# Code Review for Programming Exercise 1 #
## Description ##

For this assignment, you will be giving feedback on the completeness of Exercise 1.  To do so, we will be giving you a rubric to provide feedback on. For the feedback, please provide positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to review the code and project files that were given out by the instructor.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.

## Due Date and Submission Information ##
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer-review. The file name should be the same as in the template: PeerReview-Exercise1.md. You also need to include your name and email address in the Peer-reviewer Information section below. This review document should be placed into the base folder of the repo you are reviewing in the master branch. This branch should be on the origin of the repository you are reviewing.

If you are in the rare situation where there are two peer-reviewers on a single repository, append your UC Davis user name before the extension of your review file. An example: PeerReview-Exercise1-username.md. Both reviewers should submit their reviews in the master branch.  

## Solution Assessment ##

## Peer-reviewer Information

* *name:* Noah Chang
* *email:* nmchang@ucdavis.edu

### Description ###

To assess the solution, you will be choosing ONE choice from unsatisfactory, satisfactory, good, great, or perfect. Place an x character inside of the square braces next to the appropriate label.

The following are the criteria by which you should assess your peer's solution of the exercise's stages.

#### Perfect #### 
    Cannot find any flaws concerning the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    A major flaw and some minor flaws.

#### Satisfactory ####
    A couple of major flaws. Heading towards a solution, however, did not fully realize the solution.

#### Unsatisfactory ####
    Partial work, but not really converging to a solution. Pervasive major flaws. Objective largely unmet.


### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The normal push-box camera works perfectly. Nothing else to comment on!

### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The horzontal side-scrolling camera works perfectly (and at a very fast speed). There is nothing else to comment on.

### Stage 3 ###

- [] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 
The catchup camera just about works. However, the center of the camera never quite fully reaches the circle after moving it once. It is always slightly off-center.

### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 
The look-ahead prediction camera does exactly what is needs to do and fulfills the requirements. Playing it does not feel very smooth but this is due to the values of the catchup time and the delay; nothing to do with student's scripting.

### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 
The 4-way speedup zone works perfectly and runs very smoothly. There is nothing else to comment on.

## Code Style ##

### Description ###
Check the scripts to see if the student code follows the .Net style guide.

If sections don't adhere to the style guide, please permalink the line of code from GitHub and justify why the line of code has infractions of the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Here is an example of the permalink drop-down on GitHub.

![Permalink option](../images/permalink_example.png)

Here is another example as well.

* [I go to Github and look at the ICommand script in the ECS189L repo!](https://github.com/dr-jam/ECS189L/blob/1618376092e85ffd63d3af9d9dcc1f2078df2170/Projects/CommandPatternExample/Assets/Scripts/ICommand.cs#L5)

### Code Style Review ###

#### Style Guide Infractions ####

NOTE: The github repo is corrupted and the student's new scripts does not appear in github. I will not be able to place permalinks.

Overall, I believe the student did a good job adhering to the style guide with minimum infractions. These are the minor details I caught:

Inconsistent type hinting - There are missing type hints for variables in both PositionLockLerpCamera and PositionLockCamera classes. The style guide suggests type hints for improved readability and maintainability.

onready in wrong location - onready variables should be placed above global variables according to style guidelines. Consider moving the position assignment above the exported variables for consistency.

#### Style Guide Exemplars ####

Appropriate variable declarations - The student has appropriately declared global variables (e.g., follow_speed, catchup_speed, and leash_distance) at the start of each class, adhering to best practices.

## Best Practices ##

### Description ###

If the student has followed best practices (Unity coding conventions from the StyleGuides document), then feel free to point at these segments of code as examples. 

If the student has breached the best practices and has done something that should be noted, please add the infracture.

This should be similar to the Code Style justification.

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

### Best Practices Review ###

#### Best Practices Infractions ####

No violations of the unity style guide found. All of the scripts adhere to the guidelines very well. However, here are some minor nitpicks:

Duplication of draw_logic() - This function appears in both classes with only slight differences. This could be refactored into a helper function in a shared utility script or base class, reducing redundancy.

#### Best Practices Exemplars ####

Optimized Camera Position Update - All of the student's declared variables have an appropriate name that The PositionLockLerpCamera class demonstrates a good understanding of efficient interpolation by checking the target's velocity to adjust the camera's following speed accordingly. This adaptive speed handling shows attention to detail in creating a smooth user experience.

Clear variable names - The variable names such as follow_speed, catchup_speed, and leash_distance are clear and descriptive, adhering to best practices. These names provide clarity about the function of each variable in controlling camera behavior.