Return-Path: <linux-pm+bounces-17098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B40819C009D
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 09:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78331C21ABD
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF221DE8A0;
	Thu,  7 Nov 2024 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vvuvDYwR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143D01DD556
	for <linux-pm@vger.kernel.org>; Thu,  7 Nov 2024 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969761; cv=none; b=XLD2esNfxu9xE1hrcTiYQvvGPsyeVKOvnfPzyE6krRz4xIYJxC0K+lnRuqDaFflRs3RVWW1ACTbQZIGbtp4QUUwY35BYtw1QuIjXJItFGOgZIpEoySJx4XpxIQqd79DKX4sfAc3yT1QATKyNWOoiq7lPNPXK9oXxB3ZNs5qyN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969761; c=relaxed/simple;
	bh=oUKXS1Trx2oLd1tIewxL57LIdNPU6w5il/qAiXfM5dQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=U46/+qXKvPCL9ooxQR/ew7vKDMBadeqsSsDTFURc7nPeWgFi+U9nfYQHvWhsjeLMmxOyv3ktpL+QBp7tSrz9Z9YdTGhnBFZMsUuWFTyilJX7Jpn1csyoi2e5qX2l0Rn9z0SIluBaRWePyW2xelhAXbb2tBWNy+maUGJC1BpOFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vvuvDYwR; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e6c754bdso528002e87.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2024 00:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730969757; x=1731574557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22XbHSdxTpfYFI6FS3XwYfdVJJn+nc1ZTuC9aza1c+M=;
        b=vvuvDYwRUC1QcTXDMu76yTY8bE1U2mxXjUaGFQ4GYKhfBHlgr27MPTEwQbfnUYtw4t
         rNpx55QL83knreDxCVJE/xf2fuiSmvWL922L2AFsl896bjCj8P+twKaXky9uh5gVZmon
         9enIIBVuHWdjylgRs0IqSSOrD3zChoSGxjXhwYDblwtMdHdvPUxd4r/zILV1RV8wSTJp
         y66IGTm8FfgknX3QTm4DS4UpDEpdB48fwbT64oBTlF4tDiMJeAj06tW2VjEkt18auEz9
         Hv6nqIIN3u/S3K+1alQBLQGbgdVxd4Fj28Ljcqxi2qdnJpcGGK0N3F8T+e5wXC3+pQrp
         iBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730969757; x=1731574557;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=22XbHSdxTpfYFI6FS3XwYfdVJJn+nc1ZTuC9aza1c+M=;
        b=E1O9E7XXKL8a1j5tJdA1+tyMhjaUVreFd2Du7MSRbhpwN4dls7rTNNFrYe56K+uMm8
         1lwpYgjKnDesVTxQ0umZ14dS7+U2+8k0Q/LBT6vvqaXc/USCozZCKVJIrZ51ytTXARGq
         g8CY03eZtZGZq/zFX9nM6addVoWWq2cpN4HwY64lGwjKkICiqmszN+HokmMJmdh3xNlT
         hkq9gABsHLipzD60gN0eDWjqoCzP0Ij3kOCbNXLgE1P9e+QNhmTCo10PyRXBJ7FSi2va
         axjuRh2YMyAD73oM8ERfXDQKhSpebQv+X67SKr9S4+yjeSV4P17BA4YPonbIE3OkklyY
         oy/w==
X-Forwarded-Encrypted: i=1; AJvYcCUxSACzFCge9Y/+1McHjpUkvl8aVUXgpZ7hIYN43XdSW/SZqVq1ADpT3ac1hKEbD+QAYCJS51aOxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvulJrgstOKT5u4LYjihk6RIDvIwJGVXI0osL3zQLQnWOlaQtV
	xia8c417VF3sDMyvJ8RWOad6YQS47CeNJUSn1bQR2KVz+Wp/UEfg7rt3XYiaiT8=
X-Google-Smtp-Source: AGHT+IHLCitCgygItsIvrBIVb0mwAMkG7nEKi2gvAEQviQ2+FqlmxeJnYgE7zjwr6oiTTX/4e230MQ==
X-Received: by 2002:a05:6512:3c97:b0:539:e12c:bba7 with SMTP id 2adb3069b0e04-53d8405ca28mr171761e87.12.1730969756964;
        Thu, 07 Nov 2024 00:55:56 -0800 (PST)
Received: from [172.16.23.252] ([154.14.63.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c2161sm15522375e9.31.2024.11.07.00.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 00:55:56 -0800 (PST)
Message-ID: <56a976d6-7dd6-4001-b6a8-268ed7d787d2@linaro.org>
Date: Thu, 7 Nov 2024 09:55:53 +0100
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
In-Reply-To: <43404449-1830-4651-a85a-54404b1d35bc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/11/2024 02:44, Akhil P Oommen wrote:
> On 11/4/2024 9:14 PM, neil.armstrong@linaro.org wrote:
>> On 11/10/2024 22:29, Akhil P Oommen wrote:
>>> ACD a.k.a Adaptive Clock Distribution is a feature which helps to reduce
>>> the power consumption. In some chipsets, it is also a requirement to
>>> support higher GPU frequencies. This patch adds support for GPU ACD by
>>> sending necessary data to GMU and AOSS. The feature support for the
>>> chipset is detected based on devicetree data.
>>>
>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>> ---
>>>    drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 81 +++++++++++++++++++++++++
>>> +++-------
>>>    drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
>>>    drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 36 ++++++++++++++++
>>>    drivers/gpu/drm/msm/adreno/a6xx_hfi.h | 21 +++++++++
>>>    4 files changed, 124 insertions(+), 15 deletions(-)
>>>
>>
>> <snip>
>>
>>> +
>>> +static int a6xx_hfi_enable_acd(struct a6xx_gmu *gmu)
>>> +{
>>> +    struct a6xx_hfi_acd_table *acd_table = &gmu->acd_table;
>>> +    struct a6xx_hfi_msg_feature_ctrl msg = {
>>> +        .feature = HFI_FEATURE_ACD,
>>> +        .enable = 1,
>>> +        .data = 0,
>>> +    };
>>> +    int ret;
>>> +
>>> +    if (!acd_table->enable_by_level)
>>> +        return 0;
>>> +
>>> +    /* Enable ACD feature at GMU */
>>> +    ret = a6xx_hfi_send_msg(gmu, HFI_H2F_FEATURE_CTRL, &msg,
>>> sizeof(msg), NULL, 0);
>>> +    if (ret) {
>>> +        DRM_DEV_ERROR(gmu->dev, "Unable to enable ACD (%d)\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    /* Send ACD table to GMU */
>>> +    ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_ACD, &msg, sizeof(msg),
>>> NULL, 0);
>>
>> This looks wrong, in this exact code, you never use the acd_table...
>> perhaps it should be acd_table here
> 
> Whoops! Weirdly gmu didn't explode when I tested.
> 
> Thanks for your keen eye.

You're welcome !

I've been trying to enable this on SM8650, but HFI_H2F_MSG_ACD fails.

My changes:
================><================================
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 7c96d6f8aaa9..bd9d586f245e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -682,7 +682,7 @@ static int a6xx_hfi_enable_acd(struct a6xx_gmu *gmu)
         }

         /* Send ACD table to GMU */
-       ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_ACD, &acd_table, sizeof(*acd_table), NULL, 0);
+       ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_ACD, &acd_table, sizeof(struct a6xx_hfi_acd_table), NULL, 0);
         if (ret) {
                 DRM_DEV_ERROR(gmu->dev, "Unable to send ACD table (%d)\n", ret);
                 return ret;
================><================================

with the appropriate qcom,opp-acd-level in DT taken from downstream, I get:
[    6.946184] platform 3d6a000.gmu: [drm:a6xx_hfi_send_msg.constprop.0 [msm]] *ERROR* Message (null) id 4 timed out waiting for response
[    6.958697] platform 3d6a000.gmu: [drm:a6xx_hfi_start [msm]] *ERROR* Unable to send ACD table (-110)

is there something missing ?

Neil

> 
> -Akhil.
> 
>>
>>> +    if (ret) {
>>> +        DRM_DEV_ERROR(gmu->dev, "Unable to ACD table (%d)\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>    static int a6xx_hfi_send_test(struct a6xx_gmu *gmu)
>>>    {
>>>        struct a6xx_hfi_msg_test msg = { 0 };
>>> @@ -756,6 +788,10 @@ int a6xx_hfi_start(struct a6xx_gmu *gmu, int
>>> boot_state)
>>>        if (ret)
>>>            return ret;
>>>    +    ret = a6xx_hfi_enable_acd(gmu);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>>        ret = a6xx_hfi_send_core_fw_start(gmu);
>>>        if (ret)
>>>            return ret;
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/
>>> msm/adreno/a6xx_hfi.h
>>> index 528110169398..51864c8ad0e6 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
>>> @@ -151,12 +151,33 @@ struct a6xx_hfi_msg_test {
>>>        u32 header;
>>>    };
>>>    +#define HFI_H2F_MSG_ACD 7
>>> +#define MAX_ACD_STRIDE 2
>>> +
>>> +struct a6xx_hfi_acd_table {
>>> +    u32 header;
>>> +    u32 version;
>>> +    u32 enable_by_level;
>>> +    u32 stride;
>>> +    u32 num_levels;
>>> +    u32 data[16 * MAX_ACD_STRIDE];
>>> +};
>>> +
>>>    #define HFI_H2F_MSG_START 10
>>>      struct a6xx_hfi_msg_start {
>>>        u32 header;
>>>    };
>>>    +#define HFI_H2F_FEATURE_CTRL 11
>>> +
>>> +struct a6xx_hfi_msg_feature_ctrl {
>>> +    u32 header;
>>> +    u32 feature;
>>> +    u32 enable;
>>> +    u32 data;
>>> +};
>>> +
>>>    #define HFI_H2F_MSG_CORE_FW_START 14
>>>      struct a6xx_hfi_msg_core_fw_start {
>>>
>>
>> Thanks,
>> Neil
> 


