## Read in a graph as a string, then show it
from sage.graphs.graph_input import from_graph6
from sage.graphs.graph_coloring import vertex_coloring
from os import listdir
# why do we need regex? to needlessly complicate things, of course!
import re
import sys


# path to the graph files
FILE_PATH = "./P3P1free_critical-main"
OUT_PATH = "./2P2_P3P1free"

# generate a 2P2 graph
def generate_2p2():
    g = graphs.EmptyGraph()
    # Now we add the vertices and edges
    g.add_vertices([1, 2, 3, 4])
    g.add_edges([(1,2), (3,4)], loops=False)
    return g

# set it as a variable for later
twoP = generate_2p2()

# check a graph
def check_graph(g, k):
    comp = g.complement()
    if comp.is_connected() is False:
        return False
    if critical_check(comp, k):
        return True
    return False

# check if a graph is k vertex critical for a given k
# from the summer
def critical_check(G, k):
    V = G.vertices()
    chi = G.chromatic_number()
    if (chi != k):
        return False

    for v in V:
        # creates local copy of G so we can delete vertices and maintain G's structure
        H = Graph(G)
        H.delete_vertex(v)
        if vertex_coloring(H, k=k-1, value_only=True) == False:
            return False
    return True

# check a file of graph6 graphs and determine which ones are k critical
def check_file(file_name, k):
    # open the file

    
    o = open(file_name + "output.g6", "w")
    
    # read a line
    with open(file_name) as f:
        for line in f:
            #print(line)
            # I feel like this is wrong, but so be it
            if (line == "\n"):
                continue

            g = Graph(line)
            # check the graph for graphs without sg and add them to the list
            if (check_graph(g, k)):
                o.write(g.compliment().graph6_string() + "\n")

# extract the graph6 files from the selected directory
# note: it only picks up things with txt files on the end. Will have to
#       to pick up if there are g6 files
def get_graph6_files(dir_path):
    file_list = listdir(dir_path)
    out_list = []
    for file in file_list:
        match = re.search(r"\.*\.txt", file)
        #print(match)
        if match is not None:
            out_list.append(match.string)
    return out_list

# check the whole directory for the subgraph
def check_directory(dir_path, sg):
    file_list = get_graph6_files(dir_path)
    print(file_list)
    for file in file_list:
        print("Checking file: " + file)
        print(check_file(dir_path + "/" + file, sg))
    return

#check_file(FILE, twoP)

# get command line input for which file to check
# also check to see if we get input
if len(sys.argv) <= 1:
	print("Usage: sage complement_check [k] [file ...]")
	sys.exit()

k = int(sys.argv[1])
for f in sys.argv[2:]:
    check_file(f, k)
    print("Done checking " + f)
print("Done")
