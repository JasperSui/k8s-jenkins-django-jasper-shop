from .config import *

#為了讓這些變數能夠在 templates 裡面使用，所以要用這個 context_processor

def utility(request):

	return {'base_url': base_url}
