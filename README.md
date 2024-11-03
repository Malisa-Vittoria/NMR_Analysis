# NMR_Analysis
Signal intensity analysis of NMR data to detect protein residues that bind to an added ligand in a NMR titration experiment 
This collection of scripts (2x) is designed to first clean and prepare the residue peaklist from CCPN analysis version 2 (NMR_Clean_PeakList.sh), then to perform subsequent signal intensity analysis to obtain protein specific residues that bind to the titrated ligand (NMR_Signal_Intensity_Analysis_2020). 
It performs the following tasks:
1. Extracts relevant data: Extracts the intensity and residue number from the input peaklist files.
2. Calculates intensity ratios: Computes the ratio of intensities between the bound and free states of the protein and estimates the intensity uncertainty by means of the Gaussian error propagation calculation
3. Normalizes intensity ratios: Normalizes the intensity ratios by dividing them by the maximum value.
4. Writes output: Writes the normalized intensity ratios and corresponding residue numbers to an output file.
