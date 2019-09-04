Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EECF1A7E7D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 10:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfIDIyB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 04:54:01 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:26542 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIDIx6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 04:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567587231;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=GqIs1lrUU3RhxWl/F9Id3HKhdnHE8O/rmtE4vRzKP40=;
        b=U3qA/Ijxx++4v3RBXoZFtD0Rn7N0KQzoZuAtXn5Vl1xzM0vmkzvlyQObxSToafuwR9
        OsPqUJtW8EpDW7TXnmS3u0FVse9/sAseHGCWlc3GitlEEXKNIGAUCEaqSe93hAZuVvC4
        y/OE6fm0cYfqQ/1Kw9e8imE7QS65HNC5QoCshavmLU3TQSN5165Q5RzFd9QbJAPu6m4v
        p2o3/jNT+nKnpydTJng52houm52R10zuFxraCe1Lv7U2WCTbrdQKGkw1hb9TqziFnONc
        D7+cBmywxy+Kh3fbTHfBpoYieMZyFKMc+newD9BFf51rNUIjbpaYTLA55U2qDTHivJaV
        7XAw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH6GK4zSwk="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v848rgcLg
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 4 Sep 2019 10:53:42 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC v2 3/3] ARM: dts: omap3: bulk convert compatible to be explicitly ti,omap3430 or ti,omap36xx
Date:   Wed,  4 Sep 2019 10:53:41 +0200
Message-Id: <a2b56edcada7b9000a6e906387a02c0ee42681db.1567587220.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1567587220.git.hns@goldelico.com>
References: <cover.1567587220.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to omap.txt bindings documentation, matching the ti-cpufreq driver needs
to specify explicitly if a board uses an omap3430 or omap36xx chip.

This needs to add ti,omap3430 to most omap34xx boards and replace ti,omap3630
by ti,omap36xx for some omap36xx boards (most others already have done it right).

We also clean up some instances of missing ti,am3517 so that we can rely on
seeing either one of:

ti,am3517
ti,omap34xx
ti,omap36xx

in addition to ti,omap3.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/am3517_mt_ventoux.dts           | 2 +-
 arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts  | 2 +-
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts  | 2 +-
 arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts | 2 +-
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts | 2 +-
 arch/arm/boot/dts/omap3-beagle.dts                | 2 +-
 arch/arm/boot/dts/omap3-cm-t3530.dts              | 2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd43.dts      | 2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd70.dts      | 2 +-
 arch/arm/boot/dts/omap3-devkit8000.dts            | 2 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts              | 2 +-
 arch/arm/boot/dts/omap3-ha-lcd.dts                | 2 +-
 arch/arm/boot/dts/omap3-ha.dts                    | 2 +-
 arch/arm/boot/dts/omap3-ldp.dts                   | 2 +-
 arch/arm/boot/dts/omap3-sbc-t3530.dts             | 2 +-
 arch/arm/boot/dts/omap3-thunder.dts               | 2 +-
 arch/arm/boot/dts/omap3430-sdp.dts                | 2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

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
diff --git a/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
index a604d92221a4..ea441acf000d 100644
--- a/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
@@ -9,5 +9,5 @@
 
 / {
 	model = "LogicPD Zoom DM3730 SOM-LV Development Kit";
-	compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap3630", "ti,omap3";
+	compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap36xx", "ti,omap3";
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
diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
index 18c27e85051f..1937a1c36ad3 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "LogicPD Zoom DM3730 Torpedo + Wireless Development Kit";
-	compatible = "logicpd,dm3730-torpedo-devkit", "ti,omap3630", "ti,omap3";
+	compatible = "logicpd,dm3730-torpedo-devkit", "ti,omap36xx", "ti,omap3";
 
 	wl12xx_vmmc: wl12xx_vmmc {
 		compatible = "regulator-fixed";
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
index 76e52c78cbb4..f13644a776aa 100644
--- a/arch/arm/boot/dts/omap3-cm-t3530.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3530.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "CompuLab CM-T3530";
-	compatible = "compulab,omap3-cm-t3530", "ti,omap34xx", "ti,omap3";
+	compatible = "compulab,omap3-cm-t3530", "ti,omap3430", "ti,omap3";
 
 	/* Regulator to trigger the reset signal of the Wifi module */
 	mmc2_sdio_reset: regulator-mmc2-sdio-reset {
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
diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index e0c0382388f0..311550ee4eae 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "TI OMAP37XX EVM (TMDSEVM3730)";
-	compatible = "ti,omap3-evm-37xx", "ti,omap3630", "ti,omap3";
+	compatible = "ti,omap3-evm-37xx", "ti,omap36xx", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
diff --git a/arch/arm/boot/dts/omap3-ha-lcd.dts b/arch/arm/boot/dts/omap3-ha-lcd.dts
index badb9b3c8897..74751798c00e 100644
--- a/arch/arm/boot/dts/omap3-ha-lcd.dts
+++ b/arch/arm/boot/dts/omap3-ha-lcd.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "TI OMAP3 HEAD acoustics LCD-baseboard with TAO3530 SOM";
-	compatible = "headacoustics,omap3-ha-lcd", "technexion,omap3-tao3530", "ti,omap34xx", "ti,omap3";
+	compatible = "headacoustics,omap3-ha-lcd", "technexion,omap3-tao3530", "ti,omap3430", "ti,omap3";
 };
 
 &omap3_pmx_core {
diff --git a/arch/arm/boot/dts/omap3-ha.dts b/arch/arm/boot/dts/omap3-ha.dts
index a5365252bfbe..f36cbc0a3586 100644
--- a/arch/arm/boot/dts/omap3-ha.dts
+++ b/arch/arm/boot/dts/omap3-ha.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "TI OMAP3 HEAD acoustics baseboard with TAO3530 SOM";
-	compatible = "headacoustics,omap3-ha", "technexion,omap3-tao3530", "ti,omap34xx", "ti,omap3";
+	compatible = "headacoustics,omap3-ha", "technexion,omap3-tao3530", "ti,omap3430", "ti,omap3";
 };
 
 &omap3_pmx_core {
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index 9a5fde2d9bce..9947574bd0f8 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "TI OMAP3430 LDP (Zoom1 Labrador)";
-	compatible = "ti,omap3-ldp", "ti,omap3";
+	compatible = "ti,omap3-ldp", "ti,omap34xx, "ti,omap3";
 
 	memory@80000000 {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/omap3-sbc-t3530.dts b/arch/arm/boot/dts/omap3-sbc-t3530.dts
index ae96002abb3b..19582ef68e60 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3530.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3530.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "CompuLab SBC-T3530 with CM-T3530";
-	compatible = "compulab,omap3-sbc-t3530", "compulab,omap3-cm-t3530", "ti,omap34xx", "ti,omap3";
+	compatible = "compulab,omap3-sbc-t3530", "compulab,omap3-cm-t3530", "ti,omap3430", "ti,omap3";
 
 	aliases {
 		display0 = &dvi0;
diff --git a/arch/arm/boot/dts/omap3-thunder.dts b/arch/arm/boot/dts/omap3-thunder.dts
index 6276e7079b36..b12ff8ecae50 100644
--- a/arch/arm/boot/dts/omap3-thunder.dts
+++ b/arch/arm/boot/dts/omap3-thunder.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "TI OMAP3 Thunder baseboard with TAO3530 SOM";
-	compatible = "technexion,omap3-thunder", "technexion,omap3-tao3530", "ti,omap34xx", "ti,omap3";
+	compatible = "technexion,omap3-thunder", "technexion,omap3-tao3530", "ti,omap3430", "ti,omap3";
 };
 
 &omap3_pmx_core {
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

