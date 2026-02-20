

https://edstem.org/us/courses/89768/discussion/7665462?comment=17825970

Alexa Jauregui[3d](https://edstem.org/us/courses/89768/discussion/7665462?comment=17825970)

Hello group 101, your project looks amazing!

- ***Does the UI utilize a SELECT for every table in the schema?\* In other words, data from each table in the schema should be displayed on the UI. Note: it is generally not acceptable for just a single query to join all tables and displays them.**

Yes, there is a SELECT for each table. Some of the entities don’t show any data on the website, but I assume that is because of people experimenting with DELETE.

- ***Does the UI implement an INSERT form for at least one table in the schema?\* In other words, there should be UI input fields that correspond to at least one table.**

Yes, the UI has an INSERT form section for each entity. 

- ***Does the UI have at least one DELETE for any one entity?\* In other words, is there a form/link/button that will allow the deletion of a row in at least one table?**

Yes, there is a DELETE for each entity table. There is a Delete button to the side of each row in a table, which makes it easier for users to delete an item without having to remember which ID they want to delete. 

- ***Does the UI have at least one DELETE that will remove things from a M:M relationship?\* In other words, if an order is deleted from the Orders table, it should also delete the corresponding rows from the OrderDetails table, BUT it should not delete any Products or Customers.**

The UI has a DELETE that removes items from M:M relationships. For example, deleting a game will also delete the corresponding rows for games of platform, run submissions, and run categories; this showcases well-implemented Cascade constraints.

- ***Is there at least one UPDATE form in the UI for any one entity?\* In other words, in the case of Products, can productName, listPrice, qtyOnHand, e.g. be updated for a single ProductID record?**

There are UPDATE forms for each entity. When clicking on the update button on the side of the rows, the UPDATE form is populated with the corresponding data. 

- ***Is there at least one UPDATE form in the UI to modify an M:M relationship?\* In other words, does the UPDATE allow the user to select a different foreign key value to update the intersection table with?**

There is an UPDATE form in the UI to modify M:M relationships. For example, I can choose a different foreign key (like the Run Category) when updating the Run Submissions table. Also, if I update the Run Category, the corresponding tables automatically update the data. Not sure if it’s intentional, but the intersection table games on platforms does not offer any update options.

- ***Do you have any other suggestions for the team to help with their HTML UI? For example, using AS aliases to replace obscure column names such as fname with First Name.\*** 

Honestly, what you have now looks amazing. I don’t have any serious suggestions to make. One improvement could be to add border lines to your tables to make the data more visually appealing, but it’s really not necessary.

- **As a reviewer, clearly describe to what extent your feedback to the team was original (e.g. "all my work") or non-original (e.g. used AI tools per [Code Citation Tips](https://canvas.oregonstate.edu/courses/2031764/pages/code-citation-tips)).**

This is all my original work.