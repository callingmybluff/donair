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

async function generatePayment (amount: number) {
  const donation = Donation.create({
    amount: amount,
  })
  Bill.bulkCreate([
    {
      donationID: (await donation).id,
      app: 'bla.blo.ble',
      percentage: 11.45,
      amount: amount * 11.45 / 100,
    },
    {
      donationID: (await donation).id,
      app: 'bla2.blo2.ble2',
      percentage: 70,
      amount: amount * 70 / 100,
    },
    {
      donationID: (await donation).id,
      app: 'bla3.blo3.ble3',
      percentage: 18.55,
      amount: amount * 11.45 / 100,
    },
  ])
  
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
