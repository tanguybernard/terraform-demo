const jwtDecode = require("jwt-decode");
const movies = [
    "Schindlers List",
    "Shawshank Redemption",
    "Batman The Dark Knight",
    "Spider-Man : No Way Home",
    "Avengers",
];
exports.handler = async (event) => {
    const decodedToken = jwtDecode.jwtDecode(event.headers.Authorization);

    return {
        statusCode: 200,
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(
            {
                movies,
                username: decodedToken["cognito:username"],

            }
            ), //sending the array of movies as stringified JSON in the response
    };
};