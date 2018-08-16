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
    migrations.add(model: UserToken.self, database: .psql)
    migrations.add(model: Track.self, database: .psql)
    migrations.add(model: FavoriteTrack.self, database: .psql)
    migrations.add(model: Advert.self, database: .psql)
    migrations.add(model: AdvertImage.self, database: .psql)
    migrations.add(model: AdvertMessage.self, database: .psql)
    migrations.add(model: Event.self, database: .psql)
    migrations.add(model: Image.self, database: .psql)
    migrations.add(model: ImageComment.self, database: .psql)
    migrations.add(model: ImageLike.self, database: .psql)
    migrations.add(model: ImageReply.self, database: .psql)
    migrations.add(model: Post.self, database: .psql)
    migrations.add(model: PostComment.self, database: .psql)
    migrations.add(model: PostLike.self, database: .psql)
    migrations.add(model: PostReply.self, database: .psql)
    migrations.add(model: Review.self, database: .psql)
    migrations.add(model: ReviewComment.self, database: .psql)
    migrations.add(model: ReviewReply.self, database: .psql)
    migrations.add(model: Setting.self, database: .psql)
    migrations.add(model: Video.self, database: .psql)
    migrations.add(model: VideoComment.self, database: .psql)
    migrations.add(model: VideoLike.self, database: .psql)
    migrations.add(model: VideoReply.self, database: .psql)
    services.register(migrations)

}
