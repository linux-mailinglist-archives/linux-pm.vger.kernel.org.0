Return-Path: <linux-pm+bounces-26605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F34AA7EEF
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 09:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14BF9A0D9E
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 07:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A66F1B0F2C;
	Sat,  3 May 2025 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SM8nAmAG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8CE1AF0C9;
	Sat,  3 May 2025 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746255879; cv=none; b=TlPQAipNNSGYHTnWzpG27BHgyT5x4UePU9kKXZW9suVWHcYHbBauKPrpw0RfNMHLC/TQasJzPrO1ilFIydJR3o4gUDsgGeGx2A5VSTxmY4j9FiG3VVn0H9Swv7nJpoEv074GzwkL4KUaa16Q8YLtRACu5+SDPRoPGM/LUdiDBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746255879; c=relaxed/simple;
	bh=N4N6dwePYp5Vs27WGpHvYGNNjmelirXtqdGazYh5FY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SPOFRcJgXg0rwrIjA4IiwN7geHVk/p2GnMn5pbFb6sfgngRp+rtSfRGri8sm9HIW2n+I/fdYxOaHlGAb++B+WC5zl8qxjHeJSEOEO+mIRe0TWWqhosIouFRFY+e47VunWxh2+O5ZtaD1Ive0P89Hfe5ohcnptcMGXfe6zg6/9K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SM8nAmAG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5434oMpL019280;
	Sat, 3 May 2025 07:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/vllXR7e4NUWfiMM/xV4egZDWMK0j+VWhYdt8vmi7Kc=; b=SM8nAmAGp8flqaNd
	WA8nnlMwsUGRGvLKa2imUZ+HD+SaKtzZK3Yqs4uV6NpnaKikWxsPREn4PX4UNhN/
	okOLZNzjDcJPHtYI7PFSM78s7edrsQoinSAtgzuOk9qGWE/1Hvw7rTLLDmFIJrDS
	5I9f8GWmDww0uYVzkhXh72R3NoZ86sf7wrDYwmJySIWlLDxga5vdTcPl4uAcJrTv
	tmnuOKKJcEXNEAC3X8KRpasUfTUt7PoC07dTcp7MO5AlINWLiYuhQn9KD5MmyIKl
	OIPOV4BTl8X7Iumj+VmwcAuYaRNZL+xA0GXcTFt5p/unKKxNoxBJAYR4fc3MiX+e
	xBQWqg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dbc5877e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 May 2025 07:04:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54374F0p001711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 May 2025 07:04:15 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 3 May 2025
 00:04:08 -0700
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Date: Sat, 3 May 2025 12:33:33 +0530
Subject: [PATCH v6 2/7] drm/msm/a6xx: Increase HFI response timeout
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250503-gpu-acd-v6-2-ab1b52866c64@quicinc.com>
References: <20250503-gpu-acd-v6-0-ab1b52866c64@quicinc.com>
In-Reply-To: <20250503-gpu-acd-v6-0-ab1b52866c64@quicinc.com>
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
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746255835; l=1125;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=N4N6dwePYp5Vs27WGpHvYGNNjmelirXtqdGazYh5FY4=;
 b=HzsoMNF9ga3+oEtobFQiKOuivAD/opckcvvawADKGuXuXnk95RwlGUXXKoG7BnBPJuTqIXvaz
 UVZM2qaqZiKC9Erz1wGEXBtc7qk0q2ozkVrNi443DC9PNdUdvXFCK4W
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nOjmRXkSpGjBGgIvKtnsA3Mt7a4DCJYT
X-Authority-Analysis: v=2.4 cv=O7Y5vA9W c=1 sm=1 tr=0 ts=6815bfef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8
 a=b3CbU_ItAAAA:8 a=COk6AnOGAAAA:8 a=adu2xZl7kSneRhG-aSEA:9 a=QEXdDO2ut3YA:10
 a=Rv2g8BkzVjQTVhhssdqe:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: nOjmRXkSpGjBGgIvKtnsA3Mt7a4DCJYT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAzMDA1OSBTYWx0ZWRfX+QHobTLZiphK
 tVlH0GphqrKDIF78w86FMbqEsAmOrc7PXi0PX1GJrOSk9WeqEtbeD+rrgLUVSU8P16sM9Q8pNGd
 pD0DvVlHpGa+AE3yO9udlFZHsSCLSnDw/khGx92kQMxWrxFQkG7qziBetSe/t1/vBBwVHo2oEhH
 TciyoYCAQlyn5CJlzsIPRaFCBy6WmO6SJb/d03O07xh85emNluV38kud0sSinwwasVNQi1Qn47q
 A3do0PV9DotvTzdkt8kftX9qAxYZ7HM/koOLO60NkC+/4fNeQ44h4Cw8EkncKHkZrLRWCXydHQM
 QSvefTrUwXKldhwyRUdtPxAtkV60021sbNvRwPZ+i8QUVTlFvGxIw/o79HnWfR+8zgfMjA7mVKl
 B5tnwauTGs7GtXe8XV7k+LHcazHAAIQAJ8oY1Dw81m09xTAOCtk2U06EworP3pTQb/N6Qrja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-03_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505030059

When ACD feature is enabled, it triggers some internal calibrations
which result in a pretty long delay during the first HFI perf vote.
So, increase the HFI response timeout to match the downstream driver.

Tested-by: Maya Matuszczyk <maccraft123mc@gmail.com>
Tested-by: Anthony Ruhier <aruhier@mailbox.org>
Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index b256092596fbab86d4eb8c17ac7c89cf94827105..d0ddae1617c3213a1bb2cb5c18b8653c5c1689e6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -109,7 +109,7 @@ static int a6xx_hfi_wait_for_ack(struct a6xx_gmu *gmu, u32 id, u32 seqnum,
 
 	/* Wait for a response */
 	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_GMU2HOST_INTR_INFO, val,
-		val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 5000);
+		val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 1000000);
 
 	if (ret) {
 		DRM_DEV_ERROR(gmu->dev,

-- 
2.48.1


