Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D987316449
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 11:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhBJKu1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 05:50:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231390AbhBJKsQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Feb 2021 05:48:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D402264E2F;
        Wed, 10 Feb 2021 10:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612954055;
        bh=a/XM9pHwhQW765fjQFIo8vqfMN/x8BO1mdYZQselwNc=;
        h=From:To:Cc:Subject:Date:From;
        b=OdqDDODEOqYt21vtszWOhisBj5iLxzG70K1r8heHzX3jxa42y60A7/pyOuPXXgp2m
         mT3nstdJqn6G4BmD5Jndo8peF61CTNQLe6gA7z3QMsu8K/tpu91P6caRzTRFGd33/u
         kDTRFDKbAAlB5kpWqrqLSZy6kZ5b6yE1GXrp6t2f110RP0Csv7u++KZqDcVkEpcwWJ
         lapi8yXk3goNENH/92RIo3HC7eW13pUOLOUeOZCrP8fu2KphfVoIwCjHhw0hZidx3a
         iQoIEcgTVLyrGr6fUzVm2/7lnd+wjkG6qL9/Zoun0YOSEKKr8oG7UleyDm/nSVWyqZ
         WLjQ3AVV8isjA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM8350 DT bindings
Date:   Wed, 10 Feb 2021 16:17:23 +0530
Message-Id: <20210210104724.340991-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SM8350 platform has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/interconnect/qcom,rpmh.yaml      |  10 ++
 .../dt-bindings/interconnect/qcom,sm8350.h    | 169 ++++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8350.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 30c2a092d2d3..e47f2aa0c61b 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -67,6 +67,16 @@ properties:
       - qcom,sm8250-mmss-noc
       - qcom,sm8250-npu-noc
       - qcom,sm8250-system-noc
+      - qcom,sm8350-aggre1-noc
+      - qcom,sm8350-aggre2-noc
+      - qcom,sm8350-config-noc
+      - qcom,sm8350-dc-noc
+      - qcom,sm8350-gem-noc
+      - qcom,sm8350-lpass-ag-noc
+      - qcom,sm8350-mc-virt
+      - qcom,sm8350-mmss-noc
+      - qcom,sm8350-compute-noc
+      - qcom,sm8350-system-noc
 
   '#interconnect-cells':
     const: 1
diff --git a/include/dt-bindings/interconnect/qcom,sm8350.h b/include/dt-bindings/interconnect/qcom,sm8350.h
new file mode 100644
index 000000000000..8633c58b3b80
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm8350.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Qualcomm SM8350 interconnect IDs
+ *
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8350_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8350_H
+
+#define SM8350_MASTER_GPU_TCU				0
+#define SM8350_MASTER_SYS_TCU				1
+#define SM8350_MASTER_APPSS_PROC			2
+#define SM8350_MASTER_LLCC				3
+#define SM8350_MASTER_CNOC_LPASS_AG_NOC			4
+#define SM8350_MASTER_CDSP_NOC_CFG			5
+#define SM8350_MASTER_QDSS_BAM				6
+#define SM8350_MASTER_QSPI_0				7
+#define SM8350_MASTER_QUP_0				8
+#define SM8350_MASTER_QUP_1				9
+#define SM8350_MASTER_QUP_2				10
+#define SM8350_MASTER_A1NOC_CFG				11
+#define SM8350_MASTER_A2NOC_CFG				12
+#define SM8350_MASTER_A1NOC_SNOC			13
+#define SM8350_MASTER_A2NOC_SNOC			14
+#define SM8350_MASTER_CAMNOC_HF				15
+#define SM8350_MASTER_CAMNOC_ICP			16
+#define SM8350_MASTER_CAMNOC_SF				17
+#define SM8350_MASTER_COMPUTE_NOC			18
+#define SM8350_MASTER_CNOC_DC_NOC			19
+#define SM8350_MASTER_GEM_NOC_CFG			20
+#define SM8350_MASTER_GEM_NOC_CNOC			21
+#define SM8350_MASTER_GEM_NOC_PCIE_SNOC			22
+#define SM8350_MASTER_GFX3D				23
+#define SM8350_MASTER_CNOC_MNOC_CFG			24
+#define SM8350_MASTER_MNOC_HF_MEM_NOC			25
+#define SM8350_MASTER_MNOC_SF_MEM_NOC			26
+#define SM8350_MASTER_ANOC_PCIE_GEM_NOC			27
+#define SM8350_MASTER_SNOC_CFG				28
+#define SM8350_MASTER_SNOC_GC_MEM_NOC			29
+#define SM8350_MASTER_SNOC_SF_MEM_NOC			30
+#define SM8350_MASTER_VIDEO_P0				31
+#define SM8350_MASTER_VIDEO_P1				32
+#define SM8350_MASTER_VIDEO_PROC			33
+#define SM8350_MASTER_QUP_CORE_0			34
+#define SM8350_MASTER_QUP_CORE_1			35
+#define SM8350_MASTER_QUP_CORE_2			36
+#define SM8350_MASTER_CRYPTO				37
+#define SM8350_MASTER_IPA				38
+#define SM8350_MASTER_MDP0				39
+#define SM8350_MASTER_MDP1				40
+#define SM8350_MASTER_CDSP_PROC				41
+#define SM8350_MASTER_PIMEM				42
+#define SM8350_MASTER_ROTATOR				43
+#define SM8350_MASTER_GIC				44
+#define SM8350_MASTER_PCIE_0				45
+#define SM8350_MASTER_PCIE_1				46
+#define SM8350_MASTER_QDSS_DAP				47
+#define SM8350_MASTER_QDSS_ETR				48
+#define SM8350_MASTER_SDCC_2				49
+#define SM8350_MASTER_SDCC_4				50
+#define SM8350_MASTER_UFS_CARD				51
+#define SM8350_MASTER_UFS_MEM				52
+#define SM8350_MASTER_USB3_0				53
+#define SM8350_MASTER_USB3_1				54
+#define SM8350_SLAVE_EBI1				512
+#define SM8350_SLAVE_AHB2PHY_SOUTH			513
+#define SM8350_SLAVE_AHB2PHY_NORTH			514
+#define SM8350_SLAVE_AOSS				515
+#define SM8350_SLAVE_APPSS				516
+#define SM8350_SLAVE_CAMERA_CFG				517
+#define SM8350_SLAVE_CLK_CTL				518
+#define SM8350_SLAVE_CDSP_CFG				519
+#define SM8350_SLAVE_RBCPR_CX_CFG			520
+#define SM8350_SLAVE_RBCPR_MMCX_CFG			521
+#define SM8350_SLAVE_RBCPR_MX_CFG			522
+#define SM8350_SLAVE_CRYPTO_0_CFG			523
+#define SM8350_SLAVE_CX_RDPM				524
+#define SM8350_SLAVE_DCC_CFG				525
+#define SM8350_SLAVE_DISPLAY_CFG			526
+#define SM8350_SLAVE_GFX3D_CFG				527
+#define SM8350_SLAVE_HWKM				528
+#define SM8350_SLAVE_IMEM_CFG				529
+#define SM8350_SLAVE_IPA_CFG				530
+#define SM8350_SLAVE_IPC_ROUTER_CFG			531
+#define SM8350_SLAVE_LLCC_CFG				532
+#define SM8350_SLAVE_LPASS				533
+#define SM8350_SLAVE_LPASS_CORE_CFG			534
+#define SM8350_SLAVE_LPASS_LPI_CFG			535
+#define SM8350_SLAVE_LPASS_MPU_CFG			536
+#define SM8350_SLAVE_LPASS_TOP_CFG			537
+#define SM8350_SLAVE_MSS_PROC_MS_MPU_CFG		538
+#define SM8350_SLAVE_MCDMA_MS_MPU_CFG			539
+#define SM8350_SLAVE_CNOC_MSS				540
+#define SM8350_SLAVE_MX_RDPM				541
+#define SM8350_SLAVE_PCIE_0_CFG				542
+#define SM8350_SLAVE_PCIE_1_CFG				543
+#define SM8350_SLAVE_PDM				544
+#define SM8350_SLAVE_PIMEM_CFG				545
+#define SM8350_SLAVE_PKA_WRAPPER_CFG			546
+#define SM8350_SLAVE_PMU_WRAPPER_CFG			547
+#define SM8350_SLAVE_QDSS_CFG				548
+#define SM8350_SLAVE_QSPI_0				549
+#define SM8350_SLAVE_QUP_0				550
+#define SM8350_SLAVE_QUP_1				551
+#define SM8350_SLAVE_QUP_2				552
+#define SM8350_SLAVE_SDCC_2				553
+#define SM8350_SLAVE_SDCC_4				554
+#define SM8350_SLAVE_SECURITY				555
+#define SM8350_SLAVE_SPSS_CFG				556
+#define SM8350_SLAVE_TCSR				557
+#define SM8350_SLAVE_TLMM				558
+#define SM8350_SLAVE_UFS_CARD_CFG			559
+#define SM8350_SLAVE_UFS_MEM_CFG			560
+#define SM8350_SLAVE_USB3_0				561
+#define SM8350_SLAVE_USB3_1				562
+#define SM8350_SLAVE_VENUS_CFG				563
+#define SM8350_SLAVE_VSENSE_CTRL_CFG			564
+#define SM8350_SLAVE_A1NOC_CFG				565
+#define SM8350_SLAVE_A1NOC_SNOC				566
+#define SM8350_SLAVE_A2NOC_CFG				567
+#define SM8350_SLAVE_A2NOC_SNOC				568
+#define SM8350_SLAVE_DDRSS_CFG				569
+#define SM8350_SLAVE_GEM_NOC_CNOC			570
+#define SM8350_SLAVE_GEM_NOC_CFG			571
+#define SM8350_SLAVE_SNOC_GEM_NOC_GC			572
+#define SM8350_SLAVE_SNOC_GEM_NOC_SF			573
+#define SM8350_SLAVE_LLCC				574
+#define SM8350_SLAVE_MNOC_HF_MEM_NOC			575
+#define SM8350_SLAVE_MNOC_SF_MEM_NOC			576
+#define SM8350_SLAVE_CNOC_MNOC_CFG			577
+#define SM8350_SLAVE_CDSP_MEM_NOC			578
+#define SM8350_SLAVE_MEM_NOC_PCIE_SNOC			579
+#define SM8350_SLAVE_ANOC_PCIE_GEM_NOC			580
+#define SM8350_SLAVE_SNOC_CFG				581
+#define SM8350_SLAVE_QUP_CORE_0				582
+#define SM8350_SLAVE_QUP_CORE_1				583
+#define SM8350_SLAVE_QUP_CORE_2				584
+#define SM8350_SLAVE_BOOT_IMEM				585
+#define SM8350_SLAVE_IMEM				586
+#define SM8350_SLAVE_PIMEM				587
+#define SM8350_SLAVE_SERVICE_NSP_NOC			588
+#define SM8350_SLAVE_SERVICE_A1NOC			589
+#define SM8350_SLAVE_SERVICE_A2NOC			590
+#define SM8350_SLAVE_SERVICE_CNOC			591
+#define SM8350_SLAVE_SERVICE_GEM_NOC_1			592
+#define SM8350_SLAVE_SERVICE_MNOC			593
+#define SM8350_SLAVE_SERVICES_LPASS_AML_NOC		594
+#define SM8350_SLAVE_SERVICE_LPASS_AG_NOC		595
+#define SM8350_SLAVE_SERVICE_GEM_NOC_2			596
+#define SM8350_SLAVE_SERVICE_SNOC			597
+#define SM8350_SLAVE_SERVICE_GEM_NOC			598
+#define SM8350_SLAVE_PCIE_0				599
+#define SM8350_SLAVE_PCIE_1				600
+#define SM8350_SLAVE_QDSS_STM				601
+#define SM8350_SLAVE_TCU				602
+#define SM8350_MASTER_LLCC_DISP				1000
+#define SM8350_MASTER_MNOC_HF_MEM_NOC_DISP		1001
+#define SM8350_MASTER_MNOC_SF_MEM_NOC_DISP		1002
+#define SM8350_MASTER_MDP0_DISP				1003
+#define SM8350_MASTER_MDP1_DISP				1004
+#define SM8350_MASTER_ROTATOR_DISP			1005
+#define SM8350_SLAVE_EBI1_DISP				1512
+#define SM8350_SLAVE_LLCC_DISP				1513
+#define SM8350_SLAVE_MNOC_HF_MEM_NOC_DISP		1514
+#define SM8350_SLAVE_MNOC_SF_MEM_NOC_DISP		1515
+
+#endif
-- 
2.26.2

