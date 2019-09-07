Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF29AC503
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2019 08:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406550AbfIGG4z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Sep 2019 02:56:55 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.104]:19485 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406536AbfIGG4x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Sep 2019 02:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567839404;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=i78YP3kcadcZ5k1f9E+a1wZfNSLAbgYBSnSSRnYwz+4=;
        b=kORCW5RnuisiyDdNPkQ+smdTSOSLY9AdYh0FYhztGUEFv7CcFixQBG6qXLPRpJkA9/
        PFYg+jPlDe9kb9z+fEAzfxSwHgj9/q9PtiUhs9mTM+Me2UQ0shf+Qsnr11GM5xwBfZWS
        BDar5uH0wL6El/mZrQHR6tm4UMVLKuy2irAoB7o66Pfml91ELlZEZ3Tdl/fcyxMJJfLR
        HjEvm1govipDqzwAbx4ilNtPl7WaRfUgFvl/BKUrOyAdBNRjNItOWlOqipft7Q1MSn55
        50SRt0pXM//JXkmOqAlwyjJeRLSNXubWFdJG+hjKKtqK2s6VCsSIPLZfsBXYZ/VJdW2M
        naZA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXL8GTntuxg="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v876uJqXG
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 7 Sep 2019 08:56:19 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] ARM: dts: omap3: bulk convert compatible to be explicitly ti,omap3430 or ti,omap3630 or ti,am3517
Date:   Sat,  7 Sep 2019 08:56:14 +0200
Message-Id: <2c9eb085606de4a52d73a2461b1997265cdd2ea5.1567839375.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1567839375.git.hns@goldelico.com>
References: <cover.1567839375.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For the ti-cpufreq driver we need a clear separation between omap34 and omap36 families
since they have different silicon revisions and efuses.

So far ti,omap3630/ti,omap36xx is just an additional flag to ti,omap3 while omap34 has no
required entry.

Therefore we can not match omap34 boards properly.

This needs to add ti,omap3430 and ti,omap3630 where it is missing.

We also clean up some instances of missing ti,am3517 so that we can rely on
seeing either one of:

ti,am3517
ti,omap3430
ti,omap3630

in addition to ti,omap3.

We leave ti,omap34xx and ti,omap36xx untouched for compatibility.

The script to do the conversion is:

find arch/arm/boot/dts -name '*.dts*' -exec fgrep -q '"ti,omap34xx"' {} \; ! -exec fgrep -q '"ti,omap3430"' {} \; -exec sed -i '' 's/"ti,omap34xx"/"ti,omap3430", "ti,omap34xx"/' {} \;
find arch/arm/boot/dts -name '*.dts*' -exec fgrep -q '"ti,omap36xx"' {} \; ! -exec fgrep -q '"ti,omap3630"' {} \; -exec sed -i '' 's/"ti,omap36xx"/"ti,omap3630", "ti,omap36xx"/' {} \;
find arch/arm/boot/dts \( -name 'omap*.dts*' -o -name 'logic*.dts*' \) -exec fgrep -q '"ti,omap3"' {} \; ! -exec fgrep -q '"ti,omap3630"' {} \; ! -exec fgrep -q '"ti,omap36xx"' {} \; ! -exec fgrep -q '"ti,am3517"' {} \; ! -exec fgrep -q '"ti,omap34xx"' {} \; ! -exec fgrep -q '"ti,omap3430"' {} \; -exec sed -i '' 's/"ti,omap3"/"ti,omap3430", "ti,omap3"/' {} \;

So if your out-of-tree omap3 board does not show any OPPs, please check
the compatibility entry and update if needed.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/am3517_mt_ventoux.dts            | 2 +-
 arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts   | 2 +-
 arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts  | 2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              | 2 +-
 arch/arm/boot/dts/omap3-beagle.dts                 | 2 +-
 arch/arm/boot/dts/omap3-cm-t3530.dts               | 2 +-
 arch/arm/boot/dts/omap3-cm-t3730.dts               | 2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd43.dts       | 2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd70.dts       | 2 +-
 arch/arm/boot/dts/omap3-devkit8000.dts             | 2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 | 2 +-
 arch/arm/boot/dts/omap3-ha-lcd.dts                 | 2 +-
 arch/arm/boot/dts/omap3-ha.dts                     | 2 +-
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts         | 2 +-
 arch/arm/boot/dts/omap3-igep0020.dts               | 2 +-
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts         | 2 +-
 arch/arm/boot/dts/omap3-igep0030.dts               | 2 +-
 arch/arm/boot/dts/omap3-ldp.dts                    | 2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            | 2 +-
 arch/arm/boot/dts/omap3-lilly-dbb056.dts           | 2 +-
 arch/arm/boot/dts/omap3-n9.dts                     | 2 +-
 arch/arm/boot/dts/omap3-n950.dts                   | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-alto35.dts     | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-gallop43.dts   | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-palo35.dts     | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-palo43.dts     | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-summit.dts     | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts       | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts    | 2 +-
 arch/arm/boot/dts/omap3-pandora-1ghz.dts           | 2 +-
 arch/arm/boot/dts/omap3-sbc-t3530.dts              | 2 +-
 arch/arm/boot/dts/omap3-sbc-t3730.dts              | 2 +-
 arch/arm/boot/dts/omap3-sniper.dts                 | 2 +-
 arch/arm/boot/dts/omap3-thunder.dts                | 2 +-
 arch/arm/boot/dts/omap3-zoom3.dts                  | 2 +-
 arch/arm/boot/dts/omap3430-sdp.dts                 | 2 +-
 37 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/am3517_mt_ventoux.dts b/arch/arm/boot/dts/am3517_mt_ventoux.dts
index e507e4ae0d88..e7d7124a34ba 100644
--- a/arch/arm/boot/dts/am3517_mt_ventoux.dts
+++ b/arch/arm/boot/dts/am3517_mt_ventoux.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "TeeJet Mt.Ventoux";
-	compatible = "teejet,mt_ventoux", "ti,omap3";
+	compatible = "teejet,mt_ventoux", "ti,am3517", "ti,omap3";
 
 	memory@80000000 {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts b/arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts
index f7a841a28865..2a0a98fe67f0 100644
--- a/arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts
@@ -9,5 +9,5 @@
 
 / {
 	model = "LogicPD Zoom OMAP35xx SOM-LV Development Kit";
-	compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap3";
+	compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap3430", "ti,omap3";
 };
diff --git a/arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts
index 7675bc3fa868..57bae2aa910e 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts
@@ -9,5 +9,5 @@
 
 / {
 	model = "LogicPD Zoom OMAP35xx Torpedo Development Kit";
-	compatible = "logicpd,dm3730-torpedo-devkit", "ti,omap3";
+	compatible = "logicpd,dm3730-torpedo-devkit", "ti,omap3430", "ti,omap3";
 };
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 1aa99fc1487a..125ed933ca75 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "TI OMAP3 BeagleBoard xM";
-	compatible = "ti,omap3-beagle-xm", "ti,omap36xx", "ti,omap3";
+	compatible = "ti,omap3-beagle-xm", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 
 	cpus {
 		cpu@0 {
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index e3df3c166902..4ed3f93f5841 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "TI OMAP3 BeagleBoard";
-	compatible = "ti,omap3-beagle", "ti,omap3";
+	compatible = "ti,omap3-beagle", "ti,omap3430", "ti,omap3";
 
 	cpus {
 		cpu@0 {
diff --git a/arch/arm/boot/dts/omap3-cm-t3530.dts b/arch/arm/boot/dts/omap3-cm-t3530.dts
index 76e52c78cbb4..32dbaeaed147 100644
--- a/arch/arm/boot/dts/omap3-cm-t3530.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3530.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "CompuLab CM-T3530";
-	compatible = "compulab,omap3-cm-t3530", "ti,omap34xx", "ti,omap3";
+	compatible = "compulab,omap3-cm-t3530", "ti,omap3430", "ti,omap34xx", "ti,omap3";
 
 	/* Regulator to trigger the reset signal of the Wifi module */
 	mmc2_sdio_reset: regulator-mmc2-sdio-reset {
diff --git a/arch/arm/boot/dts/omap3-cm-t3730.dts b/arch/arm/boot/dts/omap3-cm-t3730.dts
index 6e944dfa0f3d..683819bf0915 100644
--- a/arch/arm/boot/dts/omap3-cm-t3730.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3730.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "CompuLab CM-T3730";
-	compatible = "compulab,omap3-cm-t3730", "ti,omap36xx", "ti,omap3";
+	compatible = "compulab,omap3-cm-t3730", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 
 	wl12xx_vmmc2: wl12xx_vmmc2 {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd43.dts b/arch/arm/boot/dts/omap3-devkit8000-lcd43.dts
index a80fc60bc773..afed85078ad8 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-lcd43.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000-lcd43.dts
@@ -11,7 +11,7 @@
 #include "omap3-devkit8000-lcd-common.dtsi"
 / {
 	model = "TimLL OMAP3 Devkit8000 with 4.3'' LCD panel";
-	compatible = "timll,omap3-devkit8000", "ti,omap3";
+	compatible = "timll,omap3-devkit8000", "ti,omap3430", "ti,omap3";
 
 	lcd0: display {
 		panel-timing {
diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd70.dts b/arch/arm/boot/dts/omap3-devkit8000-lcd70.dts
index 0753776071f8..07c51a105c0d 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-lcd70.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000-lcd70.dts
@@ -11,7 +11,7 @@
 #include "omap3-devkit8000-lcd-common.dtsi"
 / {
 	model = "TimLL OMAP3 Devkit8000 with 7.0'' LCD panel";
-	compatible = "timll,omap3-devkit8000", "ti,omap3";
+	compatible = "timll,omap3-devkit8000", "ti,omap3430", "ti,omap3";
 
 	lcd0: display {
 		panel-timing {
diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index faafc48d8f61..162d0726b008 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -7,7 +7,7 @@
 #include "omap3-devkit8000-common.dtsi"
 / {
 	model = "TimLL OMAP3 Devkit8000";
-	compatible = "timll,omap3-devkit8000", "ti,omap3";
+	compatible = "timll,omap3-devkit8000", "ti,omap3430", "ti,omap3";
 
 	aliases {
 		display1 = &dvi0;
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index b295f6fad2a5..25b6ed9203e1 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -11,7 +11,7 @@
 
 / {
 	model = "OMAP3 GTA04";
-	compatible = "ti,omap3-gta04", "ti,omap36xx", "ti,omap3";
+	compatible = "ti,omap3-gta04", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 
 	cpus {
 		cpu@0 {
diff --git a/arch/arm/boot/dts/omap3-ha-lcd.dts b/arch/arm/boot/dts/omap3-ha-lcd.dts
index badb9b3c8897..c9ecbc45c8e2 100644
--- a/arch/arm/boot/dts/omap3-ha-lcd.dts
+++ b/arch/arm/boot/dts/omap3-ha-lcd.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "TI OMAP3 HEAD acoustics LCD-baseboard with TAO3530 SOM";
-	compatible = "headacoustics,omap3-ha-lcd", "technexion,omap3-tao3530", "ti,omap34xx", "ti,omap3";
+	compatible = "headacoustics,omap3-ha-lcd", "technexion,omap3-tao3530", "ti,omap3430", "ti,omap34xx", "ti,omap3";
 };
 
 &omap3_pmx_core {
diff --git a/arch/arm/boot/dts/omap3-ha.dts b/arch/arm/boot/dts/omap3-ha.dts
index a5365252bfbe..35c4e15abeb7 100644
--- a/arch/arm/boot/dts/omap3-ha.dts
+++ b/arch/arm/boot/dts/omap3-ha.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "TI OMAP3 HEAD acoustics baseboard with TAO3530 SOM";
-	compatible = "headacoustics,omap3-ha", "technexion,omap3-tao3530", "ti,omap34xx", "ti,omap3";
+	compatible = "headacoustics,omap3-ha", "technexion,omap3-tao3530", "ti,omap3430", "ti,omap34xx", "ti,omap3";
 };
 
 &omap3_pmx_core {
diff --git a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
index 03dcd05fb8a0..d134ce1cffc0 100644
--- a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
+++ b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "IGEPv2 Rev. F (TI OMAP AM/DM37x)";
-	compatible = "isee,omap3-igep0020-rev-f", "ti,omap36xx", "ti,omap3";
+	compatible = "isee,omap3-igep0020-rev-f", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 
 	/* Regulator to trigger the WL_EN signal of the Wifi module */
 	lbep5clwmc_wlen: regulator-lbep5clwmc-wlen {
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 6d0519e3dfd0..e341535a7162 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "IGEPv2 Rev. C (TI OMAP AM/DM37x)";
-	compatible = "isee,omap3-igep0020", "ti,omap36xx", "ti,omap3";
+	compatible = "isee,omap3-igep0020", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 
 	vmmcsdio_fixed: fixedregulator-mmcsdio {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
index 060acd1e803a..9ca1d0f61964 100644
--- a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
+++ b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "IGEP COM MODULE Rev. G (TI OMAP AM/DM37x)";
-	compatible = "isee,omap3-igep0030-rev-g", "ti,omap36xx", "ti,omap3";
+	compatible = "isee,omap3-igep0030-rev-g", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 
 	/* Regulator to trigger the WL_EN signal of the Wifi module */
 	lbep5clwmc_wlen: regulator-lbep5clwmc-wlen {
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 25170bd3c573..32f31035daa2 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "IGEP COM MODULE Rev. E (TI OMAP AM/DM37x)";
-	compatible = "isee,omap3-igep0030", "ti,omap36xx", "ti,omap3";
+	compatible = "isee,omap3-igep0030", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 
 	vmmcsdio_fixed: fixedregulator-mmcsdio {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index 9a5fde2d9bce..ec9ba04ef43b 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "TI OMAP3430 LDP (Zoom1 Labrador)";
-	compatible = "ti,omap3-ldp", "ti,omap3";
+	compatible = "ti,omap3-ldp", "ti,omap3430", "ti,omap3";
 
 	memory@80000000 {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index c22833d4e568..73d477898ec2 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -7,7 +7,7 @@
 
 / {
 	model = "INCOstartec LILLY-A83X module (DM3730)";
-	compatible = "incostartec,omap3-lilly-a83x", "ti,omap36xx", "ti,omap3";
+	compatible = "incostartec,omap3-lilly-a83x", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 
 	chosen {
 			bootargs = "console=ttyO0,115200n8 vt.global_cursor_default=0 consoleblank=0";
diff --git a/arch/arm/boot/dts/omap3-lilly-dbb056.dts b/arch/arm/boot/dts/omap3-lilly-dbb056.dts
index fec335400074..ecb4ef738e07 100644
--- a/arch/arm/boot/dts/omap3-lilly-dbb056.dts
+++ b/arch/arm/boot/dts/omap3-lilly-dbb056.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "INCOstartec LILLY-DBB056 (DM3730)";
-	compatible = "incostartec,omap3-lilly-dbb056", "incostartec,omap3-lilly-a83x", "ti,omap36xx", "ti,omap3";
+	compatible = "incostartec,omap3-lilly-dbb056", "incostartec,omap3-lilly-a83x", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 };
 
 &twl {
diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
index 74c0ff2350d3..2495a696cec6 100644
--- a/arch/arm/boot/dts/omap3-n9.dts
+++ b/arch/arm/boot/dts/omap3-n9.dts
@@ -12,7 +12,7 @@
 
 / {
 	model = "Nokia N9";
-	compatible = "nokia,omap3-n9", "ti,omap36xx", "ti,omap3";
+	compatible = "nokia,omap3-n9", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 };
 
 &i2c2 {
diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
index 9886bf8b90ab..31d47a1fad84 100644
--- a/arch/arm/boot/dts/omap3-n950.dts
+++ b/arch/arm/boot/dts/omap3-n950.dts
@@ -12,7 +12,7 @@
 
 / {
 	model = "Nokia N950";
-	compatible = "nokia,omap3-n950", "ti,omap36xx", "ti,omap3";
+	compatible = "nokia,omap3-n950", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 
 	keys {
 		compatible = "gpio-keys";
diff --git a/arch/arm/boot/dts/omap3-overo-storm-alto35.dts b/arch/arm/boot/dts/omap3-overo-storm-alto35.dts
index 18338576c41d..7f04dfad8203 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-alto35.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-alto35.dts
@@ -14,5 +14,5 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Alto35";
-	compatible = "gumstix,omap3-overo-alto35", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-alto35", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 };
diff --git a/arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts b/arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts
index f204c8af8281..bc5a04e03336 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Chestnut43";
-	compatible = "gumstix,omap3-overo-chestnut43", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-chestnut43", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
diff --git a/arch/arm/boot/dts/omap3-overo-storm-gallop43.dts b/arch/arm/boot/dts/omap3-overo-storm-gallop43.dts
index c633f7cee68e..065c31cbf0e2 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-gallop43.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-gallop43.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Gallop43";
-	compatible = "gumstix,omap3-overo-gallop43", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-gallop43", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
diff --git a/arch/arm/boot/dts/omap3-overo-storm-palo35.dts b/arch/arm/boot/dts/omap3-overo-storm-palo35.dts
index fb88ebc9858c..e38c1c51392c 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-palo35.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-palo35.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Palo35";
-	compatible = "gumstix,omap3-overo-palo35", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-palo35", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
diff --git a/arch/arm/boot/dts/omap3-overo-storm-palo43.dts b/arch/arm/boot/dts/omap3-overo-storm-palo43.dts
index 76cca00d97b6..e6dc23159c4d 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-palo43.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-palo43.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Palo43";
-	compatible = "gumstix,omap3-overo-palo43", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-palo43", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
diff --git a/arch/arm/boot/dts/omap3-overo-storm-summit.dts b/arch/arm/boot/dts/omap3-overo-storm-summit.dts
index cc081a9e4c1e..587c08ce282d 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-summit.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-summit.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Summit";
-	compatible = "gumstix,omap3-overo-summit", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-summit", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
diff --git a/arch/arm/boot/dts/omap3-overo-storm-tobi.dts b/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
index 1de41c0826e0..f57de6010994 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
@@ -14,6 +14,6 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Tobi";
-	compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 };
 
diff --git a/arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts b/arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts
index 9ed13118ed8e..281af6c113be 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts
@@ -14,5 +14,5 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on TobiDuo";
-	compatible = "gumstix,omap3-overo-tobiduo", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-tobiduo", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 };
diff --git a/arch/arm/boot/dts/omap3-pandora-1ghz.dts b/arch/arm/boot/dts/omap3-pandora-1ghz.dts
index 81b957f33c9f..ea509956d7ac 100644
--- a/arch/arm/boot/dts/omap3-pandora-1ghz.dts
+++ b/arch/arm/boot/dts/omap3-pandora-1ghz.dts
@@ -16,7 +16,7 @@
 / {
 	model = "Pandora Handheld Console 1GHz";
 
-	compatible = "openpandora,omap3-pandora-1ghz", "ti,omap36xx", "ti,omap3";
+	compatible = "openpandora,omap3-pandora-1ghz", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
diff --git a/arch/arm/boot/dts/omap3-sbc-t3530.dts b/arch/arm/boot/dts/omap3-sbc-t3530.dts
index ae96002abb3b..24bf3fd86641 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3530.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3530.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "CompuLab SBC-T3530 with CM-T3530";
-	compatible = "compulab,omap3-sbc-t3530", "compulab,omap3-cm-t3530", "ti,omap34xx", "ti,omap3";
+	compatible = "compulab,omap3-sbc-t3530", "compulab,omap3-cm-t3530", "ti,omap3430", "ti,omap34xx", "ti,omap3";
 
 	aliases {
 		display0 = &dvi0;
diff --git a/arch/arm/boot/dts/omap3-sbc-t3730.dts b/arch/arm/boot/dts/omap3-sbc-t3730.dts
index 7de6df16fc17..eb3893b9535e 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3730.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3730.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "CompuLab SBC-T3730 with CM-T3730";
-	compatible = "compulab,omap3-sbc-t3730", "compulab,omap3-cm-t3730", "ti,omap36xx", "ti,omap3";
+	compatible = "compulab,omap3-sbc-t3730", "compulab,omap3-cm-t3730", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 
 	aliases {
 		display0 = &dvi0;
diff --git a/arch/arm/boot/dts/omap3-sniper.dts b/arch/arm/boot/dts/omap3-sniper.dts
index 40a87330e8c3..b6879cdc5c13 100644
--- a/arch/arm/boot/dts/omap3-sniper.dts
+++ b/arch/arm/boot/dts/omap3-sniper.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "LG Optimus Black";
-	compatible = "lg,omap3-sniper", "ti,omap36xx", "ti,omap3";
+	compatible = "lg,omap3-sniper", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 
 	cpus {
 		cpu@0 {
diff --git a/arch/arm/boot/dts/omap3-thunder.dts b/arch/arm/boot/dts/omap3-thunder.dts
index 6276e7079b36..64221e3b3477 100644
--- a/arch/arm/boot/dts/omap3-thunder.dts
+++ b/arch/arm/boot/dts/omap3-thunder.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "TI OMAP3 Thunder baseboard with TAO3530 SOM";
-	compatible = "technexion,omap3-thunder", "technexion,omap3-tao3530", "ti,omap34xx", "ti,omap3";
+	compatible = "technexion,omap3-thunder", "technexion,omap3-tao3530", "ti,omap3430", "ti,omap34xx", "ti,omap3";
 };
 
 &omap3_pmx_core {
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
index db3a2fe84e99..d240e39f2151 100644
--- a/arch/arm/boot/dts/omap3-zoom3.dts
+++ b/arch/arm/boot/dts/omap3-zoom3.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "TI Zoom3";
-	compatible = "ti,omap3-zoom3", "ti,omap36xx", "ti,omap3";
+	compatible = "ti,omap3-zoom3", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 
 	cpus {
 		cpu@0 {
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index 0abd61108a53..7bfde8aac7ae 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "TI OMAP3430 SDP";
-	compatible = "ti,omap3430-sdp", "ti,omap3";
+	compatible = "ti,omap3430-sdp", "ti,omap3430", "ti,omap3";
 
 	memory@80000000 {
 		device_type = "memory";
-- 
2.19.1

