/// <reference types="Cypress" />

describe('Actions', () => {

    beforeEach(() => {
        // cy.visit('https://example.cypress.io/commands/actions')
    })

    it('Displays a title', () => {
        cy.visit('http://host.docker.internal:3000');

        cy.contains('Tacos');
    })
})