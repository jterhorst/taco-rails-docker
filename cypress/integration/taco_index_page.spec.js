/// <reference types="Cypress" />

describe('Index page', () => {

    beforeEach(() => {
        cy.visit('/');
    })

    it('Displays a title', () => {
        
        cy.contains('Tacos');
    })

    it('Displays a link for taco creation', () => {
        
        cy.contains('New Taco').click();

        cy.contains("New Taco")
    })

    
})