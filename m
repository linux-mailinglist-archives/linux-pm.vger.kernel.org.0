Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D119E2F0DE7
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 09:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbhAKIW6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 03:22:58 -0500
Received: from comms.puri.sm ([159.203.221.185]:60528 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbhAKIW6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Jan 2021 03:22:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id B0F75DF6AB;
        Mon, 11 Jan 2021 00:22:17 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J0pOjU8TVSyv; Mon, 11 Jan 2021 00:22:16 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 2/5] arm64: dts: imx8mq: Add interconnect provider property
Date:   Mon, 11 Jan 2021 09:21:44 +0100
Message-Id: <20210111082144.24450-1-martin.kepplinger@puri.sm>
In-Reply-To: <20210111045103.GH28365@dragon>
References: <20210111045103.GH28365@dragon>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add #interconnect-cells on main &noc so that it will probe the interconnect
provider.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Acked-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index dbe480a76aa1..89e7de2e7f7a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1163,6 +1163,7 @@
 			reg = <0x32700000 0x100000>;
 			clocks = <&clk IMX8MQ_CLK_NOC>;
 			fsl,ddrc = <&ddrc>;
+			#interconnect-cells = <1>;
 			operating-points-v2 = <&noc_opp_table>;
 
 			noc_opp_table: opp-table {
-- 
2.20.1

