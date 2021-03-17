Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A9A33F17F
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhCQNtf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56130 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhCQNtK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4FA751F44133
Received: by jupiter.universe (Postfix, from userid 1000)
        id B8E054800C3; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 00/38] Convert power-supply DT bindings to YAML
Date:   Wed, 17 Mar 2021 14:48:26 +0100
Message-Id: <20210317134904.80737-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I keep getting patches for existing drivers, that modify DT behaviour
without updating the binding file. Let's move everything to DT schema
files, so that this can easily be cached automatically by dtbs_check.

After this series only three bindings are left unconverted:

1. max8925_battery.txt
   This describes a node below the PMIC, which does not have its own
   compatible value. It needs to be described in the PMIC binding
   file, which has not yet been converted.

2. stericsson,ab8500-battery.txt
   This also describes a node below the PMIC, which does not have
   its own compatible value. The same applies.

3. charger-manager.txt
   This is far more complex to convert than the other files, due
   to the 'cm-regulator-name' / "<>-supply" thing. I skipped it
   for now.

I tested the series using dt-validate 2021.3.dev6+g38efe3f and nothing
is reported when running dtbs_check like this:

make -s -j100 dtbs_check DT_SCHEMA_FILES="Documentation/devicetree/bindings/power/supply/*.yaml"

Also nothing is reported when checking the power-supply binding files
like this:

for file in Documentation/devicetree/bindings/power/supply/*yaml ; do
    make -s -j42 dt_binding_check DT_SCHEMA_FILES=$file ;
done

This is also available as 'psy-yaml-binding' branch from my repository:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git

Changes since PATCHv1:
[1] https://lore.kernel.org/linux-devicetree/20210312154357.1561730-1-sebastian.reichel@collabora.com/
 * Drop #gpio-cells/gpio-controller dependency (inherited from standard binding)
 * Drop $ref for properties with standard suffix
 * ti,bq24735: Add $ref property for poll-interval
 * ti,lp8727: Combine usb and ac property information using patternProperties

Thanks for reviewing it,

-- Sebastian

Sebastian Reichel (38):
  ARM: dts: motorola-cpcap-mapphone: Prepare for dtbs_check parsing
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
  dt-bindings: power: supply: sc2731-charger: Convert to DT schema
    format
  dt-bindings: power: supply: tps65090: Convert to DT schema format
  dt-bindings: power: supply: tps65217: Convert to DT schema format
  dt-bindings: power: supply: twl4030: Convert to DT schema format
  dt-bindings: power: supply: n900-battery: Convert to DT schema format
  dt-bindings: power: supply: lego-ev3-battery: Convert to DT schema
    format
  dt-bindings: power: supply: max17040: Convert to DT schema format
  dt-bindings: power: supply: max14656: Convert to DT schema format
  dt-bindings: power: supply: max17042: Convert to DT schema format
  dt-bindings: power: supply: max8903: Convert to DT schema format
  dt-bindings: power: supply: ucs1002: Convert to DT schema format
  dt-bindings: power: supply: pm8941-charger: Convert to DT schema
    format
  dt-bindings: power: supply: pm8941-coincell: Convert to DT schema
    format
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

 .../bindings/power/supply/ab8500/btemp.txt    |  16 --
 .../bindings/power/supply/ab8500/chargalg.txt |  16 --
 .../bindings/power/supply/ab8500/charger.txt  |  25 ---
 .../power/supply/act8945a-charger.txt         |  44 -----
 .../supply/active-semi,act8945a-charger.yaml  |  76 ++++++++
 .../bindings/power/supply/axp20x_ac_power.txt |  25 ---
 .../bindings/power/supply/axp20x_battery.txt  |  20 ---
 .../power/supply/axp20x_usb_power.txt         |  41 -----
 .../bindings/power/supply/battery.txt         |   3 -
 .../bindings/power/supply/bq2415x.txt         |  47 -----
 .../bindings/power/supply/bq2415x.yaml        |  98 ++++++++++
 .../bindings/power/supply/bq24190.txt         |  61 -------
 .../bindings/power/supply/bq24190.yaml        |  92 ++++++++++
 .../bindings/power/supply/bq24257.txt         |  62 -------
 .../bindings/power/supply/bq24257.yaml        | 124 +++++++++++++
 .../bindings/power/supply/bq24735.yaml        |  89 +++++++++
 .../bindings/power/supply/bq25890.txt         |  60 -------
 .../bindings/power/supply/bq25890.yaml        | 123 +++++++++++++
 .../bindings/power/supply/bq27xxx.yaml        |   2 +-
 .../bindings/power/supply/cpcap-battery.txt   |  31 ----
 .../bindings/power/supply/cpcap-battery.yaml  |  87 +++++++++
 .../bindings/power/supply/cpcap-charger.txt   |  40 -----
 .../bindings/power/supply/cpcap-charger.yaml  | 106 +++++++++++
 .../bindings/power/supply/da9150-charger.txt  |  26 ---
 .../bindings/power/supply/da9150-fg.txt       |  23 ---
 .../power/supply/dlg,da9150-charger.yaml      |  52 ++++++
 .../power/supply/dlg,da9150-fuel-gauge.yaml   |  51 ++++++
 .../bindings/power/supply/isp1704.txt         |  17 --
 .../bindings/power/supply/isp1704.yaml        |  42 +++++
 .../power/supply/lego,ev3-battery.yaml        |  55 ++++++
 .../power/supply/lego_ev3_battery.txt         |  21 ---
 .../power/supply/lltc,lt3651-charger.yaml     |  44 +++++
 .../bindings/power/supply/lltc,ltc294x.yaml   |  66 +++++++
 .../bindings/power/supply/lp8727_charger.txt  |  43 -----
 .../bindings/power/supply/lt3651-charger.txt  |  29 ---
 .../bindings/power/supply/ltc2941.txt         |  28 ---
 .../power/supply/max17040_battery.txt         |  52 ------
 .../power/supply/max17042_battery.txt         |  35 ----
 .../bindings/power/supply/max8903-charger.txt |  24 ---
 .../bindings/power/supply/maxim,ds2760.txt    |  26 ---
 .../bindings/power/supply/maxim,ds2760.yaml   |  43 +++++
 .../bindings/power/supply/maxim,max14656.txt  |  23 ---
 .../bindings/power/supply/maxim,max14656.yaml |  45 +++++
 .../bindings/power/supply/maxim,max17040.yaml |  95 ++++++++++
 .../bindings/power/supply/maxim,max17042.yaml |  78 ++++++++
 .../bindings/power/supply/maxim,max8903.yaml  |  67 +++++++
 .../power/supply/microchip,ucs1002.txt        |  27 ---
 .../power/supply/microchip,ucs1002.yaml       |  51 ++++++
 .../power/supply/nokia,n900-battery.yaml      |  49 +++++
 .../bindings/power/supply/olpc-battery.yaml   |  27 +++
 .../bindings/power/supply/olpc_battery.txt    |   5 -
 .../bindings/power/supply/power_supply.txt    |   2 -
 .../power/supply/qcom,coincell-charger.txt    |  48 -----
 .../power/supply/qcom,pm8941-charger.yaml     | 169 ++++++++++++++++++
 .../power/supply/qcom,pm8941-coincell.yaml    |  57 ++++++
 .../bindings/power/supply/qcom_smbb.txt       | 150 ----------------
 .../bindings/power/supply/richtek,rt9455.yaml |  90 ++++++++++
 .../bindings/power/supply/rohm,bd99954.yaml   |   2 +-
 .../bindings/power/supply/rt9455_charger.txt  |  46 -----
 .../bindings/power/supply/rx51-battery.txt    |  25 ---
 .../power/supply/sbs,sbs-battery.yaml         |   7 +-
 .../power/supply/sbs,sbs-charger.yaml         |  55 ++++++
 .../bindings/power/supply/sbs,sbs-manager.txt |  66 -------
 .../power/supply/sbs,sbs-manager.yaml         | 107 +++++++++++
 .../bindings/power/supply/sbs_sbs-charger.txt |  21 ---
 .../bindings/power/supply/sc2731-charger.yaml |  53 ++++++
 .../bindings/power/supply/sc2731_charger.txt  |  40 -----
 .../bindings/power/supply/sc27xx-fg.txt       |  59 ------
 .../bindings/power/supply/sc27xx-fg.yaml      |  98 ++++++++++
 .../fg.txt => stericsson,ab8500-battery.txt}  |  32 +---
 .../power/supply/stericsson,ab8500-btemp.yaml |  73 ++++++++
 .../supply/stericsson,ab8500-chargalg.yaml    |  37 ++++
 .../supply/stericsson,ab8500-charger.yaml     | 123 +++++++++++++
 .../power/supply/stericsson,ab8500-fg.yaml    |  72 ++++++++
 .../bindings/power/supply/ti,bq24735.txt      |  39 ----
 .../bindings/power/supply/ti,lp8727.yaml      |  90 ++++++++++
 .../power/supply/tps65090-charger.yaml        |  36 ++++
 .../bindings/power/supply/tps65090.txt        |  17 --
 .../power/supply/tps65217-charger.yaml        |  43 +++++
 .../power/supply/tps65217_charger.txt         |  17 --
 .../bindings/power/supply/twl-charger.txt     |  30 ----
 .../power/supply/twl4030-charger.yaml         |  68 +++++++
 .../x-powers,axp20x-ac-power-supply.yaml      |  32 ++++
 .../x-powers,axp20x-battery-power-supply.yaml |  30 ++++
 .../x-powers,axp20x-usb-power-supply.yaml     |  33 ++++
 .../arm/boot/dts/motorola-cpcap-mapphone.dtsi |  59 +++---
 86 files changed, 2865 insertions(+), 1493 deletions(-)
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

-- 
2.30.2

