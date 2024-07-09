Return-Path: <linux-pm+bounces-10829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA3792B304
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 11:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F17282055
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 09:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C30155758;
	Tue,  9 Jul 2024 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pQL6SzbG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7792D1552FC;
	Tue,  9 Jul 2024 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515764; cv=none; b=d5TjfKjZmqW6tTxWuxXlc+gMfh6i9t91XOTXIgECVcLtrirS8N54P2wOyUMLJZ4Z1cMndySx/zKiRH0OHfAUHckPxhbCKoADcpOr15lxeRbAslP+l9Ger+n2WOgeKIYyLvuwm7c68ztDdhHPeLpeilrmYyAsODkfrTdPDliwHek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515764; c=relaxed/simple;
	bh=kyT2lvnZ/z/NDW94MzCkn8+4xY1RNh2feW47eeACaGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qczX+I6T9wffVBsnHTO/FqQkINk+mzFBkmCGhj33I0LWDPbD8OOTgin+y3XqlS0aD0NZW+xQiY0tytgc7V8NmR14LfuXscKviQ5JRz6e+yzoh4sGpv/lKJxyLMaYAUACO/JiJVcgl+k+hFuHQ7ZAC2Stbfd5R6LSN9gFkIDb/x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pQL6SzbG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4692VSjO014159;
	Tue, 9 Jul 2024 09:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZReu1Re5cu0W/i7PRU33nbGEbt3ZUnonMSTjz/njU+A=; b=pQL6SzbGqJD8hfXd
	+1zOArtzsQtGJXyWR2/aDP2BmDiYM+F78Qzs/2y1GiHV2UZRSlc16+EN0iN1foPz
	5v/BJ9dbJIUE2Jo4+Cp/rf0FORA3dM4CUnNUlr3ZNJY32pR+9gWtn9TBoIfPkZNh
	08VK4/Rb87I66t2leWfNAtN8cAlVgSLimENWRMwSHw4yUz623gtWVm9qClcrBQjP
	jkNpeM1h7v2DTLyqMyzzFUVeOJ6cObitztK6nw8vn0iKjggowrOVxh+TRXFqEYTR
	4IdctNYq7OdyDnojCDvATuMzc7Y2tYinABPVtZPslXRB6XotblGXLVxKxWpKazrQ
	Xy7pPQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406xa65uhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 09:02:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46992Vre009918
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 09:02:31 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 02:02:22 -0700
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
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 5/9] pmdomain: qcom: rpmpd: Add IPQ9574 power domains
Date: Tue, 9 Jul 2024 14:31:28 +0530
Message-ID: <20240709090132.117077-6-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: RgFg_YShf2r1wSwj1j_-XtKggJ0ErQff
X-Proofpoint-ORIG-GUID: RgFg_YShf2r1wSwj1j_-XtKggJ0ErQff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090060

From: Praveenkumar I <quic_ipkumar@quicinc.com>

Add the APC power domain definitions used in IPQ9574.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v4: Add Reviewed-by: Dmitry Baryshkov
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


