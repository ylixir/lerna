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
using Gdk;
using Lua;

public class LernaWindow : Gtk.Window
{

    private static const string TITLE = "Lerna Browser";

    private Box box;
    private LernaTabstrip tabstrip;
    private Stack stack;

    public LernaWindow(LuaVM vm)
    {
        //try to call the lua function for this
        vm.get_global("lerna_window_created");
        if( vm.is_function(-1) )
        {
          Gtk.Window* win = this;
          vm.push_lightuserdata(win);
          if( 0 != vm.pcall(1,0,0) )
            stderr.printf(@"error running function 'lerna_window_created'\n$(vm.to_string(-1))");
        }

        this.title = LernaWindow.TITLE;
        set_default_size (800, 600);

        stack = new Stack();
        tabstrip = new LernaTabstrip(stack);
        box =  new Box(Orientation.VERTICAL,0);
        box.pack_start(tabstrip,false,false);
        box.pack_start(stack,true,true);
        add(box);

        destroy.connect(Gtk.main_quit);
        tabstrip.new_clicked.connect((source)=>
        {
          LernaPage page = new LernaPage();
          stack.add(page);
          stack.child_set_property(page,"title","[No Title]");
          page.start();
          stack.visible_child=page;
        });
    }

    public void start()
    {
        show_all();
        box.show_all();
        stack.show_all();
        tabstrip.start();
        tabstrip.new_clicked();
    }
}

