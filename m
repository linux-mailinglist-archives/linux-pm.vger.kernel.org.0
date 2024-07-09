Return-Path: <linux-pm+bounces-10830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C55F292B30A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 11:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687D31F22807
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 09:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D97154429;
	Tue,  9 Jul 2024 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cET7FydR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6F727462;
	Tue,  9 Jul 2024 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515775; cv=none; b=ZYS3skT4joyvkehqwuhLcxH3VFvSY/cNTu7REfmjFwcvPFFZjvS+ONR42o+/UeowX3RJdNiMntw5NgwEKYDttirJRxhPcIEkZbixoS8ljzCXWNhwUF5c/U4iondCDaR8zANPBlHR7bnjLVRVUt4j46cFoFSiu4MsMHosPQIf6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515775; c=relaxed/simple;
	bh=neNtOpuW9mjYTt94CSDTndEM+5Zr+OBrr+fQsCkRJ9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNMAOYQTH9eiDkh0mFoEhwKZHSr3wIWUGIE2lyTegg9Q8K5RAaw2aRu1BngQE0XZ6zXQ9hlYONjnj025Z5n3NKNJLgQTou7N9hQ6foKaC/d0D0gN9kok9B2wjaGfVIX7f21yxk1xaG8yY9xYXIcEuAfg+p4vfEjvWm5M65msi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cET7FydR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4691pAG7012241;
	Tue, 9 Jul 2024 09:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0CiZDdUy6XDkSlN1FrTDDtLu9A/BN3HDGKSFgXJNRLk=; b=cET7FydRzlFgfiLp
	zHBvgz93WED0L9nEZ7fxOufkPB4QN1W1ic2K4zWTvVXmGaP0G8uvjBVQM0V5ZCob
	LII5+RIf9+ImQ5LG6gdXlaZLcG4wr83zrveIv4GmlH+zdaSXcIMqANPLfTN5lnlc
	182W8x8cX9CcJ6XGZID/zKK88csuNMSRffkRbmJok7GEqvhzQLcpt31/R/95cbc5
	xUjlpD/FclfqC6fC0PNDzbx7LwNsqtAoOmkAowQF2CUWBCH6hFpw0YunLStTJTgs
	NcQA9y7/z/lNk7sHCya1mb1OJg6QJ11bGnrnJliMUdWSOoOfPxUAP6iecOBjXZJg
	xWQULw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wmmp0y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 09:02:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46992cFf029278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 09:02:38 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 02:02:30 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_rjendra@quicinc.com>, <otto.pflueger@abscue.de>,
        <luca@z3ntu.xyz>, <danila@jiaxyga.com>, <quic_ipkumar@quicinc.com>,
        <stephan.gerhold@kernkonzept.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 6/9] dt-bindings: clock: Add CPR clock defines for IPQ9574
Date: Tue, 9 Jul 2024 14:31:29 +0530
Message-ID: <20240709090132.117077-7-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709090132.117077-1-quic_varada@quicinc.com>
References: <20240709090132.117077-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: duozcgjoz2UV_pHbaBBGUmUX2Qts1_cD
X-Proofpoint-ORIG-GUID: duozcgjoz2UV_pHbaBBGUmUX2Qts1_cD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090060

Add defines for the CPR block present in IPQ9574.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v4: No change
v3: Add Acked-By
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


