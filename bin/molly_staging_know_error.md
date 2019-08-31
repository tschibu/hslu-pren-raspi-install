# Fehler:

```
    gcc -pthread -Wno-unused-result -Wsign-compare -DNDEBUG -g -fwrapv -O3 -Wall -fPIC -DH5_USE_16_API -I./h5py -I/tmp/pip-install-ogyzcfgl/h5py/lzf -I/opt/local/include -I/usr/local/include -I/home/pi/virtualenvs/molly/lib/python3.6/site-packages/numpy/core/include -I/usr/local/include/python3.6m -c /tmp/pip-install-ogyzcfgl/h5py/h5py/defs.c -o build/temp.linux-armv7l-3.6/tmp/pip-install-ogyzcfgl/h5py/h5py/defs.o
    In file included from /home/pi/virtualenvs/molly/lib/python3.6/site-packages/numpy/core/include/numpy/ndarraytypes.h:1822:0,
                     from /home/pi/virtualenvs/molly/lib/python3.6/site-packages/numpy/core/include/numpy/ndarrayobject.h:12,
                     from /home/pi/virtualenvs/molly/lib/python3.6/site-packages/numpy/core/include/numpy/arrayobject.h:4,
                     from /tmp/pip-install-ogyzcfgl/h5py/h5py/api_compat.h:26,
                     from /tmp/pip-install-ogyzcfgl/h5py/h5py/defs.c:642:
    /home/pi/virtualenvs/molly/lib/python3.6/site-packages/numpy/core/include/numpy/npy_1_7_deprecated_api.h:17:2: warning: #warning "Using deprecated NumPy API, disable it with " "#define NPY_NO_DEPRECATED_API NPY_1_7_API_VERSION" [-Wcpp]
     #warning "Using deprecated NumPy API, disable it with " \
      ^~~~~~~
    In file included from /tmp/pip-install-ogyzcfgl/h5py/h5py/defs.c:642:0:
    /tmp/pip-install-ogyzcfgl/h5py/h5py/api_compat.h:27:18: fatal error: hdf5.h: No such file or directory
     #include "hdf5.h"
                      ^
    compilation terminated.
    error: command 'gcc' failed with exit status 1
    ----------------------------------------
ERROR: Command "/home/pi/virtualenvs/molly/bin/python3.6 -u -c 'import setuptools, tokenize;__file__='"'"'/tmp/pip-install-ogyzcfgl/h5py/setup.py'"'"';f=getattr(tokenize, '"'"'open'"'"', open)(__file__);code=f.read().replace('"'"'\r\n'"'"', '"'"'\n'"'"');f.close();exec(compile(code, __file__, '"'"'exec'"'"'))' install --record /tmp/pip-record-_yb_aynf/install-record.txt --single-version-externally-managed --compile --install-headers /home/pi/virtualenvs/molly/include/site/python3.6/h5py" failed with error code 1 in /tmp/pip-install-ogyzcfgl/h5py/
```

## Lösung:
`sudo apt-get install libhdf5-serial-dev hdf5-tools`



# Fehler:
```
Collecting scipy>=0.14 (from keras)
  Downloading https://files.pythonhosted.org/packages/cb/97/361c8c6ceb3eb765371a702ea873ff2fe112fa40073e7d2b8199db8eb56e/scipy-1.3.0.tar.gz (23.6MB)
     |████████████████████████████████| 23.6MB 7.6MB/s
  Installing build dependencies ... error
  ERROR: Complete output from command /home/pi/virtualenvs/molly/bin/python3.6 /home/pi/virtualenvs/molly/lib/python3.6/site-packages/pip install --ignore-installed --no-user --prefix /tmp/pip-build-env-ftm83sra/overlay --no-warn-script-location --no-binary :none: --only-binary :none: -i https://pypi.org/simple --extra-index-url https://www.piwheels.org/simple -- wheel setuptools 'Cython>=0.29.2' 'numpy==1.13.3; python_version=='"'"'3.5'"'"'' 'numpy==1.13.3; python_version=='"'"'3.6'"'"'' 'numpy==1.14.5; python_version>='"'"'3.7'"'"'':
  ERROR: Traceback (most recent call last):
    File "/usr/local/lib/python3.6/runpy.py", line 193, in _run_module_as_main
      "__main__", mod_spec)
    File "/usr/local/lib/python3.6/runpy.py", line 85, in _run_code
      exec(code, run_globals)
    File "/home/pi/virtualenvs/molly/lib/python3.6/site-packages/pip/__main__.py", line 16, in <module>
      from pip._internal import main as _main  # isort:skip # noqa
    File "/home/pi/virtualenvs/molly/lib/python3.6/site-packages/pip/_internal/__init__.py", line 4, in <module>
      import locale
    File "/home/pi/virtualenvs/molly/lib/python3.6/locale.py", line 16, in <module>
      import re
    File "/home/pi/virtualenvs/molly/lib/python3.6/re.py", line 142, in <module>
      class RegexFlag(enum.IntFlag):
  AttributeError: module 'enum' has no attribute 'IntFlag'
  ----------------------------------------
ERROR: Command "/home/pi/virtualenvs/molly/bin/python3.6 /home/pi/virtualenvs/molly/lib/python3.6/site-packages/pip install --ignore-installed --no-user --prefix /tmp/pip-build-env-ftm83sra/overlay --no-warn-script-location --no-binary :none: --only-binary :none: -i https://pypi.org/simple --extra-index-url https://www.piwheels.org/simple -- wheel setuptools 'Cython>=0.29.2' 'numpy==1.13.3; python_version=='"'"'3.5'"'"'' 'numpy==1.13.3; python_version=='"'"'3.6'"'"'' 'numpy==1.14.5; python_version>='"'"'3.7'"'"''" failed with error code 1 in None
```

## Lösung:
`pip uninstall enum34`








Fehler:

`pip install keras`

```
    setup.py:388: UserWarning: Unrecognized setuptools command ('dist_info --egg-base /tmp/pip-install-epagmgou/scipy/pip-wheel-metadata'), proceeding with generating Cython sources and expanding templates
      ' '.join(sys.argv[1:])))
    Running from scipy source directory.
    /tmp/pip-build-env-pc8ce050/overlay/lib/python3.6/site-packages/numpy/distutils/system_info.py:572: UserWarning:
        Atlas (http://math-atlas.sourceforge.net/) libraries not found.
        Directories to search for the libraries can be specified in the
        numpy/distutils/site.cfg file (section [atlas]) or by setting
        the ATLAS environment variable.
      self.calc_info()
    /tmp/pip-build-env-pc8ce050/overlay/lib/python3.6/site-packages/numpy/distutils/system_info.py:572: UserWarning:
        Lapack (http://www.netlib.org/lapack/) libraries not found.
        Directories to search for the libraries can be specified in the
        numpy/distutils/site.cfg file (section [lapack]) or by setting
        the LAPACK environment variable.
      self.calc_info()
    /tmp/pip-build-env-pc8ce050/overlay/lib/python3.6/site-packages/numpy/distutils/system_info.py:572: UserWarning:
        Lapack (http://www.netlib.org/lapack/) sources not found.
        Directories to search for the sources can be specified in the
        numpy/distutils/site.cfg file (section [lapack_src]) or by setting
        the LAPACK_SRC environment variable.
      self.calc_info()
    Traceback (most recent call last):
      File "/home/pi/virtualenvs/molly/lib/python3.6/site-packages/pip/_vendor/pep517/_in_process.py", line 207, in <module>
        main()
      File "/home/pi/virtualenvs/molly/lib/python3.6/site-packages/pip/_vendor/pep517/_in_process.py", line 197, in main
        json_out['return_val'] = hook(**hook_input['kwargs'])
      File "/home/pi/virtualenvs/molly/lib/python3.6/site-packages/pip/_vendor/pep517/_in_process.py", line 69, in prepare_metadata_for_build_wheel
        return hook(metadata_directory, config_settings)
      File "/tmp/pip-build-env-pc8ce050/overlay/lib/python3.6/site-packages/setuptools/build_meta.py", line 155, in prepare_metadata_for_build_wheel
        self.run_setup()
      File "/tmp/pip-build-env-pc8ce050/overlay/lib/python3.6/site-packages/setuptools/build_meta.py", line 234, in run_setup
        self).run_setup(setup_script=setup_script)
      File "/tmp/pip-build-env-pc8ce050/overlay/lib/python3.6/site-packages/setuptools/build_meta.py", line 141, in run_setup
        exec(compile(code, __file__, 'exec'), locals())
      File "setup.py", line 505, in <module>
        setup_package()
      File "setup.py", line 501, in setup_package
        setup(**metadata)
      File "/tmp/pip-build-env-pc8ce050/overlay/lib/python3.6/site-packages/numpy/distutils/core.py", line 135, in setup
        config = configuration()
      File "setup.py", line 403, in configuration
        raise NotFoundError(msg)
    numpy.distutils.system_info.NotFoundError: No lapack/blas resources found.
    ----------------------------------------
ERROR: Command "/home/pi/virtualenvs/molly/bin/python3.6 /home/pi/virtualenvs/molly/lib/python3.6/site-packages/pip/_vendor/pep517/_in_process.py prepare_metadata_for_build_wheel /tmp/tmpehb2nh9d" failed with error code 1 in /tmp/pip-install-epagmgou/scipy
```

Lösung:
```
sudo apt-get install libblas-dev liblapack-dev -y
```




```
    gcc -pthread -Wno-unused-result -Wsign-compare -DNDEBUG -g -fwrapv -O3 -Wall -fPIC -DH5_USE_16_API -I./h5py -I/tmp/pip-install-xow77n6w/h5py/lzf -I/opt/local/include -I/usr/local/include -I/home/pi/virtualenvs/molly/lib/python3.6/site-packages/numpy/core/include -I/usr/local/include/python3.6m -c /tmp/pip-install-xow77n6w/h5py/h5py/defs.c -o build/temp.linux-armv7l-3.6/tmp/pip-install-xow77n6w/h5py/h5py/defs.o
    In file included from /home/pi/virtualenvs/molly/lib/python3.6/site-packages/numpy/core/include/numpy/ndarraytypes.h:1822:0,
                     from /home/pi/virtualenvs/molly/lib/python3.6/site-packages/numpy/core/include/numpy/ndarrayobject.h:12,
                     from /home/pi/virtualenvs/molly/lib/python3.6/site-packages/numpy/core/include/numpy/arrayobject.h:4,
                     from /tmp/pip-install-xow77n6w/h5py/h5py/api_compat.h:26,
                     from /tmp/pip-install-xow77n6w/h5py/h5py/defs.c:642:
    /home/pi/virtualenvs/molly/lib/python3.6/site-packages/numpy/core/include/numpy/npy_1_7_deprecated_api.h:17:2: warning: #warning "Using deprecated NumPy API, disable it with " "#define NPY_NO_DEPRECATED_API NPY_1_7_API_VERSION" [-Wcpp]
     #warning "Using deprecated NumPy API, disable it with " \
      ^~~~~~~
    In file included from /tmp/pip-install-xow77n6w/h5py/h5py/defs.c:642:0:
    /tmp/pip-install-xow77n6w/h5py/h5py/api_compat.h:27:18: fatal error: hdf5.h: No such file or directory
     #include "hdf5.h"
                      ^
    compilation terminated.
    error: command 'gcc' failed with exit status 1
    ----------------------------------------
ERROR: Command "/home/pi/virtualenvs/molly/bin/python3.6 -u -c 'import setuptools, tokenize;__file__='"'"'/tmp/pip-install-xow77n6w/h5py/setup.py'"'"';f=getattr(tokenize, '"'"'open'"'"', open)(__file__);code=f.read().replace('"'"'\r\n'"'"', '"'"'\n'"'"');f.close();exec(compile(code, __file__, '"'"'exec'"'"'))' install --record /tmp/pip-record-6pbmp9ut/install-record.txt --single-version-externally-managed --compile --install-headers /home/pi/virtualenvs/molly/include/site/python3.6/h5py" failed with error code 1 in /tmp/pip-install-xow77n6w/h5py/
```


# Fehler:

* Fehler bei der Installation von keras

## Fehlerbild
```
(molly) pi@mollygui:~/install $ pip install keras
Looking in indexes: https://pypi.org/simple, https://www.piwheels.org/simple
Collecting keras
  Using cached https://files.pythonhosted.org/packages/5e/10/aa32dad071ce52b5502266b5c659451cfd6ffcbf14e6c8c4f16c0ff5aaab/Keras-2.2.4-py2.py3-none-any.whl
Requirement already satisfied: h5py in /home/pi/virtualenvs/molly/lib/python3.6/site-packages (from keras) (2.9.0)
Requirement already satisfied: keras-applications>=1.0.6 in /home/pi/virtualenvs/molly/lib/python3.6/site-packages (from keras) (1.0.8)
Collecting scipy>=0.14 (from keras)
  Using cached https://files.pythonhosted.org/packages/cb/97/361c8c6ceb3eb765371a702ea873ff2fe112fa40073e7d2b8199db8eb56e/scipy-1.3.0.tar.gz
  Installing build dependencies ... error
  ERROR: Complete output from command /home/pi/virtualenvs/molly/bin/python3.6 /home/pi/virtualenvs/molly/lib/python3.6/site-packages/pip install --ignore-installed --no-user --prefix /tmp/pip-build-env-tkbzze9c/overlay --no-warn-script-location --no-binary :none: --only-binary :none: -i https://pypi.org/simple --extra-index-url https://www.piwheels.org/simple -- wheel setuptools 'Cython>=0.29.2' 'numpy==1.13.3; python_version=='"'"'3.5'"'"'' 'numpy==1.13.3; python_version=='"'"'3.6'"'"'' 'numpy==1.14.5; python_version>='"'"'3.7'"'"'':
  ERROR: Traceback (most recent call last):
    File "/usr/local/lib/python3.6/runpy.py", line 193, in _run_module_as_main
      "__main__", mod_spec)
    File "/usr/local/lib/python3.6/runpy.py", line 85, in _run_code
      exec(code, run_globals)
    File "/home/pi/virtualenvs/molly/lib/python3.6/site-packages/pip/__main__.py", line 16, in <module>
      from pip._internal import main as _main  # isort:skip # noqa
    File "/home/pi/virtualenvs/molly/lib/python3.6/site-packages/pip/_internal/__init__.py", line 4, in <module>
      import locale
    File "/home/pi/virtualenvs/molly/lib/python3.6/locale.py", line 16, in <module>
      import re
    File "/home/pi/virtualenvs/molly/lib/python3.6/re.py", line 142, in <module>
      class RegexFlag(enum.IntFlag):
  AttributeError: module 'enum' has no attribute 'IntFlag'
  ----------------------------------------
ERROR: Command "/home/pi/virtualenvs/molly/bin/python3.6 /home/pi/virtualenvs/molly/lib/python3.6/site-packages/pip install --ignore-installed --no-user --prefix /tmp/pip-build-env-tkbzze9c/overlay --no-warn-script-location --no-binary :none: --only-binary :none: -i https://pypi.org/simple --extra-index-url https://www.piwheels.org/simple -- wheel setuptools 'Cython>=0.29.2' 'numpy==1.13.3; python_version=='"'"'3.5'"'"'' 'numpy==1.13.3; python_version=='"'"'3.6'"'"'' 'numpy==1.14.5; python_version>='"'"'3.7'"'"''" failed with error code 1 in None
```

## Lösung:
```
(molly) pi@mollygui:~ $ pip uninstall enum34
Uninstalling enum34-1.1.6:
  Would remove:
    /home/pi/virtualenvs/molly/lib/python3.6/site-packages/enum/*
    /home/pi/virtualenvs/molly/lib/python3.6/site-packages/enum34-1.1.6.dist-info/*
Proceed (y/n)? y
  Successfully uninstalled enum34-1.1.6
```
