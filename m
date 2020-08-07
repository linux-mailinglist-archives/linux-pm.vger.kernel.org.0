Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DFE23F50E
	for <lists+linux-pm@lfdr.de>; Sat,  8 Aug 2020 00:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGW7r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Aug 2020 18:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgHGW7q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Aug 2020 18:59:46 -0400
Received: from earth.universe (unknown [95.33.152.0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B61F20866;
        Fri,  7 Aug 2020 22:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596841185;
        bh=OKlwQpmZVQ3qO7aGJBHKETrCWwGnjbQlj5eQ6u796b4=;
        h=Date:From:To:Cc:Subject:From;
        b=BauPeCuOtKayFdlD3gtWq1yeXNsC3Xe2DCx5McCH/MrAv6RpNcPLX4M1rUltS3QDW
         cOdr7zzSlkz9VytYHyjxoGvDSs61gnT1L377vWn/VDtL83IrM50U7gFFNxgbYZvGf8
         ve/cW35XKcQXEApLrz9Yymf4dD83/FZ0y9ByzYT4=
Received: by earth.universe (Postfix, from userid 1000)
        id BEFD83C0C80; Sat,  8 Aug 2020 00:59:43 +0200 (CEST)
Date:   Sat, 8 Aug 2020 00:59:43 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] power-supply changes for 5.9
Message-ID: <20200807225943.cdfvw5m6h7ywgrmc@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n7bt4iw4u6yl7qkt"
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--n7bt4iw4u6yl7qkt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull the power-supply changes for the 5.9 development cycle.
Stephen mentioned one trivial merge conflict between the
power-supply tree and the set_fs tree and has the correct solution:

https://lore.kernel.org/linux-next/20200727210137.01a5d03d@canb.auug.org.au/

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/for-v5.9

for you to fetch changes up to 46cbd0b05799e8234b719d18f3a4b27679c4c92e:

  power: supply: wilco_ec: Add long life charging mode (2020-07-31 14:33:56=
 +0200)

----------------------------------------------------------------
power supply and reset changes for the v5.9 series

power-supply core:
 * add COOL/WARM/HOT state from JEITA JISC8712:2015 specification
 * convert simple-battery DT binding to YAML
 * add long-life charging mode

battery/charger drivers:
 * bq25150: new charger driver
 * bq27xxx: add support for BQ27z561 and BQ28z610
 * max17040: support CAPACITY_ALERT_MIN
 * sbs-battery: add PEC support
 * wilco-ec: support long-life charging mode
 * bq25890: fix DT binding
 * misc. fixes and cleanups

reset drivers:
 * linkstation: new reset driver

----------------------------------------------------------------
Alexander A. Klimov (2):
      power: reset: keystone-reset: Replace HTTP links with HTTPS ones
      power: supply: bq2xxxx: Replace HTTP links with HTTPS ones

Chunyan Zhang (2):
      math64: New DIV_S64_ROUND_CLOSEST helper
      power: supply: sc27xx: prevent adc * 1000 from overflow

Crag Wang (1):
      power: supply: wilco_ec: Add long life charging mode

Dan Murphy (6):
      power_supply: Add additional health properties to the header
      dt-bindings: power: Convert battery.txt to battery.yaml
      dt-bindings: power: Add BQ27Z561 compatible
      power: supply: bq27xxx_battery: Add the BQ27Z561 Battery monitor
      dt-bindings: power: Add BQ28z610 compatible
      power: supply: bq27xxx_battery: Add the BQ28z610 Battery monitor

Daniel Gonz=E1lez Cabanelas (1):
      power: reset: add driver for LinkStation power off

Dinghao Liu (1):
      power: supply: bq24190_charger: Fix runtime PM imbalance on error

Jonathan Bakker (1):
      power: supply: max8998_charger: Correct ONLINE and add STATUS props

Keyur Patel (1):
      power: supply: axp20x_usb_power: fix spelling mistake

Krzysztof Kozlowski (4):
      dt-bindings: power: supply: bq25890: Indent example with tabs
      dt-bindings: power: supply: bq25890: Document required interrupt
      power: supply: cpcap-battery: Fix kerneldoc of cpcap_battery_read_acc=
umulated()
      power: supply: Fix kerneldoc of power_supply_temp2resist_simple()

LH Lin (1):
      power: supply: test_power: Fix battery_current initial value

Matheus Castello (1):
      power: supply: max17040: Add POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN

Peng Fan (1):
      power: supply: rt5033_battery: Fix error code in rt5033_battery_probe=
()

Randy Dunlap (1):
      power: fix duplicated words in bq2415x_charger.h

Ricardo Rivera-Matos (2):
      dt-bindings: power: Add the bindings for the bq2515x family of charge=
rs.
      power: supply: bq25150 introduce the bq25150

Sebastian Reichel (4):
      dt-bindings: power: supply: gpio-charger: convert to yaml
      power: supply: gpio-charger: Make gpios optional
      power: supply: sbs-battery: use i2c_smbus_read_block_data()
      power: supply: sbs-battery: add PEC support

Tom Rix (1):
      power: supply: check if calc_soc succeeded in pm860x_init_battery

Wang Qing (1):
      power: supply: use kobj_to_dev

Yongqiang Liu (1):
      power: Convert to DEFINE_SHOW_ATTRIBUTE

 Documentation/ABI/testing/sysfs-class-power        |    3 +-
 Documentation/ABI/testing/sysfs-class-power-wilco  |    4 +
 .../devicetree/bindings/power/supply/battery.txt   |   86 +-
 .../devicetree/bindings/power/supply/battery.yaml  |  144 +++
 .../devicetree/bindings/power/supply/bq2515x.yaml  |   93 ++
 .../devicetree/bindings/power/supply/bq25890.txt   |   30 +-
 .../devicetree/bindings/power/supply/bq27xxx.yaml  |    2 +
 .../bindings/power/supply/gpio-charger.txt         |   31 -
 .../bindings/power/supply/gpio-charger.yaml        |   63 ++
 drivers/power/reset/Kconfig                        |   11 +
 drivers/power/reset/Makefile                       |    1 +
 drivers/power/reset/keystone-reset.c               |    2 +-
 drivers/power/reset/linkstation-poweroff.c         |  136 +++
 drivers/power/supply/88pm860x_battery.c            |    6 +-
 drivers/power/supply/Kconfig                       |   13 +
 drivers/power/supply/Makefile                      |    1 +
 drivers/power/supply/axp20x_usb_power.c            |    2 +-
 drivers/power/supply/bq2415x_charger.c             |   16 +-
 drivers/power/supply/bq24190_charger.c             |    4 +-
 drivers/power/supply/bq24257_charger.c             |    6 +-
 drivers/power/supply/bq2515x_charger.c             | 1169 ++++++++++++++++=
++++
 drivers/power/supply/bq27xxx_battery.c             |  160 ++-
 drivers/power/supply/bq27xxx_battery_hdq.c         |    2 +-
 drivers/power/supply/bq27xxx_battery_i2c.c         |    6 +-
 drivers/power/supply/cpcap-battery.c               |    2 +-
 drivers/power/supply/da9030_battery.c              |   12 +-
 drivers/power/supply/gpio-charger.c                |   38 +-
 drivers/power/supply/max17040_battery.c            |   51 +-
 drivers/power/supply/max8998_charger.c             |   25 +-
 drivers/power/supply/power_supply_core.c           |    2 +-
 drivers/power/supply/power_supply_sysfs.c          |    6 +-
 drivers/power/supply/rt5033_battery.c              |    2 +-
 drivers/power/supply/sbs-battery.c                 |   89 +-
 drivers/power/supply/sc27xx_fuel_gauge.c           |    9 +-
 drivers/power/supply/test_power.c                  |    2 +-
 drivers/power/supply/wilco-charger.c               |    5 +
 include/linux/math64.h                             |   19 +
 include/linux/power/bq2415x_charger.h              |    4 +-
 include/linux/power/bq27xxx_battery.h              |    2 +
 include/linux/power_supply.h                       |    4 +
 40 files changed, 2044 insertions(+), 219 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.=
yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.=
yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/gpio-cha=
rger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/gpio-cha=
rger.yaml
 create mode 100644 drivers/power/reset/linkstation-poweroff.c
 create mode 100644 drivers/power/supply/bq2515x_charger.c

--n7bt4iw4u6yl7qkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8t3M0ACgkQ2O7X88g7
+poUrQ//eWJTZcVDFsWgWepCSQSYXVCnyFlQtX4yPjOh3FbdskDbaV4Lfw5oaRH8
Q6wXY0lhEAHqQSYQac5BNTRMx3diA7UzjIqy5ovUMnB9Q886BX0D1VC9wcHyDvEL
0JgF/8mD/DK75dAHC3DpcEyW7NcZ5dlKg4eCLxtL3e+Ak6s7/iNqm/F9DU+zPwLq
W6h9u8+fr8jbbzfWdo/PkUSyemi/LvUHqC/vwywZZWSzOVBrRspFb54GFiM34/rJ
LLTa6W4vuAS2yLqif5W+1e+qYy0/+LW8vLuAYE7ZBPRGPj1Fb+YqAy9OWVfJa0ab
Ab2k1TwLHtz0CKdTn8lS/OpQdMBMmdVSQhN5VaMWrEmDHvBzyr2gk3r1Il3s1OMM
FbXbtgZBOplCADANiqZEWc1uz4ztU4Uov4DKm8VNdOY6jJRPBCsz5XeLoSecKBmc
MycotdH2dN0ii0DGRYFfctPPGqSPNxdwYiwcoTwL9o9F0OcYg3uLWUHpjL+rx2TZ
vlR9yY1n83CE7lCg8m3iUsxALwOoRQ9Z8PdObuxyvi4yBOhXw0oWreRDsJEimgIQ
OZMiXPY38GOTQY7E1zjOWFOBzwl4iVXvGFXK6A17EMUM+/EALuX2PvJ5EfVCdtgs
eiOwSXNXiKLRPQ8kGtCzO0ydli9duRpZICVP/GHbSKA8AdbiWgo=
=1wFC
-----END PGP SIGNATURE-----

--n7bt4iw4u6yl7qkt--
