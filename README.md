# XNAT2BIDS
###### We are not the authors of converting software we use in our script - all credit goes to Rordenlab: [dcm2niix by Rordenlab](https://github.com/rordenlab/dcm2niix)

Simple xnat pipeline to convert DICOM scans to BIDS-compatible output (nii+json). 


### Prerequisities

Just make sure you have zip tool installed on your machine.

### Installing

Import it like a regular pipeline:

* Place files from the repo in your in:

```
/your/path/to/pipeline/catalog/bids2
```

* Go to Administration->pipelines->add pipeline to repository,
* Enter same path as in the step above + XNAT2bids.xml,
* Add pipeline to your project,
* You are good to go!

### Usage

Pipeline needs to run for each session individually.

It lets the user choose series that should be included in bids package or specify custom subject label. Leaving the last field empty sets the subject label sam as in XNAT. The `sub-label_ses-session_run-run_mod` are generated automatically from protocol name and other information stored in XNAT DB. Since task-labels aren't stored in DICOM headers by default, we encourage to check the data and fill this field properly.

After creating proper directory hierarchy it zips data and sends it to subject resources. If there were any scans that aren't recognized they will be placed in `unassigned` folder inside of the bids package.

## Authors

* **Kamil Lipinski** - [kamillipi](https://github.com/kamillipi)
* **Adam Kaczor** - [AdamKaczor](https://github.com/AdamKaczor)

Created during 2nd Coding Sprint at Stanford Center for Reproducible Neuroscience, September 2017.

## Learn more
* **XNAT** - [xnat.org](https://xnat.org)
* **BIDS** - [BIDS](http://bids.neuroimaging.io/)

[![picture alt](http://www.ire.pw.edu.pl/mambo/templates/akoautumnfog/images/logo-top-left.png "Institute of Radioelectronics an Multimedia Technology")![picture alt](http://www.ire.pw.edu.pl/mambo/templates/akoautumnfog/images/logo-top-right-en.png "Institute of Radioelectronics an Multimedia Technology")](http://www.ire.pw.edu.pl/)

[![picture alt](http://ibib.waw.pl/images/ibib/admin_files/logo_ibib/logo_ibib_01_EN.png "Institute of Biocybernetics and Biomedical Engineering")](http://ibib.waw.pl)




