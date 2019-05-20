//
//  DatabaseProtocol.swift
//  Punity
//
//  Created by Damian Farinaccio on 20/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation

enum DatabaseChange {
    case add
    case remove
    case update
}
enum ListenerType {
    case podcasts
    case users
    case all
}
protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onTeamChange(change: DatabaseChange, teamHeroes: [SuperHero])
    func onHeroListChange(change: DatabaseChange, heroes: [SuperHero])
}
protocol DatabaseProtocol: AnyObject {
    var defaultTeam: Team {get}
    
    func addSuperHero(name: String, abilities: String) -> SuperHero
    func addTeam(teamName: String) -> Team
    func addHeroToTeam(hero: SuperHero, team: Team) -> Bool
    func deleteSuperHero(hero: SuperHero)
    func deleteTeam(team: Team)
    func removeHeroFromTeam(hero: SuperHero, team: Team)
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}
