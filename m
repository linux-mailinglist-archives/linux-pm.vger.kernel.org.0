Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDE22FCC62
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 09:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbhATIJo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 03:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730346AbhATIJV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 03:09:21 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6042C06179B
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 00:06:46 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id o20so5603827pfu.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 00:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQk462ZrxRaZihzXHMR1S5iNVW4hb2empx8cTYl9lzo=;
        b=qWxyo2K9mJcwrhPUU5T8c6zJFSw0JKvQa675Bk0ZCcBhbrkOeNIf1hbsvORP45je8Y
         feqlsLVmPkxrfF4fLdFI+ctUexdYyi91pdg1j2VtswPk59UCegz8Lju4HvtTt+GFAPEu
         AL5wuZmmXR3icqeNWlfpmskY6X0ayqa/vCcOp1FEs5iMJJt35613ehsBGMnZQvwoDW3i
         WNxAdT6oKXyt3T8tZKgk9gZH2en3swsRjkx0M2kYFlTvbNQe44qXRHn5y93ww+9UmlNL
         LN4wtoeTB7erl7TmajdZlXGrRb8kMlab9xGsCOvkPYHBxN3+DuNWwLa9XTnYEd4s+mzQ
         PKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQk462ZrxRaZihzXHMR1S5iNVW4hb2empx8cTYl9lzo=;
        b=L/Tfeyztqw2U+NbS4yFhAXnW66Mx3d2jjBVGMhV+IcRaFLg4FQW3O68Y3oK8sWoiQN
         /UdoOFoC59XXnJtgeBXsyYlRrtTwoHT/oznbzQCyG43Eid+P/MHCUXgglejECuy44YHY
         z8ppDsFs0tqtZuQ5v2TcsJjTSqUA/h95vERQCP7Jl7+JuaUfGUDhvgWrwN6Eu9p9r6Q5
         N+a8MxKM3D8qt1UHiukfbUj4oPiEjIjFkBne9Zf9c0cNs64OCCcfRSKwdt8ttV6kwNQF
         Hf1i5wYqXUUe5Quh1+nFtpwJuohxIcD7LUubDiuK6dYHsipe7Pn4dM5U8IXoXGDIty4Z
         638A==
X-Gm-Message-State: AOAM533I5mM4JekuOYGptlET/FEP8fIMZaYcURYnNiuN4Wb0D9/5V6es
        6CV2wH6GK9DvxWWP+B6lIgzu
X-Google-Smtp-Source: ABdhPJxWrj2PNQO0qiPT6/pCF1p+En6aDmwk50Ux/SxZ9KvumJwPxnXut5JijxoQjFeymeK1C8La2A==
X-Received: by 2002:a63:4d41:: with SMTP id n1mr8251304pgl.147.1611130006249;
        Wed, 20 Jan 2021 00:06:46 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6d85:48cc:b166:aab7:ff85:2769])
        by smtp.gmail.com with ESMTPSA id y1sm1324040pff.17.2021.01.20.00.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 00:06:45 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     georgi.djakov@linaro.org, robh+dt@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        okukatla@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SDX55 DT bindings
Date:   Wed, 20 Jan 2021 13:36:26 +0530
Message-Id: <20210120080627.20784-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120080627.20784-1-manivannan.sadhasivam@linaro.org>
References: <20210120080627.20784-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SDX55 platform has several bus fabrics that could be
controlled and tuned dynamically over RPMh according to the bandwidth
demand.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/interconnect/qcom,rpmh.yaml      |  4 +
 include/dt-bindings/interconnect/qcom,sdx55.h | 76 +++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,sdx55.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 30c2a092d2d3..f9b150b817d8 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -45,6 +45,10 @@ properties:
       - qcom,sdm845-mem-noc
       - qcom,sdm845-mmss-noc
       - qcom,sdm845-system-noc
+      - qcom,sdx55-ipa-virt
+      - qcom,sdx55-mc-virt
+      - qcom,sdx55-mem-noc
+      - qcom,sdx55-system-noc
       - qcom,sm8150-aggre1-noc
       - qcom,sm8150-aggre2-noc
       - qcom,sm8150-camnoc-noc
diff --git a/include/dt-bindings/interconnect/qcom,sdx55.h b/include/dt-bindings/interconnect/qcom,sdx55.h
new file mode 100644
index 000000000000..daa8cd4f21f6
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sdx55.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm SDX55 interconnect IDs
+ *
+ * Copyright (c) 2020, Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SDX55_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SDX55_H
+
+#define MASTER_LLCC			0
+#define SLAVE_EBI_CH0			1
+
+#define MASTER_TCU_0			0
+#define MASTER_SNOC_GC_MEM_NOC		1
+#define MASTER_AMPSS_M0			2
+#define SLAVE_LLCC			3
+#define SLAVE_MEM_NOC_SNOC		4
+#define SLAVE_MEM_NOC_PCIE_SNOC		5
+
+#define MASTER_AUDIO			0
+#define MASTER_BLSP_1			1
+#define MASTER_QDSS_BAM			2
+#define MASTER_QPIC			3
+#define MASTER_SNOC_CFG			4
+#define MASTER_SPMI_FETCHER		5
+#define MASTER_ANOC_SNOC		6
+#define MASTER_IPA			7
+#define MASTER_MEM_NOC_SNOC		8
+#define MASTER_MEM_NOC_PCIE_SNOC	9
+#define MASTER_CRYPTO_CORE_0		10
+#define MASTER_EMAC			11
+#define MASTER_IPA_PCIE			12
+#define MASTER_PCIE			13
+#define MASTER_QDSS_ETR			14
+#define MASTER_SDCC_1			15
+#define MASTER_USB3			16
+#define SLAVE_AOP			17
+#define SLAVE_AOSS			18
+#define SLAVE_APPSS			19
+#define SLAVE_AUDIO			20
+#define SLAVE_BLSP_1			21
+#define SLAVE_CLK_CTL			22
+#define SLAVE_CRYPTO_0_CFG		23
+#define SLAVE_CNOC_DDRSS		24
+#define SLAVE_ECC_CFG			25
+#define SLAVE_EMAC_CFG			26
+#define SLAVE_IMEM_CFG			27
+#define SLAVE_IPA_CFG			28
+#define SLAVE_CNOC_MSS			29
+#define SLAVE_PCIE_PARF			30
+#define SLAVE_PDM			31
+#define SLAVE_PRNG			32
+#define SLAVE_QDSS_CFG			33
+#define SLAVE_QPIC			34
+#define SLAVE_SDCC_1			35
+#define SLAVE_SNOC_CFG			36
+#define SLAVE_SPMI_FETCHER		37
+#define SLAVE_SPMI_VGI_COEX		38
+#define SLAVE_TCSR			39
+#define SLAVE_TLMM			40
+#define SLAVE_USB3			41
+#define SLAVE_USB3_PHY_CFG		42
+#define SLAVE_ANOC_SNOC			43
+#define SLAVE_SNOC_MEM_NOC_GC		44
+#define SLAVE_OCIMEM			45
+#define SLAVE_SERVICE_SNOC		46
+#define SLAVE_PCIE_0			47
+#define SLAVE_QDSS_STM			48
+#define SLAVE_TCU			49
+
+#define MASTER_IPA_CORE			0
+#define SLAVE_IPA_CORE			1
+
+#endif
-- 
2.25.1

