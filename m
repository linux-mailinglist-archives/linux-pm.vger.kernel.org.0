Return-Path: <linux-pm+bounces-13527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AEE96B4AD
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 10:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15A52881E3
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 08:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A961CC8AD;
	Wed,  4 Sep 2024 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YU71RR4e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5B91CC894;
	Wed,  4 Sep 2024 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438893; cv=none; b=KBZ4EC+YS+SvE+mqoXbVkGVWREuyASDi5tklkFkQy+QyVeOtlPr50r6704KAu5U0j/OWStJcyASd45NkV0k+WgPGm36yQ98SAYB8yCI64dX5oLdEiQbpBdhirYR80cHbpIo5IrMGpcOJP9gacu5lGM3S7l3s3m56JTkQnDc5Dvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438893; c=relaxed/simple;
	bh=eRnHuM4fcfsWKej+awtm4axCjNDL8/ysx+AUsUyuYMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VkR08z5oGebh9GJqadHasmLg7cHwIZYUcSUnhXljQEZaxcPijcJHmYaL6p5QbPyWgs2VvbM3c+UDJBfjGRsgD3WYF0oxhypYdVv5nhrIKUrN4Ro4mfsi09pGkcWvvMd9FsL/KO69E6eyTmxwHELfh6T20//fBVWo+vcVWusQeJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YU71RR4e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483Md1eJ006005;
	Wed, 4 Sep 2024 08:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u8VhrvOn1bDEJCrKK7Ka8sNoIAYo6OaRkqqy/Ppi0Uo=; b=YU71RR4exEgTWS2m
	rSKaNaq9M5Pbw9K3Cn8F8cyxMBrYJzlBOcC/iUkhTmRq0RzR6PKd3U+/N5+ShEAu
	I2TyMgI90MbYnWTjgiHvF6Ju31PxveuMqTv0BoCvIkXVK+vH5LsZBorRFLvyDEf9
	DcjJlO46Wq2QtBpuucETI4z1NkV/1CQKv2SZm/+yFyu1LoUa0tCsPIstAyhn1qjU
	2zu/NzKnASe/XfaXqp/VElB1QLSgDmt1qB/jfjre3l8mRhSrZn8bZ+q1cA1+DCTI
	oEpD4CoatOjSNglxpJSeEsfJ2sB1KH4qtERHKDivDcu2zqQNWauV1pSxpEfw+Ij9
	++900w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt6725u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 08:34:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4848YRXh028503
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 08:34:27 GMT
Received: from jingyw-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 01:34:18 -0700
From: Jingyi Wang <quic_jingyw@quicinc.com>
Date: Wed, 4 Sep 2024 16:33:43 +0800
Subject: [PATCH 02/19] remoteproc: qcom: pas: Add QCS8300 remoteproc
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240904-qcs8300_initial_dtsi-v1-2-d0ea9afdc007@quicinc.com>
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
        Xin Liu
	<quic_liuxin@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725438840; l=1313;
 i=quic_jingyw@quicinc.com; s=20240829; h=from:subject:message-id;
 bh=eRnHuM4fcfsWKej+awtm4axCjNDL8/ysx+AUsUyuYMk=;
 b=0VjaWywdQz5GkkE0DsUVf3aRljLwu0/kQLKh6HQ1Tt/ZBlkBe0F7c5B0t3RGbnykOoV9rEhvg
 c0n8z31b6pLAKCAiRqWkHxl7EBnVfUYpasw4Xuja+dYClzJkZg8wBUn
X-Developer-Key: i=quic_jingyw@quicinc.com; a=ed25519;
 pk=3tHAHZsIl3cClXtU9HGR1okpPOs9Xyy1M0jzHw6A/qs=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hEjExQXcbG6sS79jjZa8D5NFZ_-GJ6wQ
X-Proofpoint-GUID: hEjExQXcbG6sS79jjZa8D5NFZ_-GJ6wQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_05,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040065

Add support for PIL loading on ADSP, CDSP and GPDSP on QCS8300
platform.

Co-developed-by: Xin Liu <quic_liuxin@quicinc.com>
Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index ef82835e98a4..f92ccd4921b7 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1416,6 +1416,9 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,qcs404-adsp-pas", .data = &adsp_resource_init },
 	{ .compatible = "qcom,qcs404-cdsp-pas", .data = &cdsp_resource_init },
 	{ .compatible = "qcom,qcs404-wcss-pas", .data = &wcss_resource_init },
+	{ .compatible = "qcom,qcs8300-adsp-pas", .data = &sa8775p_adsp_resource},
+	{ .compatible = "qcom,qcs8300-cdsp-pas", .data = &sa8775p_cdsp0_resource},
+	{ .compatible = "qcom,qcs8300-gpdsp-pas", .data = &sa8775p_gpdsp0_resource},
 	{ .compatible = "qcom,sa8775p-adsp-pas", .data = &sa8775p_adsp_resource},
 	{ .compatible = "qcom,sa8775p-cdsp0-pas", .data = &sa8775p_cdsp0_resource},
 	{ .compatible = "qcom,sa8775p-cdsp1-pas", .data = &sa8775p_cdsp1_resource},

-- 
2.25.1


