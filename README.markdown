# YardXML: an YARD extension for XML output

YardXML is an YARD extension which allows to produce XML output from
YARD registry.

## Usage

Install the gem:

    gem install yard-xml

Edit ~/.yard/config and insert the following line:

    load_plugins: true

Run yardoc with `-f xml` switch to specify XML format.

    yard -f xml

It will generate `doc/index.xml` file for you.
