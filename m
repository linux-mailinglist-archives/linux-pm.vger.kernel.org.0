Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F5C2ECF76
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 13:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbhAGMTH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 07:19:07 -0500
Received: from comms.puri.sm ([159.203.221.185]:43920 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbhAGMTH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Jan 2021 07:19:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id A5CB3E20F7;
        Thu,  7 Jan 2021 04:18:26 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vacq4ajD9Ilv; Thu,  7 Jan 2021 04:18:25 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com, gregkh@linuxfoundation.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 1/5] arm64: dts: imx8mq: Add NOC node
Date:   Thu,  7 Jan 2021 13:17:50 +0100
Message-Id: <20210107121754.3295-2-martin.kepplinger@puri.sm>
In-Reply-To: <20210107121754.3295-1-martin.kepplinger@puri.sm>
References: <20210107121754.3295-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

Add initial support for dynamic frequency scaling of the main NOC
on imx8mq.

Make DDRC the parent of the NOC (using passive governor) so that the
main NOC is automatically scaled together with DDRC by default.

Support for proactive scaling via interconnect will come on top.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Acked-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index a841a023e8e0..dbe480a76aa1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1158,6 +1158,30 @@
 			};
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mq-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MQ_CLK_NOC>;
+			fsl,ddrc = <&ddrc>;
+			operating-points-v2 = <&noc_opp_table>;
+
+			noc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-133M {
+					opp-hz = /bits/ 64 <133333333>;
+				};
+
+				opp-400M {
+					opp-hz = /bits/ 64 <400000000>;
+				};
+
+				opp-800M {
+					opp-hz = /bits/ 64 <800000000>;
+				};
+			};
+		};
+
 		bus@32c00000 { /* AIPS4 */
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x32c00000 0x400000>;
-- 
2.20.1

