--this file is testing and documentation, it is run after Gtk.init, but before anything else
print("Hello World")

--don't forget to enable access to gtk
local lgi = require 'lgi'
local Gtk = lgi.Gtk

--this function is called whenever a new window is created
function lerna_window_created(window)
  win = Gtk.Window(window)
  function win:on_destroy()
    print("goodbye destruction!")
  end
  print("hello constructor")
end
