Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3097D3BEC89
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhGGQuu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 12:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbhGGQuu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 12:50:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FE3361C83;
        Wed,  7 Jul 2021 16:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625676489;
        bh=k0JV4tSCIZihgVLBxZqxe5k6bWz3d1873m0Xerujc8c=;
        h=Date:From:To:Cc:Subject:From;
        b=KlK6Rr1NJJA0wJAx/LcU9EVmjCLGPIPHTCKXlMq9Nl+thtAaREoqx1XfP+JR1kW2c
         ehAZpvXECyhe3J+sUlnd5FOMhtOJA6uEkyHCflFHCBEmAWHwDMWmtr6KKxHQ1oqYEn
         Z6E8nyx6obSuZF06WyOZr6YIFdtKsfGXxr4+es3Z99nx9djrmtnbba9L/oe/LNfbu7
         Ji4mNF3I+KVvPGSMsOMmIujH4qXXCUpbhgFfXmKjulYcHFZUL40gtnXHk0V4SEl9YV
         5mFko7DDGtSztLkt1OfMmzYzlbjkuEsGfQ4wAJiEHP9IXZNnkenLH9FF97e1CEmUoB
         w5ahxGS1nvJDQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 7778F3C0C97; Wed,  7 Jul 2021 18:47:32 +0200 (CEST)
Date:   Wed, 7 Jul 2021 18:47:32 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.14
Message-ID: <20210707164732.4vcivdobkykccrha@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="evu6hrxzrrci4lu3"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--evu6hrxzrrci4lu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.14

for you to fetch changes up to f1c74a6c07e76fcb31a4bcc1f437c4361a2674ce:

  power: supply: ab8500: Fix an old bug (2021-06-30 00:14:55 +0200)

----------------------------------------------------------------
power supply and reset changes for the v5.14 series

battery/charger driver changes:
 * convert charger-manager binding to YAML
 * drop bd70528-charger driver
 * drop pm2301-charger driver
 * introduce rt5033-battery driver
 * misc. improvements and fixes

----------------------------------------------------------------
Andreas Kemnade (2):
      power: supply: rn5t618: Add charger type detection
      power: supply: rn5t618: Add input current limit

Andy Shevchenko (1):
      power: supply: bq24190_charger: drop of_match_ptr() from device ID table

Bixuan Cui (1):
      power: reset: gpio-poweroff: add missing MODULE_DEVICE_TABLE

Carl Philipp Klemm (2):
      power: supply: cpcap-battery: invalidate config when incompatible measurements are read
      power: supply: cpcap-charger: get the battery inserted infomation from cpcap-battery

Colin Ian King (1):
      power: supply: axp288_fuel_gauge: remove redundant continue statement

Guenter Roeck (1):
      power: supply: ab8500: Drop unnecessary NULL check after container_of

Hans de Goede (2):
      power: supply: axp288_fuel_gauge: Rename fuel_gauge_blacklist to no_battery_list
      power: supply: axp288_fuel_gauge: Make "T3 MRD" no_battery_list DMI entry more generic

Hermann Lauer (1):
      power: supply: axp20x_battery: allow disabling battery charging

Ikjoon Jang (1):
      power: supply: sbs-battery: cache constant string properties

Jian Xin (1):
      power: supply: ab8500: Fix typo

Krzysztof Kozlowski (8):
      MAINTAINERS: power: supply: use Krzysztof Kozlowski's Canonical address
      power: ab8500: remove unused header
      MAINTAINERS: power: supply: cover also header files
      power: supply: max17042: Do not enforce (incorrect) interrupt trigger type
      power: supply: max17040: Do not enforce (incorrect) interrupt trigger type
      power: supply: max17040: remove non-working POWER_SUPPLY_PROP_STATUS
      power: supply: max17040: simplify POWER_SUPPLY_PROP_ONLINE
      power: supply: max17040: drop unused platform data support

Linus Walleij (8):
      power: supply: ab8500: Move to componentized binding
      power: supply: ab8500: Call battery population once
      power: supply: ab8500: Avoid NULL pointers
      power: supply: ab8500: Enable USB and AC
      power: supply: ab8500: Drop unused member
      power: supply: pm2301_charger: Delete driver
      power: supply: smb347-charger: Drop unused include
      power: supply: ab8500: Fix an old bug

Matti Vaittinen (1):
      power: supply: Drop BD70528 support

Maximilian Luz (2):
      power: supply: surface_battery: Fix battery event handling
      power: supply: surface-charger: Fix type of integer variable

Sebastian Reichel (2):
      dt-bindings: power: supply: charger-manager: Convert to DT schema format
      Merge branch 'psy-fixes' into psy-next

Stephan Gerhold (2):
      dt-bindings: power: supply: Add DT schema for richtek,rt5033-battery
      power: supply: rt5033_battery: Fix device tree enumeration

Yu Jiahua (1):
      drivers: power: add missing MODULE_DEVICE_TABLE in keystone-reset.c

Zhen Lei (1):
      power: reset: at91-sama5d2_shdwc: Remove redundant error printing in at91_shdwc_probe()

Zou Wei (5):
      power: supply: sc27xx: Add missing MODULE_DEVICE_TABLE
      power: supply: sc2731_charger: Add missing MODULE_DEVICE_TABLE
      power: reset: regulator-poweroff: add missing MODULE_DEVICE_TABLE
      power: supply: charger-manager: add missing MODULE_DEVICE_TABLE
      power: supply: ab8500: add missing MODULE_DEVICE_TABLE

 .../bindings/power/supply/charger-manager.txt      |   91 --
 .../bindings/power/supply/charger-manager.yaml     |  215 ++++
 .../bindings/power/supply/maxim,max17040.yaml      |    2 +-
 .../power/supply/richtek,rt5033-battery.yaml       |   54 +
 MAINTAINERS                                        |    3 +-
 drivers/power/reset/at91-sama5d2_shdwc.c           |    4 +-
 drivers/power/reset/gpio-poweroff.c                |    1 +
 drivers/power/reset/keystone-reset.c               |    1 +
 drivers/power/reset/regulator-poweroff.c           |    1 +
 drivers/power/supply/Kconfig                       |   12 +-
 drivers/power/supply/Makefile                      |    3 +-
 drivers/power/supply/ab8500-bm.h                   |    7 +-
 drivers/power/supply/ab8500-chargalg.h             |    2 +-
 drivers/power/supply/ab8500_btemp.c                |  126 +-
 drivers/power/supply/ab8500_charger.c              |  381 +++---
 drivers/power/supply/ab8500_fg.c                   |  145 ++-
 drivers/power/supply/abx500_chargalg.c             |  117 +-
 drivers/power/supply/axp20x_battery.c              |   17 +-
 drivers/power/supply/axp288_fuel_gauge.c           |   26 +-
 drivers/power/supply/bd70528-charger.c             |  710 -----------
 drivers/power/supply/bq24190_charger.c             |   11 +-
 drivers/power/supply/charger-manager.c             |    1 +
 drivers/power/supply/cpcap-battery.c               |   19 +-
 drivers/power/supply/cpcap-charger.c               |   39 +-
 drivers/power/supply/max17040_battery.c            |   42 +-
 drivers/power/supply/max17042_battery.c            |    2 +-
 drivers/power/supply/pm2301_charger.c              | 1249 --------------------
 drivers/power/supply/rn5t618_power.c               |  235 ++++
 drivers/power/supply/rt5033_battery.c              |    7 +
 drivers/power/supply/sbs-battery.c                 |  153 ++-
 drivers/power/supply/sc2731_charger.c              |    1 +
 drivers/power/supply/sc27xx_fuel_gauge.c           |    1 +
 drivers/power/supply/smb347-charger.c              |    1 -
 drivers/power/supply/surface_battery.c             |   14 +-
 drivers/power/supply/surface_charger.c             |    2 +-
 include/linux/max17040_battery.h                   |   16 -
 include/linux/pm2301_charger.h                     |   48 -
 include/linux/power/ab8500.h                       |   16 -
 38 files changed, 1113 insertions(+), 2662 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/charger-manager.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/charger-manager.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
 delete mode 100644 drivers/power/supply/bd70528-charger.c
 delete mode 100644 drivers/power/supply/pm2301_charger.c
 delete mode 100644 include/linux/max17040_battery.h
 delete mode 100644 include/linux/pm2301_charger.h
 delete mode 100644 include/linux/power/ab8500.h

--evu6hrxzrrci4lu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmDl2p4ACgkQ2O7X88g7
+poqpxAAhr6AEC0iJuCj6rBLDBjLFmIvlWi1FTOX0dJkgXumyU+1aJ+2LtQ6zcPH
jDCloICas0enPBkQyno/Tb+k8w4eqmKjG0mYbKu/kqIrubqKAijQd46d/alTR7WO
wkjjlKlyBizGpkqzctUpp5KXGyk5Ox/DybHD6FOx5PNk89Ey0H82vtAhC2jWxZys
aH4l/i/P57rX7L7am3DHIxsrkEtmP2KZyxAXgbSKeyPFuEj05a2pNMqtP7i3vkBU
a0SYrGGJapdqHRLLTOMs5WCBNgMzIHIHMilaQH7qhwlWbOxRbtOg+vc5Aqe4vuU0
A/f3KyHk3N3q+jvnsrRJ1xABDs3BCEALqckncyrUeCLjqqAx2stNuHwVd9LhZGiu
XPnhOPdBOWVdF73fqh2WXsjjFyHRgPJlk3VY+ibeuLrv78FOtxznArk/GrRfuPEe
PU0bDZclhubViBxmBuVRh/S9EiI+TtbaDU9j8sI36BKxazBs8+zGAOOuVY3KxLwp
YbieUdBo9xK1xIhbF7b+dEmX8dTZJ5L4OQPC162v96h8Tc4Ybb250TgZr0qwek9/
jnXU6nXb0AEHXykEXVGBfAl43/Bw46kBB297ArwVxfnzWEF5zvX+lURVdT9AODcD
tVgkHieoPJog7kuDzxwFaYzgosjyduCBc/GCLuS+xspvQpRgXVE=
=eHeo
-----END PGP SIGNATURE-----

--evu6hrxzrrci4lu3--
