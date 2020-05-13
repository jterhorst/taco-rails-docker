/// <reference types="Cypress" />

describe('Actions', () => {

    beforeEach(() => {
        // cy.visit('https://example.cypress.io/commands/actions')
    })

    it('Displays a title', () => {
        cy.visit('http://127.0.0.1:3000');
        // on macOS hosts, use host.docker.internal

        cy.contains('Tacos');
    })
})