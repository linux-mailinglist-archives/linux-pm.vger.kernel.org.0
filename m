Return-Path: <linux-pm+bounces-12509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004A2957D03
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFAD1F237BC
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 05:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD3148FEB;
	Tue, 20 Aug 2024 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l+6qiMXP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3054652;
	Tue, 20 Aug 2024 05:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133461; cv=none; b=Xcq3d7dhjUvktsloj0r8K2tp5hQ6hPOWYQbqI7iELfGfOH/72rD4542vl3EWaUMPE+q59hIdGFzeblQe161AQBnX4gLFwxjOHMKIh53rTpHC5TCF2G2v+yYLEJEd1IIKIuZhuMtIntfYhwaHUEuJDMrI2SCEKs3KOuiluzCEF2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133461; c=relaxed/simple;
	bh=u3PgkPYkxe+M2fDj4vH8agpU4hCJnkDsiBPcu2ez/oU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCz5DxjJwiiKnNegCOfTiW3QHSC4Lh9HOJqrRM1GYeNW36gNHED1TJxJXq/GfuXoIfl+j29GmoHDOsPAdI27o1hNIp9wzx6Qnbx7lIflZJvFlbYs+4BOvxN25xnkqTh+vll+mZ8pQA0FjrLOqyB1Aub1DNOL0Khhvcw4Q30LyA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l+6qiMXP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K0267a015828;
	Tue, 20 Aug 2024 05:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tF0Cag0dwkBCTl8uDHh4UQ0Mtyhc5zCkQF/9aJe8qQU=; b=l+6qiMXPPkol8zU5
	9tAmDgxQcw+zhIFXPHyfmKKuu+NERxyZNu+nIWraqqm/9nqJrA/IZK/WFlPNWaSf
	pKQTnRYfMN5GJhpbClRaCB7aMG06AqhZIOQOtsujbtBd3+Mm8jqC4b6GCBDnSbTe
	878Nt+kSC2vqzTwgWaEn+PFo5xNo9cgB0a4nFEWdYhw0wAxUrp4PkmWNDz+nkI2N
	Qf4kRZ8a9FrZCP+AZknsg7ly//qC83kCE7tdbLO8yApVXih4EHraL82EwQbiFkx0
	K7Jhed4fSNm6FfnkTNtBHf+6eh6pADpUWhpNpP+S4ItCn1YtT2354zRNSLTlxHZD
	ykQ/1A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412m876jcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 05:57:35 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47K5vY2S026969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 05:57:34 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 19 Aug 2024 22:57:29 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ulf.hansson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v7 2/7] cpufreq: qcom-nvmem: Add support for IPQ9574
Date: Tue, 20 Aug 2024 11:27:00 +0530
Message-ID: <20240820055705.3922754-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820055705.3922754-1-quic_varada@quicinc.com>
References: <20240820055705.3922754-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: 1ycrRI0fcd9Ei-iaCXiB5zWTckCntCzw
X-Proofpoint-ORIG-GUID: 1ycrRI0fcd9Ei-iaCXiB5zWTckCntCzw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200044

IPQ9574 uses CPR4 power domain to manage core supplies. Use
device-specific match data for this platform that includes
genpd_names configuration.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: add Reviewed-by: Konrad

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


