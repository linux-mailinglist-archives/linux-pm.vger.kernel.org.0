Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07839746D8B
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jul 2023 11:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjGDJeY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jul 2023 05:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjGDJdy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2023 05:33:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1AC1722
        for <linux-pm@vger.kernel.org>; Tue,  4 Jul 2023 02:33:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qGcOv-0006tw-RL; Tue, 04 Jul 2023 11:32:49 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qGcOu-00C09s-8Y; Tue, 04 Jul 2023 11:32:48 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qGcOr-002TzG-I0; Tue, 04 Jul 2023 11:32:45 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v7 26/26] arm64: dts: rockchip: rk3588s: Add DFI
Date:   Tue,  4 Jul 2023 11:32:42 +0200
Message-Id: <20230704093242.583575-27-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230704093242.583575-1-s.hauer@pengutronix.de>
References: <20230704093242.583575-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The DFI unit can be used to measure DRAM utilization using perf. Add the
node to the device tree. The DFI needs a rockchip,pmu phandle to the pmu
containing registers for SDRAM configuration details. This is added in
this patch as well.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Notes:
    Changes since v4:
    - new patch

 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index a3124bd2e092c..723a17ec04361 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -397,6 +397,11 @@ scmi_shmem: sram@0 {
 		};
 	};
 
+	pmu1grf: syscon@fd58a000 {
+		compatible = "rockchip,rk3588-pmugrf", "syscon", "simple-mfd";
+		reg = <0x0 0xfd58a000 0x0 0x10000>;
+	};
+
 	sys_grf: syscon@fd58c000 {
 		compatible = "rockchip,rk3588-sys-grf", "syscon";
 		reg = <0x0 0xfd58c000 0x0 0x1000>;
@@ -1121,6 +1126,17 @@ qos_vop_m1: qos@fdf82200 {
 		reg = <0x0 0xfdf82200 0x0 0x20>;
 	};
 
+	dfi: dfi@fe060000 {
+		reg = <0x00 0xfe060000 0x00 0x10000>;
+		compatible = "rockchip,rk3588-dfi";
+		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "ch0", "ch1", "ch2", "ch3";
+		rockchip,pmu = <&pmu1grf>;
+	};
+
 	gmac1: ethernet@fe1c0000 {
 		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
 		reg = <0x0 0xfe1c0000 0x0 0x10000>;
-- 
2.39.2

