Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D49F4B02FC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2019 19:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfIKRri (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 13:47:38 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.120]:21954 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbfIKRrh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 13:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568224053;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=zTCjh/MU9k8u84ljc9bm/puUjtHWFUlUpSOaFyAcr/0=;
        b=tnkGAU/UmATVF9Wp5XK0gX7jg0OfbRxQzvG0qDMtuIkqM6PejexFKtzE9QPnHJO3/s
        DkLAwl2UEY7Vu7jrL31nLrcKuzfMUERgiW9kGn/Wh3srK6DsECrkOLgGDevC7h8v5xvU
        FFbJZ/AK0LepcaDY3pAflsaKO4MjuJ0TZtA1WvyGMaXzuCDXjoIt0JJIS/S26ksjjg8V
        N8GiHECz2p2gHvT/xTaOBeDs3hTV2WVpvYNwNcMS+Lme5aRRfEKniVHcbAzGWhSKkHWY
        AuA/Ji9AMDV3i5YxVE2IyP3FDklQdiN7yiR5brCHs7dHdVXQPPu2X3rJ9eW7IJEbKHqF
        7TvQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7Nk1d2C6Y"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v8BHlJ8ny
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 11 Sep 2019 19:47:19 +0200 (CEST)
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
Subject: [PATCH v3 8/8] ARM: dts: Add OPP-V2 table for AM3517
Date:   Wed, 11 Sep 2019 19:47:14 +0200
Message-Id: <6089486dcf1f327aa53348f5434cd57cc964c30f.1568224033.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1568224032.git.hns@goldelico.com>
References: <cover.1568224032.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

The AM3517 only lists 600MHz @ 1.2V, but the register values for
0x4830A204 = 1b86 802f, it seems like am3517 might be a derivative
of the omap36 which OPPs would be OPP50 (300 MHz) and OPP100
(600 MHz).

This patch sets up the OPP50 and OPP100 tables at 300MHz and 600MHz
for the AM3517 with each having an operating voltage at 1.2V.

Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Adam Ford <aford173@gmail.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/am3517.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index 23ea381d363f..a0f23361d4bc 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -16,6 +16,37 @@
 		can = &hecc;
 	};
 
+	cpus {
+		cpu: cpu@0 {
+			/* Based on OMAP3630 variants OPP50 and OPP100 */
+			operating-points-v2 = <&cpu0_opp_table>;
+
+			clock-latency = <300000>; /* From legacy driver */
+		};
+	};
+
+	cpu0_opp_table: opp-table {
+		compatible = "operating-points-v2-ti-cpu";
+		syscon = <&scm_conf>;
+		/*
+		 * AM3517 TRM only lists 600MHz @ 1.2V, but omap36xx
+		 * appear to operate at 300MHz as well. Since AM3517 only
+		 * lists one operating voltage, it will remain fixed at 1.2V
+		 */
+		opp50-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <1200000>;
+			opp-supported-hw = <0xffffffff 0xffffffff>;
+			opp-suspend;
+		};
+
+		opp100-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1200000>;
+			opp-supported-hw = <0xffffffff 0xffffffff>;
+		};
+	};
+
 	ocp@68000000 {
 		am35x_otg_hs: am35x_otg_hs@5c040000 {
 			compatible = "ti,omap3-musb";
-- 
2.19.1

