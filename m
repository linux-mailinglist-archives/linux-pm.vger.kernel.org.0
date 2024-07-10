Return-Path: <linux-pm+bounces-10905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF9C92CA78
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 08:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08031C22196
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 06:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FB16F077;
	Wed, 10 Jul 2024 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e+YiHKNZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492D50A80;
	Wed, 10 Jul 2024 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591913; cv=none; b=Cz3TnLE2ctm5o6vPhpnbGoq3Ow81DYwAsuFkOrEaq2zX9cBmKPUCgwrwZY/wnm+7ohFvYFZQTHh7hc5VGSCP7j+hCw0Oh8WNsufaTHfjgi3quxHwpUDfJJzItGyspnSLvB4p2c+QEXOhq0UTkh5nJTv2/gGn4nYNZBkVyQtbR8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591913; c=relaxed/simple;
	bh=u5GDcskkLkPvszCAkvzuDxSce+h0qv79jWl002Twdps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnEDSc9FF+IH1RqwzuJ3vdH1niCdkvkYW9DPQzlhL/W2Le6kmLcircwthMOesi3JfaKSe1muYdV1eFsXJ8I6PVcu0eJ1F5+Lq48aXdOcJxGn300NqgfZafFYylCvPFB6B42XGqsCWy3AiDEvVaTpLUY/as2xeYT6VQ4hgDI55Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e+YiHKNZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A52agq020904;
	Wed, 10 Jul 2024 06:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V4jjdhYt7mtR0F7AzgJDsh8z3aA3+2GN85+4XBhWQMA=; b=e+YiHKNZfcmqX04v
	FMH87BsFi62zawCPJuGhOd5Q0gzeNCl5sRD3eCSXLgTRWqFxXHCn1olqf0ZP9f4m
	hfIZED2UFmqhUXfEWpOLZufd4f1yoLAA0R0TY4dYvC9wQ6fFvJYl0kw2oNc3jT2f
	TAbjFEwX4l7oIyNT1PpkaUS0qj71RKqmxJihJ6hWO//3QwcfalCnY21GWJwucxXv
	E3vKekvU97GxSRPsv8aHf5jWQ6jvP91OYNwgHpUEenTw+7VbyrRvn3my472DP3mM
	YVxhLayvLIEGoxOZEE0HZL03r9iibsOreAzCtCFI1G761SyvXlOhuT0GZIBSZJer
	5PDnSg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406we907rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:11:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46A6Bcas023833
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:11:38 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 23:11:30 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <ilia.lin@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <quic_rjendra@quicinc.com>, <danila@jiaxyga.com>,
        <quic_varada@quicinc.com>, <neil.armstrong@linaro.org>,
        <otto.pflueger@abscue.de>, <abel.vesa@linaro.org>, <luca@z3ntu.xyz>,
        <geert+renesas@glider.be>, <stephan.gerhold@kernkonzept.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v6 2/9] cpufreq: qcom-nvmem: Add support for IPQ9574
Date: Wed, 10 Jul 2024 11:40:55 +0530
Message-ID: <20240710061102.1323550-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710061102.1323550-1-quic_varada@quicinc.com>
References: <20240710061102.1323550-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: eY-VF5CnEZnPnEWLO8q0GQ0QrYVGcSD8
X-Proofpoint-GUID: eY-VF5CnEZnPnEWLO8q0GQ0QrYVGcSD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407100046

IPQ9574 uses CPR4 power domain to manage core supplies. Use
device-specific match data for this platform that includes
genpd_names configuration.

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Change commit message and add Acked-by

v4: Update commit log to include stack trace
    Introduce qcom_cpufreq_match_data for IPQ9574
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 939702dfa73f..95558586c2e6 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -428,6 +428,11 @@ static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
 	.get_version = qcom_cpufreq_ipq8074_name_version,
 };
 
+static const struct qcom_cpufreq_match_data match_data_ipq9574 = {
+	.get_version = qcom_cpufreq_kryo_name_version,
+	.genpd_names = generic_genpd_names,
+};
+
 static void qcom_cpufreq_suspend_virt_devs(struct qcom_cpufreq_drv *drv, unsigned int cpu)
 {
 	const char * const *name = drv->data->genpd_names;
@@ -621,7 +626,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
 	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
 	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
-	{ .compatible = "qcom,ipq9574", .data = &match_data_kryo },
+	{ .compatible = "qcom,ipq9574", .data = &match_data_ipq9574 },
 	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8960", .data = &match_data_krait },
 	{},
-- 
2.34.1


