Return-Path: <linux-pm+bounces-28898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF72ADCA97
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 14:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D598917A154
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CB92EACFD;
	Tue, 17 Jun 2025 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gM7SbLhx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4452E424A;
	Tue, 17 Jun 2025 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162062; cv=none; b=eNh0S+9PyWoTejsFCpwpXJibkQQ22SWooUIOM22tggjK3V9KM5SKmqLYZL06fJF2JZ/tZCPPW9UxQiCKTU3lhgofg9LitcX/F4utYz1FCmOoJAc8WCxevgSASwif32UM5rx5f3NXemloCqmMJt5bfOd0BvtXzUcYVbQyQmRNp8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162062; c=relaxed/simple;
	bh=BaJcZTbtyE7iv3X0nNhDOqOJWIsFkeAgkmPMhA0y/hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=R3idSb78F+1dO3EAmHzEvnrXUVSh3JFfrerSM+BQqO+okcOMigOlcP5rxQAwuA9rpKEa99hfHdxYtO5jcY9OzqGkIrSIM2Zl+omuCn351F9Uo3vMiedndl6uKG4gOmtanfwQBRCXa3/RCvK93RrgrJnMNv4FQAlQZ+M75vHaMXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gM7SbLhx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H6e1wh025023;
	Tue, 17 Jun 2025 12:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ANX9zL6s5Cxuaj63jK5tEEAiU9/ZbMfAmEO5y8n8FAU=; b=gM7SbLhx6KB03/ZW
	aVhJOJPzLA9gQuA4Ulste4NvcKX9UZkGvRDeR1/zuxGG1NWFPU+lO+zqK6HG3hNR
	OJmu5knur6Dcn502wXNH7PfAXII81Pxb7pbHRsNoMBFfVdKKU/Kl5GNduQAeImLG
	oS4C85csgdcI3OG0pcp/DQqSGIJ9wU3wK0zS7pmzK+5iyrOXYmn0ebbi5fxPd3j8
	5eI5I+sWaa8zVaX1PvN8SYQAW9s0MK7GLrg/68AawYv0papvV1zCRkL9JiTrvmn6
	LbPljjcLQpLUSAKZaIfgDA/IHPSgaIbTx145JTSife8ur/hKRb/8iYB9UgIL216W
	tTJcfA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791f786cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 12:07:29 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55HC7Srv012049
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 12:07:28 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Jun 2025 05:07:22 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 17 Jun 2025 20:06:39 +0800
Subject: [PATCH 8/8] arm64: defconfig: Build NSS clock controller driver
 for IPQ5424
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250617-qcom_ipq5424_nsscc-v1-8-4dc2d6b3cdfc@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750161999; l=691;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=BaJcZTbtyE7iv3X0nNhDOqOJWIsFkeAgkmPMhA0y/hs=;
 b=rThO/wMeS3ipSysaKWkH45J6KNZ8aEk/PdM2IRCgPjNM3+EcWUOF6PIJUbHQMqUVxbmJOvO3r
 xyEas1rYS9/CmUU0QRKUuRZH5N4R1tOhMr+DbavFRRNmJ+Eax8Wk30h
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA5NiBTYWx0ZWRfX2QffuONYFkUZ
 4rbfzEcQsmJ6WXgSTrDlKQEaBTUIziGJ6O2gg6GQ+a+LKIW/4tsLiL2fTKeiq2G9XMZ2Ap0dFUg
 8FWTS9VEpQ1oKsPSEuXqilBNU7uWRg7y46jaCqPCtztJ6qiq4U7jIq+c1OP+FBN/6IzQldqQ3n0
 xQLN92WA5Q/ub3YrqFWkjAduqkMbicUm3apHjMNNNWok0LLtx3wpl+mYQ1zQoFPUYOoRscokJ88
 UgzO6/1nlh6M/k4WOzX7FDlA/oMXzpVdpUaz+wSwZK2i+exCDXN4bkfjrJc4PfdYN2nUL3F3SBK
 C1Brs3zebmsk+SFZ4O0F7OhtB/RIUmzTaYIVTy4mTaHFDXtcgYd/FaBYulpx15njIpYFcn82FAK
 3wgYyzHgQxgH+Cy/OcZgKKCiREcaIV8OQ2LMyLt93EBi0XMiPZ9QHQ82kQhXigzZ7/QJez0/
X-Proofpoint-GUID: KTGdYXMETixNdbejMxVEwMT2I0sARa2H
X-Proofpoint-ORIG-GUID: KTGdYXMETixNdbejMxVEwMT2I0sARa2H
X-Authority-Analysis: v=2.4 cv=FrIF/3rq c=1 sm=1 tr=0 ts=68515a81 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=RK9YKw_JGFIj7oen8bEA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_05,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=823 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170096

NSS clock controller is needed for supplying clocks and resets
to the networking blocks for the Ethernet functions on the
IPQ5424 platforms.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 897fc686e6a9..f4e4a6d95de4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1363,6 +1363,7 @@ CONFIG_IPQ_GCC_5424=y
 CONFIG_IPQ_GCC_6018=y
 CONFIG_IPQ_GCC_8074=y
 CONFIG_IPQ_GCC_9574=y
+CONFIG_IPQ_NSSCC_5424=m
 CONFIG_IPQ_NSSCC_9574=m
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_MMCC_8994=m

-- 
2.34.1


