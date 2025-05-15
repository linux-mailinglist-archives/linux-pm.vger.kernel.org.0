Return-Path: <linux-pm+bounces-27197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFDEAB87F0
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 15:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA089E7AF0
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 13:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2090712CD8B;
	Thu, 15 May 2025 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nd2vWg9u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3872627
	for <linux-pm@vger.kernel.org>; Thu, 15 May 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747315745; cv=none; b=lcSLng2sGFwZc93vKWqiPy6qZJtWossvpsKiQDCVT1G5CQCNPT6phO/+ybVgwmyhKUwswOkhm406DjwPl0Pig/vN9q0H4SVPpFMNyTUwnuYjIgL+pShR3jxx+RFTIqR1npZEoL4MhrtGhWcqX8nGA6+0rE1wnQPXbmKq1PVOslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747315745; c=relaxed/simple;
	bh=0OxqwkoXyk4pMEZB+3Be/QzVD7EbaVm3mM/XisR5KNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xi3Qp/59IWabVAZyRV6qCQpC8+vxRXKWtYMdAW0bU4BoGTrIb3RLYB6uUnQmwvSbjk0Mng70EsGClSFnx95LJZlYR0K/snthMdrn2mSxEpwfWCwCXROHQ59/JI1TxBfSkC7XxaMHUqTUraNPMcRfkI308oHPhkXGylpfVgNuOYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nd2vWg9u; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfe574976so6503145e9.1
        for <linux-pm@vger.kernel.org>; Thu, 15 May 2025 06:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747315741; x=1747920541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXeqa887aZIuoR48uoN7BEsLTRu+NlEEvV/bSAfKqmQ=;
        b=Nd2vWg9uzonXvn3Ku+ahyeMH71CjBYLgnEdSYTMmCKCRYemS31Q7u3k8+JXO23jx0G
         tZIRiuw5f1jTL09JElIeNLFxAzH8hZu/W/bD0HVUabJZy/um+XTzVEprG65dstApHKp0
         Uzk26kgx1KunmPcYVcE5TifN0yiKLQNSs2iTNjEZE+ZfSvWdE+5bFdQEX3Fm0rxH1nZe
         IUaPXtYONcU3PvuXZszy/et9nCs2+3ncRwEPwK0MqBIoKE7wfxccoPgwM2oHLC2cosNE
         cUsUd/uRf4vbEVU7hEy59y67kCzzHOk6eU1ajOOOZ9mfKNTCt4EUmHJLZUpHNQXZdJNX
         /M0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747315741; x=1747920541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXeqa887aZIuoR48uoN7BEsLTRu+NlEEvV/bSAfKqmQ=;
        b=Gs2HY2jnxebYYKo11QOwCirsVciecqfydSn3cYMeizfdv4FeWDNaXHSAEvqRyj/s6L
         5C7G8/W9oH37UQVQU9zR10LLLb0qsIG3PC40bIGC0058chjntXlUiBSm5pvGImuaBU09
         Csq1mtxzR1zsjZUcygsCjxCTlCCioQaq8Y3eQY2LIIGeDHan8fZe393GvaGqcbJs3T7X
         S9pONPrxN5e9rNtjiTLhkJ6+2WUUYsj6ldRS19uiNBK4aVijOGp3ocKGLULx0P4vR5Ti
         wRegH/KibX3CQqlPXjgwDY2mcJmSGKsNaeWRbujNV3uklZyKKxd9WqbyfU/UsFtbefbz
         HNbg==
X-Forwarded-Encrypted: i=1; AJvYcCXz+e6wavXvIvtUX8T76M9NlEq5F1wHGFujQt0Xqm1taYm93+/qg/okD9EZUnolQhX5DB1HuYISaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMu3cC++Nl3S/EZo970RKgw7TJ5xmxl0CjhRjdzbbqLvnSxMJO
	bXtWGvojFO6wVDMjyAfRQSztRB4H+sj/MmUHgRQ4vpu0u9XQ23h77dmeDVOuHu4=
X-Gm-Gg: ASbGncs36G8fv6q8ym810NuYdqnmjHHtzVVYvgqCbfi3izGGTlAsEnhWhNUop+hXUCf
	5glkjXTN8BZMABc1QOLa+/8XCiadvNGgCNJNMkuKsLNObsWiGCQx4j+HWbo9B8A/IMrLAoRTKiy
	Ic/Yda0eYpe2QkRxTvP/8vEwTxFMP+ZHPXZ/F0IBlVi1ne2xDjva4r5h/9QIojY0ud/dB4eovAC
	hXOTl2t8UrbznYVeg8kU5LqTZPyrBENjPf1DsukDj3rwyuObYy9nrA/yQUZLJbnKIod/jwM0gA6
	STBiqAppqwBi2yVfuDgOYfvMQ9DCuCmLe9pZRoAObU59Tyeh69yoE23KOqgZYz4A/d9FVitD01d
	t905L/fuEgzxBgzOGQHQmdPo=
X-Google-Smtp-Source: AGHT+IEjQRVUhGojBwI+97YBtdmsQnt5mRPLvJ6XJl4UcLoxhfGfGLJJ2ddgeOKQqlG0CKXA5mxG9g==
X-Received: by 2002:a05:600c:348a:b0:43c:fa0e:4713 with SMTP id 5b1f17b1804b1-442f20bb25dmr78852185e9.2.1747315741090;
        Thu, 15 May 2025 06:29:01 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f3368d1csm73524575e9.8.2025.05.15.06.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 06:28:59 -0700 (PDT)
Message-ID: <92c2949e-2fc1-40e9-9dea-e3d9f7aa571d@linaro.org>
Date: Thu, 15 May 2025 15:28:55 +0200
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
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CANAwSgSA-JHMRD7-19wijOY=TSWD-sv6yyrT=mH+wkUJuvxFAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/15/25 13:10, Anand Moon wrote:
> Hi Daniel,
> 
> On Wed, 14 May 2025 at 16:53, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On Wed, Apr 30, 2025 at 06:02:56PM +0530, Anand Moon wrote:
>>> Hi All,
>>
>> Hi Anand,
>>
>> if the goal of the changes is to do cleanups, I recommend to rework
>> how the code is organized. Instead of having the data->soc check all
>> around the functions, write per platform functions and store them in
>> struct of_device_id data field instead of the soc version.
>>
>> Basically get rid of exynos_map_dt_data by settings the different ops
>> in a per platform structure.
>>
>> Then the initialization routine would be simpler to clean.
>>
> 
> Thanks, I had previously attempted this approach.
> The goal is to split the exynos_tmu_data structure to accommodate
> SoC-specific callbacks for initialization and configuration.
> 
> In my earlier attempt, I tried to refactor the code to achieve this.
> However, the main challenge I encountered was that the
> exynos_sensor_ops weren’t being correctly mapped for each SoC.
> 
> Some SoC have multiple sensor
> exynos4x12
>                      tmu: tmu@100c0000
> exynos5420
>                  tmu_cpu0: tmu@10060000
>                  tmu_cpu1: tmu@10064000
>                  tmu_cpu2: tmu@10068000
>                  tmu_cpu3: tmu@1006c000
>                  tmu_gpu: tmu@100a0000
>   exynos5433
>                  tmu_atlas0: tmu@10060000
>                  tmu_atlas1: tmu@10068000
>                  tmu_g3d: tmu@10070000
> exynos7
>                  tmu@10060000
> 
> It could be a design issue of the structure.or some DTS issue.
> So what I found in debugging it is not working correctly.
> 
> static const struct thermal_zone_device_ops exynos_sensor_ops = {
>          .get_temp = exynos_get_temp,
>          .set_emul_temp = exynos_tmu_set_emulation,
>          .set_trips = exynos_set_trips,
> };
> 
> The sensor callback will not return a valid pointer and soc id for the get_temp.
> 
> Here is my earlier version of local changes.
> [1] https://pastebin.com/bbEP04Zh exynos_tmu.c
> [2] https://pastebin.com/PzNz5yve Odroid U3 dmesg.log
> [3] https://pastebin.com/4Yjt2d2u    Odroid Xu4 dmesg.log
> 
> I want to re-model the structure to improve the code.
> Once Its working condition I will send this for review.
> 
> If you have some suggestions please let me know.

I suggest to do the conversion step by step beginning by 
exynos4210_tmu_clear_irqs, then by exynos_map_dt_data as the first 
cleanup iteration


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

