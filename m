Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32FA4E6C3F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 07:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfJ1GHR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 02:07:17 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53374 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfJ1GHR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Oct 2019 02:07:17 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 59A6A20070D;
        Mon, 28 Oct 2019 07:07:15 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3EBAA200161;
        Mon, 28 Oct 2019 07:07:01 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C0A60402F0;
        Mon, 28 Oct 2019 14:06:47 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, ping.bai@nxp.com, daniel.baluta@nxp.com,
        jun.li@nxp.com, bjorn.andersson@linaro.org, olof@lixom.net,
        mripard@kernel.org, vkoul@kernel.org, jagan@amarulasolutions.com,
        dinguyen@kernel.org, marcin.juszkiewicz@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH RESEND 1/4] dt-bindings: thermal: imx8mm-thermal: Add binding doc for i.MX8MM
Date:   Mon, 28 Oct 2019 14:03:35 +0800
Message-Id: <1572242618-18806-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add thermal binding doc for Freescale's i.MX8MM Thermal Monitoring Unit.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

