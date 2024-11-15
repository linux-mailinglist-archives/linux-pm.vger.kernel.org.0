Return-Path: <linux-pm+bounces-17601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B329CDB46
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 10:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D31E1F21FE3
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 09:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E14F18FDAE;
	Fri, 15 Nov 2024 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwqSupR2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218B918F2FC
	for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662164; cv=none; b=cm/O/eh+GhYZje8MqE9noo0+6XxcIRYphbuCcgKzzYoaqO1DXbjj55O8Y9DF+kzJdynubX+b1jJnJ3lIav/OQhKwMbr4AedjwB1AwbsRUA17YNCl26FYeewziYI9oTJjjUo0yEVKjNFCzw4ktsKwubTC1zUm4Sd7RIdYUdjWQZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662164; c=relaxed/simple;
	bh=eKLb9WPBbZ0Xu/K4i9juTXvzHHcU4NwWfLgass5d4oU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qNpaQ46Ww6bbjTHgh+U72qARazwvhjqg0OebxNwuq40ynkJKMS1zsoNpVdHE9hN79NGQ9P/PCOqjvN9fzIdAwtmayoavv6Xo8ncpOdvkmGlybHzo3tXz4VEXfdOa3yx9365zfMio3S5+YhO5YvkJ+cmDpzvLfeLIBO4Ls2DWvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lwqSupR2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so3928975e9.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 01:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731662160; x=1732266960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21xfAjVQeCIIZ6dS35gVy1ZySA5llV+Yj+sUkf/GRP4=;
        b=lwqSupR2fz51EYLaPJK6SklehLAm6J2GRc5L1Ytvh76mTlUAL6qYPSZk3vDUAcWDzQ
         /8e8d4XjsEwWThBC1DEkYxkQU9+pQESRedJ486uhzY/JqWAH1Ch9PB1SRvdIpqyQOQda
         vo8P4M6lPokCsIlhUqIsTZKOPfTmYP66xx67t5I/ZgRSR0B9whv700h/SUUAMBi63UaR
         n6QJoRVSthfylBxyMqVHo/IfKXw+pdHshj5w6OO2KNXu7QuZHLzsAHj/3D/tSlfisple
         hD1GNoavh3n+ioao/I1cJsKjGuApbGRIpdZPhBPeDv7WVk+jrayZEKiDqq7iGamGGCrI
         djuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731662160; x=1732266960;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=21xfAjVQeCIIZ6dS35gVy1ZySA5llV+Yj+sUkf/GRP4=;
        b=QylEDhGpwHIP8s7X4GEJTSUpPlx3K1VmKIaDXkxlYR/Md6r8gCBWMoMOHQgxZUIQrj
         wIMuKo1j5QsTJGCEj7SLM0gGX9lkZrCOj/2c5SS8btkgvWmVa7FwcXa3zN67B588R3ob
         Y0OgK6aYRJLPn9jor6rEXABiHd/Aa9TjQ38x4fYqeCCbp0iQh8GJRLGNMEF4F2b+ivsb
         4VZgKUGnfUFcLvJQoMdf8cA8i62vSfpTOUEJJ+kji8vy/Dhomo5RB1km6sqkFiJ7GlYN
         cl/CR/YKLqUShLYUdQ+5aSJBp5zkUSdirYgYp3hzK8hZrmX5S1zTLRncsnOU/C05xmdo
         +Nsw==
X-Forwarded-Encrypted: i=1; AJvYcCWpj9DrTKeKvGNyV/X7X8nQp/BXd9tWV7nipJgMX+z5C88Wh0WbEJ4PWiRCBEMozfWBlglbCrBupQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkvSj9EYaFPWsDOPmb0bRqelgad4Ckcxl7GGEqp89z1AP2RSEQ
	ll7YBDBVID+9TFgouZriDWkO+Qiv61S0n/9DEq/MWOPp5qvVLl7pWzn5LAY2fyY=
X-Google-Smtp-Source: AGHT+IFPbcpcX4w3sjn8rOwf7xbvOcUQVBQPqXmF6Nf82dTlcp6xBxu/Ctu+3eZ//JQlin2Qv5qoRw==
X-Received: by 2002:a05:600c:3b03:b0:430:52ec:1e41 with SMTP id 5b1f17b1804b1-432df74de50mr17161875e9.17.1731662160432;
        Fri, 15 Nov 2024 01:16:00 -0800 (PST)
Received: from [192.168.7.189] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac1d85fsm47149875e9.36.2024.11.15.01.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 01:15:59 -0800 (PST)
Message-ID: <8f0f23e0-c517-4e49-864a-e6c47cedc6de@linaro.org>
Date: Fri, 15 Nov 2024 10:15:59 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC 5/8] drm/msm: adreno: find bandwidth index of OPP and
 set it along freq index
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Connor Abbott <cwabbott0@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
 <20241113-topic-sm8x50-gpu-bw-vote-v1-5-3b8d39737a9b@linaro.org>
 <ith6te3m4cjwjyxrsxpjsvqsyjr3qrmlyyo7cucljuweuzn37b@lmd5b5mqwkbw>
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
In-Reply-To: <ith6te3m4cjwjyxrsxpjsvqsyjr3qrmlyyo7cucljuweuzn37b@lmd5b5mqwkbw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/11/2024 08:28, Dmitry Baryshkov wrote:
> On Wed, Nov 13, 2024 at 04:48:31PM +0100, Neil Armstrong wrote:
>> The Adreno GMU Management Unit (GMU) can also scale the DDR Bandwidth
>> along the Frequency and Power Domain level, until now we left the OPP
>> core scale the OPP bandwidth via the interconnect path.
>>
>> In order to enable bandwidth voting via the GPU Management
>> Unit (GMU), when an opp is set by devfreq we also look for
>> the corresponding bandwidth index in the previously generated
>> bw_table and pass this value along the frequency index to the GMU.
>>
>> Since we now vote for all resources via the GMU, setting the OPP
>> is no more needed, so we can completely skip calling
>> dev_pm_opp_set_opp() in this situation.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 17 +++++++++++++++--
>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  2 +-
>>   drivers/gpu/drm/msm/adreno/a6xx_hfi.c |  6 +++---
>>   3 files changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> index 504a7c5d5a9df4c787951f2ae3a69d566d205ad5..1131c3521ebbb0d053aceb162052ed01e197726a 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> @@ -113,6 +113,7 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
>>   	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>>   	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>>   	u32 perf_index;
>> +	u32 bw_index = 0;
>>   	unsigned long gpu_freq;
>>   	int ret = 0;
>>   
>> @@ -125,6 +126,16 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
>>   		if (gpu_freq == gmu->gpu_freqs[perf_index])
>>   			break;
>>   
>> +	/* If enabled, find the corresponding DDR bandwidth index */
>> +	if ((adreno_gpu->info->quirks & ADRENO_QUIRK_GMU_BW_VOTE) && gmu->nr_gpu_bws) {
>> +		unsigned int bw = dev_pm_opp_get_bandwidth(opp, true, 0);
>> +
>> +		for (bw_index = 0; bw_index < gmu->nr_gpu_bws - 1; bw_index++) {
>> +			if (bw == gmu->gpu_bw_table[bw_index])
>> +				break;
>> +		}
>> +	}
>> +
>>   	gmu->current_perf_index = perf_index;
>>   	gmu->freq = gmu->gpu_freqs[perf_index];
>>   
>> @@ -140,8 +151,10 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
>>   		return;
>>   
>>   	if (!gmu->legacy) {
>> -		a6xx_hfi_set_freq(gmu, perf_index);
>> -		dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
>> +		a6xx_hfi_set_freq(gmu, perf_index, bw_index);
>> +		/* With Bandwidth voting, we now vote for all resources, so skip OPP set */
>> +		if (bw_index)
> 
> if (!bw_index) ???

Good catch, I added it back wrongly when refactoring...

> 
> Also should there be a 0 vote too in case we are shutting down /
> suspending?

It's already handled in a6xx_gmu_stop()

> 
>> +			dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
>>   		return;
>>   	}
>>   
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
>> index 95c632d8987a517f067c48c61c6c06b9a4f61fc0..9b4f2b1a0c48a133cd5c48713bc321c74eaffce9 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
>> @@ -205,7 +205,7 @@ void a6xx_hfi_init(struct a6xx_gmu *gmu);
>>   int a6xx_hfi_start(struct a6xx_gmu *gmu, int boot_state);
>>   void a6xx_hfi_stop(struct a6xx_gmu *gmu);
>>   int a6xx_hfi_send_prep_slumber(struct a6xx_gmu *gmu);
>> -int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, int index);
>> +int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, int perf_index, int bw_index);
>>   
>>   bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu);
>>   bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu);
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>> index 9a89ba95843e7805d78f0e5ddbe328677b6431dd..e2325c15677f1a1194a811e6ecbb5931bdfb1ad9 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>> @@ -752,13 +752,13 @@ static int a6xx_hfi_send_core_fw_start(struct a6xx_gmu *gmu)
>>   		sizeof(msg), NULL, 0);
>>   }
>>   
>> -int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, int index)
>> +int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, int freq_index, int bw_index)
>>   {
>>   	struct a6xx_hfi_gx_bw_perf_vote_cmd msg = { 0 };
>>   
>>   	msg.ack_type = 1; /* blocking */
>> -	msg.freq = index;
>> -	msg.bw = 0; /* TODO: bus scaling */
>> +	msg.freq = freq_index;
>> +	msg.bw = bw_index;
>>   
>>   	return a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_GX_BW_PERF_VOTE, &msg,
>>   		sizeof(msg), NULL, 0);
>>
>> -- 
>> 2.34.1
>>
> 


