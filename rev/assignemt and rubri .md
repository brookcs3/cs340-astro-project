# Project Step 3 Final Version: Design UI Interface + DML SQL (Group / On Canvas) 

- **Due** Thursday by 11:59pm
-  
- **Points** 200
-  
- **Submitting** a file upload
- **File Types** zip and pdf
-  
- **Available** until Feb 23 at 11:59pm
- 

## Instructions

Here, you turn in the Final Version of the Project Step 3, as a group. It's expected that you have fixed your submission based on the peer review(s) you received for the Draft version.

In addition to all the things described in the instructions for [Project Step 3 Draft](

'/Users/cameronbrooks/cs340-astro-project/rev/Project Step 3 Draft Version Design UI Interface + DML SQL (Group  On Ed Discussion ).md'

, you are also required to add the following sections at the top of your **PDF** file:

#### Feedback by the peer reviewer

Include verbatim the review that your Draft submission received in the Group Review from peers and the TA/instructors. If you did not receive any reviews, mention that. You should include feedback that both members of the Project Group received. Remember to also include all prior feedback from other steps.

#### Actions based on the feedback

List briefly the actions that you chose to take based on the above feedback. If you decided not to act on a specific suggestion, you need to describe in detail your reasoning.

#### Upgrades to the Draft version

If you are making any changes to the files based on your own changed design decisions, they should be listed under this section.

 

## How should I get started?

Use the feedback that you received from your classmates to fix your Draft version. You can continue using Ed Discussion to seek feedback as well as bounce off ideas with your classmates. Finally, if you have any questions post on Ed Discussion or ask in the TA or Instructor's office hours.

 

## Points

This is worth 200 points of your grade. It will be graded by the graders for validity based on the rubric.

## FAQ

**Q:** Can you please elaborate on the DELETE requirement? What is meant by "You should be able to DELETE a record from a M:M relationship without creating a data anomaly in the related tables"?

![bsg_cert_people intersection table](https://canvas.oregonstate.edu/courses/2031764/files/115358767/preview)

**A:** Take the above bsg_planets partial schema as an example. There are two delete scenarios to consider: one is how to delete a row from your intersection table, bsg_cert_people. This is pretty trivial; you just DELETE the row. But the second and more challenging issue is what happens if a person is deleted from bsg_people (or from bsg_cert) BUT that person's pid (or that cid) is a FK inside of the intersection table, bsg_cert_people? How will you handle removing that FK from your intersection table so that you do not create a data anomaly? This is the delete where ON DELETE CASCADE will help you, as explained in [Exploration - MySQL Cascade](https://canvas.oregonstate.edu/courses/2031764/pages/exploration-mysql-cascade).

**Q:** Can you please help me understand this feedback criteria: "*Does each INSERT also add the corresponding FK attributes, including at least one M:M relationship?*"

**A:** Take the above bsg_planets partial schema as an example. We expect you to have a UI ability to insert new rows inside of bsg_cert_people that adds a new row by inserting the two FKs (pid & cid). 

**Q:** The rubric for the draft says 'EACH TABLE in schema has a corresponding page.' I would like some clarification on this. Does this mean separate pages need to be created for our intersection tables with M:N relationships as well?

**A:** As noted in the [CS340 Project Guide](https://canvas.oregonstate.edu/courses/2031764/pages/cs340-project-guide), you could have a separate UI page for the bsg_cert_people intersection table above to support select/add/update/delete. OR if you wanted to put those CRUD steps in the bsg_cert_people page, the bsg_cert page or a combination of the two pages, that would also be fine. 

**Q:** I'm confused about something on the rubric in regard to the dml.sql file that says "*JOINs used to make FKs user-friendly*" what does that mean?

**A:** Take the above bsg_planets partial schema as an example, where bsg_cert_people is an intersection table. You want to design a page to support browse/insert/update/delete each row in bsg_cert_people. We don't want to make the user look up the PID (or CID values). So instead, use the following query (with a JOIN) to display the fname & lname (with a space between) inside of a dropdown list to help them see the name.

```
SELECT pid, CONCAT(bsg_people.fname, " ", bsg_people.lname) AS pname 
FROM bsg_cert_people 
   INNER JOIN bsg_people ON bsg_people.id = pid;
```

**Q:** What is the difference between these as noted in the grading rubric? 

3) a URL to a home page that lists links to all your UI pages
4) URL on the top of your PDF file.

A: When you submit your assignment and upload your ZIP file, there is an option to add a comment. Please include the URL in your comment as in the image below. 
![canvas submit assignment details which shows the team zip file being uploaded and a comment with the URL  http://classwork.engr.oregonstate.edu:27271/](https://canvas.oregonstate.edu/courses/2031764/files/115358693/preview)

**Q:** My question wasn't answered here.

**A:** Please ask on Ed Discussion. 

## Rubric

Project Step 3 FINAL

| Criteria                                                     | Ratings                                                      | Pts    |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------ |
| This criterion is linked to a Learning OutcomeA ZIP archive  | 25 ptsFull MarksIncludes 1) ZIP archive containing: 2) PDF file containing information from previous steps, 3) a URL to a home page that lists links to all your UI pages. 4) URL on the top of your PDF file. 5) name your zip file like projectgroupX_stepX_FINAL.zip. e.g. ProjectGroup42_Step3_FINAL.zip20 ptsMissing ONENO MORE THAN ONE item incorrect 1) ZIP archive containing: 2) PDF file containing information from previous steps, 3) a URL to a home page that lists links to all your UI pages. 4) URL on the top of your PDF file. 5) name your zip file like projectgroupX_stepX_FINAL.zip. e.g. ProjectGroup42_Step3_FINAL.zip15 ptsMissing TWONO MORE THAN TWO item incorrect 1) ZIP archive containing: 2) PDF file containing information from previous steps, 3) a URL to a home page that lists links to all your UI pages. 4) URL on the top of your PDF file. 5) name your zip file like projectgroupX_stepX_FINAL.zip. e.g. ProjectGroup42_Step3_FINAL.zip10 ptsMissing Three or MoreMISSING THREE OR MORE 1) ZIP archive containing: 2) PDF file containing information from previous steps, 3) a URL to a home page that lists links to all your UI pages. 4) URL on the top of your PDF file. 5) name your zip file like projectgroupX_stepX_FINAL.zip. e.g. ProjectGroup42_Step3_FINAL.zip | 25 pts |
| This criterion is linked to a Learning OutcomeUpdated Project Outline, DB Overview, ERD & Schema | 25 ptsFull MarksSubstantial effort to update and revise outline, overview, ERD and schema based on the normalization process, peer review(s) received for draft versions and class concepts taught. Exceptional quality.20 ptsGood qualityNoticeable effort to update and revise outline, overview, ERD and schema based on the normalization process, peer review(s) received for draft versions and class concepts taught. Good quality, though some minor improvements recommended.15 ptsAcceptableSome effort to update and revise outline, overview, ERD and schema based on the normalization process, peer review(s) received for draft versions and class concepts taught. BUT at least one SIGNIFICANT issue still remains. Acceptable quality for this step but recommend revisions for future project steps.10 ptsNeeds improvementLargely fails to update Project Outline, DB Overview, ERD & Schema according to course concepts. Needs improvement for future project steps. | 25 pts |
| This criterion is linked to a Learning OutcomeDetails feedback and what actions the team took for each | 25 ptsFull MarksIncludes all items: 1) Verbatim review peers and the TA/instructors or mentions did not receive any reviews and 2) briefly describes the actions that you chose to take based on the above feedback. 3) If you chose not to follow feedback you need to describe in detail your reasoning.20 ptsOne InconsistencyAt most ONE inconsistency: 1) Verbatim review peers and the TA/instructors or mentions did not receive any reviews and 2) briefly describes the actions that you chose to take based on the above feedback. 3) If you chose not to follow feedback you need to describe in detail your reasoning.15 ptsTwo inconsistenciesAt most TWO inconsistencies: 1) Verbatim review peers and the TA/instructors or mentions did not receive any reviews and 2) briefly describes the actions that you chose to take based on the above feedback. 3) If you chose not to follow feedback you need to describe in detail your reasoning.10 ptsThree inconsistenciesTHREE inconsistencies: 1) Verbatim review or mentions did not receive any reviews peers and the TA/instructors and 2) briefly describes the actions that you chose to take based on the above feedback. 3) If you chose not to follow feedback you need to describe in detail your reasoning. | 25 pts |
| This criterion is linked to a Learning OutcomeUI Pages quality | 50 ptsFull Marks1) EACH TABLE in schema has a corresponding page. 2) Forms for all CRUD operations required by CS 340 Project guidelines are present 3) with a meaningful title, e.g. "Add entries to each table" could be "Add a new BSG person." Excellent quality45 ptsGood qualitySome minor inconsistencies in 1) EACH TABLE in schema has a corresponding page. 2) Forms for all CRUD operations required by CS 340 Project guidelines are present 3) with a meaningful title, e.g. "Add entries to each table" could be "Add a new BSG person." Good quality for this step but minor changes recommended.40 ptsChanges neededOne or more MAJOR inconsistencies in 1) EACH TABLE in schema has a corresponding page. 2) Forms for all CRUD operations required by CS 340 Project guidelines are present 3) with a meaningful title, e.g. "Add entries to each table" could be "Add a new BSG person." THIS SHOULD BE CORRECTED for subsequent project steps. Please see the comments and contact the grader if you are unclear.35 ptsProblematicSignificant logical gaps in 1) EACH TABLE in schema has a corresponding page. 2) Forms for all CRUD operations required by CS 340 Project guidelines are present 3) with a meaningful title, e.g. "Add entries to each table" could be "Add a new BSG person." Please see the grading comments THIS MUST BE CORRECTED for subsequent project steps. Please see the comments and update your entities for subsequent project steps. Contact the TA or instructor if you are not clear. | 50 pts |
| This criterion is linked to a Learning OutcomeSample Data    | 25 ptsFull MarksExample data from each table in schema pasted into your report: 1) 3-5 rows of sample data per table in report 2) foreign keys demonstrate 1:M relationships 3) intersection tables show M:M relationships in action 6) polite values that reasonably represent the database in action - Excellent quality20 ptsGood qualitySome minor inconsistencies in Example data from each table in schema pasted into your report: 1) 3-5 rows of sample data per table in report 2) foreign keys demonstrate 1:M relationships 3) intersection tables show M:M relationships in action 6) polite values that reasonably represent the database in action - Good quality for this step but minor changes recommended.15 ptsChanges neededOne or more MAJOR inconsistencies in Example data from each table in schema pasted into your report: 1) 3-5 rows of sample data per table in report 2) foreign keys demonstrate 1:M relationships 3) intersection tables show M:M relationships in action 6) polite values that reasonably represent the database in action - THIS SHOULD BE CORRECTED for subsequent project steps. Please see the comments and contact the grader if you are unclear.10 ptsProblematicSignificant logical gaps in example data from each table in schema pasted into your report: 1) 3-5 rows of sample data per table in report 2) foreign keys demonstrate 1:M relationships 3) intersection tables show M:M relationships in action 6) polite values that reasonably represent the database in action - Please see the grading comments THIS MUST BE CORRECTED for subsequent project steps. Contact the TA or instructor if you are not clear. | 25 pts |
| This criterion is linked to a Learning OutcomeData Definition Queries | 25 ptsFull Marks1) hand authored and well-structured DDL.SQL file 2) cleanly import-able 3) match the schema of the report 4) INSERTs example data 5) tables have PK defined and 6) FK and references appropriate fields - Excellent quality22.5 ptsGood qualitySome minor issues in DDL.SQL file 1) Well commented MySQL dump 2) cleanly import-able 3) match the schema of the report 4) INSERTs example data 5) tables have PK defined and 6) FK and references appropriate fields - Good quality for this step but minor changes recommended.17.5 ptsChanges neededOne or more MAJOR inconsistencies in DDL.SQL file 1) Well commented MySQL dump 2) cleanly import-able 3) match the schema of the report 4) INSERTs example data 5) tables have PK defined and 6) FK and references appropriate fields - THIS SHOULD BE CORRECTED for subsequent project steps. Please see the comments and contact the grader if you are unclear.10 ptsProblematicSignificant logical gaps in DDL.SQL file Well commented MySQL dump 2) cleanly import-able 3) match the schema of the report 4) INSERTs example data 5) tables have PK defined and 6) FK and references appropriate fields - Please see the comments and update your entities for subsequent project steps. Contact the TA or instructor if you are not clear. | 25 pts |
| This criterion is linked to a Learning OutcomeData Manipulation Queries | 25 ptsFull Marks1) DML.SQL file has SELECT, INSERT, UPDATE and DELETE queries to meet CS340 Project Guide, 2) JOINs used to make FKs user friendly 3) Variables for back-end code encapsulated by some special characters 4) All queries would run if replaced with actual data. - Excellent quality22.5 ptsGood QualitySome minor inconsistencies in 1) DML.SQL file has SELECT, INSERT, UPDATE and DELETE queries to meet CS340 Project Guide, 2) JOINs used to make FKs user friendly 3) Variables for back-end code encapsulated by some special characters 4) All queries would run if replaced with actual data. - Good quality for this step but minor changes recommended.17.5 ptsChanges NeededOne or more MAJOR inconsistencies in 1) DML.SQL file has SELECT, INSERT, UPDATE and DELETE queries to meet CS340 Project Guide, 2) JOINs used to make FKs user friendly 3) Variables for back-end code encapsulated by some special characters 4) All queries would run if replaced with actual data. - THIS SHOULD BE CORRECTED for subsequent project steps. Please see the comments and contact the grader if you are unclear.10 ptsProblematicSignificant logical gaps in 1) DML.SQL file has SELECT, INSERT, UPDATE and DELETE queries to meet CS340 Project Guide, 2) JOINs used to make FKs user friendly 3) Variables for back-end code encapsulated by some special characters 4) All queries would run if replaced with actual data. - Please see the comments and update your entities for subsequent project steps. Contact the TA or instructor if you are not clear. | 25 pts |

Total Points: 200