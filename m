Return-Path: <linux-pm+bounces-16198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A72A99A9DF0
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 11:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387321F2715B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 09:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4123158DAC;
	Tue, 22 Oct 2024 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5KBmYDS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8071940B9
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588081; cv=none; b=RKL7a+G8FKaFiMDcqXipaFNCe2z+IlnResrZ8xxes23X3jgHL8uBSZTfvgWrA6vdtcrG6gE2wJWloE6Nn313z1B6CnhlQZubY38tENJ4lSDNRl6LSIDRlpIdAnLprUxdX3ax6WwsIUkh19KezAMgEejQWJ9SezFtXvsgatAFUes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588081; c=relaxed/simple;
	bh=pysn6nWm7VH7Da+e1O+B858W3dG1ImyoY2oZIhE1dqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7Ugk9o7aWvf1rzb1r8fI86AplftEaxYp3GFTvA1eLdDqsCl9B4pUh0kNIwnPJbylOLMlpwqg4rxQCYUXOfdv1su+KSxPoe1lNE+IZBdGj3GKwFdOuefKBsRQXlN85tSaqliqH3blN66CEcnmC5GS9KHMlSCKMd2eLbyzJBX7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O5KBmYDS; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a850270e2so489622466b.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 02:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729588078; x=1730192878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sqANacwu59WVDubToPeLNd0ZLGqiBFI013WHEtWvuoY=;
        b=O5KBmYDS0Stfg84yUL2nST6Zvalu4l4l6bLQT5TA216sumVAH4lu22MqfhgU1h5Pon
         gUDvOIvhfo3JOL+R2sIjQrqMz2rgudqBbzBx6CDtiZeFLR1ECXtpm1jBnrRIt0ZfFR+u
         Z5DeBN1NVNVYls5QRcO0TLNBX2+tZ2Dq+n7gJZM5zU4bNjfA/5GVUewDb94tVP68c1tS
         A3wGWpuYJ38l/9sh8k0oRu5iEddG8gCM1wvUdv7VvLENkmi/svsN97cTG60IY5osdhP6
         BOQnSLQqKD+lzlnWKvTdjVEs5td5dVG1rie6/hx3WZe7j11gwCZbFEluguyVx6ALhkks
         qk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729588078; x=1730192878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sqANacwu59WVDubToPeLNd0ZLGqiBFI013WHEtWvuoY=;
        b=P4JS85JLW5OQjfLONdX+JGFealNWG9NILL7RBeUwitBRCQ0NgMgAE+0IZT84pJwMFA
         /YCRryELEvBV5tFGiYeYdALrDxgyawYFaayBRVbKr60eoa2bge9oMGhH8+Ug1jTzYzAG
         DARF01FYvP4SPn45gly7Eg9Fr4lipNUi5yJ5Co9Y+/MB+x1FLZW74dNPtlfB4qHdTFze
         BT0w/mSHYxqpEytq6t42dVHw5k0wbTaUeJQ2ZzUDLHNuRT1jzq1kCuyF5DjlVSSC5uFs
         aGMPR9SI9g6wJH55uU5hRi40l5D91LQSXddr0drkOSoJCs4XSSOlsjlZ2ns7DhX3NNF6
         gSrg==
X-Forwarded-Encrypted: i=1; AJvYcCWdnhAZSF2fy8+LoK/GvzMiI7HWW1JZRvJ9zAn1E1phW9AppmTKLcZsdSu1rPIqMv9/onRchVT0jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL61gIzrsfreXZxgpg4C/AfiNV5isKwHGsMy9BLJTz78fMDQXd
	QpTArrC7f4LkO1YCgn9NlRZb5r2BmS1kfjgOvO6x+WcH3iPuPP1gQsnzJdaHD5I=
X-Google-Smtp-Source: AGHT+IGoE+jrhGDPxvzS+WZimT/uQDCBFmA0e0z1M8EFELzXgykeI+0Jev6cLL5gP+5Bp6fGDKWWLg==
X-Received: by 2002:a17:907:3e12:b0:a9a:4fd3:c35f with SMTP id a640c23a62f3a-a9a69a63db8mr1206244266b.9.1729588077786;
        Tue, 22 Oct 2024 02:07:57 -0700 (PDT)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6267sm311979566b.32.2024.10.22.02.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 02:07:57 -0700 (PDT)
Message-ID: <3ee7a1c9-2d6d-4fd5-982e-d86151e45662@linaro.org>
Date: Tue, 22 Oct 2024 10:07:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/msm/adreno: Add support for ACD
To: Akhil P Oommen <quic_akhilpo@quicinc.com>, Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20241021-gpu-acd-v2-0-9c25a62803bc@quicinc.com>
 <20241021-gpu-acd-v2-1-9c25a62803bc@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241021-gpu-acd-v2-1-9c25a62803bc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/10/2024 12:53, Akhil P Oommen wrote:
> ACD a.k.a Adaptive Clock Distribution is a feature which helps to reduce
> the power consumption. In some chipsets, it is also a requirement to
> support higher GPU frequencies. This patch adds support for GPU ACD by
> sending necessary data to GMU and AOSS. The feature support for the
> chipset is detected based on devicetree data.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 81 ++++++++++++++++++++++++++++-------
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
>   drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 36 ++++++++++++++++
>   drivers/gpu/drm/msm/adreno/a6xx_hfi.h | 21 +++++++++
>   4 files changed, 124 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 37927bdd6fbe..09fb3f397dbb 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1021,14 +1021,6 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>   
>   	gmu->hung = false;
>   
> -	/* Notify AOSS about the ACD state (unimplemented for now => disable it) */
> -	if (!IS_ERR(gmu->qmp)) {
> -		ret = qmp_send(gmu->qmp, "{class: gpu, res: acd, val: %d}",
> -			       0 /* Hardcode ACD to be disabled for now */);
> -		if (ret)
> -			dev_err(gmu->dev, "failed to send GPU ACD state\n");
> -	}
> -
>   	/* Turn on the resources */
>   	pm_runtime_get_sync(gmu->dev);
>   
> @@ -1476,6 +1468,64 @@ static int a6xx_gmu_pwrlevels_probe(struct a6xx_gmu *gmu)
>   	return a6xx_gmu_rpmh_votes_init(gmu);
>   }
>   
> +static int a6xx_gmu_acd_probe(struct a6xx_gmu *gmu)
> +{
> +	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> +	struct a6xx_hfi_acd_table *cmd = &gmu->acd_table;
> +	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +	struct msm_gpu *gpu = &adreno_gpu->base;
> +	int ret, i, cmd_idx = 0;
> +
> +	cmd->version = 1;
> +	cmd->stride = 1;
> +	cmd->enable_by_level = 0;
> +
> +	/* Skip freq = 0 and parse acd-level for rest of the OPPs */
> +	for (i = 1; i < gmu->nr_gpu_freqs; i++) {
> +		struct dev_pm_opp *opp;
> +		struct device_node *np;
> +		unsigned long freq;
> +		u32 val;
> +
> +		freq = gmu->gpu_freqs[i];
> +		opp = dev_pm_opp_find_freq_exact(&gpu->pdev->dev, freq, true);
> +		np = dev_pm_opp_get_of_node(opp);
> +
> +		ret = of_property_read_u32(np, "qcom,opp-acd-level", &val);
> +		of_node_put(np);
> +		dev_pm_opp_put(opp);
> +		if (ret == -EINVAL)
> +			continue;
> +		else if (ret) {
> +			DRM_DEV_ERROR(gmu->dev, "Unable to read acd level for freq %lu\n", freq);
> +			return ret;
> +		}
> +
> +		cmd->enable_by_level |= BIT(i);
> +		cmd->data[cmd_idx++] = val;

How do you know that cmd_idx is always < sizeof(cmd->data); ?

> +	}
> +
> +	cmd->num_levels = cmd_idx;
> +
> +	/* We are done here if ACD is not required for any of the OPPs */
> +	if (!cmd->enable_by_level)
> +		return 0;
> +
> +	/* Initialize qmp node to talk to AOSS */
> +	gmu->qmp = qmp_get(gmu->dev);
> +	if (IS_ERR(gmu->qmp)) {
> +		cmd->enable_by_level = 0;
> +		return dev_err_probe(gmu->dev, PTR_ERR(gmu->qmp), "Failed to initialize qmp\n");
> +	}
> +
> +	/* Notify AOSS about the ACD state */
> +	ret = qmp_send(gmu->qmp, "{class: gpu, res: acd, val: %d}", 1);
> +	if (ret)
> +		DRM_DEV_ERROR(gmu->dev, "failed to send GPU ACD state\n");
> +
> +	return 0;

Shouldn't the ret from gmp_send() get propogated in the return of this 
function ?

i.e. how can your probe be successful if the notification failed ?

---
bod

