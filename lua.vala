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

//utility function to push gtk objects on
//the lua stack in a lua friendly form
bool push_lgi(LuaVM L, string type, Object object)
{
  //try to call the lua function for this
  L.get_global("Gtk");
  //gtk
  stack_dump(L);
  if( false == L.is_table(-1) )
  { L.pop(1); return false; }

  //good, we have access to our entry point and to gtk
  L.push_string(type);
  L.get_table(-2);
  //gtk,type

  if(false == L.is_table(-1))
  { L.pop(2); return false; }

  L.push_string("_new");
  L.get_table(-2); 
  //gtk,type,_new
  if(false == L.is_function(-1))
  { L.pop(3); return false; }

  L.push_value(-2);
  //gtk,type,_new,type
  L.remove(-3);
  L.remove(-3);
  //_new,type

  L.push_lightuserdata(object);
  //_new,window,object
  if( 0 != L.pcall(2,1,0) )
  {
    stderr.printf(@"error running function 'Gtk.$type'\n$(L.to_string(-1))\n");
    return false;
  }
    //object
    return true;
}

//cribbed from programming in lua
static void stack_dump (LuaVM L)
{
  int i;
  int top = L.get_top();
  for (i = 1; i <= top; i++)
  {  /* repeat for each level */
    Lua.Type t = L.type(i);
    switch (t)
    {
      case Lua.Type.STRING:  /* strings */
        stdout.printf("`%s'", L.to_string(i));
        break;
      case Lua.Type.BOOLEAN:  /* booleans */
        stdout.printf(L.to_boolean(i) ? "true" : "false");
        break;
      case Lua.Type.NUMBER:  /* numbers */
        stdout.printf("%g", L.to_number(i));
        break;
      default:  /* other values */
        stdout.printf("%s", L.type_name(t));
        break;
    }
    stdout.printf("  ");  /* put a separator */
  }
  stdout.printf("\n");  /* end the listing */
}
