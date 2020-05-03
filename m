Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AA81C2D77
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgECP30 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 11:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbgECP30 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 May 2020 11:29:26 -0400
Received: from earth.universe (dyndsl-091-096-057-139.ewe-ip-backbone.de [91.96.57.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1588620757;
        Sun,  3 May 2020 15:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588519765;
        bh=/SjMMioYeZz+TW8hgdX2oiXpkM6HnrgkvBAhKuC3c1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0HoJ4hv+f6GW4NpkH0Kc8i8NKaHbN3HFkXq6rmygsihTvsG2klw94bJ6I+5nclxp0
         b+Gc+WcBCcflev396v8xo+pNVMi9/PAal6xJjfCuUMorfRgulSVYbJq8WqBR4DLad0
         uk0rm2qk4V3EB6kgzO715VQFc7SUdQq+1xKmphqM=
Received: by earth.universe (Postfix, from userid 1000)
        id D3B023C08C7; Sun,  3 May 2020 17:29:22 +0200 (CEST)
Date:   Sun, 3 May 2020 17:29:22 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/11] Support ROHM BD99954 charger IC
Message-ID: <20200503152922.lsnt6fkef4exwr22@earth.universe>
References: <cover.1586925868.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pkrhttqoxtqpf3yz"
Content-Disposition: inline
In-Reply-To: <cover.1586925868.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pkrhttqoxtqpf3yz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

I think it's best to create an immutable branch for patches 1-5,
which introduce the linear ranges helper. It can go into regulator
and power-supply tree. Then I take patches 6-11 directly into
power-supply. Do you want to create the immutable branch, or should
I send you a pull request?

-- Sebastian

On Wed, Apr 15, 2020 at 08:16:56AM +0300, Matti Vaittinen wrote:
> Support ROHM BD99954 Battery Management IC
>=20
> ROHM BD99954 is a Battery Management IC for 1-4 cell Lithium-Ion
> secondary battery. BD99954 is intended to be used in space-constraint
> equipment such as Low profile Notebook PC, Tablets and other
> applications.
>=20
> Series extracts a "linear ranges" helper out of the regulator
> framework. Linear ranges helper is intended to help converting
> real-world values to register values when conversion is linear. I
> suspect this is useful also for power subsystem and possibly for clk.
>=20
> Current implementation does not support inversely proportional ranges
> but adding support for that could be helpful.
>=20
> This version of series introduces new battry DT binding entries and
> adds the parsing in power_supply_get_battery_info().
>=20
> Changelog v10:
>  - Add patch 11 which removes the "default n" from power/supply KConfig
>    (Please just drop from series if you disagree)
>  - Fix the regulator_linear_ranges added to qcom_smd-regulator.c at
>    v5.7-rc1
>  - Minor styling to BD70528 power/supply driver as suggested by Andy
>=20
> Changelog v9:
>  General:
>    - rebased on top of v5.7-rc1
>    - re-ordered patches as suggested by Sebastian Reichel
>    - added few acks
>  BD99954 driver:
>    - Moved bd99954-charger.h to drivers/power/supply
>    - fixed a typo from print
>    - used devm_add_action_or_reset and removed remove callback
>=20
> Changelog v8:
>  Linear ranges
>    - small improvements suggested by Andy Shevchenko, no functional chang=
es
>=20
> Changelog v7:
>  General:
>    - rebased on top of v5.6
>  bd99954 driver:
>    - fixed bunch of styling issues spotted by Andy Shevchenko
>    - dropped ACPI table as ACPI properties are not supported at this
>      version of driver.
>    - added few acks
>=20
> Changelog v6:
>  generic:
>    - rebased on top of 5.6-rc7.
>  linear ranges:
>    - moved to lib as requested by Greg KH
>    - EXPORT_SYMBOL =3D> EXPORT_SYMBOL_GPL
>    - licence GPL-2.0, not later
>    - added KUnit test for linear ranges
>=20
> Changelog v5:
>  generic:
>    - rebased on top of 5.6-rc6.
>  DT-bindings:
>    - Dropped -charger extension from compatible and removed wildcard x.
>  regulators:
>    - squashed the regulator changes in one patch.
>  power-supply KConfig:
>    - fixed indentiation
>    - dropped unnecessary 'default N' from BD99954.
>=20
> Changelog v4:
>  generic:
>    - rebase and drop RFC.
>  DT-bindings:
>    - add I2C node address-cells and size-cells to fix yaml check errors
>    - uncomment multipleOf:
>  bd70528:
>    - add patch which renames driver internal linear_range struct to
>      avoid collision when regulator/driver.h (which gets included from
>      rohm generic header) introduces the linear_range struct.
>  regulators:
>    - rebase to v5.6-rc2 and convert also the two newly introduced
>      drivers to use linear_range struct instead of
>      regulator_linear_range.
>  linear_ranges:
>    - Fix kerneldoc.
>=20
> Changelog RFC-v3:
>  DT-bindings:
>    - fix the BD99954 binding (the *-microvolt Vs. *-microvolts issue is
>      still there. Not sure which one is correct)
>    - renabe tricklecharge-* binding to trickle-charge-* as suggested by
>      Rob.
>  - drop the linear-ranges helper which was written for BD70528 and
>    extract the linear-range code from regulator framework instead.
>  - refactor regulator framework to utilize extracted linear-ranges
>    code.
>  - change the struct regulator_linear_range to linear_range from
>    regulator drivers.
>  - refactor BD70528 to use regulator framework originated
>    linear-ranges code.
>  - change BD99954 to use linear-ranges code from regulator framework
>=20
> Changelog RFC-v2:
>  DT-bindings:
>    - Used the battery parameters described in battery.txt
>    - Added few new parameters to battery.txt
>    - Added ASCII art charging profile chart for BD99954 to explain
>      states and limits.
>  Linear ranges:
>    - Fixed division by zero error from linear-ranges code if step 0 is
>      used.
>  Power-supply core:
>    - Added parsing of new battery parameters.
>  BD99954 driver:
>    - converted to use battery parameters from battery node
>    - Added step 0 ranges for reg values which do not change voltage
>    - added dt-node to psy-config
>=20
> Patch 1:
> 	Linear ranges helpers
> Patch 2:
> 	Test for linear ranges helpers
> Patch 3:
> 	Rename driver internal struct linear_range from bd70528-power
> Patch 4:
> 	Use linear-ranges helpers in regulator framework and
> 	convert regulator drivers to use new linear_range struct.
> Patch 5:
> 	Use linear-ranges helpers in bd70528 driver
> Patch 6:
> 	DT binding docs for the new battery parameters
> Patch 7:
> 	Parsing of new battery parameters
> Patch 8:
> 	BD99954 charger DT binding docs
> Patch 9:
> 	ROHM BD99954 charger IC driver
> Patch 10:
> 	Fix Kconfig help text indentiation for other entries as well.
> Patch 10:
> 	Fix Kconfig by removing the "default n".
>=20
> ---
>=20
> Matti Vaittinen (11):
>   lib: add linear ranges helpers
>   lib/test_linear_ranges: add a test for the 'linear_ranges'
>   power: supply: bd70528: rename linear_range to avoid collision
>   regulator: use linear_ranges helper
>   power: supply: bd70528: use linear ranges
>   dt-bindings: battery: add new battery parameters
>   power: supply: add battery parameters
>   dt_bindings: ROHM BD99954 Charger
>   power: supply: Support ROHM bd99954 charger
>   power: supply: Fix Kconfig help text indentiation
>   power: supply: KConfig cleanup default n
>=20
>  .../bindings/power/supply/battery.txt         |    6 +
>  .../bindings/power/supply/rohm,bd99954.yaml   |  155 +++
>  drivers/power/supply/Kconfig                  |   36 +-
>  drivers/power/supply/Makefile                 |    1 +
>  drivers/power/supply/bd70528-charger.c        |  140 +-
>  drivers/power/supply/bd99954-charger.c        | 1142 +++++++++++++++++
>  drivers/power/supply/bd99954-charger.h        | 1075 ++++++++++++++++
>  drivers/power/supply/power_supply_core.c      |    8 +
>  drivers/regulator/88pg86x.c                   |    4 +-
>  drivers/regulator/88pm800-regulator.c         |    4 +-
>  drivers/regulator/Kconfig                     |    1 +
>  drivers/regulator/act8865-regulator.c         |    4 +-
>  drivers/regulator/act8945a-regulator.c        |    2 +-
>  drivers/regulator/arizona-ldo1.c              |    2 +-
>  drivers/regulator/arizona-micsupp.c           |    4 +-
>  drivers/regulator/as3711-regulator.c          |    6 +-
>  drivers/regulator/as3722-regulator.c          |    4 +-
>  drivers/regulator/axp20x-regulator.c          |   16 +-
>  drivers/regulator/bcm590xx-regulator.c        |    8 +-
>  drivers/regulator/bd70528-regulator.c         |    8 +-
>  drivers/regulator/bd71828-regulator.c         |   10 +-
>  drivers/regulator/bd718x7-regulator.c         |   26 +-
>  drivers/regulator/da903x.c                    |    2 +-
>  drivers/regulator/helpers.c                   |  130 +-
>  drivers/regulator/hi6421-regulator.c          |    4 +-
>  drivers/regulator/lochnagar-regulator.c       |    4 +-
>  drivers/regulator/lp873x-regulator.c          |    4 +-
>  drivers/regulator/lp87565-regulator.c         |    2 +-
>  drivers/regulator/lp8788-buck.c               |    2 +-
>  drivers/regulator/max77650-regulator.c        |    2 +-
>  drivers/regulator/mcp16502.c                  |    4 +-
>  drivers/regulator/mp8859.c                    |    2 +-
>  drivers/regulator/mt6323-regulator.c          |    6 +-
>  drivers/regulator/mt6358-regulator.c          |    8 +-
>  drivers/regulator/mt6380-regulator.c          |    6 +-
>  drivers/regulator/mt6397-regulator.c          |    6 +-
>  drivers/regulator/palmas-regulator.c          |    4 +-
>  drivers/regulator/qcom-rpmh-regulator.c       |    2 +-
>  drivers/regulator/qcom_rpm-regulator.c        |   14 +-
>  drivers/regulator/qcom_smd-regulator.c        |   78 +-
>  drivers/regulator/rk808-regulator.c           |   10 +-
>  drivers/regulator/s2mps11.c                   |   14 +-
>  drivers/regulator/sky81452-regulator.c        |    2 +-
>  drivers/regulator/stpmic1_regulator.c         |   18 +-
>  drivers/regulator/tps65086-regulator.c        |   10 +-
>  drivers/regulator/tps65217-regulator.c        |    4 +-
>  drivers/regulator/tps65218-regulator.c        |    6 +-
>  drivers/regulator/tps65912-regulator.c        |    4 +-
>  drivers/regulator/twl-regulator.c             |    4 +-
>  drivers/regulator/twl6030-regulator.c         |    2 +-
>  drivers/regulator/wm831x-dcdc.c               |    2 +-
>  drivers/regulator/wm831x-ldo.c                |    4 +-
>  drivers/regulator/wm8350-regulator.c          |    2 +-
>  drivers/regulator/wm8400-regulator.c          |    2 +-
>  include/linux/linear_range.h                  |   48 +
>  include/linux/power_supply.h                  |    4 +
>  include/linux/regulator/driver.h              |   27 +-
>  lib/Kconfig                                   |    3 +
>  lib/Kconfig.debug                             |   11 +
>  lib/Makefile                                  |    2 +
>  lib/linear_ranges.c                           |  241 ++++
>  lib/test_linear_ranges.c                      |  228 ++++
>  62 files changed, 3228 insertions(+), 362 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,b=
d99954.yaml
>  create mode 100644 drivers/power/supply/bd99954-charger.c
>  create mode 100644 drivers/power/supply/bd99954-charger.h
>  create mode 100644 include/linux/linear_range.h
>  create mode 100644 lib/linear_ranges.c
>  create mode 100644 lib/test_linear_ranges.c
>=20
>=20
> base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
> --=20
> 2.21.0
>=20
>=20
> --=20
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
>=20
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =3D]=20

--pkrhttqoxtqpf3yz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6u40cACgkQ2O7X88g7
+ppdhA//aMJwamiLXuzN8bUqOw2zTaJE0/yLwlUPBlv5zcqcW2daVvPv16DA5mJX
6u4FMnuu2YIvO45kEkZiHsgnsOv1bCrgP7BAJrIf96uLLwfIk4Lb9rXK3YaNRuAZ
DyB8VG7lORrIzcm2UN4W5aGL/qHoNzKRwiqmAxop/O0HuDd3Gdmf3goCWNC+iKgf
StZZSMiL/Jc9dqb8Xw6f70cxV+8+OkZ3qDyGaBOTok6pR/wMYY7UpmmcdGLMJqeq
5zVPN0LRciJ/v2HvaEKBzKChLfc/+eTlyfrok8BOpjzu2h2/H01QCILamUwtk43P
hFSabwOOy8ORn1TrPjjqbml137YBA7Eov7QVatqfGzyIyDTAa6X6XooigNmqmQrF
SawdyETqoZQKPN1EzTmmKBDleGhqX9wFsme+zMEXdVpQYG5SehewlWZeGRX1bn+V
pzfWkx1F41vFxhNFHkWr+vaWlzxejjX4ZYs0o/Q2ObAvRbjUVwQsvlHsuGmgla4j
YG04EZ2VewvEXtyz6zvbeJZCHwiRbopdzim7jCUifl6PNpueCc6AoYPHeouD82Lx
Yo3+a2GzbSoRtb1uiYEWCfhuAoO3TNkqXGBrVmx/xM+X35pQIfbGbwUaEDRI5BvQ
jqyvu+MKg0nU7GJq9Eobv1NZpY+3vVfReCznAHxMeXsEz+JOej4=
=2/vf
-----END PGP SIGNATURE-----

--pkrhttqoxtqpf3yz--
