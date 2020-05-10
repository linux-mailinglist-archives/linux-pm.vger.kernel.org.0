Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F141CC5C2
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 02:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEJAct (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 May 2020 20:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726356AbgEJAct (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 May 2020 20:32:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B0C061A0C;
        Sat,  9 May 2020 17:32:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7E8652753CA
Received: by earth.universe (Postfix, from userid 1000)
        id BD0943C08C7; Sun, 10 May 2020 02:32:44 +0200 (CEST)
Date:   Sun, 10 May 2020 02:32:44 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com, lgirdwood@gmail.com,
        brendanhiggins@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/11] Support ROHM BD99954 charger IC
Message-ID: <20200510003244.3ecxkn5r57nudsm2@earth.universe>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
 <20200508172024.GN4820@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2vnpaxzv7zffzoea"
Content-Disposition: inline
In-Reply-To: <20200508172024.GN4820@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2vnpaxzv7zffzoea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 08, 2020 at 06:20:24PM +0100, Mark Brown wrote:
> On Fri, May 08, 2020 at 06:38:17PM +0300, Matti Vaittinen wrote:
> > Please note that this series should be applied to two trees. Patches
> > 1-4 (or 1-5 as suggested by Sebastian) should go to regulator tree.
> > Perhaps Mark can provide an immutable branch to Sebastian? Rest of the
> > patches can then go to power-supply tree.
>=20
> The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314=
fd:
>=20
>   Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git t=
ags/linear-ranges-lib
>=20
> for you to fetch changes up to 60ab7f4153b6af461c90d572c31104086b44639f:
>=20
>   regulator: use linear_ranges helper (2020-05-08 18:18:13 +0100)
>=20
> ----------------------------------------------------------------
> lib: Add linear ranges helper library and start using it
>=20
> Series extracts a "linear ranges" helper out of the regulator
> framework. Linear ranges helper is intended to help converting
> real-world values to register values when conversion is linear. I
> suspect this is useful also for power subsystem and possibly for clk.
>=20
> ----------------------------------------------------------------

Thanks, merged to power-supply's for-next branch.

-- Sebastian

> Matti Vaittinen (4):
>       lib: add linear ranges helpers
>       lib/test_linear_ranges: add a test for the 'linear_ranges'
>       power: supply: bd70528: rename linear_range to avoid collision
>       regulator: use linear_ranges helper
>=20
>  drivers/power/supply/bd70528-charger.c  |  10 +-
>  drivers/regulator/88pg86x.c             |   4 +-
>  drivers/regulator/88pm800-regulator.c   |   4 +-
>  drivers/regulator/Kconfig               |   1 +
>  drivers/regulator/act8865-regulator.c   |   4 +-
>  drivers/regulator/act8945a-regulator.c  |   2 +-
>  drivers/regulator/arizona-ldo1.c        |   2 +-
>  drivers/regulator/arizona-micsupp.c     |   4 +-
>  drivers/regulator/as3711-regulator.c    |   6 +-
>  drivers/regulator/as3722-regulator.c    |   4 +-
>  drivers/regulator/axp20x-regulator.c    |  16 +--
>  drivers/regulator/bcm590xx-regulator.c  |   8 +-
>  drivers/regulator/bd70528-regulator.c   |   8 +-
>  drivers/regulator/bd71828-regulator.c   |  10 +-
>  drivers/regulator/bd718x7-regulator.c   |  26 ++--
>  drivers/regulator/da903x.c              |   2 +-
>  drivers/regulator/helpers.c             | 130 ++++++++---------
>  drivers/regulator/hi6421-regulator.c    |   4 +-
>  drivers/regulator/lochnagar-regulator.c |   4 +-
>  drivers/regulator/lp873x-regulator.c    |   4 +-
>  drivers/regulator/lp87565-regulator.c   |   2 +-
>  drivers/regulator/lp8788-buck.c         |   2 +-
>  drivers/regulator/max77650-regulator.c  |   2 +-
>  drivers/regulator/mcp16502.c            |   4 +-
>  drivers/regulator/mp8859.c              |   2 +-
>  drivers/regulator/mt6323-regulator.c    |   6 +-
>  drivers/regulator/mt6358-regulator.c    |   8 +-
>  drivers/regulator/mt6380-regulator.c    |   6 +-
>  drivers/regulator/mt6397-regulator.c    |   6 +-
>  drivers/regulator/palmas-regulator.c    |   4 +-
>  drivers/regulator/qcom-rpmh-regulator.c |   2 +-
>  drivers/regulator/qcom_rpm-regulator.c  |  14 +-
>  drivers/regulator/qcom_smd-regulator.c  |  78 +++++------
>  drivers/regulator/rk808-regulator.c     |  10 +-
>  drivers/regulator/s2mps11.c             |  14 +-
>  drivers/regulator/sky81452-regulator.c  |   2 +-
>  drivers/regulator/stpmic1_regulator.c   |  18 +--
>  drivers/regulator/tps65086-regulator.c  |  10 +-
>  drivers/regulator/tps65217-regulator.c  |   4 +-
>  drivers/regulator/tps65218-regulator.c  |   6 +-
>  drivers/regulator/tps65912-regulator.c  |   4 +-
>  drivers/regulator/twl-regulator.c       |   4 +-
>  drivers/regulator/twl6030-regulator.c   |   2 +-
>  drivers/regulator/wm831x-dcdc.c         |   2 +-
>  drivers/regulator/wm831x-ldo.c          |   4 +-
>  drivers/regulator/wm8350-regulator.c    |   2 +-
>  drivers/regulator/wm8400-regulator.c    |   2 +-
>  include/linux/linear_range.h            |  48 +++++++
>  include/linux/regulator/driver.h        |  27 +---
>  lib/Kconfig                             |   3 +
>  lib/Kconfig.debug                       |  12 ++
>  lib/Makefile                            |   2 +
>  lib/linear_ranges.c                     | 241 ++++++++++++++++++++++++++=
++++++
>  lib/test_linear_ranges.c                | 228 ++++++++++++++++++++++++++=
++++
>  54 files changed, 768 insertions(+), 266 deletions(-)
>  create mode 100644 include/linux/linear_range.h
>  create mode 100644 lib/linear_ranges.c
>  create mode 100644 lib/test_linear_ranges.c



--2vnpaxzv7zffzoea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl63S6cACgkQ2O7X88g7
+poxMQ//ZqWoqEMXvf3HYr8zHc/3gRNnrZHVI1jhO2aSOs4UIH1gebjIUEaVmSdH
iK2rLIyGChmiHZbwDW84POb9e3DhV6vSzzo2MB+ZpYszYQWSzfioVbS2mM+kpMWs
n35kz0CbznrukxOjIZpmCqVwHwu4UOURhasRJdf6HzddUYt8TIRd3B1SKqqgN96W
hKJt3JYeIs3e1gARYHKA1tI10OpAnfyqJ+2fWejjEBtPFeBqyy2bJAwqe9EJOV8J
+Ks7+kO8nYYaWtDEamXfJC5gn+fre4eG4tH7Xu7NYIsHJ7duiQ6jwixsy3m78vp9
oRzDegoHoTtgGTtjBy28jyZWubK6bCZxDY7tlbdvx63cePAHH+KJuhlQKXxxKxUr
TFmYP4hIL4xp0D5P3v0WRURdgfxK4Tf0YVrM2qsIseLpiXeepPcDxlgmWl6KFJlW
9DnhbCvxPzP/Prybahox3W2RzTeOAvjCO25zl6J/wozksGQgFtc8REy0+PJcp3cW
7GZdhlOGQru8848JO0CnuearPDIc41+2q97FfJH2n5OLURwOg1n/fOx05vguhD/c
IPYVEZs9TLICb6OmJOUlZUD775/Lcp2ceUiwdfDgGo2y+T8Fy/O2Ym7C9IHXuEcN
aeKqUNpeaKC8vOnsIicKALw6fd193vUQ1wKppLvi+KEXPd6Osck=
=Xn2+
-----END PGP SIGNATURE-----

--2vnpaxzv7zffzoea--
