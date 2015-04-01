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

LuaVM vm; //one vm to rule them all

//this will be updated later
const string filename = "lernaconf.lua";

int main (string[] args)
{
    Gtk.init(ref args);

    vm = new LuaVM();
    vm.open_libs();
    //a little ugly using the or short circuit...
    if(0 != vm.load_file(filename) || 0!= vm.pcall(0,0,0))
    {
      stderr.printf(@"Couldn't run configuration file: $filename\n");
      stderr.printf(@"$(vm.to_string(-1))\n");
    }
    var browser = new LernaWindow();
    browser.start();

    Gtk.main();

    return 0;
}

