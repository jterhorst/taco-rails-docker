/// <reference types="Cypress" />

describe('Add taco page', () => {

    beforeEach(() => {
        cy.visit('/tacos/new');
    })

    it('Displays a title', () => {
        
        cy.contains('New Taco');
    })

    it('Fills out the form', () => {
        
        cy.get('#taco_name').type('Test Taco')
        cy.get('#taco_price').type('9.00')
        cy.get('#taco_description').type('Test Taco')
        cy.get('#taco_meat').type('Test Taco')
        cy.contains('Create Taco').click()
        
        cy.contains("Taco was successfully created")
        cy.contains("Test Taco")
    })

    it('Displays a link to go back', () => {
        
        cy.contains('Back').click();

        cy.contains("Tacos")
    })

    
})