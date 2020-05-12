/// <reference types="Cypress" />

describe('Actions', () => {

    beforeEach(() => {
        // cy.visit('https://example.cypress.io/commands/actions')
    })

    it('Displays a title', () => {
        cy.visit('https://taco.docker');

        cy.contains('Tacos');
    })
})