Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3ACF564
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 13:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfD3LVo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 07:21:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36323 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727430AbfD3LVn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 07:21:43 -0400
X-UUID: 47c29028b7dc4386949a3ac8766afb00-20190430
X-UUID: 47c29028b7dc4386949a3ac8766afb00-20190430
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 947838440; Tue, 30 Apr 2019 19:21:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 30 Apr 2019 19:21:29 +0800
Received: from mtkslt207.mediatek.inc (10.21.15.94) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 30 Apr 2019 19:21:29 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>,
        "Kevin Hilman" <khilman@kernel.org>,
        Roger Lu <roger.lu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [RFC v1 2/3] arm64: dts: mt8183: add svs device information
Date:   Tue, 30 Apr 2019 19:20:11 +0800
Message-ID: <20190430112012.4514-3-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190430112012.4514-1-roger.lu@mediatek.com>
References: <20190430112012.4514-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

add pmic/clock/irq/efuse setting in svs noce

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 16 +++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 46 +++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index 9b525597e5ec..42bdf4f3c0bc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -26,6 +26,22 @@
 	};
 };
 
+&svs_cpu_little {
+	vcpu_little-supply = <&mt6358_vproc12_reg>;
+};
+
+&svs_cpu_big {
+	vcpu_big-supply = <&mt6358_vproc11_reg>;
+};
+
+&svs_cci {
+	vcci-supply = <&mt6358_vproc12_reg>;
+};
+
+&svs_gpu {
+	vgpu-spply = <&mt6358_vgpu_reg>;
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 75c4881bbe5e..0ae00cf39d41 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -299,12 +299,58 @@
 			status = "disabled";
 		};
 
+		svs: svs@1100b000 {
+			compatible = "mediatek,mt8183-svs";
+			reg = <0 0x1100b000 0 0x1000>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW 0>;
+			clocks = <&infracfg CLK_INFRA_THERM>;
+			clock-names = "main_clk";
+			nvmem-cells = <&svs_calibration>,
+				      <&thermal_calibration>;
+			nvmem-cell-names = "svs-calibration-data",
+					   "calibration-data";
+
+			svs_cpu_little: svs_cpu_little {
+				compatible = "mediatek,mt8183-svs-cpu-little";
+				operating-points-v2 = <&cluster0_opp>;
+			};
+
+			svs_cpu_big: svs_cpu_big {
+				compatible = "mediatek,mt8183-svs-cpu-big";
+				operating-points-v2 = <&cluster1_opp>;
+			};
+
+			svs_cci: svs_cci {
+				compatible = "mediatek,mt8183-svs-cci";
+				operating-points-v2 = <&cluster2_opp>;
+			};
+
+			svs_gpu: svs_gpu {
+				compatible = "mediatek,mt8183-svs-gpu";
+				power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_2D>;
+				operating-points-v2 = <&gpu_opp_table>;
+			};
+		};
+
 		audiosys: syscon@11220000 {
 			compatible = "mediatek,mt8183-audiosys", "syscon";
 			reg = <0 0x11220000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		efuse: efuse@11f10000 {
+			compatible = "mediatek,efuse";
+			reg = <0 0x11f10000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			svs_calibration: calib@580 {
+				reg = <0x580 0x64>;
+			};
+			thermal_calibration: calib@180 {
+				reg = <0x180 0xc>;
+			};
+		};
+
 		mfgcfg: syscon@13000000 {
 			compatible = "mediatek,mt8183-mfgcfg", "syscon";
 			reg = <0 0x13000000 0 0x1000>;
-- 
2.18.0

