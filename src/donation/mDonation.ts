import Logger from '../util/logger'
import Connect from '../util/connect'

export default {
  generatePayment: async (amount: number) => {
    const customer = await Connect.POST(
      '/v1/customers',
      {
        name: 'Natalie'
      }
    )
    const customerID = customer.data.id
    await Connect.POST(
      '/v1/invoiceitems',
      {
        customer: customerID,
        currency: 'eur',
        amount: amount,
        description: 'Donations',
      },
    )
    const invoice = await Connect.POST(
      '/v1/invoices',
      {
        customer: customerID,
      },
    )
    const final = await Connect.POST(
      `/v1/invoices/${invoice.data.id}/finalize`,
      {}
    )
    Logger.info(final.data)
    Logger.info(final.data.id)
    Logger.info(final.data.hosted_invoice_url)
  }
}
