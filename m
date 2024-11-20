Return-Path: <linux-pm+bounces-17819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9299D3AC9
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 13:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60391B23CED
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D041A76C4;
	Wed, 20 Nov 2024 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a7XgM48p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8221A7274
	for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106273; cv=none; b=BRMf5XFvTUanWTwdcwHDYPQiGleUBkrsPD1DBPlQOWD0XFspqFW1EgTBRuLpkwgxKxc3dEtiHCd383aPwNyPdW35FrGsvbm18zNkajAhx2hQavDTxrYbQP5nuODvufbIrTvNY8vgyRJTgrSPi5dyOzrI5Pkf7bZoeIrVDy7gfBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106273; c=relaxed/simple;
	bh=hGNhi3mDUnjXZyPKKkHWlafcIccCqvhPnj3EyW602AM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QV+TqH6luy0j9rKha1ZchOY9rtGiBU7nzADy+m2XsvcP2JBLjB5h+tgIQ++Ju/0kh1IbxYYiU3uPgvyIQcsnDrId9k2LjeyEWyJZhpqa6xbqiqGrZa+AD+rwFQGl6ujbjCrPR1qN4laWG+MWydtfxRukdC1zAeWZ177bhfIsPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a7XgM48p; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-381ee2e10dfso2642647f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2024 04:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732106270; x=1732711070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gziM8urKl1B9e4nzfFx9z8Wbv3rlCgU3+h1y6PGcuuI=;
        b=a7XgM48pDX3K9NIWL/lCWLWqP9wWO3nA0Qhywy+COafVSb1Xe1rv/66mA7ztHLEi6K
         3RfWzahZzlDRF1H3XVqnnq3xnXZcuOssZFUFE9ih1gBbhyNTtidswyJg6ele9eJjgxke
         lBugDTZBIVO/bVYEUhc7SpYQyVS8XMw7Oy24V+pMuA+b8sOIdFycXeoS6xRDnIHMCSga
         ydTsaEO8WzR3RQezCsOgKB6eq7Y4euwV8kl9LMoNC7ZBtq7FRCdpnJByk3vl0DzXL5eY
         BW1REZbYK7SelNsF0NlnUdIpWp6I03svXAFJWtv5lq10XQK3SmP3mD9k7Fhs7pkKGPyM
         QSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732106270; x=1732711070;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gziM8urKl1B9e4nzfFx9z8Wbv3rlCgU3+h1y6PGcuuI=;
        b=wO5LnbpWarNOiJWTVMHhRScR3BKooG+Pqm4Lf1yHPG7Wkz3AtrZXivxnRNQ7iWQf9E
         D9HTgCkAEVJ/ulyzMRjLDxPe+146Z1uoZa4/A2ARwy1nXA7yd4LLYTv91gNP/fcGv3+Z
         h2IczAjaUl6ZEETIjHu89wA6lrL4+YC/TNutmvPub4DFxNaKDrzKQbTZXjO3lV5P3ZRm
         +oIXnMfCVqlWcwi+x32tgjsPlqIW7oBlDudpddQf+oRKfkfavAWZ4jXmaaYQpwOQ5Pg7
         6iFuPzpF/fd/8D897uTbIlgfATj0iDiNB+p8te8SquozKog8wv9amNX3JyHOszCVkBbo
         wa0g==
X-Forwarded-Encrypted: i=1; AJvYcCW53wo0Pu0WhamjnK0CFznlcuaWnJ18knpLMbdgLsmJiHNvPX+37MijQ50/FBJIZVUx6pNPaFaMUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YystHeUhA+kpU/gufHBC47xKm0IIOlBEc97sZ87Zus/rvCUYjOK
	8X4zsKXCflkjJGaMGdRyc3sAHxB9qPqT6dxfC3do84zu4Os7bncr3BVNtRJ6PFw=
X-Google-Smtp-Source: AGHT+IGdJQAc+iugPISjAUH200goFko5j0vmx0r96libdXqJlDe8aAFXpLkq1rdFGaZ45mhCCnvewg==
X-Received: by 2002:a05:6000:1a88:b0:382:30a5:c38b with SMTP id ffacd0b85a97d-38254b0e1d0mr1677410f8f.42.1732106269882;
        Wed, 20 Nov 2024 04:37:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:927b:2848:1f7d:3776? ([2a01:e0a:982:cbb0:927b:2848:1f7d:3776])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e1165sm17968325e9.2.2024.11.20.04.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 04:37:49 -0800 (PST)
Message-ID: <8218a053-6b69-4e1f-adb0-4c11930412ed@linaro.org>
Date: Wed, 20 Nov 2024 13:37:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 04/11] drm/msm: adreno: add GMU_BW_VOTE feature flag
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
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-4-4deb87be2498@linaro.org>
 <iw75ptavkqw3vybfov2f7koz5nh5lfzxcou3wey7rdsqt2gj5n@7luy2kqrzkj5>
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
In-Reply-To: <iw75ptavkqw3vybfov2f7koz5nh5lfzxcou3wey7rdsqt2gj5n@7luy2kqrzkj5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/11/2024 12:19, Dmitry Baryshkov wrote:
> On Tue, Nov 19, 2024 at 06:56:39PM +0100, Neil Armstrong wrote:
>> The Adreno GMU Management Unit (GNU) can also scale the DDR Bandwidth
>> along the Frequency and Power Domain level, but by default we leave the
>> OPP core vote for the interconnect ddr path.
>>
>> While scaling via the interconnect path was sufficient, newer GPUs
>> like the A750 requires specific vote paremeters and bandwidth to
>> achieve full functionality.
>>
>> While the feature will require some data in a6xx_info, it's safer
>> to only enable tested platforms with this flag first.
>>
>> Add a new feature enabling DDR Bandwidth vote via GMU.
> 
> Squash into the implementation patch.

Which one ? the flag is use in the next 3 patches

> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> index 4702d4cfca3b58fb3cbb25cb6805f1c19be2ebcb..394b96eb6c83354ae008b15b562bedb96cd391dd 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> @@ -58,6 +58,7 @@ enum adreno_family {
>>   #define ADRENO_FEAT_HAS_HW_APRIV		BIT(0)
>>   #define ADRENO_FEAT_HAS_CACHED_COHERENT		BIT(1)
>>   #define ADRENO_FEAT_PREEMPTION			BIT(2)
>> +#define ADRENO_FEAT_GMU_BW_VOTE			BIT(3)
>>   
>>   /* Helper for formating the chip_id in the way that userspace tools like
>>    * crashdec expect.
>>
>> -- 
>> 2.34.1
>>
> 


