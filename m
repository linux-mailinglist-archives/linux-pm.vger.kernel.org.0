Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CA663987B
	for <lists+linux-pm@lfdr.de>; Sat, 26 Nov 2022 23:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKZWsM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Nov 2022 17:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiKZWsL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Nov 2022 17:48:11 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63712140CD;
        Sat, 26 Nov 2022 14:48:10 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 928C98515B;
        Sat, 26 Nov 2022 23:48:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669502887;
        bh=86EZTKhDRuaKl90lBCm/6wx1bcdIhb81P9lvZE5GnjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v1UC3wpzOiG7i9imUy7Chv7st1ijjSGBf0E4iyOryHIXbooEb6k9mDUgD4fKTFLEI
         6+D7Y5iD7leDPqiRDBEJ8Lqp6hXl+qTcDc6pQzyBdixZp4ytMghnSMngapN8CF5yrg
         e88Jyg8O0om2liC9l9JBxPsEswFhf6kN3kYdgScqesvm5f1LmH1ok8kDj4aKXX/taY
         caPpvMBWLy7lT7nhcqydIMG4Je4RPADeqJmktmSLoOW8jszwEtdQodJxGg1Im+44En
         z92ZBMM7sMxpmryXMe9xjBsiRJvh2BtExzcjUhYXXWANeAmrQMah6l2ImQvmk87Vh0
         330mXCT49b05A==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
        Alice Guo <alice.guo@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: imx8m: Add TMU phandle to calibration data in OCOTP
Date:   Sat, 26 Nov 2022 23:47:39 +0100
Message-Id: <20221126224740.311625-4-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221126224740.311625-1-marex@denx.de>
References: <20221126224740.311625-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The TMU TASR, TCALIVn, TRIM registers must be explicitly programmed with
calibration values in OCOTP. Add the OCOTP calibration values phandle so
the TMU driver can perform this programming.

The MX8MM/MX8MN TMUv1 uses only one OCOTP cell, while MX8MP TMUv2 uses 4.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Li Jun <jun.li@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: devicetree@vger.kernel.org
To: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 513c2de0caa15..0cd7fff47c44d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -496,6 +496,8 @@ tmu: tmu@30260000 {
 				compatible = "fsl,imx8mm-tmu";
 				reg = <0x30260000 0x10000>;
 				clocks = <&clk IMX8MM_CLK_TMU_ROOT>;
+				nvmem-cells = <&tmu_calib>;
+				nvmem-cell-names = "calib";
 				#thermal-sensor-cells = <0>;
 			};
 
@@ -584,6 +586,10 @@ cpu_speed_grade: speed-grade@10 { /* 0x440 */
 					reg = <0x10 4>;
 				};
 
+				tmu_calib: calib@3c { /* 0x4f0 */
+					reg = <0x3c 4>;
+				};
+
 				fec_mac_address: mac-address@90 { /* 0x640 */
 					reg = <0x90 6>;
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 068f599cdf757..5eef9b274edde 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -498,6 +498,8 @@ tmu: tmu@30260000 {
 				compatible = "fsl,imx8mn-tmu", "fsl,imx8mm-tmu";
 				reg = <0x30260000 0x10000>;
 				clocks = <&clk IMX8MN_CLK_TMU_ROOT>;
+				nvmem-cells = <&tmu_calib>;
+				nvmem-cell-names = "calib";
 				#thermal-sensor-cells = <0>;
 			};
 
@@ -585,6 +587,10 @@ cpu_speed_grade: speed-grade@10 { /* 0x440 */
 					reg = <0x10 4>;
 				};
 
+				tmu_calib: calib@3c { /* 0x4f0 */
+					reg = <0x3c 4>;
+				};
+
 				fec_mac_address: mac-address@90 { /* 0x640 */
 					reg = <0x90 6>;
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index ddcd5e23ba47d..0173e394ad4d8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -380,6 +380,8 @@ tmu: tmu@30260000 {
 				compatible = "fsl,imx8mp-tmu";
 				reg = <0x30260000 0x10000>;
 				clocks = <&clk IMX8MP_CLK_TSENSOR_ROOT>;
+				nvmem-cells = <&tmu_calib>;
+				nvmem-cell-names = "calib";
 				#thermal-sensor-cells = <1>;
 			};
 
@@ -454,6 +456,10 @@ eth_mac1: mac-address@90 { /* 0x640 */
 				eth_mac2: mac-address@96 { /* 0x658 */
 					reg = <0x96 6>;
 				};
+
+				tmu_calib: calib@264 { /* 0xd90-0xdc0 */
+					reg = <0x264 0x10>;
+				};
 			};
 
 			anatop: clock-controller@30360000 {
-- 
2.35.1

