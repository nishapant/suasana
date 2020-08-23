const dialogflow = require('@google-cloud/dialogflow');
const uuid = require('uuid');
const projectId = 'suasana-mtecrd'

const keyFilename = 'FILE_PATH_HERE'
const express = require("express");
const app = express();
app.use(express.static("."));
app.use(express.json());

app.post("/dialogflow", async (req, res) => {
    const {text} = req.body;
    const sessionId = uuid.v4();

    // Create a new session
    const sessionClient = new dialogflow.SessionsClient({keyFilename: keyFilename});
    const sessionPath = sessionClient.projectAgentSessionPath(projectId, sessionId);

    // The text query request.
    const request = {
    session: sessionPath,
    queryInput: {
        text: {
        // The query to send to the dialogflow agent
        text: text,
        // The language used by the client (en-US)
        languageCode: 'en-US',
        },
    },
    };

    // Send request and log result
    const responses = await sessionClient.detectIntent(request);
    console.log('Detected intent');
    const result = responses[0].queryResult;
    console.log(`  Query: ${result.queryText}`);
    console.log(`  Response: ${result.fulfillmentText}`);
    if (result.intent) {
    console.log(`  Intent: ${result.intent.displayName}`);
    } else {
    console.log(`  No intent matched.`);
    }
    res.send({
        response: result.fulfillmentText
    });
});

app.listen(4242, () => console.log('Node server listening on port 4242!'));