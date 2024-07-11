Return-Path: <linux-pm+bounces-10986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB8F92E6CD
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 13:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE1F1F27E5C
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 11:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD20815CD78;
	Thu, 11 Jul 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IGSLfAmS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09259130AFF;
	Thu, 11 Jul 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697589; cv=none; b=tf1RAN5sJaR3CTuai7dmjTuo20RrAzdNtv+L8K++3Sh2ybz+0ItFIbpsRcUDYz9eLYL/LtwT7x6NFMPc7H/un5zsTxC5ihQ03eISjOz7FLhuOcngFLAp5f/4fbH3Kbgy7wXTtWECTPZde1JW8twrgGf0Fy4faI+zE5YQjXjacTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697589; c=relaxed/simple;
	bh=zd776uLEGJYMliUomRDlKs/pOU7/0Nlf4/xioaLxqyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnT6ryPCotovTsevTq9NTcT5dI060NqgqiNsmzMnuXvfW/GxtlzMreC+GBxSBbaAEig5amVgiQvOyGQoclLWAJweRmvfqhRNJt1FKG6318wSiiCtDb+OAIEFDGrjjP1NK8FJl/noWRtsw4WyIj1UFTtIOfQjjC3JXcRwNPuDaLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IGSLfAmS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B503Wb019099;
	Thu, 11 Jul 2024 11:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YGgNKlY7YX6YvxmgOTEHXS41YFSumTsw4rw7RCOQ9kM=; b=IGSLfAmSs6Sq0G3J
	cntj+y7pXmdZz6vs1Jpupmb+v/4tLAp3ZV2kZGsrsKfhcKMhUZ8wVKBcaNnRffhh
	zaiBG8Cj3x5MNcJd/kt79sjGmMCOVIFCu6aMF1qeElnatBuWr4tYKqAnhIXZMVCf
	4WAFUc4cH2lWYfIu0/vkp0Gc2Q9pWz1yTs+Pve2bff7X32cT5r/6n+Ej6P2Ya5ym
	w35WghIwY+2Gf3CbgwiJjVNC2k4ZK2ilMoHOQRch05aXQntonzMeh4vbFaA3fL7v
	XszRkvsZ5ffT4FiI+e2AEZDViBqdlzzSJcWZMPZrF2s3gRNyG4IjtRZSmhdjPSOI
	yVbgIA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40a8uhrxak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 11:33:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BBX1NO009740
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 11:33:01 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Jul 2024 04:32:56 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v2 1/4] dt-bindings: interconnect: Add Qualcomm IPQ5332 support
Date: Thu, 11 Jul 2024 17:02:36 +0530
Message-ID: <20240711113239.3063546-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711113239.3063546-1-quic_varada@quicinc.com>
References: <20240711113239.3063546-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: UMxVMEJZWRBnFRDE3LA8rzpXAu8bLDbX
X-Proofpoint-ORIG-GUID: UMxVMEJZWRBnFRDE3LA8rzpXAu8bLDbX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_06,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110082

Add interconnect-cells to clock provider so that it can be
used as icc provider.

Add master/slave ids for Qualcomm IPQ5332 Network-On-Chip
interfaces. This will be used by the gcc-ipq5332 driver
for providing interconnect services using the icc-clk
framework.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
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
index 000000000000..be4e513bf603
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,ipq5332.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef INTERCONNECT_QCOM_IPQ9574_H
+#define INTERCONNECT_QCOM_IPQ9574_H
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
+#endif /* INTERCONNECT_QCOM_IPQ9574_H */
-- 
2.34.1


