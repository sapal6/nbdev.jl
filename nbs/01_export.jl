### A Pluto.jl notebook ###
# v0.14.4

using Markdown
using InteractiveUtils

# ╔═╡ 5b4e526e-3dfa-11eb-3472-bd753d60c119
#hide
include("../src/documenter.jl")

# ╔═╡ 486bb5f0-54be-11eb-0e7c-1dcf55b5f983
md"The Export module helps in exporting the code to script files."

# ╔═╡ 0aecd4c0-0e14-11eb-1619-4f5e0ced1279
#export
import Pluto: Notebook, Cell, load_notebook_nobackup

# ╔═╡ d2a442c0-0eb2-11eb-1ea8-d507d9145823
#export
function processMdChunk(mdChunk::String)
	chopMdMarker(mdChunk)
end

# ╔═╡ 2181580b-7f3e-456f-aa62-68130d9b9178
load_notebook_nobackup("./01_export.jl")

# ╔═╡ 6ff1ad80-1479-11eb-3868-0df000f47cc9
md"## Lower Level Entities(Structs, methods etc.) 

These are the objects on which nbdev's Export module was built. You can use it to extend nbdev but these are automtically used by Nbdev's internal engine to generate code files for you."

# ╔═╡ 16fbf5b0-54bf-11eb-3c21-2bf024188fac
md"#### Nucleus type"

# ╔═╡ a5bfff40-1620-11eb-2824-2d49985a022d
#export
begin
"""
> struct Nucleus--> This is the lowest entity of a code notebook. This type represents the code cell in a Pluto notebook.
> * Fields:
>   * code--> String which makes up a code cell
"""
Base.@kwdef mutable struct Nucleus
	code::String=""
	end

"""
> Nucleus(code)-->Getter for accessing the constructer of the Nucleus type
"""
Nucleus(code) = Nucleus(code = code)
end

# ╔═╡ ad64c040-54bf-11eb-2c3d-ff1de3c15f3f
Documenter.showDoc(Nucleus)

# ╔═╡ 1d983360-54c0-11eb-0104-672aaffbbb95
md"Every time a code cell is parsed, it gets stored as a Nucleus type. The stored code can then be accessed using the `code` field in the Nucleus type."

# ╔═╡ cc7be350-54bf-11eb-2107-335896e7fbf3
md"#### Example"

# ╔═╡ d38222e0-54bf-11eb-309a-2722b3e78bbc
sample_code="a=1+1"

# ╔═╡ f1eadd80-54bf-11eb-1de4-ef2da2e36eda
nucleus=Nucleus(sample_code)

# ╔═╡ 0361d7d0-54c0-11eb-0a50-79dc00a9d848
nucleus.code

# ╔═╡ d236da00-54c6-11eb-3afe-859ccc31d041
md"#### Nb type"

# ╔═╡ d17ebf90-1486-11eb-0d41-b967a8ab82ba
#export
begin
"""
> struct Nb--> a notebook having nuclei made up of code cells only.
> * Fields:
>   * nuclei--> Array of Nucleus type
>   * name--> name of notebook
"""
mutable struct Nb
	nuclei::Array{Nucleus,1}
	name::AbstractString
end

"""
> nuclei(nuclei::Array)--> Helper to collect an array of Nucleus.	
"""
nuclei(nuclei::Array) = nuclei

"""
> nuclei(nuclei::Array)--> Helper to collect an name of a notebook.
"""
name(name::AbstractString) = name
end

# ╔═╡ 117932c0-54c8-11eb-158c-5be86ba8fd19
Documenter.showDoc(Nb)

# ╔═╡ 65163a40-54c8-11eb-3384-61a1dce37c10
Documenter.showDoc(nuclei)

# ╔═╡ 6d8afdf0-54c8-11eb-27e5-d59d375bd9eb
Documenter.showDoc(name)

# ╔═╡ 93dc68e0-54c8-11eb-0b28-eb809c1f15a6
md"A Nb type is used to collect all code cells(which are contained in the Nucleus type. These code cells are actual code represented as string."

# ╔═╡ 772778c0-54c8-11eb-3b23-01d2dc0c5dc0
md"#### Example"

# ╔═╡ 8e253e90-54c8-11eb-3456-97a428b1f232
samplecodes=[Nucleus("a=1+1"), Nucleus("function test(x)  x+1 end"), Nucleus("test(2)")]

# ╔═╡ 020a9620-54c9-11eb-107e-c107354dc90a
nb=Nb(samplecodes, "testnb.jl")

# ╔═╡ cf50547e-54c9-11eb-132d-894c0cfe9ccc
nb.nuclei

# ╔═╡ 99fd66a0-54ca-11eb-3d11-d92049fd2f6a
nb.name

# ╔═╡ 296282f0-1770-11eb-0900-b37a94fbc69c
#export
begin
"""
Headers that would appear in a code file
"""
const _header = "### A Nbdev script file ###"
const _sub_header = "### Autogenerated file. Don't modify. ###"
end

# ╔═╡ 2a36f0b0-54cb-11eb-1b53-0998e776d5a5
md"`collect_nuclei(notebook::ScrubbedNotebook, marker)` reads the entire notebook cell by cell and then checks if the content of that cell starts with a marker, only then it builds an array of the Nucleus type. "

# ╔═╡ 773b9da0-2fd4-11eb-1c65-a10ea8672725
#export
"""
This had to be done because having the cell iddelimeter as a constant gives an error during parsing the notebook
"""
cell_id_delimiter=string("#"," ╔═╡ ")

# ╔═╡ 6bfde500-2fcb-11eb-2b73-7ddce97351d3
#export
"""
marks the end of a cell
"""
const _cell_suffix = "\n\n"

# ╔═╡ 0561b9f0-54d5-11eb-01f0-8bde739e3e37
md"#### load_scrubbed_nb"

# ╔═╡ 512e7b20-54d5-11eb-3ff9-b150bf2f9e26
md"`load_scrubbed_nb` reads the notebook in the given path cell by cell, while ignoring the stuffs in the notebook like the cell order delimeters and the cell start delimeter. The result is a `ScrubbedNotebook` type which contains only the code which you intend to export."

# ╔═╡ 12377150-54d6-11eb-18ff-ef441154f771
md"## High Level APIs

This too are called automaticallyby Nbdev."

# ╔═╡ c71b1460-54d5-11eb-3e6b-cb3dadbc0349
md"#### load_nb"

# ╔═╡ 8b7e8030-54d6-11eb-2f48-d3bc02e21c96
md"#### ScrubbedNotebook"

# ╔═╡ 20c285d0-2fb4-11eb-1ef0-3b28829af7e8
#export
"""
> struct ScrubbedNotebook--> Represents a notebook from which all but code to be exported are scrubbed off.
> * Fields-->
>   * cells--> Vector of strings.
"""
mutable struct ScrubbedNotebook
	cells::Array{String, 1}
end

# ╔═╡ d4daaac0-0eb2-11eb-1d4d-7763fcfc0ed2
#export
"""
> collect_nuclei(notebook::ScrubbedNotebook, marker)--> Reads a notebook, collects code from code cells and returns an array of Nucelus.
"""
function collect_nuclei(notebook::ScrubbedNotebook, marker)
	notebook_cells=notebook.cells
	nuclei=[]
		
    for i in 1:length(notebook_cells)
    	raw_code=notebook_cells[i]
    	nucleus=Nucleus(raw_code)
    	
    	if startswith(raw_code, marker)
            push!(nuclei,nucleus)
        end
    	
    end
	 nuclei
end

# ╔═╡ f3cd62b0-54cb-11eb-0419-ab20ac4b8c14
Documenter.showDoc(collect_nuclei)

# ╔═╡ 4d1217b0-2fcb-11eb-0e90-75867c5e4cb2
#export
begin
"""
>load_scrubbed_nb--> These are modification of the Pluto.load_notebook methods. Scrubs the notebook of all stuff but the code to be exported.
"""
function load_scrubbed_nb(io, path)::ScrubbedNotebook
    collected_cells = []
		
	# ignore first bits of file
    readuntil(io,cell_id_delimiter)

    last_read = ""
    while !eof(io)
        cell_id_str = String(readline(io))
        if cell_id_str == "Cell order:"
            break
        else
            code_raw = String(readuntil(io, cell_id_delimiter))
            # change Windows line endings to Linux
            code_normalised = replace(code_raw, "\r\n" => "\n")
            # remove the cell appendix
            code = code_normalised[1:prevind(code_normalised, end, length(_cell_suffix))]

            read_cell = code
            push!(collected_cells, read_cell)
        end
    end
		
	ScrubbedNotebook(collected_cells)
end
	
function load_scrubbed_nb(path::String)::ScrubbedNotebook
    local loaded
    open(path, "r") do io
        loaded = load_scrubbed_nb(io, path)
    end
    loaded
end
end

# ╔═╡ 3500e370-54d5-11eb-1944-c9b82c127615
Documenter.showDoc(load_scrubbed_nb)

# ╔═╡ 0b0aaa7e-2fd5-11eb-3b82-9165d56b4f63
#export
begin
"""
> load_nb(filename::String, marker::String)--> High level function which calls _load_nb
"""
load_nb(filename::String, marker::String) = _load_nb(filename, marker)

"""
> _load_nb(filename::String, marker::String)--> creates a scrubbednotebook and returns a curated Nb type having code to be exported.
"""
function _load_nb(filename::String, marker::String)
		#notebook=load_notebook_nobackup(filename)
		scrubbedNotebook=load_scrubbed_nb(filename)
		collected_nuclei=nuclei(collect_nuclei(scrubbedNotebook, marker))
		
		#if marker=="md"
		#	notebook
		#else
		Nb(collected_nuclei, filename)
		#end
end

end

# ╔═╡ 5463e720-54d6-11eb-2ffd-7922b7a75131
Documenter.showDoc(load_nb)

# ╔═╡ 7d58fad2-54d6-11eb-0297-d350524a3101
Documenter.showDoc(_load_nb)

# ╔═╡ d13f9ca0-1758-11eb-143b-29bccf950cae
testnb= load_nb("01_export.jl", "#export")

# ╔═╡ e229a820-1777-11eb-37c5-c108ab5f7110
testnb.nuclei[1].code

# ╔═╡ 54f54160-176f-11eb-0317-3542cb72f89f
md"something to save files"

# ╔═╡ 35a01900-1771-11eb-01a7-39297caf95fd
#hide
k="01_export.jl"

# ╔═╡ 16a58460-54d7-11eb-1f6a-97f11bc07049
md"#### strip"

# ╔═╡ 4c511e5e-1771-11eb-3c8e-5785e7399d70
#export
"""
> strip --> Helper fucntion to replace a substring y in a string x with blank.
"""
strip=(x::String,y) -> replace(x, y=>"")

# ╔═╡ 55ed2102-597d-11eb-342c-b589f4681bdd
#hide
@doc strip

# ╔═╡ 526b7d10-54d7-11eb-20f1-5d26e020ff16
md"#### Example"

# ╔═╡ 7b999f90-1775-11eb-031e-69d461ec4150
"module $(uppercasefirst(strip(strip(k, r"[0-9_]"), r".jl")))"

# ╔═╡ 76f97bd0-177b-11eb-2d78-77c72b2aef81
md"To export the required code, the following scenarios must be considered.

👉 Check if the file is in the src directory. If it's there then overwrite it. 


👉 If it's not there then create and then write."

# ╔═╡ 6069d790-176f-11eb-3020-41b450d430ad
#export
begin
"""
> save_nb(io, notebook)--> Reads the supplied notebook and creates an io and writes stuffs like the module name and the content to the created io.
"""
function save_nb(io, notebook)
    println(io, _header)
    println(io, _sub_header)
    println(io, "")
    println(io, "module $(uppercasefirst(strip(strip(notebook.name, r"[0-9_]"), r".jl")))")
	for nucleus in notebook.nuclei
			println(io, nucleus.code*"\n")
    end
	#notebook
	print(io, "end")	
end

"""
> save_nb(notebook::Nb, path::String)--> Creates a file in the supplied path with the name in the NB type.
"""
function save_nb(notebook::Nb, path::String)
	file_name=uppercasefirst(strip(notebook.name, r"[0-9_]"))
	open(joinpath(path, file_name), "w") do io
        save_nb(io, notebook)
    end
end
end

# ╔═╡ d096aed0-54d7-11eb-31fc-b19801db8851
Documenter.showDoc(save_nb)

# ╔═╡ dc1cd130-54d7-11eb-223f-e724e43a535c
md"#### Example"

# ╔═╡ cdd23fa0-1776-11eb-2343-a570b848c87e
save_nb(testnb, "../testpath")

# ╔═╡ b9a15e60-0e13-11eb-199d-f50a49f5bc44
md"We will read files in the current path which should be the /nbs folder in your project. This will host all your notebooks"

# ╔═╡ f7f0d72e-54d7-11eb-1b8a-b3689e09598b
md"#### readfilenames"

# ╔═╡ cdada98e-0e13-11eb-30aa-1777efffb181
#export
begin
"""
> readfilenames()--> Reads files in the directory and subdirectories in the current path. Reads only the files with ".jl" extension
"""
function readfilenames()
	files=[]
	for file in readdir()
			if endswith(file, ".jl")
				push!(files,file)
			end
			#if getfile_extension(file)== ".jl"
			#	push!(files,file)
			#end
	end
	files
end

function readfilenames(dir::String)
	files=[]
	for file in readdir(dir)
			if endswith(file, ".jl")
				push!(files,file)
			end
			#if getfile_extension(file)== ".jl"
			#	push!(files,file)
			#end
	end
	files
end
end

# ╔═╡ 37ffeb40-54d8-11eb-0c8a-af262b2bec28
Documenter.showDoc(readfilenames)

# ╔═╡ 4259e9b0-54d8-11eb-3768-85ede85ab315
md"#### Example"

# ╔═╡ 9b436180-177c-11eb-1c9a-ffbac62c95df
readfilenames()

# ╔═╡ 528689b0-54d8-11eb-35f4-2b56012fa4e6
md"#### export_file"

# ╔═╡ 0be54350-177c-11eb-285a-93dd4d45e40e
#export
"""
> export_file(file::String, path::String, marker::String)--> Loads the file in the supplied path and reads the cells which are marked with "#export". Then saves the notebook in the given path
"""
function export_file(file::String, path::String, marker::String)
	notebook=load_nb(file, "#export")
	save_nb(notebook, path)
end

# ╔═╡ a89665f0-54d8-11eb-1e5a-fd409b238ce1
Documenter.showDoc(export_file)

# ╔═╡ 41d65310-0e11-11eb-1a36-87dc9ac941fa
#export
"""
> export_content(files::AbstractVector, path::String, marker::String)--> maps the `export_file` function to each files in the files vector
"""
function export_content(files::AbstractVector, path::String, marker::String)
	map(file->export_file(file, path, marker), files)
end

# ╔═╡ 1b57d6f0-54d9-11eb-0a0a-db4b2959750b
Documenter.showDoc(export_content)

# ╔═╡ 23e775a0-54d9-11eb-0106-431100572909
md"#### getfile_extension"

# ╔═╡ 01608690-0e14-11eb-3faa-9b960f57f3fe
#export
"""
> getfile_extension(filename)--> get the file extensions in the pwd
"""
function getfile_extension(filename)
    return filename[findlast(isequal('.'),filename):end]
end

# ╔═╡ 3b2578c0-54d9-11eb-00a0-595ad6034cfa
Documenter.showDoc(getfile_extension)

# ╔═╡ 44fa41a0-54d9-11eb-1cc1-bf7ce7d30abf
md"#### Example"

# ╔═╡ 06649ce0-177d-11eb-2092-d7160725252a
 getfile_extension("test.jl")

# ╔═╡ 4de0d9f0-54d9-11eb-38c6-3de69a7ec1db
md"#### notebook2script"

# ╔═╡ b34f9d82-0ede-11eb-0f08-afa0cc898e80
#export
"""
> notebook2script()--> Export all the code to the ../src path of the project
"""
function notebook2script()
	export_content(readfilenames(), "../src", "#export")
end

# ╔═╡ 730bc63e-54d9-11eb-1489-39a31e9b0deb
Documenter.showDoc(notebook2script)

# ╔═╡ 7a9391e0-54d9-11eb-14f1-7f8e10036a1a
md"`notebook2script` can be called from anotebook which you intend to export. Usually in the last cell of that notebook"

# ╔═╡ baf3f1d0-0ede-11eb-2c02-1f53ed1a6cd7
notebook2script()

# ╔═╡ Cell order:
# ╠═486bb5f0-54be-11eb-0e7c-1dcf55b5f983
# ╠═5b4e526e-3dfa-11eb-3472-bd753d60c119
# ╠═0aecd4c0-0e14-11eb-1619-4f5e0ced1279
# ╠═d2a442c0-0eb2-11eb-1ea8-d507d9145823
# ╠═2181580b-7f3e-456f-aa62-68130d9b9178
# ╠═6ff1ad80-1479-11eb-3868-0df000f47cc9
# ╠═16fbf5b0-54bf-11eb-3c21-2bf024188fac
# ╠═a5bfff40-1620-11eb-2824-2d49985a022d
# ╠═ad64c040-54bf-11eb-2c3d-ff1de3c15f3f
# ╠═1d983360-54c0-11eb-0104-672aaffbbb95
# ╠═cc7be350-54bf-11eb-2107-335896e7fbf3
# ╠═d38222e0-54bf-11eb-309a-2722b3e78bbc
# ╠═f1eadd80-54bf-11eb-1de4-ef2da2e36eda
# ╠═0361d7d0-54c0-11eb-0a50-79dc00a9d848
# ╠═d236da00-54c6-11eb-3afe-859ccc31d041
# ╠═d17ebf90-1486-11eb-0d41-b967a8ab82ba
# ╠═117932c0-54c8-11eb-158c-5be86ba8fd19
# ╠═65163a40-54c8-11eb-3384-61a1dce37c10
# ╠═6d8afdf0-54c8-11eb-27e5-d59d375bd9eb
# ╠═93dc68e0-54c8-11eb-0b28-eb809c1f15a6
# ╠═772778c0-54c8-11eb-3b23-01d2dc0c5dc0
# ╠═8e253e90-54c8-11eb-3456-97a428b1f232
# ╠═020a9620-54c9-11eb-107e-c107354dc90a
# ╠═cf50547e-54c9-11eb-132d-894c0cfe9ccc
# ╠═99fd66a0-54ca-11eb-3d11-d92049fd2f6a
# ╠═296282f0-1770-11eb-0900-b37a94fbc69c
# ╠═d4daaac0-0eb2-11eb-1d4d-7763fcfc0ed2
# ╠═f3cd62b0-54cb-11eb-0419-ab20ac4b8c14
# ╠═2a36f0b0-54cb-11eb-1b53-0998e776d5a5
# ╠═773b9da0-2fd4-11eb-1c65-a10ea8672725
# ╠═6bfde500-2fcb-11eb-2b73-7ddce97351d3
# ╠═0561b9f0-54d5-11eb-01f0-8bde739e3e37
# ╠═4d1217b0-2fcb-11eb-0e90-75867c5e4cb2
# ╠═3500e370-54d5-11eb-1944-c9b82c127615
# ╠═512e7b20-54d5-11eb-3ff9-b150bf2f9e26
# ╠═12377150-54d6-11eb-18ff-ef441154f771
# ╠═c71b1460-54d5-11eb-3e6b-cb3dadbc0349
# ╠═0b0aaa7e-2fd5-11eb-3b82-9165d56b4f63
# ╠═5463e720-54d6-11eb-2ffd-7922b7a75131
# ╠═7d58fad2-54d6-11eb-0297-d350524a3101
# ╠═8b7e8030-54d6-11eb-2f48-d3bc02e21c96
# ╠═20c285d0-2fb4-11eb-1ef0-3b28829af7e8
# ╠═d13f9ca0-1758-11eb-143b-29bccf950cae
# ╠═e229a820-1777-11eb-37c5-c108ab5f7110
# ╟─54f54160-176f-11eb-0317-3542cb72f89f
# ╠═35a01900-1771-11eb-01a7-39297caf95fd
# ╠═16a58460-54d7-11eb-1f6a-97f11bc07049
# ╠═4c511e5e-1771-11eb-3c8e-5785e7399d70
# ╠═55ed2102-597d-11eb-342c-b589f4681bdd
# ╠═526b7d10-54d7-11eb-20f1-5d26e020ff16
# ╠═7b999f90-1775-11eb-031e-69d461ec4150
# ╟─76f97bd0-177b-11eb-2d78-77c72b2aef81
# ╠═6069d790-176f-11eb-3020-41b450d430ad
# ╠═d096aed0-54d7-11eb-31fc-b19801db8851
# ╠═dc1cd130-54d7-11eb-223f-e724e43a535c
# ╠═cdd23fa0-1776-11eb-2343-a570b848c87e
# ╠═b9a15e60-0e13-11eb-199d-f50a49f5bc44
# ╠═f7f0d72e-54d7-11eb-1b8a-b3689e09598b
# ╠═cdada98e-0e13-11eb-30aa-1777efffb181
# ╠═37ffeb40-54d8-11eb-0c8a-af262b2bec28
# ╠═4259e9b0-54d8-11eb-3768-85ede85ab315
# ╠═9b436180-177c-11eb-1c9a-ffbac62c95df
# ╠═528689b0-54d8-11eb-35f4-2b56012fa4e6
# ╠═0be54350-177c-11eb-285a-93dd4d45e40e
# ╠═a89665f0-54d8-11eb-1e5a-fd409b238ce1
# ╠═41d65310-0e11-11eb-1a36-87dc9ac941fa
# ╠═1b57d6f0-54d9-11eb-0a0a-db4b2959750b
# ╠═23e775a0-54d9-11eb-0106-431100572909
# ╠═01608690-0e14-11eb-3faa-9b960f57f3fe
# ╠═3b2578c0-54d9-11eb-00a0-595ad6034cfa
# ╠═44fa41a0-54d9-11eb-1cc1-bf7ce7d30abf
# ╠═06649ce0-177d-11eb-2092-d7160725252a
# ╠═4de0d9f0-54d9-11eb-38c6-3de69a7ec1db
# ╠═b34f9d82-0ede-11eb-0f08-afa0cc898e80
# ╠═730bc63e-54d9-11eb-1489-39a31e9b0deb
# ╠═7a9391e0-54d9-11eb-14f1-7f8e10036a1a
# ╠═baf3f1d0-0ede-11eb-2c02-1f53ed1a6cd7
