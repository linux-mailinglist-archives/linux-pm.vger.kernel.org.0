Return-Path: <linux-pm+bounces-11622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 773D59407C6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 07:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2045F1F23543
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 05:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313E5169382;
	Tue, 30 Jul 2024 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dxV9MUZu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CBC8C0B;
	Tue, 30 Jul 2024 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722318532; cv=none; b=ausgG0ZM0R5doxWY6hbX1UjI22taoGXSfwhwBKciUNTGlQDyRLrRZMJaAy5+cDWv5z3pQljhbtV46OTQAC+vyrgvX9h776ChjyrWFvUEN0KWh375r/VsaZA5fC4WZ0lotxuaUbwfyu0mfKd9PAl5dasoSnaov9unnPEhUkO5BXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722318532; c=relaxed/simple;
	bh=Eqol7SL4+cxSJ2trAoS3fL1wCu/dWzgRAa0+jTTQMhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pa3GnDNGivwNVXy4O34P/pkpswV8UViTdvO0LkSfngcMEe0rhb8TDiVncX5TYOhT9IX3aDZjK64FdHZj1lWZGrD75yXNG+N7Dl0KICS79GbWM9UeHDQBpr9B6aP7JbQlh0jnMrOxpG+UIL/GkJxGXGpqF+jGhUp2gBKcZiJXDuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dxV9MUZu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U0V7Ie022635;
	Tue, 30 Jul 2024 05:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rUuWtYFiSTkqR8yKMC3h9SpZYDS1Z7yhQqO5LoflbCE=; b=dxV9MUZuOGcRpaix
	e2Ft/TSp7fTMRwx9/YC4RI3wk62Sjhb2DaJxOVkuANwTJxTEhX9trE26p4SB8D9j
	k9yuHl6XLmh8fdQiT5LgEUe+Eg0gA1YxQihLpzBcNmHptF+YYNYY3tkIhiV6tnqN
	hEpx3LHYOGRmpnIPNROWglFwG1XoCc5Rv+iSE2Tx9TqjjOh2SYQXf/PLddkjeJDR
	M6vKeqzX1ua1s8APm2KYxdYHlUQ2dGBxi9toTr2A/p0QtQguvQm09O2n+M5+HCye
	Zx+9Ku3481iQf7XKxt6dtHELK2h9LCz5XFKUkp+suSrYc3HtNDIYaeJAcT6vIDKX
	N4TqIg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ms43682q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:48:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46U5meSs030570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:48:40 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Jul 2024 22:48:35 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/5] dt-bindings: interconnect: Add Qualcomm IPQ5332 support
Date: Tue, 30 Jul 2024 11:18:13 +0530
Message-ID: <20240730054817.1915652-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730054817.1915652-1-quic_varada@quicinc.com>
References: <20240730054817.1915652-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: soZgWoQLtZXe_4iBuhOH26SCKc0JZNmY
X-Proofpoint-ORIG-GUID: soZgWoQLtZXe_4iBuhOH26SCKc0JZNmY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_05,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300042

Add interconnect-cells to clock provider so that it can be
used as icc provider.

Add master/slave ids for Qualcomm IPQ5332 Network-On-Chip
interfaces. This will be used by the gcc-ipq5332 driver
for providing interconnect services using the icc-clk
framework.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v4: Add Reviewed-By: Krzysztof

v3: Not taking Reviewed-By: Krzysztof, fixed copy paste error
    INTERCONNECT_QCOM_IPQ9574_H -> INTERCONNECT_QCOM_IPQ5332_H
---
 .../bindings/clock/qcom,ipq5332-gcc.yaml      |  2 +
 .../dt-bindings/interconnect/qcom,ipq5332.h   | 46 +++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq5332.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
index adc30d84fa8f..9193de681de2 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
@@ -31,6 +31,8 @@ properties:
       - description: USB PCIE wrapper pipe clock source
 
   '#power-domain-cells': false
+  '#interconnect-cells':
+    const: 1
 
 required:
   - compatible
diff --git a/include/dt-bindings/interconnect/qcom,ipq5332.h b/include/dt-bindings/interconnect/qcom,ipq5332.h
new file mode 100644
index 000000000000..16475bb07a48
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,ipq5332.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef INTERCONNECT_QCOM_IPQ5332_H
+#define INTERCONNECT_QCOM_IPQ5332_H
+
+#define MASTER_SNOC_PCIE3_1_M		0
+#define SLAVE_SNOC_PCIE3_1_M		1
+#define MASTER_ANOC_PCIE3_1_S		2
+#define SLAVE_ANOC_PCIE3_1_S		3
+#define MASTER_SNOC_PCIE3_2_M		4
+#define SLAVE_SNOC_PCIE3_2_M		5
+#define MASTER_ANOC_PCIE3_2_S		6
+#define SLAVE_ANOC_PCIE3_2_S		7
+#define MASTER_SNOC_USB			8
+#define SLAVE_SNOC_USB			9
+#define MASTER_NSSNOC_NSSCC		10
+#define SLAVE_NSSNOC_NSSCC		11
+#define MASTER_NSSNOC_SNOC_0		12
+#define SLAVE_NSSNOC_SNOC_0		13
+#define MASTER_NSSNOC_SNOC_1		14
+#define SLAVE_NSSNOC_SNOC_1		15
+#define MASTER_NSSNOC_ATB		16
+#define SLAVE_NSSNOC_ATB		17
+#define MASTER_NSSNOC_PCNOC_1		18
+#define SLAVE_NSSNOC_PCNOC_1		19
+#define MASTER_NSSNOC_QOSGEN_REF	20
+#define SLAVE_NSSNOC_QOSGEN_REF		21
+#define MASTER_NSSNOC_TIMEOUT_REF	22
+#define SLAVE_NSSNOC_TIMEOUT_REF	23
+#define MASTER_NSSNOC_XO_DCD		24
+#define SLAVE_NSSNOC_XO_DCD		25
+
+#define MASTER_NSSNOC_PPE		0
+#define SLAVE_NSSNOC_PPE		1
+#define MASTER_NSSNOC_PPE_CFG		2
+#define SLAVE_NSSNOC_PPE_CFG		3
+#define MASTER_NSSNOC_NSS_CSR		4
+#define SLAVE_NSSNOC_NSS_CSR		5
+#define MASTER_NSSNOC_CE_APB		6
+#define SLAVE_NSSNOC_CE_APB		7
+#define MASTER_NSSNOC_CE_AXI		8
+#define SLAVE_NSSNOC_CE_AXI		9
+
+#define MASTER_CNOC_AHB			0
+#define SLAVE_CNOC_AHB			1
+
+#endif /* INTERCONNECT_QCOM_IPQ5332_H */
-- 
2.34.1


