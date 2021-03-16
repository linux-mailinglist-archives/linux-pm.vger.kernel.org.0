Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A97733CE56
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 08:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhCPHCd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 03:02:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44328 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231356AbhCPHCM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 03:02:12 -0400
X-UUID: 5abef9c256ff417386aec7eb5af5cbf7-20210316
X-UUID: 5abef9c256ff417386aec7eb5af5cbf7-20210316
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1502989313; Tue, 16 Mar 2021 15:02:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Mar 2021 15:01:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Mar 2021 15:01:44 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     <michael.kao@mediatek.com>, <fan.chen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [v7,1/3] arm64: dts: mt8183: add thermal zone node
Date:   Tue, 16 Mar 2021 15:01:42 +0800
Message-ID: <20210316070144.28440-2-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210316070144.28440-1-michael.kao@mediatek.com>
References: <20210316070144.28440-1-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 18D33057B35F074E492F7361681F86E71698E3215D951BD9CBBD6C0687251D1E2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "michael.kao" <michael.kao@mediatek.com>

Add thermal zone node to Mediatek MT8183 dts file.

Evaluate the thermal zone every 500ms while not cooling
and every 100ms when passive cooling is performed.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Michael Kao <michael.kao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 85 ++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 5b782a4769e7..d3550af06408 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -657,6 +657,87 @@
 			status = "disabled";
 		};
 
+		thermal: thermal@1100b000 {
+			#thermal-sensor-cells = <1>;
+			compatible = "mediatek,mt8183-thermal";
+			reg = <0 0x1100b000 0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_THERM>,
+				 <&infracfg CLK_INFRA_AUXADC>;
+			clock-names = "therm", "auxadc";
+			resets = <&infracfg  MT8183_INFRACFG_AO_THERM_SW_RST>;
+			interrupts = <0 76 IRQ_TYPE_LEVEL_LOW>;
+			mediatek,auxadc = <&auxadc>;
+			mediatek,apmixedsys = <&apmixedsys>;
+			nvmem-cells = <&thermal_calibration>;
+			nvmem-cell-names = "calibration-data";
+		};
+
+		thermal-zones {
+			cpu_thermal: cpu_thermal {
+				polling-delay-passive = <100>;
+				polling-delay = <500>;
+				thermal-sensors = <&thermal 0>;
+				sustainable-power = <5000>;
+			};
+
+			/* The tzts1 ~ tzts6 don't need to polling */
+			/* The tzts1 ~ tzts6 don't need to thermal throttle */
+
+			tzts1: tzts1 {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+				thermal-sensors = <&thermal 1>;
+				sustainable-power = <5000>;
+				trips {};
+				cooling-maps {};
+			};
+
+			tzts2: tzts2 {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+				thermal-sensors = <&thermal 2>;
+				sustainable-power = <5000>;
+				trips {};
+				cooling-maps {};
+			};
+
+			tzts3: tzts3 {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+				thermal-sensors = <&thermal 3>;
+				sustainable-power = <5000>;
+				trips {};
+				cooling-maps {};
+			};
+
+			tzts4: tzts4 {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+				thermal-sensors = <&thermal 4>;
+				sustainable-power = <5000>;
+				trips {};
+				cooling-maps {};
+			};
+
+			tzts5: tzts5 {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+				thermal-sensors = <&thermal 5>;
+				sustainable-power = <5000>;
+				trips {};
+				cooling-maps {};
+			};
+
+			tztsABB: tztsABB {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+				thermal-sensors = <&thermal 6>;
+				sustainable-power = <5000>;
+				trips {};
+				cooling-maps {};
+			};
+		};
+
 		pwm0: pwm@1100e000 {
 			compatible = "mediatek,mt8183-disp-pwm";
 			reg = <0 0x1100e000 0 0x1000>;
@@ -926,6 +1007,10 @@
 			reg = <0 0x11f10000 0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			thermal_calibration: calib@180 {
+				reg = <0x180 0xc>;
+			};
+
 			mipi_tx_calibration: calib@190 {
 				reg = <0x190 0xc>;
 			};
-- 
2.18.0

