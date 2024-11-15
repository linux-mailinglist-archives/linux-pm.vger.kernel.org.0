Return-Path: <linux-pm+bounces-17597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4693B9CD9ED
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 08:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B2828310D
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56731891AB;
	Fri, 15 Nov 2024 07:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QESEqBpg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1DB1885A1
	for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655710; cv=none; b=C2ByH4zDS+FRJEy9D+T9nZwe3YWdrzZ336EvYLE/iZ/mIEBVBEISFQvypBZ+qEewDvgZQW1dJN/sshDh6ARL/YbiwwEqM/z4uGXO6X7Sv9WkOb+stecxRaDyXjjgFpjUcb6Knw6Fft4dUvngMlMffx2v2uB1gNJlG9jElSIW+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655710; c=relaxed/simple;
	bh=6BEPIqlBVHJZyi2Sf0fYAB4CnTBbuvd5Fhv964Cngnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIpKhJ5G2/++YeNzi7IjZjzUIiaO7OYNWsVpFWo2R5I1zBT8y62HU+p1njSzAAje8YMgXt7L583LYLlXgZ+keGLHMNp25wGNwMNBFfqI3oxWczuXUvS+B3BcgiQ3jaJXo6QfKPXI0kutR9jrx3jdqZXU11IDVNQBKjmafLcgL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QESEqBpg; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so14477311fa.3
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 23:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731655707; x=1732260507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/GwN7axuFnJwGV4zNdR/K7IbEiX+PCDHxU+ABf832Zg=;
        b=QESEqBpgmSYwJlWLppr9+Iwk7jG83lobN2S+0ERHf5ikJHdD4gVlzHbHHeoJco0Zj5
         c/ywvkU+3rR1PWT64oVwlA01PjCrwmKWnKhyVg7Z02uv7iFizax4uxTuDxJpk1d79uwD
         yTn63b5AT2hGqiUGVZ1Ib9cF4MlYv1UksJaqU3WfAMorDBk2rICM5TQY3pcAZ+j2CB0m
         6vbWl8vfKCQ/2onQJ2WS/7kvExkpa73mKT97IIHS1/srOpBlT9HKxvI64SrIsxGqZBVU
         7OoNtrS0lQlH+8A/BMEfhnT1M5EtQZx10tgLjqoiCIyBxr1KHeWTnOA7aoki2UeMMT/L
         SHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731655707; x=1732260507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GwN7axuFnJwGV4zNdR/K7IbEiX+PCDHxU+ABf832Zg=;
        b=vEH2BreSbL8MfAopyYe/Q0N1Jzb0JEg1WJUTRq6Acw4VL9z/5u6NyR7CwJCBrYIm6z
         UFRQmlSh0lC5BYP+kK91kAMFjS+gukitNa6qHoPmGeFZ/GY6JLcfy4eN75ICcOUSP/wC
         Q9XCRG5w7eU+OeGNCOTKwTrk0xkY0q0/ep90nXNm74tjyRMIJ7cxvOPTRdJXXtnFsKRj
         LAnMOK9uKCHiTxVYfv8zTaXJ+yTGf/bqEMamj91uLydgUCb1tlK+N0sMxd+qKPvJ89eQ
         QDXoRT1VHhSKMugnbS0v4b6yzmen8dPWncyEyKjhVzRhn5E2O3OcVsNb6EMXnAzG3Kd+
         EOVg==
X-Forwarded-Encrypted: i=1; AJvYcCXVnnNS50ClgKIRAJjbx4PpvYZU37HRnY/+s4yvKuWt6SdxrIQOMbKhLXxjLau4qu6EDCes3A45nQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuWb2uMQs253IQz0G/E3HG9M8f/bHn5Thrg8zIIgAFlcpakzNZ
	bJdySjrIgeenhJ4ZbVNVwMe1YBwNaIZT7EhxctIyqbZQXz0QbytvqC/r5DiLlSc=
X-Google-Smtp-Source: AGHT+IHI9ax56yXePo1V9MbCWM4uPRipd+fXjT7Ug8imMQgOMNPQ6F5cq7l/TiXiyQtSP+9DaXDpmw==
X-Received: by 2002:a05:651c:1551:b0:2fa:c014:4b6b with SMTP id 38308e7fff4ca-2ff609d868fmr7153221fa.41.1731655706847;
        Thu, 14 Nov 2024 23:28:26 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff597a053bsm4547781fa.56.2024.11.14.23.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:28:25 -0800 (PST)
Date: Fri, 15 Nov 2024 09:28:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 5/8] drm/msm: adreno: find bandwidth index of OPP and
 set it along freq index
Message-ID: <ith6te3m4cjwjyxrsxpjsvqsyjr3qrmlyyo7cucljuweuzn37b@lmd5b5mqwkbw>
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
 <20241113-topic-sm8x50-gpu-bw-vote-v1-5-3b8d39737a9b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-topic-sm8x50-gpu-bw-vote-v1-5-3b8d39737a9b@linaro.org>

On Wed, Nov 13, 2024 at 04:48:31PM +0100, Neil Armstrong wrote:
> The Adreno GMU Management Unit (GMU) can also scale the DDR Bandwidth
> along the Frequency and Power Domain level, until now we left the OPP
> core scale the OPP bandwidth via the interconnect path.
> 
> In order to enable bandwidth voting via the GPU Management
> Unit (GMU), when an opp is set by devfreq we also look for
> the corresponding bandwidth index in the previously generated
> bw_table and pass this value along the frequency index to the GMU.
> 
> Since we now vote for all resources via the GMU, setting the OPP
> is no more needed, so we can completely skip calling
> dev_pm_opp_set_opp() in this situation.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 17 +++++++++++++++--
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c |  6 +++---
>  3 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 504a7c5d5a9df4c787951f2ae3a69d566d205ad5..1131c3521ebbb0d053aceb162052ed01e197726a 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -113,6 +113,7 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
>  	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>  	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>  	u32 perf_index;
> +	u32 bw_index = 0;
>  	unsigned long gpu_freq;
>  	int ret = 0;
>  
> @@ -125,6 +126,16 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
>  		if (gpu_freq == gmu->gpu_freqs[perf_index])
>  			break;
>  
> +	/* If enabled, find the corresponding DDR bandwidth index */
> +	if ((adreno_gpu->info->quirks & ADRENO_QUIRK_GMU_BW_VOTE) && gmu->nr_gpu_bws) {
> +		unsigned int bw = dev_pm_opp_get_bandwidth(opp, true, 0);
> +
> +		for (bw_index = 0; bw_index < gmu->nr_gpu_bws - 1; bw_index++) {
> +			if (bw == gmu->gpu_bw_table[bw_index])
> +				break;
> +		}
> +	}
> +
>  	gmu->current_perf_index = perf_index;
>  	gmu->freq = gmu->gpu_freqs[perf_index];
>  
> @@ -140,8 +151,10 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
>  		return;
>  
>  	if (!gmu->legacy) {
> -		a6xx_hfi_set_freq(gmu, perf_index);
> -		dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
> +		a6xx_hfi_set_freq(gmu, perf_index, bw_index);
> +		/* With Bandwidth voting, we now vote for all resources, so skip OPP set */
> +		if (bw_index)

if (!bw_index) ???

Also should there be a 0 vote too in case we are shutting down /
suspending?

> +			dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
>  		return;
>  	}
>  
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> index 95c632d8987a517f067c48c61c6c06b9a4f61fc0..9b4f2b1a0c48a133cd5c48713bc321c74eaffce9 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> @@ -205,7 +205,7 @@ void a6xx_hfi_init(struct a6xx_gmu *gmu);
>  int a6xx_hfi_start(struct a6xx_gmu *gmu, int boot_state);
>  void a6xx_hfi_stop(struct a6xx_gmu *gmu);
>  int a6xx_hfi_send_prep_slumber(struct a6xx_gmu *gmu);
> -int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, int index);
> +int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, int perf_index, int bw_index);
>  
>  bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu);
>  bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu);
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> index 9a89ba95843e7805d78f0e5ddbe328677b6431dd..e2325c15677f1a1194a811e6ecbb5931bdfb1ad9 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -752,13 +752,13 @@ static int a6xx_hfi_send_core_fw_start(struct a6xx_gmu *gmu)
>  		sizeof(msg), NULL, 0);
>  }
>  
> -int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, int index)
> +int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, int freq_index, int bw_index)
>  {
>  	struct a6xx_hfi_gx_bw_perf_vote_cmd msg = { 0 };
>  
>  	msg.ack_type = 1; /* blocking */
> -	msg.freq = index;
> -	msg.bw = 0; /* TODO: bus scaling */
> +	msg.freq = freq_index;
> +	msg.bw = bw_index;
>  
>  	return a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_GX_BW_PERF_VOTE, &msg,
>  		sizeof(msg), NULL, 0);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

