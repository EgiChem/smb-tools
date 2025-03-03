# smb-tools

Collection of tools and scripts to manage SMB unit operation.


## Examples

- [examples_solvents.mlx](examples_solvents.mlx) for solvent properties, pressure drops calculations;
- [examples_flowrates.mlx](examples_flowrates.mlx) for SMB flowrate calculations;
- [examples_triangleTheory.mlx](examples_triangleTheory.mlx) for the Triangle Theory;
- [examples_utils.mlx](examples_utils.mlx) for examples as some utilities.


## Main scripts

### `experimental.process_1col_log`

Process chromatogram data from SMB unit log file. Creates pressure and absorbance plots.

Usage:

```
>> process_1col_log('sample-files/chrom_DHAEE_EPAEE_0_4_C18.txt')
```

Specifying that pump 1 and detector 2 are in use:

```
>> process_1col_log('sample-files/chrom_DHAEE_EPAEE_0_4_C18.txt', 1, 2)
```


### `experimental.process_log`

Process chromatogram data from SMB unit log file. Creates flow-rate, pressure and absorbance plots for all pumps and detector.

Usage: Input the log file path (including extension) in the `filepath` variable.


### `experimental.process_Bronkhorst`

Process Bronkhorst Flow Suite log file and create flow rate plots.

Usage: Input the log file path (including extension) in the `datafiles` variable.


### `createRun`

Prepare for a SMB run. This script:
- calculates flowrates by mass balance for a classic 4-zone SMB. 
- provides values for EgiChem SMB unit pumps P1 - P4 and MFC (Coriolis).
- generates a recipe file from the calculated flowrates
