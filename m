Return-Path: <linux-pm+bounces-17117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29289C08E7
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 15:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FDA2833CC
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3D0212196;
	Thu,  7 Nov 2024 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmoD10Sq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2F51F8EFF
	for <linux-pm@vger.kernel.org>; Thu,  7 Nov 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989871; cv=none; b=UaWk/XiHZ/o2lzK7nXGiOAD8uTUs5QyGc3gCACACfULt86AJkNAkLzlLGUPtvrZEN5/GHRnvK5jHuFrpyA4Jmy9Sc4OeI0nYdui1jmsBWyLtUxpCudJNSR3oLDP1CMjbB4xbbSO6yj4BmrC9dzSX48K4LRcay95qo1T65zp19SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989871; c=relaxed/simple;
	bh=BZ5oTKHBKMEtyTEuiNUO32t+G7u472nOePKIEpkjFPk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mVyxvRuduqOCwUo0mvOdbnqcbkhq2quC6LyoW1zX/l9nmlJWs2WNG/lSr1t5YvQgD21LE4vCGnsl4lXG3ayNvQe0f3L84mbQ7k2HDtPGMjeBp8Oj2YoEe6h2+FndHcj46dlNype6R7+zrZKqmMl9numhFtUaRNCu+7w0K8M5J/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kmoD10Sq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315baec69eso9175725e9.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2024 06:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730989868; x=1731594668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52spWhmFBKhhJZSyR9FLJzET+EvHavBhysGOe9CL+hQ=;
        b=kmoD10SqEQEhXpS+YHThSaRuHI7ncIVELSNULAtZ8RQl0OV3H+h/zqxFvezQU+NUNV
         7pDwdr/AbsefB6xhhnpUsnUXo5tKuToSSjHKiHOl9juGKQX65bHngPygpt8gQfMUtIPX
         uhRObp7DuEknttOlDO+/LhDTsMPnCxzxNyzFBxMgM7N4+SQREe4yuZ79nNUk9PEOAkok
         BhWiMEp62m8sCVdt1yd7cGXUUndFWa+zLkCCey2zBHZVJy/RIJLY2Qz6q26Tzt5EbPX7
         ao+ZY1GeVfmLkAWKkahXrJESpyDv9dU6QMHPir5Clru8WWo/77xkBWTcoUbGcMcTr1BB
         WUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730989868; x=1731594668;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=52spWhmFBKhhJZSyR9FLJzET+EvHavBhysGOe9CL+hQ=;
        b=p9bedde4k5jFZGpGhDuJhCl7erpkkM4g9hJ7V8PBQCemipAQDpHMjX9ZgEN8TE5R2M
         UjjP+8mno6Xo7EUfIxGyU8d4ugKqwl7WizHL21VZG7UeETbN5o88p1xEH+gNPi23fum9
         5XF9gMaAWP9z501WyXT7Ef3OWcoyE1qyJMsK1swzlbbM2Hgo/tKMb3Clm+9lb8z0w7Cc
         Q2ezhasc5chj+QVbjAwuzDpw2FE4LomvYrb1wabosuFtMHgbL5jTqZ39Muko/kgvGRiM
         iks6vFlb2I/x5TEo1fIWDwEKY0K5LydIjzkI+y0ZoIYJsHA6k8ilRJXet9nIy7eGjnIh
         +qKg==
X-Forwarded-Encrypted: i=1; AJvYcCU9///PNrWykoJJGuWFatpv4+fUoErJrK+ask/l1O/D8VYw9a4jXuaqppbWr4yq9EtJbzylp6lBvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoxYU3UJmEad+VGM7r3qgP00EujNOVLI7lMKM56VW6sKNcPJo8
	X+y9xV9me0bWxQVt5NURLcVwYLw1K8eDw8IDWNeKikbqg/lVQSzYbfkKnPwuKdw=
X-Google-Smtp-Source: AGHT+IH1XW54uNic2Zsxikuj4la1QpramzsNuBrwv0oti7++/bg6c3Sof5I5A2uO5KaEWXSxgWOsoA==
X-Received: by 2002:a05:6000:1569:b0:37d:5103:8894 with SMTP id ffacd0b85a97d-381c7aa4a56mr20990212f8f.42.1730989867777;
        Thu, 07 Nov 2024 06:31:07 -0800 (PST)
Received: from [172.16.23.252] ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9719easm1930183f8f.9.2024.11.07.06.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 06:31:07 -0800 (PST)
Message-ID: <85eaeaca-850d-47d4-b81d-b23f25084d81@linaro.org>
Date: Thu, 7 Nov 2024 15:31:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC 1/3] drm/msm/adreno: Add support for ACD
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
References: <20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com>
 <20241012-gpu-acd-v1-1-1e5e91aa95b6@quicinc.com>
 <4aeec9f1-720b-400c-9582-d02847db2ac7@linaro.org>
 <43404449-1830-4651-a85a-54404b1d35bc@quicinc.com>
 <56a976d6-7dd6-4001-b6a8-268ed7d787d2@linaro.org>
 <49e1a6b6-683f-4826-b67e-8354a10a785d@quicinc.com>
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
In-Reply-To: <49e1a6b6-683f-4826-b67e-8354a10a785d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/11/2024 13:46, Akhil P Oommen wrote:
> On 11/7/2024 2:25 PM, neil.armstrong@linaro.org wrote:
>> On 06/11/2024 02:44, Akhil P Oommen wrote:
>>> On 11/4/2024 9:14 PM, neil.armstrong@linaro.org wrote:
>>>> On 11/10/2024 22:29, Akhil P Oommen wrote:
>>>>> ACD a.k.a Adaptive Clock Distribution is a feature which helps to
>>>>> reduce
>>>>> the power consumption. In some chipsets, it is also a requirement to
>>>>> support higher GPU frequencies. This patch adds support for GPU ACD by
>>>>> sending necessary data to GMU and AOSS. The feature support for the
>>>>> chipset is detected based on devicetree data.
>>>>>
>>>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>>>> ---
>>>>>     drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 81 +++++++++++++++++++++++++
>>>>> +++-------
>>>>>     drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
>>>>>     drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 36 ++++++++++++++++
>>>>>     drivers/gpu/drm/msm/adreno/a6xx_hfi.h | 21 +++++++++
>>>>>     4 files changed, 124 insertions(+), 15 deletions(-)
>>>>>
>>>>
>>>> <snip>
>>>>
>>>>> +
>>>>> +static int a6xx_hfi_enable_acd(struct a6xx_gmu *gmu)
>>>>> +{
>>>>> +    struct a6xx_hfi_acd_table *acd_table = &gmu->acd_table;
>>>>> +    struct a6xx_hfi_msg_feature_ctrl msg = {
>>>>> +        .feature = HFI_FEATURE_ACD,
>>>>> +        .enable = 1,
>>>>> +        .data = 0,
>>>>> +    };
>>>>> +    int ret;
>>>>> +
>>>>> +    if (!acd_table->enable_by_level)
>>>>> +        return 0;
>>>>> +
>>>>> +    /* Enable ACD feature at GMU */
>>>>> +    ret = a6xx_hfi_send_msg(gmu, HFI_H2F_FEATURE_CTRL, &msg,
>>>>> sizeof(msg), NULL, 0);
>>>>> +    if (ret) {
>>>>> +        DRM_DEV_ERROR(gmu->dev, "Unable to enable ACD (%d)\n", ret);
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    /* Send ACD table to GMU */
>>>>> +    ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_ACD, &msg, sizeof(msg),
>>>>> NULL, 0);
>>>>
>>>> This looks wrong, in this exact code, you never use the acd_table...
>>>> perhaps it should be acd_table here
>>>
>>> Whoops! Weirdly gmu didn't explode when I tested.
>>>
>>> Thanks for your keen eye.
>>
>> You're welcome !
>>
>> I've been trying to enable this on SM8650, but HFI_H2F_MSG_ACD fails.
>>
>> My changes:
>> ================><================================
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/
>> msm/adreno/a6xx_hfi.c
>> index 7c96d6f8aaa9..bd9d586f245e 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>> @@ -682,7 +682,7 @@ static int a6xx_hfi_enable_acd(struct a6xx_gmu *gmu)
>>          }
>>
>>          /* Send ACD table to GMU */
>> -       ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_ACD, &acd_table,
>> sizeof(*acd_table), NULL, 0);
>> +       ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_ACD, &acd_table,
> 
> &acd_table -> acd_table here?

Damn, good catch !

Ok so it didn't explode anymore, but still fails:
=====
[    7.083258] platform 3d6a000.gmu: [drm:a6xx_hfi_send_msg.constprop.0 [msm]] *ERROR* Message HFI_H2F_MSG_GX_BW_PERF_VOTE id 7 timed out waiting for response
[    7.149709] platform 3d6a000.gmu: [drm:a6xx_hfi_send_msg.constprop.0 [msm]] *ERROR* Unexpected message id 7 on the response queue
[    7.149744] platform 3d6a000.gmu: [drm:a6xx_hfi_send_msg.constprop.0 [msm]] *ERROR* The HFI response queue is unexpectedly empty
[    7.165163] platform 3d6a000.gmu: [drm:a6xx_hfi_send_msg.constprop.0 [msm]] *ERROR* Unexpected message id 8 on the response queue
[    7.165188] platform 3d6a000.gmu: [drm:a6xx_hfi_send_msg.constprop.0 [msm]] *ERROR* The HFI response queue is unexpectedly empty
====

Seems with ACD enabled, first vote can take up to 100ms, and downstream has 1s timeout, with a larger timeout I got it to work !

Thanks,
Neil
> 
> -Akhil
> 
>> sizeof(struct a6xx_hfi_acd_table), NULL, 0);
>>          if (ret) {
>>                  DRM_DEV_ERROR(gmu->dev, "Unable to send ACD table
>> (%d)\n", ret);
>>                  return ret;
>> ================><================================
>>
>> with the appropriate qcom,opp-acd-level in DT taken from downstream, I get:
>> [    6.946184] platform 3d6a000.gmu: [drm:a6xx_hfi_send_msg.constprop.0
>> [msm]] *ERROR* Message (null) id 4 timed out waiting for response
>> [    6.958697] platform 3d6a000.gmu: [drm:a6xx_hfi_start [msm]] *ERROR*
>> Unable to send ACD table (-110)
>>
>> is there something missing ?
>>
>> Neil
>>
>>>
>>> -Akhil.
>>>
>>>>
>>>>> +    if (ret) {
>>>>> +        DRM_DEV_ERROR(gmu->dev, "Unable to ACD table (%d)\n", ret);
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>     static int a6xx_hfi_send_test(struct a6xx_gmu *gmu)
>>>>>     {
>>>>>         struct a6xx_hfi_msg_test msg = { 0 };
>>>>> @@ -756,6 +788,10 @@ int a6xx_hfi_start(struct a6xx_gmu *gmu, int
>>>>> boot_state)
>>>>>         if (ret)
>>>>>             return ret;
>>>>>     +    ret = a6xx_hfi_enable_acd(gmu);
>>>>> +    if (ret)
>>>>> +        return ret;
>>>>> +
>>>>>         ret = a6xx_hfi_send_core_fw_start(gmu);
>>>>>         if (ret)
>>>>>             return ret;
>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/
>>>>> msm/adreno/a6xx_hfi.h
>>>>> index 528110169398..51864c8ad0e6 100644
>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
>>>>> @@ -151,12 +151,33 @@ struct a6xx_hfi_msg_test {
>>>>>         u32 header;
>>>>>     };
>>>>>     +#define HFI_H2F_MSG_ACD 7
>>>>> +#define MAX_ACD_STRIDE 2
>>>>> +
>>>>> +struct a6xx_hfi_acd_table {
>>>>> +    u32 header;
>>>>> +    u32 version;
>>>>> +    u32 enable_by_level;
>>>>> +    u32 stride;
>>>>> +    u32 num_levels;
>>>>> +    u32 data[16 * MAX_ACD_STRIDE];
>>>>> +};
>>>>> +
>>>>>     #define HFI_H2F_MSG_START 10
>>>>>       struct a6xx_hfi_msg_start {
>>>>>         u32 header;
>>>>>     };
>>>>>     +#define HFI_H2F_FEATURE_CTRL 11
>>>>> +
>>>>> +struct a6xx_hfi_msg_feature_ctrl {
>>>>> +    u32 header;
>>>>> +    u32 feature;
>>>>> +    u32 enable;
>>>>> +    u32 data;
>>>>> +};
>>>>> +
>>>>>     #define HFI_H2F_MSG_CORE_FW_START 14
>>>>>       struct a6xx_hfi_msg_core_fw_start {
>>>>>
>>>>
>>>> Thanks,
>>>> Neil
>>>
>>
> 


