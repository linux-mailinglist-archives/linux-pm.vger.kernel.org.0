Return-Path: <linux-pm+bounces-29655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C95AEB731
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 14:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513AB3A9AA8
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 12:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6D2D8762;
	Fri, 27 Jun 2025 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WIkVDtQv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540032D6600;
	Fri, 27 Jun 2025 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751026237; cv=none; b=LmowHhGrNeasBUjgcAit7V/m2HjFoa3An8wfzNmmW3GloVqe8/J8LgAK2LMRTEvFlNZ5B7LkjFTrww22cX1ILy9wMcNUxUASeY+qcr0obP9C3qmeLSN7QTBP8G0uXe+aKc8kYFwOGLI0cPJw3qj2bn3sMrKI7L966Dxj1C4EcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751026237; c=relaxed/simple;
	bh=xFV0RM7AkP8d52iBvweiGXjqokBrpnLUmoV3FYix4kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YTw+WHUikC8qtWpLv49qTMtxDReBRcFMKKaDVpfjx/eW1E/tP8knaleI+fIiTca2z7P2O4CAOkhyzUggWzhdZMYM3NukwqA5ntuxBfZVYwnMf1Irq2kaWv+sEnFzhT9bO+Al7uwY1IbNkcPgQjebDUDhIKDsmifEZuPF/7sBlcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WIkVDtQv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R4DFFS007903;
	Fri, 27 Jun 2025 12:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FCpI/UT4URHTIiLIQI0B5V0v4oK7YMxxIsEWeLtN2lU=; b=WIkVDtQvoSBmmjH/
	0PYaioJ5hO/IRfLjyEOmDHmx/28mKKa46C0H/cNQuhDP2vzjUzYlll8gQCGZmtxx
	N3Nb0mpclyvzSCDdwBcQTkQwabMp+8xYUN+pMBeYnSAFaeFuerBD91SQD6DUBinM
	MhjD33dCFyFlcqjuiqQQQg5zERFEcHyEW267FLntiyIWOHvEcHcsEP2RYC5m1llS
	pB3SMr6XnJwcmdiU7+D+np/Oyn9hAkFQr2mmxvtAO1aNzVHGUDIrpFnjhtpA7PxB
	gEp+XKOzFqMDUfyYxya+0jBjEENLcW8iq+JbsUjesL1DeYHYmPg7B31W28gQrtqy
	XNNA8A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbhqw4ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 12:10:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55RCAJkS023260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 12:10:19 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 27 Jun 2025 05:10:14 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Fri, 27 Jun 2025 20:09:17 +0800
Subject: [PATCH v2 1/8] dt-bindings: interconnect: Add Qualcomm IPQ5424
 NSSNOC IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250627-qcom_ipq5424_nsscc-v2-1-8d392f65102a@quicinc.com>
References: <20250627-qcom_ipq5424_nsscc-v2-0-8d392f65102a@quicinc.com>
In-Reply-To: <20250627-qcom_ipq5424_nsscc-v2-0-8d392f65102a@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>,
        Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751026208; l=1007;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=xFV0RM7AkP8d52iBvweiGXjqokBrpnLUmoV3FYix4kk=;
 b=uBrp8asd1N3r5J5UHRjT6t7+14zDFQCpnYim3B1+vkoKaK0fU6Bv/H2oR0O864N9lph6GPQ8J
 C9sPtm1XiODB9WJI4QyEn29E/ewvujYmGuSDYIInisS+UVSbnWgsceH
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7b-_Dixg-1x4VyznMfcYIJe0e7Eh7zSj
X-Authority-Analysis: v=2.4 cv=Id+HWXqa c=1 sm=1 tr=0 ts=685e8a31 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=Kx41LZk2Md8-nXejKTUA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 7b-_Dixg-1x4VyznMfcYIJe0e7Eh7zSj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEwMSBTYWx0ZWRfX5aHcsDQIK+7S
 u7/Cft+Np18MBLDV2vup+s5KmWu9NptCawOHeRXcdYm35+vxK6PmRLSgNSMxG3/o6+5cD1Rezw4
 dyhwkslmFcMQuNjkn2Pa7quZfkJE6vKIVX0sxulMglRLF+thBWb7V/bhzZgL2LEY2ct9gpXKw/R
 bGGUbaazcjwBSshslosWTXU8g7w3OLxj33m4riHaYCufVz+lQwRv3d0qT9D5MwqZCtO6jP9HRgZ
 jNb/32wZSwvwW0r3xhN3DaKDXoY9yQfV09ixmIBpnteV3NLyNewAnyflAUivhMgCFmKSu+sbWBN
 +YKcvaWU1PRu4KS3KTh1XIQWlVy4lz3MjLwrC0p6wJ/Z4Fpv5LAbz+w0XDDed2CoXJmReadZQAK
 nJ+qujU6fUtJIZT5o+yDCJJmRqg/71Cf/5xW1vdXz3/dGmxLIA2PdV4VbiDFdz1plM1FWkXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270101

Add the NSSNOC master/slave ids for Qualcomm IPQ5424 network subsystem
(NSS) hardware blocks. These will be used by the gcc-ipq5424 driver
that provides the interconnect services by using the icc-clk framework.

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


