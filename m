Return-Path: <linux-pm+bounces-18164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CC09DAB25
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 16:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0282164510
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 15:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43C720012B;
	Wed, 27 Nov 2024 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PU0L/DdG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D0200114
	for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2024 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722932; cv=none; b=X3IZve0enIFue5c4Wt8r/Z7adc0mRriGn6kEJS5gxirVdxX+kBTknprLIW0bt2J55MVq6ZypwjLRZRVyTw5gV02GlL94iFoBl/6mERkdU2tbraPNWel0jFCnRMVwAXbBOZSU8ckZFHfn/X9dwcsbSCGe8+E4cyTlULbIcsmhLB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722932; c=relaxed/simple;
	bh=M78xFjTtzjUp+sgtV1vhmtloCxaKb1TcGmKL3Bb/rB8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UVL/dCgrktoulqVFhkNFag7kZcLqpS4SSRjbzVmp7Gq67SBIRQBNPdCAmL8tkWOwKsCTid33s3c2jsjgQ9PnrIxds0xzGtj+pLJAVEpAHrFak4f8KB3KvOyhNgFRCvBGe+gRhCoMC0UywOb6ycDihmrYtmMTnj6shjkcFWoQ/7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PU0L/DdG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434ab114753so6343295e9.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2024 07:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732722929; x=1733327729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fZHHyi9lrufyt8LGbh+sPd+B86keKpYadbG8L8712E=;
        b=PU0L/DdGD5HeKMIuoUfIdd8O9H9EmUnMXQvdTyLFEjNezUlnfYufrAcUhWZ8bYJ9sG
         UA3aHIUxTMEFv0sQnBAFfUqycp1DL8NDii3F6Eno1yWWvETU4IZEoYshHAgWaYAZIxiT
         eNoOSkuTwlntTPVDIa9sYshb3X6pxuHT8a3KTwXdEXCwbh6VxEotVuiHGg9rCrrIUyuJ
         XZa4IZ6R637JG0Ow2nzDdJNOibkYAqMxdAbRMIfj/lrUkmv2+PEPwucq+fEm4g+5inGy
         oQC6gYrZLcBFb0lAjsUNx4kBFck0nTd0IL1pROorlsqhJ70LIcdj4+jgZnZvV5shkuoZ
         MJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732722929; x=1733327729;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+fZHHyi9lrufyt8LGbh+sPd+B86keKpYadbG8L8712E=;
        b=iBcEmx27c/Vp3yxB0oc661nQejGhEg94+HsTqI6x/VxZ02NgwFtO3p6o7zKlDeGoQk
         vFQSfSlIJjusGl2eUykhaejylTsTHgKXvdQrgZ+tW60onv2ByvLqIrOnTMScM+uy4f7C
         uMI32duphozVKgYnbAqgXtgy5Wu9YyxnYcF8FCN0zYGnDaUlQRJzAZOlUFqwmqtCslqg
         ts3cbpHWEBRkivhgjokN2kZf5qLyswrUPJGKGUwvBul60IHKSXUC1jCyYq25PCwhpYg2
         x4XicMH7mktDvSB5oirOS68oHzK43fgRTo4txpfwBYnWp/gG3E8VYR1C/+7Fw5d4ab1p
         ySkg==
X-Forwarded-Encrypted: i=1; AJvYcCWKdpS7LuE4umrubb0HmBPjtgthGttx0IFO7AlT4+5ZrM5h63ynYucWbtuMLWsry5xw66/p8wQcbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY74JlUFsB5PAsGd0T21uSPdsJexE6dpZs/LKAgTh5uPtiaL6W
	WEYMc/vH8Qy6mO4eSuL5HDKsIEwBw5bijnPlSY3x8mHbzY8FHX1JdRSfls/6o2A=
X-Gm-Gg: ASbGnctjWEN/bAOhAupfNnRivHcyTxgoH7T9SJhcW2TfZqH9vrhBpEj1ah/ANtfEP1r
	zZnAsY95+pvgLo/k5Kblfh1CUMHUvZQrLQexZrEm/0b6lN4i4iwAA8e1yPKULPIAGhXNzSEMH5q
	AiCchiYjt5DvTyddaS3Sq26cH2kqXaZ6jGu4WpE8oD9X0FvdzgEW7SSactKw+z5+GOH0POJnDuv
	RTkU0lWozYGT3sNJ+R0JgFoNBG1FPzFJBPh/H+1+kbTYJZVxcFTWUCn+vT86jiYy421ilzNiupl
	2HxCqIolUBIFyEfEQ4UttdkXWnw=
X-Google-Smtp-Source: AGHT+IH0D2BTFO4lLWrwOI5qlHZb/ab3iD4eTxYpRNpC5w+FLQ9G/yFTXTi/l1wQsEuQuG8y3L4+Pw==
X-Received: by 2002:a05:600c:354e:b0:434:a802:e9b2 with SMTP id 5b1f17b1804b1-434a9dbc589mr34098165e9.4.1732722929148;
        Wed, 27 Nov 2024 07:55:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8ad2:e64c:f150:ebc6? ([2a01:e0a:982:cbb0:8ad2:e64c:f150:ebc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7a4f69sm25388865e9.3.2024.11.27.07.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 07:55:28 -0800 (PST)
Message-ID: <79e76b0d-15df-444e-ab14-24cf32678b96@linaro.org>
Date: Wed, 27 Nov 2024 16:55:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 08/11] drm/msm: adreno: request for maximum bus
 bandwidth usage
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
 <20241119-topic-sm8x50-gpu-bw-vote-v2-8-4deb87be2498@linaro.org>
 <20241123225954.lv3k2fxk7rxyh67z@hu-akhilpo-hyd.qualcomm.com>
 <1965cd01-7b31-4f16-82b2-27fd56fcb77e@linaro.org>
 <2d3a77da-cf73-4888-bc4d-68482181c908@quicinc.com>
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
In-Reply-To: <2d3a77da-cf73-4888-bc4d-68482181c908@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/11/2024 16:46, Akhil P Oommen wrote:
> On 11/25/2024 1:44 PM, Neil Armstrong wrote:
>> On 23/11/2024 23:59, Akhil P Oommen wrote:
>>> On Tue, Nov 19, 2024 at 06:56:43PM +0100, Neil Armstrong wrote:
>>>> When requesting a DDR bandwidth level along a GPU frequency
>>>> level via the GMU, we can also specify the bus bandwidth usage in a
>>>> 16bit
>>>> quantitized value.
>>>>
>>>> For now simply request the maximum bus usage.
>>>
>>> Why? You don't care about power efficiency?
>>> Lets drop this patch. We don't care about AB vote yet.
>>
>> I care about functionality, without this AB vote the spillall use
>> case that fails on SM8650 HDK fails on the SM8650 QRD.
> 
> This should have been documented as a comment so that someone doesn't
> remove it in future.
> 
>>
>> AB is a quantitized value of the BW voted, so yes I expect we can have
>> 100% of the BW voted, but since we scale the BW it's perfectly fine.
> 
> Ah! no. MAX AB vote here is equal to the Max IB vote value in the hfi
> table. This is why I was asking about including all BW levels from the
> DT in the hfi table in the other patch.
> 
> So you are always voting for Max DDR Freq which is probably helping (or
> masking?) the spill all issue. We can just add a quirk to vote for MAX
> IB probably.

Oh, indeed I've been re-reading gen7_bus_ab_quantize() and it seems
I should calculate the AB vote when building the bw_table.

Thanks,
Neil

> 
> -Akhil
> 
>>
>> Neil
>>
>>>
>>> -Akhil
>>>
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 11 +++++++++++
>>>>    drivers/gpu/drm/msm/adreno/a6xx_hfi.h |  5 +++++
>>>>    2 files changed, 16 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/
>>>> msm/adreno/a6xx_gmu.c
>>>> index
>>>> dc2d0035544e7848e5c4ea27f1ea9a191f9c4991..36c0f67fd8e109aabf09a0804bacbed3593c39d7 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>>> @@ -134,6 +134,17 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu,
>>>> struct dev_pm_opp *opp,
>>>>                if (bw == gmu->gpu_bw_table[bw_index])
>>>>                    break;
>>>>            }
>>>> +
>>>> +        if (bw_index) {
>>>> +            /*
>>>> +             * Append AB vote to the maximum bus usage.
>>>> +             * AB represents a quantitized 16bit value of the
>>>> +             * max ddr bandwidth we could use, let's simply
>>>> +             * request the maximum for now.
>>>> +             */
>>>> +            bw_index |= AB_VOTE(MAX_AB_VOTE);
>>>> +            bw_index |= AB_VOTE_ENABLE;
>>>> +        }
>>>>        }
>>>>          gmu->current_perf_index = perf_index;
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/
>>>> msm/adreno/a6xx_hfi.h
>>>> index
>>>> 528110169398f69f16443a29a1594d19c36fb595..52ba4a07d7b9a709289acd244a751ace9bdaab5d 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
>>>> @@ -173,6 +173,11 @@ struct a6xx_hfi_gx_bw_perf_vote_cmd {
>>>>        u32 bw;
>>>>    };
>>>>    +#define AB_VOTE_MASK        GENMASK(31, 16)
>>>> +#define MAX_AB_VOTE        (FIELD_MAX(AB_VOTE_MASK) - 1)
>>>> +#define AB_VOTE(vote)        FIELD_PREP(AB_VOTE_MASK, (vote))
>>>> +#define AB_VOTE_ENABLE        BIT(8)
>>>> +
>>>>    #define HFI_H2F_MSG_PREPARE_SLUMBER 33
>>>>      struct a6xx_hfi_prep_slumber_cmd {
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>
> 


