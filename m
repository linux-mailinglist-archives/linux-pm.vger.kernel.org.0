Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6049B2EAD41
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 15:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbhAEOSs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 09:18:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbhAEOSr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Jan 2021 09:18:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19D3F22AAB;
        Tue,  5 Jan 2021 14:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609856287;
        bh=6s31ZIkixY+XOJ1zBcpw8HQ3MQaUtb0FwN/tnF0TkUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X9W3EgUNZzJnC2z9WBx7doUE6NQHm+ds/uakdLvr0h/dST+VYNnt5lMTuX2NZ1GnO
         TORpQpoQUsTRAxjuTobBhCnCRLG5ij5148f8DLe7euA8DK+fGNFevj34MdoddRfGmi
         SWnFY/BXkNvth8RW4ENUcI3zpwR+9H9SimDn38Zz9yV1qXWmS3PikigZqjX/O2TDAR
         y1EoHDyEu1bU0oKC6BGC0qbWk/BQPWwePYYwd8hRtBs0f9adU3MtaSEvBQ5GA9M6Xq
         uuejZ4cUgwd7sCxSAG+YK0gLbQkMl1Mu5SrhX+pClDRLNT23CdiyoTSmZddiPAn3g/
         M6VfSUPTppcXw==
Received: by earth.universe (Postfix, from userid 1000)
        id 1E2F13C0C94; Tue,  5 Jan 2021 15:18:05 +0100 (CET)
Date:   Tue, 5 Jan 2021 15:18:05 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, dmurphy@ti.com
Subject: Re: [PATCH v8 2/2] power: supply: bq256xx: Introduce the BQ256XX
 charger driver
Message-ID: <20210105141805.vhf7wrgcwujr7uwn@earth.universe>
References: <20210104202450.9669-3-r-rivera-matos@ti.com>
 <202101051158.UxB5IFs7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h2556ndxc2dpprsn"
Content-Disposition: inline
In-Reply-To: <202101051158.UxB5IFs7-lkp@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--h2556ndxc2dpprsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ricardo,

On Tue, Jan 05, 2021 at 11:24:18AM +0800, kernel test robot wrote:
> Hi Ricardo,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on power-supply/for-next]
> [also build test WARNING on robh/for-next v5.11-rc2 next-20210104]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>=20
> url:    https://github.com/0day-ci/linux/commits/Ricardo-Rivera-Matos/Int=
roduce-the-BQ256XX-family-of-chargers/20210105-043028
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-s=
upply.git for-next
> config: powerpc64-randconfig-r034-20210105 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 5c95=
1623bc8965fa1e89660f2f5f4a2944e4981a)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc64 cross compiling tool for clang build
>         # apt-get install binutils-powerpc64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/82436c2c6d99c4effb187bb=
d09b47c4dc59a1f3d
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Ricardo-Rivera-Matos/Introduce-t=
he-BQ256XX-family-of-chargers/20210105-043028
>         git checkout 82436c2c6d99c4effb187bbd09b47c4dc59a1f3d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross AR=
CH=3Dpowerpc64=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
>    drivers/power/supply/bq256xx_charger.c:1644:29: warning: variable 'psy=
_cfg' is uninitialized when used here [-Wuninitialized]
>            ret =3D bq256xx_parse_dt(bq, psy_cfg, dev);
>                                       ^~~~~~~
>    drivers/power/supply/bq256xx_charger.c:1618:37: note: initialize the v=
ariable 'psy_cfg' to silence this warning
>            struct power_supply_config *psy_cfg;
>                                               ^
>                                                =3D NULL

bah, I missed this serious issue during review :(

FWIW the compiler provided wrong solution. It would result in
dereferencing a NULL pointer afterwards since you never allocate
any memory for psy_cfg. You could of course allocate memory for
it, but power_supply_config is only needed during device
registration.

Proper solution is to initialize it as variable instead of pointer,
so that it ends up on the stack. Also you should initialize it with
{} to make sure any fields not explicitly configured are 0.

> >> drivers/power/supply/bq256xx_charger.c:1720:36: warning: unused variab=
le 'bq256xx_acpi_match' [-Wunused-const-variable]
>    static const struct acpi_device_id bq256xx_acpi_match[] =3D {

For this one just change

=2Eacpi_match_table =3D ACPI_PTR(bq256xx_acpi_match),

into

=2Eacpi_match_table =3D bq256xx_acpi_match,

>    2 warnings generated.
>=20
>=20
> vim +/bq256xx_acpi_match +1720 drivers/power/supply/bq256xx_charger.c
>=20
>   1719=09
> > 1720	static const struct acpi_device_id bq256xx_acpi_match[] =3D {
>   1721		{ "bq25600", BQ25600 },
>   1722		{ "bq25600d", BQ25600D },
>   1723		{ "bq25601", BQ25601 },
>   1724		{ "bq25601d", BQ25601D },
>   1725		{ "bq25611d", BQ25611D },
>   1726		{ "bq25618", BQ25618 },
>   1727		{ "bq25619", BQ25619 },
>   1728		{},
>   1729	};
>   1730	MODULE_DEVICE_TABLE(acpi, bq256xx_acpi_match);
>   1731=09
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Thanks,

-- Sebastian

--h2556ndxc2dpprsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/0dRUACgkQ2O7X88g7
+pqiEg/9GHmqEAJL5IHzTgu/C/VHwlU5qSAaWbxei3YIOJ0oeIqWjuh96AADjSMQ
nZmul4Q+N2yHBcMipUkjmttW66tUfA1pXqRkiaSfZLSKsHDn6a5mdNyPfYbGM8Zq
vttHOKE0FEVwEqLifXmM5yuQEmCW0ulCazhwOMET15Un+LrkTnff25UwGGxYJ49m
CsfTFxMvjj12uZZKhu9pU3HCgfegDR++H0EQrjywvwwnPn35WMo5IjiY5vARhwwz
6qSWc7HnuvevTCMoMYYns4XfS4LQYo+r9UTH8RfGVoNTvmnev3dS++kcg6HbFFKH
JUZudb5KDwpLp1DSn2S8Q3i+SskU/NPvw1k6cZyFilRNGKiyrDphuHbtCgZgGpfo
OXIdsFHAbPaocq+ubNkYE+wNNMZZ3vYvN6B2hRxEavwSqVV3jOlkBNxngGtefyUw
BW4H5nlc1hcWYuHMpObFSbH2bcvxh/n4rD7WVZVgiPBMSjS4TvvksCACZHIp0ByH
McGIJnTEyOoMGpecVZTztpbIH2MtKG6gER6x2jHhPtXzV08Kzb+Ve8DBPhgT5Fbi
B05JbaQH6EIvCqv+bVC5nMDDsJvPkGL/scAJq8AgMNxbbv+S4pEKN7wQZOXfaNi6
yTZtU02+n6QAghgU0P2HKBYLMIXx44t7Q3GKDq7py/G3kRVVv7w=
=TDLb
-----END PGP SIGNATURE-----

--h2556ndxc2dpprsn--
