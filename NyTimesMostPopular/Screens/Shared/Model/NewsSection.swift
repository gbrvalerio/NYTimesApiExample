//
//  NewsSection.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 05/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import Foundation


///All the sections accepted by the NYTimes Api
///Chose enum because of the compile time safety.
///
///Sections:
/// - Arts
/// - Automobiles
/// - Blogs
/// - Books
/// - Business Day
/// - Education
/// - Fashion & Style
/// - Food
/// - Health
/// - Job Market
/// - Magazine
/// - membercenter
/// - Movies
/// - Multimedia
/// - N.Y.%20%2F%20Region
/// - NYT Now
/// - Obituaries
/// - Open
/// - Opinion
/// - Public Editor
/// - Real Estate
/// - Science
/// - Sports
/// - Style
/// - Sunday Review
/// - T Magazine
/// - Technology
/// - The Upshot
/// - Theater
/// - Times Insider
/// - Today’s Paper
/// - Travel
/// - U.S.
/// - World
/// - Your Money
/// - all-sections
enum NewsSection : String, Decodable {
    
    case arts = "Arts"
    case automobiles = "Automobiles"
    case blogs = "Blogs"
    case books = "Books"
    case businessDay = "Business Day"
    case education = "Education"
    case fashionAndStyle = "Fashion & Style"
    case food = "Food"
    case health = "Health"
    case jobMarket = "Job Market"
    case magazine = "Magazine"
    case membercenter = "membercenter"
    case movies = "Movies"
    case multimedia = "Multimedia"
    case nyRegion = "N.Y. / Region"
    case nytNow = "NYT Now"
    case obituaries = "Obituaries"
    case open = "Open"
    case opinion = "Opinion"
    case publicEditor = "Public Editor"
    case realEstate = "Real Estate"
    case science = "Science"
    case sports = "Sports"
    case style = "Style"
    case sundayReview = "Sunday Review"
    case tMagazine = "T Magazine"
    case technology = "Technology"
    case theUpshot = "The Upshot"
    case theather = "Theater"
    case timesInsider = "Times Insider"
    case todaysPaper = "Today’s Paper"
    case travel = "Travel"
    case us = "U.S."
    case world = "World"
    case yourMoney = "Your Money"
    case well = "Well"
    case all = "all-sections"
    
}
