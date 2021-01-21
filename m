Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC4F2FE1ED
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 06:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbhAUFnb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 00:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbhAUFeD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 00:34:03 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5868BC0613D6
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 21:33:17 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id o20so856245pfu.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 21:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdF7A3Srp9FLkQoF574fS1ByIlAhbXL+GvTymLUhq4o=;
        b=j4j599fkmm1wQqO8pvw1ky6t5rl5pPGywKQfoUzLZzXDMmctv+jplGU/fAQd+nz3qm
         Cf4UFV8ejFIJ6PHG2o45s1tgnJ/O02LglqKuO8jkxeun/Etf96orKxVaaT4HSXZ4IKdl
         VpwanvepScn+cmjHW8NPwmWp2iwdVihMgS0zx7XyG36OeWp01gCa/XWOoo/16Qb3J+14
         EvW90FsutZ2oKUGGeyA1WwX135wZDPFKe4S731ksArTdGxh4jBcderdx9qefIV6QQiQy
         1mmzxJr9xN1ckYVLxdupqDLdx4L0v4sCSVgcf1Js9eH3jmOaeDnxq5iM290P9vHM/4SW
         GSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdF7A3Srp9FLkQoF574fS1ByIlAhbXL+GvTymLUhq4o=;
        b=AfUai/KAmyXEPvbo/llpYcux7rnMIsj5Z/j2e3HEUea2So7SmOVJHIInPOfcNQSvuM
         l0znOQ2vGkGwU3aB6non1ysUaqryOwzO01McHQvoS6S/dYuVyzMPALL36d9X7DDdUb0n
         qPoCDzo9IBNizezAui/Hh2aPu9UJTriqrBVz2UHFm2qFV9dWk8/2S3OeUehXiTaOiSP5
         CrVTWvzdSpbqFfkOrBUxO/ZmoyCANEcVFOZXAS8nloXkx2XcDahMB6fY7rZ+kNZEhrhj
         y2wgw0U+Tac3o9CcNnvFa8zR2/OpmAPH3lBKbHO6X03/BeUu9T45mvdC2g6iVuglPEWR
         5E/w==
X-Gm-Message-State: AOAM533ds6V2GpnLiPi+dbdMMvyrFl5deI4xAWBGu2JuKAwuRl2pnvX3
        a1/ta/hDf4hiN7jewVEcdyjr
X-Google-Smtp-Source: ABdhPJwGnyS1uQRHUwQq0tA1ZBDNDz634WYemrQBU52WbHfAnZ+Turq03VGJ4rAAfPrHqVcWdOvuIA==
X-Received: by 2002:a62:dd94:0:b029:19e:92ec:722a with SMTP id w142-20020a62dd940000b029019e92ec722amr12894309pff.50.1611207196781;
        Wed, 20 Jan 2021 21:33:16 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6182:23c4:4d5:e6d9:fc7e:c8e2])
        by smtp.gmail.com with ESMTPSA id o14sm4332850pgr.44.2021.01.20.21.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 21:33:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     georgi.djakov@linaro.org, robh+dt@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        okukatla@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: interconnect: Add Qualcomm SDX55 DT bindings
Date:   Thu, 21 Jan 2021 11:02:53 +0530
Message-Id: <20210121053254.8355-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121053254.8355-1-manivannan.sadhasivam@linaro.org>
References: <20210121053254.8355-1-manivannan.sadhasivam@linaro.org>
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
index 000000000000..bfb6524a2d90
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sdx55.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm SDX55 interconnect IDs
+ *
+ * Copyright (c) 2021, Linaro Ltd.
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

