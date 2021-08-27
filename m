Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0843F9679
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 10:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244593AbhH0IxL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Aug 2021 04:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244564AbhH0IxL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Aug 2021 04:53:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A99B608FE;
        Fri, 27 Aug 2021 08:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630054342;
        bh=sV2PImxd2kifPAONwUdQB3D3Va+SNOiOHRTI/8ZqHls=;
        h=Date:From:To:Cc:Subject:From;
        b=LOF2f1AOxbczUhmYOUOxHQ8UTLjNFIydCba0axtLejundYRKE8FB2jFMAXNL4Z2qB
         41nqQC8vUD6j35DGe2LwT5aJqIFXkwOym4lpDGVAXWLYJdfCqt9G01sTDFFtPbBU7w
         VzvFuFtIKY9nwXSlnSTTrEW+hELEeoZtnOrfh1/lZADFA3mhN25W49S5PKCKsaNE45
         VC8Ww+gFQA0wj3UccQ7uM9xjqZJLY8aieiS/sunc6FqqGCq/uS2r+S7xp3LMr+Jggm
         5zAURL4HsbvQxW68sRBWOz0RG/LDkJ5D7bIM7NxxyImOgZxzhvhoAXmUvivegNlft8
         tr8CJ4aSP5ORw==
Received: by earth.universe (Postfix, from userid 1000)
        id 6B1C83C0C98; Fri, 27 Aug 2021 10:52:20 +0200 (CEST)
Date:   Fri, 27 Aug 2021 10:52:20 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.15
Message-ID: <20210827085220.yryb2prsgeaz7s6o@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yce6kyfcsoaihuun"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--yce6kyfcsoaihuun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

I'm on vacation without my laptop for two weeks starting today
and return shortly before the merge window is expected to close,
so I'm sending the 5.15 power-supply pull-request early.

Patches have been in linux-next for some time and no problems have
been reported by Stephen Rothwell (or anyone else).

Thanks,

-- Sebastian

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.15

for you to fetch changes up to c9398455b046fc7a44b6dd53d9d6fe4b11c21700:

  power: supply: core: Fix parsing of battery chemistry/technology (2021-08-20 18:57:56 +0200)

----------------------------------------------------------------
power supply and reset changes for the v5.15 series

battery/charger related changes:
 - cros-peripheral-charger: new driver
 - mt6360-charger: new driver
 - simple-battery: support reading chemistry info
 - max17042-battery: add max77849 support
 - sbs-battery: add time_to_empty_now support
 - smb347-charger: prepare USB OTG support
 - rn5t618: add voltage_now support
 - axp288: cleanup & optimizations
 - max17042_battery: cleanups
 - ab8500: cleanups
 - misc minor cleanups and DT binding fixes

reset related changes:
 - tps65086-restart: new driver
 - linkstation-poweroff: support NETGEAR ReadyNAS Duo v2

----------------------------------------------------------------
Andreas Kemnade (2):
      iio: adc: rn5t618: Add iio map
      power: supply: rn5t618: Add voltage_now property

Andrejus Basovas (1):
      power: supply: axp288_fuel_gauge: Refresh all registers in one go

Bruno Meneguele (1):
      power: supply: bq24735: reorganize ChargeOption command macros

Colin Ian King (1):
      power: supply: ab8500: clean up warnings found by checkpatch

Daisuke Nojiri (1):
      power: supply: PCHG: Peripheral device charger

Dmitry Osipenko (6):
      dt-bindings: power: supply: smb347-charger: Document USB VBUS regulator
      power: supply: smb347-charger: Make smb347_set_writable() IRQ-safe
      power: supply: smb347-charger: Utilize generic regmap caching
      power: supply: smb347-charger: Add missing pin control activation
      power: supply: smb347-charger: Implement USB VBUS regulator
      power: supply: core: Fix parsing of battery chemistry/technology

Emil Renner Berthing (1):
      power: reset: Add TPS65086 restart driver

Gene Chen (3):
      lib: add linear range get selector within
      dt-bindings: power: Add bindings document for Charger support on MT6360 PMIC
      power: supply: mt6360_charger: add MT6360 charger support

Hans de Goede (9):
      power: supply: axp288_fuel_gauge: Fix define alignment
      power: supply: axp288_fuel_gauge: Remove debugfs support
      power: supply: axp288_fuel_gauge: Silence the chatty IRQ mapping code
      power: supply: axp288_fuel_gauge: Report register-address on readb / writeb errors
      power: supply: axp288_fuel_gauge: Drop retry logic from fuel_gauge_reg_readb()
      power: supply: axp288_fuel_gauge: Store struct device pointer in axp288_fg_info
      power: supply: axp288_fuel_gauge: Only read PWR_OP_MODE, FG_LOW_CAP_REG regs once
      power: supply: axp288_fuel_gauge: Move the AXP20X_CC_CTRL check together with the other checks
      power: supply: axp288_fuel_gauge: Take the P-Unit semaphore only once during probe()

Krzysztof Kozlowski (3):
      power: supply: max17042: handle fails of reading status register
      power: supply: max17042: remove duplicated STATUS bit defines
      dt-bindings: power: supply: max17042: describe interrupt

Linus Walleij (7):
      power: supply: ab8500: Use library interpolation
      power: supply: ab8500: Rename charging algorithm symbols
      power: supply: ab8500: Drop abx500 concept
      power: supply: ab8500: Rename charging algorithm psy
      power: supply: ab8500: Drop some includes from bmdata
      dt-bindings: power: Extend battery bindings with chemistry
      power: supply: core: Parse battery chemistry/technology

Matthias Schiffer (2):
      power: supply: sbs-battery: relax voltage limit
      power: supply: sbs-battery: add support for time_to_empty_now attribute

Maxime Ripard (2):
      dt-bindings: power: supply: axp20x: Add AXP803 compatible
      dt-bindings: power: supply: axp20x-battery: Add AXP209 compatible

Nikita Travkin (2):
      dt-bindings: power: supply: max17042: Document max77849-battery
      power: supply: max17042_battery: Add support for MAX77849 Fuel-Gauge

Pawel Dembicki (2):
      power: reset: linkstation-poweroff: prepare for new devices
      power: reset: linkstation-poweroff: add new device

Peter Robinson (1):
      power: supply: cw2015: use dev_err_probe to allow deferred probe

Sebastian Krzyszkowiak (4):
      power: supply: max17042_battery: clean up MAX17055_V_empty
      power: supply: max17042_battery: fix typo in MAx17042_TOFF
      power: supply: max17042_battery: more robust chip type checks
      power: supply: max17042_battery: log SOC threshold using debug log level

Sebastian Reichel (1):
      Merge tag 'ib-mt6360-for-5.15-signed' into psy-next

Tang Bin (3):
      power: supply: sc27xx: Delete superfluous error message
      power: supply: qcom_smbb: Remove superfluous error message
      power: supply: axp288_charger: Use the defined variable to clean code

 .../devicetree/bindings/power/supply/battery.yaml  |  14 +
 .../bindings/power/supply/maxim,max17042.yaml      |   3 +
 .../bindings/power/supply/mt6360_charger.yaml      |  48 ++
 .../power/supply/summit,smb347-charger.yaml        |  30 +
 .../supply/x-powers,axp20x-ac-power-supply.yaml    |  11 +-
 .../x-powers,axp20x-battery-power-supply.yaml      |  12 +-
 .../supply/x-powers,axp20x-usb-power-supply.yaml   |  14 +-
 drivers/iio/adc/rn5t618-adc.c                      |  23 +
 drivers/power/reset/Kconfig                        |   6 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/linkstation-poweroff.c         |  77 +-
 drivers/power/reset/tps65086-restart.c             |  98 +++
 drivers/power/supply/Kconfig                       |  26 +-
 drivers/power/supply/Makefile                      |   4 +-
 drivers/power/supply/ab8500-bm.h                   | 219 +-----
 drivers/power/supply/ab8500_bmdata.c               |  34 +-
 drivers/power/supply/ab8500_btemp.c                |  22 +-
 .../{abx500_chargalg.c => ab8500_chargalg.c}       | 601 +++++++-------
 drivers/power/supply/ab8500_charger.c              |   4 +-
 drivers/power/supply/ab8500_fg.c                   |  20 +-
 drivers/power/supply/axp288_charger.c              |  11 +-
 drivers/power/supply/axp288_fuel_gauge.c           | 489 +++++-------
 drivers/power/supply/bq24735-charger.c             |  27 +-
 drivers/power/supply/cros_peripheral_charger.c     | 386 +++++++++
 drivers/power/supply/cw2015_battery.c              |   4 +-
 drivers/power/supply/max17042_battery.c            |  61 +-
 drivers/power/supply/mt6360_charger.c              | 867 +++++++++++++++++++++
 drivers/power/supply/power_supply_core.c           |  19 +
 drivers/power/supply/qcom_smbb.c                   |   5 +-
 drivers/power/supply/rn5t618_power.c               |  38 +
 drivers/power/supply/sbs-battery.c                 |  16 +-
 drivers/power/supply/sc27xx_fuel_gauge.c           |   4 +-
 drivers/power/supply/smb347-charger.c              | 271 ++++++-
 include/dt-bindings/power/summit,smb347-charger.h  |   4 +
 include/linux/linear_range.h                       |   2 +
 include/linux/platform_data/cros_ec_commands.h     |  67 ++
 include/linux/power/max17042_battery.h             |  12 +-
 include/linux/power_supply.h                       |   1 +
 lib/linear_ranges.c                                |  31 +
 39 files changed, 2645 insertions(+), 937 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
 create mode 100644 drivers/power/reset/tps65086-restart.c
 rename drivers/power/supply/{abx500_chargalg.c => ab8500_chargalg.c} (74%)
 create mode 100644 drivers/power/supply/cros_peripheral_charger.c
 create mode 100644 drivers/power/supply/mt6360_charger.c

--yce6kyfcsoaihuun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEop7wACgkQ2O7X88g7
+pp5JQ/+JIQ0+oGc2Fu7vi49AFweQTkNJk4OIEpqCCOukBW/BeJX5EYdarbipmhK
z1SFhyGBzELRFrNZOgLX3P+zvmiet/qCmf4DjKSHi0HVuRe2WW5X0uo+ENUI/g2n
3P4IQ2Gvxc9D2LaAHFqgFDgHpqixaG3gZZ+xDnMXwo01+Qpwv/wgzmANFrOocKkR
/WRNEs+5Kr4Fyt2H7Ixhz3+37hLP2LQCk2FNcmCD1CeRMT5m70iT+J9J77sDiz9F
XjJUNGXAkYV7BatJPCDf6xv38QuUQZrXPmGMP5PbLRmVCp4D5DgtUzlMqLgYDgTV
Ypjx78fjemjF9otyxXtYEobUDvbB+de4A8ByIHkJ3ry9Y3uUhey+j7F+CmbbkU6p
wR6ht7dsKr4rh14VGNSVuMFnhOmow9DpvO5zZvs784RXv1H4gmTwDNvKeL4Eay1t
C6FJtA9Y0fSgfE51tuXmQMU013H77TE6MpI00USyzzQg5xjLF1v8X7S6l5FAUgSL
jup/uT+/MEKQ61diiz6XhC+I2nLbIerjH0jzQxZyPDGQ7hYeT7okM3ESxglHPIEF
OnVQC2dMJycOK2txiuc2haMwbcqyexcqiq+yHNUXnaD6CBhWpDdhZge0z6M+Y9ME
AuuuTF9AhoHn/t2z/dbBnauEl+nuzTSBoZ+GnkIzQ9Bl5nU25TY=
=x3mZ
-----END PGP SIGNATURE-----

--yce6kyfcsoaihuun--
