VERSION=$$(cat version.txt)

default: build

clean/generated:
		rm -rf docs
		mkdir docs
		mkdir docs/css
		mkdir docs/fonts
		mkdir docs/img
		mkdir docs/blog

generate/css:
		sassc --style compressed src/scss/app.scss docs/css/app-${VERSION}.css

generate/html:
		bash build-html.sh ${VERSION}

generate/static:
		cp src/img/* docs/img/
		cp src/fonts/* docs/fonts/
		cp keybase.txt docs/
		cp robots.txt docs/

cdn/clean:
		aws s3 rm --recursive "s3://joshgrancell.com/cdn/img"
		aws s3 rm --recursive "s3://joshgrancell.com/cdn/css"
		aws s3 rm --recursive "s3://joshgrancell.com/cdn/fonts"

cdn/upload:
		aws s3 sync "docs/img/" "s3://joshgrancell.com/cdn/img/"
		aws s3 sync "docs/css/" "s3://joshgrancell.com/cdn/css/"
		aws s3 sync "docs/fonts/" "s3://joshgrancell.com/cdn/fonts/"

build: clean/generated generate/css generate/html generate/static

publish: build cdn/upload
