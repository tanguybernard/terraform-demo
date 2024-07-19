exports.handler = (event, context, callback) => {
    console.log("EVENT FROM SQS !!!");
    console.log(event);

    callback(null, 'Hello from Lambda');
};