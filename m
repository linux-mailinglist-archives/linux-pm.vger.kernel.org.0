Return-Path: <linux-pm+bounces-8549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FAE8FA75E
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 03:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A305C2889A2
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 01:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9551B8C1F;
	Tue,  4 Jun 2024 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SJF+OxSc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB8171C1;
	Tue,  4 Jun 2024 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717463604; cv=none; b=ZErS8HHkswo2wcOhtsdINBHX5LdKcQqpSuScbugfg20DZxI/AY1Xte4VjPuivuuNRv3wRNj8VVh3bVtmoBlipxQnQPPqkjvE4cgW+uX6BtGms4BreFf7BAdT7OYjGgXJ8d2xHBZZ0GvAjfTrcYf1uJFHFUWa+lRxzMV6bDDRmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717463604; c=relaxed/simple;
	bh=3j3HIjtTgVidWtkhAO2CrZvRhljzkZZDGvZ4qwDnpiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgM42mFU2ToY2RK3xF9dFhdSsQzjf2MQLOgr3GmXu2/nIzJXR6Auv4gojKdjmFfZ/FRIStaMn4gmS0iDc+QZvG9/1ofBA5ykMobiVr9DOisr4Qp+QQ4mynbSdAQAn12iP19ZqGv6cwKcBLWh/7AfnuqvjYvjhoYhpOLwy7E/AGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SJF+OxSc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453BmAIw019501;
	Tue, 4 Jun 2024 01:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lzOVmMEApuLpA08skwJu0DPG7QwsD/G9jRyBvQwPAAc=; b=SJF+OxScXdxH8IYc
	cVD1oO3hIkWsZJ+NP+XRFRM4ydajG4SwI3ULWxc6ti2d9gtuMfBpZtVBHlPlxivE
	WAoGn/vtuuPLW4/3OBaFNl57ieViNwzmy61IuE3Lmbwbw4ozs1W85sd3sM5xcl/V
	kzcaLtlTv1RBjErLsT32OTGW+LldxITYHPphNHrFKpeYfTxl524j23zFi84vx0/e
	EXMz193pRWredRP/brYCJktqI80dbDp18EJF5BFteps8OnRDOIO/rI3e/4IHDB4E
	saEXs5bk/HzPackrqh9Cp/IYhxxLmsPHgsXZ9NRV8Do06hfP2H1cVanuD1vRS0U+
	jVvfyg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw3r5mra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 01:13:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4541DIq4002298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 01:13:18 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Jun 2024 18:13:13 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_sibis@quicinc.com>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <abel.vesa@linaro.org>
Subject: [PATCH 2/4] soc: qcom: icc-bwmon: Allow for interrupts to be shared across instances
Date: Tue, 4 Jun 2024 06:41:55 +0530
Message-ID: <20240604011157.2358019-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604011157.2358019-1-quic_sibis@quicinc.com>
References: <20240604011157.2358019-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nOdRoJV2NJdrFev0DGvr8lytCn47h2Ee
X-Proofpoint-GUID: nOdRoJV2NJdrFev0DGvr8lytCn47h2Ee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxlogscore=879
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040008

The multiple BWMONv4 instances available on the X1E80100 SoC use the
same interrupt number. Mark them are shared to allow for re-use across
instances.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/soc/qcom/icc-bwmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index fb323b3364db..d69e0797eeda 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -783,7 +783,8 @@ static int bwmon_probe(struct platform_device *pdev)
 	bwmon_disable(bwmon);
 	ret = devm_request_threaded_irq(dev, bwmon->irq, bwmon_intr,
 					bwmon_intr_thread,
-					IRQF_ONESHOT, dev_name(dev), bwmon);
+					IRQF_ONESHOT | IRQF_SHARED,
+					dev_name(dev), bwmon);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request IRQ\n");
 
-- 
2.34.1


