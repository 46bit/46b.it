{-# LANGUAGE OverloadedStrings #-}
import Hakyll
import Data.Monoid
import Data.Maybe
import Data.Map

main :: IO ()
main = hakyll $ do
	match "templates/*" $ do
		compile templateCompiler

	-- Asset compilation
	match (Hakyll.fromList ["img/*", "js/*"]) $ do
		route idRoute
		compile copyFileCompiler
	match "css/*" $ do
		route idRoute
		compile compressCssCompiler

	-- Home
	create ["index.html"] $ do
		route idRoute
		compile $ do
			makeItem ""
				>>= loadAndApplyTemplate "templates/default.html" defaultContext
				>>= relativizeUrls

	-- Yearly post indexes


	-- Individual posts
	match "[0-9][0-9][0-9][0-9]/*.md" $ do
		route $ setExtension "html"
		compile $ pandocCompiler
			>>= loadAndApplyTemplate "templates/default.html" defaultContext
			>>= relativizeUrls

	-- Simple content pages
	match (Hakyll.fromList ["about.md", "ident.md"]) $ do
		route $ setExtension "html"
		compile $ pandocCompiler
			>>= loadAndApplyTemplate "templates/default.html" defaultContext
			>>= relativizeUrls
