Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422F6210C82
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 15:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgGANpI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 09:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731034AbgGANpF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 09:45:05 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F521C08C5DC
        for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2020 06:45:05 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v19so18376033qtq.10
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2020 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YfOjKER5oMeevtyRUZwe3pNG9ZI07+gjbZp59KKuY2U=;
        b=OBhzkJtbWpa+UZXIpLHFsaDeuNIVYk84EtsdkCL03Y9PddKwyzqCDxUicU2clXxRpa
         l+bA5kl6aVU3kux4ptgHZv79AKWC00DeN+nhf0xM9LQMENzK7ypUZC77cfpS2P4pn+ow
         0KjuCzZiFt3d+F4r3npqsdH9fcOSAyAZNJusyHxlD53R5nmwKC0yVaDd72BcYyFtP1HY
         pupLp54VbmQ8xcRtczN6CYQ7QdflNUEz/KQyH60Je4q3hd8XYbP0iDcT/gTaFaEEEoZH
         Wu02JB5IDuNCWyX18MJEoDgL+qffX92MJ8KngbAT0ld5IDVnYr2u8r2j22PNJkq9l+d8
         2kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfOjKER5oMeevtyRUZwe3pNG9ZI07+gjbZp59KKuY2U=;
        b=AFTeTuxjegHIvAuGR+5lZBRiFT1bWuGgejziQ6kQTpBGXksk7GaIVXDPKUKnc+Imh3
         GJiE+dwNsiwfJsJoCWK+1zC0QGEfhe4YCA/Pz6VE+36fpmv+qdFd04QoN+tqDyfbMkyS
         c/bmqJrc+SYD+OdWMRl9P9lrXTg8x+lgpTlMWy+qePYABqt5jhl84YeugMgpEGXkQs5s
         WUJoHSUcq9KTKsb+elKwshhX0kZ6+s5ea9t+jPSLp0jIKULoZ9znlFhaUdz/xPQOI7Ue
         E1JMlzUhbtplC/j7w5b0sIpvNcklGUaefFbVl7n47FE3SvrJZ0HweAZXUsFNwSKEI3yf
         Jckg==
X-Gm-Message-State: AOAM530Bkk9eF19D+8LLmuQ/gApTcnfARogR9Do0Y+ewo0URuypmN2oz
        +I3mCE1cHk6D4XJvzcFfPCcr9A==
X-Google-Smtp-Source: ABdhPJzlRzqAoCgskrJuxHrw4kKKuNKgDfuaCKHDwY5vGCG71aiqXTVhVJTp6K3cF2uCkrz1P8Tu0Q==
X-Received: by 2002:ac8:6c36:: with SMTP id k22mr26422191qtu.288.1593611104217;
        Wed, 01 Jul 2020 06:45:04 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id d136sm1444345qke.47.2020.07.01.06.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:45:03 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org (open list:INTERCONNECT API),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/6] dt-bindings: interconnect: Add Qualcomm SM8150 DT bindings
Date:   Wed,  1 Jul 2020 09:42:50 -0400
Message-Id: <20200701134259.8055-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200701134259.8055-1-jonathan@marek.ca>
References: <20200701134259.8055-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SM8150 platform has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../bindings/interconnect/qcom,sm8150.yaml    |  86 +++++++++
 .../dt-bindings/interconnect/qcom,sm8150.h    | 176 ++++++++++++++++++
 2 files changed, 262 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8150.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8150.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm8150.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm8150.yaml
new file mode 100644
index 000000000000..99fb881bc797
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm8150.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sm8150.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:  Qualcomm SM8150 Network-On-Chip Interconnect
+
+maintainers:
+  -
+
+description: |
+   SM8150 interconnect providers support system bandwidth requirements through
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
+      - qcom,sm8150-aggre1-noc
+      - qcom,sm8150-aggre2-noc
+      - qcom,sm8150-camnoc-noc
+      - qcom,sm8150-compute-noc
+      - qcom,sm8150-config-noc
+      - qcom,sm8150-dc-noc
+      - qcom,sm8150-gem-noc
+      - qcom,sm8150-ipa-virt
+      - qcom,sm8150-mc-virt
+      - qcom,sm8150-mmss-noc
+      - qcom,sm8150-system-noc
+      - qcom,sm8150-gem-noc-display
+      - qcom,sm8150-mc-virt-display
+      - qcom,sm8150-mmss-noc-display
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
+      #include <dt-bindings/interconnect/qcom,sm8150.h>
+
+      config_noc: interconnect@1500000 {
+            compatible = "qcom,sm8150-config-noc";
+            reg = <0x01500000 0x1000>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      system_noc: interconnect@1629000 {
+            compatible = "qcom,sm8150-system-noc";
+            reg = <0x01629000 0x1000>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      mmss_noc: interconnect@1749000 {
+            compatible = "qcom,sm8150-mmss-noc";
+            reg = <0x01749000 0x1000>;
+            #interconnect-cells = <1>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+      };
diff --git a/include/dt-bindings/interconnect/qcom,sm8150.h b/include/dt-bindings/interconnect/qcom,sm8150.h
new file mode 100644
index 000000000000..0550d7313817
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm8150.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm SM8150 interconnect IDs
+ *
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8150_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8150_H
+
+#define MASTER_A1NOC_CFG		0
+#define MASTER_QUP_0			1
+#define MASTER_EMAC			2
+#define MASTER_UFS_MEM			3
+#define MASTER_USB3			4
+#define MASTER_USB3_1			5
+#define A1NOC_SNOC_SLV			6
+#define SLAVE_SERVICE_A1NOC		7
+
+#define MASTER_A2NOC_CFG		0
+#define MASTER_QDSS_BAM			1
+#define MASTER_QSPI			2
+#define MASTER_QUP_1			3
+#define MASTER_QUP_2			4
+#define MASTER_SENSORS_AHB		5
+#define MASTER_TSIF			6
+#define MASTER_CNOC_A2NOC		7
+#define MASTER_CRYPTO_CORE_0		8
+#define MASTER_IPA			9
+#define MASTER_PCIE			10
+#define MASTER_PCIE_1			11
+#define MASTER_QDSS_ETR			12
+#define MASTER_SDCC_2			13
+#define MASTER_SDCC_4			14
+#define A2NOC_SNOC_SLV			15
+#define SLAVE_ANOC_PCIE_GEM_NOC		16
+#define SLAVE_SERVICE_A2NOC		17
+
+#define MASTER_CAMNOC_HF0_UNCOMP	0
+#define MASTER_CAMNOC_HF1_UNCOMP	1
+#define MASTER_CAMNOC_SF_UNCOMP		2
+#define SLAVE_CAMNOC_UNCOMP		3
+
+#define MASTER_NPU			0
+#define SLAVE_CDSP_MEM_NOC		1
+
+#define MASTER_SPDM			0
+#define SNOC_CNOC_MAS			1
+#define MASTER_QDSS_DAP			2
+#define SLAVE_A1NOC_CFG			3
+#define SLAVE_A2NOC_CFG			4
+#define SLAVE_AHB2PHY_SOUTH		5
+#define SLAVE_AOP			6
+#define SLAVE_AOSS			7
+#define SLAVE_CAMERA_CFG		8
+#define SLAVE_CLK_CTL			9
+#define SLAVE_CDSP_CFG			10
+#define SLAVE_RBCPR_CX_CFG		11
+#define SLAVE_RBCPR_MMCX_CFG		12
+#define SLAVE_RBCPR_MX_CFG		13
+#define SLAVE_CRYPTO_0_CFG		14
+#define SLAVE_CNOC_DDRSS		15
+#define SLAVE_DISPLAY_CFG		16
+#define SLAVE_EMAC_CFG			17
+#define SLAVE_GLM			18
+#define SLAVE_GRAPHICS_3D_CFG		19
+#define SLAVE_IMEM_CFG			20
+#define SLAVE_IPA_CFG			21
+#define SLAVE_CNOC_MNOC_CFG		22
+#define SLAVE_NPU_CFG			23
+#define SLAVE_PCIE_0_CFG		24
+#define SLAVE_PCIE_1_CFG		25
+#define SLAVE_NORTH_PHY_CFG		26
+#define SLAVE_PIMEM_CFG			27
+#define SLAVE_PRNG			28
+#define SLAVE_QDSS_CFG			29
+#define SLAVE_QSPI			30
+#define SLAVE_QUP_2			31
+#define SLAVE_QUP_1			32
+#define SLAVE_QUP_0			33
+#define SLAVE_SDCC_2			34
+#define SLAVE_SDCC_4			35
+#define SLAVE_SNOC_CFG			36
+#define SLAVE_SPDM_WRAPPER		37
+#define SLAVE_SPSS_CFG			38
+#define SLAVE_SSC_CFG			39
+#define SLAVE_TCSR			40
+#define SLAVE_TLMM_EAST			41
+#define SLAVE_TLMM_NORTH		42
+#define SLAVE_TLMM_SOUTH		43
+#define SLAVE_TLMM_WEST			44
+#define SLAVE_TSIF			45
+#define SLAVE_UFS_CARD_CFG		46
+#define SLAVE_UFS_MEM_CFG		47
+#define SLAVE_USB3			48
+#define SLAVE_USB3_1			49
+#define SLAVE_VENUS_CFG			50
+#define SLAVE_VSENSE_CTRL_CFG		51
+#define SLAVE_CNOC_A2NOC		52
+#define SLAVE_SERVICE_CNOC		53
+
+#define MASTER_CNOC_DC_NOC		0
+#define SLAVE_LLCC_CFG			1
+#define SLAVE_GEM_NOC_CFG		2
+
+#define MASTER_AMPSS_M0			0
+#define MASTER_GPU_TCU			1
+#define MASTER_SYS_TCU			2
+#define MASTER_GEM_NOC_CFG		3
+#define MASTER_COMPUTE_NOC		4
+#define MASTER_GRAPHICS_3D		5
+#define MASTER_MNOC_HF_MEM_NOC		6
+#define MASTER_MNOC_SF_MEM_NOC		7
+#define MASTER_GEM_NOC_PCIE_SNOC	8
+#define MASTER_SNOC_GC_MEM_NOC		9
+#define MASTER_SNOC_SF_MEM_NOC		10
+#define MASTER_ECC			11
+#define SLAVE_MSS_PROC_MS_MPU_CFG	12
+#define SLAVE_ECC			13
+#define SLAVE_GEM_NOC_SNOC		14
+#define SLAVE_LLCC			15
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
+#define MASTER_CAMNOC_HF0		1
+#define MASTER_CAMNOC_HF1		2
+#define MASTER_CAMNOC_SF		3
+#define MASTER_MDP_PORT0		4
+#define MASTER_MDP_PORT1		5
+#define MASTER_ROTATOR			6
+#define MASTER_VIDEO_P0			7
+#define MASTER_VIDEO_P1			8
+#define MASTER_VIDEO_PROC		9
+#define SLAVE_MNOC_SF_MEM_NOC		10
+#define SLAVE_MNOC_HF_MEM_NOC		11
+#define SLAVE_SERVICE_MNOC		12
+
+#define MASTER_SNOC_CFG			0
+#define A1NOC_SNOC_MAS			1
+#define A2NOC_SNOC_MAS			2
+#define MASTER_GEM_NOC_SNOC		3
+#define MASTER_PIMEM			4
+#define MASTER_GIC			5
+#define SLAVE_APPSS			6
+#define SNOC_CNOC_SLV			7
+#define SLAVE_SNOC_GEM_NOC_GC		8
+#define SLAVE_SNOC_GEM_NOC_SF		9
+#define SLAVE_OCIMEM			10
+#define SLAVE_PIMEM			11
+#define SLAVE_SERVICE_SNOC		12
+#define SLAVE_PCIE_0			13
+#define SLAVE_PCIE_1			14
+#define SLAVE_QDSS_STM			15
+#define SLAVE_TCU			16
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
+#define SLAVE_MNOC_SF_MEM_NOC_DISPLAY	3
+#define SLAVE_MNOC_HF_MEM_NOC_DISPLAY	4
+
+#endif
-- 
2.26.1

