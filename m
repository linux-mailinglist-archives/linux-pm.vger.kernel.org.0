Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA32BAC86F
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2019 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbfIGRrK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Sep 2019 13:47:10 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:32169 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbfIGRrK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Sep 2019 13:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567878423;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=UgiWsNC2/wC8/vU5aYU2/4GpzLLnutsHtR+C7Vm9FWs=;
        b=WJwfpn2/GGPue4MsGIki3ekm00qXxC1fR60vgRWu95qD3YyIdeLvewfuNwh/r5pMjW
        5mJUyyhiBK1XmmBEFJrZQL155RuuMgUcIAG93IkMV+2qBIDg5cgFb3r1ocOlW8njdkGN
        MN8Bo9wv9C6iiY7P3NZpVFRbAHFEifE79/Mp1KJ4OFwZR2ql2NI5dCgE9Nmi6SP06XTF
        M9FnBu6fRwxGxg36p8/bdg8FxEbQCWO7J45RP1h4UqSZ7PosULxxZeY58Zn/qaI/XS6m
        zC+Tkl4B8qCj9KmhS0OGbiQFjsC6Yn2oT7UV+qUt6jbqA5h/5GLyy2mPqZubYgWvqnz2
        rjwg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXL8GTntuxg="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v87Hkurbh
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 7 Sep 2019 19:46:56 +0200 (CEST)
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
Subject: [PATCH 2/4] ARM: dts: replace opp-v1 tables by opp-v2 for omap34xx and omap36xx
Date:   Sat,  7 Sep 2019 19:46:51 +0200
Message-Id: <784d0d08ee585fc436f15de4edb58b394d0f4452.1567878413.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1567878413.git.hns@goldelico.com>
References: <cover.1567878413.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In addition, move omap3 from whitelist to blacklist in cpufreq-dt-platdev
in the same patch, because doing either first breaks operation and
may make trouble in bisect.

We also can remove opp-v1 table for omap3-n950-n9 since it is now
automatically detected.

We also fix a wrong OPP4 voltage for omap3430 which must be
0.6V + 54*12.5mV = 1275mV. Otherwise the twl4030 driver will reject
this OPP.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-n950-n9.dtsi |  7 ---
 arch/arm/boot/dts/omap34xx.dtsi      | 65 ++++++++++++++++++++++++----
 arch/arm/boot/dts/omap36xx.dtsi      | 53 +++++++++++++++++++----
 drivers/cpufreq/cpufreq-dt-platdev.c |  2 +-
 4 files changed, 102 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index 5441e9ffdbb4..e98b0c615f19 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -11,13 +11,6 @@
 	cpus {
 		cpu@0 {
 			cpu0-supply = <&vcc>;
-			operating-points = <
-				/* kHz    uV */
-				300000  1012500
-				600000  1200000
-				800000  1325000
-				1000000	1375000
-			>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index f572a477f74c..91154829f86a 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -16,19 +16,66 @@
 / {
 	cpus {
 		cpu: cpu@0 {
-			/* OMAP343x/OMAP35xx variants OPP1-5 */
-			operating-points = <
-				/* kHz    uV */
-				125000   975000
-				250000  1075000
-				500000  1200000
-				550000  1270000
-				600000  1350000
-			>;
+			/* OMAP343x/OMAP35xx variants OPP1-6 */
+			operating-points-v2 = <&cpu0_opp_table>;
+
 			clock-latency = <300000>; /* From legacy driver */
 		};
 	};
 
+	/* see Documentation/devicetree/bindings/opp/opp.txt */
+	cpu0_opp_table: opp-table {
+		compatible = "operating-points-v2-ti-cpu";
+		syscon = <&scm_conf>;
+
+		opp1-125000000 {
+			opp-hz = /bits/ 64 <125000000>;
+			/*
+			 * we currently only select the max voltage from table
+			 * Table 3-3 of the omap3530 Data sheet (SPRS507F).
+			 * Format is: <target min max>
+			 */
+			opp-microvolt = <975000 975000 975000>;
+			/*
+			 * first value is silicon revision bit mask
+			 * second one 720MHz Device Identification bit mask
+			 */
+			opp-supported-hw = <0xffffffff 3>;
+		};
+
+		opp2-250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			opp-microvolt = <1075000 1075000 1075000>;
+			opp-supported-hw = <0xffffffff 3>;
+			opp-suspend;
+		};
+
+		opp3-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <1200000 1200000 1200000>;
+			opp-supported-hw = <0xffffffff 3>;
+		};
+
+		opp4-550000000 {
+			opp-hz = /bits/ 64 <550000000>;
+			opp-microvolt = <1275000 1275000 1275000>;
+			opp-supported-hw = <0xffffffff 3>;
+		};
+
+		opp5-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1350000 1350000 1350000>;
+			opp-supported-hw = <0xffffffff 3>;
+		};
+
+		opp6-720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <1350000 1350000 1350000>;
+			/* only high-speed grade omap3530 devices */
+			opp-supported-hw = <0xffffffff 2>;
+		};
+	};
+
 	ocp@68000000 {
 		omap3_pmx_core2: pinmux@480025d8 {
 			compatible = "ti,omap3-padconf", "pinctrl-single";
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 6fb23ada1f64..44f25b0eb45b 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -19,15 +19,52 @@
 	};
 
 	cpus {
-		/* OMAP3630/OMAP37xx 'standard device' variants OPP50 to OPP130 */
+		/* OMAP3630/OMAP37xx variants OPP50 to OPP130 and OPP1G */
 		cpu: cpu@0 {
-			operating-points = <
-				/* kHz    uV */
-				300000  1012500
-				600000  1200000
-				800000  1325000
-			>;
-			clock-latency = <300000>; /* From legacy driver */
+			operating-points-v2 = <&cpu0_opp_table>;
+
+			clock-latency = <300000>; /* From omap-cpufreq driver */
+		};
+	};
+
+	/* see Documentation/devicetree/bindings/opp/opp.txt */
+	cpu0_opp_table: opp-table {
+		compatible = "operating-points-v2-ti-cpu";
+		syscon = <&scm_conf>;
+
+		opp50-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			/*
+			 * we currently only select the max voltage from table
+			 * Table 4-19 of the DM3730 Data sheet (SPRS685B)
+			 * Format is: <target min max>
+			 */
+			opp-microvolt = <1012500 1012500 1012500>;
+			/*
+			 * first value is silicon revision bit mask
+			 * second one is "speed binned" bit mask
+			 */
+			opp-supported-hw = <0xffffffff 3>;
+			opp-suspend;
+		};
+
+		opp100-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1200000 1200000 1200000>;
+			opp-supported-hw = <0xffffffff 3>;
+		};
+
+		opp130-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1325000 1325000 1325000>;
+			opp-supported-hw = <0xffffffff 3>;
+		};
+
+		opp1g-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1375000 1375000 1375000>;
+			/* only on am/dm37x with speed-binned bit set */
+			opp-supported-hw = <0xffffffff 2>;
 		};
 	};
 
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 03dc4244ab00..68b7fc4225f8 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -86,7 +86,6 @@ static const struct of_device_id whitelist[] __initconst = {
 	{ .compatible = "st-ericsson,u9540", },
 
 	{ .compatible = "ti,omap2", },
-	{ .compatible = "ti,omap3", },
 	{ .compatible = "ti,omap4", },
 	{ .compatible = "ti,omap5", },
 
@@ -132,6 +131,7 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "ti,am33xx", },
 	{ .compatible = "ti,am43", },
 	{ .compatible = "ti,dra7", },
+	{ .compatible = "ti,omap3", },
 
 	{ }
 };
-- 
2.19.1

