# smb-tools

Collection of tools and scripts to manage SMB unit operation.

## `process_1col_log`

Process chromatogram data from SMB unit log file. Creates pressure and absorbance plots.

Usage:

```
>> process_1col_log('sample-files/chrom_DHAEE_EPAEE_0_4_C18.txt')
```

Specifying that pump 1 and detector 2 are in use:

```
>> process_1col_log('sample-files/chrom_DHAEE_EPAEE_0_4_C18.txt', 1, 2)
```


## `process_log`

Process chromatogram data from SMB unit log file. Creates flow-rate, pressure and absorbance plots for all pumps and detector.

Usage: Input the log file path (including extension) in the `filepath` variable.


## `flowRatesSMB`

Given eluent, feed, extract and zone I flow-rates, calculate all remaining classic SMB flow-rates.


## `createRecipe`

Create a SMB recipe file to use in the SMB control program..