Return-Path: <linux-pm+bounces-9855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CCD9141AC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 07:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E5CB235B4
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 05:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B58E175AD;
	Mon, 24 Jun 2024 05:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gq1J64hJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913251C6A5;
	Mon, 24 Jun 2024 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719205433; cv=none; b=Xzysi8ff8VM/u/e+lM+Tpol1/72tSaHcn90ajyh3eg6+cu+xgk3qConCY2fephojWPAtRm8t2X7ZYP4o+ii8V/hr2mB021bHUoyaXbD7YwYpMOBgu0WNYQzrQxSHIwMi/bEfauci8YbMFO3tNte2C/Ohk83addrIZKWbQ1an//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719205433; c=relaxed/simple;
	bh=8zZPiIS+o1z0dbiVhYu3LzPXZ8dbjItMz0MDGo8UeBQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpYSELsoEiieL9ZkWxCkvrrparcqexa/WjY/WRyOlRFmk/csetcyX+wJR0Nev4pZJE90ZsVpHNGarIyNuQIktkVk/iCng4mYveLR2OdPZfJciH9B5I4Hu2JmzmGSgYkXa6MTEtbxR/pX1e6pH8V3wQvDO4Hf/x0pfSCRc8BQPHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gq1J64hJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NMZ24E001261;
	Mon, 24 Jun 2024 05:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xwsFpV5DEpHLo+75wKzFfRC68kOxWGgTe1gVDB4T/Sc=; b=gq1J64hJYy5Iy+6B
	/h6K+97ZO/fi95I9x7G7XfJXdEbjrgP8OQNmH7vWa2ICwwMQPDolcaohhnzUzwsr
	L78o5tZhhnT/h+qzfz+sCAY4eSPxsjNEzn5VDHj0GLt1F5QGNxNj17d+x+QpZWJ2
	TWikWJO4XbV0Oq8Za1l+aSt9zSwSCE/I+AJjNGp8YpUIUkO6RpB+5xrzcq6ya/Dw
	ZvPiCm+Xja+mEXQ8lsYe+dg5z1tHVSIN4/2J1Axa78my37nZpkcf8r7sM/tTl3Cb
	5HJSKvSP3DBIwpicZaaRXLaWUKZpDI4fMgdYvTtlBeHnGnQezYnA0HTxttNTJSH5
	D121Kg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywkyn2tk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 05:03:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O53hCI019813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 05:03:43 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Jun 2024 22:03:37 -0700
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
Subject: [PATCH v2 3/7] pmdomain: qcom: rpmpd: Add IPQ9574 power domains
Date: Mon, 24 Jun 2024 10:32:50 +0530
Message-ID: <20240624050254.2942959-4-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: XbUCd3dc2ZwiuMYKzEGYdPNe0n31FHJr
X-Proofpoint-GUID: XbUCd3dc2ZwiuMYKzEGYdPNe0n31FHJr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240038

Add the APC power domain definitions used in IPQ9574.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
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


