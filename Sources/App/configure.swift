import FluentPostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentPostgreSQLProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    var databases = DatabasesConfig()
    let databaseConfig: PostgreSQLDatabaseConfig
    if let url = Environment.get("DATABASE_URL") { // it will read from this URL in production
        databaseConfig = (try PostgreSQLDatabaseConfig(url: url))
    }
    else { // when environment variable not present, default to local development environment
        databaseConfig = PostgreSQLDatabaseConfig(hostname: "0.0.0.0", port: 5432, username: "yakis", database: "serveroo", password: nil)
    }
    let database = PostgreSQLDatabase(config: databaseConfig)
    databases.add(database: database, as: .psql)
    services.register(databases)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .psql)
    services.register(migrations)

}
