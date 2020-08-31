Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C222574BB
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 09:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgHaHx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 03:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaHx6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 03:53:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF8C061573
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 00:53:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n3so1895399pjq.1
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 00:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1ejUKm/YqmNXifqLJ7YW1JgKaUcKOtRzhgy9Apva5Rk=;
        b=yOCs14nHNGS4VJc/sR2rI4csRD9hM14paW3Qto8WkLBwTfXqb/A5UAOsyTALxnw7Zx
         nArasdRsaP0IJRwdRF3gbyQtVwm+8b7y8DHX6shWMudu3eUVPPKNcwlfUdem+5Rgt9Ov
         CiyV2l6nQ4UmN3m4SwV55N7145HnmDwy/RcSvVXxF8LgUVUviD3BDyVuPR0P0E2EP0rQ
         nfWv+xs5fwoO4SQT3j1Z7Qt7m9LNPR1hyXWfKRVSoA9nZawnZk0nXHlZOBNUscH6hq1O
         DK0eHpYXctDLHi1zW16n061pOwye0KhxE3PqhNyTXEHTLPJHQJv7yJoO0FUteKXSCh7B
         Lh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1ejUKm/YqmNXifqLJ7YW1JgKaUcKOtRzhgy9Apva5Rk=;
        b=dX8fs+g04D3kFoS+WBDBZpJzLeBdrKGfmEcbpnNpa7voUY88K6WDL2fqCcAJvD4/Js
         vTSp8QdnKwkfagoNhL8+yeScmsWNRvcjBDEqnmUG3r6VJRsJ+ncS2JP8uC9oAz97Xqep
         zKgg1xIg97hiOOUN48ydrg+Xi09WJMBGI97LaEOA/KFH7/FeU7bozhID7i9lVqB7rA3F
         DSWQjcssl//nqGHgoTSdycWSG+4GhdaN9MLK6p/7P9L1pKKojdadOjEwm87xDTPjIpEb
         /pJU6YqQPZRz0/I7XzG2aQif+h5OrPa/jzxgcf9U364ekpmBbtB86BR1eWV9Kx+d+9BN
         DLFw==
X-Gm-Message-State: AOAM530HtUKGFZqbJA6uch6ByS1BH304YaIOjD6V8tyxO8KOuii7DdCf
        oDojKJ+ggN6qwUfRE8J+MYaBCw==
X-Google-Smtp-Source: ABdhPJyYnSB5VeT13P6k3ZhLAvzXhS44WQcrZ78u7h7s6gmrMvpPjPPa7gXl2mUltXpCbP/QAWSE3g==
X-Received: by 2002:a17:902:7596:: with SMTP id j22mr190129pll.309.1598860436523;
        Mon, 31 Aug 2020 00:53:56 -0700 (PDT)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id u191sm6425552pgu.56.2020.08.31.00.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 00:53:55 -0700 (PDT)
From:   Jun Nie <jun.nie@linaro.org>
To:     shawn.guo@linaro.org, georgi.djakov@linaro.org,
        linux-pm@vger.kernel.org
Cc:     Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm MSM8939 DT bindings
Date:   Mon, 31 Aug 2020 15:53:28 +0800
Message-Id: <20200831075329.30374-1-jun.nie@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm MSM8939 platform has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 .../bindings/interconnect/qcom,msm8939.yaml   |  87 +++++++++++++++
 .../dt-bindings/interconnect/qcom,msm8939.h   | 105 ++++++++++++++++++
 2 files changed, 192 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8939.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
new file mode 100644
index 000000000000..99a827143723
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,msm8939.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8939 Network-On-Chip interconnect
+
+maintainers:
+  - Jun Nie <jun.nie@linaro.org>
+
+description: |
+   The Qualcomm MSM8939 interconnect providers support adjusting the
+   bandwidth requirements between the various NoC fabrics.
+
+properties:
+  compatible:
+    enum:
+      - qcom,msm8939-bimc
+      - qcom,msm8939-pcnoc
+      - qcom,msm8939-snoc
+      - qcom,msm8939-snoc-mm
+
+  reg:
+    maxItems: 1
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
+      #include <dt-bindings/clock/qcom,rpmcc.h>
+
+      bimc: interconnect@400000 {
+              compatible = "qcom,msm8939-bimc";
+              reg = <0x00400000 0x62000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
+      };
+
+      pcnoc: interconnect@500000 {
+              compatible = "qcom,msm8939-pcnoc";
+              reg = <0x00500000 0x11000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
+                       <&rpmcc RPM_SMD_PCNOC_A_CLK>;
+      };
+
+      snoc: interconnect@580000 {
+              compatible = "qcom,msm8939-snoc";
+              reg = <0x00580000 0x14000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+                       <&rpmcc RPM_SMD_SNOC_A_CLK>;
+      };
+
+      snoc_mm: interconnect@580000 {
+              compatible = "qcom,msm8939-snoc-mm";
+              reg = <0x00580000 0x14000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+	      clocks = <&rpmcc RPM_SMD_MMSSNOC_AHB_CLK>,
+		       <&rpmcc RPM_SMD_MMSSNOC_AHB_A_CLK>;
+      };
diff --git a/include/dt-bindings/interconnect/qcom,msm8939.h b/include/dt-bindings/interconnect/qcom,msm8939.h
new file mode 100644
index 000000000000..f306e88a86fe
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,msm8939.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm interconnect IDs
+ *
+ * Copyright (c) 2020, Linaro Ltd.
+ * Author: Jun Nie <jun.nie@linaro.org>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8939_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8939_H
+
+#define BIMC_SNOC_SLV			0
+#define MASTER_QDSS_BAM			1
+#define MASTER_QDSS_ETR			2
+#define MASTER_SNOC_CFG			3
+#define PCNOC_SNOC_SLV			4
+#define SLAVE_APSS			5
+#define SLAVE_CATS_128			6
+#define SLAVE_OCMEM_64			7
+#define SLAVE_IMEM			8
+#define SLAVE_QDSS_STM			9
+#define SLAVE_SRVC_SNOC			10
+#define SNOC_BIMC_0_MAS			11
+#define SNOC_BIMC_1_MAS			12
+#define SNOC_BIMC_2_MAS			13
+#define SNOC_INT_0			14
+#define SNOC_INT_1			15
+#define SNOC_INT_BIMC			16
+#define SNOC_PCNOC_MAS			17
+#define SNOC_QDSS_INT			18
+
+#define MASTER_VIDEO_P0			0
+#define MASTER_JPEG			1
+#define MASTER_VFE			2
+#define MASTER_MDP_PORT0		3
+#define MASTER_MDP_PORT1		4
+#define MASTER_CPP			5
+#define SNOC_MM_INT_0			6
+#define SNOC_MM_INT_1			7
+#define SNOC_MM_INT_2			8
+
+#define BIMC_SNOC_MAS			0
+#define MASTER_AMPSS_M0			1
+#define MASTER_GRAPHICS_3D		2
+#define MASTER_TCU0			3
+#define SLAVE_AMPSS_L2			4
+#define SLAVE_EBI_CH0			5
+#define SNOC_BIMC_0_SLV			6
+#define SNOC_BIMC_1_SLV			7
+#define SNOC_BIMC_2_SLV			8
+
+#define MASTER_BLSP_1			0
+#define MASTER_DEHR			1
+#define MASTER_LPASS			2
+#define MASTER_CRYPTO_CORE0		3
+#define MASTER_SDCC_1			4
+#define MASTER_SDCC_2			5
+#define MASTER_SPDM			6
+#define MASTER_USB_HS1			7
+#define MASTER_USB_HS2			8
+#define PCNOC_INT_0			9
+#define PCNOC_INT_1			10
+#define PCNOC_MAS_0			11
+#define PCNOC_MAS_1			12
+#define PCNOC_SLV_0			13
+#define PCNOC_SLV_1			14
+#define PCNOC_SLV_2			15
+#define PCNOC_SLV_3			16
+#define PCNOC_SLV_4			17
+#define PCNOC_SLV_8			18
+#define PCNOC_SLV_9			19
+#define PCNOC_SNOC_MAS			20
+#define SLAVE_BIMC_CFG			21
+#define SLAVE_BLSP_1			22
+#define SLAVE_BOOT_ROM			23
+#define SLAVE_CAMERA_CFG		24
+#define SLAVE_CLK_CTL			25
+#define SLAVE_CRYPTO_0_CFG		26
+#define SLAVE_DEHR_CFG			27
+#define SLAVE_DISPLAY_CFG		28
+#define SLAVE_GRAPHICS_3D_CFG		29
+#define SLAVE_IMEM_CFG			30
+#define SLAVE_LPASS			31
+#define SLAVE_MPM			32
+#define SLAVE_MSG_RAM			33
+#define SLAVE_MSS			34
+#define SLAVE_PDM			35
+#define SLAVE_PMIC_ARB			36
+#define SLAVE_PCNOC_CFG			37
+#define SLAVE_PRNG			38
+#define SLAVE_QDSS_CFG			39
+#define SLAVE_RBCPR_CFG			40
+#define SLAVE_SDCC_1			41
+#define SLAVE_SDCC_2			42
+#define SLAVE_SECURITY			43
+#define SLAVE_SNOC_CFG			44
+#define SLAVE_SPDM			45
+#define SLAVE_TCSR			46
+#define SLAVE_TLMM			47
+#define SLAVE_USB_HS1			48
+#define SLAVE_USB_HS2			49
+#define SLAVE_VENUS_CFG			50
+#define SNOC_PCNOC_SLV			51
+
+#endif
-- 
2.17.1

