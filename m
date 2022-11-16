Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5675D62BCAD
	for <lists+linux-pm@lfdr.de>; Wed, 16 Nov 2022 12:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKPLyg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Nov 2022 06:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiKPLyB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Nov 2022 06:54:01 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7290C1019
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2022 03:45:52 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l14so29490677wrw.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2022 03:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CYb8x/YmuNm17E9LVErByKAjke5joqUG8NoEA2YMvzw=;
        b=vB3WDtszOwMLHhG21z/PMXCkXJTklcyiKnkKBaR1IPAdOG6sSmqWKE8cIzyS+GfLcu
         aghIgmrGQ9/6H7ucIQS52+5l7u+kXS9k65HGoTW9jptpcrrzYx9gmetxakfF4s9XN1Hn
         lVP/Dj4fK8Ht1uv8UyJLtXSY9ecI9zkW9486pW50pxbJY/tv9PdBfFCq0uCnez3xJ7bm
         jU1w+bfn1LCb3KlhOmN2Zr9eLQB/Pb7P9k5jW0qhLK7Pacffde12QWwpuivhr0BcmvQj
         E9j3AYlGQfZcPNJ8Zf6tMyeD5dUTLQRm186DAE3e9ULfRMhfGgVhgAxcese877HmAaw+
         qhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYb8x/YmuNm17E9LVErByKAjke5joqUG8NoEA2YMvzw=;
        b=41pWHmnH0FJI6L0VL9eCW6YwOmOsNzuzjjJpEkAXwEprzmq6YExewh6OmSvq0de1rb
         lVBZR23Ik0GNkRH+/GTtIgLyHMVrxF3lKbwfbcPtf9jcVdqB6dt6JuJQmlKpgr4fDDnM
         /02bXbCJxuyOy32JP84EgmNmXQuIkJie7FgNX8+3YGFfzXrabWxN8QdJ6cH+RATYWZ8e
         inyGE9eGGvO+6LWVAsXivBi3kpQADPTHLLSVdffTGTXXj4bfXSZ0YHcmYOJVRPmyDeEI
         dcvs8RHMLBVsHI0SETEqgxv7LPM73+B4u/XyEGiYpZjFCK1PWJILxaQHV88Ya/DomAmA
         H5qQ==
X-Gm-Message-State: ANoB5pmQh76Lm7o6vGF3J5V9JvDpkbaoWP01G5I5wiU5KTkF93qxiNfE
        hqdVYfZdrTC45WlWmjAffOOqtA==
X-Google-Smtp-Source: AA0mqf4EPQ6iNXiDDed/pb1jdj1XGgnttAlCGgVaGXIzR7crH3z7FoPX2y2MMRvO2hTi/fZxEEqW6Q==
X-Received: by 2002:adf:fa11:0:b0:22e:34b4:411d with SMTP id m17-20020adffa11000000b0022e34b4411dmr13128010wrr.95.1668599150684;
        Wed, 16 Nov 2022 03:45:50 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c08a900b003a6125562e1sm1692302wmp.46.2022.11.16.03.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:45:50 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM8550 DT bindings
Date:   Wed, 16 Nov 2022 13:45:25 +0200
Message-Id: <20221116114526.2679041-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SM8550 SoC has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/interconnect/qcom,rpmh.yaml      |  19 +-
 .../dt-bindings/interconnect/qcom,sm8550.h    | 190 ++++++++++++++++++
 2 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8550.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index a429a1ed1006..667ed6815773 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -132,12 +132,29 @@ properties:
       - qcom,sm8450-nsp-noc
       - qcom,sm8450-pcie-anoc
       - qcom,sm8450-system-noc
+      - qcom,sm8550-aggre1-noc
+      - qcom,sm8550-aggre2-noc
+      - qcom,sm8550-clk-virt
+      - qcom,sm8550-config-noc
+      - qcom,sm8550-cnoc-main
+      - qcom,sm8550-gem-noc
+      - qcom,sm8550-lpass-ag-noc
+      - qcom,sm8550-lpass-lpiaon-noc
+      - qcom,sm8550-lpass-lpicx-noc
+      - qcom,sm8550-mc-virt
+      - qcom,sm8550-mmss-noc
+      - qcom,sm8550-nsp-noc
+      - qcom,sm8550-pcie-anoc
+      - qcom,sm8550-system-noc
+
+  clocks:
+    minItems: 1
+    maxItems: 2
 
   '#interconnect-cells': true
 
 required:
   - compatible
-  - reg
 
 unevaluatedProperties: false
 
diff --git a/include/dt-bindings/interconnect/qcom,sm8550.h b/include/dt-bindings/interconnect/qcom,sm8550.h
new file mode 100644
index 000000000000..a066460d5a12
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm8550.h
@@ -0,0 +1,190 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8550_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8550_H
+
+#define MASTER_QSPI_0				0
+#define MASTER_QUP_1				1
+#define MASTER_SDCC_4				2
+#define MASTER_UFS_MEM				3
+#define MASTER_USB3_0				4
+#define SLAVE_A1NOC_SNOC			5
+
+#define	MASTER_QDSS_BAM				0
+#define	MASTER_QUP_2				1
+#define	MASTER_CRYPTO				2
+#define	MASTER_IPA				3
+#define	MASTER_SP				4
+#define	MASTER_QDSS_ETR				5
+#define	MASTER_QDSS_ETR_1			6
+#define	MASTER_SDCC_2				7
+#define	SLAVE_A2NOC_SNOC			8
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define MASTER_QUP_CORE_2			2
+#define SLAVE_QUP_CORE_0			3
+#define SLAVE_QUP_CORE_1			4
+#define SLAVE_QUP_CORE_2			5
+
+#define MASTER_CNOC_CFG				0
+#define SLAVE_AHB2PHY_SOUTH			1
+#define SLAVE_AHB2PHY_NORTH			2
+#define SLAVE_APPSS				3
+#define SLAVE_CAMERA_CFG			4
+#define SLAVE_CLK_CTL				5
+#define SLAVE_RBCPR_CX_CFG			6
+#define SLAVE_RBCPR_MMCX_CFG			7
+#define SLAVE_RBCPR_MXA_CFG			8
+#define SLAVE_RBCPR_MXC_CFG			9
+#define SLAVE_CPR_NSPCX				10
+#define SLAVE_CRYPTO_0_CFG			11
+#define SLAVE_CX_RDPM				12
+#define SLAVE_DISPLAY_CFG			13
+#define SLAVE_GFX3D_CFG				14
+#define SLAVE_I2C				15
+#define SLAVE_IMEM_CFG				16
+#define SLAVE_IPA_CFG				17
+#define SLAVE_IPC_ROUTER_CFG			18
+#define SLAVE_CNOC_MSS				19
+#define SLAVE_MX_RDPM				20
+#define SLAVE_PCIE_0_CFG			21
+#define SLAVE_PCIE_1_CFG			22
+#define SLAVE_PDM				23
+#define SLAVE_PIMEM_CFG				24
+#define SLAVE_PRNG				25
+#define SLAVE_QDSS_CFG				26
+#define SLAVE_QSPI_0				27
+#define SLAVE_QUP_1				28
+#define SLAVE_QUP_2				29
+#define SLAVE_SDCC_2				30
+#define SLAVE_SDCC_4				31
+#define SLAVE_SPSS_CFG				32
+#define SLAVE_TCSR				33
+#define SLAVE_TLMM				34
+#define SLAVE_UFS_MEM_CFG			35
+#define SLAVE_USB3_0				36
+#define SLAVE_VENUS_CFG				37
+#define SLAVE_VSENSE_CTRL_CFG			38
+#define SLAVE_LPASS_QTB_CFG			39
+#define SLAVE_CNOC_MNOC_CFG			40
+#define SLAVE_NSP_QTB_CFG			41
+#define SLAVE_PCIE_ANOC_CFG			42
+#define SLAVE_QDSS_STM				43
+#define SLAVE_TCU				44
+
+#define MASTER_GEM_NOC_CNOC			0
+#define MASTER_GEM_NOC_PCIE_SNOC		1
+#define SLAVE_AOSS				2
+#define SLAVE_TME_CFG				3
+#define SLAVE_CNOC_CFG				4
+#define SLAVE_DDRSS_CFG				5
+#define SLAVE_BOOT_IMEM				6
+#define SLAVE_IMEM				7
+#define SLAVE_PCIE_0				8
+#define SLAVE_PCIE_1				9
+
+#define MASTER_GPU_TCU				0
+#define MASTER_SYS_TCU				1
+#define MASTER_APPSS_PROC			2
+#define MASTER_GFX3D				3
+#define MASTER_LPASS_GEM_NOC			4
+#define MASTER_MSS_PROC				5
+#define MASTER_MNOC_HF_MEM_NOC			6
+#define MASTER_MNOC_SF_MEM_NOC			7
+#define MASTER_COMPUTE_NOC			8
+#define MASTER_ANOC_PCIE_GEM_NOC		9
+#define MASTER_SNOC_GC_MEM_NOC			10
+#define MASTER_SNOC_SF_MEM_NOC			11
+#define SLAVE_GEM_NOC_CNOC			12
+#define SLAVE_LLCC				13
+#define SLAVE_MEM_NOC_PCIE_SNOC			14
+#define MASTER_MNOC_HF_MEM_NOC_DISP		15
+#define MASTER_ANOC_PCIE_GEM_NOC_DISP		16
+#define SLAVE_LLCC_DISP				17
+#define MASTER_MNOC_HF_MEM_NOC_CAM_IFE_0	18
+#define MASTER_MNOC_SF_MEM_NOC_CAM_IFE_0	19
+#define MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_0	20
+#define SLAVE_LLCC_CAM_IFE_0			21
+#define MASTER_MNOC_HF_MEM_NOC_CAM_IFE_1	22
+#define MASTER_MNOC_SF_MEM_NOC_CAM_IFE_1	23
+#define MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_1	24
+#define SLAVE_LLCC_CAM_IFE_1			25
+#define MASTER_MNOC_HF_MEM_NOC_CAM_IFE_2	26
+#define MASTER_MNOC_SF_MEM_NOC_CAM_IFE_2	27
+#define MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_2	28
+#define SLAVE_LLCC_CAM_IFE_2			29
+
+
+#define MASTER_LPIAON_NOC			0
+#define SLAVE_LPASS_GEM_NOC			1
+
+#define MASTER_LPASS_LPINOC			0
+#define SLAVE_LPIAON_NOC_LPASS_AG_NOC		1
+
+#define MASTER_LPASS_PROC			0
+#define SLAVE_LPICX_NOC_LPIAON_NOC		1
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+#define MASTER_LLCC_DISP			2
+#define SLAVE_EBI1_DISP				3
+#define MASTER_LLCC_CAM_IFE_0			4
+#define SLAVE_EBI1_CAM_IFE_0			5
+#define MASTER_LLCC_CAM_IFE_1			6
+#define SLAVE_EBI1_CAM_IFE_1			7
+#define MASTER_LLCC_CAM_IFE_2			8
+#define SLAVE_EBI1_CAM_IFE_2			9
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_CAMNOC_ICP			1
+#define MASTER_CAMNOC_SF			2
+#define MASTER_MDP				3
+#define MASTER_CDSP_HCP				4
+#define MASTER_VIDEO				5
+#define MASTER_VIDEO_CV_PROC			6
+#define MASTER_VIDEO_PROC			7
+#define MASTER_VIDEO_V_PROC			8
+#define MASTER_CNOC_MNOC_CFG			9
+#define SLAVE_MNOC_HF_MEM_NOC			10
+#define SLAVE_MNOC_SF_MEM_NOC			11
+#define SLAVE_SERVICE_MNOC			12
+#define MASTER_MDP_DISP				13
+#define SLAVE_MNOC_HF_MEM_NOC_DISP		14
+#define MASTER_CAMNOC_HF_CAM_IFE_0		15
+#define MASTER_CAMNOC_ICP_CAM_IFE_0		16
+#define MASTER_CAMNOC_SF_CAM_IFE_0		17
+#define SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_0		18
+#define SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_0		19
+#define MASTER_CAMNOC_HF_CAM_IFE_1		20
+#define MASTER_CAMNOC_ICP_CAM_IFE_1		21
+#define MASTER_CAMNOC_SF_CAM_IFE_1		22
+#define SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_1		23
+#define SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_1		24
+#define MASTER_CAMNOC_HF_CAM_IFE_2		25
+#define MASTER_CAMNOC_ICP_CAM_IFE_2		26
+#define MASTER_CAMNOC_SF_CAM_IFE_2		27
+#define SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_2		28
+#define SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_2		29
+
+#define MASTER_CDSP_PROC			0
+#define SLAVE_CDSP_MEM_NOC			1
+
+#define MASTER_PCIE_ANOC_CFG			0
+#define MASTER_PCIE_0				1
+#define MASTER_PCIE_1				2
+#define SLAVE_ANOC_PCIE_GEM_NOC			3
+#define SLAVE_SERVICE_PCIE_ANOC			4
+
+#define MASTER_GIC_AHB				0
+#define MASTER_A1NOC_SNOC			1
+#define MASTER_A2NOC_SNOC			2
+#define MASTER_GIC				3
+#define SLAVE_SNOC_GEM_NOC_GC			4
+#define SLAVE_SNOC_GEM_NOC_SF			5
+
+#endif
-- 
2.34.1

