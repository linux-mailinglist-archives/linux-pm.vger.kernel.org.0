Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98EFAB0307
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2019 19:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfIKRru (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 13:47:50 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.103]:17121 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbfIKRrg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568224053;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=JM/wblpxwObAecxPNDrqgp7olZBmOUwQXv/3/qORPTA=;
        b=mNqQKhCj0aacPINy1UTX4O7YzAXV9SWo7W5+2gr8uBahlh8qxc8uWX3kLV/+LHrRg6
        12i0iwXRYhY+OwoUQi7IKVVJpzNa9XPgma1q3nNgBMs5pAZApJO8n03fUIKrwxXnwKpB
        Xv/xe/Ta1BHvU4EP6Ml+/me1b/+Dxrh7HNJEOpWhsMkvrwnWD/GpPSynlQCueHHwAutG
        BVk+YdGaPsUOoPLhuB3HRUiPGX0GhNzcqapOBajRVRUNCtoPszo1yyNTe2DnW2BU/7qt
        RpbFNOHfS7mPSLJtrZB/9cqQlAwfgHEj4UKWvxU8meyLfsgGijIdyChdShsYYOekRVoG
        bT5Q==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7Nk1d2C6Y"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v8BHlI8nw
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 11 Sep 2019 19:47:18 +0200 (CEST)
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
Subject: [PATCH v3 6/8] ARM: dts: omap36xx: using OPP1G needs to control the abb_ldo
Date:   Wed, 11 Sep 2019 19:47:12 +0200
Message-Id: <59a0f6267c75859c25665548db2e8a9c4229d3b4.1568224033.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1568224032.git.hns@goldelico.com>
References: <cover.1568224032.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

See DM3730,DM275 data sheet (SPRS685B) footnote (6) in Table 4-19
which says that ABB must be switched to FBB mode when using the
OPP1G.

The LOD definition abb_mpu_iva already exists so that we need
to add plumbing for vbb-supply = <&abb_mpu_iva>
and define two voltage vectors for each OPP so that the abb LDO
is also updated by the ti-cpufreq driver.

We also must switch the ti_cpufreq_soc_data to multi_regulator.

Note: reading out the abb reglator voltage to verify that
it does do transitions can be done by

cat /sys/devices/platform/68000000.ocp/483072f0.regulator-abb-mpu/regulator/regulator.*/microvolts

Likewise, read the twl4030 provided VDD voltage by

cat /sys/devices/platform/68000000.ocp/48070000.i2c/i2c-0/0-0048/48070000.i2c:twl@48:regulator-vdd1/regulator/regulator.*/microvolts

Note: to check if the ABB FBB is enabled/disabled, check
registers

PRM_LDO_ABB_CTRL 0x483072F4 bit 3:0 1=bypass 5=FBB
PRM_LDO_ABB_SETUP 0x483072F0 0x00=bypass 0x11=FBB

e.g.

/dev/mem opened.
Memory mapped at address 0xb6fe4000.
Value at address 0x483072F4 (0xb6fe42f4): 0x3205
/dev/mem opened.
Memory mapped at address 0xb6f89000.
Value at address 0x483072F4 (0xb6f892f4): 0x3201

Note: omap34xx and am3517 have/need no comparable LDO
or mechanism.

Suggested-by: Adam Ford <aford173@gmail.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap36xx.dtsi | 21 ++++++++++++++++-----
 drivers/cpufreq/ti-cpufreq.c    |  2 +-
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index cb5bd0969124..4bb4f534afe2 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -23,6 +23,7 @@
 		cpu: cpu@0 {
 			operating-points-v2 = <&cpu0_opp_table>;
 
+			vbb-supply = <&abb_mpu_iva>;
 			clock-latency = <300000>; /* From omap-cpufreq driver */
 		};
 	};
@@ -37,9 +38,11 @@
 			/*
 			 * we currently only select the max voltage from table
 			 * Table 4-19 of the DM3730 Data sheet (SPRS685B)
-			 * Format is: <target min max>
+			 * Format is:	cpu0-supply:	<target min max>
+			 *		vbb-supply:	<target min max>
 			 */
-			opp-microvolt = <1012500 1012500 1012500>;
+			opp-microvolt = <1012500 1012500 1012500>,
+					 <1012500 1012500 1012500>;
 			/*
 			 * first value is silicon revision bit mask
 			 * second one is "speed binned" bit mask
@@ -50,25 +53,33 @@
 
 		opp100-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <1200000 1200000 1200000>;
+			opp-microvolt = <1200000 1200000 1200000>,
+					 <1200000 1200000 1200000>;
 			opp-supported-hw = <0xffffffff 3>;
 		};
 
 		opp130-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <1325000 1325000 1325000>;
+			opp-microvolt = <1325000 1325000 1325000>,
+					 <1325000 1325000 1325000>;
 			opp-supported-hw = <0xffffffff 3>;
 		};
 
 		opp1g-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <1375000 1375000 1375000>;
+			opp-microvolt = <1375000 1375000 1375000>,
+					 <1375000 1375000 1375000>;
 			/* only on am/dm37x with speed-binned bit set */
 			opp-supported-hw = <0xffffffff 2>;
 			turbo-mode;
 		};
 	};
 
+	opp_supply_mpu_iva: opp_supply {
+		compatible = "ti,omap-opp-supply";
+		ti,absolute-max-voltage-uv = <1375000>;
+	};
+
 	ocp@68000000 {
 		uart4: serial@49042000 {
 			compatible = "ti,omap3-uart";
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 1a3073a3093e..f4704f9033e0 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -174,7 +174,7 @@ static struct ti_cpufreq_soc_data omap36xx_soc_data = {
 	.efuse_shift = 9,
 	.efuse_mask = BIT(9),
 	.rev_offset = OMAP3_CONTROL_IDCODE - OMAP3_SYSCON_BASE,
-	.multi_regulator = false,
+	.multi_regulator = true,
 };
 
 /**
-- 
2.19.1

