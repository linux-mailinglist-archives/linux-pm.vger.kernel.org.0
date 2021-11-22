Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343F8458AD9
	for <lists+linux-pm@lfdr.de>; Mon, 22 Nov 2021 09:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbhKVIzD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Nov 2021 03:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbhKVIyy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Nov 2021 03:54:54 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE005C061748
        for <linux-pm@vger.kernel.org>; Mon, 22 Nov 2021 00:51:47 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so14680982pjb.5
        for <linux-pm@vger.kernel.org>; Mon, 22 Nov 2021 00:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5OaQ5L0UVpCbHHsojzNQYl1bCiB0dlK4pp1Vl5dpNPI=;
        b=g1Qx9Wm5xiY5+9/XQF56GofK7kuqdwWSV32yXlK36ZXdApgLROiSYARWGfJsQQfr12
         lPcsGYPVfZnOoaqJVNpiQFjyQtYOauxrZkj9OvOeDK4igy9nKNAvYudlDvQOYy0IKlNm
         fwDyOI0qIHlOVJKyFHsYXSCRvLx9NM8EclaP46g6OTvRexQIdaDWJNbrCL69kYxug5Ns
         3uDsBeUUGJgGXCjArXS3uNbFtiPULwRiUcfo+aAekKSHC58b0jH7DZmO6y9dQQf+4mdU
         XY02sDmx9EwWHVJ8uSQtIZ+V9oOYN0njJu/tm2ead2vC/aDYxJEJyaq8fc3aRFsKTni6
         A40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5OaQ5L0UVpCbHHsojzNQYl1bCiB0dlK4pp1Vl5dpNPI=;
        b=Nuq5XbmBfYkhUMokWkxIcVml82tLTMM2v0bf84x0IXE3sKtOf6+x9jIlfVd2JssuRW
         vRckFBjvpko5D6Q1Kkn8BfonCeQajyeS58wl1KQVT4l+letq/7KCeo0Futm0z01PqcF4
         wTV8MGPDxFfQDKBjgvitmPJQEQSuHk7fH0dr7nZR8fyhRs+1rHqnabI4/4X2YH/NqvZA
         8c/ybNFEwvIaC4pf3QZMzc5NDJWNQpmkynBragoEs00m5lyFsJLy54zB+wooJrL+OdSg
         ZpLoXpsHKB5lP6erJzrD5rUrRLmSIOX8X9dm7G5cxy6ocOtgOYMmuuKaVfOz9rgTmrS8
         WTQg==
X-Gm-Message-State: AOAM531T9Y6/kI+lAZwISlB1mtaeuc8cg8GRigDdFdCHhAthu+jDSrzI
        iamPhzDbUzr7zICZTaPNgfuMmw==
X-Google-Smtp-Source: ABdhPJzy7Kl63sHb9jiyaQRb0kW6jUCiLG8Jz/LFhRC5Ql4tUExpfeFuneblhliN6/djGkqxWuIECw==
X-Received: by 2002:a17:902:bd87:b0:143:c6e8:4110 with SMTP id q7-20020a170902bd8700b00143c6e84110mr80802481pls.23.1637571107342;
        Mon, 22 Nov 2021 00:51:47 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id f8sm8445582pfv.135.2021.11.22.00.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 00:51:47 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 5/6] dt-bindings: interconnect: Add Qualcomm QCM2290 NoC support
Date:   Mon, 22 Nov 2021 16:51:22 +0800
Message-Id: <20211122085123.21049-6-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122085123.21049-1-shawn.guo@linaro.org>
References: <20211122085123.21049-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bindings for Qualcomm QCM2290 Network-On-Chip interconnect devices.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/interconnect/qcom,qcm2290.yaml   | 116 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,qcm2290.h   |  94 ++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
new file mode 100644
index 000000000000..fb5e62196d9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,qcm2290.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCM2290 Network-On-Chip interconnect
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+
+description: |
+  The Qualcomm QCM2290 interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+properties:
+  reg:
+    maxItems: 1
+
+  compatible:
+    enum:
+      - qcom,qcm2290-bimc
+      - qcom,qcm2290-cnoc
+      - qcom,qcm2290-snoc
+      - qcom,qcm2290-qup-virt
+      - qcom,qcm2290-mmrt-virt
+      - qcom,qcm2290-mmnrt-virt
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
+  - '#interconnect-cells'
+  - clock-names
+  - clocks
+
+additionalProperties: true
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcm2290-bimc
+              - qcom,qcm2290-cnoc
+              - qcom,qcm2290-snoc
+    then:
+      required:
+        - reg
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+
+    snoc: interconnect@1880000 {
+        compatible = "qcom,qcm2290-snoc";
+        reg = <0x01880000 0x60200>;
+        #interconnect-cells = <1>;
+        clock-names = "bus", "bus_a";
+        clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+                 <&rpmcc RPM_SMD_SNOC_A_CLK>;
+
+        qup_virt: interconnect-qup {
+            compatible = "qcom,qcm2290-qup-virt";
+            #interconnect-cells = <1>;
+            clock-names = "bus", "bus_a";
+            clocks = <&rpmcc RPM_SMD_QUP_CLK>,
+                     <&rpmcc RPM_SMD_QUP_A_CLK>;
+        };
+
+        mmnrt_virt: interconnect-mmnrt {
+            compatible = "qcom,qcm2290-mmnrt-virt";
+            #interconnect-cells = <1>;
+            clock-names = "bus", "bus_a";
+            clocks = <&rpmcc RPM_SMD_MMNRT_CLK>,
+                     <&rpmcc RPM_SMD_MMNRT_A_CLK>;
+        };
+
+        mmrt_virt: interconnect-mmrt {
+            compatible = "qcom,qcm2290-mmrt-virt";
+            #interconnect-cells = <1>;
+            clock-names = "bus", "bus_a";
+            clocks = <&rpmcc RPM_SMD_MMRT_CLK>,
+                     <&rpmcc RPM_SMD_MMRT_A_CLK>;
+        };
+    };
+
+    cnoc: interconnect@1900000 {
+        compatible = "qcom,qcm2290-cnoc";
+        reg = <0x01900000 0x8200>;
+        #interconnect-cells = <1>;
+        clock-names = "bus", "bus_a";
+        clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
+                 <&rpmcc RPM_SMD_CNOC_A_CLK>;
+    };
+
+    bimc: interconnect@4480000 {
+        compatible = "qcom,qcm2290-bimc";
+        reg = <0x04480000 0x80000>;
+        #interconnect-cells = <1>;
+        clock-names = "bus", "bus_a";
+        clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+                 <&rpmcc RPM_SMD_BIMC_A_CLK>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,qcm2290.h b/include/dt-bindings/interconnect/qcom,qcm2290.h
new file mode 100644
index 000000000000..6cbbb7fe0bd3
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,qcm2290.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* QCM2290 interconnect IDs */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_QCM2290_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_QCM2290_H
+
+/* BIMC */
+#define MASTER_APPSS_PROC		0
+#define MASTER_SNOC_BIMC_RT		1
+#define MASTER_SNOC_BIMC_NRT		2
+#define MASTER_SNOC_BIMC		3
+#define MASTER_TCU_0			4
+#define MASTER_GFX3D			5
+#define SLAVE_EBI1			6
+#define SLAVE_BIMC_SNOC			7
+
+/* CNOC */
+#define MASTER_SNOC_CNOC		0
+#define MASTER_QDSS_DAP			1
+#define SLAVE_BIMC_CFG			2
+#define SLAVE_CAMERA_NRT_THROTTLE_CFG	3
+#define SLAVE_CAMERA_RT_THROTTLE_CFG	4
+#define SLAVE_CAMERA_CFG		5
+#define SLAVE_CLK_CTL			6
+#define SLAVE_CRYPTO_0_CFG		7
+#define SLAVE_DISPLAY_CFG		8
+#define SLAVE_DISPLAY_THROTTLE_CFG	9
+#define SLAVE_GPU_CFG			10
+#define SLAVE_HWKM			11
+#define SLAVE_IMEM_CFG			12
+#define SLAVE_IPA_CFG			13
+#define SLAVE_LPASS			14
+#define SLAVE_MESSAGE_RAM		15
+#define SLAVE_PDM			16
+#define SLAVE_PIMEM_CFG			17
+#define SLAVE_PKA_WRAPPER		18
+#define SLAVE_PMIC_ARB			19
+#define SLAVE_PRNG			20
+#define SLAVE_QDSS_CFG			21
+#define SLAVE_QM_CFG			22
+#define SLAVE_QM_MPU_CFG		23
+#define SLAVE_QPIC			24
+#define SLAVE_QUP_0			25
+#define SLAVE_SDCC_1			26
+#define SLAVE_SDCC_2			27
+#define SLAVE_SNOC_CFG			28
+#define SLAVE_TCSR			29
+#define SLAVE_USB3			30
+#define SLAVE_VENUS_CFG			31
+#define SLAVE_VENUS_THROTTLE_CFG	32
+#define SLAVE_VSENSE_CTRL_CFG		33
+#define SLAVE_SERVICE_CNOC		34
+
+/* SNOC */
+#define MASTER_CRYPTO_CORE0		0
+#define MASTER_SNOC_CFG			1
+#define MASTER_TIC			2
+#define MASTER_ANOC_SNOC		3
+#define MASTER_BIMC_SNOC		4
+#define MASTER_PIMEM			5
+#define MASTER_QDSS_BAM			6
+#define MASTER_QUP_0			7
+#define MASTER_IPA			8
+#define MASTER_QDSS_ETR			9
+#define MASTER_SDCC_1			10
+#define MASTER_SDCC_2			11
+#define MASTER_QPIC			12
+#define MASTER_USB3_0			13
+#define SLAVE_APPSS			14
+#define SLAVE_SNOC_CNOC			15
+#define SLAVE_IMEM			16
+#define SLAVE_PIMEM			17
+#define SLAVE_SNOC_BIMC			18
+#define SLAVE_SERVICE_SNOC		19
+#define SLAVE_QDSS_STM			20
+#define SLAVE_TCU			21
+#define SLAVE_ANOC_SNOC			22
+
+/* QUP Virtual */
+#define MASTER_QUP_CORE_0		0
+#define SLAVE_QUP_CORE_0		1
+
+/* MMNRT Virtual */
+#define MASTER_CAMNOC_SF		0
+#define MASTER_VIDEO_P0			1
+#define MASTER_VIDEO_PROC		2
+#define SLAVE_SNOC_BIMC_NRT		3
+
+/* MMRT Virtual */
+#define MASTER_CAMNOC_HF		0
+#define MASTER_MDP0			1
+#define SLAVE_SNOC_BIMC_RT		2
+
+#endif
-- 
2.17.1

