#!/bin/bash

# MIT License
# Copyright (c) 2020 Gökhan Koçak
# www.gokhankocak.com

multipass launch -m 2G -d 16G -n master
multipass transfer Micro.sh master:/tmp
multipass exec master /bin/bash /tmp/Micro.sh
multipass exec master git clone https://github.com/gokhankocak/kubernetes-egitim.git
multipass exec master chmod +x kubernetes-egitim/betik/Kube.sh
multipass exec master chmod +x kubernetes-egitim/betik/OnPanel.sh

multipass launch -m 2G -d 16G -n node1
multipass transfer Micro.sh node1:/tmp
multipass exec node1 /bin/bash /tmp/Micro.sh

multipass launch -m 2G -d 16G -n node2
multipass transfer Micro.sh node2:/tmp
multipass exec node2 /bin/bash /tmp/Micro.sh

