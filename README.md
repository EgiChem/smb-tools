# smb-tools

Collection of tools and scripts to manage SMB unit operation.


## Examples

Check the [examples.mlx](examples.mlx) file for details


## Main tools

### `process_1col_log`

Process chromatogram data from SMB unit log file. Creates pressure and absorbance plots.

Usage:

```
>> process_1col_log('sample-files/chrom_DHAEE_EPAEE_0_4_C18.txt')
```

Specifying that pump 1 and detector 2 are in use:

```
>> process_1col_log('sample-files/chrom_DHAEE_EPAEE_0_4_C18.txt', 1, 2)
```


### `process_log`

Process chromatogram data from SMB unit log file. Creates flow-rate, pressure and absorbance plots for all pumps and detector.

Usage: Input the log file path (including extension) in the `filepath` variable.



### `createRun`

Prepare for a SMB run. This script:
- calculates flowrates by mass balance for a classic 4-zone SMB. 
- provides values for EgiChem SMB unit pumps P1 - P4 and MFC (Coriolis).
- generates a recipe file from the calculated flowrates