Return-Path: <linux-pm+bounces-25749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE223A943F3
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 16:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E492D7A3DCC
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 14:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691DE1E008B;
	Sat, 19 Apr 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="abTkPsnS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A1C1DFD95;
	Sat, 19 Apr 2025 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745074367; cv=none; b=jsxksUQN9P6vRvrOrk+8SsnAtMy77Ycjn1rU7A40i87LHVadlGP4Jk6N9rp/lnYFWX6YxpWkgy1Wc4DQiwuHjj8+Q6Lg3Rl/ypyFWwQF8ZVDtOHrEF3iBMx1Nnl8/EzE35C+0lFhZUL09UkzSPUHPkptEjWIK1iW1pMAK1hn7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745074367; c=relaxed/simple;
	bh=ircO9SakF3D2OTcHFawOAa4r4fU1O4jDNgu9Hw7XbZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bctfmpNbSYXPpVKRZ2/Yf2HztM9TVqy2pizIDXK+e2iu++og+hgZD0Lk64JsLhcm/dPx+wjnDvq8t/FpGk91E/dhDkBj0MnyuWoq8KkXrZqtjbuQIoiD4pvjXYtdjjh1+bxXWQ80Go6viXG9V+2No8Lvz6+yCGOsmfL+VWOV+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=abTkPsnS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JBZKdl028081;
	Sat, 19 Apr 2025 14:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kSEq/cMYthWnmBG8ilzZCdLeov6EdqxbKyWnzgr3lLQ=; b=abTkPsnSJVqKy7k/
	y85p1d8+gLMMP/qLMLISAsOf7ebL2y45DQPqYjRX2PM9NRIhf5DB1RzM51/vX8Np
	TSFy27NfW7U33uSQfOTWAhc4zf8abcSxWtS7kFmPRCk2jlllx3hPdPJktPEjstK0
	Ucbeb0OU9x7Ih6jiouBNUchTz15/OTZPyYAafNeojSrJXeikiijFZTDVDquCX65Z
	ambP2hjwpGsAMAhm3VoKnceIKWifmtbi9EkA88LgkBy3xtR0mLW4aHK+XioiqsKK
	czkgsEl0sSDkVsHR6ZKFfqF4ZAMnRFzPG1Xfgs1Cdmoz5wZw/rpz7KzdIDTwmyT1
	Qm3k9Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4644kj8kj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:52:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53JEqQgv010330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:52:26 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 19 Apr
 2025 07:52:19 -0700
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Date: Sat, 19 Apr 2025 20:21:32 +0530
Subject: [PATCH v5 3/7] drm/msm: a6x: Rework qmp_get() error handling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250419-gpu-acd-v5-3-8dbab23569e0@quicinc.com>
References: <20250419-gpu-acd-v5-0-8dbab23569e0@quicinc.com>
In-Reply-To: <20250419-gpu-acd-v5-0-8dbab23569e0@quicinc.com>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Akhil P Oommen
	<quic_akhilpo@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Maya
 Matuszczyk" <maccraft123mc@gmail.com>,
        Anthony Ruhier <aruhier@mailbox.org>,
        Dmitry Baryshkov <lumag@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745074319; l=1244;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=ircO9SakF3D2OTcHFawOAa4r4fU1O4jDNgu9Hw7XbZ0=;
 b=CinHFZ0e7D97dsEP/3xaPrF3B8t4dbuOv8Bi/OniGM8CeojwCcL4QjG0pOzVQswBp3UhLovx9
 RkAiznV/ek1C1EU/xkf6/2Qsoe6/s/Io7LRrmZp9td/qxt0f/enR3bX
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jfdjdhi4GTPMqb7OZTW4H9WHX-mTfCVx
X-Authority-Analysis: v=2.4 cv=f5pIBPyM c=1 sm=1 tr=0 ts=6803b8ab cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=b3CbU_ItAAAA:8 a=Q2ddA9Psw6g7R4ygXckA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-ORIG-GUID: Jfdjdhi4GTPMqb7OZTW4H9WHX-mTfCVx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190122

Fix the following for qmp_get() errors:

1. Correctly handle probe defer for A6x GPUs
2. Ignore other errors because those are okay when GPU ACD is
not required. They are checked again during gpu acd probe.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Maya Matuszczyk <maccraft123mc@gmail.com>
Tested-by: Anthony Ruhier <aruhier@mailbox.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 6bd6d7c67f98b38cb1d23f926b5e6ccbd7f2ec53..48b4ca8894ba38176481b62b7fd1406472369df1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2043,9 +2043,10 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
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
2.48.1


