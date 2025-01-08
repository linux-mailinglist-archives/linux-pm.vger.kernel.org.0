Return-Path: <linux-pm+bounces-20116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC70BA06668
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 21:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE89E7A24BB
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 20:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B8C20468C;
	Wed,  8 Jan 2025 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nq43vne/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8AE204681;
	Wed,  8 Jan 2025 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368851; cv=none; b=u8bO/d/ECi5pQpoZm839e/DGCj9oUBFWvTdJ4ky1YQxe5Wtm6+Rwjm9vNnBauDlp/31hw9yJzomQ00MIINqT5fyzvaEqxQ5LVsWNcD5HGV8AHw7YT1yexZEYgPjUyfc7288zEnqrq6SO50Pize4MoccviBGa/YFbOZkZ+fSF/s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368851; c=relaxed/simple;
	bh=5ytAEPpk+peT5jTuxMqYIAb/yYLt5D+AFkmAX3LLTf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eMci1JOZiLkJcpezL9FynFVN0vu9xjaoFjFhbSoLhgTsnsd757eNx6ubKRi9V+0/OgddGlQX48DU2G4hlLNEPGTDmw9LxSkyfZpjw+YGogH0di05zIMdY0Nwdbl8Af6QK6F6vs4KYg7/uBWdqAfj31jWZPPI/TY8VrI0j172GPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nq43vne/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508HbqhR011371;
	Wed, 8 Jan 2025 20:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wADXqIrY+qPwTvqLv5shbT7qMpXxzjIzS8x2sIAn57A=; b=Nq43vne/VLV0FvNm
	SCUkHxh6SlfSj5dPdDLUxCt/1j7ETjlRIDaa7NC3QFm3L11Ht7ZIHoUM+bJ3NGQf
	ZQJsZYSmgtIyEqvdFTiZyiTPDIHNnuGLzoaywHZtfsSCHNwMNPirjPlrw5wjah+t
	fETAGn3/UHgnqQSYXNT2DTx3tiUw9nliMJhlA15BdkVOHXr2fGFAexzrnmXQKFhX
	TL6dPE7oCdQEJ7wua2+PBxFsWLMAhL902a2apE7YvZ3plj9H0HATVTIEU9paHzOl
	S/XtKBGmhJuZpRH99TcEE/8izUK5j3ucStCPrwH9GSjvWwuQ97LMBb9TjHrsie3t
	2eJQ5w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441wx60dw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 20:40:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 508KedY8027015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Jan 2025 20:40:39 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 Jan 2025
 12:40:33 -0800
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Date: Thu, 9 Jan 2025 02:09:58 +0530
Subject: [PATCH v4 2/7] drm/msm/a6xx: Increase HFI response timeout
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250109-gpu-acd-v4-2-08a5efaf4a23@quicinc.com>
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
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736368821; l=1345;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=5ytAEPpk+peT5jTuxMqYIAb/yYLt5D+AFkmAX3LLTf4=;
 b=/5QY9TjFLZqW9f8LBK7QibCaUsdVTtq05I1XVM7UX44QB1jlDUZ5Y1qUqEERi70cgaEEIyP6p
 RoBLJumSb+gAGcZBftgNPIRgWr5zI31liwgW95kLiko9/mxaB5+5ONz
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LZ_psyO6nuU7RMn3T_RKWLeAU2kEEwjt
X-Proofpoint-ORIG-GUID: LZ_psyO6nuU7RMn3T_RKWLeAU2kEEwjt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501080168

When ACD feature is enabled, it triggers some internal calibrations
which result in a pretty long delay during the first HFI perf vote.
So, increase the HFI response timeout to match the downstream driver.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 3c183c1c6266..7d04b242363c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -108,7 +108,7 @@ static int a6xx_hfi_wait_for_ack(struct a6xx_gmu *gmu, u32 id, u32 seqnum,
 
 	/* Wait for a response */
 	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_GMU2HOST_INTR_INFO, val,
-		val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 5000);
+		val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 1000000);
 
 	if (ret) {
 		DRM_DEV_ERROR(gmu->dev,
@@ -725,7 +725,7 @@ static int a6xx_hfi_enable_acd(struct a6xx_gmu *gmu)
 	}
 
 	/* Send ACD table to GMU */
-	ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_ACD, &msg, sizeof(msg), NULL, 0);
+	ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_ACD, acd_table, sizeof(*acd_table), NULL, 0);
 	if (ret) {
 		DRM_DEV_ERROR(gmu->dev, "Unable to ACD table (%d)\n", ret);
 		return ret;

-- 
2.45.2


