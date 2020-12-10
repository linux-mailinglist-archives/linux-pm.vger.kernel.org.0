Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533062D5801
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 11:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgLJKNF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 05:13:05 -0500
Received: from comms.puri.sm ([159.203.221.185]:40386 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbgLJKLU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 05:11:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D87EFE120D;
        Thu, 10 Dec 2020 02:09:46 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sYssI5KZXI3U; Thu, 10 Dec 2020 02:09:46 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3 3/6] arm64: dts: imx8mq: Add interconnect for lcdif
Date:   Thu, 10 Dec 2020 11:09:03 +0100
Message-Id: <20201210100906.18205-4-martin.kepplinger@puri.sm>
In-Reply-To: <20201210100906.18205-1-martin.kepplinger@puri.sm>
References: <20201210100906.18205-1-martin.kepplinger@puri.sm>
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
index 3617b7238952..7c4b68bda6fa 100644
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

