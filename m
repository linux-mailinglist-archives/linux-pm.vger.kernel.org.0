Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE204362DA
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 15:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhJUN1h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 09:27:37 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:52334 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhJUN1e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 09:27:34 -0400
Date:   Thu, 21 Oct 2021 13:24:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634822700;
        bh=CppEtBEHAFqduV85SPEgNJTJ+noPoh4RCxCUrTuIjWU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=p1D7cL8k/7Z5SC4t+hAN1D6z4vLkYsS5t7LOOvTKp4VBUTljdZ5ntIPFTOrOwWgb+
         fL7p8s0DyA9bGAj2USmctFsFeE9kGvbvLPfHcB+1/hJOCJqLEjyluit92rZ4dLL+dc
         LO1rS7QGgyN0pJfIEHq0aFMVic0YDeQQA760JtUU=
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v5 3/5] dt-bindings: interconnect: Add Qualcomm MSM8996 DT bindings
Message-ID: <20211021132329.234942-4-y.oudjana@protonmail.com>
In-Reply-To: <20211021132329.234942-1-y.oudjana@protonmail.com>
References: <20211021132329.234942-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bindings for interconnects on Qualcomm MSM8996.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Changes since v4:
 - Rebase on Dmitry's icc-rpm patches.
 - Add support for Aggregate 0 NoC (a0noc).
Changes since v2:
 - Dual-license qcom,msm8996.h and move it to the dt bindings patch

 .../bindings/interconnect/qcom,rpm.yaml       |  42 +++++
 .../dt-bindings/interconnect/qcom,msm8996.h   | 163 ++++++++++++++++++
 2 files changed, 205 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8996.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b=
/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 6c39c0529e36..e4c3c2818119 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -27,6 +27,14 @@ properties:
       - qcom,msm8939-pcnoc
       - qcom,msm8939-snoc
       - qcom,msm8939-snoc-mm
+      - qcom,msm8996-a0noc
+      - qcom,msm8996-a1noc
+      - qcom,msm8996-a2noc
+      - qcom,msm8996-bimc
+      - qcom,msm8996-cnoc
+      - qcom,msm8996-mnoc
+      - qcom,msm8996-pnoc
+      - qcom,msm8996-snoc
       - qcom,qcs404-bimc
       - qcom,qcs404-pcnoc
       - qcom,qcs404-snoc
@@ -48,6 +56,9 @@ properties:
     minItems: 2
     maxItems: 7
=20
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -70,6 +81,12 @@ allOf:
               - qcom,msm8939-pcnoc
               - qcom,msm8939-snoc
               - qcom,msm8939-snoc-mm
+              - qcom,msm8996-a1noc
+              - qcom,msm8996-a2noc
+              - qcom,msm8996-bimc
+              - qcom,msm8996-cnoc
+              - qcom,msm8996-pnoc
+              - qcom,msm8996-snoc
               - qcom,qcs404-bimc
               - qcom,qcs404-pcnoc
               - qcom,qcs404-snoc
@@ -95,6 +112,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,msm8996-mnoc
               - qcom,sdm660-mnoc
=20
     then:
@@ -111,6 +129,30 @@ allOf:
             - description: Bus A Clock.
             - description: CPU-NoC High-performance Bus Clock.
=20
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8996-a0noc
+
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: aggre0_snoc_axi
+            - const: aggre0_cnoc_ahb
+            - const: aggre0_noc_mpu_cfg
+
+        clocks:
+          items:
+            - description: Aggregate0 System NoC AXI Clock.
+            - description: Aggregate0 Config NoC AHB Clock.
+            - description: Aggregate0 NoC MPU Clock.
+
+      required:
+        - power-domains
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/interconnect/qcom,msm8996.h b/include/dt-b=
indings/interconnect/qcom,msm8996.h
new file mode 100644
index 000000000000..a0b7c0ec7bed
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,msm8996.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * Qualcomm MSM8996 interconnect IDs
+ *
+ * Copyright (c) 2021 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8996_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8996_H
+
+/* A0NOC */
+#define MASTER_PCIE_0=09=09=090
+#define MASTER_PCIE_1=09=09=091
+#define MASTER_PCIE_2=09=09=092
+
+/* A1NOC */
+#define MASTER_CNOC_A1NOC=09=090
+#define MASTER_CRYPTO_CORE0=09=091
+#define MASTER_PNOC_A1NOC=09=092
+
+/* A2NOC */
+#define MASTER_USB3=09=09=090
+#define MASTER_IPA=09=09=091
+#define MASTER_UFS=09=09=092
+
+/* BIMC */
+#define MASTER_AMPSS_M0=09=09=090
+#define MASTER_GRAPHICS_3D=09=091
+#define MASTER_MNOC_BIMC=09=092
+#define MASTER_SNOC_BIMC=09=093
+#define SLAVE_EBI_CH0=09=09=094
+#define SLAVE_HMSS_L3=09=09=095
+#define SLAVE_BIMC_SNOC_0=09=096
+#define SLAVE_BIMC_SNOC_1=09=097
+
+/* CNOC */
+#define MASTER_SNOC_CNOC=09=090
+#define MASTER_QDSS_DAP=09=09=091
+#define SLAVE_CNOC_A1NOC=09=092
+#define SLAVE_CLK_CTL=09=09=093
+#define SLAVE_TCSR=09=09=094
+#define SLAVE_TLMM=09=09=095
+#define SLAVE_CRYPTO_0_CFG=09=096
+#define SLAVE_MPM=09=09=097
+#define SLAVE_PIMEM_CFG=09=09=098
+#define SLAVE_IMEM_CFG=09=09=099
+#define SLAVE_MESSAGE_RAM=09=0910
+#define SLAVE_BIMC_CFG=09=09=0911
+#define SLAVE_PMIC_ARB=09=09=0912
+#define SLAVE_PRNG=09=09=0913
+#define SLAVE_DCC_CFG=09=09=0914
+#define SLAVE_RBCPR_MX=09=09=0915
+#define SLAVE_QDSS_CFG=09=09=0916
+#define SLAVE_RBCPR_CX=09=09=0917
+#define SLAVE_QDSS_RBCPR_APU=09=0918
+#define SLAVE_CNOC_MNOC_CFG=09=0919
+#define SLAVE_SNOC_CFG=09=09=0920
+#define SLAVE_SNOC_MPU_CFG=09=0921
+#define SLAVE_EBI1_PHY_CFG=09=0922
+#define SLAVE_A0NOC_CFG=09=09=0923
+#define SLAVE_PCIE_1_CFG=09=0924
+#define SLAVE_PCIE_2_CFG=09=0925
+#define SLAVE_PCIE_0_CFG=09=0926
+#define SLAVE_PCIE20_AHB2PHY=09=0927
+#define SLAVE_A0NOC_MPU_CFG=09=0928
+#define SLAVE_UFS_CFG=09=09=0929
+#define SLAVE_A1NOC_CFG=09=09=0930
+#define SLAVE_A1NOC_MPU_CFG=09=0931
+#define SLAVE_A2NOC_CFG=09=09=0932
+#define SLAVE_A2NOC_MPU_CFG=09=0933
+#define SLAVE_SSC_CFG=09=09=0934
+#define SLAVE_A0NOC_SMMU_CFG=09=0935
+#define SLAVE_A1NOC_SMMU_CFG=09=0936
+#define SLAVE_A2NOC_SMMU_CFG=09=0937
+#define SLAVE_LPASS_SMMU_CFG=09=0938
+#define SLAVE_CNOC_MNOC_MMSS_CFG=0939
+
+/* MNOC */
+#define MASTER_CNOC_MNOC_CFG=09=090
+#define MASTER_CPP=09=09=091
+#define MASTER_JPEG=09=09=092
+#define MASTER_MDP_PORT0=09=093
+#define MASTER_MDP_PORT1=09=094
+#define MASTER_ROTATOR=09=09=095
+#define MASTER_VIDEO_P0=09=09=096
+#define MASTER_VFE=09=09=097
+#define MASTER_SNOC_VMEM=09=098
+#define MASTER_VIDEO_P0_OCMEM=09=099
+#define MASTER_CNOC_MNOC_MMSS_CFG=0910
+#define SLAVE_MNOC_BIMC=09=09=0911
+#define SLAVE_VMEM=09=09=0912
+#define SLAVE_SERVICE_MNOC=09=0913
+#define SLAVE_MMAGIC_CFG=09=0914
+#define SLAVE_CPR_CFG=09=09=0915
+#define SLAVE_MISC_CFG=09=09=0916
+#define SLAVE_VENUS_THROTTLE_CFG=0917
+#define SLAVE_VENUS_CFG=09=09=0918
+#define SLAVE_VMEM_CFG=09=09=0919
+#define SLAVE_DSA_CFG=09=09=0920
+#define SLAVE_MMSS_CLK_CFG=09=0921
+#define SLAVE_DSA_MPU_CFG=09=0922
+#define SLAVE_MNOC_MPU_CFG=09=0923
+#define SLAVE_DISPLAY_CFG=09=0924
+#define SLAVE_DISPLAY_THROTTLE_CFG=0925
+#define SLAVE_CAMERA_CFG=09=0926
+#define SLAVE_CAMERA_THROTTLE_CFG=0927
+#define SLAVE_GRAPHICS_3D_CFG=09=0928
+#define SLAVE_SMMU_MDP_CFG=09=0929
+#define SLAVE_SMMU_ROT_CFG=09=0930
+#define SLAVE_SMMU_VENUS_CFG=09=0931
+#define SLAVE_SMMU_CPP_CFG=09=0932
+#define SLAVE_SMMU_JPEG_CFG=09=0933
+#define SLAVE_SMMU_VFE_CFG=09=0934
+
+/* PNOC */
+#define MASTER_SNOC_PNOC=09=090
+#define MASTER_SDCC_1=09=09=091
+#define MASTER_SDCC_2=09=09=092
+#define MASTER_SDCC_4=09=09=093
+#define MASTER_USB_HS=09=09=094
+#define MASTER_BLSP_1=09=09=095
+#define MASTER_BLSP_2=09=09=096
+#define MASTER_TSIF=09=09=097
+#define SLAVE_PNOC_A1NOC=09=098
+#define SLAVE_USB_HS=09=09=099
+#define SLAVE_SDCC_2=09=09=0910
+#define SLAVE_SDCC_4=09=09=0911
+#define SLAVE_TSIF=09=09=0912
+#define SLAVE_BLSP_2=09=09=0913
+#define SLAVE_SDCC_1=09=09=0914
+#define SLAVE_BLSP_1=09=09=0915
+#define SLAVE_PDM=09=09=0916
+#define SLAVE_AHB2PHY=09=09=0917
+
+/* SNOC */
+#define MASTER_HMSS=09=09=090
+#define MASTER_QDSS_BAM=09=09=091
+#define MASTER_SNOC_CFG=09=09=092
+#define MASTER_BIMC_SNOC_0=09=093
+#define MASTER_BIMC_SNOC_1=09=094
+#define MASTER_A0NOC_SNOC=09=095
+#define MASTER_A1NOC_SNOC=09=096
+#define MASTER_A2NOC_SNOC=09=097
+#define MASTER_QDSS_ETR=09=09=098
+#define SLAVE_A0NOC_SNOC=09=099
+#define SLAVE_A1NOC_SNOC=09=0910
+#define SLAVE_A2NOC_SNOC=09=0911
+#define SLAVE_HMSS=09=09=0912
+#define SLAVE_LPASS=09=09=0913
+#define SLAVE_USB3=09=09=0914
+#define SLAVE_SNOC_BIMC=09=09=0915
+#define SLAVE_SNOC_CNOC=09=09=0916
+#define SLAVE_IMEM=09=09=0917
+#define SLAVE_PIMEM=09=09=0918
+#define SLAVE_SNOC_VMEM=09=09=0919
+#define SLAVE_SNOC_PNOC=09=09=0920
+#define SLAVE_QDSS_STM=09=09=0921
+#define SLAVE_PCIE_0=09=09=0922
+#define SLAVE_PCIE_1=09=09=0923
+#define SLAVE_PCIE_2=09=09=0924
+#define SLAVE_SERVICE_SNOC=09=0925
+
+#endif
--=20
2.33.1


