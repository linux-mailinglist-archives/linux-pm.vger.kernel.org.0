Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C8810A0E3
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 16:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfKZPB2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 10:01:28 -0500
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:60212
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbfKZPB2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 10:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574780487;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=APFAqQ5hhFy6nrdgORg6OIjDflWXH5R08ymFxeXhbSA=;
        b=Y6gwfA/R2jet5NtgXnPYy58NryRWzLEZHJBHgLTHamZRY8FsPr6iSHtHhKVCmTN3
        gr0XD7zYsS9SQE/OvT7HVwFOOfuf+90Pwe5A2sT37JfHBB274qm/AaBBb5EFMZyayEo
        bwwgP+LvJJIGzqDCFbAczTZmLANN2M/EfMV0GIwE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574780486;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=APFAqQ5hhFy6nrdgORg6OIjDflWXH5R08ymFxeXhbSA=;
        b=LZaM8+Z6Tmov6iGX9cxxCRDY4hTnbfe9ezHqwgDHj9h0uU4HeOohlSkrLFB3iZps
        8oJ+5PderVJjqjr/me6RRghlU0OgFZkiaLeS+ktPGJ8GWQviKI5Zi+pcwwhWR9g2Tyg
        4oeZ2VLDsTLMpN8iI6tpxcY/hL1jjfqTYF1fAu4g=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95115C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=okukatla@codeaurora.org
From:   Odelu Kukatla <okukatla@codeaurora.org>
To:     georgi.djakov@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com, sboyd@kernel.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Subject: [PATCH V1 1/2] dt-bindings: interconnect: Add Qualcomm SC7180 DT bindings
Date:   Tue, 26 Nov 2019 15:01:26 +0000
Message-ID: <0101016ea83b44e2-546fc9ff-6056-482b-a42d-231b9d908640-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1574780408-21282-1-git-send-email-okukatla@codeaurora.org>
References: <1574780408-21282-1-git-send-email-okukatla@codeaurora.org>
X-SES-Outgoing: 2019.11.26-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SC7180 platform has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand.

Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
---
 .../bindings/interconnect/qcom,bcm-voter.yaml      |   1 +
 .../bindings/interconnect/qcom,sc7180.yaml         | 155 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,sc7180.h     | 149 ++++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,sc7180.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
index 74f0715..55c9f34 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
@@ -19,6 +19,7 @@ description: |
 properties:
   compatible:
     enum:
+      - qcom,sc7180-bcm-voter
       - qcom,sdm845-bcm-voter
 
 required:
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
new file mode 100644
index 0000000..487da5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
@@ -0,0 +1,155 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sc7180.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:  Qualcomm SC7180 Network-On-Chip Interconnect
+
+maintainers:
+  - David Dai <daidavid1@codeaurora.org>
+
+description: |
+   SC7180 interconnect providers support system bandwidth requirements through
+   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+   able to communicate with the BCM through the Resource State Coordinator (RSC)
+   associated with each execution environment. Provider nodes must point to at
+   least one RPMh device child node pertaining to their RSC and each provider
+   can map to multiple RPMh resources.
+
+properties:
+  reg:
+    maxItems: 1
+
+  compatible:
+    enum:
+      - qcom,sc7180-aggre1-noc
+      - qcom,sc7180-aggre2-noc
+      - qcom,sc7180-camnoc-virt
+      - qcom,sc7180-compute-noc
+      - qcom,sc7180-config-noc
+      - qcom,sc7180-dc-noc
+      - qcom,sc7180-gem-noc
+      - qcom,sc7180-ipa-virt
+      - qcom,sc7180-mc-virt
+      - qcom,sc7180-mmss-noc
+      - qcom,sc7180-npu-noc
+      - qcom,sc7180-qup-virt
+      - qcom,sc7180-system-noc
+
+  '#interconnect-cells':
+    const: 1
+
+  qcom,bcm-voters:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      List of phandles to qcom,bcm-voter nodes that are required by
+      this interconnect to send RPMh commands.
+
+  qcom,bcm-voter-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: |
+      Names for each of the qcom,bcm-voters specified.
+
+required:
+  - compatible
+  - reg
+  - '#interconnect-cells'
+  - qcom,bcm-voters
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/interconnect/qcom,sc7180.h>
+
+      config_noc: interconnect@1500000 {
+            compatible = "qcom,sc7180-config-noc";
+            reg = <0 0x01500000 0 0x28000>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      system_noc: interconnect@1620000 {
+            compatible = "qcom,sc7180-system-noc";
+            reg = <0 0x01620000 0 0x17080>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      mc_virt: interconnect@1630000 {
+            compatible = "qcom,sc7180-mc-virt";
+            reg = <0 0x01630000 0 0x4000>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      qup_virt: interconnect@1650000 {
+            compatible = "qcom,sc7180-qup-virt";
+            reg = <0 0x01650000 0 0x4000>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      aggre1_noc: interconnect@16e0000 {
+            compatible = "qcom,sc7180-aggre1-noc";
+            reg = <0 0x016e0000 0 0x15080>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      aggre2_noc: interconnect@1700000 {
+            compatible = "qcom,sc7180-aggre2-noc";
+            reg = <0 0x01700000 0 0x1f880>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      compute_noc: interconnect@170e000 {
+            compatible = "qcom,sc7180-compute-noc";
+            reg = <0 0x0170e000 0 0x11880>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      mmss_noc: interconnect@1740000 {
+            compatible = "qcom,sc7180-mmss-noc";
+            reg = <0 0x01740000 0 0x1c100>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      ipa_virt: interconnect@1e00000 {
+            compatible = "qcom,sc7180-ipa-virt";
+            reg = <0 0x01e00000 0 0x4000>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      dc_noc: interconnect@9160000 {
+            compatible = "qcom,sc7180-dc-noc";
+            reg = <0 0x09160000 0 0x03200>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      gem_noc: interconnect@9680000 {
+            compatible = "qcom,sc7180-gem-noc";
+            reg = <0 0x09680000 0 0x3e200>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      npu_noc: interconnect@9990000 {
+            compatible = "qcom,sc7180-npu-noc";
+            reg = <0 0x09990000 0 0x1600>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      camnoc_virt: interconnect@ac00000 {
+            compatible = "qcom,sc7180-camnoc-virt";
+            reg = <0 0x0ac00000 0 0x4000>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
diff --git a/include/dt-bindings/interconnect/qcom,sc7180.h b/include/dt-bindings/interconnect/qcom,sc7180.h
new file mode 100644
index 0000000..b762bc3
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sc7180.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm SC7180 interconnect IDs
+ *
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SC7180_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SC7180_H
+
+#define MASTER_APPSS_PROC			0
+#define MASTER_SYS_TCU				1
+#define MASTER_NPU_SYS				2
+#define MASTER_IPA_CORE				3
+#define MASTER_LLCC				4
+#define MASTER_A1NOC_CFG			5
+#define MASTER_A2NOC_CFG			6
+#define MASTER_CNOC_DC_NOC			7
+#define MASTER_GEM_NOC_CFG			8
+#define MASTER_CNOC_MNOC_CFG			9
+#define MASTER_NPU_NOC_CFG			10
+#define MASTER_QDSS_BAM				11
+#define MASTER_QSPI				12
+#define MASTER_QUP_0				13
+#define MASTER_QUP_1				14
+#define MASTER_SNOC_CFG				15
+#define MASTER_A1NOC_SNOC			16
+#define MASTER_A2NOC_SNOC			17
+#define MASTER_COMPUTE_NOC			18
+#define MASTER_GEM_NOC_SNOC			19
+#define MASTER_MNOC_HF_MEM_NOC			20
+#define MASTER_MNOC_SF_MEM_NOC			21
+#define MASTER_NPU				22
+#define MASTER_SNOC_CNOC			23
+#define MASTER_SNOC_GC_MEM_NOC			24
+#define MASTER_SNOC_SF_MEM_NOC			25
+#define MASTER_QUP_CORE_0			26
+#define MASTER_QUP_CORE_1			27
+#define MASTER_CAMNOC_HF0			28
+#define MASTER_CAMNOC_HF1			29
+#define MASTER_CAMNOC_HF0_UNCOMP		30
+#define MASTER_CAMNOC_HF1_UNCOMP		31
+#define MASTER_CAMNOC_SF			32
+#define MASTER_CAMNOC_SF_UNCOMP			33
+#define MASTER_CRYPTO				34
+#define MASTER_GFX3D				35
+#define MASTER_IPA				36
+#define MASTER_MDP0				37
+#define MASTER_NPU_PROC				38
+#define MASTER_PIMEM				39
+#define MASTER_ROTATOR				40
+#define MASTER_VIDEO_P0				41
+#define MASTER_VIDEO_PROC			42
+#define MASTER_QDSS_DAP				43
+#define MASTER_QDSS_ETR				44
+#define MASTER_SDCC_2				45
+#define MASTER_UFS_MEM				46
+#define MASTER_USB3				47
+#define MASTER_EMMC				48
+#define SLAVE_EBI1				512
+#define SLAVE_IPA_CORE				513
+#define SLAVE_A1NOC_CFG				514
+#define SLAVE_A2NOC_CFG				515
+#define SLAVE_AHB2PHY_SOUTH			516
+#define SLAVE_AHB2PHY_CENTER			517
+#define SLAVE_AOP				518
+#define SLAVE_AOSS				519
+#define SLAVE_APPSS				520
+#define SLAVE_BOOT_ROM				521
+#define SLAVE_NPU_CAL_DP0			522
+#define SLAVE_CAMERA_CFG			523
+#define SLAVE_CAMERA_NRT_THROTTLE_CFG		524
+#define SLAVE_CAMERA_RT_THROTTLE_CFG		525
+#define SLAVE_CLK_CTL				526
+#define SLAVE_NPU_CP				527
+#define SLAVE_RBCPR_CX_CFG			528
+#define SLAVE_RBCPR_MX_CFG			529
+#define SLAVE_CRYPTO_0_CFG			530
+#define SLAVE_DCC_CFG				531
+#define SLAVE_CNOC_DDRSS			532
+#define SLAVE_DISPLAY_CFG			533
+#define SLAVE_DISPLAY_RT_THROTTLE_CFG		534
+#define SLAVE_DISPLAY_THROTTLE_CFG		535
+#define SLAVE_NPU_INT_DMA_BWMON_CFG		536
+#define SLAVE_NPU_DPM				537
+#define SLAVE_EMMC_CFG				538
+#define SLAVE_GEM_NOC_CFG			539
+#define SLAVE_GLM				540
+#define SLAVE_GFX3D_CFG				541
+#define SLAVE_IMEM_CFG				542
+#define SLAVE_IPA_CFG				543
+#define SLAVE_ISENSE_CFG			544
+#define SLAVE_LLCC_CFG				545
+#define SLAVE_NPU_LLM_CFG			546
+#define SLAVE_MSS_PROC_MS_MPU_CFG		547
+#define SLAVE_CNOC_MNOC_CFG			548
+#define SLAVE_CNOC_MSS				549
+#define SLAVE_NPU_CFG				550
+#define SLAVE_NPU_DMA_BWMON_CFG			551
+#define SLAVE_NPU_PROC_BWMON_CFG		552
+#define SLAVE_PDM				553
+#define SLAVE_PIMEM_CFG				554
+#define SLAVE_PRNG				555
+#define SLAVE_QDSS_CFG				556
+#define SLAVE_QM_CFG				557
+#define SLAVE_QM_MPU_CFG			558
+#define SLAVE_QSPI_0				559
+#define SLAVE_QUP_0				560
+#define SLAVE_QUP_1				561
+#define SLAVE_SDCC_2				562
+#define SLAVE_SECURITY				563
+#define SLAVE_SNOC_CFG				564
+#define SLAVE_NPU_TCM				565
+#define SLAVE_TCSR				566
+#define SLAVE_TLMM_WEST				567
+#define SLAVE_TLMM_NORTH			568
+#define SLAVE_TLMM_SOUTH			569
+#define SLAVE_UFS_MEM_CFG			570
+#define SLAVE_USB3				571
+#define SLAVE_VENUS_CFG				572
+#define SLAVE_VENUS_THROTTLE_CFG		573
+#define SLAVE_VSENSE_CTRL_CFG			574
+#define SLAVE_A1NOC_SNOC			575
+#define SLAVE_A2NOC_SNOC			576
+#define SLAVE_CAMNOC_UNCOMP			577
+#define SLAVE_CDSP_GEM_NOC			578
+#define SLAVE_SNOC_CNOC				579
+#define SLAVE_GEM_NOC_SNOC			580
+#define SLAVE_SNOC_GEM_NOC_GC			581
+#define SLAVE_SNOC_GEM_NOC_SF			582
+#define SLAVE_LLCC				583
+#define SLAVE_MNOC_HF_MEM_NOC			584
+#define SLAVE_MNOC_SF_MEM_NOC			585
+#define SLAVE_NPU_COMPUTE_NOC			586
+#define SLAVE_QUP_CORE_0			587
+#define SLAVE_QUP_CORE_1			588
+#define SLAVE_IMEM				589
+#define SLAVE_PIMEM				590
+#define SLAVE_SERVICE_A1NOC			591
+#define SLAVE_SERVICE_A2NOC			592
+#define SLAVE_SERVICE_CNOC			593
+#define SLAVE_SERVICE_GEM_NOC			594
+#define SLAVE_SERVICE_MNOC			595
+#define SLAVE_SERVICE_NPU_NOC			596
+#define SLAVE_SERVICE_SNOC			597
+#define SLAVE_QDSS_STM				598
+#define SLAVE_TCU				599
+
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

