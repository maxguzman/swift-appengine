import Foundation
import Vapor

let drop = Droplet()

// Respond to App Engine health check requests
drop.get("/_ah/health") { request in
    print("ALL - /_ah/health route handler...")
    return "OK"
}

// Basic GET request
drop.get { request in
    return try JSON(node: [
        "message": "Welcome to Anorak's Almanac!"
    ])
}

drop.get("hello") { request in
    return try JSON(node: [
        "message": "hello max!"
    ])
}

drop.get("hello","there") { request in
    return try JSON(node: [
        "message": "hello again..."
    ])
}

drop.get("beers", Int.self) { request, beers in
    return try JSON(node: [
        "message": "Te quedan \(beers -1) chelas..."
    ])
}

drop.post("post") { request in
    guard let name = request.data["name"]?.string else {
        throw Abort.badRequest
    }
    return try JSON(node: [
        "message": "Hello, \(name)!"
    ])
}

// Start server on 8080 (default)
drop.run()