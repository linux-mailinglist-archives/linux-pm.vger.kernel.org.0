Return-Path: <linux-pm+bounces-18030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD99D7CA4
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 09:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B731281DB1
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 08:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B37318787F;
	Mon, 25 Nov 2024 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjD4YJh3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42395155747
	for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2024 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732522465; cv=none; b=r19TfB9Cqi53MIKRsuv5ClrwyPwB0cgT8VWZEqc82eqdTIGCXPCf4Dq0Xx96ZPhjre0hcdJQQ8d7hB1QS+YhEEwu/AdsdVuqBgL5e/jvjjIJiyOUfHpdEgbxUXUCRgibcDXCd/B6DOKh1NH/PXRNfy9v4nu2RyvbY5Ec0F6UUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732522465; c=relaxed/simple;
	bh=w/5u7Jk2vOFpnbW0Ti/xir1zG7fptuhC5FBDunZwPvQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Uj/GLs7xFvr0kFl/xGUQb1mi3RadlNVB7ETNS7Al8cEUFnwpfISZLQpy18tnFBisD5sFd9m3ESf5tw+gePypTSe50d5HOqjeJ3SP/lmrgHndwISKkj31qHdzq5QFbddlJzGPaIuNDJOjT30HsewczXYHjpyHM8zlZEOBtANAYQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AjD4YJh3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4349fd77b33so4630705e9.2
        for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2024 00:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732522463; x=1733127263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJYq/ufVyCyQrJjMpbrUBAtwTDNfWWvkDBQ3TDITt2E=;
        b=AjD4YJh35a0ypeNJ/nEgASaZ9gSsdhNH8xsPD5y06jKGenZIbjt13r7Mj1QAa50C0h
         DKOJPCe/gjy+Pv9+yDMz+iVXNPMxrZLiN1fGNrFmmmrk55Z3cgUCq3xLDU5AubRyNh2y
         iI2iotSi2z+wxTyr3+e5fWECXPr05+akT1qN0MIjiMHHeDGgTtvEZV2YzOGC5y5VLYup
         qtXmtD2ARxc8YT5tbFvKk4NhLcI5iOZoXeE3dahl8ln8kJw+g0Mo23muuuDz6MwKIbSq
         oc6aVQ16T1CdoRCsLzZtTDa6i243Wyb40b+E1rrxZJVN2zuCLGiQ28QvMEfrAPjEUZxT
         zdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732522463; x=1733127263;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YJYq/ufVyCyQrJjMpbrUBAtwTDNfWWvkDBQ3TDITt2E=;
        b=RF6ONbcK+IuFNZhD77aU5jgc16yEnbsmzmcnfFXHG9uYxlftHiFkOmGwfbiqxJD2pW
         RUVKfcIHe1Uttfntu3M7/fphPTHnWgJk0mBMbyk5s1bMWoJ7jwjlz696Z1dqZfiRY2ET
         Lo6SwXy+/dEN6hcC/XBrU8aybCefRFuy9GYcmxSKIaMaIBPbvQjFGHrrJXlXp43q/zoR
         3dacmgc6dQyMLLichqN/SI0ymJJZBbIudoX7Oyf3/wDE5OThKk+Tk7ZiAh3j7q41afyb
         KOezWwSELEfKdpLBFpIZYIbKhUh1iXARjgxhwhkouqJYP06wcCwds+5cuWn1/P2s1GLl
         QZlw==
X-Forwarded-Encrypted: i=1; AJvYcCXu5MYSbOasKo6siwGT4OnozOv5z4ZKmDVT0bTuO7WwR3+BUkI8NnLI2csJoOx7AiDcZqGBsZ/mvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGVxKSnZlbFpKkoAQ0mdaFUT7pr0q4rjFLAglEArhLEKpQqr4K
	NUkuGb6cy778pEN8oslyTHNh0mtyiR0FhuB8Al03l50ZmcbY4JIXkfrG9jJpwn4=
X-Gm-Gg: ASbGncs6CZDXjlx8Ec/Ygd97P6UzDs6lWnP/SfZbpVO8RGRbazW7uN/uRusS5BsdFPm
	a0BONJNF65/t+n46bd8HRo8vjxYMP2C2SGKyUKJdpJCU/r4RGaxWbF4YSYyfYpShryBFW0IGsUV
	g+oYl3dUpOeDH6awx7lGZhMGb6e2QicKklGNUvCpEVC19dP5RmdHFaoy42utpOySGp6KzbKihH6
	NBJ5m5jQ3N1HuZxlJNxMWH+frb8RRnfY8//emPwyt7/wQg8bRhp9Y+tlK15VVZ77DSFKFw79Pft
	FMG/H8i4ps3pVCzBtMbrMn4NzJE=
X-Google-Smtp-Source: AGHT+IHb8RG3CjwsMrQMRixwfeFBD1mGI+t7VoI8qc88KfSgFTabuTFgWinCCEg7/AuU3JSOkTjHJQ==
X-Received: by 2002:a05:6000:23c5:b0:37d:50e1:b3d3 with SMTP id ffacd0b85a97d-38260b5e4e2mr7233009f8f.20.1732522462734;
        Mon, 25 Nov 2024 00:14:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9dc0:6c46:415c:5f8b? ([2a01:e0a:982:cbb0:9dc0:6c46:415c:5f8b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a16d96d6sm6722365e9.7.2024.11.25.00.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 00:14:22 -0800 (PST)
Message-ID: <1965cd01-7b31-4f16-82b2-27fd56fcb77e@linaro.org>
Date: Mon, 25 Nov 2024 09:14:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20241123225954.lv3k2fxk7rxyh67z@hu-akhilpo-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/11/2024 23:59, Akhil P Oommen wrote:
> On Tue, Nov 19, 2024 at 06:56:43PM +0100, Neil Armstrong wrote:
>> When requesting a DDR bandwidth level along a GPU frequency
>> level via the GMU, we can also specify the bus bandwidth usage in a 16bit
>> quantitized value.
>>
>> For now simply request the maximum bus usage.
> 
> Why? You don't care about power efficiency?
> Lets drop this patch. We don't care about AB vote yet.

I care about functionality, without this AB vote the spillall use
case that fails on SM8650 HDK fails on the SM8650 QRD.

AB is a quantitized value of the BW voted, so yes I expect we can have
100% of the BW voted, but since we scale the BW it's perfectly fine.

Neil

> 
> -Akhil
> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 11 +++++++++++
>>   drivers/gpu/drm/msm/adreno/a6xx_hfi.h |  5 +++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> index dc2d0035544e7848e5c4ea27f1ea9a191f9c4991..36c0f67fd8e109aabf09a0804bacbed3593c39d7 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> @@ -134,6 +134,17 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
>>   			if (bw == gmu->gpu_bw_table[bw_index])
>>   				break;
>>   		}
>> +
>> +		if (bw_index) {
>> +			/*
>> +			 * Append AB vote to the maximum bus usage.
>> +			 * AB represents a quantitized 16bit value of the
>> +			 * max ddr bandwidth we could use, let's simply
>> +			 * request the maximum for now.
>> +			 */
>> +			bw_index |= AB_VOTE(MAX_AB_VOTE);
>> +			bw_index |= AB_VOTE_ENABLE;
>> +		}
>>   	}
>>   
>>   	gmu->current_perf_index = perf_index;
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
>> index 528110169398f69f16443a29a1594d19c36fb595..52ba4a07d7b9a709289acd244a751ace9bdaab5d 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
>> @@ -173,6 +173,11 @@ struct a6xx_hfi_gx_bw_perf_vote_cmd {
>>   	u32 bw;
>>   };
>>   
>> +#define AB_VOTE_MASK		GENMASK(31, 16)
>> +#define MAX_AB_VOTE		(FIELD_MAX(AB_VOTE_MASK) - 1)
>> +#define AB_VOTE(vote)		FIELD_PREP(AB_VOTE_MASK, (vote))
>> +#define AB_VOTE_ENABLE		BIT(8)
>> +
>>   #define HFI_H2F_MSG_PREPARE_SLUMBER 33
>>   
>>   struct a6xx_hfi_prep_slumber_cmd {
>>
>> -- 
>> 2.34.1
>>


