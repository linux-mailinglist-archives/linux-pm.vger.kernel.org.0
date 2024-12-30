Return-Path: <linux-pm+bounces-19857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 940B19FEAEF
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 22:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87953A2272
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 21:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09FF19CCFA;
	Mon, 30 Dec 2024 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l/cAwYbW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6415E8B;
	Mon, 30 Dec 2024 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735593113; cv=none; b=iUBCSk3FpgvnipCPRy+X0IgsL7Sjt37NwAyEe7PygFMtEdzpjlx//JU7KzqqtMwitj1oSFyewXAWS+gX1f5nDaIgKoawUWbOQ9auV4J5zZx48mrBcklHEs4+/f3v4s77D3iQS33jTM1ngQQAxFhR9/8taauvOuiEiElG5HFpPiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735593113; c=relaxed/simple;
	bh=lpNlkaAqDtGPqRgiubmBGv2n/ovMOYsokcd/+h9OBho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PImd3jn9n7wMDpBFqyfS60ZSsx/be3UJhCBMJsopZtfWz/H22Wcuv5WY5JpAe4KueLYg0pTwiDpC/3fsPQ0WL6Gn3gKhrHR9TatSW7xaYUxNsuBHnGTMg1aE1Iqw/ulMk+u9thlUFbd9mmWWtm3n/KLEwjTpywWfScL5IgfK6ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l/cAwYbW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUJr0qb020786;
	Mon, 30 Dec 2024 21:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s0wRUiY8vAjGesEaJhQA+W2SjHVAeRkNYjaOj1bFXzo=; b=l/cAwYbWyCSiKk+X
	Jl69qogN3ahCVMfAuuVBeupmUlLRvlSMpUM1THubSD0qqBEvU7WpQtMXkfz0WUS/
	r21qrjvqfnpRrs+0wH0800eLIjyegtD/EXBviqjjVXM/khMLzJp0sloIXljzp2jp
	fk5tPMJPz1rEOUDyYkA7vQXYy52wMmJyEWUePUPI4N1uJoeWFBlM+IFf/4n3HqjP
	fDf1QA1tsI887tjt0IeQS+RHkjUrXFgdK3ximat6y36V4gIgKVk1PG5GwfQ3yyI5
	pjPLjYYzG3KKijpkUnl0uRb8l6Hj3L9kdkodHw+fhQhgNEo9l/wlqZlJmIcpvh/l
	0eHzVg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43v22g837w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 21:11:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BULBe8L031272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 21:11:40 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 30 Dec
 2024 13:11:34 -0800
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Date: Tue, 31 Dec 2024 02:41:04 +0530
Subject: [PATCH v3 3/6] drm/msm/adreno: Add module param to disable ACD
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241231-gpu-acd-v3-3-3ba73660e9ca@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735593076; l=1711;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=lpNlkaAqDtGPqRgiubmBGv2n/ovMOYsokcd/+h9OBho=;
 b=sOr2aJQWROaa3nLhC2l8DCdK1I/G7GXbiFaNYHE9t2BHsXj7tFTfFGtnTCNoTe/sWQx441QnK
 8AIHtoMP5EBAZcUrorNfbs3sxWdFvWy4EQXB0kJ7rHn2pMditbgNkGB
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NAYz6TGJw9tR8m-H8f51kBm4sLQ-TZlp
X-Proofpoint-ORIG-GUID: NAYz6TGJw9tR8m-H8f51kBm4sLQ-TZlp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412300182

Add a module param to disable ACD which will help to quickly rule it
out for any GPU issues.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 7 +++++++
 drivers/gpu/drm/msm/adreno/adreno_device.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 1f213a0fc61b..ce08eed572c8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1475,6 +1475,13 @@ static int a6xx_gmu_acd_probe(struct a6xx_gmu *gmu)
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	struct msm_gpu *gpu = &adreno_gpu->base;
 	int ret, i, cmd_idx = 0;
+	extern bool disable_acd;
+
+	/* Skip ACD probe if requested via module param */
+	if (disable_acd) {
+		DRM_DEV_ERROR(gmu->dev, "Skipping GPU ACD probe\n");
+		return 0;
+	}
 
 	cmd->version = 1;
 	cmd->stride = 1;
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 236b25c094cd..f4552b8c6767 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -24,6 +24,10 @@ int enable_preemption = -1;
 MODULE_PARM_DESC(enable_preemption, "Enable preemption (A7xx only) (1=on , 0=disable, -1=auto (default))");
 module_param(enable_preemption, int, 0600);
 
+bool disable_acd;
+MODULE_PARM_DESC(disable_acd, "Forcefully disable GPU ACD");
+module_param_unsafe(disable_acd, bool, 0600);
+
 extern const struct adreno_gpulist a2xx_gpulist;
 extern const struct adreno_gpulist a3xx_gpulist;
 extern const struct adreno_gpulist a4xx_gpulist;

-- 
2.45.2


