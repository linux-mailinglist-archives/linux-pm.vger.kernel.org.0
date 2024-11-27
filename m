Return-Path: <linux-pm+bounces-18180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7299DAD78
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 20:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C05B2131B
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11461FF7BC;
	Wed, 27 Nov 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvdql95g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69C81F5FD
	for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2024 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734118; cv=none; b=qE96Yydx2Mcc/bFsIstyxlDMul/Ox+y9iu0Tr8RykHAhcNNm/kukqjGdKl0jLx174DPWGiVDo6zhNVs2dOu3wE+pUZbNkjHNIT2Rs3fLaqiuyN34bNhFwYqRUxqcEVUUCdWOD31EwawUk77ITKaf58HHz3D5121r3icy8AY+A3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734118; c=relaxed/simple;
	bh=9YMYnQ/Swz9QsXKarm981aqQ7JGhUXBtFzUyiN37kgg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=euRESqC9x6yEpAYgEFPtTUW6d6hc9cWjQzCws0DapjMdPd6WwD5biHUHssjLcm8w02ms6FrN0Rh3bMJFvel/cMZBdEbEf2Z5GVqSecvOTD64COBS75xWdHlW1TkiYKeUbG4IJoWzds7nDUFOs5b71AJhwV3UNO97BKTP4bIkv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fvdql95g; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so758145e9.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2024 11:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732734115; x=1733338915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1yiyWo2SoYBonA2AnEougX0aSnWZiu2p9ZQOE6p3sA=;
        b=fvdql95g7J/uFySziHI4Lrg1Bs+kbAvjih9YKylrBrce/FXcmt3yP8Wr7Xn/YKR+EG
         1wXBfsyVZbQGf7RGGwq/YvmTmgfTPKIlFIs/8K7EQ15x8in3zhnhAcw+f0ATYm2/wCaZ
         ZYkvMa21NODbMiZDIpf6OWnfLhr6ad+NCe+zkhZC4FSj3wOQFOUJx40bNnA26kplTp7H
         A45E3jyOSKGo0oX955M1CDLX/fF7KofeWcJ6Jv11p4lolLzsvTy8hVRWvEtB3MylZdu+
         0o+/aZaqjZn4bEcvC+TQapa+2WEUovCPsdfQIWhDEBt/y1RQPbB4AYRhYMK0zX0F3oZ+
         CoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732734115; x=1733338915;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z1yiyWo2SoYBonA2AnEougX0aSnWZiu2p9ZQOE6p3sA=;
        b=hY7oRiWQrX1yB/xUDsxynse6CZiSaivmsZwTLXj3Iiu+P0H6dceFTruMllRjyMYRt6
         RMphKNL2u67vUUi+Coczcs5asvmuItWE5XtA4+qPHALuhbcRQ3zs/0Z6jB9RI8/dGdML
         oz8i3c7GFniBJtOQejtrHfSqkU3Sfz8w2CPmoblmUeDbnNRiFf+xU3iYYsSZCsajwkKu
         jtAS8fYS1TxBkls0GQ1w+4SsSroTvJWNlyM9sBqnPdd1nK39QNPVrCtj7h4y7LGbn7Gs
         HL9kbBgGjY9Ohfvvcj0GJYXjTcz7IbyZwQY+NuJXllOIZlBQPXIOrLOP42+X4wbcZYft
         jjTw==
X-Forwarded-Encrypted: i=1; AJvYcCV75ehE41C84U6g6lTft9ZdCVneH90ztUTuLeXT4XtRP4CeRdZV5QrOUytUwEUg/EUmX75cQP3HzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YztWZh3hy7kB1TQqQhx4Hc3uKypHXduVy4K8gmfxHErgcD9NTEN
	m2QuAN+mn+stdwogGmUQJb6jnL81GaXXvPl89LWo+TQ60uSFx/ayHFHlJ/fu3Zw=
X-Gm-Gg: ASbGncumdQTpKczL58TS1K+Cinw66WJAfiB840RmPgAM9Eq5EnaZtOBjhsIWEdNEvIB
	nbziQIBS7aY26KHhqfaj5Uq3LGcP/3YiJfBgXCebaZ58nH4n+j1yoze3/rxBkIIMG8BDwobmmJM
	M1gFq76JmkIe7SNYQaMl2/+GAKYl5Xwsk8gLdSDqd+YAxBWP37pXAKPEkwcCISsiKiypGoyKUsp
	E1svkLwSASW7WYJTDd/36amApRK2JeOY8WVtYlB8qA7KiTWSTdgI7wTRVy8OmAU2cb9N0UOPesm
	d4so6NsoGaP6rG9oxBdugckCTm0=
X-Google-Smtp-Source: AGHT+IE0EkuY37ILnPKptg6uGReSxnPJE0X/fqU/3PWi9f79qp1lbwcINs44bUUuSRvUsJiz99sxZA==
X-Received: by 2002:a05:600c:2d4b:b0:42c:baf1:4c7 with SMTP id 5b1f17b1804b1-434afb94427mr4280355e9.4.1732734114928;
        Wed, 27 Nov 2024 11:01:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8ad2:e64c:f150:ebc6? ([2a01:e0a:982:cbb0:8ad2:e64c:f150:ebc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e5e59sm30134885e9.44.2024.11.27.11.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 11:01:54 -0800 (PST)
Message-ID: <4d237348-2128-479c-8122-b194ffb19e5c@linaro.org>
Date: Wed, 27 Nov 2024 20:01:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 04/11] drm/msm: adreno: add GMU_BW_VOTE feature flag
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <20241123194316.yqvovktcptfep4dr@hu-akhilpo-hyd.qualcomm.com>
 <a936a9fc-6632-4f44-94d1-db304218b5a5@linaro.org>
 <fe8f40aa-b9c7-4a85-9cb6-63df81190fab@quicinc.com>
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
In-Reply-To: <fe8f40aa-b9c7-4a85-9cb6-63df81190fab@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/11/2024 17:00, Akhil P Oommen wrote:
> On 11/25/2024 1:46 PM, Neil Armstrong wrote:
>> On 23/11/2024 20:43, Akhil P Oommen wrote:
>>> On Tue, Nov 19, 2024 at 06:56:39PM +0100, Neil Armstrong wrote:
>>>> The Adreno GMU Management Unit (GNU) can also scale the DDR Bandwidth
>>>> along the Frequency and Power Domain level, but by default we leave the
>>>> OPP core vote for the interconnect ddr path.
>>>>
>>>> While scaling via the interconnect path was sufficient, newer GPUs
>>>> like the A750 requires specific vote paremeters and bandwidth to
>>>> achieve full functionality.
>>>>
>>>> While the feature will require some data in a6xx_info, it's safer
>>>> to only enable tested platforms with this flag first.
>>>>
>>>> Add a new feature enabling DDR Bandwidth vote via GMU.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/
>>>> drm/msm/adreno/adreno_gpu.h
>>>> index
>>>> 4702d4cfca3b58fb3cbb25cb6805f1c19be2ebcb..394b96eb6c83354ae008b15b562bedb96cd391dd 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>>>> @@ -58,6 +58,7 @@ enum adreno_family {
>>>>    #define ADRENO_FEAT_HAS_HW_APRIV        BIT(0)
>>>>    #define ADRENO_FEAT_HAS_CACHED_COHERENT        BIT(1)
>>>>    #define ADRENO_FEAT_PREEMPTION            BIT(2)
>>>> +#define ADRENO_FEAT_GMU_BW_VOTE            BIT(3)
>>>
>>> Do we really need a feature flag for this? We have to carry this for
>>> every
>>> GPU going forward. IB voting is supported on all GMUs from A6xx GEN2 and
>>> newer. So we can just check that along with whether the bw table is
>>> dynamically generated or not.
>>
>> It depends on the bw table _and_ the a6xx_info.gmu table, I don't want to
>> check both in all parts on the driver.
>>
> Thats fine then.

Finally I converted the a6xx_info to a pointer, and it's fine checking
this pointer instead of the quirk, since anyway we already check num_bws.

Neil

> 
> -Akhil.
> 
>> Neil
>>
>>>
>>> -Akhil
>>>
>>>>      /* Helper for formating the chip_id in the way that userspace
>>>> tools like
>>>>     * crashdec expect.
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>
>>
> 


