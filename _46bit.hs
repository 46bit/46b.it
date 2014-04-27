{-# LANGUAGE OverloadedStrings #-}
import Hakyll
import Data.Monoid
import Data.Maybe
import Data.Map
import Data.List (intersperse, isSuffixOf, isPrefixOf)
import Data.List.Split (splitOn)
import System.FilePath (combine, splitExtension, takeFileName)
import Debug.Trace

config :: Configuration
config = defaultConfiguration
	{deployCommand = "ssh 46gluon 'cd /server/www/46b.it/webroot && git pull origin release'"}

main :: IO ()
main = hakyllWith config $ do
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
	match "index.html" $ do
		route idRoute
		compile $ do
			posts <- recentFirst =<< loadAll "posts/*"
			let indexCtx =
				constField "title" "Home" `mappend`
				listField "posts" postCtx (return posts) `mappend`
				defaultContext
			getResourceBody
				>>= applyAsTemplate indexCtx
				>>= loadAndApplyTemplate "templates/default.html" indexCtx
				>>= deIndexUrls

	-- Yearly post indexes
	create (yearsString [2011, 2012, 2013, 2014]) $ do
		route idRoute
		compile $ do
			posts <- recentFirst =<< loadAll "posts/*"
			let archiveCtx =
				constField "title" "YEAR" `mappend`
				listField "posts" postCtx (return posts) `mappend`
				defaultContext
			makeItem ""
				>>= loadAndApplyTemplate "templates/years.html" archiveCtx
				>>= loadAndApplyTemplate "templates/default.html" archiveCtx
				>>= deIndexUrls

	-- Individual posts
	match "posts/*.md" $ do
		route $ postRoute `composeRoutes` setExtension "html"
		compile $ pandocCompiler
			>>= saveSnapshot "content"
			>>= loadAndApplyTemplate "templates/post.html" postCtx
			>>= loadAndApplyTemplate "templates/default.html" postCtx
			>>= deIndexUrls

	-- Simple content pages
	match (Hakyll.fromList ["about.md", "ident.md"]) $ do
		route $ dirIndexRoute `composeRoutes` setExtension "html"
		compile $ pandocCompiler
			>>= loadAndApplyTemplate "templates/page.html" defaultContext
			>>= loadAndApplyTemplate "templates/default.html" defaultContext
			>>= deIndexUrls

yearsString :: [Int] -> [Identifier]
yearsString ys = Prelude.map t ys
	where t y = fromFilePath (show y ++ "/index.html")

dirIndexRoute :: Routes
dirIndexRoute = customRoute (\i -> directorize $ toFilePath i)
	where
		directorize path = dirs ++ "/index" ++ ext
			where
				(dirs, ext) = splitExtension path

postCtx :: Context String
postCtx =
	dateField "year" "%Y" `mappend`
	dateField "date" "%B %e, %Y" `mappend`
	teaserField "teaser" "content" `mappend`
	defaultContext

postRoute :: Routes
postRoute = postlessRoute `composeRoutes` directorizeYear

postlessRoute :: Routes
postlessRoute = gsubRoute "posts/" (const "")

-- https://github.com/ohbadiah/nickmcavoy-dotcom/blob/master/blog/src/Main.hs:191
directorizeYear :: Routes
directorizeYear = customRoute (\i -> directorize $ toFilePath i)
	where
		directorize path = dirs ++ "/index" ++ ext
			where
				(dirs, ext) = splitExtension $ concat $
					(intersperse "/" year) ++ ["/"] ++ (intersperse "-" slug)
				(year, rest) = splitAt 1 $ splitOn "-" path
				(_, slug) = splitAt 3 $ splitOn "-" path

-- this version strips /index.html from non-home pages and index.html from home.
stripIndex :: String -> String
stripIndex url = if "index.html" `isSuffixOf` url
	then
		if length url > 11
			then take (length url - 11) url
			else take (length url - 10) url
	else url

deIndexUrls :: Item String -> Compiler (Item String)
deIndexUrls item = return $ fmap (withUrls stripIndex) item


