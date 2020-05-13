/// <reference types="Cypress" />

describe('Actions', () => {

    beforeEach(() => {
        // cy.visit('https://example.cypress.io/commands/actions')
    })

    it('Displays a title', () => {
        cy.visit('/');
        // on macOS hosts, use host.docker.internal

        cy.contains('Tacos');
    })
})