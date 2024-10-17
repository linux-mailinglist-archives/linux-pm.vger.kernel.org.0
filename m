Return-Path: <linux-pm+bounces-15892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E639A2B01
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 19:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 760DEB25D41
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 17:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D121DFE06;
	Thu, 17 Oct 2024 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AS5c17nK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1F61DF267
	for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186286; cv=none; b=IMolD4uyQlLrcDYYdM+1N18Hxh+tJxD2hGtbiFZGEky1nQrai9c7SbrVKQXIDv11uSZRnbXwEJK1byWMMcO30ACO2o+9fIxvJ6RYa+T7E9PLBppRuKF/vCRqLNZca1hPJKRJY1GqJCWfJ7Zfokupyb3CEEa/DUo6fm6mOMeWSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186286; c=relaxed/simple;
	bh=0V+kBYbl4k9WVuVGKAVF6uGw02tiQUhx8xQGNzotcqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YGv59bONPzO7lmVxXfUcElJSHFWgrQlEruD/OKB4qNyovmKHbfMU2BDGMmhLqDb00dkJQJnqxW16xyEPXtV7e073oyjbCFNgfhJG7mGrSU7TDOsWK4aXNisQ07F/u3zp4o9N7jXXq5FEjHkPk8QLW36OqIJiVCoJgD1rYyMVPBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AS5c17nK; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e690479cso1438586e87.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729186280; x=1729791080; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBJ7HqX+VstSjF7XQEz435Zo5Da+sJMmcqG+eoCDjJU=;
        b=AS5c17nKGyFztereA7dZKhOUW3wZQARp7HmnuwdgDemjGTMhVGTMfJuP8UvgNwqRnB
         PQ6gUyBnmRRVyswBs8oagKZ/Xdq/ewOQpayIY+d7GQS529q0ihnSa860IzdxZkpXatdA
         2kFbESLckY84vOUfRXQMuMiGcDIeZtp5kXVig6/xeprdG/ufCTKIlLqQISCTkUegXkQ4
         hvsWf1K6AjMOVw7db69xgOy/1At3diTuhPeuJrlE6Tec7x4Dl3f/gD7m7qeHsXEojhwP
         se/Q02xEBA5V9OC6ANEmqA9/rlRWUbdP1/KaAzxhOBq36tJdiYr1LtkJfja/zTqJB9KZ
         cUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729186280; x=1729791080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBJ7HqX+VstSjF7XQEz435Zo5Da+sJMmcqG+eoCDjJU=;
        b=Vr4kidpBJAuZVSHwQZsDJNqRAiWZ0GAD3iiQBy3Tet82OwTRgFu5A1JZl0i/EZl2z/
         rplAoqvsWjgxHdMrO+SnWe79V2ibJFU6Ut7YdDMQbQt8Yz44IsQcNyFlIw2yqihq7may
         oSKd1Ps4FTLq1nFpwk2gs1DvWtnkgiy5jton4Z7U9JwO/A0KKTl6ZTIr3NzoLupWBHaK
         GIOyZa7hSGTA8H8gZP3uny/yF2QIzrEpBA4xUU0xJQecQ39Z0gi6Q3M/qBpFHgubCIkm
         +T8Jel8O7cyoQ2fVCio3LzkTeAXgMETulnnfWDx9xllTgzCFu3lgWqPvSnMfoH8yjBax
         oh6w==
X-Forwarded-Encrypted: i=1; AJvYcCXvIvm1h+C+pdpT6EulREvSmgn4WewXCJSyIXsjWvEQU8uF/FPvV1hfjG1oh4q1fk2EElttlmq08Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqDsAgRAhagxwLe+zi9MvpFMiKdLo7bH2BxMrNNPDl2cUlJNE7
	o2aVcnLMiJxlgdwsby7pdhcW+OPhh1ozgMyA/fxflkkMEVmJ0yFIcGwNqMzHzhU=
X-Google-Smtp-Source: AGHT+IEzRzVMwAFt6qJxffe+eAT0r3GIGz3G/NYaIDbuVZ57h+a1wy5WQQR9ZRRSKI0iJnzqRpj4gQ==
X-Received: by 2002:a05:6512:e9d:b0:539:d0ef:b3f9 with SMTP id 2adb3069b0e04-539e571d4bemr11331570e87.40.1729186279642;
        Thu, 17 Oct 2024 10:31:19 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fffb1a92sm826104e87.101.2024.10.17.10.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 10:31:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 17 Oct 2024 20:31:13 +0300
Subject: [PATCH 1/2] dt-bindings: interconnect: qcom: document SAR2130P NoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-sar2130p-icc-v1-1-bd3a8befa4aa@linaro.org>
References: <20241017-sar2130p-icc-v1-0-bd3a8befa4aa@linaro.org>
In-Reply-To: <20241017-sar2130p-icc-v1-0-bd3a8befa4aa@linaro.org>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8276;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=0V+kBYbl4k9WVuVGKAVF6uGw02tiQUhx8xQGNzotcqk=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEUnihYeVX1WFhwvS/YBU6sa8ykgUegrIsloHj
 R3Ec/PBMJaJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxFJ4gAKCRAU23LtvoBl
 uAF+D/4wrtMflVU32R6GOsSN7/MessQzDXt7id7PLZ4tDiHNkNRHyFpglsNAWF0ThLG3zkeg0g0
 NaP5hjId2DbuuSMcC5cmYVWNK7Tu2IYB70rNKWX81Sza9N0uudyBox6Y+bGNSRQ6PJEkNZcqJYD
 RPbyp+PmSllI1ykMKAOmIBqdUdACTUpS/MKIW911VvBu3hovf1LK9M4to4/w5YIvmxJxM1k7gKf
 BafbPPItoiYWSDhW/O+mo7Pt/5M2C/lpoZpHv+WHRWCKv07FD7u7aimPOxSeuUl/mjwq52flQf0
 EDedSbjKr68kvuNYXK8YzUEgGjtOW05DFbj6FRU3d4443tUSJLtcVvVrVBVAbxEVEDe54zBroKy
 MEFo9Cfz1d6EfyfiLt0PLxFy32CLOdRCO00Ei8mNsAZ9utjMtYoUdnkWVrnGhFMFkOjsl5tWcos
 LcmLSHYc+ta5v6cu/bK4jcMyqqYtiwXaDbk7CTtANpXj/G1EJ7hGSaJw8k6W7fJ1ykw/zIj8psy
 PcKBupyDBK0XC+BqYY64UkIlZVOz2Sdnq5iWzhdwGUiRo/Km/QYEMrmHVG71KF/YEx8J7r3Zhs3
 H1NvkswaxtYpGZ1P0+wAOEY6EixdvqBoVZHPw0phu2vDP2OsnGUW0Lqh+Q+xfbpHAgcP8WF8oxu
 +NFNtkWlE0REQ8A==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add bindings for the Network of Connects (NoC) present on the
Qualcomm SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/interconnect/qcom,sar2130p-rpmh.yaml  | 117 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sar2130p-rpmh.h  | 137 +++++++++++++++++++++
 2 files changed, 254 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sar2130p-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sar2130p-rpmh.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..4647dac740e9b8bf308470255ba92066fb2903c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sar2130p-rpmh.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sar2130p-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SAR2130P
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+  - Georgi Djakov <djakov@kernel.org>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also:: include/dt-bindings/interconnect/qcom,sar2130p-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sar2130p-clk-virt
+      - qcom,sar2130p-config-noc
+      - qcom,sar2130p-gem-noc
+      - qcom,sar2130p-lpass-ag-noc
+      - qcom,sar2130p-mc-virt
+      - qcom,sar2130p-mmss-noc
+      - qcom,sar2130p-nsp-noc
+      - qcom,sar2130p-pcie-anoc
+      - qcom,sar2130p-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sar2130p-clk-virt
+              - qcom,sar2130p-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sar2130p-pcie-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre-NOC PCIe AXI clock
+            - description: cfg-NOC PCIe a-NOC AHB clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sar2130p-system-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre USB3 PRIM AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sar2130p-system-noc
+              - qcom,sar2130p-pcie-anoc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    clk_virt: interconnect-0 {
+      compatible = "qcom,sar2130p-clk-virt";
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre1_noc: interconnect@1680000 {
+      compatible = "qcom,sar2130p-system-noc";
+      reg = <0x01680000 0x29080>;
+      #interconnect-cells = <2>;
+      clocks = <&gcc_prim_axi_clk>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,sar2130p-rpmh.h b/include/dt-bindings/interconnect/qcom,sar2130p-rpmh.h
new file mode 100644
index 0000000000000000000000000000000000000000..aec7cbb7cd7050ae669bdf655ad97241555b00b5
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sar2130p-rpmh.h
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2024, Linaro Ltd.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SAR2130P_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SAR2130P_H
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define SLAVE_QUP_CORE_0			2
+#define SLAVE_QUP_CORE_1			3
+
+#define MASTER_GEM_NOC_CNOC			0
+#define MASTER_GEM_NOC_PCIE_SNOC		1
+#define MASTER_QDSS_DAP				2
+#define SLAVE_AHB2PHY_SOUTH			3
+#define SLAVE_AOSS				4
+#define SLAVE_CAMERA_CFG			5
+#define SLAVE_CLK_CTL				6
+#define SLAVE_CDSP_CFG				7
+#define SLAVE_RBCPR_CX_CFG			8
+#define SLAVE_RBCPR_MMCX_CFG			9
+#define SLAVE_RBCPR_MXA_CFG			10
+#define SLAVE_RBCPR_MXC_CFG			11
+#define SLAVE_CPR_NSPCX				12
+#define SLAVE_CRYPTO_0_CFG			13
+#define SLAVE_CX_RDPM				14
+#define SLAVE_DISPLAY_CFG			15
+#define SLAVE_GFX3D_CFG				16
+#define SLAVE_IMEM_CFG				17
+#define SLAVE_IPC_ROUTER_CFG			18
+#define SLAVE_LPASS				19
+#define SLAVE_MX_RDPM				20
+#define SLAVE_PCIE_0_CFG			21
+#define SLAVE_PCIE_1_CFG			22
+#define SLAVE_PDM				23
+#define SLAVE_PIMEM_CFG				24
+#define SLAVE_PRNG				25
+#define SLAVE_QDSS_CFG				26
+#define SLAVE_QSPI_0				27
+#define SLAVE_QUP_0				28
+#define SLAVE_QUP_1				29
+#define SLAVE_SDCC_1				30
+#define SLAVE_TCSR				31
+#define SLAVE_TLMM				32
+#define SLAVE_TME_CFG				33
+#define SLAVE_USB3_0				34
+#define SLAVE_VENUS_CFG				35
+#define SLAVE_VSENSE_CTRL_CFG			36
+#define SLAVE_WLAN_Q6_CFG			37
+#define SLAVE_DDRSS_CFG				38
+#define SLAVE_CNOC_MNOC_CFG			39
+#define SLAVE_SNOC_CFG				40
+#define SLAVE_IMEM				41
+#define SLAVE_PIMEM				42
+#define SLAVE_SERVICE_CNOC			43
+#define SLAVE_PCIE_0				44
+#define SLAVE_PCIE_1				45
+#define SLAVE_QDSS_STM				46
+#define SLAVE_TCU				47
+
+#define MASTER_GPU_TCU				0
+#define MASTER_SYS_TCU				1
+#define MASTER_APPSS_PROC			2
+#define MASTER_GFX3D				3
+#define MASTER_MNOC_HF_MEM_NOC			4
+#define MASTER_MNOC_SF_MEM_NOC			5
+#define MASTER_COMPUTE_NOC			6
+#define MASTER_ANOC_PCIE_GEM_NOC		7
+#define MASTER_SNOC_GC_MEM_NOC			8
+#define MASTER_SNOC_SF_MEM_NOC			9
+#define MASTER_WLAN_Q6				10
+#define SLAVE_GEM_NOC_CNOC			11
+#define SLAVE_LLCC				12
+#define SLAVE_MEM_NOC_PCIE_SNOC			13
+
+#define MASTER_CNOC_LPASS_AG_NOC		0
+#define MASTER_LPASS_PROC			1
+#define SLAVE_LPASS_CORE_CFG			2
+#define SLAVE_LPASS_LPI_CFG			3
+#define SLAVE_LPASS_MPU_CFG			4
+#define SLAVE_LPASS_TOP_CFG			5
+#define SLAVE_LPASS_SNOC			6
+#define SLAVE_SERVICES_LPASS_AML_NOC		7
+#define SLAVE_SERVICE_LPASS_AG_NOC		8
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_CAMNOC_ICP			1
+#define MASTER_CAMNOC_SF			2
+#define MASTER_LSR				3
+#define MASTER_MDP				4
+#define MASTER_CNOC_MNOC_CFG			5
+#define MASTER_VIDEO				6
+#define MASTER_VIDEO_CV_PROC			7
+#define MASTER_VIDEO_PROC			8
+#define MASTER_VIDEO_V_PROC			9
+#define SLAVE_MNOC_HF_MEM_NOC			10
+#define SLAVE_MNOC_SF_MEM_NOC			11
+#define SLAVE_SERVICE_MNOC			12
+
+#define MASTER_CDSP_NOC_CFG			0
+#define MASTER_CDSP_PROC			1
+#define SLAVE_CDSP_MEM_NOC			2
+#define SLAVE_SERVICE_NSP_NOC			3
+
+#define MASTER_PCIE_0				0
+#define MASTER_PCIE_1				1
+#define SLAVE_ANOC_PCIE_GEM_NOC			2
+
+#define MASTER_GIC_AHB				0
+#define MASTER_QDSS_BAM				1
+#define MASTER_QSPI_0				2
+#define MASTER_QUP_0				3
+#define MASTER_QUP_1				4
+#define MASTER_A2NOC_SNOC			5
+#define MASTER_CNOC_DATAPATH			6
+#define MASTER_LPASS_ANOC			7
+#define MASTER_SNOC_CFG				8
+#define MASTER_CRYPTO				9
+#define MASTER_PIMEM				10
+#define MASTER_GIC				11
+#define MASTER_QDSS_ETR				12
+#define MASTER_QDSS_ETR_1			13
+#define MASTER_SDCC_1				14
+#define MASTER_USB3_0				15
+#define SLAVE_A2NOC_SNOC			16
+#define SLAVE_SNOC_GEM_NOC_GC			17
+#define SLAVE_SNOC_GEM_NOC_SF			18
+#define SLAVE_SERVICE_SNOC			19
+
+#endif

-- 
2.39.5


