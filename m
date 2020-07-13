Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9A921DA72
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 17:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgGMPnX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 11:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbgGMPmw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 11:42:52 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5931C061794
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:42:52 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id k18so12607277qke.4
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0/Om6KX5WpVodwKlmSsBgTMZUVH39nABMAZW28824HU=;
        b=eSo2x87Y1epp53LEJ7RdCRLoB/S0E7dpae2sSzReQ3SKvPtOMgUP2jsO7NKnQebEUU
         lvRek+vwBTyMP+hmCDA+6KHwv1+xQoxDmVkIk6+h3Oal0DIyA0mmfy53/Z+q+NTE9Fzs
         CuztoLtIp3KXDDPo84W7jWqCUJWKiim3cMzxYkyTsCUVnxJrAYlCMK737+imofzhgrwV
         H2v33eWHT1lm2gPm/+O3WzZhDpjxnit0fMG5JJtBkGYSsiZ/6n9iorWkoNIn2aM+DiZ0
         G4DypqX6EhKDPFKL6RLN/ueR8HFeapLFFikGQPtDvojwphKhgTnA8wKrljmBBLCl3cMx
         yiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0/Om6KX5WpVodwKlmSsBgTMZUVH39nABMAZW28824HU=;
        b=gSv04ozFbYGb5/RwVyCgVBzeHkEiQUeQia7tdNt17FJ5sAkRQAuyiZqvdlaAzRghHU
         jU4yprZGHaxV4VFAZierv9RGy86oTWFccqSac4YTY23zgprnTm1ybOSQDclVbKu0O/1b
         6GwD04Fvg8Z9jVQzTXbuI1Wse/kAtoB+oMUai1dLXX/+3bMZFkdRdeiY8MYKs5SE0Gan
         BYCX7nPcmxzgmjMAgFgbTdZRmnUIV++6bbW2r7C3HBcqTKF35IC+uzG504e6L80RWf+W
         CeIDb/beorTUWMIN/JzjeivMUTgE2ig/LRaEBwctZwgTl5j9CgxZ+Tr6xMR5UkNA5aeR
         L//g==
X-Gm-Message-State: AOAM532YHLbf41SlVvihuow44VGEOGa5vkpDl1ujm8yCZv7MPfPIe/U4
        vUNuhNz6R1HlI1Q9jaM/sBaCvg==
X-Google-Smtp-Source: ABdhPJzwnEHIsy08nyUHYlxsxaXmMySKLQo3sZve5g3qQlPwjyG7BMny1Oa27guDoBfPV4pyxGvGMQ==
X-Received: by 2002:a37:9bc9:: with SMTP id d192mr142932qke.409.1594654971906;
        Mon, 13 Jul 2020 08:42:51 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id l1sm19806371qtk.18.2020.07.13.08.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 08:42:51 -0700 (PDT)
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
Subject: [PATCH v2 2/7] dt-bindings: interconnect: Add Qualcomm SM8150 DT bindings
Date:   Mon, 13 Jul 2020 11:41:11 -0400
Message-Id: <20200713154121.22094-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200713154121.22094-1-jonathan@marek.ca>
References: <20200713154121.22094-1-jonathan@marek.ca>
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
 .../bindings/interconnect/qcom,rpmh.yaml      |  11 ++
 .../dt-bindings/interconnect/qcom,sm8150.h    | 163 ++++++++++++++++++
 2 files changed, 174 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8150.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 9878139a73b8..9dfd1d75fdd3 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -45,6 +45,17 @@ properties:
       - qcom,sdm845-mem-noc
       - qcom,sdm845-mmss-noc
       - qcom,sdm845-system-noc
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
 
   '#interconnect-cells':
     const: 1
diff --git a/include/dt-bindings/interconnect/qcom,sm8150.h b/include/dt-bindings/interconnect/qcom,sm8150.h
new file mode 100644
index 000000000000..ab42f04d93a2
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm8150.h
@@ -0,0 +1,163 @@
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
+#endif
-- 
2.26.1

