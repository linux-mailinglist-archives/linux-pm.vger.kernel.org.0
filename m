Return-Path: <linux-pm+bounces-17360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C94D9C4AA6
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 01:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25ED41F232DB
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 00:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F01EBFF2;
	Tue, 12 Nov 2024 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WcxT9fEj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0741D0B8B;
	Tue, 12 Nov 2024 00:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731371119; cv=none; b=V2VZWV+AGn3mSGubAV962+oA53LQE+b9MB9WlQ15XNpmSRWHZImWrGSc37K31tMWk12g2qQbIkgRGIK9QVzGFfpg7RsjK1h8PlIUynn+0tVIjBk4lshsfNbdTT44sAxauyNKUmtkQUdQbVvwY4PZU3G9HxD522gcRdJCH2RQ8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731371119; c=relaxed/simple;
	bh=ayPVtgfrB8qU0x5cnLGhbpyBmFoRBwYYeQg9SZIK1U4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwmYgr8xH+RMg50XukHBX9GoRe4Kuurb46dsn5pCftDmU/ykMwoNOyH/noYmTAm37F/9EpbxeBlz5DYTRndXNWCtR8D3RFMTvLLU6at7iSVgTf/+khKXPVswhOwbxnIAbzLvmd6CJqsxe/YjjJNc7E72A7vsl9GcU2o7euqS51A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WcxT9fEj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABH6pOW022150;
	Tue, 12 Nov 2024 00:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rjuzItRyBHCsGZ9FU8o5GYAzUorLoIxA4ySCph/eZDo=; b=WcxT9fEjs4KmLnvk
	lW0n6R78tiSAveqCmgdSLgYU58NVycu7cx+a/EUD5h9BLweFYMJP23D8FJznZ057
	nzaVu3jgUV7ZGsvHrIwnt346TMGcgqpHJnRZDwOXf3XAiryqLQ/dizwRaaV4BPw/
	oG4fcTIzZLM+ee9l7o3olYXc2VmQbCwj1N6l+pyhnNS9HYvJG8zNsH6p8UGyp6I5
	BsXxFmaBfSL1HN+HviRCbIYCLW3jta/Z/aUAPCjtVbvwGqqQuoOIrB2BZEnd6ZRC
	xiOhL7kh7W+qtePbU6qTFeK8W9oJyUJVwbE/iTV/TFYcAu4R7+pLyPCsLKbqcz0w
	1oGlKg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42uc60a9fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 00:25:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AC0PAVL018591
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 00:25:10 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 11 Nov 2024 16:25:09 -0800
From: Melody Olvera <quic_molvera@quicinc.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Tingguo Cheng
	<quic_tingguoc@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>, Luca Weiss
	<luca@lucaweiss.eu>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>
Subject: [PATCH v2 2/2] pmdomain: qcom: rpmhpd: Add rpmhpd support for SM8750
Date: Mon, 11 Nov 2024 16:24:44 -0800
Message-ID: <20241112002444.2802092-3-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241112002444.2802092-1-quic_molvera@quicinc.com>
References: <20241112002444.2802092-1-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BFqwaxdk0KgoUHh-4g6xwbMKdREk1tw-
X-Proofpoint-ORIG-GUID: BFqwaxdk0KgoUHh-4g6xwbMKdREk1tw-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411120001

From: Jishnu Prakash <quic_jprakash@quicinc.com>

This adds the RPMHPD present in SM8750 SoCs.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 5c5f9542c392..dfd0f80154e4 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -537,6 +537,31 @@ static const struct rpmhpd_desc sm8650_desc = {
 	.num_pds = ARRAY_SIZE(sm8650_rpmhpds),
 };
 
+/* SM8750 RPMH powerdomains */
+static struct rpmhpd *sm8750_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_GMXC] = &gmxc,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MMCX] = &mmcx_w_cx_parent,
+	[RPMHPD_MMCX_AO] = &mmcx_ao_w_cx_parent,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_NSP] = &nsp,
+	[RPMHPD_NSP2] = &nsp2,
+};
+
+static const struct rpmhpd_desc sm8750_desc = {
+	.rpmhpds = sm8750_rpmhpds,
+	.num_pds = ARRAY_SIZE(sm8750_rpmhpds),
+};
+
 /* QDU1000/QRU1000 RPMH powerdomains */
 static struct rpmhpd *qdu1000_rpmhpds[] = {
 	[QDU1000_CX] = &cx,
@@ -707,6 +732,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sm8450-rpmhpd", .data = &sm8450_desc },
 	{ .compatible = "qcom,sm8550-rpmhpd", .data = &sm8550_desc },
 	{ .compatible = "qcom,sm8650-rpmhpd", .data = &sm8650_desc },
+	{ .compatible = "qcom,sm8750-rpmhpd", .data = &sm8750_desc },
 	{ .compatible = "qcom,x1e80100-rpmhpd", .data = &x1e80100_desc },
 	{ }
 };
-- 
2.46.1


