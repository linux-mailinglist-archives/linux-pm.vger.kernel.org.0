Return-Path: <linux-pm+bounces-10044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A59917E89
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 12:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AFF286544
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57EF181CE1;
	Wed, 26 Jun 2024 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Roui13ZO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2028917E8EF;
	Wed, 26 Jun 2024 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398500; cv=none; b=KeXb9ZTRJp+8whmk2sAoIaXjYWHDqE1bUZeyU4e9rpk4s2MjSiQW5ZcrercTTrG4hJfg+OYGJq9mrP02253GlYzRFoTnYUBnSjf0m1fis0UK5gnjeoNWlgBkqoK/zBR7FYacZWUYIUhv8bBFVx1ExHtPF2FgJr1oRUx9mTUa1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398500; c=relaxed/simple;
	bh=yd9JckspeWwCdPRuNk0bHbT8g0DNYSX0JcGydDzUzH8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqctn7CtvwZf4o0W+EgAvShV9Kd3gZ81Hf+SAqqG2cGyyhoKrX+CZ5sA/XilDoIQWxcXfVMvPHj65qbZpgt5NDWHuhUA4/W2B6eY90ALXs8IslJMk86irye1yZl1N8fsoKMJq9UTIe96AkoPMxB/NdNVndDyhHnVH+PKaCvvZE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Roui13ZO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfUI9018102;
	Wed, 26 Jun 2024 10:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qzYZKDC0mxcSxh7F2I3bVpuKrpqivJa+bwOnhrbv9ys=; b=Roui13ZOfjwM9Nw7
	HHuWe/HOjuuWjiQPs7bfMNLEfk575sB3G4bYjjQ0QwYp5LB1o0AkBG8gY8v5Mx+I
	A5NnazP4grGrmF9n3SCZ26fjaETfXmJmn7SBWxajMcLJ0rU6YqZCggffIFL/xNO6
	2r3RIv0vDsa+EhrRuaoKCW0E+JaTmVL4eUpnXd/IT7bAQd/n/tMXwvh1LJ/3pUPY
	TB+biYcv86/IOW+1syzm+tFAdk7xPEXAgvy3x+i+nyMGv3SiZrXpfQcXQ7K4cLdR
	qnQyGKOSP88YJvvUX4MhudTvs5LLxssZ32wmU+eWnpMbNn9amm6guztdeRaUvDoN
	AmHARQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywppv92w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:41:29 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QAfA33029793
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:41:10 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 03:41:03 -0700
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
Subject: [PATCH v3 5/9] pmdomain: qcom: rpmpd: Add IPQ9574 power domains
Date: Wed, 26 Jun 2024 16:09:58 +0530
Message-ID: <20240626104002.420535-6-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: CMhfws0mieFXWGpimtUXWy_odaCH9Zd_
X-Proofpoint-ORIG-GUID: CMhfws0mieFXWGpimtUXWy_odaCH9Zd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260081

From: Praveenkumar I <quic_ipkumar@quicinc.com>

Add the APC power domain definitions used in IPQ9574.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v3: Fix patch author
v2: Fix Signed-off-by order
---
 drivers/pmdomain/qcom/rpmpd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index 5e6280b4cf70..947d6a9c3897 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -38,6 +38,7 @@ static struct qcom_smd_rpm *rpmpd_smd_rpm;
 #define KEY_FLOOR_CORNER	0x636676   /* vfc */
 #define KEY_FLOOR_LEVEL		0x6c6676   /* vfl */
 #define KEY_LEVEL		0x6c766c76 /* vlvl */
+#define RPM_KEY_UV		0x00007675 /* "uv" */
 
 #define MAX_CORNER_RPMPD_STATE	6
 
@@ -644,6 +645,23 @@ static const struct rpmpd_desc mdm9607_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
+static struct rpmpd apc_s1_lvl = {
+	.pd = { .name = "apc", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = RPM_KEY_UV,
+};
+
+static struct rpmpd *ipq9574_rpmpds[] = {
+	[IPQ9574_VDDAPC] =	&apc_s1_lvl,
+};
+
+static const struct rpmpd_desc ipq9574_desc = {
+	.rpmpds = ipq9574_rpmpds,
+	.num_pds = ARRAY_SIZE(ipq9574_rpmpds),
+	.max_state = RPM_SMD_LEVEL_TURBO_HIGH,
+};
+
 static struct rpmpd *msm8226_rpmpds[] = {
 	[MSM8226_VDDCX] =	&cx_s1a_corner,
 	[MSM8226_VDDCX_AO] =	&cx_s1a_corner_ao,
@@ -931,6 +949,7 @@ static const struct rpmpd_desc qcm2290_desc = {
 };
 
 static const struct of_device_id rpmpd_match_table[] = {
+	{ .compatible = "qcom,ipq9574-rpmpd", .data = &ipq9574_desc },
 	{ .compatible = "qcom,mdm9607-rpmpd", .data = &mdm9607_desc },
 	{ .compatible = "qcom,msm8226-rpmpd", .data = &msm8226_desc },
 	{ .compatible = "qcom,msm8909-rpmpd", .data = &msm8916_desc },
-- 
2.34.1


