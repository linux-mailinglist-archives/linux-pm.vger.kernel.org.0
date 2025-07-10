Return-Path: <linux-pm+bounces-30571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B83E9B001DD
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516B01C8585A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAA12E7654;
	Thu, 10 Jul 2025 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XjOzsJkI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CC5257AC7;
	Thu, 10 Jul 2025 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150573; cv=none; b=PqnOcquqouyDBqITFuBhZgTWeuMqv36snVp7lECGYsSVvIuLeGjXl96cJv1yMf4fDlr/eZrB4Uz/yXWrC5wZL5FnOdPOOkLU377wzKR64ndeSYchnoBJ0yPgiuCDIJdt9MfZ6MpiVMTGBK1+sP0oJGlbzQePJEq+rvNxDlmZDvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150573; c=relaxed/simple;
	bh=0eAemDEX8aqWbx88zJPszW13Z9Wymz1nnHXpRUqWea8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cxziWStrOnx1ZU6ZHLmxKU3J+wFwIXN8qf/vbcAnfAtESMz8OgNOTpIi1i7ivhLM7L4cMyifdOv2P/gwBK/CxmRM5zbIUzyoJGoedCf5C95me/piLqAUEKrLpkK9ZVreivCYXbrvVnaokmYsJJULluz+Vj3yTUobVCuVteJ7fW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XjOzsJkI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9YAtf002616;
	Thu, 10 Jul 2025 12:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mCUYVofGmA1lumKwwrvXffFupjX1Qb6wdnK/3ht6YYU=; b=XjOzsJkIpijdSDg0
	B3EwcT9mf6Nio4NQ3CsPR7gz5Y6eUNykEblucOJz+Vr2w2aFv9IptcuFFb1QUXhd
	9zKwkPnsYLwEmXPrIroI+RywmgSbBXorOVLkCA9aszfbQEWF80wAjCVfpJOc5vuO
	YzkVTUXa8gfd+T2OKIigZyBNPjk80lPHerodNY3ov9eQFJajb2dCpIm68l1ZIIYs
	QBKYqRQFiVn6JKFj/BpdRpxI6I2zDn2uGAPI276k9UvhrJ0TdW+TQlrEEg362aCl
	8LIrRGLWEjHY11U4MsCJ0eJiO2ECkS3CdP3C+4pM0xlbx5ovVGWvgy4qReCBC9q2
	0iq8cg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2bg6qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 12:29:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56ACTLQ6009780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 12:29:21 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 10 Jul 2025 05:29:16 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 10 Jul 2025 20:28:13 +0800
Subject: [PATCH v3 05/10] dt-bindings: clock: ipq9574: Rename NSS CC source
 clocks to drop rate
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250710-qcom_ipq5424_nsscc-v3-5-f149dc461212@quicinc.com>
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
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752150528; l=1871;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=0eAemDEX8aqWbx88zJPszW13Z9Wymz1nnHXpRUqWea8=;
 b=2UHYqipbWbnId0ApaVtlWEdY6On6m7s65G5MleHpiwRO1Cd7KkIeUaBh3mpyAEXYOoeyBwYjp
 qURKak9VSQnA0vwr8bgWKR10QF3OCwnCfEyluR4Mqi0IBEta7NyEmjG
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwNiBTYWx0ZWRfXw/xSyeWuEIYH
 AQQNns5C4I+t4PPYxq9bBj1N88NVBwYeTlfDvF9g0CsP6ips93ypijl1gPRuTOhXcMiqrggR0iL
 lUREn8I7vqHqpR2QPP8s4vpMAic75iBChLBAB88tZQEra4edQA+LXd/Kuas+Ax/UGaDiSdBx1CH
 hN/Z2pFzQu98yTuJwdS8E/WSOitFtPs95jS/xKiSXN86mMY6H7aIEHhRjq1465Cu5girM2N1GVc
 Xh7c5vW/Gj6h78ZWu9JBF4ijquO72jEuLuFZJGZAE9CZ6Hb1dg7zbrjB7NnrcX4wxvuvXQ1Ivp4
 C7uEhePHn1IhmG0MC2O0S4IyJCC7mH2h7H0eszy4sEfJgWwIQNHWIe4iuZwjXzmz8fQuI/FrNL6
 cMPaxgp2H2fnDurRTibV7k31aBAoOLGhd7D8X75RhRIAdD6Ib1dtt2KZpma/zoXSJexJ2WVw
X-Proofpoint-ORIG-GUID: snWrQgzDLGZJU_Er3_8ww_ihT2risdS6
X-Proofpoint-GUID: snWrQgzDLGZJU_Er3_8ww_ihT2risdS6
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=686fb222 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=xPnLX8oNBevfRIP3bmMA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100106

Drop the clock rate suffix from the NSS Clock Controller clock names for
PPE and NSS clocks. A generic name allows for easier extension of support
to additional SoCs that utilize same hardware design.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 .../devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml        | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
index 17252b6ea3be..b9ca69172adc 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
@@ -25,8 +25,8 @@ properties:
   clocks:
     items:
       - description: Board XO source
-      - description: CMN_PLL NSS 1200MHz (Bias PLL cc) clock source
-      - description: CMN_PLL PPE 353MHz (Bias PLL ubi nc) clock source
+      - description: CMN_PLL NSS (Bias PLL cc) clock source
+      - description: CMN_PLL PPE (Bias PLL ubi nc) clock source
       - description: GCC GPLL0 OUT AUX clock source
       - description: Uniphy0 NSS Rx clock source
       - description: Uniphy0 NSS Tx clock source
@@ -42,8 +42,8 @@ properties:
   clock-names:
     items:
       - const: xo
-      - const: nss_1200
-      - const: ppe_353
+      - const: nss
+      - const: ppe
       - const: gpll0_out
       - const: uniphy0_rx
       - const: uniphy0_tx
@@ -82,8 +82,8 @@ examples:
                <&uniphy 5>,
                <&gcc GCC_NSSCC_CLK>;
       clock-names = "xo",
-                    "nss_1200",
-                    "ppe_353",
+                    "nss",
+                    "ppe",
                     "gpll0_out",
                     "uniphy0_rx",
                     "uniphy0_tx",

-- 
2.34.1


