#!/bin/bash
#!/bin/sh
# more info at https://gist.github.com/mcgivrer/a31510019029eba73edf5721a93c3dec
# Copyright 2020 Frederic Delorme (McGivrer) fredericDOTdelormeATgmailDOTcom
#
export PROGRAM_NAME=helloworld
export PROGRAM_VERSION=1.0
export PROGRAM_TITLE="HelloWorld"
export AUTHOR_NAME="Frederic Delorme"
export VENDOR_NAME="SnapGames"
export MAINCLASS=com.snapgames.sample.HelloWorld
# pathes
export SRC=src
export LIBS=lib
export TARGET=target
export BUILD=$TARGET/build
export CLASSES=$TARGET/classes
export RESOURCES=$SRC/main/resources
export COMPILATION_OPTS=-Xlint:deprecation
export JAR_OPTS=
export BOOK_PATH=docs

function manifest(){
	rm -Rf $TARGET
	mkdir $TARGET
	touch $TARGET/manifest.mf
	# build manifest
	echo "|_ 1. Create Manifest file '$TARGET/manifest.mf'"
	echo 'Manifest-Version: 1.0'>$TARGET/manifest.mf
	echo "Created-By: $JAVA_VERSION ($VENDOR_NAME)">>$TARGET/manifest.mf
	echo "Main-Class: $MAINCLASS">>$TARGET/manifest.mf
	echo "Implementation-Title: $PROGRAM_TITLE">>$TARGET/manifest.mf
	echo "Implementation-Version: $PROGRAM_VERSION-build_$GIT_COMMIT_ID">>$TARGET/manifest.mf
	echo "Implementation-Vendor: $VENDOR_NAME">>$TARGET/manifest.mf
	echo "Implementation-Author: $AUTHOR_NAME">>$TARGET/manifest.mf
	echo "   |_ done"
}

function compile(){
	echo "compile sources "
	echo "> from : $SRC"
	echo "> to   : $CLASSES"
	# prepare target
	mkdir -p $CLASSES
	# Compile class files
	rm -Rf $CLASSES/*
	echo "|_ 2. compile sources from '$SRC' ..."
	find $SRC -name '*.java'  > $LIBS/sources.lst
	javac @$LIBS/options.txt @$LIBS/sources.lst -cp $CLASSES $COMPILATION_OPTS
	echo "   done."
}

function createJar(){
	echo "|_ 3. package jar file '$PROGRAM_NAME.jar'..."

	if ([ $(ls $CLASSES | wc -l  | grep -w "0") ])
	then
		echo 'No compiled class files'
	else
		# Build JAR
		jar -cfmv $JAR_OPTS $TARGET/$PROGRAM_NAME.jar $TARGET/manifest.mf -C $CLASSES . -C $RESOURCES .
	fi

	echo "   |_ done."
}

function wrapJar(){
	# create runnable program
	echo "|_ 4. create run file '$PROGRAM_NAME.run'..."
	mkdir -p $BUILD
	cat $LIBS/stub.sh $TARGET/$PROGRAM_NAME.jar > $BUILD/$PROGRAM_NAME.run
	chmod +x $BUILD/$PROGRAM_NAME.run
	echo "   |_ done."
}

function sign(){
	echo "not already implemented... sorry"
}

function genPandocEBook(){
	rm -f $TARGET/book.md
	cat $SRC/docs/metadata.yml>>$TARGET/book.md
	cat $SRC/docs/*.md>>$TARGET/book.md
	pandoc $TARGET/book.md --resource-path=$SRC/docs/resources/ --toc --toc-depth=2 -t epub3 -o $TARGET/build/$PROGRAM_NAME-$PROGRAM_VERSION.epub
}

function genPandocPdf(){
	rm -f $TARGET/book.md
	cat $SRC/docs/metadata.yml>>$TARGET/book.md
	cat $SRC/docs/*.md>>$TARGET/book.md
	pandoc $TARGET/book.md --resource-path=$SRC/docs/resources/ --toc --toc-depth=2 -o $TARGET/build/$PROGRAM_NAME-$PROGRAM_VERSION.pdf --listings --template $SRC/docs/eisvogel.tex
}

function help(){
	echo "build2 command line usage :"
	echo "---------------------------"
	echo "$> build2 [options]"
	echo "where :"
	echo " - a|A|all     : Perform all following operations"
	echo " - c|C|compile : Compile all sources project"
	echo " - j|J|jar     : Build JAR with all resources"
	echo " - w|W|wrap    : Build and wrap jar as a shell script"
	echo " - s|S|sign    : Build and wrap signed jar as a shell script"
	echo ""
	echo " (c)2020 MIT License Frederic Delorme (@McGivrer) fredericDOTdelormeATgmailDOTcom"
	echo " --"
}

function run(){
	echo "Build of program '$PROGRAM_NAME' ..."
	echo "-----------"
	case $1 in
	  a|A|all)
		manifest
		compile
		createJar
		wrapJar
		;;
	  c|C|compile)
		manifest
		compile
		;;
	  d|D|doc)
	    genPandocPdf
		;;
	  e|E|edoc)
	    genPandocEBook
		;;
	  j|J|jar)
		createJar
		;;
	  w|W|wrap)
		wrapJar
		;;
	  s|S|sign)
	    sign $2
	    ;;
	  h|H|?|*)
		help
		;;
	esac
	echo "-----------"
	echo "... done".
}

run $1
