Return-Path: <linux-pm+bounces-40839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 027FAD1DD62
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 11:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2C30300FECB
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 10:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC9638A719;
	Wed, 14 Jan 2026 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9DsiHHl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D86F38A2B6
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385262; cv=none; b=cDRYUs/RetD1c/xxOgxnj4oVQPFQlpgeQ8Ad1EL1Cqpk3863t0W5C3bS37cVoN2k27GuIc1GFjKICgjSjVp+waaE63vkK3tgH/pHkdHMfguITvt3x+Dx4bbzW3BVK2iC47JlBQBECKWmNCF6mKF/ImWhYuDDGQvh8VeaMm0rm28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385262; c=relaxed/simple;
	bh=aqHYCoOIh2zY40JLbyZ6FfpCHfXNb5CknOmVdBYwquw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FCX7QjlRSP/oJBzccRVDqCs8frqXybgTu/9SdTPEoYmDSonMkSqR0omuqOPB/usiJA8DXMLK5NJFymU7pouFhBhesKN1P5mj/L0+tL6yL5/xRACxzWQossB0sBZe3Ad81ZC19RT1qDZeyv6IkqzFiDoQhSiM2rbV/wpOKSrUV7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H9DsiHHl; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so4413391f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 02:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768385258; x=1768990058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8mW+tYY/3O9GKx5C5cOgVc4F9fjWRFBqMrxS64uloQ=;
        b=H9DsiHHlhF4GL2p9dBZbln5Avj0w/7rwZ9gGeA3BK/R/gAv4GGUCX+Sw+Z08r7hg9w
         jBlwb/Uha/af66u6pnuKQIcilUwY5ony+RCTzlJQwQ8b2frbBfvBEAtgKvWddA+ELGIR
         IjOpoFzR19rIqvR+s+LKhXlAxnq1bF2xl96yMRURXTlsmR/mRArTDB4qV1BYVkToohRQ
         76pRkYLaly8KMYf+7sVIOjYMVSPE+wx5bX38vk8UgYSFEIvxYG2fZKabLA5f+Eghd8B9
         zQZpcEuY0kt90RdzZMjATI4k8xBZzkokiKXuR+FoYbpH4sm4AEyIiYCNht/y87p76BcY
         YTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768385258; x=1768990058;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8mW+tYY/3O9GKx5C5cOgVc4F9fjWRFBqMrxS64uloQ=;
        b=DWpFo7DNTa9lDdNacpJ6QTyhvIicXI3omjGHbFDyC2atBQzI4qswxYtUsLM5NGYrSL
         3gWVqBaRehUYWQYiRSC5ZAw8WLSqInWmrUc8ez9cnswskhN7cO8GtXZ3vEZjt4pvsTkF
         chO5oGGmKbKecETIxUL/HmBUtBYSN6Z2kNNijX0G+kuO//tyjYFRvdtgtcWU4WXTbRYt
         bPoiVSM0uZg/MzPFd4ZNlvYhzzFeWS+NaEm1hoOIx5cuFXatmT37UxZ4vb1kGFJv808N
         bPanoNFrHiZyMprrbpEuEdXqo/FAQqJaVcvcvWNQDeN9bi8ZJfEG5ikTxhiEjDXgFd59
         dVpw==
X-Forwarded-Encrypted: i=1; AJvYcCUJtNbbfIq5viEQjCFOO2d1QLprkEa0fB0f5t+0WwvZmy9YKP34I8L/6/AFOg3h5Z3OX7w1MQz7JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHzLdvDpiA9Jky7RHSlpfA8MggFbwd+r+uCoXrtUXnf8BlR5g0
	3Du8tBsCRl0TjMYauZ4XVKfwRyc/ZNnvYSoSmnKyXJ3SQRma/VShEGvEm6CW9IRAdz0=
X-Gm-Gg: AY/fxX45tqGtKYV4MJ9wGcO6h3SAuyglRb5jyO52nw35adcQe9ulcRl9eil4iN4ufxX
	Bdb0r4s8zEDq3qPmyRRRT3UE7ytarMugbq7SUMbtkXt7xUTiLE+iVMhfsp1PLmjymR69rpLKTFX
	uHAu5XgwJoQgATwz+I6PYuHTvNLCih6D5D37ixIjCchghYwcHdXH7JFRDkXXGTA9apld4oBM2mZ
	2ruzef8T1f3ztQLeraF7DFybx3ZOURCmICqkT4LQxnNnvFRjFID6KEgObFooP7wG+YyLQ/ZgCZ6
	ITgRyIFUIHGGnya0skmabyWNDISko+Up95HZ23FO2KQUeauO3GaZSldZMxi6nXcGky+h9hfx4rb
	JotfSOk6uGsNZefi0xXHO5OpOiXChHSIg1LoJDY3eojt8eU4D7K4jnQbAF8j1atAICtqMjvS3+6
	etxXk60PVhAdVktv1b1bzg3KlkL8NJC2JoI8eoDyh8jqtO86X4gVNZ+HVXNuAvfic=
X-Received: by 2002:a05:6000:2893:b0:430:fd84:3171 with SMTP id ffacd0b85a97d-4342c500119mr2192528f8f.22.1768385258402;
        Wed, 14 Jan 2026 02:07:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:b357:7e03:65d5:1450? ([2a01:e0a:3d9:2080:b357:7e03:65d5:1450])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff1e9sm51179179f8f.41.2026.01.14.02.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 02:07:38 -0800 (PST)
Message-ID: <95becfde-ba4b-4024-9b90-e64e77551f0a@linaro.org>
Date: Wed, 14 Jan 2026 11:07:37 +0100
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
In-Reply-To: <1be287ac-fce9-4f27-aa88-b1f786e968cd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/26 11:01, Konrad Dybcio wrote:
> On 1/13/26 6:53 PM, Georgi Djakov wrote:
>> On 11/6/25 6:46 PM, Neil Armstrong wrote:
>>> Since we can actually read back the APPS rpmh interconnect
>>> BCM votes we can actually implement the get_bw() callback
>>> and provide a coherent average and peak bandwidth at probe time.
>>>
>>> The benefits of that are:
>>> - keep disabled BCMs disabled
>>> - avoid voting unused BCMs to INT_MAX
>>>
>>> If the interconnects are correctly described for a platform,
>>> all the required BCMs would be voted to the maximum bandwidth
>>> until sync_state is reached.
>>>
>>> Since we only get the BCM vote, we need to redistribute
>>> the vote values to the associated nodes. The initial BCM
>>> votes are read back at probe time in order to be ready when
>>> the get_bw() is called when a node is added.
>>>
>>
>> FWIW, I was able to finally test this on sdm845. Some nodes are indeed
>> showing reasonable bandwidth values instead of the default INT_MAX.
> 
> As I learnt here
> 
> https://lore.kernel.org/linux-arm-msm/1e7594dc-dca6-42e7-b478-b063e3325aff@oss.qualcomm.com/
> 
> rpmh_read() will only retrieve the currently active values, so as-is,
> this hunk:
> 
> +	/* For boot-up, fill the AMC vote in all buckets */
> +	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> +		bcm->vote_x[i] = x;
> +		bcm->vote_y[i] = y;
> +	}
> 
> is lying about the state of wake/sleep buckets
> 
> this is ""fine"" today, as I don't see any "if (old_bw == new_bw)" checks
> across the framework, but debugfs is going to report incorrect values and
> if anyone decides to add the aforementioned check, it may introduce issues
> where the values aren't commited to the hardware (because Linux is going
> to believe they're already set)

This is only for the pre-sync-state phase, where we don't need the wake/sleep
values but the interconnect rpmh implementation needs them, and anyway they will
be replaced by proper values in sync_state

So this is an informed & assumed choice I did here. It's a small optimization
to avoid turning on _all_ interconnects at INT_MAX, and keep boot votes
up to sync_state.

Neil

> 
> Konrad


