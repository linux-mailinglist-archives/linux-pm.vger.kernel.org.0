Return-Path: <linux-pm+bounces-18807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFE39E907E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F191636AE
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 10:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0166D21B90D;
	Mon,  9 Dec 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KMDK/OqN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382A217F34;
	Mon,  9 Dec 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740549; cv=none; b=i8FPPKdJRXShQpE/oxPmwdt590ic+CuwNmqQdBUag/go42tBgdFdoRA7OuggPk7IPP3qy/JPiFvayLP+fgSYJwQXWdvIIe11JN1ikFljraX4MCtNHaFRGe3BMtm6KGzHDfrmfNb1lc7aIZo0ajZRf65IotFJDqoZKJvcK5sn/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740549; c=relaxed/simple;
	bh=lO0NSY8LMiuJW05Xvn1QEhsQUDgF7azuqtl0fNHFRuo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jyyh1ouwhvbff/PSsgo/7L8OmXD1tPC+pGwFPREfHrQvXBiVXSs/33YX6Ri+WCcEN78iVbd4o55OevSdOhA607Ubl0Fqhwu3vcX+CXbMMtz3KlJmUyCXx2B1oYIkGlnC58+5Z/pqSw/KArL/BxfNA1dOfosYcs6Tht6LwdsPxt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KMDK/OqN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AFEfa011260;
	Mon, 9 Dec 2024 10:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qhj1nivFGwsGQuyh9FdQA0o+
	5GmWqgiquJCRJfoBXuQ=; b=KMDK/OqNn7Shu7BwK8ke3I9GFRd0mKuRjrOB2Ksl
	RlpIH5RfYv7CcoT/shR1kssAMmJh2afC402j5Ky0XXkvx8YVeoZ9bslYJ2EQgVCo
	C+d68gn0ArZzoeExnSzKUWhJlH6pu5Vy7r1V8oHlg3lIoexV7bCowfU82Wj7PSJd
	mYR8hTAOaggx/p6JpE4i0Fw7/V5SxVsXykBvPzK82fzoWD617+NkhdWup/SdbAsm
	ru8Vhqm6BmXWbCTZ2JX6Bqg+JssRBkPUCEtz3qSi44TXXEatasKFtaoeTGUmAg3E
	ZZFnZuJYE0v2CR/4VSaKhVWSeu8UG+4tOpzy3cjRIJmPIw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdc6cc7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 10:35:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B9AZfCe009261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 10:35:41 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 02:35:35 -0800
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
Subject: [PATCH v5 4/4] power: sequencing: qcom-wcn: add support for the WCN6750 PMU
Date: Mon, 9 Dec 2024 16:04:55 +0530
Message-ID: <20241209103455.9675-5-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209103455.9675-1-quic_janathot@quicinc.com>
References: <20241209103455.9675-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 125Oze-hPZU82v66ayb2kUqB43xu4-lR
X-Proofpoint-GUID: 125Oze-hPZU82v66ayb2kUqB43xu4-lR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090082

Enable support for controlling the power-up sequence of the PMU inside
the WCN6750 model.

Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 682a9beac69e..cc03b5aaa8f2 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -272,6 +272,24 @@ static const struct pwrseq_qcom_wcn_pdata pwrseq_qca6390_of_data = {
 	.targets = pwrseq_qcom_wcn_targets,
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
 static const char *const pwrseq_wcn6855_vregs[] = {
 	"vddio",
 	"vddaon",
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


