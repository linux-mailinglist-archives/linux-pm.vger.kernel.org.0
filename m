Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9242F27E384
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 10:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgI3IR3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 04:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgI3IR3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 04:17:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF93BC061755
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 01:17:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q4so478308pjh.5
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G3b/9TZP4KyuUfSLZ4D3GzVJ+2+2UC458YcP2ozoLZ8=;
        b=flN1fFtfApFC/bkxXCv20zFmSWwO1q4/yqkAKinOn/DzHcv2Z8Js7M8PA/QhjB2hBM
         tWOUC9mKJ0jDm6khTKIdBCmimYfR3reJ+c/EyumIu5wqD+qr6foM/HdOPIYCcYmOu5b2
         qNfZgw3oGfnUnIYqQ4L8OGKkohiCnvEYtbtYuF24t4PvOMGGQ9mjVYcFyXYDhXJxEYrp
         pYHgTQ8i099VRQ0EQRXqxse6yA2nwQfopXFUY37dL9gHsUkjfUnYWH0NjNyn8mQNMc8L
         tSJTiXc6L8lvHGA6CFb30BSBXTz/3JeelYTNe2FUVefidmG7TIOkyY+/Zn8n6xDMWLLM
         ek0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G3b/9TZP4KyuUfSLZ4D3GzVJ+2+2UC458YcP2ozoLZ8=;
        b=NOhJPDXxAU5Nco0d5wj2n+kGVUTckPFj/+UgNFOOd3lvw4L968fMwLjQRX8TVmA1Sb
         JfHM09RQG0MYvKunTj8OuZc3kyNFJ4O9MS2g+6LlyAgBm6L/Lj2xrCVGzduNMGVHeKBI
         CqJhIJdIkXeDgLxZF1qS/2SaZk3IbBrjaI4zsxRutvpZdGvp1pC2EUbP0ZC92VDrVONR
         ytsCnYC/JcLjFCd8qNyiqgHcCQIlnUxOpcADOUzKN0FYaD2EoqjM6mI2ctN4OSfL8jc+
         1cMjBLKL5ZwUT0vKRVuf/as05PQzYyR1KFj19TBWxEIPw4QCGVrwxw6S4hFvRDrtIFLG
         4EhQ==
X-Gm-Message-State: AOAM5320kEDMfkMsUgcxcp4v7tP+mDPxGXoWG2Fg7zpJSeehQIqWg+ND
        eFwBcuLt+749VLO/fzkYbhSRZA==
X-Google-Smtp-Source: ABdhPJz3Q3E1/tY+t8Q3DnykvxLaJxaOfrDkGdLde7yM50vRXsz97W/fT0SNKioD+mxCURG+6OXL5Q==
X-Received: by 2002:a17:90a:5c83:: with SMTP id r3mr1518847pji.112.1601453848521;
        Wed, 30 Sep 2020 01:17:28 -0700 (PDT)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id q15sm1385345pje.29.2020.09.30.01.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 01:17:27 -0700 (PDT)
From:   Jun Nie <jun.nie@linaro.org>
To:     devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org
Cc:     shawn.guo@linaro.org, Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 4/5] dt-bindings: interconnect: Add Qualcomm MSM8939 DT bindings
Date:   Wed, 30 Sep 2020 16:16:44 +0800
Message-Id: <20200930081645.3434-5-jun.nie@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930081645.3434-1-jun.nie@linaro.org>
References: <20200930081645.3434-1-jun.nie@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm MSM8939 platform has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 .../bindings/interconnect/qcom,rpm.yaml       |   4 +
 .../dt-bindings/interconnect/qcom,msm8939.h   | 105 ++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8939.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index e9f856357822..469db5dc23ef 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -23,6 +23,10 @@ properties:
           - qcom,msm8916-bimc
           - qcom,msm8916-pcnoc
           - qcom,msm8916-snoc
+          - qcom,msm8939-bimc
+          - qcom,msm8939-pcnoc
+          - qcom,msm8939-snoc
+          - qcom,msm8939-snoc-mm
           - qcom,qcs404-bimc
           - qcom,qcs404-pcnoc
           - qcom,qcs404-snoc
diff --git a/include/dt-bindings/interconnect/qcom,msm8939.h b/include/dt-bindings/interconnect/qcom,msm8939.h
new file mode 100644
index 000000000000..c22369a4b9f5
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,msm8939.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm interconnect IDs
+ *
+ * Copyright (c) 2020, Linaro Ltd.
+ * Author: Jun Nie <jun.nie@linaro.org>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8939_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8939_H
+
+#define BIMC_SNOC_SLV			0
+#define MASTER_QDSS_BAM			1
+#define MASTER_QDSS_ETR			2
+#define MASTER_SNOC_CFG			3
+#define PCNOC_SNOC_SLV			4
+#define SLAVE_APSS			5
+#define SLAVE_CATS_128			6
+#define SLAVE_OCMEM_64			7
+#define SLAVE_IMEM			8
+#define SLAVE_QDSS_STM			9
+#define SLAVE_SRVC_SNOC			10
+#define SNOC_BIMC_0_MAS			11
+#define SNOC_BIMC_1_MAS			12
+#define SNOC_BIMC_2_MAS			13
+#define SNOC_INT_0			14
+#define SNOC_INT_1			15
+#define SNOC_INT_BIMC			16
+#define SNOC_PCNOC_MAS			17
+#define SNOC_QDSS_INT			18
+
+#define MASTER_VIDEO_P0			0
+#define MASTER_JPEG			1
+#define MASTER_VFE			2
+#define MASTER_MDP_PORT0		3
+#define MASTER_MDP_PORT1		4
+#define MASTER_CPP			5
+#define SNOC_MM_INT_0			6
+#define SNOC_MM_INT_1			7
+#define SNOC_MM_INT_2			8
+
+#define BIMC_SNOC_MAS			0
+#define MASTER_AMPSS_M0			1
+#define MASTER_GRAPHICS_3D		2
+#define MASTER_TCU0			3
+#define SLAVE_AMPSS_L2			4
+#define SLAVE_EBI_CH0			5
+#define SNOC_BIMC_0_SLV			6
+#define SNOC_BIMC_1_SLV			7
+#define SNOC_BIMC_2_SLV			8
+
+#define MASTER_BLSP_1			0
+#define MASTER_DEHR			1
+#define MASTER_LPASS			2
+#define MASTER_CRYPTO_CORE0		3
+#define MASTER_SDCC_1			4
+#define MASTER_SDCC_2			5
+#define MASTER_SPDM			6
+#define MASTER_USB_HS1			7
+#define MASTER_USB_HS2			8
+#define PCNOC_INT_0			9
+#define PCNOC_INT_1			10
+#define PCNOC_MAS_0			11
+#define PCNOC_MAS_1			12
+#define PCNOC_SLV_0			13
+#define PCNOC_SLV_1			14
+#define PCNOC_SLV_2			15
+#define PCNOC_SLV_3			16
+#define PCNOC_SLV_4			17
+#define PCNOC_SLV_8			18
+#define PCNOC_SLV_9			19
+#define PCNOC_SNOC_MAS			20
+#define SLAVE_BIMC_CFG			21
+#define SLAVE_BLSP_1			22
+#define SLAVE_BOOT_ROM			23
+#define SLAVE_CAMERA_CFG		24
+#define SLAVE_CLK_CTL			25
+#define SLAVE_CRYPTO_0_CFG			26
+#define SLAVE_DEHR_CFG			27
+#define SLAVE_DISPLAY_CFG			28
+#define SLAVE_GRAPHICS_3D_CFG			29
+#define SLAVE_IMEM_CFG			30
+#define SLAVE_LPASS			31
+#define SLAVE_MPM			32
+#define SLAVE_MSG_RAM			33
+#define SLAVE_MSS			34
+#define SLAVE_PDM			35
+#define SLAVE_PMIC_ARB			36
+#define SLAVE_PCNOC_CFG			37
+#define SLAVE_PRNG			38
+#define SLAVE_QDSS_CFG			39
+#define SLAVE_RBCPR_CFG			40
+#define SLAVE_SDCC_1			41
+#define SLAVE_SDCC_2			42
+#define SLAVE_SECURITY			43
+#define SLAVE_SNOC_CFG			44
+#define SLAVE_SPDM			45
+#define SLAVE_TCSR			46
+#define SLAVE_TLMM			47
+#define SLAVE_USB_HS1			48
+#define SLAVE_USB_HS2			49
+#define SLAVE_VENUS_CFG			50
+#define SNOC_PCNOC_SLV			51
+
+#endif
-- 
2.17.1

