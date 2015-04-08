# Copyright 2015 Jon "ylixir" Allen
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
VC=valac
CC=gcc
CFLAGS=`pkg-config --cflags --libs gtk+-3.0 webkit2gtk-4.0 gee-1.0 lua` -include lauxlib.h
VFLAGS=--pkg gtk+-3.0 --pkg webkit2gtk-4.0 --pkg gee-1.0 --pkg lua 
VSOURCES=main.vala window.vala page.vala tabstrip.vala button.vala tab.vala lua.vala
VCFILES=$(VSOURCES:%.vala=%.c)
VAPIFILES=$(VSOURCES:%.vala=%.vapi)
VOBJECTS=$(VSOURCES:%.vala=%.o)

TARGET=lerna

all: $(VSOURCES) $(TARGET)

$(TARGET): $(VOBJECTS) $(VCFILES) $(VAPIFILES)
	$(CC) $(CFLAGS) $(VOBJECTS) -o $(TARGET)

%.vapi : %.vala
	$(VC) $(VFLAGS) --fast-vapi=$@ $<

%.c : %.vala $(VAPIFILES)
	$(VC) $(VFLAGS) -C $(addprefix --use-fast-vapi=,$(subst $(basename $@).vapi,, $(VAPIFILES))) $<

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(VOBJECTS) $(VCFILES) $(VAPIFILES) $(TARGET)
