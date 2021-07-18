import threading
from background import handwrite_background


def on_starting(server):
    t = threading.Thread(target=handwrite_background, args=(True,))
    t.start()
