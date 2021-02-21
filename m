Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1912320E9A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 00:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhBUXut (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Feb 2021 18:50:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhBUXup (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 21 Feb 2021 18:50:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69D7164E2E;
        Sun, 21 Feb 2021 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613951404;
        bh=6hacnVmVBfDVPVg0HrBwY+/up5Gd/RRlaNgdilyoPE4=;
        h=Date:From:To:Cc:Subject:From;
        b=tD4SGFOi2/3l+mOLhMU439GUNWhJ8c0vJJFReD/mxQzFIVEn8afGw3Kd4ZnrJHJmP
         cP1rOtrmSvZgRri716ZpzmTxHS2xram4JyphSEUFuPY2atT0FmMwlkn+XavSnVCxp6
         vcyZ9jEgbA87ugyuCMdElePpj+QNUKCcKKC3IyP0sJiPSY2zHLbMaHK+wWy+GSZiwv
         WubdthtD25wvEKkwvU+IcfqTB4tdI5A0wLjisKPQkzWh1co+gNXuQQBrL45fHNMu3e
         h1Zj9VyClc5x5St0ZsMsjOy604zylTmYQ6/+Qm7U9ssU8xVXDPYwd0w0MpxeLhzy1H
         v8Ea0ATwD1o8Q==
Received: by earth.universe (Postfix, from userid 1000)
        id 842B83C0C96; Mon, 22 Feb 2021 00:50:02 +0100 (CET)
Date:   Mon, 22 Feb 2021 00:50:02 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.12
Message-ID: <20210221235002.yjqkcbuugnusveg6@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yp6m36jp7q6qpjoy"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--yp6m36jp7q6qpjoy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/for-v5.12

for you to fetch changes up to a72acc56f3e939b9e10f2dd460ac1e4519de621f:

  power-supply: use kobj_to_dev() (2021-01-28 01:31:42 +0100)

----------------------------------------------------------------
power supply and reset changes for the v5.12 series

battery/charger driver changes:
 * acer_a500: new fuel gauge driver for Acer Iconia Tab A500
 * bq256xx: new charger driver
 * bq27xxx: Support CHARGE_NOW for bq27z561/bq28z610/bq34z100
 * bq27xxx: Fix inverted CURRENT_NOW sign
 * cpcap: rework fuel gauge and charger drivers
 * ltc4162l: new charger driver
 * max8997-charger: add extcon based current limit configuration
 * max8903, wm97xx, z2: convert to GPIO descriptors (incl. ARM board files)
 * misc. cleanup and fixes

reset drivers:
 * new poweroff driver for ATC260x
 * at91-sama5d2_shdwc: add support for sama7g5
 * drop zte zx driver (SoC support is removed from kernel)

----------------------------------------------------------------
Andreas Kemnade (1):
      power: supply: bq27xxx: fix polarity of current_now

Arnd Bergmann (1):
      power/reset: remove zte zx driver

Arthur Demchenkov (4):
      power: supply: cpcap-battery: Add charge_full property
      power: supply: cpcap-battery: Keep track of state for capacity report=
ing
      power: supply: cpcap-battery: Implement capacity reporting
      power: supply: cpcap-battery: Add charge_now property

Carl Philipp Klemm (1):
      power: supply: cpcap-battery: improve handling of 3rd party batteries.

Claudiu Beznea (3):
      power: reset: at91-sama5d2_shdwc: fix wkupdbc mask
      dt-bindings: atmel-sysreg: add microchip,sama7g5-shdwc
      power: reset: at91-sama5d2_shdwc: add support for sama7g5

Colin Ian King (2):
      power: supply: max8997_charger: fix spelling mistake "diconnected" ->=
 "disconnected"
      power: supply: cpcap-charger: Fix power_supply_put on null battery po=
inter

Cristian Ciocaltea (1):
      power: reset: Add poweroff driver for ATC260x PMICs

Daniel Gonz=E1lez Cabanelas (1):
      power: reset: linkstation-poweroff: add missing put_device()

Dmitry Osipenko (2):
      power: supply: Add battery gauge driver for Acer Iconia Tab A500
      power: supply: smb347-charger: Fix interrupt usage if interrupt is un=
available

Hans de Goede (1):
      power: supply: axp288_fuel_gauge: Add Mele PCG03 to the deny-list

Hermes Zhang (1):
      power: supply: bq27xxx: Support CHARGE_NOW for bq27z561/bq28z610/bq34=
z100

Jian Dong (1):
      power-supply: use kobj_to_dev()

Junlin Yang (2):
      power: supply: charger-manager: fix incorrect health status
      power: supply: charger-manager: fix typo

Linus Walleij (5):
      power: supply: max14656: Drop unused includes
      power: supply: max8903: Absorb pdata header
      power: supply: max8903: Convert to GPIO descriptors
      power: supply: z2_battery: Convert to GPIO descriptors
      power: supply: wm97xx_battery: Convert to GPIO descriptor

Menglong Dong (1):
      power: supply: remove duplicated argument in power_supply_hwmon_info

Mike Looijmans (2):
      power/supply: Add ltc4162-l-charger
      dt-bindings: power/supply: Add ltc4162-l-charger

Pavel Machek (2):
      power: supply: cpcap-charger: Limiting charge current on Droid 4
      power: supply: cpcap-battery: Fix typo

Randy Dunlap (1):
      power: supply: fix sbs-charger build, needs REGMAP_I2C

Ricardo Rivera-Matos (3):
      dt-bindings: power: Add the bq256xx dt bindings
      power: supply: bq256xx: Introduce the BQ256XX charger driver
      power: supply: bq256xx: Fix BQ256XX_NUM_WD_VAL and bq256xx_watchdog_t=
ime[] overrun

Rikard Falkeborn (2):
      power: supply: ltc4162-l: Constify static struct attribute_group
      power: supply: core: Constify static struct attribute_group

Samuel Holland (1):
      power: supply: axp20x_usb_power: Init work before enabling IRQs

Sebastian Reichel (2):
      Merge tag 'ib-psy-pxa-for-5.12-signed' into psy-next
      power: supply: cpcap-battery: constify psy_desc

Tian Tao (1):
      power: supply: ds2780: Switch to using the new API kobj_to_dev()

Timon Baetz (1):
      power: supply: max8997_charger: Set CHARGER current limit

Tom Rix (1):
      power: supply: ingenic: remove unneeded semicolon

Tony Lindgren (10):
      power: supply: cpcap: Add missing IRQF_ONESHOT to fix regression
      power: supply: cpcap-charger: Fix missing power_supply_put()
      power: supply: cpcap-battery: Fix missing power_supply_put()
      power: supply: cpcap-charger: Fix flakey reboot with charger connected
      power: supply: cpcap-charger: Make VBUS already provided debug only
      power: supply: cpcap-charger: Use standard enumeration
      power: supply: cpcap-charger: Drop internal state and use generic sta=
ts
      power: supply: cpcap-charger: Simplify things with enable and disable
      power: supply: cpcap-charger: Provide state updates for battery from =
charger
      power: supply: cpcap-battery: Use charger status for battery full det=
ection

Zheng Yongjun (2):
      power: supply: ab8500_fg: convert comma to semicolon
      power: supply: bq24190_charger: convert comma to semicolon

xinjian (1):
      power: supply: bq25980: Fix repetive bq25975 with bq25960

 .../ABI/testing/sysfs-class-power-ltc4162l         |   82 +
 .../devicetree/bindings/arm/atmel-sysregs.txt      |    5 +-
 .../devicetree/bindings/power/supply/bq256xx.yaml  |  110 ++
 .../bindings/power/supply/ltc4162-l.yaml           |   69 +
 arch/arm/mach-pxa/mioa701.c                        |    1 -
 arch/arm/mach-pxa/palm27x.c                        |    1 -
 arch/arm/mach-pxa/palmte2.c                        |    1 -
 arch/arm/mach-pxa/z2.c                             |   12 +-
 drivers/power/reset/Kconfig                        |   15 +-
 drivers/power/reset/Makefile                       |    2 +-
 drivers/power/reset/at91-sama5d2_shdwc.c           |   74 +-
 drivers/power/reset/atc260x-poweroff.c             |  262 +++
 drivers/power/reset/linkstation-poweroff.c         |    1 +
 drivers/power/reset/zx-reboot.c                    |   86 -
 drivers/power/supply/Kconfig                       |   27 +
 drivers/power/supply/Makefile                      |    3 +
 drivers/power/supply/ab8500_fg.c                   |    2 +-
 drivers/power/supply/acer_a500_battery.c           |  297 ++++
 drivers/power/supply/axp20x_usb_power.c            |    2 +-
 drivers/power/supply/axp288_fuel_gauge.c           |    6 +
 drivers/power/supply/bq24190_charger.c             |    2 +-
 drivers/power/supply/bq256xx_charger.c             | 1749 ++++++++++++++++=
++++
 drivers/power/supply/bq25980_charger.c             |    2 +-
 drivers/power/supply/bq27xxx_battery.c             |   39 +-
 drivers/power/supply/charger-manager.c             |    8 +-
 drivers/power/supply/cpcap-battery.c               |  217 ++-
 drivers/power/supply/cpcap-charger.c               |  262 +--
 drivers/power/supply/ds2760_battery.c              |    2 +-
 drivers/power/supply/ds2780_battery.c              |    8 +-
 drivers/power/supply/ingenic-battery.c             |    2 +-
 drivers/power/supply/ltc4162-l-charger.c           |  931 +++++++++++
 drivers/power/supply/max14656_charger_detector.c   |    2 -
 drivers/power/supply/max8903_charger.c             |  360 ++--
 drivers/power/supply/max8997_charger.c             |   96 ++
 drivers/power/supply/power_supply_hwmon.c          |    2 -
 drivers/power/supply/power_supply_sysfs.c          |    2 +-
 drivers/power/supply/smb347-charger.c              |   12 +-
 drivers/power/supply/wm97xx_battery.c              |   45 +-
 drivers/power/supply/z2_battery.c                  |   46 +-
 include/linux/power/max8903_charger.h              |   43 -
 include/linux/wm97xx.h                             |    1 -
 include/linux/z2_battery.h                         |    1 -
 42 files changed, 4331 insertions(+), 559 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-ltc4162l
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq256xx.=
yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/ltc4162-=
l.yaml
 create mode 100644 drivers/power/reset/atc260x-poweroff.c
 delete mode 100644 drivers/power/reset/zx-reboot.c
 create mode 100644 drivers/power/supply/acer_a500_battery.c
 create mode 100644 drivers/power/supply/bq256xx_charger.c
 create mode 100644 drivers/power/supply/ltc4162-l-charger.c
 delete mode 100644 include/linux/power/max8903_charger.h

--yp6m36jp7q6qpjoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmAy8aIACgkQ2O7X88g7
+ppdRhAAh2PQALJviN0LWQSReBEOJgOegyQKhl4mQthLj3KKQArOTb6Y2bgc4l4e
ZKMezn0GsRju46OiGHYTatwJqVZ/t8P0cu3H76s9cQzU1/dA8jX7lqpXMPtao7ot
J1ZqSFtZzJg0LSVUqg1B1b/RpGfJZ1qvfaNKSN84j2KdNtpS2Adj6StvmJFUsC3j
xdyslYYVKSdSJ9gRvRRNTu3GET2nrHBuoNnFgwTn2EsuXPLt0DzEOElUi1KpAUSd
JURcbZCmxruQx1FM5Bjdutq/Hn+mX/7IaXiGYefMXQNG52LxvS7gO4yJpFcyiA+I
4hjdctSzIqMnSuqKDoJr+JYRV/kiHgRCTy+sYjwhfotU6l5jsf5u2xYsxvhMyZJe
9rphWTBnbGnCnNnsLKEZDngVSLm/gy1dLv+1/sO0A3ucphhCP7tb8aYWJsa/zmzx
axkw6AGdMwLObz2ovo/q7OgAg3q/sDFSBBw03SAJGq2piOVxFUwLLzSl63N/8IjM
zjNo7t571SchKQPfCCZMtNPCswAx3PCK1myAswIzxGe/LbifBqmNXJ/ssADZ4qem
wp6bT+L/tjCJuagXx2hvy+QqHlQj4baixtAIdSK8Pv76yJ0DaMa8BnZUCUDxag9u
mQKABPz9uXwfsAEzRlm6EuoiM7TAHP65/8WQ0B0B4TwtlXPMEI8=
=bLFk
-----END PGP SIGNATURE-----

--yp6m36jp7q6qpjoy--
