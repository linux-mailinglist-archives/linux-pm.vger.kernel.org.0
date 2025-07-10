Return-Path: <linux-pm+bounces-30567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B03BB001C4
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48A11CA01C3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E00425BEF8;
	Thu, 10 Jul 2025 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AOEKy8C/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89B42566F5;
	Thu, 10 Jul 2025 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150556; cv=none; b=Hyn0x1oUsLhjA76Mby5QYaD5F8Gu6ENGpt2mZ7mwz2X7ZX9gqoVwtd/KB3o6+XVNhqsBrg9S5pk+aUqFriKWGerO2u74IpT32CNnD3DqVbXFxWGgTBsnKVUvgOhtRZ92S29kKT1/VBck58/zXqnB22gk9jLOHckkseQE0BtnQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150556; c=relaxed/simple;
	bh=4StWH583lOfHFJ5uNKlyBTyXhHWcT1DqfFeFzXKqFvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=drTmXnNNfWAuKrKtqPIQJu2G7wUwiQOI1Wl8w35zUBbXMPp23dDZUHZ2guL9X3x4CQVRhLdBLrQztmjUJpc5Ska/0TL3k+9Dfke+/X+Oc0HFoM1CAbwBiD3iI1kRpw0Jtohtqp2aeZIQDdDdElucfKk7Y6qHWy/DaZ6NBf5yNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AOEKy8C/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9SY2h031898;
	Thu, 10 Jul 2025 12:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mVHYHvNUgKZ7MDjuKxvYt8ATMUGf0V+IozVt+PsAQLI=; b=AOEKy8C/+kLfonCC
	aDVQLxCOsVssbR8Wg1+vXMF9/cVECiIzzQXbWGt/mT26d/qPAhSpRKZ61dpJi4WZ
	WhRWnMcQz+7dZqT4IM/9DMo75xMkjGuhxuPuEG40BTO1N90XPDf3MVqe03ZNUnAU
	Zm5KqTx1nIxTpqH37Fi8S00aWPuS66geUEWvs6JJUfJNyyPtWi7FEnvr14CSMklv
	oanVskphkpEDh8QL0sn1as8xnARpoeR2QcAN6ec6zHhiV1/lHr/MTqwMYQWbtV/2
	MzbARcH67FVGZoj1MiT1zGax1iqCowh/5vdL4rBqlXZZvyGq60ur7OeHqpDwuSWC
	DwFb5Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pw7qyhb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 12:29:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56ACT0L1019632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 12:29:00 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 10 Jul 2025 05:28:54 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 10 Jul 2025 20:28:09 +0800
Subject: [PATCH v3 01/10] dt-bindings: interconnect: Add Qualcomm IPQ5424
 NSSNOC IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250710-qcom_ipq5424_nsscc-v3-1-f149dc461212@quicinc.com>
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
In-Reply-To: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Anusha Rao
	<quic_anusha@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_suruchia@quicinc.com>,
        Luo Jie
	<quic_luoj@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752150527; l=1071;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=4StWH583lOfHFJ5uNKlyBTyXhHWcT1DqfFeFzXKqFvE=;
 b=7eF5zqshE9nngkrhrhj+688HyXc2mX48G6y3z+Pnb9P8sLPFys+csKCY2SztB4UoiBu1Xh6+D
 MhhgqnWImO6AhDAQS0c1XiG1fQhcXm8+Kecnj2vN6zP9ypZoBTnJGEf
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwNiBTYWx0ZWRfX8D3Nk5Y/muUV
 0avonEe5egZk8abMYviskKClFuzXToVwOBFCWiN5d9cgg1PtOpc3EQSHtZD3Te91i0iu+NdIZWf
 Tx8ZVprvaA/sGLJgZL1i1nU7FEA70niZT8h7YMlAtuokur5YJHgYYrgunRHX16JCWsr/OkTRy+4
 PmiLNtiLC8yjIDDVcLHGzdLhtG43aOSuo/5C7TRBV5lkS2nxWqapZVybECiymGKDoXVgC2ksFiI
 4lTYU+rAdbAnwI8wOvnkx/FPS4bjmZ2AJcHGEo5U93W9+pZtIuo2ccOrJlWWls3wnAECSdji03J
 e9+j/uIW2TKN4OzSjY1AOcg0hqAIrEBdinQ6BFMIIB9nM62O/IAbBwzC1k+TOCBG1aY+6JMJIV0
 p2wf9YuJgHn8tmOZHosTWyuzVvVB/s7W8Wb4i6ZAzQALqTECJyFCsf3VBhSXvsde06Tb5eeM
X-Proofpoint-GUID: I13aIZFI8XQZyZ_ZoiUT41nZsVkB2c09
X-Proofpoint-ORIG-GUID: I13aIZFI8XQZyZ_ZoiUT41nZsVkB2c09
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686fb20e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=Qcuqu0ky38DJWFOqejsA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100106

Add the NSSNOC master/slave ids for Qualcomm IPQ5424 network subsystem
(NSS) hardware blocks. These will be used by the gcc-ipq5424 driver
that provides the interconnect services by using the icc-clk framework.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 include/dt-bindings/interconnect/qcom,ipq5424.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/interconnect/qcom,ipq5424.h b/include/dt-bindings/interconnect/qcom,ipq5424.h
index a770356112ee..66cd9a9ece03 100644
--- a/include/dt-bindings/interconnect/qcom,ipq5424.h
+++ b/include/dt-bindings/interconnect/qcom,ipq5424.h
@@ -20,5 +20,11 @@
 #define SLAVE_CNOC_PCIE3		15
 #define MASTER_CNOC_USB			16
 #define SLAVE_CNOC_USB			17
+#define MASTER_NSSNOC_NSSCC		18
+#define SLAVE_NSSNOC_NSSCC		19
+#define MASTER_NSSNOC_SNOC_0		20
+#define SLAVE_NSSNOC_SNOC_0		21
+#define MASTER_NSSNOC_SNOC_1		22
+#define SLAVE_NSSNOC_SNOC_1		23
 
 #endif /* INTERCONNECT_QCOM_IPQ5424_H */

-- 
2.34.1


