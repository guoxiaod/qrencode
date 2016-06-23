%define luaver 5.1
%define lualibdir %{_libdir}/lua/%{luaver}
%define luadatadir %{_datadir}/lua/%{luaver}

Name:		lua-qrencode
Version:	0.1.0
Release:	1%{?dist}
Summary:	qrencode for lua 

Group:		Development/Libraries
License:	MIT
URL:		https://github.com/guoxiaod/qrencode
Source0:	https://github.com/guoxiaod/qrencode/.../%{name}-%{version}.tgz
BuildRoot:	%(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

BuildRequires:	lua >= %{luaver}, lua-devel >= %{luaver}
BuildRequires:  libpng-devel, qrencode-devel
Requires:	lua >= %{luaver}, libpng, qrencode-libs

%description
qrencode is a wrapper of libqrencode with libpng for lua.


%prep
%setup -q


%build
make %{?_smp_mflags} LUA_INCLUDE_DIR="%{_includedir}"


%install
rm -rf "$RPM_BUILD_ROOT"
make install DESTDIR="$RPM_BUILD_ROOT" LUA_CMODULE_DIR="%{lualibdir}"


%clean
rm -rf "$RPM_BUILD_ROOT"


%files
%defattr(-,root,root,-)
%{lualibdir}/*


%changelog
* Thu Jun 23 2016 - guoxiaodong<gxd305@gmail.com> - 
- init version
