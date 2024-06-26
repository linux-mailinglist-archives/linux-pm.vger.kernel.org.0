Return-Path: <linux-pm+bounces-10039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9180917E6F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 12:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A871F225AF
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904E217B514;
	Wed, 26 Jun 2024 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TrO2v3cd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DC17B405;
	Wed, 26 Jun 2024 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398461; cv=none; b=jGSaJnGWlt24VTKHHHjxQPSe+ein8y1mEms1BxKwxx2Ontr251g/YYUlT158UywVk6v5RG5U6bxsPWcN2tsGJnhQAghH2vHYp10nGHq8k/NDY0nY4ZudegpsA6ubw4Toq7hlXXKJihTmJjyQXo3EbNppGF2u1zwvBoceCz7DT9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398461; c=relaxed/simple;
	bh=l0R/P3u3PChoGz4XznbcCkh3+RlIqfpt7c5t/vs5eh4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RN5C65tyPK/ooCYzIN2WQ6NxdSD901AQGigjc5i1KvLU4OvM4VXxmSZUjwXf3+JynLvuOHvuujUPFB++7iMEdUXK6GJroQzNuBN6suhFrO7sOQm20Vn434q4cXmxcDaRiQ9QR0SvQJLK5gdZ1s762JuIlVv5fwV91sOai7Y8AnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TrO2v3cd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q3mmtY002267;
	Wed, 26 Jun 2024 10:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lrg3yoV9Tnw7Ektyl29stD6ahGhkTypjQWuGqUa+ieA=; b=TrO2v3cd9zNE4/3V
	YS2TQKikrmQmumgx9Hz2qFsmP7JYLowjs9QeU7KxFtoqD4Wz0u5c+vjpX3tK/TCA
	uGrIHyxE4gReLN3V59RZvAFs0X9iJ0wbikYUuAf5Gux1lAXxgxS+ddHNHOWyBjcc
	um9DfI/A6uTlVkg/3cQJmj4Par74H1mEcgEVqn+jD9upKNnEmBSNOCvZg7oi/Jdr
	Fne8A2OnU5zq8cIHyqpIMTSWi7uSaBasQlj8BMg095yhCqG53jqUXV7Fktbdw+Sq
	Zbf0eXnuTeq6jeN/UXS1oYeo7S2QbvumX0Jneomfmg441HLwrDqCJ7Ae9reKYRGB
	CJdPEA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400bdq9154-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:40:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QAem30029257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:40:48 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 03:40:41 -0700
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
Subject: [PATCH v3 2/9] cpufreq: qcom-nvmem: Add genpd names to match_data_kryo
Date: Wed, 26 Jun 2024 16:09:55 +0530
Message-ID: <20240626104002.420535-3-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: t3dW5VTpdlXMGJE2hMp-NIgFm9gco2ys
X-Proofpoint-GUID: t3dW5VTpdlXMGJE2hMp-NIgFm9gco2ys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260081

This is used for tying up the cpu@N nodes with the power domains.
Without this, 'cat /sys/kernel/debug/qcom_cpr3/thread0'
crashes with NULL pointer access.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 939702dfa73f..5e6525c7788c 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -399,6 +399,7 @@ static const char *generic_genpd_names[] = { "perf", NULL };
 
 static const struct qcom_cpufreq_match_data match_data_kryo = {
 	.get_version = qcom_cpufreq_kryo_name_version,
+	.genpd_names = generic_genpd_names,
 };
 
 static const struct qcom_cpufreq_match_data match_data_krait = {
-- 
2.34.1


