Return-Path: <linux-pm+bounces-35368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8752CB9FD94
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 16:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2090C7B7AA3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5AD2D6E6E;
	Thu, 25 Sep 2025 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lIbVWS0x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C581E503D;
	Thu, 25 Sep 2025 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809194; cv=none; b=oUQbULQPhCjjdjMTl0+xQBvKNhmcWF/I900+nDvfravv/lkrUJg01aUn3d/HvDIt73QO9yqsm0sr/iz0qTy1ph0U6oEPdlhGDajScEaFNSWBlrxbWjaqy/IZX9fbgr//ZALYpK/xD5XEiGq2Zj078o0uBNv2FsrYjmjn6ZrPP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809194; c=relaxed/simple;
	bh=3kI7v3n2uneHPtTTq+P96g+GGegxV6qWC49TJxH8Jfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CINPwy9OAsGWO7qkCuZMtlSjVnrLzAt4F1dL4O3hZQKVGhg2+o3Ct0cKGP9Bw5D3k3BlcT4OBBFoFOx2PMy3pMoalaMzm/av7wou5202aEOzFHm53z7i2dBUgs0PrPZfWtwrY//lHAOgZHB/9SUVn3F8knimTZFZGmL2J/smP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lIbVWS0x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAUhvM029619;
	Thu, 25 Sep 2025 14:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EK88bIxyb7opoCqG7E3Er3n2due1WnCsiMk8VTgRnkg=; b=lIbVWS0xpT1rwP5t
	HA1VAgPzmoHjRhP1ABGlKCm3EnI57rbsxm2REOADGVeYBWSiZsNyKxBG6DjnbcRC
	hI2QJgr4Yl5SbkzjgCTVcnaIHjjuSdhTYULMtVd+7yZKz5c2EOH0TDlTneHFul7O
	7sqSMMV3wgZr8hQMkNmO8+NowJjfy+LD8j5Sz7UKCA0ojbHadG7OkHdNOyfMRO7W
	9zpiBcadY2rbDUjDaP7xMoAqdk7rraoZL8iq0uJabHmOvqpX2YeRPMBBrNScWk1F
	AqZYY3/TtXmxaZMFDioZN54epVxrs3cgRz6ZZpIwGeWMz7H5fxYgjimruT52ej8d
	e5AM5w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fr7ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 14:06:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58PE68li022731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 14:06:08 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 25 Sep 2025 07:06:02 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 25 Sep 2025 22:05:37 +0800
Subject: [PATCH v6 03/10] dt-bindings: interconnect: Add Qualcomm IPQ5424
 NSSNOC IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250925-qcom_ipq5424_nsscc-v6-3-7fad69b14358@quicinc.com>
References: <20250925-qcom_ipq5424_nsscc-v6-0-7fad69b14358@quicinc.com>
In-Reply-To: <20250925-qcom_ipq5424_nsscc-v6-0-7fad69b14358@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        "Manikanta Mylavarapu" <quic_mmanikan@quicinc.com>,
        Devi Priya
	<quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_suruchia@quicinc.com>, Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758809144; l=1518;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=3kI7v3n2uneHPtTTq+P96g+GGegxV6qWC49TJxH8Jfc=;
 b=DnTbCCp0ejnZVH1RCIPQSN8Dd71lI27GFVYWHDUIDZDRfhEwq06LeC36XNkiZmpq4xfcl2Gps
 jIba0ZOAaiJDp2ndquOigeF9ayIm2XMx1dyryIb37CZbZDR+hgd8S0+
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UsR0FuEcIvf_hVMeDDiYv3U-QA1BbTFf
X-Proofpoint-GUID: UsR0FuEcIvf_hVMeDDiYv3U-QA1BbTFf
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d54c52 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8
 a=Qcuqu0ky38DJWFOqejsA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX4N4tci+qleZE
 nf+sK0VYGDbDGcPD5Ng65jpxOb5LPtMB1FORYPQbeFJ/qvkDsxdZSwey408bke5vfSrAZrpQT2S
 OePsLpTmNy9cugy6Hdtxj0PQFhIdSxdHNuRjYwuBzxkp9Qkw3PTkLmJSDYr5s4InWgxPKfGyszF
 u+PNnkxU9W+1fhtfapOB2JLoLmkgbLwvdNT0xkFeKMFWfHiidqhH9ot2JMnZe5X6QRMVJhzZHpm
 /P4lMcDoPBra+8aDMqWfVdFwcoDEt8DrTRNOGv0RSmihVhlrOp+9BVYeTZrOOCCalL6Noi5lTO1
 K0ffjxF3CojBXM95PsW2JRTxtEb8QWmQkoICnLcnvfl4mlfv9klTn0cGuqxmM9qyNGlRfaSsgIX
 jxjrqPxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

Add the NSSNOC master/slave ids for Qualcomm IPQ5424 network subsystem
(NSS) hardware blocks. These will be used by the gcc-ipq5424 driver
that provides the interconnect services by using the icc-clk framework.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 include/dt-bindings/interconnect/qcom,ipq5424.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/dt-bindings/interconnect/qcom,ipq5424.h b/include/dt-bindings/interconnect/qcom,ipq5424.h
index afd7e0683a24..c5e0dec0b300 100644
--- a/include/dt-bindings/interconnect/qcom,ipq5424.h
+++ b/include/dt-bindings/interconnect/qcom,ipq5424.h
@@ -20,6 +20,26 @@
 #define SLAVE_CNOC_PCIE3		15
 #define MASTER_CNOC_USB			16
 #define SLAVE_CNOC_USB			17
+#define MASTER_NSSNOC_NSSCC		18
+#define SLAVE_NSSNOC_NSSCC		19
+#define MASTER_NSSNOC_SNOC_0		20
+#define SLAVE_NSSNOC_SNOC_0		21
+#define MASTER_NSSNOC_SNOC_1		22
+#define SLAVE_NSSNOC_SNOC_1		23
+#define MASTER_NSSNOC_PCNOC_1		24
+#define SLAVE_NSSNOC_PCNOC_1		25
+#define MASTER_NSSNOC_QOSGEN_REF	26
+#define SLAVE_NSSNOC_QOSGEN_REF		27
+#define MASTER_NSSNOC_TIMEOUT_REF	28
+#define SLAVE_NSSNOC_TIMEOUT_REF	29
+#define MASTER_NSSNOC_XO_DCD		30
+#define SLAVE_NSSNOC_XO_DCD		31
+#define MASTER_NSSNOC_ATB		32
+#define SLAVE_NSSNOC_ATB		33
+#define MASTER_CNOC_LPASS_CFG		34
+#define SLAVE_CNOC_LPASS_CFG		35
+#define MASTER_SNOC_LPASS		36
+#define SLAVE_SNOC_LPASS		37
 
 #define MASTER_CPU			0
 #define SLAVE_L3			1

-- 
2.34.1


