Return-Path: <linux-pm+bounces-17982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790EE9D6B13
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 20:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2ECB2168E
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 19:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8E81494CC;
	Sat, 23 Nov 2024 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ToBDugRi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133A27466;
	Sat, 23 Nov 2024 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732389998; cv=none; b=eLTJvmbWcKGE1yiTJ7eJZN/djVvtMjHLBmxl6NzO8xJzk1GqmUQJcaIowBtyAU5bYgIACANN5AERsRgrSlfT0CHXJ+FO3D2rO4c4YZYHa5fg/XNsnBYTnMCmkMyh7ZuMCiwm7vn1nEFs8n4EK6xZpSCYa1w7J2ph/tLNtPRF7ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732389998; c=relaxed/simple;
	bh=9JLZnnIB7zwmNSPsfgDlDPtfuRw6R7JhHsKzWaXMMTk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HveA8ei5XN60KuqRL5BjqA2NxjhZhPZBZx9lAO3KSu3u9mPtezfdB9GyD7W6SGc2q92FzqLa8FuHQCThRqLVkKFSjQ8IH2Bbi6gs+2QnQFEMsXDUldjQkrAraVHbJ3pEkoM92Um8JS2Mwhx9iGACrvNbtmdSmb2LOWtmtS1tOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ToBDugRi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ANFl84c013054;
	Sat, 23 Nov 2024 19:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NRXy+WaClMyD5mBSqvP8rvqS
	m5kZz4d92lObXBf9Tv4=; b=ToBDugRiDcrOaGD0AMxVdIsS85LLTy2xtP41PfLf
	mGsYu/uzm3D+ITo37eRb/c8ftGHHra/uqpkkubHtQLA1lcbDSrzgRdYI1ORbBU/w
	lWcF/hBVTTPTM7uszRU9Ic1Fg8EWVutEcuTmZpa//A0cqK71lDK73QCym7QFto83
	Rh0fxF+fqYX1sLLTfcTzn3gBfOeQi/X6Sqg9ZOya/fZigHGPDVEbhvmGl4knG3gD
	Iogw8eAAG46UDNiJgyJjMo/So9Cc7EjN2GXo+PSbh3u4brpP83HTzFmRw1tTfRQD
	xeZ035P3jVI9X7dMhSsVcG/uKFkmVqfONaXftTbEUgmwgQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4336cfh8vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Nov 2024 19:26:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ANJQ2iQ016077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Nov 2024 19:26:02 GMT
Received: from hu-akhilpo-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 23 Nov 2024 11:25:55 -0800
Date: Sun, 24 Nov 2024 00:55:51 +0530
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
CC: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 02/11] drm/msm: adreno: rename quirks that are features
Message-ID: <20241123192551.ederap4nmtjifrdq@hu-akhilpo-hyd.qualcomm.com>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-2-4deb87be2498@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-2-4deb87be2498@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pzO3esH0_xtko1A528ZAYHMs4ugmBeD0
X-Proofpoint-ORIG-GUID: pzO3esH0_xtko1A528ZAYHMs4ugmBeD0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=998 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411230160

On Tue, Nov 19, 2024 at 06:56:37PM +0100, Neil Armstrong wrote:
> Half of the current "Quirks" are in fact features, so rename
> the defines with FEAT instead of QUIRK.
> 
> They will be moved in a separate bitfield in a second time.
> 
> No functional changes.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c  | 62 +++++++++++++++---------------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  4 +-
>  drivers/gpu/drm/msm/adreno/adreno_device.c |  2 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  7 ++--
>  4 files changed, 38 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 0c560e84ad5a53bb4e8a49ba4e153ce9cf33f7ae..825c820def315968d508973c8ae40c7c7b646569 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -743,7 +743,7 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_512K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a615_zap.mbn",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -769,7 +769,7 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_512K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT,
>  		.init = a6xx_gpu_init,
>  		.a6xx = &(const struct a6xx_info) {
>  			.protect = &a630_protect,
> @@ -839,7 +839,7 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_512K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a615_zap.mdt",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -864,8 +864,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_512K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_HAS_HW_APRIV,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
> +			  ADRENO_FEAT_HAS_HW_APRIV,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a620_zap.mbn",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -892,7 +892,7 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_1M,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a630_zap.mdt",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -911,7 +911,7 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_1M,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a640_zap.mdt",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -934,8 +934,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_1M + SZ_128K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			ADRENO_QUIRK_HAS_HW_APRIV,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
> +			ADRENO_FEAT_HAS_HW_APRIV,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a650_zap.mdt",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -961,8 +961,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_1M + SZ_512K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			ADRENO_QUIRK_HAS_HW_APRIV,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
> +			ADRENO_FEAT_HAS_HW_APRIV,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a660_zap.mdt",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -981,8 +981,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_1M + SZ_512K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			ADRENO_QUIRK_HAS_HW_APRIV,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
> +			ADRENO_FEAT_HAS_HW_APRIV,
>  		.init = a6xx_gpu_init,
>  		.a6xx = &(const struct a6xx_info) {
>  			.hwcg = a690_hwcg,
> @@ -1000,8 +1000,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_512K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			ADRENO_QUIRK_HAS_HW_APRIV,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
> +			ADRENO_FEAT_HAS_HW_APRIV,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a660_zap.mbn",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -1028,7 +1028,7 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_2M,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a640_zap.mdt",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -1046,8 +1046,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_4M,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			ADRENO_QUIRK_HAS_HW_APRIV,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
> +			ADRENO_FEAT_HAS_HW_APRIV,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a690_zap.mdt",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -1331,7 +1331,7 @@ static const struct adreno_info a7xx_gpus[] = {
>  		},
>  		.gmem = SZ_128K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
> +		.quirks = ADRENO_FEAT_HAS_HW_APRIV,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a702_zap.mbn",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -1355,9 +1355,9 @@ static const struct adreno_info a7xx_gpus[] = {
>  		},
>  		.gmem = SZ_2M,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_HAS_HW_APRIV |
> -			  ADRENO_QUIRK_PREEMPTION,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
> +			  ADRENO_FEAT_HAS_HW_APRIV |
> +			  ADRENO_FEAT_PREEMPTION,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a730_zap.mdt",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -1377,9 +1377,9 @@ static const struct adreno_info a7xx_gpus[] = {
>  		},
>  		.gmem = 3 * SZ_1M,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_HAS_HW_APRIV |
> -			  ADRENO_QUIRK_PREEMPTION,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
> +			  ADRENO_FEAT_HAS_HW_APRIV |
> +			  ADRENO_FEAT_PREEMPTION,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a740_zap.mdt",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -1400,9 +1400,9 @@ static const struct adreno_info a7xx_gpus[] = {
>  		},
>  		.gmem = 3 * SZ_1M,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_HAS_HW_APRIV |
> -			  ADRENO_QUIRK_PREEMPTION,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
> +			  ADRENO_FEAT_HAS_HW_APRIV |
> +			  ADRENO_FEAT_PREEMPTION,
>  		.init = a6xx_gpu_init,
>  		.a6xx = &(const struct a6xx_info) {
>  			.hwcg = a740_hwcg,
> @@ -1422,9 +1422,9 @@ static const struct adreno_info a7xx_gpus[] = {
>  		},
>  		.gmem = 3 * SZ_1M,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_HAS_HW_APRIV |
> -			  ADRENO_QUIRK_PREEMPTION,
> +		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
> +			  ADRENO_FEAT_HAS_HW_APRIV |
> +			  ADRENO_FEAT_PREEMPTION,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "gen70900_zap.mbn",
>  		.a6xx = &(const struct a6xx_info) {
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 019610341df1506c89f44e86b8d1deeb27d61857..2ebd3fac212576a1507e0b6afe2560cd0408dd89 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2478,7 +2478,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>  	adreno_gpu->gmu_is_wrapper = of_device_is_compatible(node, "qcom,adreno-gmu-wrapper");
>  
>  	adreno_gpu->base.hw_apriv =
> -		!!(config->info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
> +		!!(config->info->quirks & ADRENO_FEAT_HAS_HW_APRIV);
>  
>  	/* gpu->info only gets assigned in adreno_gpu_init() */
>  	is_a7xx = config->info->family == ADRENO_7XX_GEN1 ||
> @@ -2495,7 +2495,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>  	}
>  
>  	if ((enable_preemption == 1) || (enable_preemption == -1 &&
> -	    (config->info->quirks & ADRENO_QUIRK_PREEMPTION)))
> +	    (config->info->quirks & ADRENO_FEAT_PREEMPTION)))
>  		ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs_a7xx, 4);
>  	else if (is_a7xx)
>  		ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs_a7xx, 1);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 9ffe91920fbfb4841b28aabec9fbde94539fdd83..09d4569f77528c2a20cabc814668c4c930dd07f1 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -207,7 +207,7 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
>  
>  	priv->is_a2xx = info->family < ADRENO_3XX;
>  	priv->has_cached_coherent =
> -		!!(info->quirks & ADRENO_QUIRK_HAS_CACHED_COHERENT);
> +		!!(info->quirks & ADRENO_FEAT_HAS_CACHED_COHERENT);
>  
>  	gpu = info->init(drm);
>  	if (IS_ERR(gpu)) {
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index e71f420f8b3a8e6cfc52dd1c4d5a63ef3704a07f..8782c25e8a393ec7d9dc23ad450908d039bd08c5 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -54,9 +54,10 @@ enum adreno_family {
>  #define ADRENO_QUIRK_TWO_PASS_USE_WFI		BIT(0)
>  #define ADRENO_QUIRK_FAULT_DETECT_MASK		BIT(1)
>  #define ADRENO_QUIRK_LMLOADKILL_DISABLE		BIT(2)
> -#define ADRENO_QUIRK_HAS_HW_APRIV		BIT(3)
> -#define ADRENO_QUIRK_HAS_CACHED_COHERENT	BIT(4)
> -#define ADRENO_QUIRK_PREEMPTION			BIT(5)
> +

IMO, we should not keep features separate. In future, we should just append the next
quirk/feature at the bottom without disturbing the existing bit
mappings. Just to ensure we don't accidentally duplicate a bit number.

I agree on using 'ADRENO_FEAT' to distinguish features.

-Akhil

> +#define ADRENO_FEAT_HAS_HW_APRIV		BIT(3)
> +#define ADRENO_FEAT_HAS_CACHED_COHERENT		BIT(4)
> +#define ADRENO_FEAT_PREEMPTION			BIT(5)
>  
>  /* Helper for formating the chip_id in the way that userspace tools like
>   * crashdec expect.
> 
> -- 
> 2.34.1
> 

