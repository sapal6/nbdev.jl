### A Nbdev script file ###
### Autogenerated file. Don't modify. ###

module CodeRunner
#export
import Pluto: Notebook, Cell, Configuration, Notebook, ServerSession, ClientSession, update_run!, Cell, WorkspaceManager

#export
import Pluto.PlutoRunner

#export
function execute_code(notebook::Notebook)
	fakeserver=ServerSession()
	fakeclient = ClientSession(:fake, nothing)
	fakeserver.connected_clients[fakeclient.id] = fakeclient
	
	fakeclient.connected_notebook = notebook
	
	update_run!(fakeserver, notebook, notebook.cells)
	notebook
end

end