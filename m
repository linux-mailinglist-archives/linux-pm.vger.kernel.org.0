Return-Path: <linux-pm+bounces-20135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79013A06F75
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 08:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B271A3A24DA
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 07:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19242215173;
	Thu,  9 Jan 2025 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErY6VSWT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE4C204688
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409235; cv=none; b=nzL6jaxcy4iP9TLeXU10xWuZk3aoHWkPzVynSpOxWaXQaEkyoAoNY8NM2Z2lwhwexj/ZsseHL0FAciQNiq86zj/L57UUUWhOZsCDmkFHvXjuyirJAEJutSrAEC6z4Y+0eHoqBvRkKe+WgrF/GYYRtDwAtamEuJECZj03BlV1yTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409235; c=relaxed/simple;
	bh=SUL1rwQxCeGoGIudfKxY19YuACvW07OmdyUWkGTWgfk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GxrdbYDolsLjDQUrPSNsZkorZHGD8W5KIPy1iFne+kAKx0kSXKH0jxpzAH6UfvaaMADa4eqqhgmLXnQLtnPjYKnHj7K9dyUEvurSAIyXmcYfX+9BTXWbmxBSyztgK2IoGs7+w3jELkwujak1lN2YKEZkjQ0AubmpUY+jrqHi5qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ErY6VSWT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862d6d5765so302637f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 23:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736409232; x=1737014032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYwrTFYhQZWChYoXnnLgK+gBgeb8rrd8GmS0pqeHRkQ=;
        b=ErY6VSWTO6vwZhC1OJ01OCF2P8YSh8XVwZf0/l9ts0WJXF3kq5/1ViVajin3HOrKem
         nfAScQe5v3FUZ+LpRvBgYJ+nD79h72ca6rJ43ShKIc7HYkWWfmrV06rGdsHhtR5//vOW
         A6xgdF1AaqPGi2yr3p+3QnlHZn4eDqy4t1btwpe/zlx6AJqQHXYkppJo2xeqbm/bfJhZ
         X+5LHB7eD3nUIxKGlip2TnqbqDV+Ut+avcIUILSMkN1TQ7yd+CEl5/cNKqjFXwWJokfc
         9GB3XIJK7nsJ30B/iysYtI2Ruy98HEKF4+NA9Mxqlj3QqXh7zKhR6BJSmg+jYXjKeegI
         ZSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736409232; x=1737014032;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pYwrTFYhQZWChYoXnnLgK+gBgeb8rrd8GmS0pqeHRkQ=;
        b=bsu2YQkeWG4rLLLCd007eCnkTkvSY64NKs5V9V7CdZFKveDdxIon90oVElAdm5VeSv
         j8/yoNX1Je+QKj2L7LhqzWaf0cj7aO4PBRgwBs/WdQNM36dojZZprcCwUj6bq3IslNTq
         5enRmQU/dNVv63cdWzBRKjYr8xRUiwnGc189FYarIZzuBvpDmrEN0HEKcVl00g2Gc4vi
         9CkkQdr5nBZa6UFcCu20EzHgOvs3fkOpZEGpxzVK0feB+etU7kLEjdziHQAstf1DUzeQ
         FBiCdUTeCdNvivK0HIXPk1a5lqOrQuKuIsUqorRuGMpgU9hkozOIHOh00DgXOG+9Yt6S
         DH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWc/2MYIx++ukU3eYia1CreyziFHIN/Gii3qVJpTDSR+6618QCD1QR0eclh0ruHfVPEYZK7WcCnUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YynpciyY4bjKOtwjk5ngJ8rK6O9QWNoF7wesLE+ggmsDWD+wYKi
	uudcnonrk2o/DfpLjHuVwCCUsj9gUUQ22EEpqQJKJcLVoih8a5UJoSlOyy4XwK0=
X-Gm-Gg: ASbGnctrB1d07xLFLqIZO/odTob2xIgO6IdVJ73h4MtN4RC+08RypILLCvFiZ9VdHHo
	y5s5C+FB47KeRuGJeQsULbLZZ1eQlLQ9Iq2+fxdhiCuNhdlzDaEF8l4WqVfV+ME8r9GyKsrXwdl
	ug59tEWD0xuGQzpavhuVyap/ynfp5J8G2pJ2Mef7VZeOEjQWn83D+DSSBa2dwoqJha6tiLWPyc8
	tB/1kini9/YOVDUOUBc9fi2fo5lnrkCDvLEW3wrw5SS35JvZDn/YKP4CVOiHXMZ6MrktrAtde/H
	NgFx4nJtFBuKBfyFydJLbprP1NAv9txrzQ==
X-Google-Smtp-Source: AGHT+IFlMDqZ1mwhTw65CziPYf+WzQqjwBtxBF1bx8FyjDt1mZKxdZTeMQjICpEpyRf86THO25H/Bg==
X-Received: by 2002:a5d:5f85:0:b0:387:86cf:4e87 with SMTP id ffacd0b85a97d-38a872deb33mr5392030f8f.15.1736409232106;
        Wed, 08 Jan 2025 23:53:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:688f:e09e:ce30:f1b2? ([2a01:e0a:982:cbb0:688f:e09e:ce30:f1b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89df1sm45491345e9.27.2025.01.08.23.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 23:53:51 -0800 (PST)
Message-ID: <5ace1905-cce0-4d32-9e38-5451e9466c88@linaro.org>
Date: Thu, 9 Jan 2025 08:53:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 1/7] drm/msm/adreno: Add support for ACD
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
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Maya Matuszczyk <maccraft123mc@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250109-gpu-acd-v4-0-08a5efaf4a23@quicinc.com>
 <20250109-gpu-acd-v4-1-08a5efaf4a23@quicinc.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250109-gpu-acd-v4-1-08a5efaf4a23@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/01/2025 21:39, Akhil P Oommen wrote:
> ACD a.k.a Adaptive Clock Distribution is a feature which helps to reduce
> the power consumption. In some chipsets, it is also a requirement to
> support higher GPU frequencies. This patch adds support for GPU ACD by
> sending necessary data to GMU and AOSS. The feature support for the
> chipset is detected based on devicetree data.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 84 ++++++++++++++++++++++++++++++-----
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
>   drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 36 +++++++++++++++
>   drivers/gpu/drm/msm/adreno/a6xx_hfi.h | 21 +++++++++
>   4 files changed, 132 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 14db7376c712..2689e79aefa5 100644
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
> @@ -1476,6 +1468,68 @@ static int a6xx_gmu_pwrlevels_probe(struct a6xx_gmu *gmu)
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
> +	}
> +
> +	cmd->num_levels = cmd_idx;
> +
> +	/* It is a problem if qmp node is unavailable when ACD is required */
> +	if (cmd->enable_by_level && IS_ERR_OR_NULL(gmu->qmp)) {
> +		DRM_DEV_ERROR(gmu->dev, "Unable to send ACD state to AOSS\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Otherwise, nothing to do if qmp is unavailable */
> +	if (IS_ERR_OR_NULL(gmu->qmp))
> +		return 0;
> +
> +	/*
> +	 * Notify AOSS about the ACD state. AOSS is supposed to assume that ACD is disabled on
> +	 * system reset. So it is harmless if we couldn't notify 'OFF' state
> +	 */
> +	ret = qmp_send(gmu->qmp, "{class: gpu, res: acd, val: %d}", !!cmd->enable_by_level);
> +	if (ret && cmd->enable_by_level) {
> +		DRM_DEV_ERROR(gmu->dev, "Failed to send ACD state to AOSS\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static int a6xx_gmu_clocks_probe(struct a6xx_gmu *gmu)
>   {
>   	int ret = devm_clk_bulk_get_all(gmu->dev, &gmu->clocks);
> @@ -1793,7 +1847,7 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>   	gmu->qmp = qmp_get(gmu->dev);
>   	if (IS_ERR(gmu->qmp) && adreno_is_a7xx(adreno_gpu)) {
>   		ret = PTR_ERR(gmu->qmp);
> -		goto remove_device_link;
> +		goto detach_gxpd;
>   	}
>   
>   	init_completion(&gmu->pd_gate);
> @@ -1809,6 +1863,10 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>   	/* Get the power levels for the GMU and GPU */
>   	a6xx_gmu_pwrlevels_probe(gmu);
>   
> +	ret = a6xx_gmu_acd_probe(gmu);
> +	if (ret)
> +		goto detach_gxpd;
> +
>   	/* Set up the HFI queues */
>   	a6xx_hfi_init(gmu);
>   
> @@ -1819,7 +1877,13 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>   
>   	return 0;
>   
> -remove_device_link:
> +detach_gxpd:
> +	if (!IS_ERR_OR_NULL(gmu->gxpd))
> +		dev_pm_domain_detach(gmu->gxpd, false);
> +
> +	if (!IS_ERR_OR_NULL(gmu->qmp))
> +		qmp_put(gmu->qmp);
> +
>   	device_link_del(link);
>   
>   detach_cxpd:
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> index b4a79f88ccf4..87d225b08e9b 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> @@ -81,6 +81,7 @@ struct a6xx_gmu {
>   	int nr_gpu_freqs;
>   	unsigned long gpu_freqs[16];
>   	u32 gx_arc_votes[16];
> +	struct a6xx_hfi_acd_table acd_table;
>   
>   	int nr_gmu_freqs;
>   	unsigned long gmu_freqs[4];
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> index cb8844ed46b2..3c183c1c6266 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -702,6 +702,38 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
>   		NULL, 0);
>   }
>   
> +#define HFI_FEATURE_ACD 12
> +
> +static int a6xx_hfi_enable_acd(struct a6xx_gmu *gmu)
> +{
> +	struct a6xx_hfi_acd_table *acd_table = &gmu->acd_table;
> +	struct a6xx_hfi_msg_feature_ctrl msg = {
> +		.feature = HFI_FEATURE_ACD,
> +		.enable = 1,
> +		.data = 0,
> +	};
> +	int ret;
> +
> +	if (!acd_table->enable_by_level)
> +		return 0;
> +
> +	/* Enable ACD feature at GMU */
> +	ret = a6xx_hfi_send_msg(gmu, HFI_H2F_FEATURE_CTRL, &msg, sizeof(msg), NULL, 0);
> +	if (ret) {
> +		DRM_DEV_ERROR(gmu->dev, "Unable to enable ACD (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	/* Send ACD table to GMU */
> +	ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_ACD, &msg, sizeof(msg), NULL, 0);

It seems you still don't send the acd_table!

Neil

> +	if (ret) {
> +		DRM_DEV_ERROR(gmu->dev, "Unable to ACD table (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static int a6xx_hfi_send_test(struct a6xx_gmu *gmu)
>   {
>   	struct a6xx_hfi_msg_test msg = { 0 };
> @@ -799,6 +831,10 @@ int a6xx_hfi_start(struct a6xx_gmu *gmu, int boot_state)
>   	if (ret)
>   		return ret;
>   
> +	ret = a6xx_hfi_enable_acd(gmu);
> +	if (ret)
> +		return ret;
> +
>   	ret = a6xx_hfi_send_core_fw_start(gmu);
>   	if (ret)
>   		return ret;
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
> index 528110169398..51864c8ad0e6 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
> @@ -151,12 +151,33 @@ struct a6xx_hfi_msg_test {
>   	u32 header;
>   };
>   
> +#define HFI_H2F_MSG_ACD 7
> +#define MAX_ACD_STRIDE 2
> +
> +struct a6xx_hfi_acd_table {
> +	u32 header;
> +	u32 version;
> +	u32 enable_by_level;
> +	u32 stride;
> +	u32 num_levels;
> +	u32 data[16 * MAX_ACD_STRIDE];
> +};
> +
>   #define HFI_H2F_MSG_START 10
>   
>   struct a6xx_hfi_msg_start {
>   	u32 header;
>   };
>   
> +#define HFI_H2F_FEATURE_CTRL 11
> +
> +struct a6xx_hfi_msg_feature_ctrl {
> +	u32 header;
> +	u32 feature;
> +	u32 enable;
> +	u32 data;
> +};
> +
>   #define HFI_H2F_MSG_CORE_FW_START 14
>   
>   struct a6xx_hfi_msg_core_fw_start {
> 


