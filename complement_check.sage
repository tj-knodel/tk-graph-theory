## Read in a graph as a string, then show it
from sage.graphs.graph_input import from_graph6
from os import listdir
# why do we need regex? to needlessly complicate things, of course!
import re

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

# check a file of graph6 graphs and determine which ones do not have the given subgraph
def check_file(file, sg):
    # open the file
    f = open(file)
    
    graph_list = []
    
    # read a line
    with open(file) as f:
        for line in f:
            #print(line)
            # I feel like this is wrong, but so be it
            if (line == "\n"):
                continue
            
            # create a graph out of a graph6 line
            g = Graph(line)
            # check the graph for graphs without sg and add them to the list
            if (g.subgraph_search(sg, induced=True) is None):
                #print("look at these good vertices")
                #print(g)
                graph_list.append(g)

    print("Number of graphs: " + str(len(graph_list)))
    return graph_list

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
