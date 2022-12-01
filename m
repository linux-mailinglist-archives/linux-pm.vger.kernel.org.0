Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4073B63FA1F
	for <lists+linux-pm@lfdr.de>; Thu,  1 Dec 2022 22:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiLAV5Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Dec 2022 16:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiLAV5V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Dec 2022 16:57:21 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA45C3FEA;
        Thu,  1 Dec 2022 13:57:18 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A9CDA8535C;
        Thu,  1 Dec 2022 22:57:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669931837;
        bh=t0oBra0u1usF26OQ4EbhoXbCztcFy/BC98WnQ6jGc+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHUkn86+9sDSR8U8i9EH49pCJsXXyXmr09UnIZUgw9fXfVsd8o+aRIrVjyOg9kZxr
         TFeNd98iqjf3XpbNId+4X69krUMJ2bLauvWcTvcG06lbPC0w/4+efG6kIGUsunU3FA
         koAyTRoLQPzk4AH9+aaEJ3mdgJYuaSLYr2MN8Lkr8+KcuqbE+7yqGsoafYCATVPWl8
         T2FnqM3WWx9meCSWqEbbcon7+9mVR5OkkYoint3O8Ms66WXylN8N4TEi4F2Luqt2ZS
         b8Yl5+bkHyF2FOEVrSu5k7DAxOxgE9REaWWDf04FtDy8L6kFRy+VBGj4LCiI5Zisz/
         IhzKgZ6ETv8JA==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        Adam Ford <aford173@gmail.com>, Alice Guo <alice.guo@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 3/5] arm64: dts: imx8m: Document the fuse address calculation
Date:   Thu,  1 Dec 2022 22:56:49 +0100
Message-Id: <20221201215651.152497-3-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221201215651.152497-1-marex@denx.de>
References: <20221201215651.152497-1-marex@denx.de>
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

The mapping from OCOTP reg DT property to Fusemap Descriptions Table in
the datasheet is often unclear. Add a comment to make it easier to find
out how it works. No functional change.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
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
V2: Add RB from Peng
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 19 ++++++++++++++++---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 19 ++++++++++++++++---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 21 +++++++++++++++++----
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 19 ++++++++++++++++---
 4 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 423cb36cbcd53..513c2de0caa15 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -563,15 +563,28 @@ ocotp: efuse@30350000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 
-				imx8mm_uid: unique-id@4 {
+				/*
+				 * The register address below maps to the MX8M
+				 * Fusemap Description Table entries this way.
+				 * Assuming
+				 *   reg = <ADDR SIZE>;
+				 * then
+				 *   Fuse Address = (ADDR * 4) + 0x400
+				 * Note that if SIZE is greater than 4, then
+				 * each subsequent fuse is located at offset
+				 * +0x10 in Fusemap Description Table (e.g.
+				 * reg = <0x4 0x8> describes fuses 0x410 and
+				 * 0x420).
+				 */
+				imx8mm_uid: unique-id@4 { /* 0x410-0x420 */
 					reg = <0x4 0x8>;
 				};
 
-				cpu_speed_grade: speed-grade@10 {
+				cpu_speed_grade: speed-grade@10 { /* 0x440 */
 					reg = <0x10 4>;
 				};
 
-				fec_mac_address: mac-address@90 {
+				fec_mac_address: mac-address@90 { /* 0x640 */
 					reg = <0x90 6>;
 				};
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 312e3abc35ea8..068f599cdf757 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -564,15 +564,28 @@ ocotp: efuse@30350000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 
-				imx8mn_uid: unique-id@4 {
+				/*
+				 * The register address below maps to the MX8M
+				 * Fusemap Description Table entries this way.
+				 * Assuming
+				 *   reg = <ADDR SIZE>;
+				 * then
+				 *   Fuse Address = (ADDR * 4) + 0x400
+				 * Note that if SIZE is greater than 4, then
+				 * each subsequent fuse is located at offset
+				 * +0x10 in Fusemap Description Table (e.g.
+				 * reg = <0x4 0x8> describes fuses 0x410 and
+				 * 0x420).
+				 */
+				imx8mn_uid: unique-id@4 { /* 0x410-0x420 */
 					reg = <0x4 0x8>;
 				};
 
-				cpu_speed_grade: speed-grade@10 {
+				cpu_speed_grade: speed-grade@10 { /* 0x440 */
 					reg = <0x10 4>;
 				};
 
-				fec_mac_address: mac-address@90 {
+				fec_mac_address: mac-address@90 { /* 0x640 */
 					reg = <0x90 6>;
 				};
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index c9459ed21b243..ddcd5e23ba47d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -426,19 +426,32 @@ ocotp: efuse@30350000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 
-				imx8mp_uid: unique-id@8 {
+				/*
+				 * The register address below maps to the MX8M
+				 * Fusemap Description Table entries this way.
+				 * Assuming
+				 *   reg = <ADDR SIZE>;
+				 * then
+				 *   Fuse Address = (ADDR * 4) + 0x400
+				 * Note that if SIZE is greater than 4, then
+				 * each subsequent fuse is located at offset
+				 * +0x10 in Fusemap Description Table (e.g.
+				 * reg = <0x8 0x8> describes fuses 0x420 and
+				 * 0x430).
+				 */
+				imx8mp_uid: unique-id@8 { /* 0x420-0x430 */
 					reg = <0x8 0x8>;
 				};
 
-				cpu_speed_grade: speed-grade@10 {
+				cpu_speed_grade: speed-grade@10 { /* 0x440 */
 					reg = <0x10 4>;
 				};
 
-				eth_mac1: mac-address@90 {
+				eth_mac1: mac-address@90 { /* 0x640 */
 					reg = <0x90 6>;
 				};
 
-				eth_mac2: mac-address@96 {
+				eth_mac2: mac-address@96 { /* 0x658 */
 					reg = <0x96 6>;
 				};
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 2b6d3f4ff5d93..8a2ec90b493d9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -593,15 +593,28 @@ ocotp: efuse@30350000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 
-				imx8mq_uid: soc-uid@4 {
+				/*
+				 * The register address below maps to the MX8M
+				 * Fusemap Description Table entries this way.
+				 * Assuming
+				 *   reg = <ADDR SIZE>;
+				 * then
+				 *   Fuse Address = (ADDR * 4) + 0x400
+				 * Note that if SIZE is greater than 4, then
+				 * each subsequent fuse is located at offset
+				 * +0x10 in Fusemap Description Table (e.g.
+				 * reg = <0x4 0x8> describes fuses 0x410 and
+				 * 0x420).
+				 */
+				imx8mq_uid: soc-uid@4 { /* 0x410-0x420 */
 					reg = <0x4 0x8>;
 				};
 
-				cpu_speed_grade: speed-grade@10 {
+				cpu_speed_grade: speed-grade@10 { /* 0x440 */
 					reg = <0x10 4>;
 				};
 
-				fec_mac_address: mac-address@90 {
+				fec_mac_address: mac-address@90 { /* 0x640 */
 					reg = <0x90 6>;
 				};
 			};
-- 
2.35.1

