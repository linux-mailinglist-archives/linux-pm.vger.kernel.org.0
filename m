Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC3287D58
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 22:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgJHUpZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 16:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbgJHUpY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 16:45:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5D4C0613D3;
        Thu,  8 Oct 2020 13:45:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so8034140wrx.7;
        Thu, 08 Oct 2020 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZWl2NYOBLkMRmJAVc3T/UvJ4byP1GC6peU/ci2WZ0Aw=;
        b=RxlTBc/amUFv5Ig7Q3hy66dmRTTgGxVlF4BP5MFuusGfpPV1xGraH70FTWTcWIBfWG
         FLbEIWm8DiGpSgbXk5Vxc7byYZRI6SsiCZywr1bayoN0n+LWVUPaCCDzlxFEo2VZISAc
         oEuSoBEtQ9NCehnQ0ZMe8xnjuaYMx/BmJrEXis1OzWVOTXcNy522obVGjdJ6yyXt65y7
         jNM5NT0WjEGveeXZiu4OfoV1CFpk9VbXvvd2azy93b4Fq7RRcfaWIFCrTUMxMPrBA3G7
         Bqb3YWV4LM3gYrzyw4xXBraLWmA++pk9DSevcaiZqVOa2RM2vd0P7PVpTjh2ygD1Gj8P
         DNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZWl2NYOBLkMRmJAVc3T/UvJ4byP1GC6peU/ci2WZ0Aw=;
        b=U+j+sRLZQpqgv/uMVOAkzvHSYbhV7iLnYQWJlM8YRxbrjDQuPsZT5DiGfqx6dJHW1O
         Q5+8kCDNJKHZtaldR4YmUxNX80EhhUqR3qGhYWbaR8w2DNYardETB0NiWmGzQSQvqowN
         EEsZa/qGASDPBPEFAwreuJ8DdUiPLe/K0iM7BPQe77liKg0AYZofcnJGFnJahNN4ZqAI
         n2PkgkwIAH8Ce9qLjk2iZOsd/P6EhEDsFt4oVIpwsbFHFNgNjjEF/GXZaqnSmyEzqzBy
         4ltCWcLRwGySFkW2vGndNJ6BrEDXlxB4qtwEPVKwtalAb0/wCjg8esjiAWlYqVP5zyvL
         d8NA==
X-Gm-Message-State: AOAM530ebloJ5U0s21E0TTnygGq7Ru0tSXtRq0qoQuZ7m+MRqzKIKT3o
        3DZNDoFvroUzgiPHT7wYjeTCnr0SUJexig==
X-Google-Smtp-Source: ABdhPJzo/ErP9eInwwC5xj2NK5pO0Cr0FOcQKmyO2Ex8GcvC1rKid0qlTzGh/4K2RaGoxyuuERk+7w==
X-Received: by 2002:a5d:6247:: with SMTP id m7mr7134295wrv.34.1602189922824;
        Thu, 08 Oct 2020 13:45:22 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([2.237.20.237])
        by smtp.gmail.com with ESMTPSA id o14sm8640103wmc.36.2020.10.08.13.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:45:22 -0700 (PDT)
From:   kholk11@gmail.com
To:     bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, agross@kernel.org, georgi.djakov@linaro.org,
        kholk11@gmail.com, marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: interconnect: Add bindings for Qualcomm SDM660 NoC
Date:   Thu,  8 Oct 2020 22:45:14 +0200
Message-Id: <20201008204515.695210-2-kholk11@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008204515.695210-1-kholk11@gmail.com>
References: <20201008204515.695210-1-kholk11@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: AngeloGioacchino Del Regno <kholk11@gmail.com>

Add the bindings for the Qualcomm SDM660-class NoC, valid for
SDM630, SDM636, SDM660 and SDA variants.

Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
---
 .../bindings/interconnect/qcom,sdm660.yaml    | 147 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sdm660.h    | 116 ++++++++++++++
 2 files changed, 263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,sdm660.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
new file mode 100644
index 000000000000..440e9bc1382a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sdm660.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SDM660 Network-On-Chip interconnect
+
+maintainers:
+  - Georgi Djakov <georgi.djakov@linaro.org>
+
+description: |
+  The Qualcomm SDM660 interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+properties:
+  reg:
+    maxItems: 1
+
+  compatible:
+    enum:
+      - qcom,sdm660-a2noc
+      - qcom,sdm660-bimc
+      - qcom,sdm660-cnoc
+      - qcom,sdm660-gnoc
+      - qcom,sdm660-mnoc
+      - qcom,sdm660-snoc
+
+  '#interconnect-cells':
+    const: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
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
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm660-mnoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus Clock.
+            - description: Bus A Clock.
+            - description: CPU-NoC High-performance Bus Clock.
+        clock-names:
+          items:
+            - const: bus
+            - const: bus_a
+            - const: iface
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm660-a2noc
+              - qcom,sdm660-bimc
+              - qcom,sdm660-cnoc
+              - qcom,sdm660-gnoc
+              - qcom,sdm660-snoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus Clock.
+            - description: Bus A Clock.
+        clock-names:
+          items:
+            - const: bus
+            - const: bus_a
+
+examples:
+  - |
+      #include <dt-bindings/clock/qcom,rpmcc.h>
+      #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
+
+      bimc: interconnect@1008000 {
+              compatible = "qcom,sdm660-bimc";
+              reg = <0x01008000 0x78000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
+      };
+
+      cnoc: interconnect@1500000 {
+              compatible = "qcom,sdm660-cnoc";
+              reg = <0x01500000 0x10000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
+                       <&rpmcc RPM_SMD_CNOC_A_CLK>;
+      };
+
+      snoc: interconnect@1626000 {
+              compatible = "qcom,sdm660-snoc";
+              reg = <0x01626000 0x7090>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+                       <&rpmcc RPM_SMD_SNOC_A_CLK>;
+      };
+
+      a2noc: interconnect@1704000 {
+              compatible = "qcom,sdm660-a2noc";
+              reg = <0x01704000 0xc100>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
+                       <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>;
+      };
+
+      mnoc: interconnect@1745000 {
+              compatible = "qcom,sdm660-mnoc";
+              reg = <0x01745000 0xa010>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a", "iface";
+              clocks = <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK>,
+                       <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK_A>,
+                       <&mmcc AHB_CLK_SRC>;
+      };
+
+      gnoc: interconnect@17900000 {
+              compatible = "qcom,sdm660-gnoc";
+              reg = <0x17900000 0xe000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&xo_board>, <&xo_board>;
+      };
diff --git a/include/dt-bindings/interconnect/qcom,sdm660.h b/include/dt-bindings/interconnect/qcom,sdm660.h
new file mode 100644
index 000000000000..62e8d8670d5e
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sdm660.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* SDM660 interconnect IDs */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SDM660_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SDM660_H
+
+/* A2NOC */
+#define MASTER_IPA			0
+#define MASTER_CNOC_A2NOC		1
+#define MASTER_SDCC_1			2
+#define MASTER_SDCC_2			3
+#define MASTER_BLSP_1			4
+#define MASTER_BLSP_2			5
+#define MASTER_UFS			6
+#define MASTER_USB_HS			7
+#define MASTER_USB3			8
+#define MASTER_CRYPTO_C0		9
+#define SLAVE_A2NOC_SNOC		10
+
+/* BIMC */
+#define MASTER_GNOC_BIMC		0
+#define MASTER_OXILI			1
+#define MASTER_MNOC_BIMC		2
+#define MASTER_SNOC_BIMC		3
+#define MASTER_PIMEM			4
+#define SLAVE_EBI			5
+#define SLAVE_HMSS_L3			6
+#define SLAVE_BIMC_SNOC			7
+
+/* CNOC */
+#define MASTER_SNOC_CNOC		0
+#define MASTER_QDSS_DAP			1
+#define SLAVE_CNOC_A2NOC		2
+#define SLAVE_MPM			3
+#define SLAVE_PMIC_ARB			4
+#define SLAVE_TLMM_NORTH		5
+#define SLAVE_TCSR			6
+#define SLAVE_PIMEM_CFG			7
+#define SLAVE_IMEM_CFG			8
+#define SLAVE_MESSAGE_RAM		9
+#define SLAVE_GLM			10
+#define SLAVE_BIMC_CFG			11
+#define SLAVE_PRNG			12
+#define SLAVE_SPDM			13
+#define SLAVE_QDSS_CFG			14
+#define SLAVE_CNOC_MNOC_CFG		15
+#define SLAVE_SNOC_CFG			16
+#define SLAVE_QM_CFG			17
+#define SLAVE_CLK_CTL			18
+#define SLAVE_MSS_CFG			19
+#define SLAVE_TLMM_SOUTH		20
+#define SLAVE_UFS_CFG			21
+#define SLAVE_A2NOC_CFG			22
+#define SLAVE_A2NOC_SMMU_CFG		23
+#define SLAVE_GPUSS_CFG			24
+#define SLAVE_AHB2PHY			25
+#define SLAVE_BLSP_1			26
+#define SLAVE_SDCC_1			27
+#define SLAVE_SDCC_2			28
+#define SLAVE_TLMM_CENTER		29
+#define SLAVE_BLSP_2			30
+#define SLAVE_PDM			31
+#define SLAVE_CNOC_MNOC_MMSS_CFG	32
+#define SLAVE_USB_HS			33
+#define SLAVE_USB3_0			34
+#define SLAVE_SRVC_CNOC			35
+
+/* GNOC */
+#define MASTER_APSS_PROC		0
+#define SLAVE_GNOC_BIMC			1
+#define SLAVE_GNOC_SNOC			2
+
+/* MNOC */
+#define MASTER_CPP			0
+#define MASTER_JPEG			1
+#define MASTER_MDP_P0			2
+#define MASTER_MDP_P1			3
+#define MASTER_VENUS			4
+#define MASTER_VFE			5
+#define SLAVE_MNOC_BIMC			6
+#define MASTER_CNOC_MNOC_MMSS_CFG	7
+#define MASTER_CNOC_MNOC_CFG		8
+#define SLAVE_CAMERA_CFG		9
+#define SLAVE_CAMERA_THROTTLE_CFG	10
+#define SLAVE_MISC_CFG			11
+#define SLAVE_VENUS_THROTTLE_CFG	12
+#define SLAVE_VENUS_CFG			13
+#define SLAVE_MMSS_CLK_XPU_CFG		14
+#define SLAVE_MMSS_CLK_CFG		15
+#define SLAVE_MNOC_MPU_CFG		16
+#define SLAVE_DISPLAY_CFG		17
+#define SLAVE_CSI_PHY_CFG		18
+#define SLAVE_DISPLAY_THROTTLE_CFG	19
+#define SLAVE_SMMU_CFG			20
+#define SLAVE_SRVC_MNOC			21
+
+/* SNOC */
+#define MASTER_QDSS_ETR			0
+#define MASTER_QDSS_BAM			1
+#define MASTER_SNOC_CFG			2
+#define MASTER_BIMC_SNOC		3
+#define MASTER_A2NOC_SNOC		4
+#define MASTER_GNOC_SNOC		5
+#define SLAVE_HMSS			6
+#define SLAVE_LPASS			7
+#define SLAVE_WLAN			8
+#define SLAVE_CDSP			9
+#define SLAVE_IPA			10
+#define SLAVE_SNOC_BIMC			11
+#define SLAVE_SNOC_CNOC			12
+#define SLAVE_IMEM			13
+#define SLAVE_PIMEM			14
+#define SLAVE_QDSS_STM			15
+#define SLAVE_SRVC_SNOC			16
+
+#endif
-- 
2.28.0

