Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A57D2DEC36
	for <lists+linux-pm@lfdr.de>; Sat, 19 Dec 2020 01:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgLRX75 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Dec 2020 18:59:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgLRX75 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Dec 2020 18:59:57 -0500
Date:   Sat, 19 Dec 2020 00:59:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608335956;
        bh=Dn4O932xHcMdfDpwEn/lVr2aX4q89I1DucP320WpyQM=;
        h=From:To:Cc:Subject:From;
        b=XaFkAHX0xJMvUbU55szD7ovv66ssmcvMBItQLgBRWGh70aDA/Ep4lUfNTpL2A4SC3
         LBZyM6ztg8Q4JSm+c3KTaEFmYMbWuwchuc3E6FEzQQerKiR5AkcxokAE1WGYr30Jy0
         3sE+lHTPYUlTq7mBP32+7b9X4kmGFY641dlXS54qURUCMQmkC1e2k4/a17y16K/ziB
         dslSrYTvQ+A1POXcOU5j2HljzYQyVAREX0OThLJElBcW7g/4KaXNZFLvnVFSvwkvSF
         8+vp/iA/hufI68NbiEyh6M+fdDurFcwuZT6S3xKBrqqqXX2SHML5jdX9yl8T+ixD7v
         zyvVlFMR7hvCw==
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.11
Message-ID: <20201218235914.cfmeap7y67hkbt4t@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rz7b4gmob5uaszfp"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rz7b4gmob5uaszfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.11

for you to fetch changes up to c2362519a04a7307e386e43bc567780d0d7631c7:

  power: supply: Fix a typo in warning message (2020-12-13 01:00:10 +0100)

----------------------------------------------------------------
power supply and reset changes for the v5.11 series

battery/charger driver changes:
 * collie_battery, generic-adc-battery, s3c-adc-battery: convert to GPIO descriptors (incl. ARM board files)
 * misc. cleanup and fixes

reset drivers:
 * new poweroff driver for force disabling a regulator
 * Use printk format symbol resolver
 * ocelot: add support for Luton and Jaguar2

----------------------------------------------------------------
Gregory CLEMENT (2):
      dt-bindings: reset: ocelot: Add Luton and Jaguar2 support
      power: reset: ocelot: Add support 2 other MIPS based SoCs

Hans de Goede (1):
      power: supply: axp288_charger: Fix HP Pavilion x2 10 DMI matching

Helge Deller (1):
      power: reset: Use printk format symbol resolver

Linus Walleij (10):
      power: supply: s3c-adc-battery: Convert to GPIO descriptors
      power: supply: collie_battery: Convert to GPIO descriptors
      power: supply: generic-adc-battery: Use GPIO descriptors
      power: supply: bq24190_charger: Drop unused include
      power: supply: bq24735: Drop unused include
      power: supply: ab8500: Use local helper
      power: supply: ab8500: Convert to dev_pm_ops
      power: supply: ab8500_charger: Oneshot threaded IRQs
      power: supply: ab8500_fg: Request all IRQs as threaded
      power: supply: ab8500: Use dev_err_probe() for IIO channels

Masanari Iida (1):
      power: supply: Fix a typo in warning message

Michael Klein (2):
      power: reset: new driver regulator-poweroff
      Documentation: DT: binding documentation for regulator-poweroff

Nigel Christian (1):
      power: supply: pm2301_charger: remove unnecessary variable

Sebastian Krzyszkowiak (5):
      power: supply: bq25890: Use the correct range for IILIM register
      power: supply: max17042_battery: Fix current_{avg,now} hiding with no current sense
      power: supply: max17042_battery: Improve accuracy of current_now and current_avg readings
      power: supply: max17042_battery: Take r_sns value into account in charge_counter
      power: supply: max17042_battery: Export charge termination current property

Tian Tao (1):
      power: supply: Fix missing IRQF_ONESHOT as only threaded handler

Timon Baetz (3):
      power: supply: max8997-charger: Use module_platform_driver()
      power: supply: max8997-charger: Fix platform data retrieval
      power: supply: max8997-charger: Improve getting charger status

Tom Rix (1):
      power: supply: wm831x_power: remove unneeded break

Yangtao Li (2):
      power: supply: axp20x_usb_power: fix typo
      power: supply: axp20x_usb_power: Use power efficient workqueue for debounce

Zhang Qilong (1):
      power: supply: bq24190_charger: fix reference leak

 .../bindings/power/reset/ocelot-reset.txt          |   4 +-
 .../bindings/power/reset/regulator-poweroff.yaml   |  37 +++++
 arch/arm/mach-s3c/mach-h1940.c                     |  12 +-
 arch/arm/mach-s3c/mach-rx1950.c                    |  11 +-
 arch/arm/mach-sa1100/collie.c                      |  21 +++
 drivers/power/reset/Kconfig                        |   7 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/ocelot-reset.c                 |  30 +++-
 drivers/power/reset/qnap-poweroff.c                |   8 +-
 drivers/power/reset/regulator-poweroff.c           |  82 +++++++++++
 drivers/power/reset/syscon-poweroff.c              |   8 +-
 drivers/power/supply/ab8500_btemp.c                |  68 ++++------
 drivers/power/supply/ab8500_charger.c              |  99 ++++++--------
 drivers/power/supply/ab8500_fg.c                   | 106 +++++----------
 drivers/power/supply/abx500_chargalg.c             |  19 +--
 drivers/power/supply/axp20x_usb_power.c            |  10 +-
 drivers/power/supply/axp288_charger.c              |  28 ++--
 drivers/power/supply/bq24190_charger.c             |  21 ++-
 drivers/power/supply/bq24735-charger.c             |   1 -
 drivers/power/supply/bq25890_charger.c             |   2 +-
 drivers/power/supply/collie_battery.c              | 151 +++++++++++++++------
 drivers/power/supply/generic-adc-battery.c         |  31 ++---
 drivers/power/supply/max17042_battery.c            |  23 +++-
 drivers/power/supply/max8997_charger.c             |  67 +++++----
 drivers/power/supply/pm2301_charger.c              |   3 +-
 drivers/power/supply/power_supply_sysfs.c          |   2 +-
 drivers/power/supply/s3c_adc_battery.c             |  57 ++++----
 drivers/power/supply/wm831x_power.c                |   1 -
 include/linux/power/generic-adc-battery.h          |   4 -
 include/linux/s3c_adc_battery.h                    |   3 -
 30 files changed, 562 insertions(+), 355 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
 create mode 100644 drivers/power/reset/regulator-poweroff.c

--rz7b4gmob5uaszfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/dQlEACgkQ2O7X88g7
+ppGCw/7BEtxp1amiyUOAHvVHaPjSkI4qJIRPU3tRq+a8Wosk0EZYRJN3VTwyhos
15HmSU0YNIrqTyHIwwzbEoWP6d8o8KVj+MHJ/vea4SxJBoAMW/hbaNNWoWdJZybR
o/cIfeNBZKAVTYqOFl+yaYT09G0I2HBywzixTaK6axKR6PI++fqTTdy9V+OBXuM7
pEEDmXa9+rHjwUVS0cBZADQItGbL3SnzcxHKD3aoI3HEP9ANjy/dlD8HHry00U4j
gBo57WxPCCvZIXNY3QShMbTj3i6p5arkekbVZ0N9KuRaOvSn5YtNgRrevPDYKSy/
KmNtetJSMsALRHYTx90LoCFHzTg2lThpruiyfKlAWTW5dTw3zlgz3eRPJIR9vBce
mgDl+SpFqaRpMZhNHmtUkDnYPnkQG9ZDlIYpCHBXFk28Zr1XVd+C8Ev+wlbHeSWE
Nnyuz1Gck8QHVQlgb8DpO7Wa7oZCAnxoR2jlrRWN88fCmaAz1OWZKl1l+g9wfFFH
SJKJq4TFO3lsiAoZKZAwMeZZ73vU+62rC6pbi+CMu334dOI6fQXE4HJdQlmlrfYp
CEvWMtdUnTVJliQajKhQUd0WAsNUNLb0G4sXhe/C0Rc/kaq/oOpHjosar34odxT+
5eprKllK6/i9KpJtf+slX/5l7AAw5A2Ph0sYjNCu9+cGOGpNPx4=
=BmbH
-----END PGP SIGNATURE-----

--rz7b4gmob5uaszfp--
