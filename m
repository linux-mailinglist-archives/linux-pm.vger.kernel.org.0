Return-Path: <linux-pm+bounces-17721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E7A9D1266
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 14:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C916D284395
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741401A08B6;
	Mon, 18 Nov 2024 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KX5cnXzz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85FE19AD7E
	for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937383; cv=none; b=Yu2gWGGF8CYfl5MyuPKAhvi0k1E78iVrLKZifdb91fpSVEHjXWIaJFfwsC7SKPgFNQ61nRTc2BFK7QGlne1jcBhL/kFvBXOlIO3ukohn/yyySo78BMzOstD2i5060B1kYgHyu3JWSiNRPGr2C9/VLrUFFuLhXsoUEwK0UR/i1U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937383; c=relaxed/simple;
	bh=tdWgbjXkX3OambyZqiLlP/2tb5OuNf8n79f57tgZEcY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rxqQn8+KMGXaSPlfdQj00ZiEICPlX+05HBxIGKCBZ6KMp2+JXRyUfj3fF4mdWN0OzVsrVy0T0COW/SKiTdTy3mOjAYnSiJh9z5grKsXoZnPfW1iWyvOYk8NWVuMyOQ3nVPExJ+XVfL4wrAUFO6Aj+iL0FVmlBT7KRiwvsCtDFjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KX5cnXzz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43161c0068bso16976485e9.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731937380; x=1732542180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MNIeWbXOEpIdi177GrMSJrZweM2zZKOMnvj4ie3c6U=;
        b=KX5cnXzz0e8V5Bw/ASrowUioK+us625Z2kVQVtilb41cYkRy32pIjYFXicS7uuKWW9
         ux4O6IdaYVZlzxMoQgEvztTTbKJdZsrheQv/JVceO9jZLObuh9w1Lb8FIg9d5tBMbMv0
         g6dXV9TlFxx83z6QCS2G+vg5lGrYNOgsVyYo45T5c2tRRI3lYv0bsvsF4SlSQCdwJ0+p
         nHRSImdjefq9Hur6yQSSaSLeksvQYlfu1X7kIoTpkUvLlRueLbM2461XP5iCGlruQ9+F
         yzhYp3WhpZwuxV355wEQsa5ndSHtISi6nR78yyZLP6XT3Js6zk8IvmWhkw4K9OmyvHec
         P7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731937380; x=1732542180;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0MNIeWbXOEpIdi177GrMSJrZweM2zZKOMnvj4ie3c6U=;
        b=wdx21cuQw0uMHjJIrYx+HhFcvpPm3BlKF78RVezSQGKHGNWaqK0Ns8c7B2jbJ90kdG
         92zSlgnHFjRusKVp+kVAT+P7P6OYE0WidzH2UY4d08UlEFn+fGQB8hLKDeqNSUA8+Nh7
         +It572B3M4suEFZmhslxURdRnDjku1XLRntqZc7vSrwFHCRNcZhBcz8LSUw6rRDhsbJk
         XVCWMPlzIJoMEiXP9tltNdry+Gq+kLv/z/tvLFQdf1avUwvzsuAYkMGtNsf8Zr5n6MaY
         F4lBMs1PbDjdUjVw0b2owVAdoOAUiMqX7QZI8YlPve7jhwMjNg/0INrKfMm5PNUb5Xbu
         KYWA==
X-Forwarded-Encrypted: i=1; AJvYcCVVPcPXSd2wpytquvjIN8eob7C9canE/u7nZLqY8mLqLk56UkOXZgWjPcipW4x2X+GI2AgHmJtr9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgMIS3ho+hjxXiJ8Eb7WUrEung/TUoUcdbUf0dKDd2lfKcJ+ts
	Q2pZahvEcbLMxYpY/fWlUQgDQuzjCC+YqOwtrkTxZ0uHt00wSvmZZZQiqZ06XFc=
X-Google-Smtp-Source: AGHT+IGrzGPi3KYjZ8eO1BUfXR+Xyqy1kzwZJiWe9WGbERnH/MbM0pDrrlujHkivsIJkNzef6M1Jyw==
X-Received: by 2002:a05:600c:510b:b0:430:563a:b20a with SMTP id 5b1f17b1804b1-432df72a7c3mr102661245e9.11.1731937380092;
        Mon, 18 Nov 2024 05:43:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:ed47:520d:3d5c:3acf? ([2a01:e0a:982:cbb0:ed47:520d:3d5c:3acf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2946a3sm157868985e9.35.2024.11.18.05.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 05:42:59 -0800 (PST)
Message-ID: <e76a2531-a96a-441d-ac2d-bc1557370aa5@linaro.org>
Date: Mon, 18 Nov 2024 14:42:58 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC 6/8] drm/msm: adreno: enable GMU bandwidth for A740
 and A750
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
 <20241113-topic-sm8x50-gpu-bw-vote-v1-6-3b8d39737a9b@linaro.org>
 <nw2sqnxmhntvizzvygfho6nhiwfni4xfquwst5gd5g2tel6pnr@h66d4mw46jcf>
 <8df952a8-3599-4198-9ff0-f7fac6d5feaf@linaro.org>
 <p4pqswgaxbx2aji6y5v2qngn3xp4gdlruthhbzpb4cgfs2earz@mo7zbsgqwc4b>
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
In-Reply-To: <p4pqswgaxbx2aji6y5v2qngn3xp4gdlruthhbzpb4cgfs2earz@mo7zbsgqwc4b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/11/2024 15:39, Dmitry Baryshkov wrote:
> On Fri, Nov 15, 2024 at 10:20:01AM +0100, Neil Armstrong wrote:
>> On 15/11/2024 08:33, Dmitry Baryshkov wrote:
>>> On Wed, Nov 13, 2024 at 04:48:32PM +0100, Neil Armstrong wrote:
>>>> Now all the DDR bandwidth voting via the GPU Management Unit (GMU)
>>>> is in place, let's declare the Bus Control Modules (BCMs) and
>>>
>>> s/let's //g
>>>
>>>> it's parameters in the GPU info struct and add the GMU_BW_VOTE
>>>> quirk to enable it.
>>>
>>> Can we define a function that checks for info.bcm[0].name isntead of
>>> adding a quirk?
>>
>> Probably, I'll need ideas to how design this better, perhaps a simple
>> capability bitfield in a6xx_info ?
> 
> I'm not sure if I follow the question. I think it's better to check for
> the presens of the data rather than having a separate 'cap' bit in
> addition to that data.

I don't fully agree here, I just follow the other features (CACHED_COHERENT/APRIV/...)
nothing fancy.
I'll introduce a features bitfield, so we don't mix them with quirks

> 
>> There's other feature that are lacking, like ACD or BCL which are not supported
>> on all a6xx/a7xx gpus.
> 
> Akhil is currently working on ACD, as you have seen from the patches.

Yep I've tested and reviewed the patches

> 
>>
>>>
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 26 ++++++++++++++++++++++++--
>>>>    1 file changed, 24 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>> index 0c560e84ad5a53bb4e8a49ba4e153ce9cf33f7ae..014a24256b832d8e03fe06a6516b5348a5c0474a 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>> @@ -1379,7 +1379,8 @@ static const struct adreno_info a7xx_gpus[] = {
>>>>    		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>>>>    		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
>>>>    			  ADRENO_QUIRK_HAS_HW_APRIV |
>>>> -			  ADRENO_QUIRK_PREEMPTION,
>>>> +			  ADRENO_QUIRK_PREEMPTION |
>>>> +			  ADRENO_QUIRK_GMU_BW_VOTE,
>>>>    		.init = a6xx_gpu_init,
>>>>    		.zapfw = "a740_zap.mdt",
>>>>    		.a6xx = &(const struct a6xx_info) {
>>>> @@ -1388,6 +1389,16 @@ static const struct adreno_info a7xx_gpus[] = {
>>>>    			.pwrup_reglist = &a7xx_pwrup_reglist,
>>>>    			.gmu_chipid = 0x7020100,
>>>>    			.gmu_cgc_mode = 0x00020202,
>>>> +			.bcm = {
>>>> +				[0] = { .name = "SH0", .buswidth = 16 },
>>>> +				[1] = { .name = "MC0", .buswidth = 4 },
>>>> +				[2] = {
>>>> +					.name = "ACV",
>>>> +					.fixed = true,
>>>> +					.perfmode = BIT(3),
>>>> +					.perfmode_bw = 16500000,
>>>
>>> Is it a platform property or GPU / GMU property? Can expect that there
>>> might be several SoCs having the same GPU, but different perfmode_bw
>>> entry?
>>
>> I presume this is SoC specific ? But today the XXX_build_bw_table() are
>> already SoC specific, so where should this go ?
> 
> XXX_build_bw_table() are GPU-specific. There are cases of several SoCs
> sharing the same GPU on them.

So it's gpu-specific

> 
>> Downstream specifies this in the adreno-gpulist.h, which is the equivalent
>> here.
> 


