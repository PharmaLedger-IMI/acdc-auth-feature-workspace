# ACDC Authentication Feature Workspace

ACDC means Anti-Counterfeiting Data Collaboration - Use-Case 4 of PharmaLedger

Aims to set up a separate environment, connected to Acdc for Authentication providers to develop and deploy their own authentication features in their own domain

## Installation

In order to use the workspace, we need to follow a list of steps presented below. 

### Step 1: Clone the workspace

```sh
$ git clone https://github.com/PharmaLedger-IMI/acdc-auth-feature-workspace.git
```

After the repository was cloned, you must install all the dependencies.

```sh
$ cd acdc-auth-feature-workspace
#Important: If you plan to contribute to the project and/or dependecies please set DEV:true
#in the file env.json before you run the installation!
$ npm install
```
**Note:** this command might take quite some time depending on your internet connection and you machine processing power.

### Step 2: Launch the "server"

While in the *acdc-auth-feature-workspace* folder run:
(optional)
```shell
    npm run integrate-acdc
```

this will run the following octopus script:
```json
    "configure-acdc-integration": [
        {
            "name": "configure server integration",
            "src": "",
            "actions": [
                {
                    "type": "execute",
                    "cmd": "npm run set-up-acdc-integration -- --port=8080 --domainName=epi-auth-template --epi=http://192.168.1.89:8080 --env=dev"
                },
                {
                    "type": "execute",
                    "cmd": "npm run patch-server"
                },
                {
                    "type": "execute",
                    "cmd": "npx rimraf ./apihub-root/external-volume/config/domains/epi.json"
                }
            ]
        }
    ],
```

notice the use of ```npm run set-up-acdc-integration``` with arguments to configure the domain

```sh
$ npm run server
```

At the end of this command you get something similar to:

![alt text](scr-npm-run-server.png)


### Step 3: Build all things needed for the application to run.

Open a new console inside *acdc-auth-feature-workspace* folder and run:

```sh
# Note: Run this in a new console inside "epi-workspace" folder
$ npm run build-all
```



# Contributions

If you think you can contribute, please check with the team, if it is ok to submit a pull-request.

## Follow the "10 commandments" at https://jaxenter.com/10-commandments-committing-pull-requests-115707.html

1. Thou Shalt not reformat
2. Thou shalt absolutely not fix whitespace
3. Thou Shalt not refactor
5. Thou Shalt not rename
6. Thou shalt document
7. Thou shalt not implement more than one thing in a single commit
8. Thou shalt ask the vendor / community first
9. Thou shalt not demand
10. Thou shalt accept the license terms

