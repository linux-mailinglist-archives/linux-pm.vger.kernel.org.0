Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25745A5D72
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 23:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfIBVTm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 17:19:42 -0400
Received: from onstation.org ([52.200.56.107]:51246 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfIBVTj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 17:19:39 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 47250450B3;
        Mon,  2 Sep 2019 21:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1567459178;
        bh=RwDknwXG7BMrxd0qE1bu70AWpxRPESopeBguzR0DAtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3D6RY2jvtFcWcHFU9dEEKaeTxjm2JSgtJhXKv/m/i0eHbj2i0GVMCMZyu0o5EKcF
         FX2XO78GbNxhpnkaV/uY9BfAKZj+8zsbiYTJv7qAyGfvXFssQsxULNf7+rRhAWGORQ
         e+w3wyI4oG02PhRE3Pm9hOImkeGW4LSRosGIru7Y=
From:   Brian Masney <masneyb@onstation.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/2] dt-bindings: interconnect: qcom: add msm8974 bindings
Date:   Mon,  2 Sep 2019 17:19:24 -0400
Message-Id: <20190902211925.27169-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190902211925.27169-1-masneyb@onstation.org>
References: <20190902211925.27169-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device tree bindings for the Qualcomm MSM8974 interconnect providers
that support setting system bandwidth requirements between various
network-on-chip fabrics.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../bindings/interconnect/qcom,msm8974.yaml   | 163 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,msm8974.h   | 146 ++++++++++++++++
 2 files changed, 309 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8974.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
new file mode 100644
index 000000000000..fbf440f5ffe0
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
@@ -0,0 +1,163 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,msm8974.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8974 Network-On-Chip Interconnect
+
+maintainers:
+  - Brian Masney <masneyb@onstation.org>
+
+description: |
+   The Qualcomm MSM8974 interconnect providers support setting system
+   bandwidth requirements between various network-on-chip fabrics.
+
+properties:
+  reg:
+    maxItems: 1
+
+  compatible:
+    enum:
+      - qcom,msm8974-bimc
+      - qcom,msm8974-cnoc
+      - qcom,msm8974-mmssnoc
+      - qcom,msm8974-ocmemnoc
+      - qcom,msm8974-pnoc
+      - qcom,msm8974-snoc
+
+  '#interconnect-cells':
+    const: 1
+
+  clock-names:
+    items:
+      - const: bus
+      - const: bus_a
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Bus A Clock
+
+required:
+  - compatible
+  - reg
+  - '#interconnect-cells'
+  - clock-names
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/clock/qcom,mmcc-msm8974.h>
+      #include <dt-bindings/clock/qcom,rpmcc.h>
+      #include <dt-bindings/interconnect/qcom,msm8974.h>
+      #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+      bimc: interconnect@fc380000 {
+              reg = <0xfc380000 0x6a000>;
+              compatible = "qcom,msm8974-bimc";
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
+      };
+
+      cnoc: interconnect@fc480000 {
+              reg = <0xfc480000 0x4000>;
+              compatible = "qcom,msm8974-cnoc";
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
+                       <&rpmcc RPM_SMD_CNOC_A_CLK>;
+      };
+
+      mmssnoc: interconnect@fc478000 {
+              reg = <0xfc478000 0x4000>;
+              compatible = "qcom,msm8974-mmssnoc";
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_MMSSNOC_AHB_CLK>,
+                       <&rpmcc RPM_SMD_MMSSNOC_AHB_A_CLK>;
+      };
+
+      ocmemnoc: interconnect@fc470000 {
+              reg = <0xfc470000 0x4000>;
+              compatible = "qcom,msm8974-ocmemnoc";
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>,
+                       <&rpmcc RPM_SMD_OCMEMGX_A_CLK>;
+      };
+
+      pnoc: interconnect@fc468000 {
+              reg = <0xfc468000 0x4000>;
+              compatible = "qcom,msm8974-pnoc";
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
+                       <&rpmcc RPM_SMD_PNOC_A_CLK>;
+      };
+
+      snoc: interconnect@fc460000 {
+              reg = <0xfc460000 0x4000>;
+              compatible = "qcom,msm8974-snoc";
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+                       <&rpmcc RPM_SMD_SNOC_A_CLK>;
+      };
+
+      mdss: mdss@fd900000 {
+              compatible = "qcom,mdss";
+              reg = <0xfd900000 0x100>, <0xfd924000 0x1000>;
+              reg-names = "mdss_phys", "vbif_phys";
+
+              power-domains = <&mmcc MDSS_GDSC>;
+
+              clocks = <&mmcc MDSS_AHB_CLK>,
+                       <&mmcc MDSS_AXI_CLK>,
+                       <&mmcc MDSS_VSYNC_CLK>;
+              clock-names = "iface", "bus", "vsync";
+
+              interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+
+              interrupt-controller;
+              #interrupt-cells = <1>;
+
+              #address-cells = <1>;
+              #size-cells = <1>;
+              ranges;
+
+              mdp: mdp@fd900000 {
+                      compatible = "qcom,mdp5";
+                      reg = <0xfd900100 0x22000>;
+                      reg-names = "mdp_phys";
+
+                      interrupt-parent = <&mdss>;
+                      interrupts = <0 0>;
+
+                      clocks = <&mmcc MDSS_AHB_CLK>,
+                               <&mmcc MDSS_AXI_CLK>,
+                               <&mmcc MDSS_MDP_CLK>,
+                               <&mmcc MDSS_VSYNC_CLK>;
+                      clock-names = "iface", "bus", "core", "vsync";
+
+                      interconnects = <&mmssnoc MNOC_MAS_GRAPHICS_3D &bimc BIMC_SLV_EBI_CH0>,
+                                      <&ocmemnoc OCMEM_VNOC_MAS_GFX3D &ocmemnoc OCMEM_SLV_OCMEM>;
+                      interconnect-names = "mdp0-mem", "mdp1-mem";
+
+                      ports {
+                              #address-cells = <1>;
+                              #size-cells = <0>;
+
+                              port@0 {
+                                      reg = <0>;
+                                      mdp5_intf1_out: endpoint {
+                                              remote-endpoint = <&dsi0_in>;
+                                      };
+                              };
+                      };
+              };
+      };
diff --git a/include/dt-bindings/interconnect/qcom,msm8974.h b/include/dt-bindings/interconnect/qcom,msm8974.h
new file mode 100644
index 000000000000..58acf7196410
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,msm8974.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm msm8974 interconnect IDs
+ *
+ * Copyright (c) 2019 Brian Masney <masneyb@onstation.org>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8974_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8974_H
+
+#define BIMC_MAS_AMPSS_M0		0
+#define BIMC_MAS_AMPSS_M1		1
+#define BIMC_MAS_MSS_PROC		2
+#define BIMC_TO_MNOC			3
+#define BIMC_TO_SNOC			4
+#define BIMC_SLV_EBI_CH0		5
+#define BIMC_SLV_AMPSS_L2		6
+
+#define CNOC_MAS_RPM_INST		0
+#define CNOC_MAS_RPM_DATA		1
+#define CNOC_MAS_RPM_SYS		2
+#define CNOC_MAS_DEHR			3
+#define CNOC_MAS_QDSS_DAP		4
+#define CNOC_MAS_SPDM			5
+#define CNOC_MAS_TIC			6
+#define CNOC_SLV_CLK_CTL		7
+#define CNOC_SLV_CNOC_MSS		8
+#define CNOC_SLV_SECURITY		9
+#define CNOC_SLV_TCSR			10
+#define CNOC_SLV_TLMM			11
+#define CNOC_SLV_CRYPTO_0_CFG		12
+#define CNOC_SLV_CRYPTO_1_CFG		13
+#define CNOC_SLV_IMEM_CFG		14
+#define CNOC_SLV_MESSAGE_RAM		15
+#define CNOC_SLV_BIMC_CFG		16
+#define CNOC_SLV_BOOT_ROM		17
+#define CNOC_SLV_PMIC_ARB		18
+#define CNOC_SLV_SPDM_WRAPPER		19
+#define CNOC_SLV_DEHR_CFG		20
+#define CNOC_SLV_MPM			21
+#define CNOC_SLV_QDSS_CFG		22
+#define CNOC_SLV_RBCPR_CFG		23
+#define CNOC_SLV_RBCPR_QDSS_APU_CFG	24
+#define CNOC_TO_SNOC			25
+#define CNOC_SLV_CNOC_ONOC_CFG		26
+#define CNOC_SLV_CNOC_MNOC_MMSS_CFG	27
+#define CNOC_SLV_CNOC_MNOC_CFG		28
+#define CNOC_SLV_PNOC_CFG		29
+#define CNOC_SLV_SNOC_MPU_CFG		30
+#define CNOC_SLV_SNOC_CFG		31
+#define CNOC_SLV_EBI1_DLL_CFG		32
+#define CNOC_SLV_PHY_APU_CFG		33
+#define CNOC_SLV_EBI1_PHY_CFG		34
+#define CNOC_SLV_RPM			35
+#define CNOC_SLV_SERVICE_CNOC		36
+
+#define MNOC_MAS_GRAPHICS_3D		0
+#define MNOC_MAS_JPEG			1
+#define MNOC_MAS_MDP_PORT0		2
+#define MNOC_MAS_VIDEO_P0		3
+#define MNOC_MAS_VIDEO_P1		4
+#define MNOC_MAS_VFE			5
+#define MNOC_TO_CNOC			6
+#define MNOC_TO_BIMC			7
+#define MNOC_SLV_CAMERA_CFG		8
+#define MNOC_SLV_DISPLAY_CFG		9
+#define MNOC_SLV_OCMEM_CFG		10
+#define MNOC_SLV_CPR_CFG		11
+#define MNOC_SLV_CPR_XPU_CFG		12
+#define MNOC_SLV_MISC_CFG		13
+#define MNOC_SLV_MISC_XPU_CFG		14
+#define MNOC_SLV_VENUS_CFG		15
+#define MNOC_SLV_GRAPHICS_3D_CFG	16
+#define MNOC_SLV_MMSS_CLK_CFG		17
+#define MNOC_SLV_MMSS_CLK_XPU_CFG	18
+#define MNOC_SLV_MNOC_MPU_CFG		19
+#define MNOC_SLV_ONOC_MPU_CFG		20
+#define MNOC_SLV_SERVICE_MNOC		21
+
+#define OCMEM_NOC_TO_OCMEM_VNOC		0
+#define OCMEM_MAS_JPEG_OCMEM		1
+#define OCMEM_MAS_MDP_OCMEM		2
+#define OCMEM_MAS_VIDEO_P0_OCMEM	3
+#define OCMEM_MAS_VIDEO_P1_OCMEM	4
+#define OCMEM_MAS_VFE_OCMEM		5
+#define OCMEM_MAS_CNOC_ONOC_CFG		6
+#define OCMEM_SLV_SERVICE_ONOC		7
+#define OCMEM_VNOC_TO_SNOC		8
+#define OCMEM_VNOC_TO_OCMEM_NOC		9
+#define OCMEM_VNOC_MAS_GFX3D		10
+#define OCMEM_SLV_OCMEM			11
+
+#define PNOC_MAS_PNOC_CFG		0
+#define PNOC_MAS_SDCC_1			1
+#define PNOC_MAS_SDCC_3			2
+#define PNOC_MAS_SDCC_4			3
+#define PNOC_MAS_SDCC_2			4
+#define PNOC_MAS_TSIF			5
+#define PNOC_MAS_BAM_DMA		6
+#define PNOC_MAS_BLSP_2			7
+#define PNOC_MAS_USB_HSIC		8
+#define PNOC_MAS_BLSP_1			9
+#define PNOC_MAS_USB_HS			10
+#define PNOC_TO_SNOC			11
+#define PNOC_SLV_SDCC_1			12
+#define PNOC_SLV_SDCC_3			13
+#define PNOC_SLV_SDCC_2			14
+#define PNOC_SLV_SDCC_4			15
+#define PNOC_SLV_TSIF			16
+#define PNOC_SLV_BAM_DMA		17
+#define PNOC_SLV_BLSP_2			18
+#define PNOC_SLV_USB_HSIC		19
+#define PNOC_SLV_BLSP_1			20
+#define PNOC_SLV_USB_HS			21
+#define PNOC_SLV_PDM			22
+#define PNOC_SLV_PERIPH_APU_CFG		23
+#define PNOC_SLV_PNOC_MPU_CFG		24
+#define PNOC_SLV_PRNG			25
+#define PNOC_SLV_SERVICE_PNOC		26
+
+#define SNOC_MAS_LPASS_AHB		0
+#define SNOC_MAS_QDSS_BAM		1
+#define SNOC_MAS_SNOC_CFG		2
+#define SNOC_TO_BIMC			3
+#define SNOC_TO_CNOC			4
+#define SNOC_TO_PNOC			5
+#define SNOC_TO_OCMEM_VNOC		6
+#define SNOC_MAS_CRYPTO_CORE0		7
+#define SNOC_MAS_CRYPTO_CORE1		8
+#define SNOC_MAS_LPASS_PROC		9
+#define SNOC_MAS_MSS			10
+#define SNOC_MAS_MSS_NAV		11
+#define SNOC_MAS_OCMEM_DMA		12
+#define SNOC_MAS_WCSS			13
+#define SNOC_MAS_QDSS_ETR		14
+#define SNOC_MAS_USB3			15
+#define SNOC_SLV_AMPSS			16
+#define SNOC_SLV_LPASS			17
+#define SNOC_SLV_USB3			18
+#define SNOC_SLV_WCSS			19
+#define SNOC_SLV_OCIMEM			20
+#define SNOC_SLV_SNOC_OCMEM		21
+#define SNOC_SLV_SERVICE_SNOC		22
+#define SNOC_SLV_QDSS_STM		23
+
+#endif
-- 
2.21.0

