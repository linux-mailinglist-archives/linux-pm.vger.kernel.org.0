Return-Path: <linux-pm+bounces-11323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A31C8939D1C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 11:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC07282D3D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 09:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6E214D44F;
	Tue, 23 Jul 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LZfFaIF6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E713B2AF;
	Tue, 23 Jul 2024 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721725425; cv=none; b=urivifZbGvv0vkDg6lLAAqxftfYgpdKH1jNS3R0PeLTRyZI2J8f7CHIMwfxlwVFf61w+0mN1dUiKX6NoWb3D54iCHAhXVO1C2UAN1ODU8uC1vyFnCwcJGveUsl/aRtuVI1N922NP/wVmOwzDulvG2WCzZZJJGAObpATdrwRCbb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721725425; c=relaxed/simple;
	bh=Eqol7SL4+cxSJ2trAoS3fL1wCu/dWzgRAa0+jTTQMhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b17vub6Em5RWTkBW6c8BCHXXKhylWPQwNfx0gUbbQ1QCGLVpwXRqF4XJ+DUJSjLuopAudTLOrNFpj4r5ndMIENmIyjWLn0gnqw8yGLcHbVVrJOro0BVZV52zsu4DBofXDoNsWYInM2eY9tt3qM7O/CAVGdvpN5yRl1Jfew/MFOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LZfFaIF6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N0Xnat013108;
	Tue, 23 Jul 2024 09:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rUuWtYFiSTkqR8yKMC3h9SpZYDS1Z7yhQqO5LoflbCE=; b=LZfFaIF6a1LGzSpm
	6XuwV0V3fCcBVexyXCDlwE5Ml259pU4gC005Z28iF8da3uvtTnyxb4CcdV669ro8
	v0j8I7fTFXxzXDatLk2cfmn4fIcTwPW3S/JtXXLD/CFexsn1R6Ju66xMaTIXSkBu
	xr1ITpr1O0F0lQHmzlw79elXTYpm1RXnUsllpOEIGdWUUdPkvtxi2A/IpOwru83s
	DJ676BX8pZdJmf6LKNGV41OJ3l1j1Dwv2kiQpkr76ia/lixK7mF0Xwdhs0wNADac
	GGzEkWQ9hUmdrCk6XS52dpwr0orjig/vNk9eiIFVq1MON4YGgJK4mSa9lNFMArdd
	PDrVkQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487e6ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:03:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46N93anM032674
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:03:36 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Jul 2024 02:03:30 -0700
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
Subject: [PATCH v4 1/5] dt-bindings: interconnect: Add Qualcomm IPQ5332 support
Date: Tue, 23 Jul 2024 14:33:00 +0530
Message-ID: <20240723090304.336428-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723090304.336428-1-quic_varada@quicinc.com>
References: <20240723090304.336428-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2nUCnKoVTGkE9xF9sr5Kc5O81DT-7Lzc
X-Proofpoint-GUID: 2nUCnKoVTGkE9xF9sr5Kc5O81DT-7Lzc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407230066

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


