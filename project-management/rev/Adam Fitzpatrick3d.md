

https://edstem.org/us/courses/89768/discussion/7665462?comment=17821863



Adam Fitzpatrick[3d](https://edstem.org/us/courses/89768/discussion/7665462?comment=17821863)

***Does the UI utilize a SELECT for every table in the schema?*** **In other words, data from each table in the schema should be displayed on the UI. Note: it is generally not acceptable for just a single query to join all tables and displays them.**

The UI does does have select Statements for every table in the UI. However when I browsed the site, there were no tables displayed. I'm guessing that this is due to other users, experimenting with the functionality of the UI and not an error in design or implementation. 

***Does the UI implement an INSERT form for at least one table in the schema?*** **In other words, there should be UI input fields that correspond to at least one table.**



Every table in the UI, with the exception of the intersection table has insert functionality.  

***Does the UI have at least one DELETE for any one entity?*** **In other words, is there a form/link/button that will allow the deletion of a row in at least one table?**



Yes the players table allows for the deletion of individual players. 

***Does the UI have at least one DELETE that will remove things from a M:M relationship?*** **In other words, if an order is deleted from the Orders table, it should also delete the corresponding rows from the OrderDetails table, BUT it should not delete any Products or Customers.**

Yes, and the proper Cascades are defined in the DDL. 

***Is there at least one UPDATE form in the UI for any one entity?*** **In other words, in the case of Products, can productName, listPrice, qtyOnHand, e.g. be updated for a single ProductID record?**

All tables in the UI except for games on platforms have update abilities. 

***Is there at least one UPDATE form in the UI to modify an M:M relationship?*** **In other words, does the UPDATE allow the user to select a different foreign key value to update the intersection table with?**

Yes, all of the tables do Already contain functioning update abilities. 

***Do you have any other suggestions for the team to help with their HTML UI? For example, using AS aliases to replace obscure column names such as fname with First Name. 

***

No real suggestions everything looks to be on track, if not ahead of the game. Possibly populate a larger initial data set. But that isn't entirely necessary. 

**As a reviewer, clearly describe to what extent your feedback to the team was original (e.g. "all my work") or non-original (e.g. used AI tools per [Code Citation Tips](https://canvas.oregonstate.edu/courses/2031764/pages/code-citation-tips)).** 



All work is my own. 

Reply