-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
display.setStatusBar( display.HiddenStatusBar )
display.setDefault( "background", 1, 1, 1 )


-- Global Variables
Widget = require( "widget" )
U = require("utils")
UI = require( "ui")
Anims = require( "animations")
SB = require ( "sceneBuilder" )
BB = require ("buildingBtn")
F = require ("functions")

Data = require( "Data.gameData" )
Taxes = require( "Data.taxes" )
Policies = require( "Data.policies" )

local composer = require( "composer" )
--composer.gotoScene( "Scenes.jobsScene" )
composer.gotoScene( "Scenes.masterScene" )
--composer.gotoScene( "test" )