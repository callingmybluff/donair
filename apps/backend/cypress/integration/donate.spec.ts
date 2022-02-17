/// <reference types="cypress" />

import donation from '../fixtures/donation.json'

describe('Testing API Endpoints', () => {
  it('/api/donation', () => {
    cy.request({
      method: 'POST',
      url: `/api/donation`,
      body: donation,
      headers: {
        'Authorization': '783deb90-896c-43f8-ad12-89ee7f5d8e97',
      },
    }).should(response => {
      expect(response.status).eq(201, 'Status is 201')
      cy.visit(response.body)
    })
  })
  it('Donation Page', () => {
    cy.location().should(loc => {
      expect(loc.origin).to.eq('https://invoice.stripe.com')
    })
  })
})
