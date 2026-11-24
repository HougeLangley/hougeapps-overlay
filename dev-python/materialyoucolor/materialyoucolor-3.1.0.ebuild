# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1

inherit distutils-r1 pypi

DESCRIPTION="Material You color algorithms for python"
HOMEPAGE="https://github.com/T-Dynamos/materialyoucolor-python https://pypi.org/project/materialyoucolor/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# sdist 已 vendor 全部 C++ 源（quantize/*.cc），构建不联网
BDEPEND="dev-python/pybind11[${PYTHON_USEDEP}]"

distutils_enable_tests import-check
