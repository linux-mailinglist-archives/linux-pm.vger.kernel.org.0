Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA55348719
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 03:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhCYCvr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 22:51:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39746 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229812AbhCYCvY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 22:51:24 -0400
X-UUID: 44417fe4b1eb4908ba19ed538156912a-20210325
X-UUID: 44417fe4b1eb4908ba19ed538156912a-20210325
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1572086155; Thu, 25 Mar 2021 10:51:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 25 Mar 2021 10:51:15 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Mar 2021 10:51:14 +0800
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
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v14 2/7] arm64: dts: mt8183: add svs device information
Date:   Thu, 25 Mar 2021 10:51:09 +0800
Message-ID: <20210325025114.25842-3-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210325025114.25842-1-roger.lu@mediatek.com>
References: <20210325025114.25842-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

add compitable/reg/irq/clock/efuse setting in svs node

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 80519a145f13..441d617ece43 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -657,6 +657,18 @@
 			status = "disabled";
 		};
 
+		svs: svs@1100b000 {
+			compatible = "mediatek,mt8183-svs";
+			reg = <0 0x1100b000 0 0x1000>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_THERM>;
+			clock-names = "main";
+			nvmem-cells = <&svs_calibration>,
+				      <&thermal_calibration>;
+			nvmem-cell-names = "svs-calibration-data",
+					   "t-calibration-data";
+		};
+
 		pwm0: pwm@1100e000 {
 			compatible = "mediatek,mt8183-disp-pwm";
 			reg = <0 0x1100e000 0 0x1000>;
@@ -941,9 +953,15 @@
 			reg = <0 0x11f10000 0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			thermal_calibration: calib@180 {
+				reg = <0x180 0xc>;
+			};
 			mipi_tx_calibration: calib@190 {
 				reg = <0x190 0xc>;
 			};
+			svs_calibration: calib@580 {
+				reg = <0x580 0x64>;
+			};
 		};
 
 		u3phy: usb-phy@11f40000 {
-- 
2.18.0

