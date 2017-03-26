{-# LANGUAGE OverloadedStrings #-}
import Hakyll
import Data.Monoid
import Data.Maybe
import Data.Map
import Control.Monad
import Data.List (intersperse, isSuffixOf)
import Data.List.Split (splitOn)
import System.FilePath (splitExtension, takeFileName, takeBaseName)
import Text.Pandoc.Options
import Data.Set

config :: Configuration
config = defaultConfiguration {
	deployCommand = "./lib/deploy.sh",
	providerDirectory = "./content"
}

feedConfig :: FeedConfiguration
feedConfig = FeedConfiguration {
	feedTitle = "46bit",
	feedDescription = "",
	feedAuthorName = "46bit",
	feedAuthorEmail = "",
	feedRoot = "https://46b.it"
}

-- http://travis.athougies.net/posts/2013-08-13-using-math-on-your-hakyll-blog.html
pandocMathCompiler =
    let mathExtensions = [Ext_tex_math_dollars, Ext_tex_math_double_backslash,
                          Ext_latex_macros]
        defaultExtensions = writerExtensions defaultHakyllWriterOptions
        newExtensions = Prelude.foldr Data.Set.insert defaultExtensions mathExtensions
        writerOptions = defaultHakyllWriterOptions {
                          writerExtensions = newExtensions,
                          writerHTMLMathMethod = MathJax ""
                        }
    in pandocCompilerWith defaultHakyllReaderOptions writerOptions

main :: IO ()
main = hakyllWith config $ do
	match "templates/*" $ do
		compile templateCompiler

	-- Asset compilation
	match "img/*" $ do
		route idRoute
		compile copyFileCompiler
	match "js/**/*" $ do
		route idRoute
		compile copyFileCompiler
	match "css/*" $ do
		route idRoute
		compile compressCssCompiler
	match "fonts/*" $ do
		route idRoute
		compile copyFileCompiler
	match (Hakyll.fromList ["favicon.ico"]) $ do
		route idRoute
		compile copyFileCompiler

	-- Home
	match "index.html" $ do
		route idRoute
		compile $ do
			posts <- recentFirst =<< loadAll "posts/*"
			let indexCtx =
				constField "title" "Home" `mappend`
				listField "posts" postCtx (return posts) `mappend`
				constField "math" "true" `mappend`
				defaultContext
			getResourceBody
				>>= applyAsTemplate indexCtx
				>>= loadAndApplyTemplate "templates/default.html" indexCtx
				>>= stripIndexFromUrls

	-- Content pages
	match (Hakyll.fromList ["about.md", "ident.md", "notepad.md", "404.md"]) $ do
		route routeNormal
		compile $ pandocMathCompiler
			>>= loadAndApplyTemplate "templates/page.html" defaultContext
			>>= loadAndApplyTemplate "templates/default.html" defaultContext
			>>= stripIndexFromUrls

	-- Posts
	match "posts/*.md" $ do
		route routePost
		compile $ pandocMathCompiler
			>>= saveSnapshot "content"
			>>= loadAndApplyTemplate "templates/post.html" postCtx
			>>= loadAndApplyTemplate "templates/default.html" postCtx
			>>= stripIndexFromUrls

	-- Yearly post archives
	mapM_ createYearlyArchive [2011, 2012, 2013, 2014]

	-- ATOM feed
	create ["meta/feed.atom"] $ do
		route idRoute
		compile $ do
			let feedCtx =
				bodyField "description" `mappend`
				postCtx
			posts <- fmap (take 10) . recentFirst =<< loadAllSnapshots "posts/*" "content"
			renderAtom feedConfig feedCtx posts

-- Yearly post archive helpers
createYearlyArchive :: Int -> Rules ()
createYearlyArchive year = create [archiveYearAsIdentifier year] $ do
	route idRoute
	compile $ do
		posts <- (filterPostsByYear year) `fmap` (recentFirst =<< loadAll "posts/*")
		let archiveCtx =
			constField "title" (show year) `mappend`
			listField "posts" postCtx (return posts) `mappend`
			constField "math" "true" `mappend`
			defaultContext
		{-	constField "math" (postsMath posts) `mappend`
			defaultContext-}
		makeItem ""
			>>= loadAndApplyTemplate "templates/years.html" archiveCtx
			>>= loadAndApplyTemplate "templates/default.html" archiveCtx
			>>= stripIndexFromUrls

{-hasMath :: Item a -> Compiler Bool
hasMath item = fmap isJust math
	where
		ident = itemIdentifier item
		math = getMetadataField ident "math"

postsMath :: [Item a] -> String
postsMath posts = if ((fmap length postsWithMath)) (>>=) (> 0)
	then "math"
	else ""
	where
		postsWithMath = filterM hasMath posts-}

filterPostsByYear :: Int -> [Item a] -> [Item a]
filterPostsByYear year = Prelude.filter (yearIs year . firstSegment . basename)
	where
		basename = takeBaseName . toFilePath . itemIdentifier
		firstSegment bn = takeWhile (/= '-') bn
		yearIs year yearTestStr = show year == yearTestStr

archiveYearAsIdentifier :: Int -> Identifier
archiveYearAsIdentifier year = fromFilePath (show year ++ "/index.html")

-- Routing methods
routeAtDir :: Routes
routeAtDir = customRoute (\i -> directorize $ toFilePath i)
	where
		directorize path = dirs ++ "/index" ++ ext
			where
				(dirs, ext) = splitExtension path

routeByPostYear :: Routes
routeByPostYear = customRoute (\i -> directorize $ toFilePath i)
	where
		directorize path = year ++ "/" ++ concat slug
			where
				tokens = splitOn "-" $ takeFileName path
				year = head tokens
				slug = intersperse "-" . snd $ splitAt 3 tokens

routeWithoutPosts :: Routes
routeWithoutPosts = gsubRoute "posts/" (const "")

-- Rendering methods
stripIndexFromUrls :: Item String -> Compiler (Item String)
stripIndexFromUrls item = return $ fmap (withUrls stripIndexFromUrl) item

stripIndexFromUrl :: String -> String
stripIndexFromUrl url = if "index.html" `isSuffixOf` url
	then
		if length url > 11
			then take (length url - 11) url
			else take (length url - 10) url
	else url

-- Specific Routing
routeNormal :: Routes
routeNormal = routeAtDir `composeRoutes` setExtension "html"

routePost :: Routes
routePost = routeByPostYear `composeRoutes` routeWithoutPosts `composeRoutes` routeNormal

-- Specific contexts
postCtx :: Context String
postCtx =
	dateField "year" "%Y" `mappend`
	dateField "date" "%B %e, %Y" `mappend`
	teaserField "teaser" "content" `mappend`
	defaultContext
