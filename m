Return-Path: <linux-pm+bounces-20117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2A5A0666C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 21:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7AFF7A3417
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 20:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F6F202F99;
	Wed,  8 Jan 2025 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o2CV7QQN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEAA202F67;
	Wed,  8 Jan 2025 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368857; cv=none; b=tFFs2SFGutryuXNwLf/nnxvRrDGaK8LeCB4PQ6kU5b5SK3IdeitR+NdGrmFnM0R6DgmYtidVdQRGvFFP8HPb7o3vntV2hw9IOg8oVdG/4qZNaskQXn+KqhOA6wxWV3V5VC14RC2jhqfZDbdrgi6Vll4hCvBvif2T3VyrWLlcahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368857; c=relaxed/simple;
	bh=LIJHycaL94dEk0l+18Gerrip/wbM52F6u1uVOm5ErL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pd7kSTyMnkBotQ2pJttEgtHw4o2xqI9jVvo4wef/RmWAyX22hRq2oBye+hCfNpdMhNfrlcERYpZlCHKgRI8CXoA9Gzj3lRgBN/RzPXq/FktI+se/QA91tS7XjC+EgUoXeDQunOvX29HrzM0fcaZWcaIKGOO9VUYMf/10QD5pykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o2CV7QQN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508Em4ge027439;
	Wed, 8 Jan 2025 20:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wQfO43gc/5OxjAq/ikrGNs9SkW54HhEvyX2a2AA+4wQ=; b=o2CV7QQNpCpjGkx6
	lSdsSa1z3ucwNmryjsH0znq58PPA922XvIbkDsMLkD3eykIse0E//D6f4s6vaZGJ
	QXD7Xh0PzU3xJpmeZ2A/wCY0zkFiGyWkmI9+7xZWCvqRrpn3gf8nRqsVnL9ftgMd
	AQ5i/UWgV87qVRlnlyiQXABNETpIdQ3v6zCcAPWmTvlUVvxh8sx026rD6WiyrGA1
	MW6L8RE4ELoKN4TXYlnYfThnXkxDvcIrkKLMIyaP16MP4Q+KUi/c5pDKFi2gZMhU
	l58++pr75j7lwLpLQ4SWJEQsdqHw4s+XteAcOFMgtL9AeM/dRYmnujq8SN9YMTnp
	znB0yw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441uefrujx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 20:40:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 508Kek3h027067
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Jan 2025 20:40:46 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 Jan 2025
 12:40:40 -0800
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Date: Thu, 9 Jan 2025 02:09:59 +0530
Subject: [PATCH v4 3/7] drm/msm: a6x: Rework qmp_get() error handling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250109-gpu-acd-v4-3-08a5efaf4a23@quicinc.com>
References: <20250109-gpu-acd-v4-0-08a5efaf4a23@quicinc.com>
In-Reply-To: <20250109-gpu-acd-v4-0-08a5efaf4a23@quicinc.com>
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
	<andersson@kernel.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736368821; l=1085;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=LIJHycaL94dEk0l+18Gerrip/wbM52F6u1uVOm5ErL8=;
 b=yvlY1iBUrRusxbrVeuvFShFI6iDelQBWVmlSnxOVr0U0VOSXHDSL2Y+CpHrJO3emzBr9hYFGV
 pPpNniixCs/BOtq8zG0v88DSLX7kFiQzGO0zDCQuSvRFbOfV+DdEq9g
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DtyJgtE-PX3wxKQegIsCRdSPR-tcBRiz
X-Proofpoint-GUID: DtyJgtE-PX3wxKQegIsCRdSPR-tcBRiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=976
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080168

Fix the following for qmp_get() errors:

1. Correctly handle probe defer for A6x GPUs
2. Ignore other errors because those are okay when GPU ACD is
not required. They are checked again during gpu acd probe.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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


