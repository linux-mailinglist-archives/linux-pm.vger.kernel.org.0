Return-Path: <linux-pm+bounces-20136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36730A06F7D
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 08:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB781677C1
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 07:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598AD215045;
	Thu,  9 Jan 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtnIEXAR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BCB215042
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409267; cv=none; b=Onn39+Eg3pCJyS7pKmIfIbrdUwmwIwXG2jXGIWXcMPHf30jvRZuUgUOuUG/PdIGNPDSp4fftGdLEUIWFjtiZzE4E6e6eCAf9c40mpgUq/0fdW3kcUhIZQBYR/9ick42zg/N3OfxDYIh0VrLa86arFaeAxGKLrKhfOD2fnEUBns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409267; c=relaxed/simple;
	bh=m3BbkyAs/kuM/3FyVhuJnZhbfy5lOL2xiebJ4xA403A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bOwD+2ZHb+rokrPjQwBLIw2NTaezlLtKl49bJsz8QKytEP5aquwq84cJynqocmQvKQlH1IUF6ThhN5eHT9tzSe7r2m3CJIMT0+GArZAEErVtA2YXUnBi2JP+/kvA3kHpMHblF+8eR0oFE/veKZmHX5p+KdJFrZnh0lvJ7TVxduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtnIEXAR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4362f61757fso6247765e9.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 23:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736409264; x=1737014064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDburU8EM+cyhb0IOZ8ZAadXRNXnF/xp0rz1w6CgrGM=;
        b=gtnIEXARO2OwHf1Nt9qJN8wzmMOigztguasLJ4uIdS3kBcTqI7ONw0ZmlcxZjRZYJa
         14hXZey0/MeaTmh9dJFlHnNKy2FzGPzGrl7P+U+te/TBNGp/osq+2M9ibA//6Jxh4G1W
         RgqaIyJPPL7ckK4XKV801w5tk2bH9cnOWZ7JXTTkkCdLtfDb96PNb5bwobPuQvgbt2L0
         4rAiIDCZEEz40bih+aoL6XM9FvJTaXz78dj109jySx8ROshsHfeu3vILzjIuWAVP3VHe
         kvwyCL6YM9Ja9WdGhN5S26IGw11UaGiNNJOqs0OgFMrNZzcvdb+2D373Yr/3Tl6yvySZ
         DN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736409264; x=1737014064;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SDburU8EM+cyhb0IOZ8ZAadXRNXnF/xp0rz1w6CgrGM=;
        b=MKHjMU3ck9STtb7u3kfNAK/Dp7U5I9EFsK1WXXhIrpLAAr9IhKDQS/A/2imhCw706t
         6N1R33tDGfW1JEuP1uy7kFArDeywjhfGhLfssP6GeC3wSN6LJOtp8yBaf9QaLaD3y2+7
         5qHWWz14E9niFherYq9mkwgoOCie4VKSMXSsH10AMKoZduh7z6hiwiXJ/KhqNrrbEA4J
         /ToBvjEOhk/JwS9G6VX+7jfVtEQm1NYzXG9neJponMHL0OBTHWYcnaFnKp96B/8zkDnZ
         ADR6BclX66P098GhlRqFFBuxbt1gFbH1nDfcR9o3xbiBDi9kgK9H5qq96uxR2JO/aVsk
         rKaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5/YHVfXPdabAVrCmsydnM00TUwX6nWfrFEP9GRfe7Y7+JNNSuvWWpgP+U40NZenXYvcIKqAw31Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQTM3bgUf7IoM7X2RN9o27ulA5GvHU8hH1/IXH+CMziyXgzsj
	qqcKJ7BO39+fzD/2o9kVtrfEcOn5LbMJf2jtMD3+Dtc4DsATZJen7rJHfuPIItQ=
X-Gm-Gg: ASbGncunTDfjBpTbCAXW74ERy0DdlXR0xg+ElC8WjrCYNFHJ1ljm/4xX/1d2Ear3bip
	SVUCWZcG402vXxPRaVu3xJjt/IAJGX/ldBC2tK5FgFUxzR6QIy43xLM2MuWNpapSd9OghlILKiP
	efk3MO2+L6x8eqPV2Y54ndH7LPh6/sQIpWo0i+9NwTAer3w3/a6gR3mMmmyYZR/Jowexj2kWDLC
	7srK9Lm0tZKaXhg9I0G/C0YQe5AQvx2/Q4Ty/XjfJ3tsV1Ug8vPQRauDYJAoK0vjZz4alZhuxWn
	SKIq75ulCOb3/1reV9MyenpW8nwmGrpZ7A==
X-Google-Smtp-Source: AGHT+IEGs+msZPIsIgrCbfJ6qv2MxuOOnLjQWHB0A0O0rUMX53v5jVSSQQyb1v/1WHGX+P63OGrEFA==
X-Received: by 2002:a05:600c:46d5:b0:434:ffd7:6fd2 with SMTP id 5b1f17b1804b1-436e26aeb4emr47286725e9.7.1736409263961;
        Wed, 08 Jan 2025 23:54:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:688f:e09e:ce30:f1b2? ([2a01:e0a:982:cbb0:688f:e09e:ce30:f1b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm45823095e9.9.2025.01.08.23.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 23:54:23 -0800 (PST)
Message-ID: <00a01ba3-8b03-4a41-a8a0-650aaf661f12@linaro.org>
Date: Thu, 9 Jan 2025 08:54:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 2/7] drm/msm/a6xx: Increase HFI response timeout
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
 <20250109-gpu-acd-v4-2-08a5efaf4a23@quicinc.com>
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
In-Reply-To: <20250109-gpu-acd-v4-2-08a5efaf4a23@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/01/2025 21:39, Akhil P Oommen wrote:
> When ACD feature is enabled, it triggers some internal calibrations
> which result in a pretty long delay during the first HFI perf vote.
> So, increase the HFI response timeout to match the downstream driver.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> index 3c183c1c6266..7d04b242363c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -108,7 +108,7 @@ static int a6xx_hfi_wait_for_ack(struct a6xx_gmu *gmu, u32 id, u32 seqnum,
>   
>   	/* Wait for a response */
>   	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_GMU2HOST_INTR_INFO, val,
> -		val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 5000);
> +		val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 1000000);
>   
>   	if (ret) {
>   		DRM_DEV_ERROR(gmu->dev,
> @@ -725,7 +725,7 @@ static int a6xx_hfi_enable_acd(struct a6xx_gmu *gmu)
>   	}
>   
>   	/* Send ACD table to GMU */
> -	ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_ACD, &msg, sizeof(msg), NULL, 0);
> +	ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_ACD, acd_table, sizeof(*acd_table), NULL, 0);
>   	if (ret) {
>   		DRM_DEV_ERROR(gmu->dev, "Unable to ACD table (%d)\n", ret);
>   		return ret;
> 

Ok it's here, this should be on previous patch!

Neil

