import {User} from "./domain/user";

export const handler = (event: any, context: any, callback:any): void => {
    console.log(`Event: ${JSON.stringify(event, null, 2)}`);

    const user = new User('123', 'titi')
    console.log("USER",user.name)
    callback(null, {
        statusCode: 200,
        body: JSON.stringify({
            message: 'hello world',
        }),
    });
};