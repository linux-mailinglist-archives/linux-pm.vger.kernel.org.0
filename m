Return-Path: <linux-pm+bounces-10038-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F15917E68
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 12:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40136283C75
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8148917D88C;
	Wed, 26 Jun 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PeYLUL+V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DFA17A922;
	Wed, 26 Jun 2024 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398454; cv=none; b=Z/4pXF3nvuntilzYX8O5IFcWjPgP0veUslJV+oiroHMT3LCms0X2zCPM7v4TCUw4iZBdzPB/dycRBeFtvPFsFgSSDfMEOGDxw3jQuW+ZjRtBtxe7hF5xLEli+h/QEqHvFxeUPzgstVWN5XLa+h6foOHDokSF5fBXv4XNu4u0yz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398454; c=relaxed/simple;
	bh=hyLAnLHHaqi+vBvo7zCHnj7HR41sEtAWCc2PJsn5SsU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g854IoS+kJLWegE8I2u1JiK8g/jOvmKYZ7IWOgFYCvckyx94U2u7aWxkZ6AXy7GJ83Z+I4igbw26S4j4BRcpueHcAeI67gO/ANtkmdVrXbG9+/y0dxDqYO1T8gDOrMvjvyoWVQUW7a9dCPyS92kNaxiMLly7rWc44E3cGP9EbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PeYLUL+V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q7mbx3031370;
	Wed, 26 Jun 2024 10:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mVIV1bNkbYIen8b7ZWVpzP0mrFRirI+uiVayxAO3oCk=; b=PeYLUL+VVfHEpoA2
	zqyBYvq/zjUnn0A8j4c6cYM07NTEzF+m962kY8QM8IjH+FlA7sKGGGx1As+ezvQe
	pbGRHEafX8xlGUlrq3n8OiN5N0gbowMI0Ym7tTJ++z4SGMLIhajaNWY3DQR6xhm1
	dqqqzlEnWUnuYyXtM59F+Nsj+/0gDFAPL94zZmH8pEYg7tEt31TA+K+xIrOU3/Z9
	XljToASOAyBZyi7YO57ainbTwZ9S8bM5kRZWObJJXUgbAp5L4MhupKWN5x7qbUhv
	wRsMm4C3WVzOl3LLhLecPdrWfBmT0MQIztKpgrS7sIrn3qkkctYooyLyu8faNI65
	f4XZxw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywppv92v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:40:42 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QAef68029157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:40:41 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 03:40:33 -0700
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
Subject: [PATCH v3 1/9] soc: qcom: cpr3: Fix 'acc_desc' usage
Date: Wed, 26 Jun 2024 16:09:54 +0530
Message-ID: <20240626104002.420535-2-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: ilGCwZTIuqzl_i-MOPFpsaci7NPPh7Cv
X-Proofpoint-ORIG-GUID: ilGCwZTIuqzl_i-MOPFpsaci7NPPh7Cv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260081

cpr3 code assumes that 'acc_desc' is available for SoCs
implementing CPR version 4 or less. However, IPQ9574 SoC
implements CPRv4 without ACC. This causes NULL pointer accesses
resulting in crashes. Hence, check is 'acc_desc' is populated
before using it.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/pmdomain/qcom/cpr3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/qcom/cpr3.c b/drivers/pmdomain/qcom/cpr3.c
index c7790a71e74f..c28028be50d8 100644
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
@@ -2676,7 +2676,7 @@ static int cpr_probe(struct platform_device *pdev)
 	desc = data->cpr_desc;
 
 	/* CPRh disallows MEM-ACC access from the HLOS */
-	if (!data->acc_desc && desc->cpr_type < CTRL_TYPE_CPRH)
+	if (!data->acc_desc && desc->cpr_type < CTRL_TYPE_CPR4)
 		return -EINVAL;
 
 	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
@@ -2703,7 +2703,7 @@ static int cpr_probe(struct platform_device *pdev)
 
 	mutex_init(&drv->lock);
 
-	if (desc->cpr_type < CTRL_TYPE_CPRH) {
+	if (desc->cpr_type < CTRL_TYPE_CPR4) {
 		np = of_parse_phandle(dev->of_node, "qcom,acc", 0);
 		if (!np)
 			return -ENODEV;
-- 
2.34.1


