Return-Path: <linux-pm+bounces-27233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 128D5AB9EDC
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 16:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3751BC5137
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6E81A0730;
	Fri, 16 May 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nAwbAjAV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEDC193062
	for <linux-pm@vger.kernel.org>; Fri, 16 May 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406726; cv=none; b=vEpaHO8F5kpLlvUCPby6CgGEFahpO9dAye/dpsr/3hfbcF0dny11es2j3bOM6pS/RC6zR8XCq4abBHi+jn8SHWigPqqt+fp9YYGmtx9Vnyv2mlpvBSyKScEAVgCg9RD7uZ0+07bbeMQSuJHY6LjHZPwKZTWUT/0Nd3/QfftN7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406726; c=relaxed/simple;
	bh=N7Liw7c36pTdZuHiUAWTD2kfaxk2DuwfaFnr0fCGPWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smLkef8amhrHyOsh39dZCqe1raRmG4XFMeVgTOeJ8xVaIIVim2W//2AToxkPAmO23tPCdPax332Eoon/z/AOMB2wKjc2BL1E7CNy/ghOpGqFydbKOS/QZqDmFU4GmBpGf3nPUsIQy6D5TWDhc5jd7ykAWoW1iAfv9zd2JaYbwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nAwbAjAV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so15990535e9.3
        for <linux-pm@vger.kernel.org>; Fri, 16 May 2025 07:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747406723; x=1748011523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8DPdNi4T7V/yvBz4It+xorfOv4L6Xc1BemGmrvImCwg=;
        b=nAwbAjAVYXguOh2v1ojCDYJdRwpiiehEWq2Nh0DiI7BrSbLVOVFU6xhF76fJh8Z4UW
         7et80Lk5STd/TVvdJWToEBAtE0Slkam0PSD/YLeMbLyOqhXTjt+Om8fzzJDPJLmjeGgw
         64IMz/OpF8syIhUAaDOHLvEXWsdPVT72SccI91+nljYtqp3Q/Kdtp8TZqIXUHYjk4PKN
         pnc1mtwqH+gKEofmerWiCyJXr8LEPtBlvD1JmHmjF6Ea7fxOlnC2ozotWHBacWRI+rUg
         XTaX6yPrzX1EtGfK6P+oXI212smJbti15ouCktGnFoOeI2SsttKipKTrdH5ocmIYzyMR
         OZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747406723; x=1748011523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DPdNi4T7V/yvBz4It+xorfOv4L6Xc1BemGmrvImCwg=;
        b=uAEvm/l7Um5Ajy7ca0G1YhQnKJ+ln32gX90f4lVcKRjx/F24O/ie5/VA/aEgwfedP6
         DGZLz8Iyi9aBGjz8jKP4XF2kG7lSEJNskGUt/ZEbvB6hWkC1XX1r6jOYLvZ1hjIgkydG
         AepphCeUE0l3fER4bPqRstli1H+/3WDzoQ7HzIgyZf35BKxksDEqlephRmfgzDBn5RuQ
         f76CD7pDwIFaWklt/IyBAhr5wjRIQqlXRcNZwmkPix3cbmzhMPYU2XzzuUHuBld/OC3X
         JRgl3DtKD5xCDgAS07VGiCkK7ezdqckZ07xoGJAfy+amuEZPDaBuzhSRuNxofD8tGa7J
         WNWg==
X-Forwarded-Encrypted: i=1; AJvYcCVVy38yHEdgwOjKoCLnbEKtPsLVMtVv3zWoqQ/HGOGxBfr/1KAlpuglR5yewzQmK8Q6rxdloT7YTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+MGIwsuBqV+NX2gEQx7LJCtT6X40zLYLkMKc/eFgPZdyS2dX1
	gZMnOLAuvaEC0unRuuAdWXeVPrHdgcPH8R+PV9o0JuAQYbuxgMtNjyIlf31u8zEM9QQ=
X-Gm-Gg: ASbGncvTCKa9fYKSH4O2jUIMLPUP3GgX0JB/Wv6un1oOWV8qDAq2Vay+Ljt/eugVDxU
	RGGDDUds/SPO0mZOVpfaTRGqyiSwK5s9bhLdXLMaKD5G/eSGeqdbeHL1Z28IEIYPuHdtZbD0SbD
	ZmXanfhAXiuwkG1z99/wQFDs6ipn5hL7QrPAb3gDVflA9NXUjl9dqZ/cE4IMJQHJi3LSq1ZgKpo
	tbh0S3QfdLP+oNuZoz+Be0VPq4TAOrFRS8NIPyQk1xVW4Ix3IS1yElTrrOhVRBb428/K9F07UMr
	OElPeVsCAuWf61mTJgflBJYqorUm7SaT6yHulELO0TpM+S9ygJR5Pmx2WHRI7tngtI+aton0Jao
	oRNuQQcCzcVLU
X-Google-Smtp-Source: AGHT+IE+e8uUfU2U7RrsspDQy+hqfnS3XZDgVHe+ewX3FxYMCsEn5Vbv/9CZ6GBFRep73wxKvvMGnw==
X-Received: by 2002:a05:600c:34d5:b0:43c:e7a7:1e76 with SMTP id 5b1f17b1804b1-442fefd5e7fmr30145935e9.1.1747406722689;
        Fri, 16 May 2025 07:45:22 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f39e84acsm112377585e9.25.2025.05.16.07.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 07:45:22 -0700 (PDT)
Message-ID: <3c44154c-7261-4b03-bd12-bddf4d493e74@linaro.org>
Date: Fri, 16 May 2025 16:45:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Exynos Thermal code improvement
To: Anand Moon <linux.amoon@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>,
 "open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>,
 "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20250430123306.15072-1-linux.amoon@gmail.com>
 <aCR9RzGMWEuI0pxS@mai.linaro.org>
 <CANAwSgSA-JHMRD7-19wijOY=TSWD-sv6yyrT=mH+wkUJuvxFAw@mail.gmail.com>
 <92c2949e-2fc1-40e9-9dea-e3d9f7aa571d@linaro.org>
 <CANAwSgQryVLdRVd9KRBnaUcjtX8xR9w9BBTCvoqKH6funkj=2A@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CANAwSgQryVLdRVd9KRBnaUcjtX8xR9w9BBTCvoqKH6funkj=2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/15/25 20:01, Anand Moon wrote:
> Hi Daniel,
> 
> On Thu, 15 May 2025 at 18:59, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 5/15/25 13:10, Anand Moon wrote:
>>> Hi Daniel,
>>>
>>> On Wed, 14 May 2025 at 16:53, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On Wed, Apr 30, 2025 at 06:02:56PM +0530, Anand Moon wrote:
>>>>> Hi All,
>>>>
>>>> Hi Anand,
>>>>
>>>> if the goal of the changes is to do cleanups, I recommend to rework
>>>> how the code is organized. Instead of having the data->soc check all
>>>> around the functions, write per platform functions and store them in
>>>> struct of_device_id data field instead of the soc version.
>>>>
>>>> Basically get rid of exynos_map_dt_data by settings the different ops
>>>> in a per platform structure.
>>>>
>>>> Then the initialization routine would be simpler to clean.
>>>>
>>>
>>> Thanks, I had previously attempted this approach.
>>> The goal is to split the exynos_tmu_data structure to accommodate
>>> SoC-specific callbacks for initialization and configuration.
>>>
>>> In my earlier attempt, I tried to refactor the code to achieve this.
>>> However, the main challenge I encountered was that the
>>> exynos_sensor_ops weren’t being correctly mapped for each SoC.
>>>
>>> Some SoC have multiple sensor
>>> exynos4x12
>>>                       tmu: tmu@100c0000
>>> exynos5420
>>>                   tmu_cpu0: tmu@10060000
>>>                   tmu_cpu1: tmu@10064000
>>>                   tmu_cpu2: tmu@10068000
>>>                   tmu_cpu3: tmu@1006c000
>>>                   tmu_gpu: tmu@100a0000
>>>    exynos5433
>>>                   tmu_atlas0: tmu@10060000
>>>                   tmu_atlas1: tmu@10068000
>>>                   tmu_g3d: tmu@10070000
>>> exynos7
>>>                   tmu@10060000
>>>
>>> It could be a design issue of the structure.or some DTS issue.
>>> So what I found in debugging it is not working correctly.
>>>
>>> static const struct thermal_zone_device_ops exynos_sensor_ops = {
>>>           .get_temp = exynos_get_temp,
>>>           .set_emul_temp = exynos_tmu_set_emulation,
>>>           .set_trips = exynos_set_trips,
>>> };
>>>
>>> The sensor callback will not return a valid pointer and soc id for the get_temp.
>>>
>>> Here is my earlier version of local changes.
>>> [1] https://pastebin.com/bbEP04Zh exynos_tmu.c
>>> [2] https://pastebin.com/PzNz5yve Odroid U3 dmesg.log
>>> [3] https://pastebin.com/4Yjt2d2u    Odroid Xu4 dmesg.log
>>>
>>> I want to re-model the structure to improve the code.
>>> Once Its working condition I will send this for review.
>>>
>>> If you have some suggestions please let me know.
>>
>> I suggest to do the conversion step by step beginning by
>> exynos4210_tmu_clear_irqs, then by exynos_map_dt_data as the first
>> cleanup iteration
>>
> Ok you want IRQ handle per SoC call back functions?
> so on all the changes depending on SoC id should be moved to
> respective callback functions to reduce the code.

I think you can keep the same irq handler function but move the 
tmu_intstat, tmu_intclear in the persoc structure and remove the 
exynos4210_tmu_clear_irqs function.

You should end up with something like:

static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
{
	struct exynos_tmu_data *data = id;
	unsigned int val_irq;

	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);

	mutex_lock(&data->lock);
	clk_enable(data->clk);

	val_irq = readl(data->base + data->tmu_intstat);
         writel(val_irq, data->base + data->tmu_intclear);

	clk_disable(data->clk);
	mutex_unlock(&data->lock);

	return IRQ_HANDLED;
}

But if the irq handler has some soc specific code, then it should be a 
separate function

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

