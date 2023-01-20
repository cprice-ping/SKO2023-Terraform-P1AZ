# Lab 3 - AZ, DV, Risk - Oh my

Now we have Attributes and Policies working in P1AZ - we need to integrate the decision with where the request and response can be managed and enforced.

## DaVinci

DV has the P1AZ Connector that can send in decision requests, with data from prior events in the Flow, and recieve the response. Functions can be used to check for PERMIT \ DENY and perform approriate actions.

The Connector can also extract any Statements that have been added by an Advice instruction.

![Image of DaVinci Flow](/davinci/DaVinciFlow.png)

## Risk

As Risk moves to include session fraud predictors, it becomes more important to include the Risk decision at the point of **authorization** not just at *authentication*. P1AZ has a special type of Service - a Connector - that will make the Risk call for you.

Currently, the Connector doesn't use the Signals SDK - so it can't leverage the dependent Predictors like `New Device`.

### Lab Exercise

#### P1AZ

1. Import Policy - [Lab 3](./SKO2023%20-%20P1AZ%20-%20Lab3.snapshot)
2. Reset your Env-specific attributes
    * `Services.PingOne.Environment`
        * Auth & API Paths (Lab defaults to `.com`)
    * `Services.PingOne.Token`
        * Worker ID & Secret
3. Set the incoming Attributes to resolve from the Request
    * `Payment.Amount`
    * `Services.PingOne Risk.ipAddress`
    * `Services.PingOne Risk.UserAgent`
4. Look at the `Services.PingOne Risk` attribute -- look at the JSON Schema
    >This exposes the schema to the Policy Editor - you can select any attribute returned in the Schema and P1AZ will create the proper Resolver

#### DaVinci

1. Import [DV Flow](../davinci/SKO2023_-%20P1AZ%20Payment%20Authorization_Export_2023-01-13T14_11_27.490Z.json) to your DV instance
2. Configure the P1AZ Connector
    * EnvID \ Worker \ Secret
    * Decision Endpoint - TEST URL
3. Try the Flow
