from notebook.auth import passwd
import os

# Set options for ip, password, and toggle off browser auto-opening
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.base_url = '/'
c.NotebookApp.notebook_dir = os.environ.get('NOTEBOOK_FOLDER', '/root/notebooks')

password = os.environ.get('PASSWORD')
if password:
    c.NotebookApp.password = passwd(password)
else:
    c.NotebookApp.password = ''

