Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A54835D3A2
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 01:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243068AbhDLXDq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 19:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243560AbhDLXDp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 19:03:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C016C061574;
        Mon, 12 Apr 2021 16:03:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C09301F453CE
Received: by jupiter.universe (Postfix, from userid 1000)
        id DC7034800C6; Tue, 13 Apr 2021 01:03:21 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 0/6] Convert remaining power-supply DT bindings to YAML
Date:   Tue, 13 Apr 2021 01:03:14 +0200
Message-Id: <20210412230320.382885-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Let's get rid of the remaining three non-YAML power-supply binding files.

1. charger-manager
   I initially skipped this, since the binding is quite complex.
   It turned out a basic yaml binding is not that complex.
   This does not check for supplies matching cm-regulator-name,
   but that should be fine considering this is a legacy binding.

2. max8925_battery.txt
   I initially skipped this, since it does not have a compatible
   node. This converts the MFD binding file
   compatible value. It needs to be described in the PMIC binding
   file, which has not yet been converted.

3. stericsson,ab8500-battery.txt
   This also describes a node below the PMIC, which does not have
   its own compatible value. The same applies.

I tested the series using dt-validate 2021.3.dev6+g38efe3f and nothing
is reported when running any of the following

for file in Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml \
            Documentation/devicetree/bindings/mfd/maxim,max8925.yaml \
	    Documentation/devicetree/bindings/power/supply/charger-manager.yaml ;
do
	make -s -j4 dtbs_check DT_SCHEMA_FILES=$file
	make -s -j4 dt_binding_check DT_SCHEMA_FILES=$file
done

Merging notes:
 * The ARM DTS changes can be merged independently. The DTS changes should be
   compatible with existing drivers and existing binding documenting.
 * The last patch depends on eb917497734c ("dt-bindings: power: supply: ab8500:
   Convert to DT schema format") queued into power-supply's for-next branch for
   v5.13. The change is not critical, so it can wait for 5.14.
    
Thanks for reviewing it,

-- Sebastian

Sebastian Reichel (6):
  ARM: dts: mmp2-brownstone: Fix max8925 vendor prefix
  ARM: dts: ux500: Fix interrupt cells
  ARM: dts: ux500: Rename gpio-controller node
  dt-bindings: power: supply: charger-manager: Convert to DT schema
    format
  dt-bindings: power: mfd: max8925: Convert to DT schema format
  dt-bindings: power: mfd: ab8500: Convert to DT schema format

 .../leds/backlight/max8925-backlight.txt      |  10 -
 .../devicetree/bindings/mfd/ab8500.txt        | 280 -------
 .../devicetree/bindings/mfd/max8925.txt       |  64 --
 .../bindings/mfd/maxim,max8925.yaml           | 139 ++++
 .../bindings/mfd/stericsson,ab8500.yaml       | 696 ++++++++++++++++++
 .../bindings/pinctrl/ste,abx500.txt           | 318 --------
 .../bindings/power/supply/charger-manager.txt |  91 ---
 .../power/supply/charger-manager.yaml         | 215 ++++++
 .../bindings/power/supply/max8925_battery.txt |  18 -
 .../supply/stericsson,ab8500-battery.txt      |  34 -
 arch/arm/boot/dts/mmp2-brownstone.dts         |   2 +-
 arch/arm/boot/dts/ste-ab8500.dtsi             |  28 +-
 arch/arm/boot/dts/ste-ab8505.dtsi             |  24 +-
 arch/arm/boot/dts/ste-href-ab8500.dtsi        |   2 +-
 arch/arm/boot/dts/ste-href.dtsi               |   2 +-
 arch/arm/boot/dts/ste-snowball.dts            |   2 +-
 16 files changed, 1080 insertions(+), 845 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/max8925-backlight.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/ab8500.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/max8925.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max8925.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/ste,abx500.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/charger-manager.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/charger-manager.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/max8925_battery.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-battery.txt

-- 
2.30.2

