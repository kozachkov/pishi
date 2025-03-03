test:
	prove -v t/*

readme:
	./build_book.sh -d doc -o README.md && \
		cp doc/README.md README.md && rm doc/README.md
