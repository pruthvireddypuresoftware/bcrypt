/opt/python/$1/bin/pip install virtualenv
/opt/python/$1/bin/python -m virtualenv .venv
.venv/bin/pip install setuptools wheel cffi six
REGEX="cp3([0-9])*"
if [[ "$1" =~ $REGEX ]]; then
    PY_LIMITED_API="--py-limited-api=cp3${BASH_REMATCH[1]}"
fi
.venv/bin/python setup.py bdist_wheel $PY_LIMITED_API -d tmpwheelhouse
auditwheel repair tmpwheelhouse/bcrypt*.whl -w wheelhouse/
.venv/bin/pip install bcrypt --no-index -f wheelhouse/
.venv/bin/python -c "import bcrypt; password = b'super secret password';hashed = bcrypt.hashpw(password, bcrypt.gensalt());bcrypt.checkpw(password, hashed)"
