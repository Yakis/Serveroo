//
//  PostController.swift
//  App
//
//  Created by Mugurel Moscaliuc on 18/08/2018.
//

import FluentPostgreSQL
import Vapor
import FluentSQL


final class PostController: RouteCollection {

    func boot(router: Router) throws {
        let posts = router.grouped("posts")
        
        // /api/v1/posts/all
        posts.get("all", use: getAll)
        
        // /api/v1/posts/create
        posts.post("create", use: create)
        
        // /api/v1/posts/:id
        posts.get(Post.parameter, use: getOne)
        posts.patch(Post.parameter, use: update)
        posts.delete(Post.parameter, use: delete)
        
        // /api/v1/posts/like
        posts.post("like", use: like)
        
//        // /api/v1/posts/likes?postId=1
//        posts.get("likes", use: getLikesCount)
        
    }

    func getAll(_ req: Request) throws -> Future<[Post]> {
        return Post.query(on: req).all()
    }
    
    
    func getOne(_ req: Request) throws -> Future<Post> {
        return try req.parameters.next(Post.self)
    }
    
    
    func create(_ req: Request) throws -> Future<Post> {
        return try req.content.decode(Post.self).flatMap { post in
            guard let userId = post.userId else { throw Abort(.notFound) }
            return User.find(userId, on: req).flatMap { user in
                switch user?.userType {
                case "owner":
                    return post.save(on: req)
                default: throw Abort(.unauthorized)
                }
            
            }
        }
    }
    
    
    func update(_ req: Request) throws -> Future<Post> {
        return try req.parameters.next(Post.self).flatMap { post in
            return try req.content.decode(Post.self).flatMap { newPost in
                post.content = newPost.content ?? post.content
                post.image = newPost.image ?? post.image
                post.trackId = newPost.trackId ?? post.trackId
                post.userId = newPost.userId ?? post.userId
                post.trackName = newPost.trackName ?? post.trackName
                post.trackIcon = newPost.trackIcon ?? post.trackIcon
                post.likesCount = newPost.likesCount ?? post.likesCount
                post.commentsCount = newPost.commentsCount ?? post.commentsCount
                return post.save(on: req)
            }
        }
    }
    
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Post.self).flatMap { post in
            return post.delete(on: req)
            }.transform(to: .ok)
    }
    
    
    func like(_ req: Request) throws -> Future<Post> {
        return try req.content.decode(PostLike.self).flatMap { [weak self] like in
            return Post.find(like.postId, on: req).flatMap { [weak self] post in
                guard let unwrappedPost = post else { throw Abort(.notFound) }
                let likesCount = unwrappedPost.likesCount ?? 0
                guard let postId = post?.id else { throw Abort(.badRequest) }
                guard let userId = post?.userId else { throw Abort(.badRequest) }
                switch self?.isLiked(like: like, postId: postId, userId: userId) {
                case true:
                    let _ = like.delete(on: req)
                    unwrappedPost.likesCount = likesCount - 1
                    return unwrappedPost.save(on: req)
                default:
                    let _ = like.save(on: req)
                    unwrappedPost.likesCount = likesCount + 1
                    return unwrappedPost.save(on: req)
                }
            }
        }
    }
    
    
    func isLiked(like: PostLike, postId: Int, userId: Int) -> Bool {
        if like.postId == postId && like.userId == userId {
            return true
        } else {
            return false
        }
    }
    


}



