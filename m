Return-Path: <linux-pm+bounces-28892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C07B0ADCA73
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 14:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7931686FC
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 12:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFFA2E06FA;
	Tue, 17 Jun 2025 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T2NW+LZ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E0F2DBF7D;
	Tue, 17 Jun 2025 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162024; cv=none; b=JkNAh48iHnTauVl2fQhY+ys/eZS9A7Bgsns2ibAB/LZQMfFQIRiLZ8ECZnCxe/5BRsKMFvxrWleHxUwTWjDEE/BTtNmRNrWV10odbtkimzmm59N+6w6YFQqRv5SIbcGZVZRLM7T+SAlApg9getQGZIrZy7R5J8LrGt1BYyxmVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162024; c=relaxed/simple;
	bh=CAJx+LDOx8JqdLevmt7vhooCxAIVeiFGGY/qLhy/pew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=sFT2k9uZq76wU2MKfrHa/CI9xFhyvKwOiT75Pw9mDGI6FEJwRHqrgdhmo/bixuoaXE3uDrRHLIOVlpliKuKGsLrSH9k/7XfucKwvqf5Z8n1LqGDsivc5g5T9qGENLihLvaVklNXbAeresNtpv5VuPHlgB3AVBUTgzJQhubwJjvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T2NW+LZ+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H7ZfPb004810;
	Tue, 17 Jun 2025 12:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UX3YuH2coJK3Kbc0/Dp7wWrv+mWUT6cXY++OfYbGZsU=; b=T2NW+LZ+wwcrU319
	HV/IFBmWCY6F0i39DiDyYYB+wdRIAmZszkjZ3vPsZgUsAF5MqUR3IUTrWMU/5rdT
	NAblTsbAGG4fCETLC3X9httqad56bF1fkdFxPJw2S+hovEEq4kdK9k0LiH0TiLx1
	A3MBPb/bRi7kIrVpc3BBLyXeCchlm34hBZkQeTQNNYQBUlvhHTi3JYTQejsI7K4n
	Wl8upEVKfgqMFh02c2UmsTUuHGFkskhYaTdy85S9/VfDEnKuHs1tJR7A4wySy1TL
	m/Jwy8o+7SB1RK/vp4jQYO8CVjBbzG7mz+62I2k0KabnJOJUENiggshrGjd5xv/e
	J8x1VA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791crr2aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 12:06:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55HC6oEF001913
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 12:06:50 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Jun 2025 05:06:44 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 17 Jun 2025 20:06:32 +0800
Subject: [PATCH 1/8] dt-bindings: interconnect: Add Qualcomm IPQ5424 NSSNOC
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250617-qcom_ipq5424_nsscc-v1-1-4dc2d6b3cdfc@quicinc.com>
References: <20250617-qcom_ipq5424_nsscc-v1-0-4dc2d6b3cdfc@quicinc.com>
In-Reply-To: <20250617-qcom_ipq5424_nsscc-v1-0-4dc2d6b3cdfc@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Anusha Rao <quic_anusha@quicinc.com>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>,
        Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750161999; l=1008;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=CAJx+LDOx8JqdLevmt7vhooCxAIVeiFGGY/qLhy/pew=;
 b=ECOqOS6psuO2qI0KdoA0O+TrUnppMQSDIvSWBJAWq5v9UQgylIdFvQ2Wj3WddXnX7MV+aX9BI
 btYwl0YcWunBmN2ok0BYH6iDWz8DOinS6g46DeB7IQX3TOuhvqYN53r
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: miESH52Di3s1u8auhvIrbT8fSBQqYVSc
X-Authority-Analysis: v=2.4 cv=BoedwZX5 c=1 sm=1 tr=0 ts=68515a5b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=h4eZJirXrH8_5HBWN60A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: miESH52Di3s1u8auhvIrbT8fSBQqYVSc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA5NiBTYWx0ZWRfX4CdU82H9YvKK
 n+VCI1muk/HM3fMYFuWPCfxEoB7ckiA7xCBi6UxZpjgDSPsiy9ILpX84vhCHHpHY9BHV6nrHTOU
 8nyQFOfZIjBGYs1s9bGblLWy2s1OlKyK7sig8qe3QK9bxRnV66N9Tpzl3RrNYk47a2cEpGbw/jY
 BO+7jRriAJg/vx9EDTYoociJhvKIGEy3tuxumsnw7lhArpww/MpDwF9KmyjdbW/WZpz/ErcRNNJ
 T6umv4e9YltBDKpk4yJcaCZDTgjlsT7lTH6p2poy+dkAmZsPnr9O9tcjNFO58HoWBxrAIJeadW7
 HrPEisLQZsMXJvmja1dvNivqKG65fqoOujG/yZtzymABidSc/eCdLQb4Olw9ef1r4MZFNwdL6Ry
 0veInaWMg7N5Yyhyf3aSCnFPhCSsjetfM5YqDd3daZJP5oIS/5Qf/nbowoECSSxeb/LEwIbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_05,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170096

Add the NSSNOC master/slave ids for Qualcomm IPQ5424 network
subsystem (NSS) hardware blocks. These will be used by the
gcc-ipq5424 driver that provides the interconnect services
by using the icc-clk framework.

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


