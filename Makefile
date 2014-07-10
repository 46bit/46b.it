all:
	mkdir -p bin
	ghc -o bin/_46bit ./_46bit.hs

clean:
	rm -rf bin
