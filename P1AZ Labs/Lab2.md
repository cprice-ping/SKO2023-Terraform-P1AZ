# Lab 2 - Policy Writing

Now that we've done the hard part, we can write some policies and rules.

There are 2 Policies we need - the rules are different and they apply in different contexts.

* Parent
* Child

Each of these will have different rules that are used to make the Policy decision.

### Lab Exercise

1. Import Policy (Overwrite) - [Lab 2 - Snapshot](./SKO2023-Lab2.snapshot)
    * Reset your Env-specific attributes
        * `Services.PingOne.Environment`
            * Auth & API Paths (Lab defaults to `.com`)
            * `EnvID`
        * `Services.PingOne.Token`
            * Worker ID & Secret
2. Examine the `Parent Rules` policy and it's rules

>**Applies When** tells P1AZ when to execute this Policy.

In this case, it's the Condition we created earlier -- *Is a child?* == `false`

Rules used if this is a Parent:

| Rule | Description |
| --- | --- |
| PERMIT Always | Regardless of the Payment Account, always allow |
| Step-Up if > 500 | If the Amount is > 500, request a step-up |

3. Look at the Rules  
    * PERMIT Always contains only the Effect
    * STEP-UP shows a comparison
    * STEP-UP also has an Advice statement - this is returned with the PERMIT decision
4. Test the policy with a ParentID  
    * Set the `Payment Amount` attribute to a number
5. Switch the order of the Rules and Test
6. Write the `Child Rules` policy  
    * Don't forget the **Applies When**  
    * Use the Effect option - Permit if condition holds, else deny  
    >This will force a PERMIT or DENY on the Rule decision  
7. Use the Attribues we created to add a Rule  
    * Check the Payment Amount is less than the `Parent Account.Child.Limit`
8. Test Policy
