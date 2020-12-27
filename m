Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970462E30C0
	for <lists+linux-pm@lfdr.de>; Sun, 27 Dec 2020 11:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgL0Kz5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Dec 2020 05:55:57 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:47773 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726075AbgL0Kz4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Dec 2020 05:55:56 -0500
X-UUID: 9210d22920034e4da6190ca0b4aaeb1b-20201227
X-UUID: 9210d22920034e4da6190ca0b4aaeb1b-20201227
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1697672711; Sun, 27 Dec 2020 18:55:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 27 Dec 2020 18:56:17 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 27 Dec 2020 18:56:17 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Roger Lu <roger.lu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v10 6/7] [v10,6/7]: arm64: dts: mt8192: add svs device information
Date:   Sun, 27 Dec 2020 18:54:48 +0800
Message-ID: <20201227105449.11452-7-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201227105449.11452-1-roger.lu@mediatek.com>
References: <20201227105449.11452-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A0FF4107041BC1BC3F260B2EBDF2F9E7EB82EECE6D45A68538D62697048BB8B12000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

add compitable/reg/irq/clock/efuse/reset setting in svs node

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 34 ++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 69d45c7b31f1..8fc2d3c370a7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -224,6 +224,14 @@
 			compatible = "mediatek,mt8192-infracfg", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
 			#clock-cells = <1>;
+
+			infracfg_rst: reset-controller {
+				compatible = "mediatek,infra-reset", "ti,syscon-reset";
+				#reset-cells = <1>;
+				ti,reset-bits = <
+					0x150 5 0x154 5 0 0     (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 0: svs */
+				>;
+			};
 		};
 
 		pericfg: syscon@10003000 {
@@ -318,6 +326,20 @@
 			status = "disabled";
 		};
 
+		svs: svs@1100b000 {
+			compatible = "mediatek,mt8192-svs";
+			reg = <0 0x1100b000 0 0x1000>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg CLK_INFRA_THERM>;
+			clock-names = "main";
+			nvmem-cells = <&svs_calibration>,
+				      <&lvts_e_data1>;
+			nvmem-cell-names = "svs-calibration-data",
+					   "t-calibration-data";
+			resets = <&infracfg_rst 0>;
+			reset-names = "svs_rst";
+		};
+
 		spi1: spi@11010000 {
 			compatible = "mediatek,mt8192-spi",
 				     "mediatek,mt6765-spi";
@@ -422,6 +444,18 @@
 			#clock-cells = <1>;
 		};
 
+		efuse: efuse@11c10000 {
+			compatible = "mediatek,efuse";
+			reg = <0 0x11c10000 0 0x1000>;
+
+			lvts_e_data1: data1 {
+				reg = <0x1C0 0x58>;
+			};
+			svs_calibration: calib@580 {
+				reg = <0x580 0x68>;
+			};
+		};
+
 		i2c3: i2c3@11cb0000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11cb0000 0 0x1000>,
-- 
2.18.0

