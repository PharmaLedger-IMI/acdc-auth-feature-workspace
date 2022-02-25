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

the possible arguments are:
 - --port : the port where to run the ApiHub (defaults to 8080);
 - --domainName: the name for the domain (defaults to 'template');
 - --epi: the url to the epi (acdc for the time being) apihub: ```acdc-dev.pharmaledger.pdmfc.com:80``` or ```acdc.pharmaledger.pdmfc.com:80``` for the dev and tst environments. local address for tests. (no outgoing communication is required so far for this repo, so this parameter is mute);
 - --env: (not supported currently);

Each user should tailor this to fit his needs.

### To Test Locally:
To properly test the deployment locally, the best way is to deploy this workspace to a docker file ```./docker/build.sh``` and
then run it ```./docker/run.sh```.
this latest script will map the 8080 port of the container to 8081 so it can run simultaneous to acdc.

then, in acdc, when all the workspace is set up stop the server and run ```npm run onboard-domain -- --domainName=$DOMAIN_NAME --anchoring=http://localhost:8081 --bricking=http://localhost:8081 --notifications=http://localhost:8081```

restart the server ```npm run server```

and now the KeySSI generated in this workspace can be used in the acdc workspace (easy test via Dossier Explorer or by using it in the EPI app)

### To Publish

#### Option 1 - Deploy to epi servers

 - make sure the domain you are building to when you run build-all (or npm run build in the auth feature folder) is ```epi```
 - configure bdns to point to the epi ApiHub:
```json
  "epi": {
    "replicas": [],
    "brickStorages": [
      "https://epi...:xxxx"
    ],
    "anchoringServices": [
      "https://epi...:xxxx"
    ],
    "notifications": [
      "https://epi...:xxxx"
    ]
  },
```
 - run your build command

#### Option 2 - Deploy to your own domain (and ApiHub instance)

 - decide the name for your domain, eg ```auth-feature-xxx```
 - make sure the domain you are building matches the selected name
 - have a bdns configuration for that domain and epi like so:
```json
  "epi": {
    "replicas": [],
    "brickStorages": [
      "https://epi...:xxxx"
    ],
    "anchoringServices": [
      "https://epi...:xxxx"
    ],
    "notifications": [
      "https://epi...:xxxx"
    ]
  },
    "${auth-feature-xxx}": {
    "replicas": [],
    "brickStorages": [
      "$ORIGIN"
    ],
    "anchoringServices": [
      "$ORIGIN"
    ],
    "notifications": [
      "$ORIGIN"
    ]
  },
```
 - have a domain configuration file ```./aphub-root/external-volume/config/domains/${auth-feature-xxx}.json``` with:
 ```json
 {
  "anchoring": {
    "type": "FS",
    "option": {
      "enableBricksLedger": false
    },
    "commands": {
      "addAnchor": "anchor"
    }
  },
  "skipOAuth": [
    "/bricking/${auth-feature-xxx}/get-brick"
  ]
}
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

