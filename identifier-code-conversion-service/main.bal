
import ballerina/http;
import ballerina/io;
import ballerinax/mongodb;

public type System record {
    string systemName;
    string inSystemCode;
};

public type DatoMaestro record {
    string countryCode;
    System[] systems;
};

public function main() {
    io:println("Hello, World!");
}

const string DB_NAME = "poc-lb";
const string COLLECTION_NAME = "codes";
mongodb:ConnectionString connectionUrl = {url: "mongodb+srv://choreouser:choreouser@choreo-test-cluster.nyjlp.mongodb.net/?retryWrites=true&w=majority"};

mongodb:ConnectionConfig mongoConfig = {
    connection: connectionUrl,
    databaseName: DB_NAME
};

mongodb:Client mongoClient = check new (mongoConfig);

service /datos\-maestros on new http:Listener(9090) {

    resource function get datoMaestro/[string countryCode]() returns json|error? {
        // map<json>[] found = check mongoClient->find(COLLECTION_NAME, rowType = DatoMaestro);
        // if (found.length() == 0) {
        //     return error("Not Found", message = "DatoMaestro not found for countryCode: " + countryCode);
        // }
        // return found[0];
        stream<record {}, error?> findResponse = check mongoClient->find(collectionName = "codes");

        json[]? jsonResponse = check from var entry in findResponse
            select entry.toJson();

        return jsonResponse;
    }

    resource function post datoMaestro(@http:Payload json payload) returns string|error {
        check mongoClient->insert(<map<json>>payload, COLLECTION_NAME);
        return "DatoMaestro created successfully";
    }

    //     resource function put datoMaestro/[string countryCode](json body) returns string|error {
    //     int updated = check mongoClient->update(body, COLLECTION_NAME, { "countryCode": countryCode });
    //     if (updated == 0) {
    //         return error("Not Found", message = "DatoMaestro not found for countryCode: " + countryCode);
    //     }
    //     return "DatoMaestro updated successfully";
    // }

    resource function delete datoMaestro/[string countryCode]() returns string|error {
        int deleted = check mongoClient->delete(DB_NAME, COLLECTION_NAME, {"DatoMaestro": {"countryCode": countryCode}});
        if (deleted == 0) {
            return error("Not Found", message = "DatoMaestro not found for countryCode: " + countryCode);
        }
        return "DatoMaestro deleted successfully";
    }
}

// {
//     datoMaestro {
//         countryCode: "AR",
//         systems: [
//             {
//                 systemName: "salesforceCRM",
//                 inSystemCode: "AR01"
//             },
//             {
//                 systemName: "SAP-ERP",
//                 inSystemCode: "ARG"
//             },
//             {
//                 systemName: "ServiceNow",
//                 inSystemCode: "AR"
//             }
//         ]
//     }
// }