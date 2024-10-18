Return-Path: <linux-pm+bounces-15933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDB69A389A
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 10:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC2C283B3F
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 08:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD6818EFEB;
	Fri, 18 Oct 2024 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4JBMwe/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01218E76D
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729240416; cv=none; b=K/1+9MNwb3JgI8veIciNiBUTKKZ/qRY7ynsw0YjhAlX/CokU4M9NbL/xgcAP53pTq+r4lubeftWbYy2h6XRw5E9QPF4o9/bmR19l0LqbZK4UoZYUgrA83lySx8KWe+q1KKOYlcTYvf50KAQAD5y21RmtINrTldDP65p6SHb6qkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729240416; c=relaxed/simple;
	bh=gKbBoSWslvU/fFQP9WiuQSnRtO1rW+W3iYKGQbcmeQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RW82VxugO1/Jbm7h/eWB3ni2oCOsR0L/v/FVSU7KIZ07NCAKuW2bfSGozpBe9zWsY2unnS62zUow61sX23i+kiECZx786U6Vf4WyODvnKF3WlyNJjh21tsDabuZNPef+/qCmnz3/mxekBi/avZ5pbhbuu2TgE0jGv4i1eH9I0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i4JBMwe/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so17585701fa.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729240413; x=1729845213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIWm7h0KDiQKxnixqq7/HOzQ1lD4Mko08XNsYT1iQNg=;
        b=i4JBMwe/n1A9UJnbWka2haCzIv3RuEpm8+OhQXDsauwH4vDvTzTDnttPF6hM+ki8kw
         ToUoXxLlVynwSEG1SeY7gtHjF3GxEbW6F3DJVvwMX7PHKLLyHrhs3n5/GToZ6H63g3za
         TKk4F6rTypWSYZ9MfpQR7lWGOpAzbhIJthu/0HN+tvV/4J0P5yj18G1ufbVD3SNPGk5p
         CZkbaktqaCOKOw/29X+Cx7CyJY/IY0VjeoPqvkXvj4TD8EdEAUhTlbHzHHU1Ira7E7th
         ZcH7kjkK1cQhIyxrY2a3eJWxZo6Eqbkt+9fIAcTx5ISxO0NyMqpFd7NnJVe2to9TwDV2
         T6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729240413; x=1729845213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIWm7h0KDiQKxnixqq7/HOzQ1lD4Mko08XNsYT1iQNg=;
        b=eKlyPNyblA8I/uHUIGDwfK/pUlseScCECb0AK10NtLjH23uuQtMN6kvlwbWUPtdIIM
         4KNJhg5lQ8lQRE6sNgeFWWYGnQszdv7ChTNPjUlmnMSePKqsD8sWU1dHlZnJhkec6ijm
         cdid09Us+46NxcFWxgRRC3mUY3iGJywXfYwhhS34jp+kfWx+Tq99bNm6+p94+aPnOUug
         9A0WU+re3xsN16KZCsnvhB6otwC20MHLdUf/PkPMncwcKsoHYx9cqaD9RF2OhUS7zBPe
         LJxm7Dh/kgHixCgZn6NWye6jWrpuznWfiBNHkxTYeGhec+3qGg+Fsn/0kxCK8SbNUQ4N
         rHuA==
X-Forwarded-Encrypted: i=1; AJvYcCXkAtCoNNy58JK05VgLXfSKtEd2Ar55ikFCpxqTL5gCkuNOj+/CTt6fZgOtJxEB8UJNtBvfipZVOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDRnYv8JZtZ5RnFtPO2BAAdMWGN8CZJn0sTvtdgo7RWD1F05sN
	l73NfeYbJSw25RBfoSa7TDQTYetUe5M7ZBYgr265Abk2bBOlHVqbH4aFLQcOg/8=
X-Google-Smtp-Source: AGHT+IH+RgOqYRspz4ZtgpTK1aDSTPyLxGYlBsWv7RVe4IacOMCBAGCi8k7eDC6TGUjshVb827iF+g==
X-Received: by 2002:a05:651c:211d:b0:2fa:cc12:67de with SMTP id 38308e7fff4ca-2fb83208e04mr7562951fa.32.1729240412566;
        Fri, 18 Oct 2024 01:33:32 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb809f9b62sm1628761fa.96.2024.10.18.01.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:33:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 18 Oct 2024 11:33:24 +0300
Subject: [PATCH v2 1/2] dt-bindings: interconnect: qcom: document SAR2130P
 NoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-sar2130p-icc-v2-1-c58c73dcd19d@linaro.org>
References: <20241018-sar2130p-icc-v2-0-c58c73dcd19d@linaro.org>
In-Reply-To: <20241018-sar2130p-icc-v2-0-c58c73dcd19d@linaro.org>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8343;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=gKbBoSWslvU/fFQP9WiuQSnRtO1rW+W3iYKGQbcmeQI=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEh1WF8xuJVh+jamgVGVeb7cFdlqVuXjfqEe4H
 7y3am6+udWJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxIdVgAKCRAU23LtvoBl
 uPDIEACHuPLxKZyBJLhFgsB3LGCR5dcBkkRR/SvAFdshz+JI4RzvUjpobkqmleGd/7OFaLkBnbH
 Lsbb4kAb2O6ebl6hzwXUbHbT1wZ+9uvNlxKpXJqcbdx49FcKo0QnINE05qtkySd7wDbtAlxqx8x
 at7P5TyJTHPsmSedXiixtlk7wPWRVtv40KmN0F8zzKIE4dkd+Vx7DmJBm7jX56DXFWzZ4KLMSoE
 8WPM+pWPDt1Mu1bfuSIeFtGWcvWpjyRHdaC78o0Q8rVGKstfnD4teAlqUYDHupCWTWOh5U6g6qa
 OF8R1xyXHDIeSmPjCAghUc2QqXgHWxNRSM7216fe19KpzeDk9M6J7rlwjE8zXFXEpbLw8iLYAx0
 WXmGFRwPLp5rFZ7g4ckZFYiQVMZB+nJAabc4JsuFZGvM/SsPB7pth7TriYpIao0AT2D6bc5g6XD
 efT4edp+cqC9UJHlbVCF76c/olWUJsBcTZOk2tUxrUXTgOXS1i44Cujk22BonnlvjAXZOYN4T63
 G/QuBZOGYNMazi4Gc173whL8rFDrSmbmb8RfaKtJotd5aZpDp1X3yHHuF3TBXsYlnSBtbCDD7bM
 E9VdokQkX6wJzWISCU+DEXctXdHB4iQ3bO56SPIR/taaHgTSpfTMi92xI1+JbFrQI5lzlZwYfM0
 Gxu6xS9IwYX1iZQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add bindings for the Network of Connects (NoC) present on the
Qualcomm SAR2130P platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


