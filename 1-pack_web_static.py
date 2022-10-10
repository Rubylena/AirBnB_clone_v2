#!/usr/bin/python3
"""create fabric file"""
from fabric.api import local
import time


def do_pack():
    """script that generates a .tgz archive from
    the contents of the web_static"""

    Tformat = time.strftime("%Y%m%d%H%M%S")
    try:
        local("mkdir -p versions")
        local("tar -cvzf versions/web_static_{:s}.tgz web_static/".
              format(Tformat))
        return ("versions/web_static_{:s}.tgz".format(Tformat))
    except RuntimeError:
        return None
