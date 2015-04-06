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


/*

Flat buttons are generally bad UI design in my opinion.

Regular GTK+ buttons take up a ton of screen real estate.

This program is meant to be no more difficult to use than necessary.

It should also be keyboard friendly and take up very little screen
real estate.

This is the compromise: flat buttons are evil but these buttons still help
out those who aren't born magically knowing keyboard shortcuts while
taking up less screen real estate.

*/

using Gtk;
using Pango;

public class LernaButton : EventBox
{
    /* expose the label that displays the text to everything */
    public Label label;

    public signal void clicked();

    public LernaButton(string? str)
    {
        label = new Label(str);
        label.justify = Justification.CENTER;
    }

    public void start()
    {
        /* pack the child widgets */
        add(label);

        /* connect signals */
        button_press_event.connect((source, event)=>
        {
          clicked();
          return false;
        });

        /* show all the children */
        show_all();
    }
}
