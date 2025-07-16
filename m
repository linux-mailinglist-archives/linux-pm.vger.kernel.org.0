Return-Path: <linux-pm+bounces-30923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D460B0795D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 17:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF6A173C6D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3472F363F;
	Wed, 16 Jul 2025 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CgoloWKq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73728D8F2
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678951; cv=none; b=OOstiQhFHgPX5p/q5ACweqOZNLfftTJYfB5qM+AlGCplZnt0vBFHKEiuEXHKAogC3huslA+OlsGKk67IEJn86fWBi+e0YVDsOpaxgzg2TXUQTXokiwTydM3xahc0EZtKQ5VVZuF/T64TIsYMwK6Rg3Zq50OnqPLK7fvGlt5q+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678951; c=relaxed/simple;
	bh=Gn2asDwoBS5Nzl8rR9D8RR0CoBpyqkTjtXGq4H/KB6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=toifh/0r92YKdjCjZ8ZWX0jYFfQ+cr0fkcwJCBUXqvSsjZOQp2yyYUAXE77JZZjf0N4vwTwcBPwtkfthJGyxSBq0AnQrOtR8SpfcV1U7uEH/aUBOdPMrdJ6ncz89I+2B0z3OREIyzB5snwWUPb0FUdQGJRbzaHQg7dcsBkWgHOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CgoloWKq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCsM0w007235
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VfqavrrfdEe
	Zx9RgUfQErKXX7UzQKGQ3dmIvhu35PEE=; b=CgoloWKqy7z2nJ278HOP3hulHQH
	5RAFrPo96IcMvxoZMIc0IfKnrhw2KiWEKccmpsiuaewDeEQWbjYwZl0odBR2+ei5
	ZibPRiknlTjGTCNqJY2DKT1+Ls+FoGDxJN+7UDFiKOnVtFJ3qi3medtfJ+tQwtfU
	h2umG4UN7LvLjBpdilceQ8LOEP4TEUJX+Ae8qnlicswceymrSm0NRtnaNezOAzjb
	GXp8wkMTnQlcKkxciMEJQrW5bsHBEtJu4EcqrbP+DzR0oSh87rsbS855sxEWTqRl
	SEbX2Jm4bXqOloTu55JYYWodTMPMXImFFmXoesySyQN94tC2/5vfCWZX++A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5vnd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:15:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235dd77d11fso71314355ad.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 08:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678948; x=1753283748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfqavrrfdEeZx9RgUfQErKXX7UzQKGQ3dmIvhu35PEE=;
        b=u1aaULk7Ugkk7MQ0lV/5fVSHvKpFC/RnAICWB4rxAULyW+hIUUv4F1Ejve8tkn5lTO
         v8wo5VoauiY73VkaGHt8Huv4S4U28ZaFJrYPoayIFYdlpzCTghd59Olsus0rUGvJroOh
         4aKqLkdiFIOzBtWvdr4PvwlN+j8t37CxXClkXpt81uPaDqrcHhqSIR9eG1uXe7LVpMpQ
         WQIEIPbPV+joWQwWVOVUq9dnYsTO24p9CcqWNv7EyjYWgIVzm8yVvnyEcgnaHEeza9+o
         T6IahkoQNcjMVsv9gapTW3PguP8eajb8thFcIYOms0zUlT7YRDWXGzsySjxyFMxKvTPI
         yqcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBxfQgLb/ydcYOMkiBz+RmtZoGGjwV6UmAlRMRVmgq8R0InbS/DoaHcZoAKO2vWFPZ3d3mMB2QGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWjVRQcSpPeKFiJH/4XbVyqLBZCVp2ka2mxUamtu149d5INuCw
	crzPp9HNGr10SFpOxCQPE9PmcCwV7wZ1XRrhTSyyZROJ8eK/wdlk8cO6xsw+zhywVqIrqde1MKY
	L2n3b7Vs6Me+gQ3DO9ayChMuLQytk0j2FIAnqJUTTPCLFt5RO88biUjO6ZYh2Mw==
X-Gm-Gg: ASbGncv1ELC3xYfUMMB18fbWFlFmk5AzPRnM9vM84K20cI+3V7s2p600w4HfScIOqxA
	BSyxZ0Bv9dKzrm6Iui9J9YLGKdhAnTVWVamYhkMs0WAIg0KHepAah3bCt7odHuUzDr7tuWsz6g3
	q+KpHEYH+nQdOyFx+K+NlqsM6Pz4qO+b/xx68SRdTXYRGFZV3mu01Mkn4vcQ8n8RKyHbzuYCYO+
	wBAo6T7q8DeWSXmE/4zQKi0pl4pVjY38GvQTQcDn8SHtpafm+eyiOdds0xqr10mDFQstlVR/9QB
	2YC7G2FwqG2KBUW4GD3ksO1Zg2UZSw6hgEd/c8KgAMDherPS4gUYXFTuW1v6t4CFDcoxi/G71Hy
	1sGndHIf9uTaxHK/FBQxvGtEdMFL4SadmVfekDxr1zjbzEIlI2edSOXBTv+x6
X-Received: by 2002:a17:902:ef06:b0:235:6f7:b918 with SMTP id d9443c01a7336-23e25730014mr51306855ad.28.1752678948239;
        Wed, 16 Jul 2025 08:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3epPyLcnukqjSiyXM+EDcvrxOcW34VIB2FOeJm3VpgOi6S423OV0G0SgMOIm5T5RZRWCpPg==
X-Received: by 2002:a17:902:ef06:b0:235:6f7:b918 with SMTP id d9443c01a7336-23e25730014mr51306315ad.28.1752678947769;
        Wed, 16 Jul 2025 08:15:47 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad9efsm132769455ad.58.2025.07.16.08.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:15:47 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: djakov@kernel.org, lumag@kernel.org, a39.skl@gmail.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com,
        raviteja.laggyshetty@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Glymur SoC
Date: Wed, 16 Jul 2025 20:45:34 +0530
Message-Id: <20250716151535.4054172-2-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716151535.4054172-1-pankaj.patil@oss.qualcomm.com>
References: <20250716151535.4054172-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=6877c225 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=0n2OPg6v9igEIy7wDKMA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: Tp47MbphSX3OsIZ0W-sBAIxXfyPhEQzg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOCBTYWx0ZWRfXzUVVN/vlIWKv
 75VcDGMllcVlLjMzbd8ZzKlHqz+1+WwxaHag/xViICwuOnGiG6b8LOL5PYRElCaPA2mOaAy1A42
 oIpyZIAe7rlTJvXRRUqTJZc0m+gu01pvOAxdE2kWrQnFWMzDXMn7z6BMU/8kljtLKALwEOvvUMD
 7AjPsA9AXlTMNNjyrhYTbL7Up43w5jCspBu6TReXe27i0rHrB4GDVD1RfFx5sStElk8BXrJwKxp
 +ysfFzWqvElJRqbPm504IlPMFsP/NDFwAPtdETp0MRQBkBACRncL0Jm3FgInszcrzn569p2a5Ep
 A64b/+dP5Dcrjw2EYFLbpJtl5J0EhTscY+f8JIodcPCuWvoQOjuFavypX4Ob6/yrrcRnqJtgzeE
 49+NFqSEysd3clVZ6kgDUhPHuQrSeKmq8DKcgAeA5ERaCzU4Sc9ywHaBNyry8ezmyBE6EPf4
X-Proofpoint-ORIG-GUID: Tp47MbphSX3OsIZ0W-sBAIxXfyPhEQzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160138

From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>

Document the RPMh Network-On-Chip Interconnect in Glymur platform.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 .../interconnect/qcom,glymur-rpmh.yaml        |  84 +++++++
 .../interconnect/qcom,glymur-rpmh.h           | 205 ++++++++++++++++++
 2 files changed, 289 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,glymur-rpmh.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
new file mode 100644
index 000000000000..bcf6a708143b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,glymur-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on GLYMUR
+
+maintainers:
+  - Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also: include/dt-bindings/interconnect/qcom,glymur-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,glymur-aggre1-noc
+      - qcom,glymur-aggre2-noc
+      - qcom,glymur-aggre3-noc
+      - qcom,glymur-aggre4-noc
+      - qcom,glymur-clk-virt
+      - qcom,glymur-cnoc-cfg
+      - qcom,glymur-cnoc-main
+      - qcom,glymur-hscnoc
+      - qcom,glymur-lpass-ag-noc
+      - qcom,glymur-lpass-lpiaon-noc
+      - qcom,glymur-lpass-lpicx-noc
+      - qcom,glymur-mc-virt
+      - qcom,glymur-mmss-noc
+      - qcom,glymur-nsinoc
+      - qcom,glymur-nsp-noc
+      - qcom,glymur-oobm-ss-noc
+      - qcom,glymur-pcie-east-anoc
+      - qcom,glymur-pcie-east-slv-noc
+      - qcom,glymur-pcie-west-anoc
+      - qcom,glymur-pcie-west-slv-noc
+      - qcom,glymur-system-noc
+
+  reg:
+    maxItems: 1
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
+              - qcom,glymur-clk-virt
+              - qcom,glymur-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    clk_virt: interconnect-0 {
+      compatible = "qcom,glymur-clk-virt";
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre1_noc: interconnect@16e0000 {
+      compatible = "qcom,glymur-aggre1-noc";
+      reg = <0x016e0000 0x14400>;
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,glymur-rpmh.h b/include/dt-bindings/interconnect/qcom,glymur-rpmh.h
new file mode 100644
index 000000000000..6993a686da55
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,glymur-rpmh.h
@@ -0,0 +1,205 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_GLYMUR_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_GLYMUR_H
+
+#define MASTER_CRYPTO				0
+#define MASTER_SOCCP_PROC			1
+#define MASTER_QDSS_ETR				2
+#define MASTER_QDSS_ETR_1			3
+#define SLAVE_A1NOC_SNOC			4
+
+#define MASTER_UFS_MEM				0
+#define MASTER_USB3_2				1
+#define MASTER_USB4_2				2
+#define SLAVE_A2NOC_SNOC			3
+
+#define MASTER_QSPI_0				0
+#define MASTER_QUP_0				1
+#define MASTER_QUP_1				2
+#define MASTER_QUP_2				3
+#define MASTER_SP				4
+#define MASTER_SDCC_2				5
+#define MASTER_SDCC_4				6
+#define MASTER_USB2				7
+#define MASTER_USB3_MP				8
+#define SLAVE_A3NOC_SNOC			9
+
+#define MASTER_USB3_0				0
+#define MASTER_USB3_1				1
+#define MASTER_USB4_0				2
+#define MASTER_USB4_1				3
+#define SLAVE_A4NOC_HSCNOC			4
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
+#define SLAVE_AHB2PHY_2				3
+#define SLAVE_AHB2PHY_3				4
+#define SLAVE_AV1_ENC_CFG			5
+#define SLAVE_CAMERA_CFG			6
+#define SLAVE_CLK_CTL				7
+#define SLAVE_CRYPTO_0_CFG			8
+#define SLAVE_DISPLAY_CFG			9
+#define SLAVE_GFX3D_CFG				10
+#define SLAVE_IMEM_CFG				11
+#define SLAVE_PCIE_0_CFG			12
+#define SLAVE_PCIE_1_CFG			13
+#define SLAVE_PCIE_2_CFG			14
+#define SLAVE_PCIE_3A_CFG			15
+#define SLAVE_PCIE_3B_CFG			16
+#define SLAVE_PCIE_4_CFG			17
+#define SLAVE_PCIE_5_CFG			18
+#define SLAVE_PCIE_6_CFG			19
+#define SLAVE_PCIE_RSCC				20
+#define SLAVE_PDM				21
+#define SLAVE_PRNG				22
+#define SLAVE_QDSS_CFG				23
+#define SLAVE_QSPI_0				24
+#define SLAVE_QUP_0				25
+#define SLAVE_QUP_1				26
+#define SLAVE_QUP_2				27
+#define SLAVE_SDCC_2				28
+#define SLAVE_SDCC_4				29
+#define SLAVE_SMMUV3_CFG			30
+#define SLAVE_TCSR				31
+#define SLAVE_TLMM				32
+#define SLAVE_UFS_MEM_CFG			33
+#define SLAVE_USB2				34
+#define SLAVE_USB3_0				35
+#define SLAVE_USB3_1				36
+#define SLAVE_USB3_2				37
+#define SLAVE_USB3_MP				38
+#define SLAVE_USB4_0				39
+#define SLAVE_USB4_1				40
+#define SLAVE_USB4_2				41
+#define SLAVE_VENUS_CFG				42
+#define SLAVE_CNOC_PCIE_SLAVE_EAST_CFG		43
+#define SLAVE_CNOC_PCIE_SLAVE_WEST_CFG		44
+#define SLAVE_LPASS_QTB_CFG			45
+#define SLAVE_CNOC_MNOC_CFG			46
+#define SLAVE_NSP_QTB_CFG			47
+#define SLAVE_PCIE_EAST_ANOC_CFG		48
+#define SLAVE_PCIE_WEST_ANOC_CFG		49
+#define SLAVE_QDSS_STM				50
+#define SLAVE_TCU				51
+
+#define MASTER_HSCNOC_CNOC			0
+#define SLAVE_AOSS				1
+#define SLAVE_IPC_ROUTER_CFG			2
+#define SLAVE_SOCCP				3
+#define SLAVE_TME_CFG				4
+#define SLAVE_APPSS				5
+#define SLAVE_CNOC_CFG				6
+#define SLAVE_BOOT_IMEM				7
+#define SLAVE_IMEM				8
+
+#define MASTER_GPU_TCU				0
+#define MASTER_PCIE_TCU				1
+#define MASTER_SYS_TCU				2
+#define MASTER_APPSS_PROC			3
+#define MASTER_AGGRE_NOC_EAST			4
+#define MASTER_GFX3D				5
+#define MASTER_LPASS_GEM_NOC			6
+#define MASTER_MNOC_HF_MEM_NOC			7
+#define MASTER_MNOC_SF_MEM_NOC			8
+#define MASTER_COMPUTE_NOC			9
+#define MASTER_PCIE_EAST			10
+#define MASTER_PCIE_WEST			11
+#define MASTER_SNOC_SF_MEM_NOC			12
+#define MASTER_WLAN_Q6				13
+#define MASTER_GIC				14
+#define SLAVE_HSCNOC_CNOC			15
+#define SLAVE_LLCC				16
+#define SLAVE_PCIE_EAST				17
+#define SLAVE_PCIE_WEST				18
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
+
+#define MASTER_AV1_ENC				0
+#define MASTER_CAMNOC_HF			1
+#define MASTER_CAMNOC_ICP			2
+#define MASTER_CAMNOC_SF			3
+#define MASTER_EVA				4
+#define MASTER_MDP				5
+#define MASTER_CDSP_HCP				6
+#define MASTER_VIDEO				7
+#define MASTER_VIDEO_CV_PROC			8
+#define MASTER_VIDEO_V_PROC			9
+#define MASTER_CNOC_MNOC_CFG			10
+#define SLAVE_MNOC_HF_MEM_NOC			11
+#define SLAVE_MNOC_SF_MEM_NOC			12
+#define SLAVE_SERVICE_MNOC			13
+
+#define MASTER_CPUCP				0
+#define SLAVE_NSINOC_SYSTEM_NOC			1
+#define SLAVE_SERVICE_NSINOC			2
+
+#define MASTER_CDSP_PROC			0
+#define SLAVE_NSP0_HSC_NOC			1
+
+#define MASTER_OOBMSS_SP_PROC			0
+#define SLAVE_OOBMSS_SNOC			1
+
+#define MASTER_PCIE_EAST_ANOC_CFG		0
+#define MASTER_PCIE_0				1
+#define MASTER_PCIE_1				2
+#define MASTER_PCIE_5				3
+#define SLAVE_PCIE_EAST_MEM_NOC			4
+#define SLAVE_SERVICE_PCIE_EAST_AGGRE_NOC	5
+
+#define MASTER_HSCNOC_PCIE_EAST			0
+#define MASTER_CNOC_PCIE_EAST_SLAVE_CFG		1
+#define SLAVE_HSCNOC_PCIE_EAST_MS_MPU_CFG	2
+#define SLAVE_SERVICE_PCIE_EAST			3
+#define SLAVE_PCIE_0				4
+#define SLAVE_PCIE_1				5
+#define SLAVE_PCIE_5				6
+
+#define MASTER_PCIE_WEST_ANOC_CFG		0
+#define MASTER_PCIE_2				1
+#define MASTER_PCIE_3A				2
+#define MASTER_PCIE_3B				3
+#define MASTER_PCIE_4				4
+#define MASTER_PCIE_6				5
+#define SLAVE_PCIE_WEST_MEM_NOC			6
+#define SLAVE_SERVICE_PCIE_WEST_AGGRE_NOC	7
+
+#define MASTER_HSCNOC_PCIE_WEST			0
+#define MASTER_CNOC_PCIE_WEST_SLAVE_CFG		1
+#define SLAVE_HSCNOC_PCIE_WEST_MS_MPU_CFG	2
+#define SLAVE_SERVICE_PCIE_WEST			3
+#define SLAVE_PCIE_2				4
+#define SLAVE_PCIE_3A				5
+#define SLAVE_PCIE_3B				6
+#define SLAVE_PCIE_4				7
+#define SLAVE_PCIE_6				8
+
+#define MASTER_A1NOC_SNOC			0
+#define MASTER_A2NOC_SNOC			1
+#define MASTER_A3NOC_SNOC			2
+#define MASTER_NSINOC_SNOC			3
+#define MASTER_OOBMSS				4
+#define SLAVE_SNOC_GEM_NOC_SF			5
+
+#endif
-- 
2.34.1


