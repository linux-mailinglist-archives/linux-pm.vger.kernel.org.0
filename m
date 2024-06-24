Return-Path: <linux-pm+bounces-9856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA059141B0
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 07:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299271C23118
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 05:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7101717BBF;
	Mon, 24 Jun 2024 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bT45AuwZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EAD22313;
	Mon, 24 Jun 2024 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719205439; cv=none; b=N+4qRZrgDykeI2BIucXt4vM6gJNqwyKt4lQf0q48lEwQo4jvdJcAK8cJr1/JvbGSi54EGp+zWpy2rSGpPtdQ/q4OLIM7Bkwhbfw5/+EVMwP4PGJKS+8RBJbF1AOo8skoZLqBcqP0kP6+EiaNIHeFB6o6U1CKzmAj0VxZbpPT4cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719205439; c=relaxed/simple;
	bh=X8+c0QNezDdxyv0uxBZI7oM11yxWJ95+vOgTvztH54o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sOi5uIShFA7kqBGSdXJ8BwZT5ja9ir2AV3iCOThtM3Q8Np6h/Kj84yhLf5lTbgFXhtrw8t7A/6Sm/gVDef5iid32R+GwnoNuB+voshNwnnEZqEmkRGjX9T+uytf7LfrjT1oeJwNp03UC66L+wxKlQaQ3Br+hrRa5SSeUrsqdgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bT45AuwZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O1rHci023115;
	Mon, 24 Jun 2024 05:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2mB9BnIG7V8RnH1GSnUmOCS+cANnuNIc0+bD1/d+X/A=; b=bT45AuwZ5l7wpqSQ
	vhk+ZxNJYFmID4rUiOwq1I6JKviiBbL+203go/nobKVdHqacfMJ8X+NaXI0tcHZA
	uH3AHttFXdIbnxzLHpKjMeaQ3CeSKmX+UheOg2i4wNDCfxoZINSIVaCYp825AdMu
	694X/TRt8DoY+AZfhuu6st3/P/zgXKB+Xh0Y1HkAIZazgUelqVBjq22MJ+px28Fp
	KcUXdNAzQ3Q5nRyxgXINksoI8YN5+UJ6ywU/jfANTgOzzC0EDTcaAyr56yv/KS7f
	R3uP1ClakiGKpt95fniNsIf1e/rIdB6pxDkT45lPeONSxEJD47Qvg4wgoCCPkEic
	QqFcpg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywkyn2tk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 05:03:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O53oqD026555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 05:03:50 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Jun 2024 22:03:44 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <abel.vesa@linaro.org>, <otto.pflueger@abscue.de>,
        <quic_rohiagar@quicinc.com>, <quic_varada@quicinc.com>,
        <luca@z3ntu.xyz>, <quic_ipkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v2 4/7] dt-bindings: clock: Add CPR clock defines for IPQ9574
Date: Mon, 24 Jun 2024 10:32:51 +0530
Message-ID: <20240624050254.2942959-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624050254.2942959-1-quic_varada@quicinc.com>
References: <20240624050254.2942959-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 48c-huGkIvLOHZSIeV2gyWfSNIk367u1
X-Proofpoint-GUID: 48c-huGkIvLOHZSIeV2gyWfSNIk367u1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240038

Add defines for the CPR block present in IPQ9574.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Add GCC_RBCPR_CLK_SRC define.
    Not adding 'Acked-by: Krzysztof Kozlowski' as the file changed.
---
 include/dt-bindings/clock/qcom,ipq9574-gcc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
index 52123c5a09fa..4c65de04cb7b 100644
--- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
@@ -220,4 +220,6 @@
 #define GCC_PCIE1_PIPE_CLK				211
 #define GCC_PCIE2_PIPE_CLK				212
 #define GCC_PCIE3_PIPE_CLK				213
+#define GCC_RBCPR_CLK_SRC				214
+#define GCC_RBCPR_CLK					215
 #endif
-- 
2.34.1


