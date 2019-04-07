# Friendify

## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview
### Description
A social media app based on your listening habits sourced from Spotify. 

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social Networking / Music
- **Mobile:** This will be a mobile app only.
- **Story:** Analyzes users music choices, and connects them to other users with similar choices. The user is then able to friend others based on their musical preferences. 
- **Market:** Anyone/ music enthusiasts.
- **Habit:** ALL THE TIME
- **Scope:** Start by suggesting friends based on similar music preferences...

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User should be able to login
* User should be able to logout
* User should be able to sign up
* User should be able to see the stream screen
* User can add 'friends'
* User should be able to see the profile screen

**Optional Nice-to-have Stories**

* User can play the song
* User can receive friend/music recommendations
* User can message others

### 2. Screen Archetypes

* Login
    * User should be able to login
* Register
    * User should be able to sign up
* Profile
    * User should be able to see the profile screen
* Stream
    * User should be able to see the stream screen

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Feed
* Profile
* Recommended People

**Flow Navigation** (Screen to Screen)

* Login
   * Stream
* Register
   * Stream
* Stream
   * Profile
   * Recommended people

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://github.com/csumb-team7/Friendify/blob/master/wireframes/wireframe.jpeg?raw=true" width=600>

### Interactive Prototype
<img src="https://i.imgur.com/WqXEQJs.gif" width=250>

## Schema
### Models
#### User

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user (default field) |
   | image         | File     | image that user posts |
   | spotify_account       | String   | Spotify's key |
   | name       | String   | User's name |
   | lastname       | String   | User's lastname |
   | username       | String   | User's username |
   | createdAt     | DateTime | date when post is created (default field) |
   | updatedAt     | DateTime | date when post is last updated (default field) |
   
#### Post

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the post (default field) |
   | author        | Pointer to User| Author |
   | spotify_song_id         | String     | Spotify song id |
   | createdAt     | DateTime | date when post is created (default field) |
   | updatedAt     | DateTime | date when post is last updated (default field) |
   
### Networking
#### List of network requests by screen
   - Login
      - (POST) User can login.
   - Logout
      - (POST) User can logout.
   - Sign Up
      - (POST) User can create an account.
   - Edit Profile
      - (POST) User can edit his profile.
   - Find a friend
      - (GET) User is able to find friends by their username.
   - Add a friend
      - (POST) User is able to add friends.
   - Delete a friend 
      - (POST) User is able to delete friends.
   
