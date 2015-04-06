/*
Copyright 2015 Jon "ylixir" Allen

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

using Gtk;
using Lua;


//this will be updated later
const string filename = "lernaconf.lua";

const string lgi_script = """
--this is the script to load lgi.
--we will call this before we load
--the configuration file
lgi = require 'lgi'
Gtk = lgi.Gtk
""";

int main (string[] args)
{
    LuaVM L; //one vm to rule them all
    L = new LuaVM();
    L.open_libs(); //load all the standard lua libraries that we expect

    /* first we load lgi
     * this is done to avoid locale errors
     * that crop up if we load lgi after gtk_init
     */
    if(0 != L.load_string(lgi_script)
    || 0!= L.pcall(0,0,0)) //ugly short circuit...
    {
      stderr.printf(@"Couldn't run the lgi loader\n");
      stderr.printf(@"$(L.to_string(-1))\n");
    }

    /* now initialize gtk, don't do it earlier because of
     * lgi calling gtk_disable_setlocale
     */
    Gtk.init(ref args);

    /* now it is time to load our configuration file */
    if(0 != L.load_file(filename) || 0!= L.pcall(0,0,0))
    {
      stderr.printf(@"Couldn't run configuration file: $filename\n");
      stderr.printf(@"$(L.to_string(-1))\n");
    }

    /* create a new window and fire it up */
    var browser = new LernaWindow(L); //I don't really like passing
                                      //the lua vm to the window, this
                                      //need some architectural tweaks
    browser.start();

    Gtk.main();

    return 0;
}

