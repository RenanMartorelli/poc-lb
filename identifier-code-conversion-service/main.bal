import ballerinax/mongodb;

import ballerina/http;
import ballerina/io;

configurable string DB_NAME = ?;
configurable string DB_COLLECTION_NAME = ?;

mongodb:ConnectionString connectionUrl = {url: "mongodb+srv://choreouser:choreouser@choreo-test-cluster.nyjlp.mongodb.net/?retryWrites=true&w=majority"};

mongodb:ConnectionConfig mongoConfig = {
    connection: connectionUrl,
    databaseName: DB_NAME
};

mongodb:Client mongoClient = check new (mongoConfig);

public function main() {
    io:println("Hello, World!");
}

service /datos\-maestros on new http:Listener(9090) {

    resource function get datoMaestro() returns json|error? {

        stream<record {}, error?> findResponse = check mongoClient->find(collectionName = DB_COLLECTION_NAME);
        json[]? jsonResponse = check from var entry in findResponse
            select entry.toJson();

        return jsonResponse;
    }

    resource function post datoMaestro(@http:Payload json payload) returns string|error? {

        check mongoClient->insert(<map<json>>payload, collectionName = DB_COLLECTION_NAME);
        return "DatoMaestro created successfully";
    }

    resource function delete datoMaestro/[string countryCode]() returns string|error {

        int deleteResponse = check mongoClient->delete(collectionName = DB_COLLECTION_NAME);
        if (deleteResponse == 0) {
            return error("Not Found", message = "DatoMaestro not found for countryCode: " + countryCode);
        }
        return "DatoMaestro deleted successfully";
    }
}

