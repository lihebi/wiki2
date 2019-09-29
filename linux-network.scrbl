#lang scribble/manual

@title{Network}

@literal{ifconfig} is in @literal{net-tools} package, and is
deprecated. Use @literal{ip} instead:

@verbatim{
ip addr show <dev>
ip link # show links
ip link show <dev>
}

