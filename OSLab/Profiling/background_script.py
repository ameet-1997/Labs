import os
import matplotlib.pyplot as plt


# The initial parameter set
initial_parameters = set(["cycles","instructions","cache-references","cache-misses","bus-cycles"])

# Get the string representing the parameters
initial_parameter_string = ""
for param in initial_parameters:
	initial_parameter_string += param
	initial_parameter_string += ','
initial_parameter_string = initial_parameter_string[:-1] 	# Remove the last comma

# Create a dictionary with key as parameters
parameter_values = dict.fromkeys(list(initial_parameters))

# Initialize to empty lists
for key in parameter_values.keys():
	parameter_values[key] = []

# Profile the CPU for 5 seconds for basic parameters
how_many_iterations = range(5)
for i in how_many_iterations:
	os.system("sudo perf stat -e "+initial_parameter_string+" -a sleep 2 1>garbage.txt 2>profiled.txt")

	f = open("profiled.txt", "r")
	lines = f.readlines()
	for line in lines:
		temp_line = line.strip().split()
		try:
			if temp_line[1] in initial_parameters: 	# If the parameter is required
				number = temp_line[0]
				number = number.split(',')
				string_number = ""
				for num in number:
					string_number = string_number + num
				number = int(string_number)
				parameter_values[temp_line[1]].append(number)
		except:
			pass


# Plot graphs based on the parameter values
for parameter in parameter_values.keys():
	plt.plot(how_many_iterations, parameter_values[parameter])
	plt.ylabel(parameter)
	plt.xlabel("Iterations")
	plt.show()
