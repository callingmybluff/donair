import Joi from 'joi'

import Donation from '../models/donation'
import Bill from '../models/bill'
import Connect from '../util/connect'
import Logger from '../util/logger'

const customerScheme = Joi.object({
    data: Joi.object({
      id: Joi.string().required(),
    }).required(),
  }).required()

const invoiceSchema = Joi.object()
  .keys({
    data: Joi.object().keys({
      id: Joi.string().required(),
    }).required(),
  }).required()

const finalSchema = Joi.object()
  .keys({
    data: Joi.object().keys({
      hosted_invoice_url: Joi.string().required(),
    }).required()
  }).required()

interface AppSplit {
  app: string
  percentage: number
}
interface DonationData {
  amount: number
  apps: AppSplit[]
}

async function generatePayment ({amount, apps}: DonationData) {
  const donation = Donation.create({
    amount: amount,
  })
  const donationID = (await donation).id
  Bill.bulkCreate(apps.map(split => {
    return {
      donationID: donationID,
      app: split.app,
      percentage: split.percentage,
      amount: amount * split.percentage / 100,
    }
  }))

  Logger.debug(`Generating payment, step 1 of 4: Getting customer`)

  let customer
  try {
    customer = await Connect.POST(
      '/v1/customers',
      {
        name: 'Natalie'
      }
    )
    await customerScheme.validateAsync(customer, {
      allowUnknown: true,
    })
  }
  catch(e: any) {
    console.log(e.details)
    let message = e.message
    if (!message)
      message = JSON.stringify(e)

    throw new Error(`Failed to generate payment, step 1 of 4: Getting customer. Instead got >${message}<`)
  }

  const customerID = customer.data.id
  Logger.debug(`Generating payment, step 2 of 4: Adding invoice item`)
  try {
    await Connect.POST(
      '/v1/invoiceitems',
      {
        customer: customerID,
        currency: 'eur',
        amount: amount,
        description: 'Donations',
      },
    )
  }
  catch (e: any) {
    const message = e.message | e
    throw new Error(`Failed to generate payment, step 2 of 4: Getting customer. Instead got >${message}<`)
  }

  Logger.debug(`Generating payment, step 3 of 4: Generating Invoice`)
  let invoice
  try {
    invoice = await Connect.POST(
      '/v1/invoices',
      {
        customer: customerID,
      },
    )
    await invoiceSchema.validateAsync(invoice, {
      allowUnknown: true,
    })
  }
  catch (e: any) {
    const message = e.message | e
    throw new Error(`Failed to generate payment, step 3 of 4: Generating Invoice. Instead got >${message}<`)
  }

  const invoiceID = invoice.data.id
  Logger.debug(`Generating payment, step 4 of 4: Finalizing`)
  let final
  try {
    final = await Connect.POST(
      `/v1/invoices/${invoiceID}/finalize`,
      {}
    )
    await finalSchema.validateAsync(final, {
      allowUnknown: true,
    })
  }
  catch (e: any) {
    const message = e.message | e
    throw new Error(`Failed to generate payment, step 4 of 4: Finalizing. Instead got >${e.message}<`)
  }
  //const list = await Donation.findAll({
  //  include: [{
  //    model: Bill,
  //    required: true,
  //    as: 'bills',
  //  }]
  //})

  return final.data.hosted_invoice_url
}
export {
  generatePayment,
}
