Return-Path: <linux-pm+bounces-10507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F20925662
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82FDB1F28454
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3106613D636;
	Wed,  3 Jul 2024 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VLkqzkNV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9571213D2B2;
	Wed,  3 Jul 2024 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998303; cv=none; b=I8+YSbrm+8Hc5Aw/ZtIqBUkXLLGoEL6dSewXPs1mgFWVB68/nT22bcOAT2PDzPEDqDmFhX4av5VcrlK/WQK5GEBfq0Bazrv44KVlGQXXdPxVtzNmH1QAqW65H87My3V7IZxfOYByGuEE3yeIbzllnvHpfu9VSNnJPhFQrJ8kVkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998303; c=relaxed/simple;
	bh=kyT2lvnZ/z/NDW94MzCkn8+4xY1RNh2feW47eeACaGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEFbGpels4+kyaM4ekVPz5fMluXno6oGDHf4W3GCbE6rBFw57mGaa9kRw0DD0Nzjc78rgtkmfJU4LF5B8+oOlDGs5LYOHmZlgxkZqxxnun7z7qPzOEhUzq8EIVVyb1sLJrzquHseqnYrnwGSXxumDVT5IA8uQ5+L+Bzw9TcDrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VLkqzkNV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4635IuZe023216;
	Wed, 3 Jul 2024 09:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZReu1Re5cu0W/i7PRU33nbGEbt3ZUnonMSTjz/njU+A=; b=VLkqzkNVRptWWDLT
	XjsvucZq2WrD1YK4aa7lI0tpGhrl5H3kEJs52D3+zMFnnjjx6NytBy2Ki6/zhTSs
	NwY7pYoiCK2A4nQ0QYijO/UbriEhKxFN1a1TVR+1qYxVB4fCv3FkRCMbzSy1ne5f
	9ubB+n5lKt0+B3ufkPJFEueONV5jaaU3bXjO8sPdGXl0tCjqG4nma0XH1JuHS0bf
	e7gnaE3fITldAbSBRtw5Ppjm54MaeKQ9K6F99aG8tSl4zKOx84L8FXrlNNB2K36I
	ZWxrbfxZkzMRZZCVy6OfhyN6M0gPj34Mjk7EuyqBBU89nF3+QAMSTwiLQbJCtLZI
	41lD8g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4050cy8jp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 09:18:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4639I63i025985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 09:18:07 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 3 Jul 2024 02:17:58 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <ilia.lin@kernel.org>, <rafael@kernel.org>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_rohiagar@quicinc.com>, <abel.vesa@linaro.org>,
        <otto.pflueger@abscue.de>, <danila@jiaxyga.com>,
        <quic_varada@quicinc.com>, <quic_ipkumar@quicinc.com>,
        <luca@z3ntu.xyz>, <stephan.gerhold@kernkonzept.com>, <nks@flawful.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 05/10] pmdomain: qcom: rpmpd: Add IPQ9574 power domains
Date: Wed, 3 Jul 2024 14:46:46 +0530
Message-ID: <20240703091651.2820236-6-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703091651.2820236-1-quic_varada@quicinc.com>
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: RghYWX4fLApXY03-w37Hal8lerJ4jZQ8
X-Proofpoint-ORIG-GUID: RghYWX4fLApXY03-w37Hal8lerJ4jZQ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_05,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407030068

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


