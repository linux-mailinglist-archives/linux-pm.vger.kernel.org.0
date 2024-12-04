Return-Path: <linux-pm+bounces-18537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074099E3B0F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AB228240F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7C71CD208;
	Wed,  4 Dec 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WlC42VNk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1B61BF300;
	Wed,  4 Dec 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318279; cv=none; b=o7qc6oqOzoLmQQsAm1ExnY6RpBj2gXgYg1lu+QAJ9y7GZQcq40AB4plO9Ds6vRp2B/rWn+3CMeTEgN62b43LLeClSWmWtGPPE9qm57R+f8ItS4z4aLRi88QEiyPG9Qkn+DBufCVBKZdnpuCq4uWxb1r8p3xYhA01ipwqU3kEJ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318279; c=relaxed/simple;
	bh=KsFuDdmHVUNStA4sv4Yo8JQTbghbT9Geq1tm71pFoYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQeXfhKX2vH02iMbtk5UchWAiQN5DOU8c+sOrMhtuXU5USWrIkXZLOxRWEKqhlB6E2E3WStBuIofAT9SoqfybYwucNcy03ocpsK4mqFzs+85P/sqD08yicznd2a4oykRxtfd8nWYY/+yl6bquVAjLgSmj2t3AuUtaYQBu+ZQIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WlC42VNk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B445V7J020221;
	Wed, 4 Dec 2024 13:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6kSzxwcWv3fB3wPageKcAnLH
	kyQmtDZtMwI8vGFdIds=; b=WlC42VNkB3XcdLi0m3o8EwKXwcjxPxg/MxgOuuEv
	uBURKv5mKblpP60CDpXn4JaxQf6nYS+gaCGi6hWKrb2G3FobhxIwdER8I6NnFA+O
	i/A86KlxVSQCHoNWkifcG1rBrH7h5FoPpiAHpF/zrfMEJRcxxs/xUPQXvIlH+LDe
	Y7ARNiX/JBkUfUeWDYT3rL0tVYV3I+Vef93tOorACOtmNJs8bXps8tatWssZ29K+
	+JjmCQBtgx37JsMV8ygtLggWYXe8xMdkVUTnrhcP8/97YQdGL11DC2eD0U5aKG0c
	1GcuAtRNhwXIQGIrLTto1i4/WI14L/UA+Ip0or0pMwQf/w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43a3exb8tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 13:17:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B4DHo34030578
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 13:17:50 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 05:17:44 -0800
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konradybcio@kernel.org>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v4 4/4] power: sequencing: qcom-wcn: add support for the WCN6750 PMU
Date: Wed, 4 Dec 2024 18:47:06 +0530
Message-ID: <20241204131706.20791-5-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241204131706.20791-1-quic_janathot@quicinc.com>
References: <20241204131706.20791-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3iwO9-LMCPNWTWMLnJZNApmGcp80MA0w
X-Proofpoint-GUID: 3iwO9-LMCPNWTWMLnJZNApmGcp80MA0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412040102

Enable support for controlling the power-up sequence of the PMU inside
the WCN6750 model.

Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 682a9beac69e..e38da79f0ada 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -293,6 +293,24 @@ static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn6855_of_data = {
 	.targets = pwrseq_qcom_wcn6855_targets,
 };
 
+static const char *const pwrseq_wcn6750_vregs[] = {
+	"vddaon",
+	"vddasd",
+	"vddpmu",
+	"vddrfa0p8",
+	"vddrfa1p2",
+	"vddrfa1p7",
+	"vddrfa2p2",
+};
+
+static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn6750_of_data = {
+	.vregs = pwrseq_wcn6750_vregs,
+	.num_vregs = ARRAY_SIZE(pwrseq_wcn6750_vregs),
+	.pwup_delay_ms = 50,
+	.gpio_enable_delay_ms = 5,
+	.targets = pwrseq_qcom_wcn_targets,
+};
+
 static const char *const pwrseq_wcn7850_vregs[] = {
 	"vdd",
 	"vddio",
@@ -431,6 +449,10 @@ static const struct of_device_id pwrseq_qcom_wcn_of_match[] = {
 		.compatible = "qcom,wcn7850-pmu",
 		.data = &pwrseq_wcn7850_of_data,
 	},
+	{
+		.compatible = "qcom,wcn6750-pmu",
+		.data = &pwrseq_wcn6750_of_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pwrseq_qcom_wcn_of_match);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


