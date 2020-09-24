# README

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Here is a java project template with `build.sh` script. It's now allow you to build any java project with the maven inspired file structure below. It is particularly adapted to very light machine : ARM architecture based ones a.k.a. RaspberryPi, OrangePi, BananaPi, etc ... or any simple projects.

It is using only `bash`, `javac`, `java`,`jar` and `git` command line instructions.
For this created executable `.run` file run... just be sure that a [Java JDK](https://www.oracle.com/java/technologies/java-se-glance.html "Go to the Java source and choose your favorite flavour from 8 to 15 !") is installed and a correct `JAVA_HOME` is set.

A new part has been added about generating book from `src/docs`. But you will need the `pandoc` utility. see paragrah bellow.

## Project Structure

```text
${projectfolder}/
 |_ lib
 |  |_ options.sh
 |  |_ stub.sh
 |_ src
 |  |_ main
 |     |_ java
 |     |  |_ my
 |     |     |_ program
 |     |        |_ package
 |     |           |_ MyMainClass.java
 |     |_ resources
 |        |_ res
 |        |  |_ images
 |        |  |  |_ mylogo.png
 |        |  |_ game.properties
 |_ .gitignore
 |_ build.sh
 |_ LICENSE
 |_ README.md
 (|_ pom.xml <= if any need to go back to too serious things :P )
```
## Configuration

The first variables must be adapted to your needs:

- `PROGRAM_NAME` Your program name,
- `PROGRAM_TITLE` Your program name,
- `PROGRAM_VERSION` The version of your program,
- `MAINCLASS` canonical name of your JAR entry point class,
- `VENDOR_NAME` the vendor for this program,
- `AUTHOR_NAME` the author of this program.

The manifest is generated by the `build2.sh` script.

Then just execute the following command line:

```bash
$> build.sh a
```
And a few seconds later, you'll got some beatifull `$PROGRAM_NAME.run` and `$PROGRAM_NAME.jar` file in the `target` directory. 

Execute the `.run` file to start your well packaged jar file in an autorun format.

## Generate Docs

To be able to generate the doc, as PDF and EPUB3, you will need pandoc, some fonts and a latex tooling.
According to this [post](https://learnbyexample.github.io/customizing-pandoc/) a good point is to install the following things:

```bash
sudo apt-get install pandoc
sudo apt-get install texlive-xetex
sudo apt-get install texlive-fonts-extra
sudo apt install librsvg2-bin
```

A basic Cover Image has been generated into the `src/docs/resources/images/cover` with a simple googledocs [there](https://docs.google.com/presentation/d/1VtoZ8fxrF1zqL5hsDJO4LpGUIdDhVV66Fc0xhTh15CQ/edit?usp=sharing). Feel free to copy it and modify it for your own usage.

## Some help on usage

To get some simple entry point, just do :

```bash
$> build.sh -h
build command line usage :
---------------------------
$> build [options]
where:
 - h|H|?|*     : display this simple help
 - a|A|all     : perform all following operations
 - c|C|compile : compile all sources project
 - j|J|jar     : build JAR with all resources
 - w|W|wrap    : Build and wrap jar as a shell script
 - d|D|doc     : Generate a PDF book from src/docs files
 - e|E|edoc    : Generate an ebook (EPUB) from src/docs files.

 (c)2020 MIT License Frederic Delorme (@McGivrer) fredericDOTdelormeATgmailDOTcom
 --
```

McG.

> Thanks to https://github.com/maynooth/CS210/wiki/Convert-Java-Executable-to-Linux-Executable 
> for creating a linux executable with concatenated sh and jar file.
