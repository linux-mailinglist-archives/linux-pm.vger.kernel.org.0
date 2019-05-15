Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0961FAFC
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 21:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEOTfE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 15:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfEOTfD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 May 2019 15:35:03 -0400
Received: from earth.universe (host-091-097-031-090.ewe-ip-backbone.de [91.97.31.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E654F2084F;
        Wed, 15 May 2019 19:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557948903;
        bh=T8KZMtAQaa1AWpMPzkJfrn31xMbxudTFZ6VKkGQgaMQ=;
        h=Date:From:To:Cc:Subject:From;
        b=lnMIkkcRqYl5S6/EHGKHAMSKige22qxnEicu7gElNzWmq8lgX+4G79y5n5h1DHclu
         55jVQdkX3awLLlg55pwU8rUc+njYyma2TtTlCEwoYjDHemZ0I8K/lFFYMuCbjWKMND
         zRPRNcU/ERhUmK49KQKuy7arkLz6H3sMNEn32/bY=
Received: by earth.universe (Postfix, from userid 1000)
        id EC33F3C0CAB; Wed, 15 May 2019 21:35:00 +0200 (CEST)
Date:   Wed, 15 May 2019 21:35:00 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.2
Message-ID: <20190515193500.6wpstcuacfuwt6ty@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lar6j6naw6ub2ikt"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lar6j6naw6ub2ikt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here is the power-supply pull request for the 5.2 merge window.
Everything except for a few small fixes have been in linux-next
for > 10 days. The pull request is touching some bits in x86 for
the OLPC changes and some bits in IIO for the new Ingenic JZ47xx
battery driver, that have been Acked by the respective maintainers
and no merge issues have been reported by Stephen.

-- Sebastian

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.2

for you to fetch changes up to baf5964ecfe19a0109fe2e497e72840ce0f488e6:

  power: supply: olpc_battery: force the le/be casts (2019-05-14 23:17:56 +0200)

----------------------------------------------------------------
power supply and reset changes for the v5.2 series

Core:
 * Add over-current health state
 * Add standard, adaptive and custom charge types
 * Add new properties for start/end charge threshold

New Drivers / Hardware:
 * UCS1002 Programmable USB Port Power Controller
 * Ingenic JZ47xx Battery Fuel Gauge
 * AXP20x USB Power: Add AXP813 support
 * AT91 poweroff: Add SAM9X60 support
 * OLPC battery: Add XO-1.5 and XO-1.75 support

Misc. Changes:
 * syscon-reboot: support mask property
 * AXP288 fuel gauge: Blacklist ACEPC T8/T11
  - Looks like some vendor thought it's a good idea to
    build a desktop system with a fuel gauge, that slowly
    "discharges"...
 * cpcap-battery: Fix calculation errors
 * misc. fixes

----------------------------------------------------------------
Andrey Smirnov (3):
      power: supply: core: Add POWER_SUPPLY_HEALTH_OVERCURRENT constant
      dt-bindings: power: supply: Add bindings for Microchip UCS1002
      power: supply: Add driver for Microchip UCS1002

Artur Rojek (6):
      iio: inkern: API for reading available iio channel attribute values
      iio: inkern: Convert iio_read_avail_channel_raw into a wrapper
      dt-bindings: power: supply: Add charge-status-gpios property
      power: supply: gpio-charger: Add support for charger status.
      dt-bindings: power: supply: Add docs for Ingenic JZ47xx SoCs battery.
      power: supply: add Ingenic JZ47xx battery driver.

Axel Lin (1):
      power: supply: ucs1002: Fix wrong return value checking

Chen-Yu Tsai (3):
      dt-bindings: power: supply: axp20x_usb_power: add axp813 compatible
      power: supply: axp20x_usb_power: Fix typo in VBUS current limit macros
      power: supply: axp20x_usb_power: use polling to detect vbus status change

Claudiu Beznea (3):
      power: reset: at91-poweroff: add RTT wakeup capability
      power: reset: at91-poweroff: add support for SAM9X60
      dt-bindings: arm: atmel: add binding for SAM9X60 shutdown controller

Enric Balletbo i Serra (1):
      power: supply: core: fix typo in function to get current charge control limit

Gustavo A. R. Silva (1):
      power: supply: axp288_charger: Fix unchecked return value

Hans de Goede (1):
      power: supply: axp288_fuel_gauge: Add ACEPC T8 and T11 mini PCs to the blacklist

Kangjie Lu (1):
      power: charger-manager: fix a potential NULL pointer dereference

Krzysztof Kozlowski (1):
      power: supply: bq27xxx_battery: Notify also about status changes

Lubomir Rintel (11):
      dt-bindings: olpc_battery: Add XO-1.5 battery
      x86/platform/olpc: Don't split string literals when fixing up the DT
      x86/platform/olpc: Trivial code move in DT fixup
      x86/platform/olpc: Use a correct version when making up a battery node
      power: supply: olpc_battery: Use DT to get battery version
      power: supply: olpc_battery: Move priv data to a struct
      power: supply: olpc_battery: Use devm_power_supply_register()
      power: supply: olpc_battery: Avoid using platform_info
      power: supply: olpc_battery: Add OLPC XO 1.75 support
      power: supply: olpc_battery: Have the framework register sysfs files for us
      power: supply: olpc_battery: force the le/be casts

Martin Schiller (1):
      power: reset: syscon-reboot: add a mask property

Maxime Ripard (1):
      power: supply: Fix the simple battery property names

Michael Hennerich (2):
      power: supply: ltc3651-charger: Fix device name
      power: supply: ltc3651-charger: Fix device name (rename files)

Nick Crews (3):
      power: supply: core: Add Standard, Adaptive, and Custom charge types
      power: supply: core: Add CHARGE_CONTROL_{START_THRESHOLD,END_THRESHOLD} properties
      power: supply: core: Add missing documentation for CHARGE_CONTROL_* properties

Phong Tran (1):
      power: supply: core: fix clang -Wunsequenced

Quentin Schulz (2):
      power: supply: axp20x_usb_power: add function to get max current
      power: supply: axp20x_usb_power: add support for AXP813

Sebastian Reichel (3):
      Merge branch 'psy-fixes' into psy-next
      Merge 'ib-jz47xx-battery-prereq' into psy-next
      Merge tag 'psy-olpc-1.75-battery-signed' into psy-next

Sebastien Bourdelin (1):
      dt-bindings: power: supply: gpio-charger: add missing semi-colon in example

Sven Van Asbroeck (2):
      power: supply: max14656: fix potential use-before-alloc
      power: supply: max14656: fix potential use-after-free

Tony Lindgren (7):
      power: supply: cpcap-battery: Fix division by zero
      power: supply: cpcap-battery: Fix low battery check
      power: supply: cpcap-battery: Fix signed counter sample register
      power: supply: cpcap-battery: Fix coulomb counter calibration register use
      power: supply: cpcap-battery: Use accumulator for current and power average
      power: supply: cpcap-battery: Fix pointless EPROBE_DEFER warnings
      power: supply: cpcap-charger: Fix pointless EPROBE_DEFER warnings

Wen Yang (2):
      power: supply: ab8500: fix leaked of_node refs in ab8500_bm_of_probe
      power: supply: core: fix leaked of_node refs in power_supply_get_battery_info

YueHaibing (1):
      power: supply: ucs1002: Fix build error without CONFIG_REGULATOR

 Documentation/ABI/testing/sysfs-class-power        |  51 +-
 .../devicetree/bindings/arm/atmel-sysregs.txt      |   5 +-
 .../bindings/power/reset/syscon-reboot.txt         |  11 +-
 .../bindings/power/supply/axp20x_usb_power.txt     |   1 +
 .../bindings/power/supply/gpio-charger.txt         |   8 +-
 .../bindings/power/supply/ingenic,battery.txt      |  31 +
 .../{ltc3651-charger.txt => lt3651-charger.txt}    |  10 +-
 .../bindings/power/supply/microchip,ucs1002.txt    |  27 +
 .../bindings/power/supply/olpc_battery.txt         |   2 +-
 arch/x86/platform/olpc/olpc_dt.c                   | 101 +++-
 drivers/iio/inkern.c                               |  22 +-
 drivers/power/reset/at91-sama5d2_shdwc.c           |  25 +
 drivers/power/reset/syscon-reboot.c                |  19 +-
 drivers/power/supply/Kconfig                       |  29 +-
 drivers/power/supply/Makefile                      |   4 +-
 drivers/power/supply/ab8500_bmdata.c               |   1 +
 drivers/power/supply/axp20x_usb_power.c            | 179 +++++-
 drivers/power/supply/axp288_charger.c              |   4 +
 drivers/power/supply/axp288_fuel_gauge.c           |  20 +
 drivers/power/supply/bq27xxx_battery.c             |   3 +-
 drivers/power/supply/charger-manager.c             |   3 +
 drivers/power/supply/cpcap-battery.c               |  45 +-
 drivers/power/supply/cpcap-charger.c               |   5 +-
 drivers/power/supply/gpio-charger.c                |  57 +-
 drivers/power/supply/ingenic-battery.c             | 184 ++++++
 .../supply/{ltc3651-charger.c => lt3651-charger.c} | 123 ++--
 drivers/power/supply/max14656_charger_detector.c   |  27 +-
 drivers/power/supply/olpc_battery.c                | 171 +++---
 drivers/power/supply/power_supply_core.c           |  38 +-
 drivers/power/supply/power_supply_sysfs.c          |   6 +-
 drivers/power/supply/ucs1002_power.c               | 646 +++++++++++++++++++++
 include/linux/iio/consumer.h                       |  14 +
 include/linux/power_supply.h                       |  11 +-
 33 files changed, 1613 insertions(+), 270 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
 rename Documentation/devicetree/bindings/power/supply/{ltc3651-charger.txt => lt3651-charger.txt} (71%)
 create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
 create mode 100644 drivers/power/supply/ingenic-battery.c
 rename drivers/power/supply/{ltc3651-charger.c => lt3651-charger.c} (50%)
 create mode 100644 drivers/power/supply/ucs1002_power.c

--lar6j6naw6ub2ikt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzcad8ACgkQ2O7X88g7
+poi0xAApnCY691TqGx8LZEyLlBely8pPsOVnchJierfz18QXB0oQdnsMTTRS22P
wsPELGWqr+s5sOGAfKdQ9qZcKIpZfHc1J3ibU97wANefNA8uNV/mMOD73/Y5DDUF
ptSkkEJ1yEx07yrMOUeGFCrpcOOajUDBVrKqIjc9Zab+u016/8UDiMUQA8XQD4wa
BZZHFMtCzRlyVCQPxumZxW18qjMjNzaGOXprPgl690++0YRpd1+VZN8VLt/d5Weu
BGrp1gblE5lX+vjt+CliGWGUzQHotSk0ioMmyvbiL8UQesMCpTiGKXNOxI3rVWrQ
Aq+HT1qAQnlxdR+1qB+YdZuqubyvDMEaJR13gKU6A220glBdqhteKDbzMSFBH7Iz
UR1aZesbB8RWyAhjDshrYqhvWbInQ0otCegn8nNn4s9NQw4KtW2JhpyF/yyyexh2
kSP8zhaif9HhfnQG8C/C7toehdPiuD4tuSicehpr55jL26M5GNR6xh8K8eiCmjnz
1sO1q2Q3cK/1Ufgj5MeOFd7gP/r1sUZRfN/kIxT3tr6Yq4KQwzZa/rL1ld7xvpHi
WeFtau0pb4GJ62U/3g7zpQN6sf5xYCL/GkiXKvQkM+PuFDBgDwjOkXL1GekQEB1K
OOsJK/HqQdwkvc2NZScbqAoFD4VZb4GJuijv9trCv5eKKREFO1c=
=Dmon
-----END PGP SIGNATURE-----

--lar6j6naw6ub2ikt--
