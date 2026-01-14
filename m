Return-Path: <linux-pm+bounces-40849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF99D1EA37
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 13:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3BB0305328C
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 12:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7331D396B87;
	Wed, 14 Jan 2026 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JStleW+v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB42396B92
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392108; cv=none; b=tboN/Ay9gMJHOCWGHQyEKNrmMv73bwW4K551MsB2AtwrjUOwpxYpbSBdnddQZ7K1A8sse8xGL39WEnwN/0wklduP3friwFh/bGraA6ae1de0xg0nUBtWwBXh3ANNkwGywJr/KSctEYdpEBBinSC10AMtmh1ykMz8r7/27KHoJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392108; c=relaxed/simple;
	bh=iNai+G6NshxOHQsZJbNlAnBOyInMuTA1VsQcpywwbMQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HpLeMYC8AhRZ/4QGkn6Krr0UtK8fnqxVbinwWyLZ1qqjXSUaaL6arylXvYWcPyrrruyI/u3DyehUZMEiluKDRtSzcNL9Leip+NgTFpOYzAo5vjkR/U2VNRZDSczI77ADR96RuAPVuKrU82zg9HMJMcdGpci6a8AXoyHtMmSB8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JStleW+v; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47796a837c7so58923045e9.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 04:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768392099; x=1768996899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMmxpMMJUTD5dATkBZmEMwx1+ZMsaHboVGIdX1ME97Y=;
        b=JStleW+vfxhWAkTVq/nWMw4SkOACkni8r4B90PLRjz6xHRZzrR0lRGOXXldcSluyRU
         i7MjA2ETEFg0czPnUT4MvlEe/VHItJL38n5Vd961s+m7wg+BXSjhy5vLTSrrUhWxVYWG
         3/AEE3KM0yDXG7HiJrV9VCyf7txnFJdf99A62n1uyP6kAKkQwKARzA70hbQfS7yGZHgz
         EVVuLq/aU/lINv/FvhOgRWCzoxtHCp60ml8iVnyunkx9Y80tvZTEtiJj9BmWSNG8I4Ue
         QTPASKoxfpV2cvwWoDoCY+67eYzbzC4ygz2bwYzAGDz2kxa8KYuyNwHwEQoUDhPcTArM
         KR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768392099; x=1768996899;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMmxpMMJUTD5dATkBZmEMwx1+ZMsaHboVGIdX1ME97Y=;
        b=qbSuViv3w3mmxg44ktXcfvcf376JF+k7fuDpYSV9JY+IdrJjltu05WodeAunXpk9RE
         +Imp+Bs3V5nBMfKi8YULu1eFM/MRm3zzmCv4wTUTguYEmdjHNAD7zryJd+YWHSEAiWs/
         Cvx0eXDz6ng5jLAk7J7P6hcn+1hpalj57DpkaAGByMEH1sob9fXry7WsXnw+8wQym3HB
         jZAEmjO6ulKWp2SYmclH62BiIy8XjC0W2J/6V89Q1KgiH+gnIK46mzdZKo6VewgIZpCE
         Zin9CqyBwrdb4t+GOEeik+GLN3vKV0WVbXb+yeP0vWRoWOfYwVWfaXRc4Sk8cNmri+tF
         I7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVICTuWYDkIaSiTwF+Hi3qsdYW73xVfwbfj8VhOYhz5uxKZuO9N54EJAEYqzMUljCqZc1oKGDJ77A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5h7eahCUTLLybrkFOQVV8IwR9F0UFRVi4kvjdqveqwNNzvxeo
	KHG8b800uHPRUpEDJTBDNacF5BLJNBp40WuCH9uaAEkakZoitul2fRWAqJo1/bQNFfo=
X-Gm-Gg: AY/fxX58OL4OnRveh9+V4mRKiJi6VIys/hphcPPAFMeUv4apJeUbAA34zLR8096n5ct
	HVolgLoQtLikfwXd09+l4yv7U3MaapX1dp7RzzlxZ4tXCCC9JSpDkEeZGgfs5n7Zzl5peKYSWCf
	TEYm4CoodK5R5AytccVbizGJF+jJ1S3IlU/yQJkfbkIwFL9ciWa3Mjjb3rkZgfP4NeyEi1XIqXi
	rWPmtLr4d8fRGx+oLfTX7dQRGzveE1xDX7OrQQH27W8JRdsGtqIioSzGzm9+VEtykJFBMrdBtK1
	7RyNBnDF95bAywfMYk7pZhBSA8WxLOk1eICqwwH+ir+Im9zu9KhgS7phgSj5T+sgPZCB0wo1BY0
	gk1cYl7cxPEkJyGnSE8v5RQ1TkYP4SHllsA/8HoXeYJRcGjS1696yg5QVZX9hXlxpaHTTFLGc8B
	5wzPWepRR3niOj5abMm/bVUcgj2Km2hGFnLf4eG9Is3/tGRSDKeE+MWzxltUr2zhw=
X-Received: by 2002:a05:600c:3510:b0:47e:e05f:643c with SMTP id 5b1f17b1804b1-47ee33916e6mr22558155e9.20.1768392094380;
        Wed, 14 Jan 2026 04:01:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:b357:7e03:65d5:1450? ([2a01:e0a:3d9:2080:b357:7e03:65d5:1450])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee2814587sm18125945e9.10.2026.01.14.04.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 04:01:33 -0800 (PST)
Message-ID: <3f3653d2-d40b-48d9-a131-08d3ff44dba5@linaro.org>
Date: Wed, 14 Jan 2026 13:01:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC RFT] interconnect: qcom: implement get_bw with
 rpmh_read
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20251106-topic-sm8x50-icc-read-rpmh-v1-1-d03a2e5ca5f7@linaro.org>
 <8eb528dd-71fc-408e-a97c-d484198e4f81@kernel.org>
 <1be287ac-fce9-4f27-aa88-b1f786e968cd@oss.qualcomm.com>
 <95becfde-ba4b-4024-9b90-e64e77551f0a@linaro.org>
 <ae97da56-7e4c-4ff2-b0fa-9724b95229eb@oss.qualcomm.com>
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
In-Reply-To: <ae97da56-7e4c-4ff2-b0fa-9724b95229eb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/14/26 11:31, Konrad Dybcio wrote:
> On 1/14/26 11:07 AM, Neil Armstrong wrote:
>> On 1/14/26 11:01, Konrad Dybcio wrote:
>>> On 1/13/26 6:53 PM, Georgi Djakov wrote:
>>>> On 11/6/25 6:46 PM, Neil Armstrong wrote:
>>>>> Since we can actually read back the APPS rpmh interconnect
>>>>> BCM votes we can actually implement the get_bw() callback
>>>>> and provide a coherent average and peak bandwidth at probe time.
>>>>>
>>>>> The benefits of that are:
>>>>> - keep disabled BCMs disabled
>>>>> - avoid voting unused BCMs to INT_MAX
>>>>>
>>>>> If the interconnects are correctly described for a platform,
>>>>> all the required BCMs would be voted to the maximum bandwidth
>>>>> until sync_state is reached.
>>>>>
>>>>> Since we only get the BCM vote, we need to redistribute
>>>>> the vote values to the associated nodes. The initial BCM
>>>>> votes are read back at probe time in order to be ready when
>>>>> the get_bw() is called when a node is added.
>>>>>
>>>>
>>>> FWIW, I was able to finally test this on sdm845. Some nodes are indeed
>>>> showing reasonable bandwidth values instead of the default INT_MAX.
>>>
>>> As I learnt here
>>>
>>> https://lore.kernel.org/linux-arm-msm/1e7594dc-dca6-42e7-b478-b063e3325aff@oss.qualcomm.com/
>>>
>>> rpmh_read() will only retrieve the currently active values, so as-is,
>>> this hunk:
>>>
>>> +    /* For boot-up, fill the AMC vote in all buckets */
>>> +    for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
>>> +        bcm->vote_x[i] = x;
>>> +        bcm->vote_y[i] = y;
>>> +    }
>>>
>>> is lying about the state of wake/sleep buckets
>>>
>>> this is ""fine"" today, as I don't see any "if (old_bw == new_bw)" checks
>>> across the framework, but debugfs is going to report incorrect values and
>>> if anyone decides to add the aforementioned check, it may introduce issues
>>> where the values aren't commited to the hardware (because Linux is going
>>> to believe they're already set)
>>
>> This is only for the pre-sync-state phase, where we don't need the wake/sleep
>> values but the interconnect rpmh implementation needs them, and anyway they will
>> be replaced by proper values in sync_state
> 
> I realize this may not be the most convincing argument, but consider
> the case where sync_state can not be hit, for example with the Venus
> driver that requests FW at probe time and errors out if it's absent

We're talking about initial states here, if a device votes for an interconnect
path, even before sync_state, the path will be voted with the requested bandwidth.

https://elixir.bootlin.com/linux/v6.18.5/source/drivers/interconnect/core.c#L295

Before this patch:
node->init_avg & node->init_peak are set to INT_MAX, so max(x, INT_MAX) always gives INT_MAX
After this patch:
node->init_avg & node->init_peak are from the boot, which can be 0. So we either vote
for the requested bandwidth, or floor the bandwidth set by the bootloader (could be a higher value).

> 
>> So this is an informed & assumed choice I did here. It's a small optimization
>> to avoid turning on _all_ interconnects at INT_MAX, and keep boot votes
>> up to sync_state.
> 
> Another question is, whether that's a desired change - I could easily
> see pinning buses to the maximum speed helping boot time KPIs, but
> perhaps that could/should be configurable?

It's all about the rest of the bussed endpoints, enabling _all_ endpoints
to INT_MAX could potentially lead to in fact reducing bandwidth for crucial
devices like UFS because we configure everything to the max bandwidth, and enable
unused busses (and associated clocks & power domains) for nothing.

The idea in this patch is to keep the votes from bootloader, keep the disabled
endpoints and vote with requested bandwidth for devices which are used in the boot process.

Neil

> 
> Konrad


