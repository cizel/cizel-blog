HUGO_BIN=hugo

.PHONY: start changelog

start:
	$(HUGO_BIN) server --source=exampleSite --themesDir=../.. --disableFastRender

changelog:
	conventional-changelog -p angular -i CHANGELOG.md -s
