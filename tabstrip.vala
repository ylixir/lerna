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
using Gee;
using Pango;
using Lua;

public class LernaTabstrip : Box
{
    public signal void new_clicked();
    private LernaButton new_btn;
    private HashMap<Widget,LernaTab> tabs;
    private Stack stack;

    ~LernaTabstrip()
    {
      new_btn.destroy();
      stack.destroy();
    }
    public LernaTabstrip(LuaVM vm, Stack stack, Orientation o=Orientation.HORIZONTAL, int space=2)
    {
        orientation=o;
        spacing=space;
        homogeneous = false;

        new_btn = new LernaButton("[+]");
        tabs = new HashMap<Widget,LernaTab>();
        this.stack = stack;
        pack_end(new_btn,false,false);

        new_btn.clicked.connect((source)=>
        {
          new_clicked();
        });

        stack.add.connect(
        (source, child)=>
        {
          AttrList attr;
          LernaTab old_tab;

          LernaTab tab = new LernaTab("[No Title]");

          //unbold the old tab
          old_tab = tabs.get(stack.visible_child);
          if( null != old_tab )
          {
            attr = old_tab.attributes ?? new AttrList();
            attr.change(attr_weight_new(Weight.NORMAL));
            old_tab.attributes = attr;
          }
          //bold the new tab
          attr = tab.attributes ?? new AttrList();
          attr.change(attr_weight_new(Weight.BOLD));
          tab.attributes = attr;

          tabs.set(child, tab);
          child.notify["title"].connect(
          (source)=>
          {
            tabs.get(child).label=((LernaPage)child).title;
          });
          tab.clicked.connect(
          (source)=>
          {
            //unbold the old tab
            old_tab = tabs.get(stack.visible_child);
            if( null != old_tab )
            {
              attr = old_tab.attributes ?? new AttrList();
              attr.change(attr_weight_new(Weight.NORMAL));
              old_tab.attributes = attr;
            }
            //bold the new tab
            attr = tab.attributes ?? new AttrList();
            attr.change(attr_weight_new(Weight.BOLD));
            tab.attributes = attr;

            stack.visible_child=child;
          });
          tab.close.connect(
          (source)=>
          {
            stack.remove(child);

            //bold the new tab
            LernaTab new_tab = tabs.get(stack.visible_child);
            if( null != new_tab )
            {
              attr = new_tab.attributes ?? new AttrList();
              attr.change(attr_weight_new(Weight.BOLD));
              new_tab.attributes = attr;
            }
          });
          pack_start(tab,true,true);

          //try to call the lua function for this
          vm.get_global("lerna_tab_created");
          if( vm.is_function(-1) )
          {
            vm.push_lightuserdata(stack);
            vm.push_lightuserdata(child);
            if( 0 != vm.pcall(2,0,0) )
              stderr.printf(@"error running function 'lerna_window_created'\n$(vm.to_string(-1))");
          }
   
        });
        stack.remove.connect(
        (stack, child)=>
        {
          var tab = tabs.get(child);
          tabs.unset(child);
          child.destroy();
          tab.destroy();
        });
    }

    public void start()
    {
        show_all();
        new_btn.start();
    }
}

