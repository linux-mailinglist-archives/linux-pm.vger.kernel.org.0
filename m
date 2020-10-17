Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1E4291212
	for <lists+linux-pm@lfdr.de>; Sat, 17 Oct 2020 15:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438135AbgJQNh0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Oct 2020 09:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438119AbgJQNhZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Oct 2020 09:37:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4FBC061755;
        Sat, 17 Oct 2020 06:37:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h5so6530405wrv.7;
        Sat, 17 Oct 2020 06:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pA/QSs6eST2SK8V/JpkfnY2pqyPVeF+JLdAxLQmwYTQ=;
        b=er5Ea489wGNAHJ4l+Xr0eMeXvmclxL+PWWujmrbjtolYIL2XpJxUgbQOrrgd7H5y4h
         DGeIWYAt8dPSXjj4RbRZQpjEeN5aI7HgZLqtBaqVkHWHQZ9sjwGcyTLZCDJtZHAx75l+
         VZoDY95se0fEqdH6ULmEKzYjgc8rbLTGqpcctitVuNzHOg2eL9tyOIWe+IL+Vi6xkDBX
         Ylp0oJ8409ARHSuxavYN7XGawyBt51M7Y2GuHyMKSb7MzB0EBmjngDva3YnszHTPsOWi
         FnZvVHUFkGCGSv3oEgOLtmyCJ4aWed5N89EAXaIBFc5YEZtX9BlB+j5jBAQ0Cq+uYpSN
         Esqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pA/QSs6eST2SK8V/JpkfnY2pqyPVeF+JLdAxLQmwYTQ=;
        b=MGNOyOUGUFL+OwsJZpQNTXihsD025ooTTCY2MQOG8u5uSa1pYgXt5K35eUvNLcqf16
         COzejbexJI6/wVGedib4kSB0e0Kf63gwD6BE4yWCE2qyoZ0nZcfbW06ebtExk/xpJTy6
         ImXJSQf5Qq+UMKuP0V4J52oX6OFjgFJiDBcTZBBJGFTn7z9TtFpMdlW0GKegNTWsBwZl
         y+rj0h3nFhpGfKq929MF6j0Xd5vx5ufPe6SU/nnH1Cd+62tXEA6vnHOhse3/n/5gTtmt
         /x2VX+BOzTUuYZSaKsYlsKYZ54xCcU4J465QFZ8nKkIRooI2lvcHHxTu+34muFU5igbs
         H3Fw==
X-Gm-Message-State: AOAM5338td9IiWy1WXJ6mjVy6IjE5k/6d5HEPqgLKWVk8DIqfORfVqyN
        JDPmsmi8RL0IZxM7+NiF6IY=
X-Google-Smtp-Source: ABdhPJxXKjx/wVXYUji+Hs9f2XQqcYzJhsgWY1FXg+lC2/+56QACv9IDsDV5Hi3VNb2xoV0b4HhSSA==
X-Received: by 2002:a5d:54d0:: with SMTP id x16mr1170860wrv.75.1602941842079;
        Sat, 17 Oct 2020 06:37:22 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([2.237.20.237])
        by smtp.gmail.com with ESMTPSA id g125sm2783742wme.33.2020.10.17.06.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 06:37:21 -0700 (PDT)
From:   kholk11@gmail.com
To:     bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, agross@kernel.org, georgi.djakov@linaro.org,
        kholk11@gmail.com, marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: interconnect: Add bindings for Qualcomm SDM660 NoC
Date:   Sat, 17 Oct 2020 15:37:17 +0200
Message-Id: <20201017133718.31327-2-kholk11@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017133718.31327-1-kholk11@gmail.com>
References: <20201017133718.31327-1-kholk11@gmail.com>
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
index 000000000000..29de7807df54
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
+  - AngeloGioacchino Del Regno <kholk11@gmail.com>
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

