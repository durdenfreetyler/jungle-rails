/// <reference types="cypress" />

context("product details", () => {
  beforeEach(() => {
    cy.visit("http://localhost:3000");
  });

  it("should navigate to product detail page when clicking on a product", () => {
    cy.get(".products article")
      .first()
      .within(() => {
        cy.get("a ").click();
      });
    cy.url().should("include", "/products/");
  });
});
