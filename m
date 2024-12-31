Return-Path: <linux-pm+bounces-19867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 225659FEE96
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 10:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4FF160CB6
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 09:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744051925AF;
	Tue, 31 Dec 2024 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DzFJZ+ym"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807F18A95A
	for <linux-pm@vger.kernel.org>; Tue, 31 Dec 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735638487; cv=none; b=Drhkm8LHBiPGZ33bwNYaEPauhcTrVXzY1hUG055vEJECQualavdrqjt6P1aP4XlSl9+K3AjkyYPMpNcW32mAobPK5zbsmag91mTUzDLxBSSDGnzKsTTF6w+WYXonA/4JCSRleYNvQBvIcxinDBlvNLKPFoKePHu3RM+1VpY6Bzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735638487; c=relaxed/simple;
	bh=S/qG145yAfvNp4G1vLggA8m9dSSsBxt4fvmZzzDVHDU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mmFz40stZN8/3nXvsxUIFg/0wFzPmEH8BbrN2mBRTZDJJFiXILoVjbketj3BS+L4UexkftcIfzwVEiMimpZDOOgS56sGGZzGciv3GOslvZuFy6Q1Lhh5KD9PdKL2EbWCe6IjGxgxwg2u2/IaHGtVDmQnNWnfKH8HzCrN0QzW0sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DzFJZ+ym; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso104518845e9.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Dec 2024 01:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735638483; x=1736243283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeRwnqhfF+7/JAAgCsoF3hFLXg3W1APinrWGayK28XY=;
        b=DzFJZ+ym6xv/GPlF8dFp+OQ0lDZpddqh/XVrlR7bhkwzKmWXyF+Ol0rnoJ1M4VGvyL
         4/uuIaLje+Sahbyqz8FbVvTO9pGyDqAO7IphxswZXQbMk0UKrCc28j+eitDqRHC/VyXi
         qpZAbFw8B6/F3y4FuftI4mnaiJZBj92dM63Pv94h9t4wcuodsr2/AbJEqKvyG4K3GYmn
         s1cVCJTZDHHdZhMVyzKJORm2hGG8jl/mDhYtF7akTL+3jyJQy+UtjacEQhtYF1HXQhPm
         0pcRrSlNMDUJbeZB1xRSly8JIGBIX0PnDliOe7oC/wLC4EIgbccO6JOKb3ZiL1tPfCei
         bILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735638483; x=1736243283;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HeRwnqhfF+7/JAAgCsoF3hFLXg3W1APinrWGayK28XY=;
        b=KjgLQWs0EeOyjbPRGg3p3P+QE8FjqEZm4ZAQ6qzz64pfK09V2ek/e4boGY3JfZAAay
         q+Whea3IFHFkkm06WJFSltFXNs552Jsjq+6HJ0I7YDF+KQ+wIO4jJnDXUaE6xQM571Ju
         r7zATbMd9fnL5TtcmrcT6+3msObpa+MYPWi31J/AFPUesjvb1egg1JZsj/nblU/1d2oq
         LB6dSKaCtBJQ4qzKLwlMJNODyiddkdGTeiQYsKJ51nGJkD/sh+3NJAC0KwhmD0R7iiC8
         E5A429pF+fENE4aGGqX5hmN8QdQp+ajz7qkJMMU24yWgx/TKkbsTBWicpe/DDN6d10af
         fl3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOXUa8sZBCioe2M/ezTOiySs7TIYT+66+2hBqTkI6AiRr4hJ/twxE2HjBoPre3E30hSEQHrgG1uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVsWdlrmkfdwFrFf7lr0E7IFchbqSdt98VPM+jkZFZ9A4wfIqO
	dRm469p/xJeWiSBoHS5jyVyP3f2vUIvrszGAEZmZWd9jUhcnV2lIqIsCUPjCA1s=
X-Gm-Gg: ASbGncsD59pPSHbFS/kDRvH8qZrpUKbaoiF1YxHW1Gysot79gFeAxWtoXXRIOKqYUD5
	XrNhXXZfl0/+bPuxA2Dg34HlHf/1B4ap2iQbV0CnWBw3jSNPTxFESSVWT4DuHoA6OX4aPONgVoh
	iQq7uTPZjZ6rI4e9PaYLU8PLLAt5VWXR7DL6qaYinZmdsuedflODq7foCG8T4+WljQOvu+1YBNk
	n7+5sXS5LhKNwAqwrTkAVTyyqj88j4Gkx9sHzRDu28H1GqD72r2SjFNkQ4DuXIz0I6AGowe6dpI
	Spmu30Vf6QVcDecGIqBB7Wxs/be3Xx8dRA==
X-Google-Smtp-Source: AGHT+IEGg6YSZQT43oiZ32HhVcPdM98GCfS5GJPSKrOlCvZn4fYTA3U+3B7+/7dEhUB5UITV+Oy6hA==
X-Received: by 2002:a05:600c:35cb:b0:434:a386:6cf with SMTP id 5b1f17b1804b1-43668548b49mr298952635e9.2.1735638482765;
        Tue, 31 Dec 2024 01:48:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:add3:e25d:7204:9ee5? ([2a01:e0a:982:cbb0:add3:e25d:7204:9ee5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c4b0sm383297725e9.35.2024.12.31.01.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2024 01:48:01 -0800 (PST)
Message-ID: <ae360497-84d5-4153-8bc4-b3943fb30dc5@linaro.org>
Date: Tue, 31 Dec 2024 10:48:00 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 1/6] drm/msm/adreno: Add support for ACD
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
References: <20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com>
 <20241231-gpu-acd-v3-1-3ba73660e9ca@quicinc.com>
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
In-Reply-To: <20241231-gpu-acd-v3-1-3ba73660e9ca@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/12/2024 22:11, Akhil P Oommen wrote:
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


Seems you still don't send the proper acd_table

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


