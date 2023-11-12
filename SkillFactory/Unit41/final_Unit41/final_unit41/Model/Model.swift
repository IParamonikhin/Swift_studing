//
//  Model.swift
//  final_unit41
//
//  Created by Иван on 12.11.2023.
//

import Foundation


class Model{
    
    
    let urlBase = "https://ia904600.us.archive.org/27/items/spider-mantheanimatedseries/"
    
    let episodeList = ["01x01 Night of the Lizard.mp4",
                       "01x02 The Spider Slayer.mp4",
                       "01x03 Return of the Spider Slayers.mp4",
                       "01x04 Doctor Octopus - Armed and Dangerous.mp4",
                       "01x05 The Menace of Mysterio.mp4",
                       "01x06 The Sting of the Scorpion.mp4",
                       "01x07 Kraven The Hunter.mp4",
                       "01x08 The Alien Costume (Part 1).mp4",
                       "01x09 The Alien Costume (Part 2).mp4",
                       "01x10 The Alien Costume (Part 3).mp4",
                       "01x11 The Hobgoblin (Part 1).mp4",
                       "01x12 The Hobgoblin (Part 2).mp4",
                       "01x13 Day of the Chameleon.mp4"]
    
    let thumbnailTiming: [Double] = [158, 58, 130, 58, 58, 58, 58, 58, 145, 144, 58, 144, 58]
    
    func episodeName(episodeNumber: Int)-> String{
        let retString = episodeList[episodeNumber].dropLast(4).dropFirst(3)
        return String(retString)
    }
    
    func episodeURL(episodeNumber: Int)-> URL{
        return URL(string: urlBase + episodeList[episodeNumber].addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!
    }
    
}
