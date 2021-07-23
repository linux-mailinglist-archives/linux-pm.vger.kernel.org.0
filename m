Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F573D410F
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jul 2021 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhGWTD6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jul 2021 15:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhGWTD5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jul 2021 15:03:57 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58582C061757
        for <linux-pm@vger.kernel.org>; Fri, 23 Jul 2021 12:44:29 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so3127468oth.7
        for <linux-pm@vger.kernel.org>; Fri, 23 Jul 2021 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyfyMlNc/758s1dI0muBuHUfEMmUWjMPPI7fBpiKSWs=;
        b=MlIP8UXOqcSAg1ist39XM48Zb7wwNfb/cwuVUj1xpgRgRlohcGAIfzXtZVPRbfQUcl
         DXwOLPLB9dphI/IG0/hZH88/dJWHR6yFiHdp1VaWHN1Q+/M+vFSeGTGflYRKhrbomFvT
         LkL9N7AabSTF6qljLCv9FXvgMgIbQG2ZUr57u4165lwGNIZFwRSchjlArLHz7JCCiXKt
         CE9VvAcy7emTaZzs11yIXAqS5h0wmIq8ES5WqUJWxPTVbsFi3pkXyGlLzOW1L46O/LuW
         F1jiXATUJZRWH2njljOTLIAVu1Cm7NcrFRJHHHfcCC9KGvRGfRyqZwz6wJmGFEaYD3S8
         fSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyfyMlNc/758s1dI0muBuHUfEMmUWjMPPI7fBpiKSWs=;
        b=NXeERu0+Yis/c2QhGQqwrgwxeRj8xBZZ2jDZBM8pWCCaerv0WS2Pg19so01hpAXX6s
         bjfmaXTrRmNxSb0vQE1LhdKntss4ev/uA3Qlolcv3Sq926B1M2s/DXdpCJAx592mKiDi
         Nmz0CGcKe4jLRx2X1fNQyVcmGr+NFVU7wvCjnBugyGNdtpT0EXzlxapMhXcxJPm++Xib
         ksuDtMcPxTNrpfJoPb2qMivnw7x/Aam3KPQu5lwawUeVHvp7BHV78zkIEhLJnI5+a1Rh
         u5qSzux5x+PXqMnKDeVCL/k55EqQchj2TZHG+wuxBijl9sxsiLCweRgOhVtJTUG6mpti
         6IPQ==
X-Gm-Message-State: AOAM533NzZ/I7hOGp6lY+26rzwTnq5HhdqkcuvCTJ2Yve/poGVwdOpAo
        wy/geQqkp7rxi2M9uASAYP0iUw==
X-Google-Smtp-Source: ABdhPJwdLTaT2ViF4ee0bc6ZIPatwTjgxDW2If/j2wNpLt4kAzD0NY+bSf4Oo6RDpy7jz/1MjHCwOQ==
X-Received: by 2002:a05:6830:10e:: with SMTP id i14mr4097589otp.242.1627069468627;
        Fri, 23 Jul 2021 12:44:28 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a83sm5802877oii.13.2021.07.23.12.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 12:44:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SC8180x DT bindings
Date:   Fri, 23 Jul 2021 12:42:42 -0700
Message-Id: <20210723194243.3675795-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Georgi Djakov <georgi.djakov@linaro.org>

Add compatibles and port definitions for the SC8180x RPMH interconnect
providers.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
[bjorn: Split defines from driver patch and added binding update]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../bindings/interconnect/qcom,rpmh.yaml      |  11 ++
 .../dt-bindings/interconnect/qcom,sc8180x.h   | 185 ++++++++++++++++++
 2 files changed, 196 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,sc8180x.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 5accc0d113be..3fd1a134162d 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -49,6 +49,17 @@ properties:
       - qcom,sc7280-mmss-noc
       - qcom,sc7280-nsp-noc
       - qcom,sc7280-system-noc
+      - qcom,sc8180x-aggre1-noc
+      - qcom,sc8180x-aggre2-noc
+      - qcom,sc8180x-camnoc-virt
+      - qcom,sc8180x-compute-noc
+      - qcom,sc8180x-config-noc
+      - qcom,sc8180x-dc-noc
+      - qcom,sc8180x-gem-noc
+      - qcom,sc8180x-ipa-virt
+      - qcom,sc8180x-mc-virt
+      - qcom,sc8180x-mmss-noc
+      - qcom,sc8180x-system-noc
       - qcom,sdm845-aggre1-noc
       - qcom,sdm845-aggre2-noc
       - qcom,sdm845-config-noc
diff --git a/include/dt-bindings/interconnect/qcom,sc8180x.h b/include/dt-bindings/interconnect/qcom,sc8180x.h
new file mode 100644
index 000000000000..235b525d2803
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sc8180x.h
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Qualcomm SC8180x interconnect IDs
+ *
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SC8180X_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SC8180X_H
+
+#define MASTER_A1NOC_CFG			0
+#define MASTER_UFS_CARD				1
+#define MASTER_UFS_GEN4				2
+#define MASTER_UFS_MEM				3
+#define MASTER_USB3				4
+#define MASTER_USB3_1				5
+#define MASTER_USB3_2				6
+#define A1NOC_SNOC_SLV				7
+#define SLAVE_SERVICE_A1NOC			8
+
+#define MASTER_A2NOC_CFG			0
+#define MASTER_QDSS_BAM				1
+#define MASTER_QSPI_0				2
+#define MASTER_QSPI_1				3
+#define MASTER_QUP_0				4
+#define MASTER_QUP_1				5
+#define MASTER_QUP_2				6
+#define MASTER_SENSORS_AHB			7
+#define MASTER_CRYPTO_CORE_0			8
+#define MASTER_IPA				9
+#define MASTER_EMAC				10
+#define MASTER_PCIE				11
+#define MASTER_PCIE_1				12
+#define MASTER_PCIE_2				13
+#define MASTER_PCIE_3				14
+#define MASTER_QDSS_ETR				15
+#define MASTER_SDCC_2				16
+#define MASTER_SDCC_4				17
+#define A2NOC_SNOC_SLV				18
+#define SLAVE_ANOC_PCIE_GEM_NOC			19
+#define SLAVE_SERVICE_A2NOC			20
+
+#define MASTER_CAMNOC_HF0_UNCOMP		0
+#define MASTER_CAMNOC_HF1_UNCOMP		1
+#define MASTER_CAMNOC_SF_UNCOMP			2
+#define SLAVE_CAMNOC_UNCOMP			3
+
+#define MASTER_NPU				0
+#define SLAVE_CDSP_MEM_NOC			1
+
+#define SNOC_CNOC_MAS				0
+#define SLAVE_A1NOC_CFG				1
+#define SLAVE_A2NOC_CFG				2
+#define SLAVE_AHB2PHY_CENTER			3
+#define SLAVE_AHB2PHY_EAST			4
+#define SLAVE_AHB2PHY_WEST			5
+#define SLAVE_AHB2PHY_SOUTH			6
+#define SLAVE_AOP				7
+#define SLAVE_AOSS				8
+#define SLAVE_CAMERA_CFG			9
+#define SLAVE_CLK_CTL				10
+#define SLAVE_CDSP_CFG				11
+#define SLAVE_RBCPR_CX_CFG			12
+#define SLAVE_RBCPR_MMCX_CFG			13
+#define SLAVE_RBCPR_MX_CFG			14
+#define SLAVE_CRYPTO_0_CFG			15
+#define SLAVE_CNOC_DDRSS			16
+#define SLAVE_DISPLAY_CFG			17
+#define SLAVE_EMAC_CFG				18
+#define SLAVE_GLM				19
+#define SLAVE_GRAPHICS_3D_CFG			20
+#define SLAVE_IMEM_CFG				21
+#define SLAVE_IPA_CFG				22
+#define SLAVE_CNOC_MNOC_CFG			23
+#define SLAVE_NPU_CFG				24
+#define SLAVE_PCIE_0_CFG			25
+#define SLAVE_PCIE_1_CFG			26
+#define SLAVE_PCIE_2_CFG			27
+#define SLAVE_PCIE_3_CFG			28
+#define SLAVE_PDM				29
+#define SLAVE_PIMEM_CFG				30
+#define SLAVE_PRNG				31
+#define SLAVE_QDSS_CFG				32
+#define SLAVE_QSPI_0				33
+#define SLAVE_QSPI_1				34
+#define SLAVE_QUP_1				35
+#define SLAVE_QUP_2				36
+#define SLAVE_QUP_0				37
+#define SLAVE_SDCC_2				38
+#define SLAVE_SDCC_4				39
+#define SLAVE_SECURITY				40
+#define SLAVE_SNOC_CFG				41
+#define SLAVE_SPSS_CFG				42
+#define SLAVE_TCSR				43
+#define SLAVE_TLMM_EAST				44
+#define SLAVE_TLMM_SOUTH			45
+#define SLAVE_TLMM_WEST				46
+#define SLAVE_TSIF				47
+#define SLAVE_UFS_CARD_CFG			48
+#define SLAVE_UFS_MEM_0_CFG			49
+#define SLAVE_UFS_MEM_1_CFG			50
+#define SLAVE_USB3				51
+#define SLAVE_USB3_1				52
+#define SLAVE_USB3_2				53
+#define SLAVE_VENUS_CFG				54
+#define SLAVE_VSENSE_CTRL_CFG			55
+#define SLAVE_SERVICE_CNOC			56
+
+#define MASTER_CNOC_DC_NOC			0
+#define SLAVE_GEM_NOC_CFG			1
+#define SLAVE_LLCC_CFG				2
+
+#define MASTER_AMPSS_M0				0
+#define MASTER_GPU_TCU				1
+#define MASTER_SYS_TCU				2
+#define MASTER_GEM_NOC_CFG			3
+#define MASTER_COMPUTE_NOC			4
+#define MASTER_GRAPHICS_3D			5
+#define MASTER_MNOC_HF_MEM_NOC			6
+#define MASTER_MNOC_SF_MEM_NOC			7
+#define MASTER_GEM_NOC_PCIE_SNOC		8
+#define MASTER_SNOC_GC_MEM_NOC			9
+#define MASTER_SNOC_SF_MEM_NOC			10
+#define MASTER_ECC				11
+#define SLAVE_MSS_PROC_MS_MPU_CFG		12
+#define SLAVE_ECC				13
+#define SLAVE_GEM_NOC_SNOC			14
+#define SLAVE_LLCC				15
+#define SLAVE_SERVICE_GEM_NOC			16
+#define SLAVE_SERVICE_GEM_NOC_1			17
+
+#define MASTER_IPA_CORE				0
+#define SLAVE_IPA_CORE				1
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI_CH0				1
+
+#define MASTER_CNOC_MNOC_CFG			0
+#define MASTER_CAMNOC_HF0			1
+#define MASTER_CAMNOC_HF1			2
+#define MASTER_CAMNOC_SF			3
+#define MASTER_MDP_PORT0			4
+#define MASTER_MDP_PORT1			5
+#define MASTER_ROTATOR				6
+#define MASTER_VIDEO_P0				7
+#define MASTER_VIDEO_P1				8
+#define MASTER_VIDEO_PROC			9
+#define SLAVE_MNOC_SF_MEM_NOC			10
+#define SLAVE_MNOC_HF_MEM_NOC			11
+#define SLAVE_SERVICE_MNOC			12
+
+#define MASTER_SNOC_CFG				0
+#define A1NOC_SNOC_MAS				1
+#define A2NOC_SNOC_MAS				2
+#define MASTER_GEM_NOC_SNOC			3
+#define MASTER_PIMEM				4
+#define MASTER_GIC				5
+#define SLAVE_APPSS				6
+#define SNOC_CNOC_SLV				7
+#define SLAVE_SNOC_GEM_NOC_GC			8
+#define SLAVE_SNOC_GEM_NOC_SF			9
+#define SLAVE_OCIMEM				10
+#define SLAVE_PIMEM				11
+#define SLAVE_SERVICE_SNOC			12
+#define SLAVE_PCIE_0				13
+#define SLAVE_PCIE_1				14
+#define SLAVE_PCIE_2				15
+#define SLAVE_PCIE_3				16
+#define SLAVE_QDSS_STM				17
+#define SLAVE_TCU				18
+
+#define MASTER_MNOC_HF_MEM_NOC_DISPLAY		0
+#define MASTER_MNOC_SF_MEM_NOC_DISPLAY		1
+#define SLAVE_LLCC_DISPLAY			2
+
+#define MASTER_LLCC_DISPLAY			0
+#define SLAVE_EBI_CH0_DISPLAY			1
+
+#define MASTER_MDP_PORT0_DISPLAY		0
+#define MASTER_MDP_PORT1_DISPLAY		1
+#define MASTER_ROTATOR_DISPLAY			2
+#define SLAVE_MNOC_SF_MEM_NOC_DISPLAY		3
+#define SLAVE_MNOC_HF_MEM_NOC_DISPLAY		4
+
+#endif
-- 
2.29.2

