Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5EA14D339
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 23:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgA2Wt3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 17:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgA2Wt3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jan 2020 17:49:29 -0500
Received: from earth.universe (dyndsl-095-033-170-182.ewe-ip-backbone.de [95.33.170.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54EAA206D5;
        Wed, 29 Jan 2020 22:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580338168;
        bh=R4R61fV6zl3ecz3GL/seP+pfgkzhu2DRdAZLGCd/Dx0=;
        h=Date:From:To:Cc:Subject:From;
        b=X7hctuvnZ1Iv499bjytepuyMrQzvLdYp+Hra7eDVucw9ew03vD/ftaQ9sXaO8VBvw
         CMv/sJn21dym63eolTv1r/rkJS2C7+CYO22c2INGUpTu6FSnIVmWt05vJKzG7XEyhK
         FSxPG4DeFUk1LYET3g8fV/OxVqU8jhXriAHPMxpI=
Received: by earth.universe (Postfix, from userid 1000)
        id 8C8FE3C0C7F; Wed, 29 Jan 2020 23:49:26 +0100 (CET)
Date:   Wed, 29 Jan 2020 23:49:26 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.6
Message-ID: <20200129224926.owfuj6mfya4crpwm@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vyxrw76l7bm35igj"
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vyxrw76l7bm35igj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.6

for you to fetch changes up to 3d32a8437c051013352baf5cbd0844fcf5d2f409:

  power: supply: ipaq_micro_battery: remove unneeded semicolon (2020-01-17 02:13:00 +0100)

----------------------------------------------------------------
power supply and reset changes for the v5.6 series

Core:
 * Add battery internal resistance temperature table support

Drivers:
 * sc27xx: Optimize the battery resistance with measuring temperature
 * max17042-battery: Add MAX17055 support
 * bq25890-charger: Add support of BQ25892 and BQ25896 chips
 * misc. fixes

----------------------------------------------------------------
Angus Ainslie (Purism) (2):
      device-tree: bindings: max17042_battery: add all of the compatible strings
      power: supply: max17042: add MAX17055 support

Baolin Wang (4):
      dt-bindings: power: Introduce one property to describe the battery resistance with temperature changes
      power: supply: core: Add battery internal resistance temperature table support
      dt-bindings: power: sc27xx: Add a new property to describe the real resistance of coulomb counter chip
      power: supply: sc27xx: Calibrate the resistance of coulomb counter

Bartosz Golaszewski (1):
      power: supply: max77650: add of_match table

Chen Wandun (1):
      power: suppy: ucs1002: Make the symbol 'ucs1002_regulator_enable' static

Chen Zhou (1):
      power: supply: ipaq_micro_battery: remove unneeded semicolon

Chris Packham (1):
      power: reset: gpio-restart: don't error on deferral

Chuhong Yuan (1):
      power: supply: pda_power: add missed usb_unregister_notifier

Claudiu Beznea (2):
      power: reset: at91-poweroff: introduce struct shdwc_reg_config
      power: reset: at91-poweroff: use proper master clock register offset

Colin Ian King (1):
      power: supply: bq25890_charger: fix incorrect error return when bq25890_field_read fails

Dan Carpenter (1):
      power: supply: sbs-battery: Fix a signedness bug in sbs_get_battery_capacity()

Dan Murphy (1):
      power: supply: core: Update sysfs-class-power ABI document

Enric Balletbo i Serra (1):
      power: supply: cros_usbpd: Remove dev_err() getting the number of ports

Jean-Francois Dagenais (2):
      power: supply: sbs-battery: use octal permissions on module param
      power: supply: sbs-battery: fix CAPACITY_MODE bit naming

Krzysztof Kozlowski (2):
      power: supply: Fix Kconfig indentation
      power: reset: Fix Kconfig indentation

Lucas Stach (1):
      power: suppy: ucs1002: disable power when max current is 0

Ma Feng (3):
      power: supply: ab8500: Remove unneeded semicolon
      power: supply: ab8500_charger: Remove unneeded semicolon
      power: supply: abx500_chargalg: Remove unneeded semicolon

Marek Szyprowski (1):
      power: supply: max17040: Correct IRQ wake handling

Matheus Castello (4):
      dt-bindings: power: supply: max17040: Add DT bindings for max17040 fuel gauge
      power: supply: max17040: Add IRQ handler for low SOC alert
      power: supply: max17040: Config alert SOC low level threshold from FDT
      power: supply: max17040: Send uevent in SOC and status change

Paul Cercueil (1):
      power/supply: ingenic-battery: Don't change scale if there's only one

Samuel Holland (8):
      power: supply: axp20x_ac_power: Fix reporting online status
      power: supply: axp20x_ac_power: Allow offlining
      power: supply: axp20x_ac_power: Add wakeup control
      power: supply: axp20x_usb_power: Remove unused device_node
      power: supply: axp20x_usb_power: Use a match structure
      power: supply: axp20x_usb_power: Allow offlining
      power: supply: axp20x_usb_power: Add wakeup control
      power: supply: axp20x_usb_power: Only poll while offline

Sven Van Asbroeck (1):
      power: supply: ltc2941-battery-gauge: fix use-after-free

Yauhen Kharuzhy (3):
      power: supply: bq25890_charger: Add support of BQ25892 and BQ25896 chips
      dt-bindings: Add new chips to bq25890 binding documentation
      power: supply: bq25890_charger: Add DT and I2C ids for all supported chips

Yuanjiang Yu (1):
      power: supply: sc27xx: Optimize the battery resistance with measuring temperature

 Documentation/ABI/testing/sysfs-class-power        |   3 +-
 .../devicetree/bindings/power/supply/battery.txt   |   5 +
 .../devicetree/bindings/power/supply/bq25890.txt   |   7 +-
 .../bindings/power/supply/max17040_battery.txt     |  33 ++++
 .../bindings/power/supply/max17042_battery.txt     |   6 +-
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |   3 +
 drivers/power/reset/Kconfig                        |  16 +-
 drivers/power/reset/at91-sama5d2_shdwc.c           |  72 ++++---
 drivers/power/reset/gpio-restart.c                 |   8 +-
 drivers/power/supply/Kconfig                       |  30 +--
 drivers/power/supply/ab8500_charger.c              |   6 +-
 drivers/power/supply/ab8500_fg.c                   |  14 +-
 drivers/power/supply/abx500_chargalg.c             |   2 +-
 drivers/power/supply/axp20x_ac_power.c             | 131 +++++++++---
 drivers/power/supply/axp20x_usb_power.c            | 219 ++++++++++++++++-----
 drivers/power/supply/bq25890_charger.c             | 103 ++++++++--
 drivers/power/supply/cros_usbpd-charger.c          |  10 +-
 drivers/power/supply/ingenic-battery.c             |  15 +-
 drivers/power/supply/ipaq_micro_battery.c          |   6 +-
 drivers/power/supply/ltc2941-battery-gauge.c       |   2 +-
 drivers/power/supply/max17040_battery.c            | 122 +++++++++++-
 drivers/power/supply/max17042_battery.c            |  17 +-
 drivers/power/supply/max77650-charger.c            |   7 +
 drivers/power/supply/pda_power.c                   |   4 +
 drivers/power/supply/power_supply_core.c           |  67 ++++++-
 drivers/power/supply/sbs-battery.c                 |  35 ++--
 drivers/power/supply/sc27xx_fuel_gauge.c           |  49 ++++-
 drivers/power/supply/ucs1002_power.c               |  42 +++-
 include/linux/power/max17042_battery.h             |  48 ++++-
 include/linux/power_supply.h                       |  10 +
 30 files changed, 882 insertions(+), 210 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

--vyxrw76l7bm35igj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4yC/YACgkQ2O7X88g7
+pobKRAAgP4xDWKKKWWvOES6AjQ0sgRN10ZDBbrRy8VGNZ9GZTgcBqqW+wHujOU/
6xyYN4vNUXNlLEbKmast0N//RSra68fTp38XiCMxzDNqocwZnLaadKW8zCg6nLjl
+Mu7VtHDiBvElsAb53E+d9Vf86aEpPcVX/y+SMz93wHed96fT1+EpjKOX8AL4Ung
JElf/RJjnffLXidIEPQnV3RFFIun20jnkdxqD+RshDzwPDKSFhu5PLEGicrmKV47
VY5NbRCnz+xr2/HT3jOWmfrq83zuvfi3diCwXsFFFgNgIaMaeLXTp2heADs23QK5
Xhug0ouxVu17paW6KaEjcv+JpE2KVYn+uZUzX+m2nizChOB0m6jDrq3A4mQkCcmc
5e3my8leWgsZ79JK3N8vq4A+PCiNcu7rdv5Xe86JRnK1K4wlzo+8ZB05gVaWZ6YN
3gt4qGRUjYMxdHbtYQQOvVwy7GjAko3qADz53ou6pOUfSTqaB7yDYkwvQaVByetT
ocWNgwOg0aw+wKfjQyF96oZw0TwCMLtPR3rZJmb89P3D9xUdOOko8a4BmW1vb60G
yEi6g+enz68H1jxULEazpkpwi48olcmoCgf8EDOh19j/5CO0i+mTHUiburyHvCk0
dh6wQY30Hvxk7us5ElJR9ld6a77sP05DpSp+A0S4nCuEX4XRQQI=
=7PU4
-----END PGP SIGNATURE-----

--vyxrw76l7bm35igj--
