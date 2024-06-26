Return-Path: <linux-pm+bounces-10043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F46917E86
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 12:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E96B24627
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3126D18132B;
	Wed, 26 Jun 2024 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B76ZUJa+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFDC17C211;
	Wed, 26 Jun 2024 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398499; cv=none; b=oTSyojxzmlrR30LJDQZcFQtGeutgiJ8cHgrW/xCQqLKjAaurdH+sRwUTOvG9F/xYyu5JCgc1YJ8QoHNPLcTt9TDK4retRGFB3e59RX2enHPFfrvclLeMDlYMeO9NtPFQV4O3yl6xatxdDLVKkJ3Opm0p53337+IoV0Z1eHw33Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398499; c=relaxed/simple;
	bh=J1gffr4jXgmOu33tiJxbcfBTtJ1UwG6NyjHek4C93Q8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cn3N2A9jbm0YcAmf+2fW1K0XqW0YLeM3qElxzgfgZ/vZAh09MGKRIOphq17GmF0GiR8DVx7dJZLMSxESoFBPtjmGiBcTXoOkHDbZlT5tc1gC0HPRjQI5pZRGYfcm5B3CgKckAFwnJ1R9IdIjDMyFQZ3roehsJQHZtquaNp8Enac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B76ZUJa+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfSjs029233;
	Wed, 26 Jun 2024 10:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	huZrcyVjbWEBf8x/NmnZfKfM341++kHrStQyv3DUnXU=; b=B76ZUJa+IjcMp7NR
	zHtI8SP2qQMtRnp5u/zw0wix3L/s42oiwkh9eLpwljLmGl/BiF6ir5Ni2kGvbbNp
	/k1jpcHiQ2j9NSkSdP3MpSZCW5RN6xujaQZjoJrkeIY5aCtUcNwRSj+st1OBIoi9
	+nOTZW6gsfRmgyR8fqunr4yR/uMhL/rzBXai21rGq49izx68VDVqaBspeRLFpJA4
	9cjUE/GPuBuiFcPhd6r/4wJ44po8crsaPphjTfNICnULLq4VaIeivEdrjE410yvo
	Y1lBKSbr6U3M3877XPKxpUNFTM8qIHC1dYdHDtWTCWFr9G2Y6liANHlSuHfpCfE2
	27yflw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6s1qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:41:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QAfItI029896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:41:18 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 03:41:10 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <otto.pflueger@abscue.de>,
        <neil.armstrong@linaro.org>, <luca@z3ntu.xyz>, <abel.vesa@linaro.org>,
        <danila@jiaxyga.com>, <quic_varada@quicinc.com>,
        <quic_ipkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 6/9] dt-bindings: clock: Add CPR clock defines for IPQ9574
Date: Wed, 26 Jun 2024 16:09:59 +0530
Message-ID: <20240626104002.420535-7-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626104002.420535-1-quic_varada@quicinc.com>
References: <20240626104002.420535-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: zOhu0xKh8o8qYWx_1o6LPw0D4i8b63mg
X-Proofpoint-ORIG-GUID: zOhu0xKh8o8qYWx_1o6LPw0D4i8b63mg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260081

Add defines for the CPR block present in IPQ9574.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


