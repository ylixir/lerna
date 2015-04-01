--[[
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
--]]

--this file is testing and documentation, it is run after Gtk.init, but before anything else
--
--no need to load lgi, the browser does this for us so it can
--ensure access to the helper functions that allow seemless use
--of gtk objects

print("Hello World")

--this function is called whenever a new window is created
function lerna_window_created(window)
  print("hello constructor")
  function window:on_destroy()
    print("goodbye destruction!")
  end
end

--and when a new tab is created
function lerna_tab_created(stack,child)
  print("hello tab")
end
