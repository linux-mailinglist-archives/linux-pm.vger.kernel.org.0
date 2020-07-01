Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE271210C95
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 15:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbgGANpf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 09:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731153AbgGANpH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 09:45:07 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC31C08C5C1
        for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2020 06:45:07 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c30so18307980qka.10
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2020 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OPvy4kkttICljs5o0Hp44TfDAGbA0ECK1QuThDVHWU4=;
        b=SJvJ3v6BsAUd49TEjAquGxwzpcw5vtR9c7z/FOqWRrFI09A5lIFMbbn7Uq0hJ9Gt/v
         Ye3QeyRZLhoW9I0NTIQD06+ldxnRNXb3mKd5V+kMPJfvOEFFsd33pRv/w+ZuEVsyawO2
         IPYcGOeZ4KmGTGJ7epHiE4Wla9ToZnRX4z9luJqV/khrakxl7K6p23x/FGOC1629f0v9
         2euM+cBrmRwlHVfo27QBXPk/IxRPMXHJg84evh+3QwsOT9G5w5hV2RfyndkQaVarY6ka
         hLrYzKXwe8DmBUtxiOb++SqSuYotSUK9gUZkNFOi/eHiaMXsSdG30j9naS8Yq2Ky86vV
         PRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OPvy4kkttICljs5o0Hp44TfDAGbA0ECK1QuThDVHWU4=;
        b=GL+nL1msQaU4cx4+I+eSt2yPp8mp7mbbo4rYsoDyAndFQeX+WV31fbMjo8myhOPEG4
         i6twcIQF6WWHR0FYVolPKR9jmLhj/qiun7UQZoqYRanafmwnvHAxRkEHY05w0r8ArlLm
         oZ79GpBiV1z7Ub/1/fwMQgQj+8L3ZGj2clNznAvDm2YHF7zy2Tx3Hgg0c4M3FvY+GeDV
         i8afXXSLajuRmGxdjBK0IymMzNKSU+26WZ6Tio1CHfTnoRKcX1dlK0ZLapXv/5ZVT4ka
         9a6ZYQ0bfSzpEHeq7SoaQum31kEvR8Q1Vq9gvDVxhyqbSKfLaQVGSKSEzVtzAxle9x+A
         0OTA==
X-Gm-Message-State: AOAM533BPzeuAaOclV9VEnfhzqcpVJTlHu+mNfz35DL0/KgpVZuQIfgt
        v17U1AUlf6tYMjraztiqi4aCBg==
X-Google-Smtp-Source: ABdhPJwhUqVM3NmKifFLoTu2Aj/IZk38fc1pOVWd1WQRylFh61TpO+fd3SUd1ijb9KUyf6W5HrKpSg==
X-Received: by 2002:a37:a20d:: with SMTP id l13mr26254365qke.296.1593611106102;
        Wed, 01 Jul 2020 06:45:06 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id d136sm1444345qke.47.2020.07.01.06.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:45:05 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org (open list:INTERCONNECT API),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/6] dt-bindings: interconnect: Add Qualcomm SM8250 DT bindings
Date:   Wed,  1 Jul 2020 09:42:51 -0400
Message-Id: <20200701134259.8055-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200701134259.8055-1-jonathan@marek.ca>
References: <20200701134259.8055-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SM8250 platform has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../bindings/interconnect/qcom,sm8250.yaml    |  86 ++++++++
 .../dt-bindings/interconnect/qcom,sm8250.h    | 186 ++++++++++++++++++
 2 files changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8250.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8250.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm8250.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm8250.yaml
new file mode 100644
index 000000000000..bc4e2358ad78
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm8250.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sm8250.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:  Qualcomm SM8250 Network-On-Chip Interconnect
+
+maintainers:
+  -
+
+description: |
+   SM8250 interconnect providers support system bandwidth requirements through
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
+      - qcom,sm8250-aggre1-noc
+      - qcom,sm8250-aggre2-noc
+      - qcom,sm8250-compute-noc
+      - qcom,sm8250-config-noc
+      - qcom,sm8250-dc-noc
+      - qcom,sm8250-gem-noc
+      - qcom,sm8250-ipa-virt
+      - qcom,sm8250-mc-virt
+      - qcom,sm8250-mmss-noc
+      - qcom,sm8250-npu-noc
+      - qcom,sm8250-system-noc
+      - qcom,sm8250-gem-noc-display
+      - qcom,sm8250-mc-virt-display
+      - qcom,sm8250-mmss-noc-display
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
+      #include <dt-bindings/interconnect/qcom,sm8250.h>
+
+      config_noc: interconnect@1500000 {
+            compatible = "qcom,sm8250-config-noc";
+            reg = <0x01500000 0x1000>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      system_noc: interconnect@1632000 {
+            compatible = "qcom,sm8250-system-noc";
+            reg = <0x01632000 0x1000>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      mmss_noc: interconnect@174a000 {
+            compatible = "qcom,sm8250-mmss-noc";
+            reg = <0x0174a000 0x1000>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
diff --git a/include/dt-bindings/interconnect/qcom,sm8250.h b/include/dt-bindings/interconnect/qcom,sm8250.h
new file mode 100644
index 000000000000..265571ff957a
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm8250.h
@@ -0,0 +1,186 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm SM8250 interconnect IDs
+ *
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8250_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8250_H
+
+#define MASTER_A1NOC_CFG		0
+#define MASTER_QSPI_0			1
+#define MASTER_QUP_1			2
+#define MASTER_QUP_2			3
+#define MASTER_TSIF			4
+#define MASTER_PCIE_2			5
+#define MASTER_SDCC_4			6
+#define MASTER_UFS_MEM			7
+#define MASTER_USB3			8
+#define MASTER_USB3_1			9
+#define A1NOC_SNOC_SLV			10
+#define SLAVE_ANOC_PCIE_GEM_NOC_1	11
+#define SLAVE_SERVICE_A1NOC		12
+
+#define MASTER_A2NOC_CFG		0
+#define MASTER_QDSS_BAM			1
+#define MASTER_QUP_0			2
+#define MASTER_CNOC_A2NOC		3
+#define MASTER_CRYPTO_CORE_0		4
+#define MASTER_IPA			5
+#define MASTER_PCIE			6
+#define MASTER_PCIE_1			7
+#define MASTER_QDSS_ETR			8
+#define MASTER_SDCC_2			9
+#define MASTER_UFS_CARD			10
+#define A2NOC_SNOC_SLV			11
+#define SLAVE_ANOC_PCIE_GEM_NOC		12
+#define SLAVE_SERVICE_A2NOC		13
+
+#define MASTER_NPU			0
+#define SLAVE_CDSP_MEM_NOC		1
+
+#define SNOC_CNOC_MAS			0
+#define MASTER_QDSS_DAP			1
+#define SLAVE_A1NOC_CFG			2
+#define SLAVE_A2NOC_CFG			3
+#define SLAVE_AHB2PHY_SOUTH		4
+#define SLAVE_AHB2PHY_NORTH		5
+#define SLAVE_AOSS			6
+#define SLAVE_CAMERA_CFG		7
+#define SLAVE_CLK_CTL			8
+#define SLAVE_CDSP_CFG			9
+#define SLAVE_RBCPR_CX_CFG		10
+#define SLAVE_RBCPR_MMCX_CFG		11
+#define SLAVE_RBCPR_MX_CFG		12
+#define SLAVE_CRYPTO_0_CFG		13
+#define SLAVE_CX_RDPM			14
+#define SLAVE_DCC_CFG			15
+#define SLAVE_CNOC_DDRSS		16
+#define SLAVE_DISPLAY_CFG		17
+#define SLAVE_GRAPHICS_3D_CFG		18
+#define SLAVE_IMEM_CFG			19
+#define SLAVE_IPA_CFG			20
+#define SLAVE_IPC_ROUTER_CFG		21
+#define SLAVE_LPASS			22
+#define SLAVE_CNOC_MNOC_CFG		23
+#define SLAVE_NPU_CFG			24
+#define SLAVE_PCIE_0_CFG		25
+#define SLAVE_PCIE_1_CFG		26
+#define SLAVE_PCIE_2_CFG		27
+#define SLAVE_PDM			28
+#define SLAVE_PIMEM_CFG			29
+#define SLAVE_PRNG			30
+#define SLAVE_QDSS_CFG			31
+#define SLAVE_QSPI_0			32
+#define SLAVE_QUP_0			33
+#define SLAVE_QUP_1			34
+#define SLAVE_QUP_2			35
+#define SLAVE_SDCC_2			36
+#define SLAVE_SDCC_4			37
+#define SLAVE_SNOC_CFG			38
+#define SLAVE_TCSR			39
+#define SLAVE_TLMM_NORTH		40
+#define SLAVE_TLMM_SOUTH		41
+#define SLAVE_TLMM_WEST			42
+#define SLAVE_TSIF			43
+#define SLAVE_UFS_CARD_CFG		44
+#define SLAVE_UFS_MEM_CFG		45
+#define SLAVE_USB3			46
+#define SLAVE_USB3_1			47
+#define SLAVE_VENUS_CFG			48
+#define SLAVE_VSENSE_CTRL_CFG		49
+#define SLAVE_CNOC_A2NOC		50
+#define SLAVE_SERVICE_CNOC		51
+
+#define MASTER_CNOC_DC_NOC		0
+#define SLAVE_LLCC_CFG			1
+#define SLAVE_GEM_NOC_CFG		2
+
+#define MASTER_GPU_TCU			0
+#define MASTER_SYS_TCU			1
+#define MASTER_AMPSS_M0			2
+#define MASTER_GEM_NOC_CFG		3
+#define MASTER_COMPUTE_NOC		4
+#define MASTER_GRAPHICS_3D		5
+#define MASTER_MNOC_HF_MEM_NOC		6
+#define MASTER_MNOC_SF_MEM_NOC		7
+#define MASTER_ANOC_PCIE_GEM_NOC	8
+#define MASTER_SNOC_GC_MEM_NOC		9
+#define MASTER_SNOC_SF_MEM_NOC		10
+#define SLAVE_GEM_NOC_SNOC		11
+#define SLAVE_LLCC			12
+#define SLAVE_MEM_NOC_PCIE_SNOC		13
+#define SLAVE_SERVICE_GEM_NOC_1		14
+#define SLAVE_SERVICE_GEM_NOC_2		15
+#define SLAVE_SERVICE_GEM_NOC		16
+
+#define MASTER_IPA_CORE			0
+#define SLAVE_IPA_CORE			1
+
+#define MASTER_LLCC			0
+#define MASTER_ALC			1
+#define SLAVE_EBI_CH0			2
+
+#define MASTER_CNOC_MNOC_CFG		0
+#define MASTER_CAMNOC_HF		1
+#define MASTER_CAMNOC_ICP		2
+#define MASTER_CAMNOC_SF		3
+#define MASTER_VIDEO_P0			4
+#define MASTER_VIDEO_P1			5
+#define MASTER_VIDEO_PROC		6
+#define MASTER_MDP_PORT0		7
+#define MASTER_MDP_PORT1		8
+#define MASTER_ROTATOR			9
+#define SLAVE_MNOC_HF_MEM_NOC		10
+#define SLAVE_MNOC_SF_MEM_NOC		11
+#define SLAVE_SERVICE_MNOC		12
+
+#define MASTER_NPU_SYS			0
+#define MASTER_NPU_CDP			1
+#define MASTER_NPU_NOC_CFG		2
+#define SLAVE_NPU_CAL_DP0		3
+#define SLAVE_NPU_CAL_DP1		4
+#define SLAVE_NPU_CP			5
+#define SLAVE_NPU_INT_DMA_BWMON_CFG	6
+#define SLAVE_NPU_DPM			7
+#define SLAVE_ISENSE_CFG		8
+#define SLAVE_NPU_LLM_CFG		9
+#define SLAVE_NPU_TCM			10
+#define SLAVE_NPU_COMPUTE_NOC		11
+#define SLAVE_SERVICE_NPU_NOC		12
+
+#define MASTER_SNOC_CFG			0
+#define A1NOC_SNOC_MAS			1
+#define A2NOC_SNOC_MAS			2
+#define MASTER_GEM_NOC_SNOC		3
+#define MASTER_GEM_NOC_PCIE_SNOC	4
+#define MASTER_PIMEM			5
+#define MASTER_GIC			6
+#define SLAVE_APPSS			7
+#define SNOC_CNOC_SLV			8
+#define SLAVE_SNOC_GEM_NOC_GC		9
+#define SLAVE_SNOC_GEM_NOC_SF		10
+#define SLAVE_OCIMEM			11
+#define SLAVE_PIMEM			12
+#define SLAVE_SERVICE_SNOC		13
+#define SLAVE_PCIE_0			14
+#define SLAVE_PCIE_1			15
+#define SLAVE_PCIE_2			16
+#define SLAVE_QDSS_STM			17
+#define SLAVE_TCU			18
+
+#define MASTER_MNOC_HF_MEM_NOC_DISPLAY	0
+#define MASTER_MNOC_SF_MEM_NOC_DISPLAY	1
+#define SLAVE_LLCC_DISPLAY		2
+
+#define MASTER_LLCC_DISPLAY		0
+#define SLAVE_EBI_CH0_DISPLAY		1
+
+#define MASTER_MDP_PORT0_DISPLAY	0
+#define MASTER_MDP_PORT1_DISPLAY	1
+#define MASTER_ROTATOR_DISPLAY		2
+#define SLAVE_MNOC_HF_MEM_NOC_DISPLAY	3
+#define SLAVE_MNOC_SF_MEM_NOC_DISPLAY	4
+
+#endif
-- 
2.26.1

