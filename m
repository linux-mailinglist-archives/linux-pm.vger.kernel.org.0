Return-Path: <linux-pm+bounces-17986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656C99D6BFE
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 00:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF2316175C
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 23:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60751AA789;
	Sat, 23 Nov 2024 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BozWns9o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064C1A4E9E;
	Sat, 23 Nov 2024 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732402820; cv=none; b=Kg+7gpnNXG7cASRUeNFKA50aLhMKvHGHEkMcuOqotuY9CeF9hY0RRZP3Ubk5YeUplqu8m/1aSq8NfeJlGIaNPQWmQ2uHFaiU0t7fp2vQkDbPDMUMIC7ADwei5EJPgskt82L4oykVkypzRhePmHM82PqEcigcXpqd+cQe01f7QNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732402820; c=relaxed/simple;
	bh=uN74WQ2ZwE3oU4k1atJsAUJRMs5T5pzS3BqepRuHv4o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6c9CnNFsFypIT4skCJOjgMgf1zVtQvp8Qu4524eS+dq+dbMGwEc9JlT77UDlW4zQvlqmnqEbulZMYB/lsonhnGfL4SnFeW405Eq2QnbkHzyYrvRi8sv/Lgdv204GqpGqjqAGGrRwc4WBQFWGmTdqzHprPP1JB8jiJaRmCRVOu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BozWns9o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ANMlUeN020736;
	Sat, 23 Nov 2024 23:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=z1Th407nZNKUJgy0+yOGqGyJ
	+2HnOT3I/5BrbLrTlfc=; b=BozWns9ohixfdCf/+oBB1JgFEV4/p+Xp3tL5mk0o
	G0qoOVnYU+zXFlvZpFXFM+967ltCskaIY0adtU7eMt+4kmzJM9Ix1A9m6lVOY7Sh
	CTNiZZorID+yINvafUZfL2YWSzI7e/WbTiPEeLv96Au2Us2crm5MfNamZ0M058f4
	tpH3hXETpeY7YqmXijN9KlWnQJPLLHAJCgBJev0sJYm/aMDs9TKLxRs8N+/0bifD
	ct9ACYBiI9T3e+zveC/6I4ou2YkW5q1NjqFOw+h6ufUHhWT00uqLBIknlBLddey8
	FTAzhKGW902OJPtBi/z8ElBOS/foZjbtFX0sLMaZpQObfQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4336mx9dnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Nov 2024 23:00:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ANN05PF028434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Nov 2024 23:00:05 GMT
Received: from hu-akhilpo-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 23 Nov 2024 14:59:58 -0800
Date: Sun, 24 Nov 2024 04:29:54 +0530
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
Subject: Re: [PATCH v2 08/11] drm/msm: adreno: request for maximum bus
 bandwidth usage
Message-ID: <20241123225954.lv3k2fxk7rxyh67z@hu-akhilpo-hyd.qualcomm.com>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-8-4deb87be2498@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-8-4deb87be2498@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: v9k5cxrwlBXoB2WC5EZWTBQoTzJsZLpU
X-Proofpoint-GUID: v9k5cxrwlBXoB2WC5EZWTBQoTzJsZLpU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411230192

On Tue, Nov 19, 2024 at 06:56:43PM +0100, Neil Armstrong wrote:
> When requesting a DDR bandwidth level along a GPU frequency
> level via the GMU, we can also specify the bus bandwidth usage in a 16bit
> quantitized value.
> 
> For now simply request the maximum bus usage.

Why? You don't care about power efficiency?
Lets drop this patch. We don't care about AB vote yet.

-Akhil

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 11 +++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.h |  5 +++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index dc2d0035544e7848e5c4ea27f1ea9a191f9c4991..36c0f67fd8e109aabf09a0804bacbed3593c39d7 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -134,6 +134,17 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
>  			if (bw == gmu->gpu_bw_table[bw_index])
>  				break;
>  		}
> +
> +		if (bw_index) {
> +			/*
> +			 * Append AB vote to the maximum bus usage.
> +			 * AB represents a quantitized 16bit value of the
> +			 * max ddr bandwidth we could use, let's simply
> +			 * request the maximum for now.
> +			 */
> +			bw_index |= AB_VOTE(MAX_AB_VOTE);
> +			bw_index |= AB_VOTE_ENABLE;
> +		}
>  	}
>  
>  	gmu->current_perf_index = perf_index;
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
> index 528110169398f69f16443a29a1594d19c36fb595..52ba4a07d7b9a709289acd244a751ace9bdaab5d 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
> @@ -173,6 +173,11 @@ struct a6xx_hfi_gx_bw_perf_vote_cmd {
>  	u32 bw;
>  };
>  
> +#define AB_VOTE_MASK		GENMASK(31, 16)
> +#define MAX_AB_VOTE		(FIELD_MAX(AB_VOTE_MASK) - 1)
> +#define AB_VOTE(vote)		FIELD_PREP(AB_VOTE_MASK, (vote))
> +#define AB_VOTE_ENABLE		BIT(8)
> +
>  #define HFI_H2F_MSG_PREPARE_SLUMBER 33
>  
>  struct a6xx_hfi_prep_slumber_cmd {
> 
> -- 
> 2.34.1
> 

