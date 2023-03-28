
import ballerina/http;
import ballerina/io;

public function main() {
    io:println("Hello, World!");
}



service /codeconversion on new http:Listener(9090) {
    resource function get .() returns error? {

    // checkpanic mongoClient->insert(doc2,"codes");
    // checkpanic mongoClient->insert(doc3,"codes");
    // checkpanic mongoClient->insert(doc4,"codes");
        
//  string mongoConnectionString = "mongodb://choreouser:RenanSenha2022@choreo-test-cluster-shard-00-00.nyjlp.mongodb.net:27017,choreo-test-cluster-shard-00-01.nyjlp.mongodb.net:27017,choreo-test-cluster-shard-00-02.nyjlp.mongodb.net:27017/test?replicaSet=atlas-143d3h-shard-0&ssl=true&authSource=admin";
//  string mongoDatabaseName = "marketing";

// mongodb:Client mongodbTannEndpoint = check new ({options: {url: mongoConnectionString}}, databaseName = mongoDatabaseName);
    
        // mongoDBRegistro dadosRegistro = {
        //     dadosEconomapas: economapasResponse,
        //     dadosPaciente: cpfFiltrado[0]
        // };

        // map<json> m = {};
        // m[cpf] = dadosRegistro.toJson();

        // check mongodbTannEndpoint->insert(m, "patients");
    
    
    }
}
