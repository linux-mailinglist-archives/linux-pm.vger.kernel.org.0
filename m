Return-Path: <linux-pm+bounces-10825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA1192B2F0
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 11:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2168F1F230FF
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201B5153503;
	Tue,  9 Jul 2024 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fp0tQxqx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938B214A0A7;
	Tue,  9 Jul 2024 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515735; cv=none; b=XArH8+3uDRPSrVVi/fx47ohnJdtsflbS2la7FAafwrpbe+vwFgSqeQh2FjfkSTiYEiF5qhfryuuUYZTZXWFgFU6OCw0a4UVIDF2xqGr2pV2lwQPTCJvHwrnBMK2XZPKaSYtCzcm4PaB0j9yF9VQnj0wpI7dqFuDnSURCaKvplyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515735; c=relaxed/simple;
	bh=b3i/0MCfgU6QEYwO+bz83cgYeRopRLQVdxliOV9f+Mc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oF9wR6G7GMsTK0cyN1K/HLinpeiya6EvhP7XDo2EEtKrAa8TpAZ52De7Q3P4AiLsYrmG6mfKnExldkc9+TRgupC8Z+zmAr+j8bj8msQ5Abz+G/zqKdwuNBXDWLrqa/Z5qEKt1ikQ5JRVhByXBApgMCFxEq7a2rp5MIritfgrF/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fp0tQxqx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4691kXAw028546;
	Tue, 9 Jul 2024 09:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FzK5OFs+lr/zFK/GI0khIU41rLOIjusdVR//B7Nztbs=; b=fp0tQxqxlFYK+fIQ
	aHrk49mP6cIm8qMNjEYe+j04KzniQyG7fGxkITOs5GyvROVfslOeNcMvBiJ+rKAm
	NZqTj0kwwYbiqql4nVjdQtnWp3s37I+8aW1uajDkIZVY9FiCQMbwsmM6swO2PtrV
	T+lIOBdkxoDSDDkTs2ssDhUXm7VB/38gOWbpMNc1rl2ioCn02U3ulrD0TY3RL+xX
	N0urStyAA98HwyMWKqkspWbXnjc7NaHyDesOf9OjSxMrJdzMcS7K9oPd40Hs9wN+
	awmyS7q8AuaNl8TjbFASUt+8i7HxYeZQxABpi1NOlP3Wt4cN0Jj/r4GCu/Kk4KfK
	k2sCXw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wjn63ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 09:02:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469920XL028282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 09:02:00 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 02:01:52 -0700
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
Subject: [PATCH v5 1/9] soc: qcom: cpr3: Fix 'acc_desc' usage
Date: Tue, 9 Jul 2024 14:31:24 +0530
Message-ID: <20240709090132.117077-2-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: bCZa46p-U440S9LoGlUdWHdjqZURj8v6
X-Proofpoint-GUID: bCZa46p-U440S9LoGlUdWHdjqZURj8v6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=901 clxscore=1015
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090060

cpr3 code assumes that 'acc_desc' is available for SoCs
implementing CPR version 4 or less. However, IPQ9574 SoC
implements CPRv4 without ACC. This causes NULL pointer accesses
resulting in crashes. Hence, check if 'acc_desc' is populated
before using it.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Add acc_desc check in a different way without breaking other SoC

v4: Undo the acc_desc validation in probe function as that could
    affect other SoC.
---
 drivers/pmdomain/qcom/cpr3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/qcom/cpr3.c b/drivers/pmdomain/qcom/cpr3.c
index c7790a71e74f..08a306d86403 100644
--- a/drivers/pmdomain/qcom/cpr3.c
+++ b/drivers/pmdomain/qcom/cpr3.c
@@ -2399,12 +2399,12 @@ static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
 		if (ret)
 			goto exit;
 
-		if (acc_desc->config)
+		if (acc_desc && acc_desc->config)
 			regmap_multi_reg_write(drv->tcsr, acc_desc->config,
 					       acc_desc->num_regs_per_fuse);
 
 		/* Enable ACC if required */
-		if (acc_desc->enable_mask)
+		if (acc_desc && acc_desc->enable_mask)
 			regmap_update_bits(drv->tcsr, acc_desc->enable_reg,
 					   acc_desc->enable_mask,
 					   acc_desc->enable_mask);
@@ -2703,7 +2703,7 @@ static int cpr_probe(struct platform_device *pdev)
 
 	mutex_init(&drv->lock);
 
-	if (desc->cpr_type < CTRL_TYPE_CPRH) {
+	if (data->acc_desc && desc->cpr_type < CTRL_TYPE_CPRH) {
 		np = of_parse_phandle(dev->of_node, "qcom,acc", 0);
 		if (!np)
 			return -ENODEV;
-- 
2.34.1


