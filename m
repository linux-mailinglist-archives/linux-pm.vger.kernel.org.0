Return-Path: <linux-pm+bounces-10504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F758925653
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C272285759
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7AE13CA95;
	Wed,  3 Jul 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="idXw1Ieq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7713C8EE;
	Wed,  3 Jul 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998278; cv=none; b=sw2FGCkqXdyuY8Wk/HK3iwB8QYRRhQk55X9FSkICNRjNm/otB+ZPLriEbIql1rKyUeM2Ss2ftVQ+JvAcNulDQENEOFPyUP+R35L8VUl9pgs/tNakp8aTzMkFnjeN0/yft9vPv6oxaSL6eVrRGgLUCUJQwRtRutip1tjLYtygSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998278; c=relaxed/simple;
	bh=dbf/rL/FyPZZYRw3yCB0mNrAQS41nJrX96F9bPC+fBc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3lOSaBUA3CrQhX8382q3+LfeIEyvvi+0iHeO4mMdz2lnBkFvY5ETjpUU+YBsJIgKhnY5X0IxOoAfGITj0YcMTmIR60VZK1NMcjHAhcf1OsTM92cL+JG4RZzJCqT9zINQgX4NQbLBD40OJ1THVkWlSmLu+vvrv9oaMU2Czxlv98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=idXw1Ieq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4635JsYa024431;
	Wed, 3 Jul 2024 09:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C0fIEm0CuCF3UCWIAb9JxkR8v15bhRZIqQrykRN84RA=; b=idXw1IeqnMwS7Q3G
	XnQNG60c9tu47gkNAkc+FHxJobL0Yt3XReEDttRV60Few6POf8KvdQGA6Hhu7L3e
	3G3fRrN0XCmVVlhAvVi4RmWvYN6sO7mlvLg/lks6BcV+nV69omLi40d0kWeJnqgk
	dOlRKhY/zYCGKhacz8iU244h7EpzQawieM0F+QcdNm98cbnWQKexJc2eKxkN+bS/
	vmAofPBJos30yaffH2XzyzitcJzIUVcWT4vU+3vtmtJQCRrp/FfG60qfhryVRRnU
	oFJafAyi9WI4tAu439O7plKpAdo0Qrp/QOZrhN1Bmerik3V7iHnWCNzWovuOynVS
	An9vyQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4050cy8jj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 09:17:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4639Hfil025354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 09:17:41 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 3 Jul 2024 02:17:33 -0700
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
Subject: [PATCH v4 02/10] cpufreq: qcom-nvmem: Add support for IPQ9574
Date: Wed, 3 Jul 2024 14:46:43 +0530
Message-ID: <20240703091651.2820236-3-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: TEK89Fqy3HaU0jrU1VdfWvGo4pfbBIhG
X-Proofpoint-ORIG-GUID: TEK89Fqy3HaU0jrU1VdfWvGo4pfbBIhG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_05,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407030068

Add qcom_cpufreq_match_data for IPQ9574. This is used for tying
up the cpu@N nodes with the power domains. match_data_kryo is not
used since it doesn't set genpd_names. If genpd_names is not set,
'cat /sys/kernel/debug/qcom_cpr3/thread0' causes cpr3_debug_info_show()
to crash while trying to read thread->corner->last_uV as
thread->corner is NULL.

	Call trace:
		cpr3_debug_info_show
		seq_read_iter
		seq_read

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
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


