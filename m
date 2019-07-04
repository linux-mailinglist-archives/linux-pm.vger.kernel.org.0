Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5CAD5F580
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 11:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfGDJWj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 05:22:39 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47916 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbfGDJWi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Jul 2019 05:22:38 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 422891A0584;
        Thu,  4 Jul 2019 11:22:36 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 224201A0580;
        Thu,  4 Jul 2019 11:22:22 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 51405402E1;
        Thu,  4 Jul 2019 17:22:08 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        ping.bai@nxp.com, olof@lixom.net, maxime.ripard@bootlin.com,
        jagan@amarulasolutions.com, bjorn.andersson@linaro.org,
        dinguyen@kernel.org, enric.balletbo@collabora.com,
        marcin.juszkiewicz@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/4] dt-bindings: thermal: imx8mm-thermal: Add binding doc for i.MX8MM
Date:   Thu,  4 Jul 2019 17:13:10 +0800
Message-Id: <20190704091313.9516-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190704091313.9516-1-Anson.Huang@nxp.com>
References: <20190704091313.9516-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Add thermal binding doc for Freescale's i.MX8MM Thermal Monitoring Unit.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/thermal/imx8mm-thermal.txt        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
new file mode 100644
index 0000000..d09ae82
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
@@ -0,0 +1,15 @@
+* Thermal Monitoring Unit (TMU) on Freescale i.MX8MM SoC
+
+Required properties:
+- compatible : Must be "fsl,imx8mm-tmu".
+- reg : Address range of TMU registers.
+- clocks : TMU's clock source.
+- #thermal-sensor-cells : Should be 0. See ./thermal.txt for a description.
+
+Example:
+tmu: tmu@30260000 {
+	compatible = "fsl,imx8mm-tmu";
+	reg = <0x30260000 0x10000>;
+	clocks = <&clk IMX8MM_CLK_TMU_ROOT>;
+	#thermal-sensor-cells = <0>;
+};
-- 
2.7.4

