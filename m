Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EAC44C0E4
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 13:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhKJMKs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 07:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhKJMKn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 07:10:43 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3D7C061220
        for <linux-pm@vger.kernel.org>; Wed, 10 Nov 2021 04:07:54 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so1499910pjb.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Nov 2021 04:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=55laEhBQkI9KuTAQC/MzElYLJNqSJbWhADil2TXql4o=;
        b=DHmO8BvP0RueTIjp6GFi2jq4FBTN9Ea81x6HIVm9kNkqQ5RbhZk0dxD/nHu8bjo6cZ
         KS82roZulhJDJqscFDH411mKgO1B9ThC8iVovsLVpZNFUr7a+mwlsegTZHvSHMdnm4Px
         Bb1i9deCzqImX5Wv+jjaZiZJ9iLTcivGh7WXS9ILlBpI4YUpvoI8/4i2Qm/nSAln//EL
         DCV4sDIl/shRDAXQlLmhI/bxr631UoCSF7770PjSypAnqLZfGIzz7XariC1Hx+hNifng
         cgZ8SYvOal2bHgB2vQRG22Q8IfKMBEs/xFyEPBDkVlIz1yLSJw+burC1lLSNGotHEsi4
         bWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=55laEhBQkI9KuTAQC/MzElYLJNqSJbWhADil2TXql4o=;
        b=aEpmB5EE7uBm3fzphpFg9lqbxTgHGMSMYUL1pgTaGYryJ1ZSKAsHQWd5hpzGdHggTf
         fSCz/2Eu4Jckz5DpnEf7DIDukGarAv3VTuQPQjxhEyScD8GryzGK8meNsHlV9lnFWz1H
         WMBdNZRXHB3fBUiRdKAFZDaV3FTdYH/GjqBu/TPN5MuWji1OwLjf/OuhsfEJbIdihzzN
         kuGO5TRU3eRftItYasyawFI3cKCCocdrFXKjCsRmJuD7IKS160C++JyMLtIJVdmK5HsQ
         E3Y+S2ZON+yYVspwOeR1C48Dmm8ZgZ3AgMMJe3QT4IeLpy99DqfLXSIppLhfxenoDQVW
         AkXQ==
X-Gm-Message-State: AOAM5303QXriNzzcZvUoW1fwRpH1nRuAgIJKKCX0cJTPoairkgz5di3x
        MpinKqgnINJwZFDah26DYdT1Rg==
X-Google-Smtp-Source: ABdhPJx5wMcDk76AuiCC8tq4o4SzIRbcVniRDIcmylnbjpgGpwFY5IoTdZakmyxoooNiYruQswrjRg==
X-Received: by 2002:a17:90b:314d:: with SMTP id ip13mr16516285pjb.228.1636546074032;
        Wed, 10 Nov 2021 04:07:54 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id g9sm8377914pfc.182.2021.11.10.04.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 04:07:53 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 5/6] dt-bindings: interconnect: Add Qualcomm QCM2290 NoC support
Date:   Wed, 10 Nov 2021 20:07:15 +0800
Message-Id: <20211110120716.6401-6-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110120716.6401-1-shawn.guo@linaro.org>
References: <20211110120716.6401-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bindings for Qualcomm QCM2290 Network-On-Chip interconnect devices.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/interconnect/qcom,qcm2290.yaml   | 117 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,qcm2290.h   |  94 ++++++++++++++
 2 files changed, 211 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
new file mode 100644
index 000000000000..13aef13bfcef
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
@@ -0,0 +1,117 @@
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
+    #include <dt-bindings/clock/qcom,gcc-qcm2290.h>
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

