Return-Path: <linux-pm+bounces-18224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623399DC110
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 10:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B672818D8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D0616B75C;
	Fri, 29 Nov 2024 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZnZt+cUk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF216DEDF
	for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871273; cv=none; b=cDrxfDaLEgA5ISpE4XHB6UKs09WaAsZOmp76nzAtEsTR4b/f5yb77ZMFFb6108/eGSe1Iaar5U2InlenXi6BuuQMwzhwKbELscAB95Mk0ngMPQolx6pEEZ/IyvwdlTSSOQNwARNF0CNSHYsEnQ+le45zkJd6/Kex1FlGGGG6xC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871273; c=relaxed/simple;
	bh=uBD1OTWMzefwm+EMHLdvIFrnGbZmh4ajVE0069zXcgE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=poD1Ic8XtbRrAc99sRlLp+2pLgjzeHSkZWBeSw6WXv02/CrfUKlGA7sc2vLiYIe+ffF+ivgEOrFdgbp90XUSNxFVaRFPFOTCMgPbwwDVyjkAolaAGEJRAGU6HmIAVcNUBrduSFD2gNR1HRcjUhvA4T8VRD93AS2QfosovSRKy1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZnZt+cUk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so9760725e9.0
        for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 01:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732871270; x=1733476070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAtvojJhp5crg3TeEkfKtpUrZedPVVuFwaZCFJsePRY=;
        b=ZnZt+cUkwNP4yWLaNb0gF7+wxQmxzE/u/j8DPRh7D2G/LTy0HT9ahmTvXvMM+LpF1K
         dp3zCT4DfptBJcZZI9qvVZ03jftV1GkVHvPv/Dd+X1gvDmfWzFhqw+bQ0Azt8nc+Z5fi
         wU1RV+qJVkqiJWT3NTydN5BMzT1pZEAXpjJf0mWIRcR6YlR++9lGptDOeCmr0Y2wTi/q
         QW5Z5bAc3MjHXebNba4MSGa/Rg/7d1wW9yuE2suvBGzbIWYy4EKDzEmIXJZdkp9xkAuc
         1Vk2eLL8UtI/jzgkCEM2jl/F/00/FGhQg1YBgPLQKJS2Ag2xuDPH2Z0IBTnW/C2HXzNu
         MDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732871270; x=1733476070;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DAtvojJhp5crg3TeEkfKtpUrZedPVVuFwaZCFJsePRY=;
        b=nTSpCGfdoXadVUPQc+TaydpwcfuN0vIK13FKI8FjW6uuSXCN4uwrC05CMXSENf3e2w
         Yz5NCGeUktog3VQg8aKm2LyQe1b4AvpPVFeTNxgD+8FeBbpHRDYcYejQdnFNVya/dKsg
         aAllkpYa0yVDZtRmSuV9wjYOVN/2fiERm6naZpdzoI1i+biO8ME5La5fUzRiWyDF4XAc
         k3UkIif9xOnZ9jhbB8uZ7J+Dl0Ea8vGoILAzIkNUKmPYEeNHNwdnXYzM+Rz3UX8PIO6j
         Goh5S6f7BFoBVUg3orRla7zQHmndqQ/B4C0vvVrhJqpKLq/In3EQtudXEVBFFfgU+qZQ
         gj0w==
X-Forwarded-Encrypted: i=1; AJvYcCU9oFYTHaMRcavU3V9TZfHWlrsWCU86hpOkmsfZV4bd1YiF2uGuV7tv00vSrg6uJQ4bHgSfETlj8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwwZAFzUpJlCg9L8hAG7bpLY4QmSOXgL0//1uC/zsxU/nNyc6O
	AGeBA7tPyl6qcLqrsm3QnA1ZB1+rTvKgJyLQHMVsMd1eBN8sNny8hjyAX97lmyw=
X-Gm-Gg: ASbGncv9fptu3AKyi+Jzy94jGWC3KgyoZxKaTFlZN4UrcZ3ZsWhmJdR0CAErCbX6AAu
	q77Y3bVbOJNp3VO2qrLsBMwwa909LIyo95U6w2B8YQBChxZx5yKqeeNRB0ZuBMaEm94qD6K6c9b
	lXGO7HMyv6qyYGdfncKg4cpSb5TuMYeFdvWw1BKKdpqHOfbvJdfsX38XiyGhMEAZ3oghylCUnMV
	Hw3DylG22z49KAdbGRVQ3RE0VZmhOoIQSbp1TvtC9uMBUeFY6vCGTCMy0V349cwjSm89xfH7uRZ
	L4+72N0dU6mrK4YDM80DZnYF
X-Google-Smtp-Source: AGHT+IGq+IX95UPj+p3JPDTSpj+T198MGKztf/2NkwGmEIGQoF57LHOThnqnAj3zHMXhBTpYhA9nDw==
X-Received: by 2002:a05:600c:3589:b0:431:15f1:421d with SMTP id 5b1f17b1804b1-434afc44774mr55040355e9.16.1732871269973;
        Fri, 29 Nov 2024 01:07:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f573:30fa:4c5:27df? ([2a01:e0a:982:cbb0:f573:30fa:4c5:27df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f326a9sm46696005e9.35.2024.11.29.01.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 01:07:49 -0800 (PST)
Message-ID: <b8de4e95-d598-49dc-83aa-a9ffc2714a24@linaro.org>
Date: Fri, 29 Nov 2024 10:07:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] OPP: add index check to assert to avoid buffer
 overflow in _read_freq()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
 <20241128-topic-opp-fix-assert-index-check-v1-1-cb8bd4c0370e@linaro.org>
 <20241129084052.wfi7nakgcnt3zkur@vireshk-i7>
 <c6b5b6f7-ab55-4d46-888e-f9e00b269c9c@linaro.org>
 <20241129090457.4ibsyulffydnc3ns@vireshk-i7>
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
In-Reply-To: <20241129090457.4ibsyulffydnc3ns@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/11/2024 10:04, Viresh Kumar wrote:
> On 29-11-24, 09:53, Neil Armstrong wrote:
>> Hi,
>>
>> On 29/11/2024 09:40, Viresh Kumar wrote:
>>> On 28-11-24, 11:07, Neil Armstrong wrote:
>>>> Pass the freq index to the assert function to make sure
>>>> we do not read a freq out of the opp->rates[] table.
>>>>
>>>> Without that the index value is never checked when called from
>>>> dev_pm_opp_find_freq_exact_indexed() or
>>>> dev_pm_opp_find_freq_ceil/floor_indexed().
>>>
>>> These APIs aren't supported for cases where we have more than one clks
>>> available and hence assert for single clk.
>>>
>>
>> I don't understand, the _indexed functions clearly have an index parameter
>> which is documented as "Clock index"
> 
> Ahh, I missed that there are few _indexed() helpers as well which you are
> correctly modifying.
> 
>> I agree we could leave the other ones with assert_single_clk, but we would
>> need to duplicate it to have one with the index parameter, so it felt simpler
>> to use assert_clk_index everywhere but indeed we do not exclude them for
>> when there's multiple clock...
> 
> What prevents a user to call dev_pm_opp_find_freq_exact() for a multi-clk setup
> after your patch ? As we use Index = 0 here in the code.
> 
> That's why I would prefer the earlier assert for all these, except the indexed
> ones.

Yes, let me send a v2 with this addressed

Thanks,
Neil



