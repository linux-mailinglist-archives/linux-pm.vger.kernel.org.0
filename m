Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C35F36CB4F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 20:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbhD0Svv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 14:51:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238516AbhD0Svv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Apr 2021 14:51:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A805613CA;
        Tue, 27 Apr 2021 18:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619549467;
        bh=KlhD1WVes/FADS2vZYRCPjIDqG2hAaVmDUQ+Fj93/eQ=;
        h=Date:From:To:Cc:Subject:From;
        b=EmxJBPm7BnmeAimc64Xr4+ecC9TUR35DeFSgadhtComB6vukSDdl1GwHub7+5hyF5
         CXwg4jS9Wn1d9L+dZmkFpB/bpbtWXi8l8ENSRoDGHWDZyBHlmIikKgtWup9qMAW2Ea
         fUItDnXZQf/CJ6lxNjhXibCq788aEroIGbc4yoN4BNKbaxv5nJx2wG1jjzPeUVWVo2
         jciZXwylWHvQyhsyqbo/L8nwtt3ULx/xcP6QStpe6ACUOYKf6xH86j7e+vSJQLVtCS
         abyGb8zUTQ1mnfbyzRiXSjUrBDh1Prv14EgelX0B5WZ0UUN6Fem4WhpQwVIoaXxbyu
         3yInR7HJL0FaQ==
Received: by earth.universe (Postfix, from userid 1000)
        id C9F1C3C0C96; Tue, 27 Apr 2021 20:51:05 +0200 (CEST)
Date:   Tue, 27 Apr 2021 20:51:05 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.13
Message-ID: <20210427185105.j5lsytdmg4m5ow7v@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lqhfi22d3qp5ucwf"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lqhfi22d3qp5ucwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.13

for you to fetch changes up to d0a43c12ee9f57ddb284272187bd18726c2c2c98:

  power: supply: cpcap-battery: fix invalid usage of list cursor (2021-04-21 23:06:14 +0200)

----------------------------------------------------------------
power supply and reset changes for the v5.13 series

battery/charger driver changes:
 * core: provide function stubs if CONFIG_POWER_SUPPLY=n
 * core: reduce loglevel for probe defer info
 * surface-battery: new battery driver for Surface
 * surface-charger: new charger driver for Surface
 * bq27xxx: add bq78z100 support
 * bq27xxx: fix current_now/power_avg for newer chips
 * cw2015: add CHARGE_NOW support
 * ab8500: drop pdata support
 * convert most DT bindings to YAML
 * lot's of minor fixes and cleanups

reset drivers:
 * ltc2952-poweroff: make trigger delay configurable from DT
 * minor fixes and cleanups

----------------------------------------------------------------
Bhaskar Chowdhury (2):
      power: supply: charger-manager: Fix a typo
      power: supply: max17042: Trivial spelling fixes

Bixuan Cui (1):
      power: reset: restart-poweroff: Add missing MODULE_DEVICE_TABLE

Carl Philipp Klemm (2):
      power: supply: cpcap-charger: fix small mistake in current to register conversion
      power: supply: cpcap-charger: Add usleep to cpcap charger to avoid usb plug bounce

Chen Lifu (1):
      power: reset: hisi-reboot: add missing MODULE_DEVICE_TABLE

Claudiu Beznea (1):
      power: reset: at91-reset: use devm_of_iomap

Daniel Golle (1):
      power: reset: replace curly brackets in Makefile

Dinghao Liu (1):
      power: supply: axp20x_usb_power: Add missing check in axp20x_usb_power_probe

Dmitry Osipenko (2):
      power: supply: smb347-charger: Improve interrupt initialization
      power: supply: smb347-charger: Clean up whitespaces in the code

Guangqing Zhu (1):
      power: supply: cpcap-battery: fix invalid usage of list cursor

Hao Fang (1):
      power: reset: hisi-reboot: use the correct HiSilicon copyright

Jiapeng Chong (2):
      power: supply: max8997-charger: remove unneeded semicolon
      power: supply: core: Use true and false for bool variable

Krzysztof Kozlowski (8):
      MAINTAINERS: power: supply: add entry for S3C ADC battery driver
      power: supply: s3c_adc_battery: add SPDX license identifier
      power: supply: s3c_adc_battery: remove unused pdata in suspend/resume
      power: supply: max14577: remove unneeded variable initialization
      power: supply: max17040: handle device_property_read_u8_array() failure
      power: supply: max17040: remove unneeded double cast
      power: supply: act8945a: correct kerneldoc
      power: supply: bq256xx: add kerneldoc for structure members

LI Qingwu (2):
      dt-bindings: power: bq27xxx: add bq78z100
      power: supply: bq27xxx: Add support for BQ78Z100

Linus Walleij (5):
      power: supply: z2_battery: Drop unused variable
      power: ab8500: Require device tree
      mfd/power: ab8500: Push data to power supply code
      mfd/power: ab8500: Push algorithm to power supply code
      mfd/power: ab8500: Push data to power supply code

Marek Czerski (1):
      power: reset: ltc2952: make trigger delay configurable

Martin Ashby (1):
      power: supply: cw2015: Add CHARGE_NOW support

Matthias Schiffer (3):
      power: supply: bq27xxx: fix sign of current_now for newer ICs
      power: supply: bq27xxx: fix power_avg for newer ICs
      power: supply: bq27xxx: make status more robust

Mauro Carvalho Chehab (2):
      MAINTAINERS: update lego,ev3-battery.yaml reference
      dt-bindings: power: update battery.yaml reference

Maximilian Luz (8):
      platform/surface: Set up Surface Aggregator device registry
      platform/surface: aggregator_registry: Add base device hub
      platform/surface: aggregator_registry: Add battery subsystem devices
      platform/surface: aggregator_registry: Add platform profile device
      platform/surface: aggregator_registry: Add DTX device
      platform/surface: aggregator_registry: Add HID subsystem devices
      power: supply: Add battery driver for Surface Aggregator Module
      power: supply: Add AC driver for Surface Aggregator Module

Milan Djurovic (1):
      power: supply: 88pm860x_battery: Remove unnecessary int for long long

Qiheng Lin (2):
      power: supply: surface-battery: Make some symbols static
      power: supply: surface-charger: Make symbol 'surface_ac_pm_ops' static

Ray Chi (1):
      power: supply: core: provide function stubs if CONFIG_POWER_SUPPLY=n

Ricardo Rivera-Matos (1):
      power: supply: bq25980: Move props from battery node

Roman Kiryanov (1):
      power: supply: goldfish: Remove the GOLDFISH dependency

Sebastian Reichel (46):
      dt-bindings: power: supply: cpcap-battery: Convert to DT schema format
      dt-bindings: power: supply: cpcap-charger: Convert to DT schema format
      dt-bindings: power: supply: bq25890: Convert to DT schema format
      dt-bindings: power: supply: bq24257: Convert to DT schema format
      dt-bindings: power: supply: bq24190: Convert to DT schema format
      dt-bindings: power: supply: bq2415x: Convert to DT schema format
      dt-bindings: power: supply: bq24735: Convert to DT schema format
      dt-bindings: power: supply: isp1704: Convert to DT schema format
      dt-bindings: power: supply: sbs-charger: Convert to DT schema format
      dt-bindings: power: supply: sbs-manager: Convert to DT schema format
      dt-bindings: power: supply: ds2760: Convert to DT schema format
      dt-bindings: power: supply: sc27xx-fg: Convert to DT schema format
      dt-bindings: power: supply: sc2731-charger: Convert to DT schema format
      dt-bindings: power: supply: tps65090: Convert to DT schema format
      dt-bindings: power: supply: tps65217: Convert to DT schema format
      dt-bindings: power: supply: twl4030: Convert to DT schema format
      dt-bindings: power: supply: n900-battery: Convert to DT schema format
      dt-bindings: power: supply: lego-ev3-battery: Convert to DT schema format
      dt-bindings: power: supply: max17040: Convert to DT schema format
      dt-bindings: power: supply: max14656: Convert to DT schema format
      dt-bindings: power: supply: max17042: Convert to DT schema format
      dt-bindings: power: supply: max8903: Convert to DT schema format
      dt-bindings: power: supply: ucs1002: Convert to DT schema format
      dt-bindings: power: supply: pm8941-charger: Convert to DT schema format
      dt-bindings: power: supply: pm8941-coincell: Convert to DT schema format
      dt-bindings: power: supply: act8945a: Convert to DT schema format
      dt-bindings: power: supply: axp20x: Convert to DT schema format
      dt-bindings: power: supply: da9150: Convert to DT schema format
      dt-bindings: power: supply: lp8727: Convert to DT schema format
      dt-bindings: power: supply: lt3651: Convert to DT schema format
      dt-bindings: power: supply: ltc294x: Convert to DT schema format
      dt-bindings: power: supply: rt9455: Convert to DT schema format
      dt-bindings: power: supply: olpc-battery: Convert to DT schema format
      dt-bindings: power: supply: ab8500: Convert to DT schema format
      dt-bindings: power: supply: sbs-battery: Fix dtbs_check
      dt-bindings: power: supply: Fix remaining battery.txt links
      dt-bindings: power: supply: Drop power_supply.txt
      power: supply: sbs-battery: use dev_err_probe
      power: supply: sbs-charger: use dev_err_probe
      power: supply: sbs-charger: drop unused gpio includes
      power: supply: sbs-manager: use managed i2c_mux_adapter
      power: supply: sbs-manager: use dev_err_probe
      power: supply: sbs-manager: update gpio include
      power: supply: core: reduce loglevel for probe defer info
      Merge tag 'ib-mfd-power-v5.13' into psy-next
      Merge tag 'tags/platform-drivers-x86-surface-aggregator-v5.13-1' into psy-next

Timon Baetz (1):
      power: supply: max8997_charger: Switch to new binding

Xiaofeng Cao (1):
      power: supply: max1721x: Correct spelling

Yang Li (1):
      power: supply: cpcap-charger: Simplify bool conversion

Yang Yingliang (2):
      power: supply: generic-adc-battery: fix possible use-after-free in gab_remove()
      power: supply: s3c_adc_battery: fix possible use-after-free in s3c_adc_bat_remove()

dongjian (3):
      power: supply: Use IRQF_ONESHOT
      power: reset: remove unneeded semicolon
      power: supply: ds2781: use kobj_to_dev()

 .../ABI/testing/sysfs-class-power-surface          |  15 +
 .../bindings/power/reset/ltc2952-poweroff.txt      |   4 +
 .../bindings/power/supply/ab8500/btemp.txt         |  16 -
 .../bindings/power/supply/ab8500/chargalg.txt      |  16 -
 .../bindings/power/supply/ab8500/charger.txt       |  25 -
 .../bindings/power/supply/act8945a-charger.txt     |  44 --
 .../power/supply/active-semi,act8945a-charger.yaml |  76 ++
 .../bindings/power/supply/axp20x_ac_power.txt      |  25 -
 .../bindings/power/supply/axp20x_battery.txt       |  20 -
 .../bindings/power/supply/axp20x_usb_power.txt     |  41 -
 .../devicetree/bindings/power/supply/battery.txt   |   3 -
 .../devicetree/bindings/power/supply/bq2415x.txt   |  47 --
 .../devicetree/bindings/power/supply/bq2415x.yaml  |  98 +++
 .../devicetree/bindings/power/supply/bq24190.txt   |  61 --
 .../devicetree/bindings/power/supply/bq24190.yaml  |  92 +++
 .../devicetree/bindings/power/supply/bq24257.txt   |  62 --
 .../devicetree/bindings/power/supply/bq24257.yaml  | 124 +++
 .../devicetree/bindings/power/supply/bq24735.yaml  |  89 +++
 .../devicetree/bindings/power/supply/bq25890.txt   |  60 --
 .../devicetree/bindings/power/supply/bq25890.yaml  | 123 +++
 .../devicetree/bindings/power/supply/bq27xxx.yaml  |   3 +-
 .../bindings/power/supply/cpcap-battery.txt        |  31 -
 .../bindings/power/supply/cpcap-battery.yaml       |  87 +++
 .../bindings/power/supply/cpcap-charger.txt        |  40 -
 .../bindings/power/supply/cpcap-charger.yaml       | 106 +++
 .../bindings/power/supply/da9150-charger.txt       |  26 -
 .../devicetree/bindings/power/supply/da9150-fg.txt |  23 -
 .../bindings/power/supply/dlg,da9150-charger.yaml  |  52 ++
 .../power/supply/dlg,da9150-fuel-gauge.yaml        |  51 ++
 .../devicetree/bindings/power/supply/isp1704.txt   |  17 -
 .../devicetree/bindings/power/supply/isp1704.yaml  |  42 +
 .../bindings/power/supply/lego,ev3-battery.yaml    |  55 ++
 .../bindings/power/supply/lego_ev3_battery.txt     |  21 -
 .../bindings/power/supply/lltc,lt3651-charger.yaml |  44 ++
 .../bindings/power/supply/lltc,ltc294x.yaml        |  66 ++
 .../bindings/power/supply/lp8727_charger.txt       |  43 -
 .../bindings/power/supply/lt3651-charger.txt       |  29 -
 .../devicetree/bindings/power/supply/ltc2941.txt   |  28 -
 .../bindings/power/supply/max17040_battery.txt     |  52 --
 .../bindings/power/supply/max17042_battery.txt     |  35 -
 .../bindings/power/supply/max8903-charger.txt      |  24 -
 .../bindings/power/supply/maxim,ds2760.txt         |  26 -
 .../bindings/power/supply/maxim,ds2760.yaml        |  43 +
 .../bindings/power/supply/maxim,max14656.txt       |  23 -
 .../bindings/power/supply/maxim,max14656.yaml      |  45 ++
 .../bindings/power/supply/maxim,max17040.yaml      |  95 +++
 .../bindings/power/supply/maxim,max17042.yaml      |  78 ++
 .../bindings/power/supply/maxim,max8903.yaml       |  67 ++
 .../bindings/power/supply/microchip,ucs1002.txt    |  27 -
 .../bindings/power/supply/microchip,ucs1002.yaml   |  51 ++
 .../bindings/power/supply/nokia,n900-battery.yaml  |  49 ++
 .../bindings/power/supply/olpc-battery.yaml        |  27 +
 .../bindings/power/supply/olpc_battery.txt         |   5 -
 .../bindings/power/supply/power_supply.txt         |   2 -
 .../power/supply/qcom,coincell-charger.txt         |  48 --
 .../bindings/power/supply/qcom,pm8941-charger.yaml | 169 ++++
 .../power/supply/qcom,pm8941-coincell.yaml         |  57 ++
 .../devicetree/bindings/power/supply/qcom_smbb.txt | 150 ----
 .../bindings/power/supply/richtek,rt9455.yaml      |  90 +++
 .../bindings/power/supply/rohm,bd99954.yaml        |   2 +-
 .../bindings/power/supply/rt9455_charger.txt       |  46 --
 .../bindings/power/supply/rx51-battery.txt         |  25 -
 .../bindings/power/supply/sbs,sbs-battery.yaml     |   7 +-
 .../bindings/power/supply/sbs,sbs-charger.yaml     |  55 ++
 .../bindings/power/supply/sbs,sbs-manager.txt      |  66 --
 .../bindings/power/supply/sbs,sbs-manager.yaml     | 107 +++
 .../bindings/power/supply/sbs_sbs-charger.txt      |  21 -
 .../bindings/power/supply/sc2731-charger.yaml      |  53 ++
 .../bindings/power/supply/sc2731_charger.txt       |  40 -
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |  59 --
 .../bindings/power/supply/sc27xx-fg.yaml           |  98 +++
 .../fg.txt => stericsson,ab8500-battery.txt}       |  32 +-
 .../power/supply/stericsson,ab8500-btemp.yaml      |  73 ++
 .../power/supply/stericsson,ab8500-chargalg.yaml   |  37 +
 .../power/supply/stericsson,ab8500-charger.yaml    | 123 +++
 .../power/supply/stericsson,ab8500-fg.yaml         |  72 ++
 .../bindings/power/supply/ti,bq24735.txt           |  39 -
 .../bindings/power/supply/ti,lp8727.yaml           |  90 +++
 .../bindings/power/supply/tps65090-charger.yaml    |  36 +
 .../devicetree/bindings/power/supply/tps65090.txt  |  17 -
 .../bindings/power/supply/tps65217-charger.yaml    |  43 +
 .../bindings/power/supply/tps65217_charger.txt     |  17 -
 .../bindings/power/supply/twl-charger.txt          |  30 -
 .../bindings/power/supply/twl4030-charger.yaml     |  68 ++
 .../supply/x-powers,axp20x-ac-power-supply.yaml    |  32 +
 .../x-powers,axp20x-battery-power-supply.yaml      |  30 +
 .../supply/x-powers,axp20x-usb-power-supply.yaml   |  33 +
 Documentation/power/power_supply_class.rst         |   2 +-
 MAINTAINERS                                        |  18 +-
 drivers/mfd/ab8500-core.c                          |  17 +-
 drivers/platform/surface/Kconfig                   |  27 +
 drivers/platform/surface/Makefile                  |   1 +
 .../platform/surface/surface_aggregator_registry.c | 641 +++++++++++++++
 drivers/power/reset/Makefile                       |   2 +-
 drivers/power/reset/at91-reset.c                   |   4 +-
 drivers/power/reset/hisi-reboot.c                  |   5 +-
 drivers/power/reset/ltc2952-poweroff.c             |   8 +
 drivers/power/reset/restart-poweroff.c             |   1 +
 drivers/power/reset/vexpress-poweroff.c            |   2 +-
 drivers/power/supply/88pm860x_battery.c            |   4 +-
 drivers/power/supply/Kconfig                       |  40 +-
 drivers/power/supply/Makefile                      |   2 +
 .../abx500 => drivers/power/supply}/ab8500-bm.h    | 297 ++++++-
 .../power/supply/ab8500-chargalg.h                 |   6 +-
 drivers/power/supply/ab8500_bmdata.c               |   3 +-
 drivers/power/supply/ab8500_btemp.c                |  45 +-
 drivers/power/supply/ab8500_charger.c              |  27 +-
 drivers/power/supply/ab8500_fg.c                   |  20 +-
 drivers/power/supply/abx500_chargalg.c             |  22 +-
 drivers/power/supply/act8945a_charger.c            |   2 +-
 drivers/power/supply/axp20x_usb_power.c            |   4 +-
 drivers/power/supply/bq256xx_charger.c             |   2 +
 drivers/power/supply/bq25980_charger.c             |  40 +-
 drivers/power/supply/bq27xxx_battery.c             | 169 ++--
 drivers/power/supply/bq27xxx_battery_i2c.c         |   2 +
 drivers/power/supply/charger-manager.c             |   2 +-
 drivers/power/supply/cpcap-battery.c               |   2 +-
 drivers/power/supply/cpcap-charger.c               |   7 +-
 drivers/power/supply/cw2015_battery.c              |   6 +
 drivers/power/supply/ds2781_battery.c              |   8 +-
 drivers/power/supply/generic-adc-battery.c         |   2 +-
 drivers/power/supply/lp8788-charger.c              |   2 +-
 drivers/power/supply/max14577_charger.c            |   2 +-
 drivers/power/supply/max17040_battery.c            |  12 +-
 drivers/power/supply/max17042_battery.c            |   8 +-
 drivers/power/supply/max1721x_battery.c            |  14 +-
 drivers/power/supply/max8997_charger.c             |  14 +-
 drivers/power/supply/pm2301_charger.c              |   6 +-
 drivers/power/supply/power_supply_core.c           |   4 +-
 drivers/power/supply/s3c_adc_battery.c             |  21 +-
 drivers/power/supply/sbs-battery.c                 |  28 +-
 drivers/power/supply/sbs-charger.c                 |  24 +-
 drivers/power/supply/sbs-manager.c                 |  78 +-
 drivers/power/supply/smb347-charger.c              |  65 +-
 drivers/power/supply/surface_battery.c             | 865 +++++++++++++++++++++
 drivers/power/supply/surface_charger.c             | 282 +++++++
 drivers/power/supply/tps65090-charger.c            |   2 +-
 drivers/power/supply/tps65217_charger.c            |   2 +-
 drivers/power/supply/z2_battery.c                  |   3 -
 include/linux/mfd/abx500.h                         | 276 -------
 include/linux/power/bq27xxx_battery.h              |   2 +-
 include/linux/power_supply.h                       |  14 +-
 142 files changed, 5350 insertions(+), 2133 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-surface
 delete mode 100644 Documentation/devicetree/bindings/power/supply/ab8500/btemp.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/ab8500/chargalg.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/ab8500/charger.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/active-semi,act8945a-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/bq2415x.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2415x.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/bq24190.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq24190.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/bq24257.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq24257.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq24735.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/bq25890.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq25890.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/da9150-charger.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/da9150-fg.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/dlg,da9150-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/dlg,da9150-fuel-gauge.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/isp1704.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/isp1704.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/lego,ev3-battery.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/lltc,lt3651-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/lltc,ltc294x.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/lp8727_charger.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/lt3651-charger.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/ltc2941.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/max17042_battery.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/max8903-charger.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,ds2760.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max14656.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max14656.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/nokia,n900-battery.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/olpc-battery.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/olpc_battery.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/power_supply.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/qcom,coincell-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pm8941-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/qcom_smbb.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/rt9455_charger.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/rx51-battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
 rename Documentation/devicetree/bindings/power/supply/{ab8500/fg.txt => stericsson,ab8500-battery.txt} (52%)
 create mode 100644 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-btemp.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-chargalg.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-fg.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/tps65090-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/tps65090.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/twl-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/twl4030-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/x-powers,axp20x-ac-power-supply.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
 create mode 100644 drivers/platform/surface/surface_aggregator_registry.c
 rename {include/linux/mfd/abx500 => drivers/power/supply}/ab8500-bm.h (58%)
 rename include/linux/mfd/abx500/ux500_chargalg.h => drivers/power/supply/ab8500-chargalg.h (93%)
 create mode 100644 drivers/power/supply/surface_battery.c
 create mode 100644 drivers/power/supply/surface_charger.c

--lqhfi22d3qp5ucwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCIXRkACgkQ2O7X88g7
+prPLhAAjNpbFMtp18378MLA1kZhpYgtexbm1R39AgT1NkDQ9tsSoXAoA+pmESN0
rAxMoQ0APn0JwnOjyhTrlrzB/bt3zWx8rLDp7zfmzoNFDmiIWyblIHdXjq//0Uxh
q7KwyEIc6JXPqLGLpJwPjOucuQWFP05uTrdgfLps3/boByB+C1Y2b3N34WTRWF+y
4DJgvhRsNdwZdYzeWPw79itUfn2bLsZq1N/c1bFeEO/JhQu2TcQchzvvhRQcpu8Y
Kz19YqekJVFJAIKgV0TdV9y4xl98NgUNvy+aF5b3waFmiqFv5yjJRB2JqO+PRw9z
kEErBFb8nMwP5KFxBqQ2i8zj1XGXlHMDyInPNVGc/4nKEj3eeGoHMmGQxCT2GwhM
lUo3td/D1jHOEbjXPIcd+kagwX9fifN46m8At6OLeCIOZ6Ri3j2uidap+LyjUFek
KoqRio+eCQXmmuhNDhYb6QItbM51GiWuvhF9mvH4O0RQlclIaRVZnc8U9ZhXuRN3
eHzgwfNAMBNwms1gz7L2TsMDZ7/byvNaqMafEiuqQSuJkBwPpda/DLjxi/EvC5iM
EMdlcIL9GTr5CIkr71pYx2GBa36on77/PLODTR67dSolFt2tuZGIggUBzWsZ6Dpn
5EcC/CQUbeGXGJHdJLKAUooGq1dyB8aVWQmcftgWCvopFgWGzCY=
=VkPh
-----END PGP SIGNATURE-----

--lqhfi22d3qp5ucwf--
