Return-Path: <linux-pm+bounces-9643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C8F90FE83
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 10:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67061C22D32
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 08:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373FC1849F6;
	Thu, 20 Jun 2024 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KLxzZdgN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D2C1849CB;
	Thu, 20 Jun 2024 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871341; cv=none; b=pcEZ8r9Nmtg64NtfPzAGsHc0IbUOvvXRTRXl7AzPMjvrwI/hrFKOrfeE2VuDoaHxRMt3fO3Km191yF6zPK06xWfqWGUBPj1GECuxgYzzssePqEsWMShCMD4EY7f82dEA5sDGJByOjaikmnKzYwFgz5ms2XM2meoHl/H+nT3K2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871341; c=relaxed/simple;
	bh=RpzDGL5TaHLiKEFwm6JVyJszs6bxQHnHrhwaJqRJ570=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZOLXE3deiaHSljVER510QHNs1AFYXI25VXFIMe5/f8NDGhsUq8uu237F9MJE39lXqX5qszmPAyc1GhrdpYmcZuPx2jO/bz17CXWw75Vh08ay8FbMferLtZmd6Xk/I0RAs3GqqlzEheYzTafWPkcvMbhyh9a7lPh8fn7QV1r1Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KLxzZdgN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JLn361000437;
	Thu, 20 Jun 2024 08:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AK57bWid4D1rQbBeaoXBJoYCsoYhF6btuSFANi0j8Mg=; b=KLxzZdgNls/BTP+V
	sf2mFIuRnb+8sTrxFjS4X4I2QO51QzPh06oL8530me4jvRPXNb1CDiVl0jXyO4hy
	gm0hX5pxAJ03r68OkVur4qXZOFR4WeTTgx4GBsQEcFKHiUq1BZ00Wx6WQJsR3mpa
	zNYDSADVvUcOjZyuudMzhYVJ6pC19b6asvEwYuxuQArnmenjDLXJV7DFGLwx2bn6
	Tlzn1n/WKw4kQ9dpLJu31R6rp3EbNR7jyqOVt1ucsFTD7wY997PaXZzzAel7gKMq
	zx0OH22TU6aFso422gwwT26cD6DHS9WNll2cX0Ktm4JYqIyXBwkADEZywJ6uezNP
	T7+jyg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yv7jeh36e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:15:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45K8FSJU018580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:15:28 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Jun 2024 01:15:21 -0700
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
CC: Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: [PATCH v1 3/7] pmdomain: qcom: rpmpd: Add IPQ9574 power domains
Date: Thu, 20 Jun 2024 13:44:23 +0530
Message-ID: <20240620081427.2860066-4-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: pgvQtgEPaiEWM-oqu36-tf-hQGsRI_PH
X-Proofpoint-ORIG-GUID: pgvQtgEPaiEWM-oqu36-tf-hQGsRI_PH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_04,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406200058

Add the APC power domain definitions used in IPQ9574.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
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


