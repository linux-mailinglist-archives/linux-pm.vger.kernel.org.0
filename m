Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A68293032
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 23:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbgJSVIh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 17:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732495AbgJSVIh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Oct 2020 17:08:37 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA6A22282;
        Mon, 19 Oct 2020 21:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603141715;
        bh=uF0PNfHiox/oHKa9qtJANU9pYn+637+4mD50qc8UIQ4=;
        h=Date:From:To:Cc:Subject:From;
        b=Me30rbQ9xp8qu3iis4TZCKkBBZIuMQATsKFLPQEHOxiO/MfAatyKvb5Zr/U+vWFCY
         4guIY5Z6pj2Gu3hRSbUGMNsoAir1seU4265/NSwyxghnRK9kN+D0zWUeCB4grE5+g5
         ECAQic9bs33lXjAQ4onoS/TJMyLfblOPx7fo71S8=
Received: by earth.universe (Postfix, from userid 1000)
        id 1C48D3C0C8E; Mon, 19 Oct 2020 23:08:33 +0200 (CEST)
Date:   Mon, 19 Oct 2020 23:08:33 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.10
Message-ID: <20201019210833.ll5l2g3ok5kyi6r6@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nvzplde2bn7bpea6"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--nvzplde2bn7bpea6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/for-v5.10

for you to fetch changes up to 7007fab4ae82c092cb52691c338f1b776005e32b:

  power: reset: POWER_RESET_OCELOT_RESET should depend on Ocelot or Sparx5 =
(2020-10-15 21:37:59 +0200)

----------------------------------------------------------------
power supply and reset changes for the v5.10 series

power-supply core:
 * Add wireless type
 * Properly document current direction

battery/charger driver changes:
 * New fuel-gauge/charger driver for RN5T618/RN5T619
 * New charger driver for BQ25980, BQ25975 and BQ25960
 * bq27xxx-battery: add support for TI bq34z100
 * gpio-charger: convert to GPIO descriptors
 * gpio-charger: add optional support for charge current limiting
 * max17040: add support for max17041, max17043, max17044
 * max17040: add support for max17048, max17049, max17058, max17059
 * smb347-charger: add DT support
 * smb247-charger: add SMB345 and SMB358 support
 * simple-battery: add temperature properties
 * lots of minor fixes, cleanups and DT binding YAML conversions

reset drivers:
 * ocelot: Add support for Sparx5

----------------------------------------------------------------
Alex Dewar (1):
      power: supply: Add dependency to lego-ev3-battery Kconfig options

Andreas Kemnade (1):
      power: supply: Add support for RN5T618/RC5T619 charger and fuel gauge

Artur Rojek (2):
      dt-bindings: power: Convert ingenic,battery.txt to YAML
      dt-bindings: power: ingenic,battery: add new compatibles

Colin Ian King (4):
      power: supply: pm2301_charger: fix spelling mistake "chargind" -> "ch=
arging"
      power: supply: fix spelling mistake "unprecise" -> "imprecise"
      power: supply: bq25980: remove redundant zero check on ret
      power: supply: charger-manager: fix incorrect check on charging_durat=
ion_ms

Dan Murphy (6):
      power: bq27xxx: Update to SPDX licensing
      MAINTAINERS: Remove Andrew F. Davis
      dt-binding: bq25980: Add the bq25980 flash charger
      power: supply: bq25980: Add support for the BQ259xx family
      power: supply: bq25980: Fix uninitialized wd_reg_val
      power: supply: bq25980: Fix uninitialized wd_reg_val and overrun

David Heidelberg (5):
      power: supply: smb347-charger: Use resource-managed API
      dt-bindings: power: supply: Add device-tree binding for Summit SMB3xx
      power: supply: smb347-charger: Implement device-tree support
      power: supply: smb347-charger: Support SMB345 and SMB358
      power: supply: smb347-charger: Remove virtual smb347-battery

Dmitry Osipenko (3):
      dt-bindings: battery: Add temperature properties
      power: supply: Support battery temperature device-tree properties
      power: supply: smb347-charger: Replace mutex with IRQ disable/enable

Elliot Berman (1):
      dt-bindings: power: reset: Convert reboot-mode to YAML

Geert Uytterhoeven (1):
      power: reset: POWER_RESET_OCELOT_RESET should depend on Ocelot or Spa=
rx5

Harley A.W. Lorenzo (1):
      power: supply: test-power: revise parameter printing to use sprintf

Ikjoon Jang (4):
      power: supply: sbs-battery: remove unused enable_detection flags
      power: supply: sbs-battery: combine get_presence_and_health
      power: supply: sbs-battery: don't assume i2c errors as battery discon=
nect
      power: supply: sbs-battery: keep error code when get_property() fails

Iskren Chernev (9):
      power: supply: max17040: Use devm_ to automate remove
      power: supply: max17040: Use regmap i2c
      dt-bindings: power: supply: Extend max17040 compatibility
      power: supply: max17040: Support compatible devices
      dt-bindings: power: supply: max17040: Add maxim,rcomp
      power: supply: max17040: Support setting rcomp
      power: supply: max17040: Support soc alert
      power: supply: max17040: Fix ptr to enum cast
      power: supply: ltc2941: Fix ptr to enum cast

Jonathan Bakker (4):
      power: supply: charger-manager: Always use POWER_SUPPLY_PROP_TEMP
      power: supply: charger-manager: Update extcon functions
      power: supply: charger-manager: Count cm-chargers property directly
      dt-bindings: power: supply: Cleanup charger-manager bindings

Jonghwa Lee (6):
      power: supply: charger-manager: Swap private uevent for power_supply_=
changed
      power: supply: charger-manager: Remove cm_notify_event function
      power: supply: charger-manager: Correct usage of CHARGE_NOW/FULL
      power: supply: charger-manager: Collect all power_supply_changed() ca=
lls
      power: supply: charger-manager: Make decisions focussed on battery st=
atus
      power: supply: charger-manager: Don't start charging in cable nofitic=
ation

Krzysztof Kozlowski (18):
      power: supply: bq27xxx: Simplify with dev_err_probe()
      power: supply: cpcap: Simplify with dev_err_probe()
      power: supply: gpio-charger: Simplify with dev_err_probe()
      power: supply: ingenic: Simplify with dev_err_probe()
      power: supply: lego_ev3: Simplify with dev_err_probe()
      dt-bindings: power: bq27xxx: add bq34z100
      power: supply: bq27xxx: report "not charging" on all types
      power: supply: bq27xxx: adjust whitespace and use BIT() for bitflags
      power: supply: bq27xxx: add separate flag for single SoC register
      power: supply: bq27xxx: add separate flag for capacity inaccurate
      power: supply: bq27xxx: add support for TI bq34z100
      power: supply: bq24257: skip 'struct acpi_device_id' when !CONFIG_ACPI
      power: supply: bq2515x: fix kerneldoc
      power: supply: bq25890: skip 'struct acpi_device_id' when !CONFIG_ACPI
      power: supply: goldfish: skip 'struct acpi_device_id' when !CONFIG_AC=
PI
      power: supply: rt9455: skip 'struct acpi_device_id' when !CONFIG_ACPI
      power: supply: charger-manager: drop unused charger assignment
      power: supply: pm2301: drop duplicated i2c_device_id

Lars Povlsen (2):
      dt-bindings: reset: ocelot: Add Sparx5 support
      power: reset: ocelot: Add support for Sparx5

Linus Walleij (1):
      power: supply: gpio-charger: Convert to GPIO descriptors

Lucas Stach (1):
      power: supply: ucs1002: fix some health status issues

Micha=C5=82 Miros=C5=82aw (2):
      power: supply: bq25890: support IBAT compensation
      power: supply: bq25890: document IBAT compensation DT properties

Rikard Falkeborn (1):
      power: supply: bq2515x: Constify static variables

Sebastian Reichel (5):
      Merge tag 'psy-arm-gpio-charger-immutable-for-5.10-signed' into psy-n=
ext
      power: supply: gpio-charger: add charge-current-limit feature
      power: supply: smb347-charger: Drop pdata support
      power: supply: smb347-charger: Use generic property framework
      power: supply: document current direction

Subbaraman Narayanamurthy (1):
      power: supply: add wireless type

Wang Qing (2):
      power: supply: ds278x: fix spelling typo
      power: supply: ab8500-fg: fix spelling typo

Xiongfeng Wang (1):
      power: supply: test_power: add missing newlines when printing paramet=
ers by sysfs

 Documentation/ABI/testing/sysfs-class-power        |    8 +-
 .../bindings/power/reset/ocelot-reset.txt          |    7 +-
 .../bindings/power/reset/reboot-mode.txt           |   25 -
 .../bindings/power/reset/reboot-mode.yaml          |   47 +
 .../devicetree/bindings/power/supply/battery.yaml  |   24 +
 .../devicetree/bindings/power/supply/bq25890.txt   |    4 +
 .../devicetree/bindings/power/supply/bq25980.yaml  |  114 ++
 .../devicetree/bindings/power/supply/bq27xxx.yaml  |    1 +
 .../bindings/power/supply/charger-manager.txt      |   30 +-
 .../bindings/power/supply/gpio-charger.yaml        |   31 +
 .../bindings/power/supply/ingenic,battery.txt      |   31 -
 .../bindings/power/supply/ingenic,battery.yaml     |   61 +
 .../bindings/power/supply/max17040_battery.txt     |   21 +-
 .../power/supply/summit,smb347-charger.yaml        |  152 +++
 MAINTAINERS                                        |    4 +-
 arch/arm/mach-pxa/tosa.c                           |   12 +-
 arch/arm/mach-sa1100/collie.c                      |   14 +-
 drivers/power/reset/Kconfig                        |    4 +-
 drivers/power/reset/ocelot-reset.c                 |   55 +-
 drivers/power/supply/Kconfig                       |   36 +-
 drivers/power/supply/Makefile                      |    2 +
 drivers/power/supply/ab8500_fg.c                   |    4 +-
 drivers/power/supply/bq24257_charger.c             |    2 +
 drivers/power/supply/bq2515x_charger.c             |   14 +-
 drivers/power/supply/bq25890_charger.c             |   17 +-
 drivers/power/supply/bq25980_charger.c             | 1314 ++++++++++++++++=
++++
 drivers/power/supply/bq25980_charger.h             |  178 +++
 drivers/power/supply/bq27xxx_battery.c             |  102 +-
 drivers/power/supply/bq27xxx_battery_hdq.c         |    9 +-
 drivers/power/supply/bq27xxx_battery_i2c.c         |   12 +-
 drivers/power/supply/charger-manager.c             |  578 +++------
 drivers/power/supply/cpcap-battery.c               |    7 +-
 drivers/power/supply/ds2780_battery.c              |    6 +-
 drivers/power/supply/ds2781_battery.c              |    6 +-
 drivers/power/supply/goldfish_battery.c            |    2 +
 drivers/power/supply/gpio-charger.c                |  172 ++-
 drivers/power/supply/ingenic-battery.c             |    8 +-
 drivers/power/supply/lego_ev3_battery.c            |   24 +-
 drivers/power/supply/ltc2941-battery-gauge.c       |    3 +-
 drivers/power/supply/max17040_battery.c            |  489 +++++---
 drivers/power/supply/pm2301_charger.c              |    7 +-
 drivers/power/supply/power_supply_core.c           |   19 +
 drivers/power/supply/power_supply_sysfs.c          |    1 +
 drivers/power/supply/rn5t618_power.c               |  556 +++++++++
 drivers/power/supply/rt9455_charger.c              |    2 +
 drivers/power/supply/sbs-battery.c                 |  125 +-
 drivers/power/supply/smb347-charger.c              |  692 ++++++-----
 drivers/power/supply/test_power.c                  |   26 +-
 drivers/power/supply/ucs1002_power.c               |   75 +-
 include/dt-bindings/power/summit,smb347-charger.h  |   19 +
 include/linux/power/bq27xxx_battery.h              |    1 +
 include/linux/power/charger-manager.h              |   41 +-
 include/linux/power/gpio-charger.h                 |    6 -
 include/linux/power/smb347-charger.h               |  114 --
 include/linux/power_supply.h                       |    7 +
 55 files changed, 3938 insertions(+), 1383 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mo=
de.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mo=
de.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq25980.=
yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/ingenic,=
battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/ingenic,=
battery.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/summit,s=
mb347-charger.yaml
 create mode 100644 drivers/power/supply/bq25980_charger.c
 create mode 100644 drivers/power/supply/bq25980_charger.h
 create mode 100644 drivers/power/supply/rn5t618_power.c
 create mode 100644 include/dt-bindings/power/summit,smb347-charger.h
 delete mode 100644 include/linux/power/smb347-charger.h

--nvzplde2bn7bpea6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl+OAE0ACgkQ2O7X88g7
+ppSsg/+M41RTmH2bKiMqf6RwTJs/X9DYya90c9BsioLhYsmHCV/CsHNMpFHG/+Y
rNSm8E7D7PlupOuCUpEIAluFgXh4ZMKT71VKbQYopMStzgzGDREMxYjMwDuDFCI6
XZqzsew6mIO3MyntXFl+2dGt4w9GhEoMpnrq3V6YnIv0/2L9VSriqLXjT8FNH4mq
1FEPi7fMGUAjjjSdePreVBDURc+cfyeG9dPeP/6HfMQ6V5gEGNiL2A2y8n2vUUwk
YUpY67GRW5x/rZuseSD3uuc9FYM20uL5R/wZJwqaKwiL68iQJ/XFdAyaMf1z4dYx
kiTFL6BORQmNwQBj0dPaBpC+cBgu+DnBC0cZZ2d0Mo6AkkTJsAcakgNWwEMgWjSB
EOcmtqV4A4bKuEp6IW4m47I5cEFNnM7VuF2a6a/FdmrRgIw3TSxi3jjECNLdZW10
E1KD3kSrEeW5Wsbo11oYje+xnln2sGBvab3/KHH8OnxAvQFkimZenKHcBsBsgoiA
4ceuMlxyeaxR1JyqSlEUuCHlZm4jexCMCr3V3pZyuhHZjeg/iisVI8M/mJjr/UgL
qSVDs37AnE0j0kvIEAr0nGP3kxdKC2+cR/3t9Y1qUZ5WyNJD5fMTC8JQpy6D2Az4
9BIyYtq/olgF6jlg1DrDx61DNZ337xbwXvbKgmIe8aSkwz/ewHs=
=/5yB
-----END PGP SIGNATURE-----

--nvzplde2bn7bpea6--
