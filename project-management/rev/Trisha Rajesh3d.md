

https://edstem.org/us/courses/89768/discussion/7665462?comment=17824770

Trisha Rajesh[3d](https://edstem.org/us/courses/89768/discussion/7665462?comment=17824770)

- *Does the UI utilize a SELECT for every table in the schema?* In other words, data from each table in the schema should be displayed on the UI. Note: it is generally not acceptable for just a single query to join all tables and displays them.

  Yes there are SELECT queries for every table and and each entity has both a general SELECT all and a specific SELECT by ID query.

- *Does the UI implement an INSERT form for at least one table in the schema?* In other words, there should be UI input fields that correspond to at least one table.

  Yes every table in the schema has an INSERT query but I would make sure that for foreign keys, that the dropdowns display meaningful names instead of numeric IDs.

- *Does the UI have at least one DELETE for any one entity?* In other words, is there a form/link/button that will allow the deletion of a row in at least one table?

  Yes, each main entity able has a DELETE statement.

- *Does the UI have at least one DELETE that will remove things from a M:M relationship?* In other words, if an order is deleted from the Orders table, it should also delete the corresponding rows from the OrderDetails table, BUT it should not delete any Products or Customers.

  Yes the GamesOnPlatforms intersection table handles the many to many relationship between Games and Platforms.

- *Is there at least one UPDATE form in the UI for any one entity?* In other words, in the case of Products, can productName, listPrice, qtyOnHand, e.g. be updated for a single ProductID record?

  Yes, update statements exist for all the main entities.

- *Is there at least one UPDATE form in the UI to modify an M:M relationship?* In other words, does the UPDATE allow the user to select a different foreign key value to update the intersection table with?

  Yes, the table can be updated by deleting the existing relationship and inserting a new one.

- *Do you have any other suggestions for the team to help with their HTML UI? For example, using AS aliases to replace obscure column names such as fname with First Name.* 

  Dropdown menus for foreign keys should show meaningful values instead of numeric IDs.

  

  This is all my own work

Reply