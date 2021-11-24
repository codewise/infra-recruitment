# Infrastructure team recruitment


Tasks:
1. Adapt iam.py module to:
   1. Fix error
   2. List users with access keys older than 2 days
   3. Output (Print) list of users with old keys
2. Modify terraform code to:
   1. Make instance type and ami id into variables
   2. Output LB arn
   3. Transform this into a module
   4. Create a new main.tf file that implements that module and provides values for
                  instance type and ami id
   5. Output the modules output
