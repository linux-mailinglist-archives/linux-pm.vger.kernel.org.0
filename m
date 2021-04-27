Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA8936C22A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 11:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhD0JxC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 05:53:02 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:51405 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbhD0JxB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 05:53:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619517138; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=5d4jdldSyvUh05MaXxXoVdf73yC4jzIix0A7sUiztvM=; b=kK2V4tcBc7Ub3wo9wed4vGkSkFitv+MhE3Y9rhpLWP0BjnIJ1+39nsNyzQn/e9OUGJsOVIl/
 VoQYD8DP31Fy0WQ53+R07PuHGNdOr7dS/jqCOyZmKPlcODm1mLMObprzx4JSH6PEgw/6CwHJ
 AbbeUI2nD8Z5MMvVlGVymwNkWHQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6087de9f87ce1fbb56bcc7ee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Apr 2021 09:51:27
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 545DDC433D3; Tue, 27 Apr 2021 09:51:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from okukatla1-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D9A1C433F1;
        Tue, 27 Apr 2021 09:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D9A1C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=okukatla@codeaurora.org
From:   Odelu Kukatla <okukatla@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        sibis@codeaurora.org, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: [v2 1/3] dt-bindings: interconnect: Add Qualcomm SC7280 DT bindings
Date:   Tue, 27 Apr 2021 15:20:56 +0530
Message-Id: <1619517059-12109-2-git-send-email-okukatla@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619517059-12109-1-git-send-email-okukatla@codeaurora.org>
References: <1619517059-12109-1-git-send-email-okukatla@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SC7280 platform has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand.

Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
---
 .../bindings/interconnect/qcom,rpmh.yaml           |  12 ++
 include/dt-bindings/interconnect/qcom,sc7280.h     | 165 +++++++++++++++++++++
 2 files changed, 177 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,sc7280.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index cb64981..d8afb0f 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -37,6 +37,18 @@ properties:
       - qcom,sc7180-npu-noc
       - qcom,sc7180-qup-virt
       - qcom,sc7180-system-noc
+      - qcom,sc7280-aggre1-noc
+      - qcom,sc7280-aggre2-noc
+      - qcom,sc7280-clk-virt
+      - qcom,sc7280-cnoc2
+      - qcom,sc7280-cnoc3
+      - qcom,sc7280-dc-noc
+      - qcom,sc7280-gem-noc
+      - qcom,sc7280-lpass-ag-noc
+      - qcom,sc7280-mc-virt
+      - qcom,sc7280-mmss-noc
+      - qcom,sc7280-nsp-noc
+      - qcom,sc7280-system-noc
       - qcom,sdm845-aggre1-noc
       - qcom,sdm845-aggre2-noc
       - qcom,sdm845-config-noc
diff --git a/include/dt-bindings/interconnect/qcom,sc7280.h b/include/dt-bindings/interconnect/qcom,sc7280.h
new file mode 100644
index 0000000..21b00044
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sc7280.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Qualcomm SC7280 interconnect IDs
+ *
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SC7280_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SC7280_H
+
+#define MASTER_QSPI_0			0
+#define MASTER_QUP_0			1
+#define MASTER_QUP_1			2
+#define MASTER_A1NOC_CFG			3
+#define MASTER_PCIE_0			4
+#define MASTER_PCIE_1			5
+#define MASTER_SDCC_1			6
+#define MASTER_SDCC_2			7
+#define MASTER_SDCC_4			8
+#define MASTER_UFS_MEM			9
+#define MASTER_USB2			10
+#define MASTER_USB3_0			11
+#define SLAVE_A1NOC_SNOC			12
+#define SLAVE_ANOC_PCIE_GEM_NOC			13
+#define SLAVE_SERVICE_A1NOC			14
+
+#define MASTER_QDSS_BAM			0
+#define MASTER_A2NOC_CFG			1
+#define MASTER_CNOC_A2NOC			2
+#define MASTER_CRYPTO			3
+#define MASTER_IPA			4
+#define MASTER_QDSS_ETR			5
+#define SLAVE_A2NOC_SNOC			6
+#define SLAVE_SERVICE_A2NOC			7
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1		1
+#define SLAVE_QUP_CORE_0			2
+#define SLAVE_QUP_CORE_1			3
+
+#define MASTER_CNOC3_CNOC2			0
+#define MASTER_QDSS_DAP			1
+#define SLAVE_AHB2PHY_SOUTH			2
+#define SLAVE_AHB2PHY_NORTH			3
+#define SLAVE_CAMERA_CFG			4
+#define SLAVE_CLK_CTL			5
+#define SLAVE_CDSP_CFG			6
+#define SLAVE_RBCPR_CX_CFG			7
+#define SLAVE_RBCPR_MX_CFG			8
+#define SLAVE_CRYPTO_0_CFG			9
+#define SLAVE_CX_RDPM			10
+#define SLAVE_DCC_CFG			11
+#define SLAVE_DISPLAY_CFG			12
+#define SLAVE_GFX3D_CFG			13
+#define SLAVE_HWKM			14
+#define SLAVE_IMEM_CFG			15
+#define SLAVE_IPA_CFG			16
+#define SLAVE_IPC_ROUTER_CFG			17
+#define SLAVE_LPASS			18
+#define SLAVE_CNOC_MSS			19
+#define SLAVE_MX_RDPM			20
+#define SLAVE_PCIE_0_CFG			21
+#define SLAVE_PCIE_1_CFG			22
+#define SLAVE_PDM			23
+#define SLAVE_PIMEM_CFG			24
+#define SLAVE_PKA_WRAPPER_CFG			25
+#define SLAVE_PMU_WRAPPER_CFG			26
+#define SLAVE_QDSS_CFG			27
+#define SLAVE_QSPI_0			28
+#define SLAVE_QUP_0			29
+#define SLAVE_QUP_1			30
+#define SLAVE_SDCC_1			31
+#define SLAVE_SDCC_2			32
+#define SLAVE_SDCC_4			33
+#define SLAVE_SECURITY			34
+#define SLAVE_TCSR			35
+#define SLAVE_TLMM			36
+#define SLAVE_UFS_MEM_CFG			37
+#define SLAVE_USB2			38
+#define SLAVE_USB3_0			39
+#define SLAVE_VENUS_CFG			40
+#define SLAVE_VSENSE_CTRL_CFG			41
+#define SLAVE_A1NOC_CFG			42
+#define SLAVE_A2NOC_CFG			43
+#define SLAVE_CNOC2_CNOC3			44
+#define SLAVE_CNOC_MNOC_CFG			45
+#define SLAVE_SNOC_CFG			46
+
+#define MASTER_CNOC2_CNOC3			0
+#define MASTER_GEM_NOC_CNOC			1
+#define MASTER_GEM_NOC_PCIE_SNOC			2
+#define SLAVE_AOSS			3
+#define SLAVE_APPSS			4
+#define SLAVE_CNOC3_CNOC2			5
+#define SLAVE_CNOC_A2NOC			6
+#define SLAVE_DDRSS_CFG			7
+#define SLAVE_BOOT_IMEM			8
+#define SLAVE_IMEM			9
+#define SLAVE_PIMEM			10
+#define SLAVE_PCIE_0			11
+#define SLAVE_PCIE_1			12
+#define SLAVE_QDSS_STM			13
+#define SLAVE_TCU			14
+
+#define MASTER_CNOC_DC_NOC			0
+#define SLAVE_LLCC_CFG			1
+#define SLAVE_GEM_NOC_CFG			2
+
+#define MASTER_GPU_TCU			0
+#define MASTER_SYS_TCU			1
+#define MASTER_APPSS_PROC			2
+#define MASTER_COMPUTE_NOC			3
+#define MASTER_GEM_NOC_CFG			4
+#define MASTER_GFX3D			5
+#define MASTER_MNOC_HF_MEM_NOC			6
+#define MASTER_MNOC_SF_MEM_NOC			7
+#define MASTER_ANOC_PCIE_GEM_NOC			8
+#define MASTER_SNOC_GC_MEM_NOC			9
+#define MASTER_SNOC_SF_MEM_NOC			10
+#define SLAVE_MSS_PROC_MS_MPU_CFG			11
+#define SLAVE_MCDMA_MS_MPU_CFG			12
+#define SLAVE_GEM_NOC_CNOC			13
+#define SLAVE_LLCC			14
+#define SLAVE_MEM_NOC_PCIE_SNOC			15
+#define SLAVE_SERVICE_GEM_NOC_1			16
+#define SLAVE_SERVICE_GEM_NOC_2			17
+#define SLAVE_SERVICE_GEM_NOC			18
+
+#define MASTER_CNOC_LPASS_AG_NOC			0
+#define SLAVE_LPASS_CORE_CFG			1
+#define SLAVE_LPASS_LPI_CFG			2
+#define SLAVE_LPASS_MPU_CFG			3
+#define SLAVE_LPASS_TOP_CFG			4
+#define SLAVE_SERVICES_LPASS_AML_NOC			5
+#define SLAVE_SERVICE_LPASS_AG_NOC			6
+
+#define MASTER_LLCC			0
+#define SLAVE_EBI1			1
+
+#define MASTER_CNOC_MNOC_CFG			0
+#define MASTER_VIDEO_P0			1
+#define MASTER_VIDEO_PROC			2
+#define MASTER_CAMNOC_HF			3
+#define MASTER_CAMNOC_ICP			4
+#define MASTER_CAMNOC_SF			5
+#define MASTER_MDP0			6
+#define SLAVE_MNOC_HF_MEM_NOC			7
+#define SLAVE_MNOC_SF_MEM_NOC			8
+#define SLAVE_SERVICE_MNOC			9
+
+#define MASTER_CDSP_NOC_CFG			0
+#define MASTER_CDSP_PROC			1
+#define SLAVE_CDSP_MEM_NOC			2
+#define SLAVE_SERVICE_NSP_NOC			3
+
+#define MASTER_A1NOC_SNOC			0
+#define MASTER_A2NOC_SNOC			1
+#define MASTER_SNOC_CFG			2
+#define MASTER_PIMEM			3
+#define MASTER_GIC			4
+#define SLAVE_SNOC_GEM_NOC_GC			5
+#define SLAVE_SNOC_GEM_NOC_SF			6
+#define SLAVE_SERVICE_SNOC			7
+
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

