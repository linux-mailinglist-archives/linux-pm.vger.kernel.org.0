Return-Path: <linux-pm+bounces-9644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A172190FE87
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 10:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274A7283B3F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 08:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32E718E756;
	Thu, 20 Jun 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RFLWzpUQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1818A958;
	Thu, 20 Jun 2024 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871354; cv=none; b=gi+fN2QgbkCcmJwz/4cbI2RUj7iEw5fKMvYlFnJ91mirk54e22yAp38B/fyftaTBx2Ng7JhjTd1rZTtUnq55fXG1FBQFL68Aw67ObD6Qns38UfAmiAOciuXmG3nSpJdZw0A4/ry0y6ShnorvUjX9i3p/aQc8zfrgkdG+VqORQk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871354; c=relaxed/simple;
	bh=aja2+bf0P3Zyq63FCGEBRcJF+7oow5KvNhww2dSQPMw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCKf85Xjj1cy1+ea8O2bXj8cvyWVOOSiirBLicsVlKJzVemqVHKSYr7B+5F07kMW6xUDnpSKIgUKCa56sDxyaCKfDMktiSYZAzWc7SV7H71qcP8pQXu1vPnxcLpw9W0GnqWvYTpLUEOks95NTS1IzoAr1UtJRtLb9E+hJcZMmlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RFLWzpUQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K4b0Ia030809;
	Thu, 20 Jun 2024 08:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SjbMpg7fS6E8s6twjGEDzqxpwuphU8bqbp80s4EiMAg=; b=RFLWzpUQbLFT8PR3
	frF4Yyk7P8Eh1ASz57qmlmcbVcBHI1NHCxKunS57GgxWFgcD2f6hEcWB7lBIFFO8
	KGJKAyHYa90nVqTfX1oF7/N0caRBNX0cj/XVx5DBanj/rQ4f42uiygjWA/xAh/5w
	mgYzX0Z+ZN68tHlZw7KJFJUYiYyH3CVsGJ86uX5KsTWFhkdx8REuwP4DBFke8/s/
	envzzJ/rxvS4rj7Gv+KRMXoVANFwavKK4bU13rbBMHSuzU/40gGBwyds1/nr/RHQ
	Sz3islhtOPbQsgsBfucp4vcmg9GaxNSkB8ncSEQxNMC1yVFEXZTWmbHp8nwVIbwt
	K+Q5hw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yux152dpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:15:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45K8FYtt001531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:15:34 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Jun 2024 01:15:28 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <quic_rjendra@quicinc.com>, <luca@z3ntu.xyz>, <abel.vesa@linaro.org>,
        <quic_varada@quicinc.com>, <quic_rohiagar@quicinc.com>,
        <danila@jiaxyga.com>, <otto.pflueger@abscue.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v1 4/7] dt-bindings: clock: Add CPR clock defines for IPQ9574
Date: Thu, 20 Jun 2024 13:44:24 +0530
Message-ID: <20240620081427.2860066-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620081427.2860066-1-quic_varada@quicinc.com>
References: <20240620081427.2860066-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: pFJ-Qu1Kqwk3gj2Pbd9T6FY2kFkee0wU
X-Proofpoint-ORIG-GUID: pFJ-Qu1Kqwk3gj2Pbd9T6FY2kFkee0wU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_04,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200058

Add defines for the CPR block present in IPQ9574.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 include/dt-bindings/clock/qcom,ipq9574-gcc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
index 52123c5a09fa..b7bededc442f 100644
--- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
@@ -220,4 +220,5 @@
 #define GCC_PCIE1_PIPE_CLK				211
 #define GCC_PCIE2_PIPE_CLK				212
 #define GCC_PCIE3_PIPE_CLK				213
+#define GCC_RBCPR_CLK					214
 #endif
-- 
2.34.1


