Return-Path: <linux-pm+bounces-13532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5269C96B4D5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 10:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F4A2B2439D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 08:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F0C1CC8B0;
	Wed,  4 Sep 2024 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G3IzgZ5g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C21CC145;
	Wed,  4 Sep 2024 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438933; cv=none; b=fIg0sV4Uo9yJMbWa+FLMLhvmhIoLJEhZr0x0mWZT5Uu/UrDUcepq7vSII9efqpoDY4YdIFi6VWPYS9RqRXGAWCWjv1ETsnK/r6b/U2OoyGtcv9ZBns9O4j5kYK3ALnUHVf5a6VjTcoHlsXxENobNHN8rak3a/s7rUwm+6xeOlRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438933; c=relaxed/simple;
	bh=NUlfW2fcFAtlZYTigQbpOX53gsDwiBJxJ0D0cgmgzIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kIeQm1CiskyAxuQ/E1x0/585jTQang+KEjyDUcuVNvrhl53DMi4PePMUIYwxYgF7j2y20y2eOhssQsVrmyOV0aEm0R1PZjNyLc5IYdPCKt/xprqsWYcXZDeZWUGDpG+WJLkoLwdvCTHrblbhsFmQ3NNTe3tjp8APWBjRfkcA+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G3IzgZ5g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4848KXuf009495;
	Wed, 4 Sep 2024 08:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9OkqXgP+KLa/2/+tehPx9LVC4VIKH5FkCorAROfvZyc=; b=G3IzgZ5gUYxOaJE1
	V0pVVPG0tD1MRETjlqqo+sflPTkOPFvd7zG/dtFzPPRJmcsW6/qba+AnFDtfDEXM
	EHkRezcvrbeVXLS8gJRzVpv0VGERe+brQQlOTu87+lXrVHN0rUnZxz5u9TPyAYa7
	RwIx257f/aFUqwase1nj28Om+GYXsb2MAVDmxwjhqTwex3RDfIfu8EN2J6aIqkem
	pK0xlsPQwwNkWNGhUhYw5DzhYajt0UhA/JkgApGdqLaOp/sKYQ8Sa6JbxEkF44FU
	UJZ1U7+5pC7nlJPINQIhk4eePssD1eVMRlEQZkfQDF9b63vK5tt2YGAAD9sZC3F+
	B+s4FQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41e0bhk8wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 08:35:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4848Z9jH030117
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 08:35:09 GMT
Received: from jingyw-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 01:35:01 -0700
From: Jingyi Wang <quic_jingyw@quicinc.com>
Date: Wed, 4 Sep 2024 16:33:48 +0800
Subject: [PATCH 07/19] pmdomain: qcom: rpmhpd: Add QCS8300 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240904-qcs8300_initial_dtsi-v1-7-d0ea9afdc007@quicinc.com>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
In-Reply-To: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, "Andy Gross" <agross@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
        Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh
	<quic_gurus@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones
	<lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, Jingyi Wang <quic_jingyw@quicinc.com>,
        Tingguo Cheng
	<quic_tingguoc@quicinc.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725438840; l=1659;
 i=quic_jingyw@quicinc.com; s=20240829; h=from:subject:message-id;
 bh=hz1lD5uBC7NgSpedT6G7gBtBmMuKqPdisyGX4o9be4M=;
 b=r5iEKgXRzUgLUqXKQQ6lY6dF+xYD9piv935nID6tuA1g+2S1XQECbpzjabyS/bd0LwIGWmPdm
 m4pPnwE47H3BHJ7jtNCClUgMrtHZEm9k8ZBTxF8+SWC97tGehxLLY6j
X-Developer-Key: i=quic_jingyw@quicinc.com; a=ed25519;
 pk=3tHAHZsIl3cClXtU9HGR1okpPOs9Xyy1M0jzHw6A/qs=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tL7J73z-ES22nOsCfl5UftRZz7_6PrJm
X-Proofpoint-GUID: tL7J73z-ES22nOsCfl5UftRZz7_6PrJm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_05,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040065

From: Tingguo Cheng <quic_tingguoc@quicinc.com>

Add support for the power-domains found on QCS8300 platform.

Co-developed-by: Shazad Hussain <quic_shazhuss@quicinc.com>
Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index d2cb4271a1ca..d79321b08d16 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -623,7 +623,31 @@ static const struct rpmhpd_desc x1e80100_desc = {
 	.num_pds = ARRAY_SIZE(x1e80100_rpmhpds),
 };
 
+/* QCS8300 RPMH power domains */
+static struct rpmhpd *qcs8300_rpmhpds[] = {
+	[QCS8300_CX] = &cx,
+	[QCS8300_CX_AO] = &cx_ao,
+	[QCS8300_EBI] = &ebi,
+	[QCS8300_GFX] = &gfx,
+	[QCS8300_LCX] = &lcx,
+	[QCS8300_LMX] = &lmx,
+	[QCS8300_MMCX] = &mmcx,
+	[QCS8300_MMCX_AO] = &mmcx_ao,
+	[QCS8300_MXC] = &mxc,
+	[QCS8300_MXC_AO] = &mxc_ao,
+	[QCS8300_MX] = &mx,
+	[QCS8300_MX_AO] = &mx_ao,
+	[QCS8300_NSP0] = &nsp0,
+	[QCS8300_NSP1] = &nsp1,
+};
+
+static const struct rpmhpd_desc qcs8300_desc = {
+	.rpmhpds = qcs8300_rpmhpds,
+	.num_pds = ARRAY_SIZE(qcs8300_rpmhpds),
+};
+
 static const struct of_device_id rpmhpd_match_table[] = {
+	{ .compatible = "qcom,qcs8300-rpmhpd", .data = &qcs8300_desc },
 	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &qdu1000_desc },
 	{ .compatible = "qcom,sa8155p-rpmhpd", .data = &sa8155p_desc },
 	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },

-- 
2.25.1


