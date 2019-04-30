Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1767CF55A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 13:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfD3LVf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 07:21:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33963 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726129AbfD3LVf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 07:21:35 -0400
X-UUID: fe58e1bc20b74c34aac0d21a6cfca7f5-20190430
X-UUID: fe58e1bc20b74c34aac0d21a6cfca7f5-20190430
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1490610211; Tue, 30 Apr 2019 19:21:31 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
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
        Kevin Hilman <khilman@kernel.org>,
        Roger Lu <roger.lu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [RFC v1 1/3] dt-bindings: soc: add mtk svs dt-bindings
Date:   Tue, 30 Apr 2019 19:20:10 +0800
Message-ID: <20190430112012.4514-2-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190430112012.4514-1-roger.lu@mediatek.com>
References: <20190430112012.4514-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E98BCA2A6482E39BD36EDBBB3E007502447FBA8A75806DE18C05AF44705A47AC2000:8
X-MTK:  N
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the binding for enabling mtk svs on MediaTek SoC.

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 .../devicetree/bindings/power/mtk-svs.txt     | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mtk-svs.txt

diff --git a/Documentation/devicetree/bindings/power/mtk-svs.txt b/Documentation/devicetree/bindings/power/mtk-svs.txt
new file mode 100644
index 000000000000..355329db74ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mtk-svs.txt
@@ -0,0 +1,70 @@
+* Mediatek Smart Voltage Scaling (MTK SVS)
+
+This describes the device tree binding for the MTK SVS controller
+which helps provide the optimized CPU/GPU/CCI voltages. This device also
+needs thermal data to calculate thermal slope for accurately compensate
+the voltages when temperature change.
+
+Required properties:
+- compatible:
+  - "mediatek,mt8183-svs" : For MT8183 family of SoCs
+- reg: Address range of the MTK SVS controller.
+- interrupts: IRQ for the MTK SVS controller.
+- clocks, clock-names: Clocks needed for the svs controller. required
+                       clocks are:
+		       "main_clk": Main clock needed for register access
+- nvmem-cells: Phandle to the calibration data provided by a nvmem device.
+- nvmem-cell-names: Should be "svs-calibration-data" and "calibration-data"
+- svs_xxx: Phandle of svs_bank device for controlling corresponding opp
+           table and power-domains.
+- vxxx-supply: Phandle to each regulator. vxxx can be "vcpu_little",
+	       "vcpu_big", "vcci" and "vgpu".
+
+Example:
+
+	svs: svs@1100b000 {
+		compatible = "mediatek,mt8183-svs";
+		reg = <0 0x1100b000 0 0x1000>;
+		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW 0>;
+		clocks = <&infracfg CLK_INFRA_THERM>;
+		clock-names = "main_clk";
+		nvmem-cells = <&svs_calibration>, <&thermal_calibration>;
+		nvmem-cell-names = "svs-calibration-data", "calibration-data";
+
+		svs_cpu_little: svs_cpu_little {
+			compatible = "mediatek,mt8183-svs-cpu-little";
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		svs_cpu_big: svs_cpu_big {
+			compatible = "mediatek,mt8183-svs-cpu-big";
+			operating-points-v2 = <&cluster1_opp>;
+		};
+
+		svs_cci: svs_cci {
+			compatible = "mediatek,mt8183-svs-cci";
+			operating-points-v2 = <&cluster2_opp>;
+		};
+
+		svs_gpu: svs_gpu {
+			compatible = "mediatek,mt8183-svs-gpu";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_2D>;
+			operating-points-v2 = <&gpu_opp_table>;
+		};
+	};
+
+	&svs_cpu_little {
+		vcpu_little-supply = <&mt6358_vproc12_reg>;
+	};
+
+	&svs_cpu_big {
+		vcpu_big-supply = <&mt6358_vproc11_reg>;
+	};
+
+	&svs_cci {
+		vcci-supply = <&mt6358_vproc12_reg>;
+	};
+
+	&svs_gpu {
+		vgpu-spply = <&mt6358_vgpu_reg>;
+	};
-- 
2.18.0

