Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0E421DA6D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 17:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgGMPnS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 11:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbgGMPmy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 11:42:54 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E25CC061794
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:42:54 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c139so12584257qkg.12
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8i3OitXScmOJF7vr0WcDqwgEgAOAE9A2zxpiSgF0h6c=;
        b=xpqtSAgxUWUhLAyAw7UnR5hTKMjYGe/EcAq1TAnrA00wK/tEU8aAINF6EnZ9T0s0FG
         4RIemn7oBTBGWwgbgf2zjDr0mL6O6/QmwR7GaZGph3yxVtl0epEWzTHvgkbJnkSUsrWc
         ULIkXgEDTtAzhrv3NExSI4Y0cKiJ71AtEoSMs6wQOaPrdCj/NXwPb92Uhuii6+JLphbW
         wyUf3SpHkFa9FV7JyoXJZAHt5cAnNVnX2rH0yHDs6SqwIL5h7DDJPmcTbHOueytIVsy6
         o1D02ieCIQkbe70cchR8da1o/EPlLk5WCXdm8nxDPagUHFbz3KDu1WUcmdz4cvpZguak
         6lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8i3OitXScmOJF7vr0WcDqwgEgAOAE9A2zxpiSgF0h6c=;
        b=c6FaAktEkmc4WZ5uyAYMfuEcsuQrfwVO8N4vvBAfVDO+2Gvp38YbM8jIL7O5H6Ou1Y
         HO8YsEpXv1b7qtYlAOqbQ8T7FQT+A3Wn0i/RiIaIlUtFUyI+0WQB8LF3C1oPmM9dFUGt
         qZsYmNxgw/HeKthz+1kwR3/1V/uw3KNNDaUfHVqN+8WupBKXhIdzWJihWiH3gegbiXzl
         NxUK8ObXehes6PVVfwP65/uJHq+EvX/KSBsxOPwexiEO1gcTdHLbqrE1uahE2a/ZdCZV
         UCswn9CjdhZu9GLnlrtstQ02iikX5/Za/KzbHIOFT3jSu3oHu1W3uQf6g0TC51liztKh
         tiFw==
X-Gm-Message-State: AOAM532iu5es9lhgRcSjzm+ZDhs2aLuilmLBcldAPDfOvoVtLsU1QtfK
        W/cF/T0ucbZzZOgtUMrb0Lz4Hg==
X-Google-Smtp-Source: ABdhPJxDIyGGWp7jBCp5xIlK2SvelMs+nBP/iffWFLWpPoh6Q7WxTNt7SXaz/bZriPoyOeB9DCbZfA==
X-Received: by 2002:a05:620a:7ea:: with SMTP id k10mr194916qkk.418.1594654973676;
        Mon, 13 Jul 2020 08:42:53 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id l1sm19806371qtk.18.2020.07.13.08.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 08:42:53 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org (open list:INTERCONNECT API),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/7] dt-bindings: interconnect: Add Qualcomm SM8250 DT bindings
Date:   Mon, 13 Jul 2020 11:41:12 -0400
Message-Id: <20200713154121.22094-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200713154121.22094-1-jonathan@marek.ca>
References: <20200713154121.22094-1-jonathan@marek.ca>
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
 .../bindings/interconnect/qcom,rpmh.yaml      |  11 ++
 .../dt-bindings/interconnect/qcom,sm8250.h    | 173 ++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8250.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 9dfd1d75fdd3..4894ff0e8246 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -56,6 +56,17 @@ properties:
       - qcom,sm8150-mc-virt
       - qcom,sm8150-mmss-noc
       - qcom,sm8150-system-noc
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
 
   '#interconnect-cells':
     const: 1
diff --git a/include/dt-bindings/interconnect/qcom,sm8250.h b/include/dt-bindings/interconnect/qcom,sm8250.h
new file mode 100644
index 000000000000..fda27ac7b3c4
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm8250.h
@@ -0,0 +1,173 @@
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
+#endif
-- 
2.26.1

