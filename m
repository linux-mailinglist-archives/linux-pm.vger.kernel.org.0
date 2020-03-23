Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A656218F4B9
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 13:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgCWMfi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 08:35:38 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58554 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbgCWMfh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Mar 2020 08:35:37 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C34101A13AC;
        Mon, 23 Mar 2020 13:35:35 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 430171A1397;
        Mon, 23 Mar 2020 13:35:28 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EC0E0402BF;
        Mon, 23 Mar 2020 20:35:18 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, horia.geanta@nxp.com, peng.fan@nxp.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 1/3] dt-bindings: thermal: imx8mm-thermal: Add support for i.MX8MP
Date:   Mon, 23 Mar 2020 20:28:22 +0800
Message-Id: <1584966504-21719-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add thermal binding doc for Freescale's i.MX8MP Thermal Monitoring Unit.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change.
---
 Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
index d09ae82..3629d3c 100644
--- a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
@@ -1,10 +1,10 @@
 * Thermal Monitoring Unit (TMU) on Freescale i.MX8MM SoC
 
 Required properties:
-- compatible : Must be "fsl,imx8mm-tmu".
+- compatible : Must be "fsl,imx8mm-tmu" or "fsl,imx8mp-tmu".
 - reg : Address range of TMU registers.
 - clocks : TMU's clock source.
-- #thermal-sensor-cells : Should be 0. See ./thermal.txt for a description.
+- #thermal-sensor-cells : Should be 0 or 1. See ./thermal.txt for a description.
 
 Example:
 tmu: tmu@30260000 {
-- 
2.7.4

