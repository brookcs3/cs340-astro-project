https://edstem.org/us/courses/89768/discussion/7665462?comment=17799317





Kira Stephenson[6d](https://edstem.org/us/courses/89768/discussion/7665462?comment=17799317)

***Does the UI utilize a SELECT for every table in the schema?*** **In other words, data from each table in the schema should be displayed on the UI. Note: it is generally not acceptable for just a single query to join all tables and displays them.** 

*Yup, the information is clearly presented in the DML file as well (love the comments by the way).*

***Does the UI implement an INSERT form for at least one table in the schema?*** **In other words, there should be UI input fields that correspond to at least one table.**

*There are insert forms for every entity – Players, Games, Platforms, Run Categories, Run Submissions, and Games on Platforms. Nearly every input field on every single page even has mention of unique input scenarios and whether or not a certain field is optional.*

***Does the UI have at least one DELETE for any one entity?*** **In other words, is there a form/link/button that will allow the deletion of a row in at least one table?**

*DELETE is managed by a button that is attached onto anything which has an ID.*

***Does the UI have at least one DELETE that will remove things from a M:M relationship?*** **In other words, if an order is deleted from the Orders table, it should also delete the corresponding rows from the OrderDetails table, BUT it should not delete any Products or Customers.**

*Yes. Cascade and constraint operations also appear flawless from what I can tell. Honestly, after reviewing this code I feel ill-equipped with SQL and might need to do some more review; even the JOIN statements are easy to understand.*

***Is there at least one UPDATE form in the UI for any one entity?*** **In other words, in the case of Products, can productName, listPrice, qtyOnHand, e.g. be updated for a single ProductID record?**

*Yes. I would maybe consider getting rid of the ability to update rulesets on the Run Categories entity, I only say this because it could allow for people to manipulate the rules for a type of run later on. I think if someone wants to update a ruleset then they should simply make a new run category with a new ruleset rather than being allowed to update previous rules. I know that the down side would be that you can’t fix typos or maybe make rules clearer in the future, but that also encourages people to heavily review their rules they initially input rather then just saying \*“oh it’s fine, I don’t need to worry about having good rules since I can just update them later”\*.*

***Is there at least one UPDATE form in the UI to modify an M:M relationship?*** **In other words, does the UPDATE allow the user to select a different foreign key value to update the intersection table with?**

*All of your buttons are already functional. WHAT THE HECK?! And yes, the M:M relationships are properly handled because of course they are – this site is beautiful.*

***Do you have any other suggestions for the team to help with their HTML UI? For example, using AS aliases to replace obscure column names such as fname with First Name.***

*Besides the ruleset update allowance I mentioned earlier, I’d say that you might want to include a name of the person who verified a run submission. A run being verified is important, the person who verified the run is even more crucial information to know. At least, that’s my opinion.*

**All of my work is original.**

Reply