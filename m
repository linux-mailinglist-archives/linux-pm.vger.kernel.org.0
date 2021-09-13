Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D658409B06
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 19:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345660AbhIMRkd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 13:40:33 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59160 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243866AbhIMRjx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 13:39:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 882BC2005D5;
        Mon, 13 Sep 2021 19:38:36 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7060A2005AC;
        Mon, 13 Sep 2021 19:38:36 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A25C620363;
        Mon, 13 Sep 2021 19:38:35 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 16/19] arm64: dts: imx8mq: Add interconnect properties to icc consumer nodes
Date:   Mon, 13 Sep 2021 20:38:11 +0300
Message-Id: <1631554694-9599-17-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We add all the properties necessary to control the interconnect
based on the required rates all the way from consumers to the dram.
The fsl,icc-rate specifies the minimum required rate the consumer needs
in order to operate.
For now, only the fec, usdhc1 and usdhc2 are added as consumers.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 5a73ebda6bb3..0489f7416993 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1215,6 +1215,9 @@ usdhc1: mmc@30b40000 {
 				             "fsl,imx7d-usdhc";
 				reg = <0x30b40000 0x10000>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&icc IMX8MQ_ICM_USDHC1 &icc IMX8MQ_ICS_DRAM>;
+				interconnect-names = "path";
+				fsl,icc-rate = <266666>;
 				clocks = <&clk IMX8MQ_CLK_IPG_ROOT>,
 				         <&clk IMX8MQ_CLK_NAND_USDHC_BUS>,
 				         <&clk IMX8MQ_CLK_USDHC1_ROOT>;
@@ -1230,6 +1233,9 @@ usdhc2: mmc@30b50000 {
 				             "fsl,imx7d-usdhc";
 				reg = <0x30b50000 0x10000>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&icc IMX8MQ_ICM_USDHC2 &icc IMX8MQ_ICS_DRAM>;
+				interconnect-names = "path";
+				fsl,icc-rate = <266666>;
 				clocks = <&clk IMX8MQ_CLK_IPG_ROOT>,
 				         <&clk IMX8MQ_CLK_NAND_USDHC_BUS>,
 				         <&clk IMX8MQ_CLK_USDHC2_ROOT>;
@@ -1272,6 +1278,9 @@ fec1: ethernet@30be0000 {
 				             <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&icc IMX8MQ_ICM_ENET &icc IMX8MQ_ICS_DRAM>;
+				interconnect-names = "path";
+				fsl,icc-rate = <800000>;
 				clocks = <&clk IMX8MQ_CLK_ENET1_ROOT>,
 				         <&clk IMX8MQ_CLK_ENET1_ROOT>,
 				         <&clk IMX8MQ_CLK_ENET_TIMER>,
-- 
2.31.1

