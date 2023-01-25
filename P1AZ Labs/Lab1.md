# Lab 1 - Policy Requirements

A Bank wants to deliver a feature that allows a Parent to share access to their account with their chid(ren) with restrictions on how large a transaction can be for the child.

## Questions for the Policy design

Fundamental Question -- Should this requested payment be allowed?

What questions need answers to decide the above?

* Is this a child?
* What are the child's limits?
* Who is the parent?
* What is the payment amount?

## What does a Policy need to use to answer the questions

### Decision Request

What will be sent to ask for a decision?

* Payment Amount
* UserID requesting Payment
* Do we need more context?
  * Can we derive more context as part of the decision?

### Attributes

* P1AZ can resolve the incoming UserID to the P1 User object
  * Is this a child?
    Attribute - `parent`
  * What are the child's limits?
    * This is more complicated -- the limits are stored on the Parent's object
    * P1AZ can make API calls to get more information for the decision
    * Make call to P1 User to grab the Parent
      * Extract the child's limit

#### Trust Framework - Attributes

This the the beginning of building a Policy. You start by defining the attributes in Trust Framework that you're going to be using.

>**Note**: You can use Attributes like Folder names, and organize the list in ways that make more sense.

## Lab Exercise

>Lab Policy starters can be found in the `/P1AZ Labs` folder in this repo

1. Import Policy - [Lab 1 - Snapshot](./SKO2023%20-%20P1AZ%20-%20Lab1.snapshot)
    >**Note:** Use the Dropdown to select **Overwrite**
2. Look at the **Trust Framework** - you can see Attributes and Services:

| Attribute | Comments |
| --- | --- |
| `Request User` | Resolved UserID - extract `parent` value |
| `Payment.Amount` | Payment is a "folder", Amount is in the Request |
| `Parent Account.Child.Limit` | Extract the `children` object |
| | Filter to the specific child |
| | Extract the `limit` |
| `Services.PingOne.Environment` | Contains things needed for the P1 User API call |
| `Services.PingOne.Token` | Contains things needed for the P1 Token |
| `Services.PingOne.User Object` | The results of the P1 User API Service call |

3. Add your Worker Details to the Attributes (`Services.PingOne.Token`) used to get a token  
    * Use the Resolver -> Constant
    * Set your P1AZ EnvID in `Services.PingOne.Environment.EnvID`
    >**Note** If your P1 Env is **not** in NA - modify the domain on `Services.PingOne.Environment.Auth Path` and `Services.PingOne.Environment.API Path`
4. Test that you can get a token  
    * On the `accessToken` attribute - click Test and then Execute  
        * You should see a JWT returned
5. Test the parent attribute resolves  
    * On the User Account -> Parent  
    * Click Test  
    * Enter a `childId` for the PingOne UserID  
    * Click Execute  
        * You should see a value returned
6. Add Condition to determine if the Request is from a Parent  
    * Click on Conditions  
    * Add "Is a child?"  
    * `Request User.Parent ID` *contains* `-` (part of the UUID)  
    * Test with Child ID  
        * Should return parentID
    * Test with Parent ID  
        * Should fail -- why?
            * (Add `parent` as a Default Value - don't forget to check the box)
7. Fix the ParentID attribute  
    * Open `Request User.Parent ID`  
    * Set Default value to `parent`  
    * Switch Condition to *does not equal* "parent" (no quotes)  
    * Test the condition with Child and Parent IDs
8. Examine the Parent Account attribute  
    * This is the results of the P1 User API lookup  
    * Test  
9. Examine `Parent Account.Child`  
    * Look at the sequence of Value processors  
    * "Filter children to current requestor" shows how to do deep filters using JSONPath
10. `Parent Account.Child.Limit` should resolve to a number  
    * Test using a ChildID as the PingOne UserID

>**Note** The P1 User Service call that is made to get the Child's Limits doesn't need to be a Service.
You can use the PingOne UserID resolver mapped to the `Parent ID` value on the incoming Request User
