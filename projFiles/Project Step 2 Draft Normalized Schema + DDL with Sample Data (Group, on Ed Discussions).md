# Project Step 2 Draft: Normalized Schema + DDL with Sample Data (Group, on Ed Discussions) 

- **Due** Thursday by 11:59pm
-  
- **Points** 100
-  
- **Submitting** a website url
- **Available** until Feb 6 at 11:59pm
- 

![img](https://canvas.oregonstate.edu/courses/2031764/files/115358712/download?wrap=1)

## Aim

This is the design for your database using the design tools and strategies you learned so far. You will apply the normalization process to your design, render a schema, and develop the SQL to define the tables plus insert sample data.

## Details

A **ZIP** archive containing 2 THINGS as described below in detail.

The zip file should be named like** projectgroupX_stepX_DRAFT/FINAL.zip. e.g.**ProjectGroup42_Step2_DRAFT.zip

1. **A PDF file containing** all the items from Step 1, plus a schema diagram which should follow the (updated) database outline and ER diagram, and the example data used in your database. 
2. The **.SQL file containing your Data Definition Queries** (e.g. DDL.sql) and the **sample data INSERT statements**

Your .ZIP file as should be posted to the Ed Discussion (please follow the instructions under "How do I turn in this assignment" below)

*Both members' names and Group number should be included in the files as well as a comment on the post.* 

*It's expected that you apply all the concepts you have learned until now, when working on this Step.*

### PDF File should contain

#### a) Fixes based on Feedback from Step 1:

This section in your PDF should detail what all things you were told to fix in any feedback by your peers and the TA/instructors on Step 1 and how you fixed them. If you chose not to fix things based on the feedback, this would contain why you think the design should stay the same. Apart from this, if you are making any changes based on your changed design decisions, they should also be listed here.

If you haven't received any feedback, mention you have not yet received any feedback and you may exclude this section.

#### b) Project Overview and Database Outline - Updated Version:

This section should contain the updated version of your submission for Project Step 1 based on the feedback as well as any design decisions that you decided to make on your own. For example, in applying the normalization process to your design you may identify that your schema is not in 2NF or 3NF and need to make changes. These changes need to be reflected in the updated outline and ERD.

If you haven't received any feedback yet, mention you have not yet received any feedback and you may exclude this section.

#### c) Entity-Relationship Diagram:

This should be an updated ER diagram that matches your database outline. Anything that does not match the Database outline or uses incorrect notation will cause a reduction in your points in the later Project Step 3 and Step 6 Final Version of this assignment.

Note that you don't need to include all attributes in the ERD--just the primary key is good enough. But you need to include them all in the schema.

#### d) Schema Diagram:

Apply the normalization process to your design as described in [Exploration - Normalization Steps](https://canvas.oregonstate.edu/courses/2031764/pages/exploration-normalization-steps). Start by creating a sample report (e.g. in Excel) with some data and then look for redundancies and anomalies. Once your design meets 1NF and 2NF, look for any remaining transitive dependency ,and decide whether you will go to 3NF (not all transitive dependencies need to be removed, only those which will clearly create data integrity problems). Once your schema is satisfactorily normalized, be sure to update the overview, outline, and the ER diagram to match exactly. You will be graded in the Final Version for later Steps on the extent with which the schema matches the rest of your report with an emphasis on whether the relationships, tables, and keys are set up correctly. You may use an automated schema generator such as the diagram visualizer in PhPMyAdmin, MySQL Workbench, or draw by hand and upload a scanned legible copy. Please stick to the notation covered in class. Diagrams should be easy to read (not excessively small and not too much wasted space), and care taken to try to avoid line-crossings of diagram.

#### e) Example Data:

All the **example data** from each table in your schema should be pasted into your report. Clearly indicate from which table the data is being displayed. 

Approximately 3-5 rows of data per table are enough data to demonstrate how the table works, e.g. foreign keys demonstrate 1:M relationships and intersection tables show M:M relationships in action. You are free to make up the data, but it should be polite values that reasonably represent the database in action. You can also get data from other sources such as a sample report on a website, or other sources but please anonymize so personal identifiers are not disclosed.

### **Data Definition Queries** should contain

a) a DDL.SQL file that should be cleanly import-able on the database server that is used to host your CS340 database. If the .SQL file cannot be imported or does not create tables as your Schema describes, using PHPMyAdmin or the MySQL command line client, you will lose valuable feedback from your reviewers and on later assignments (e.g. Project Step 3 Final and Project Step 6 Final) lose points.

- Well-structured, commented, and hand-authored SQL files are preferred. MySQL dump exports are also acceptable with team authored comments at the top of the file. An example of this file is [bsg_db.sql](https://canvas.oregonstate.edu/courses/2031764/files/115358900?wrap=1)[Download bsg_db.sql](https://canvas.oregonstate.edu/courses/2031764/files/115358900/download?download_frd=1)generated using the mysqldump tool as described in [Activity 5 - Backing up and Restoring your Database](https://canvas.oregonstate.edu/courses/2031764/pages/activity-5-backing-up-and-restoring-your-database)

- The SQL should exactly match the schema of the report

- All the example data shown in your report needs to be included the .SQL file using INSERT statements

- Tables should have a primary key and foreign keys defined and reference the appropriate fields

- It is recommended to use CASCADE methods as described in [Exploration - MySQL Cascade](https://canvas.oregonstate.edu/courses/2031764/pages/exploration-mysql-cascade) to handle any instance of the PK value changed as a foreign key in another table

- It is recommended to disable commits and foreign key checks at the beginning of your file and then turn them back on at the end to minimize import errors, as described in the [MySQL documentationLinks to an external site.](https://dev.mysql.com/doc/refman/8.0/en/optimizing-innodb-bulk-data-loading.html).

  - For example:

    ```
    SET FOREIGN_KEY_CHECKS=0;
    SET AUTOCOMMIT = 0;
    
    ... [your SQL goes here]
    SET FOREIGN_KEY_CHECKS=1;
    COMMIT;
    ```

- It is recommended that you use `DROP TABLE IF EXISTS` prior to any create table statements or else use the `CREATE OR REPLACE TABLE` statement as described in [Activity 4](https://canvas.oregonstate.edu/courses/2031764/pages/activity-4-creating-a-customer-object-table) to minimize import errors.

 

## How do I turn in this assignment?** **

To turn in your Project Step Draft and review others' work, follow the steps below:

1. Go to Ed Discussion and create a post called "Group XX Project Step 2 Draft". categorize your posting as *Project Step 2 Drafts & Reviews*. Communicate with your team so that you know who is posting the draft. Be sure that include *Both members' names and your Group number.*
2. Next, copy the URL of your Ed post and post it here on Canvas. Only one teammate needs to submit for the group. Failing to post the URL in Canvas will result in a deduction.
3. Each team member should then [review two other drafts](https://canvas.oregonstate.edu/courses/2031764/assignments/10323335) - reviews are an important part of the process, as you are helping others while also learning. Strive to make thoughtful and substantial suggestions.

 

## Frequently Asked Questions

**Q.** ***This is a lot of work, how will I be able to design the entire database and sample data in such short time?
***

**A.** Well, actually you don't need to implement the entire thing. You just need to get started. Since this is a Project Step Draft and Review, you get points for simply turning in things as they are. If you get stuck and can't implement it all, you can still turn in something for the Review and get points for submission and discussion.

**Q.** ***How should I create my Schema diagram?*** 

**A.** Refer to the video on [Activity 1 - Access and Use the CS340 Database](https://canvas.oregonstate.edu/courses/2031764/assignments/10323318) for how to use PhPMyAdmin. You can also use MySQL Workbench as described in [Exploration - Creating ER Diagram MySQL Workbench](https://canvas.oregonstate.edu/courses/2031764/pages/exploration-creating-er-diagram-mysql-workbench). There are other diagraming tools available (e.g. Visio) and a picture of a neat hand drawn diagram is also acceptable.

***Q. How do I create my DDL script?*** 

**A.** You can use MySQL Workbench to forward engineer a schema and then import it into the CS340 Class Database hosted on the ENGR server as described in [Exploration - Creating ER Diagram MySQL Workbench](https://canvas.oregonstate.edu/courses/2031764/pages/exploration-creating-er-diagram-mysql-workbench), and then use the Export from PhPMyadmin. You can also create the SQL by hand as in activities [1](https://canvas.oregonstate.edu/courses/2031764/pages/activity-4-creating-a-customer-object-table), [3](https://canvas.oregonstate.edu/courses/2031764/pages/activity-6-creating-transaction-and-category-tables), and [4](https://canvas.oregonstate.edu/courses/2031764/pages/activity-7-creating-database-intersection-tables) as examples of how to write the DDL for your schema and insert sample data.

***Q. Can I use sample data from another source (e.g. from XYZ website)?*** 

A. Yes, as long as you a) honor academic integrity by citing your source and b) keep in mind this is supposed to be sample data (only 3-5 rows required) so you shouldn't need more than 10 rows max. And keep in mind that you will have to paste all the data into your PDF so we really prefer if a single table does not span more than one page of your PDF document. 

Also keep in mind that even though you can save time by importing the master tables data, you will still need to manually create the rows of data for other tables. For instance, let's say a database that recorded product locations in a grocery store had the following entities:

- PRODUCTS (**PROD_NUM**, DESCRIPTION, QTY, UNIT_OF_MEASURE, PRICE) 
- AISLES (**AISLE_NUM**, DESCRIPTION) 
- PRODUCT_AISLES (**PROD_NUM, AISLE_NUM**) 

You could easily find rows of sample data from a grocery store to insert into the PRODUCTS tables. BUT you should still expect to create the sample data for the AISLES and PRODUCT_AISLES tables manually because it is very unlikely you will find sample data that exactly matches your schema design. 

**Q.** After I imported the DDL.sql, phpMyAdmin wouldn't show me any of the inserted data, even though I could query the data from the command line. PhpMyAdmin would also freeze if I tried to modify anything. What's going on?

**A.** The issue was that we had SET AUTOCOMMIT = 0; at the beginning of our DDL based  never otherwise started or committed a transaction.  The fix was to add START TRANSACTION; at the start and COMMIT; at the end. 

**Q. What does it mean for the data to demonstrate relationships in action?** 

**A.** if a table has a 0:M relationship (e.g. each invoice can have zero or more employees associated with it), then the data should have 1) an example of one invoice with NULL value for employee, 2) and an example of a different employee associated with more than one invoice. That would be a minimum of three rows of data. Similarly for an intersection table M:N you would need to show examples of 1:M and M:1 to demonstrate the many-to-many in action.

**Q. \*What if I decided to switch Project Groups? 
\***

**A.** No two submitted projects should be the same. They need to have some major difference in at least one entity and at least one relationship. I leave the logistics and repercussions of leaving/joining/forming a group to you but you would contact a TA or the Instructor to make the change effective on Canvas.

**Q. \*What if I have changed my Project idea entirely?\***

**A.** If you have changed your project idea entirely from, say, a project on *Battle Star Galactica* to *Pokemon*, you need to provide your new Project Outline Database Outline. In the second section listing Fixes, provide the reason why you chose this idea over the old one.

## Points

This is worth 100 points of your Project grade.

- [Website URL](https://canvas.oregonstate.edu/courses/2031764/assignments/10323334#submit_online_url_form)

| Keep in mind, this submission will count for everyone in your Project Groups group. |
| ------------------------------------------------------------ |
| **Website URL\***                                            |
|                                                              |
| All comments are sent to the whole group.                    |
|                                                              |

## Rubric

Project Step 2 (Draft)

| Criteria                                                     | Ratings                                                      | Pts    |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------ |
| This criterion is linked to a Learning OutcomeProject Draft  | 70 ptsFull MarksIncludes ALL required elements 1) zip file correctly named, PDF with 2) schema, 3) example data, and 4) .SQL file with DDL and 5) sample data50 ptsMissing ONEMissing no more than ONE required element 1) zip file correctly named, PDF with 2) schema, 3) example data, and 4) .SQL file with DDL and 5) sample data35 ptsMissing TWOMissing no more than TWO required element 1) zip file correctly named, PDF with 2) schema, 3) example data, and 4) .SQL file with DDL and 5) sample data25 ptsMissing THREEMissing THREE or more required elements 1) zip file correctly named, PDF with 2) schema, 3) example data, and 4) .SQL file with DDL and 5) sample data | 70 pts |
| This criterion is linked to a Learning OutcomePosts to discussion | 20 ptsFull MarksPosts draft as a Group XX Project Step 2 Draft" &. categorizes as Project Step 2 Drafts & Reviews. Includes both members' names and group number.14 ptsOne InconsistencyAt most ONE inconsistency: posts draft as a Group XX Project Step 2 Draft" &. categorizes as Project Step 2 Drafts & Reviews. Includes both members' names and group number.10 ptsTWO InconsistenciesAt most TWO inconsistencies: posts draft as a Group XX Project Step 2 Draft" &. categorizes as Project Step 2 Drafts & Reviews. Includes both members' names and group number.6 ptsThree or more InconsistenciesTHREE or MORE inconsistencies: posts draft as a Group XX Project Step 2 Draft" &. categorizes as Project Step 2 Drafts & Reviews. Includes both members' names and group number. | 20 pts |
| This criterion is linked to a Learning OutcomePosts URL to Canvas | 10 ptsFull MarksCompletes discussion posting by due date and Includes URL in Canvas submission.6 ptsURL LATE < 24 hrsCompletes discussion posting by due date BUT ADDS canvas posting of URL LATE < 24 hrs4 ptsCanvas CMT w/ URL before gradedCompletes discussion posting by due date BUT does not post to canvas. Adds canvas COMMENT with URL before it has been graded.0 ptsNo MarksCompletes discussion posting by due date BUT does not post to canvas. Emails instructor/TA and adds canvas COMMENT with URL AFTER it has been graded. | 10 pts |

Total Points: 100