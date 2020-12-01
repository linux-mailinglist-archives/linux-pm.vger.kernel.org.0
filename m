Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2240D2CA2E3
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 13:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgLAMk6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 07:40:58 -0500
Received: from comms.puri.sm ([159.203.221.185]:35256 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgLAMk6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Dec 2020 07:40:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id C3FF6E0422;
        Tue,  1 Dec 2020 04:40:17 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g9gNJm9Z32VS; Tue,  1 Dec 2020 04:40:16 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 3/7] arm64: dts: imx8mq: Add interconnect for lcdif
Date:   Tue,  1 Dec 2020 13:39:28 +0100
Message-Id: <20201201123932.12312-4-martin.kepplinger@puri.sm>
In-Reply-To: <20201201123932.12312-1-martin.kepplinger@puri.sm>
References: <20201201123932.12312-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interconnect ports for lcdif to set bus capabilities.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 244e28e54b35..f21198b19ecc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -11,6 +11,7 @@
 #include "dt-bindings/input/input.h"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/interconnect/imx8mq.h>
 #include "imx8mq-pinfunc.h"
 
 / {
@@ -522,6 +523,8 @@
 						  <&clk IMX8MQ_VIDEO_PLL1>,
 						  <&clk IMX8MQ_VIDEO_PLL1_OUT>;
 				assigned-clock-rates = <0>, <0>, <0>, <594000000>;
+				interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
+				interconnect-names = "dram";
 				status = "disabled";
 
 				port@0 {
-- 
2.20.1

