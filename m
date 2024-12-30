Return-Path: <linux-pm+bounces-19856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E85E9FEAE9
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 22:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60167188354C
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 21:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F46519D898;
	Mon, 30 Dec 2024 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="evUrMAYA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645DC15E8B;
	Mon, 30 Dec 2024 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735593105; cv=none; b=fUN8wfyt3hVY+wD0pLXI2IYMB1fjbByV4FTJ8OF2sHzSJCxyBDhcfRdBJ1qyAZFZmvrhfYulEeKjC4xN+s7Pga8IOqKxAVYjLKHpnvk1u/J3r4nLSYEOiuljclk+gXYKNIDv77qOGVQqvxlvC+y8u4+kgzqCnXxuqPLgNzSkl8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735593105; c=relaxed/simple;
	bh=uGJKj6k2bqQ8r5r+/W10Z1D00Gn+f/6dRKjYo9GiPis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YRdAudRbW7Y/OvbBA0MRJiEbTCIPMbtCUCJOwuqhHUwHaSjJcysYY4Z2iXP6pxk78eCAxayhodNJ3l3GyuphnQc1bh6NQnj647dbqfav+AfKZ3towMK4WAGVVSqVNj8KKfv5W5GLk56+/9DDxljlJ3B85kgsG54LJpasdzqnWg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=evUrMAYA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUIj2gA004809;
	Mon, 30 Dec 2024 21:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bs0BF4ztIUXJZiaiy5BCCNqD8IYJZG4CJVmSwmfK9hw=; b=evUrMAYAZDHadB1c
	XSbyTW9/VIe6VzkdIz0jWE8no3aYSSpglIOF7k5HZG5+MxqQ5NBw3SghT470bc1w
	wN2KUSptEVzBvjQz9nf3NHb9gwrTFMMOQJ6WwfT5V1toXPHwcPuqdt6KQe6yRRAh
	CWGm+cBQvNolCKGYRLqzcQqmPdho8OgU+81CtHLZPr4xedyTiu4TLv+ihcsTAClF
	Jq1pM47JQ965QMNiuO23Cvq6jao5gVyL9V7iogDIy+kC/sjMvALhODlSSQ9j+uQA
	rxtI2TtVCIKHWz0X9FIalRjd0N4LmMt3wCGT9GMvrVAOzGrgOkQXSPtyTvfHIC1G
	Hjl2pA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43uu4ss2xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 21:11:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BULBYCB031254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 21:11:34 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 30 Dec
 2024 13:11:28 -0800
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Date: Tue, 31 Dec 2024 02:41:03 +0530
Subject: [PATCH v3 2/6] drm/msm: a6x: Rework qmp_get() error handling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241231-gpu-acd-v3-2-3ba73660e9ca@quicinc.com>
References: <20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com>
In-Reply-To: <20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon
	<nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735593076; l=1024;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=uGJKj6k2bqQ8r5r+/W10Z1D00Gn+f/6dRKjYo9GiPis=;
 b=/HTIrMhs7V1V/F1ZmjU8RpXydeLB3+ZclM30JrzS83HdTkJJJIugEp4itKHSaiOXoCMGZ+IJa
 sDe3Jw5+fObBh9FdwDcKmW8MOqtHD1b4ebeDK/RS57QXvfZcfWfSyWz
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OBhhYEmcTxO1lryVxT9AMZqQRIoivH5C
X-Proofpoint-GUID: OBhhYEmcTxO1lryVxT9AMZqQRIoivH5C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=972 impostorscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412300182

Fix the following for qmp_get() errors:

1. Correctly handle probe defer for A6x GPUs
2. Ignore other errors because those are okay when GPU ACD is
not required. They are checked again during gpu acd probe.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 2689e79aefa5..1f213a0fc61b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1844,9 +1844,10 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 		goto detach_cxpd;
 	}
 
+	/* Other errors are handled during GPU ACD probe */
 	gmu->qmp = qmp_get(gmu->dev);
-	if (IS_ERR(gmu->qmp) && adreno_is_a7xx(adreno_gpu)) {
-		ret = PTR_ERR(gmu->qmp);
+	if (PTR_ERR_OR_ZERO(gmu->qmp) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
 		goto detach_gxpd;
 	}
 

-- 
2.45.2


