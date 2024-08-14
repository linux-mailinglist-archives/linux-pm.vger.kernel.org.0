Return-Path: <linux-pm+bounces-12220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060BD95219E
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 19:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289031C219E6
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 17:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFE81BD02C;
	Wed, 14 Aug 2024 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RoiFmCzi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00731B8EB4
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658245; cv=none; b=OseVsc53ncvAxPxFO9/tTMZtEBLTFPmTmZeFsgLQZ1ZHK+tizHVB1VEmmNYxy7XPtSn6g3u84VZBLEe0EUIfupyoD/85raWZvtKaPQ6cvjlQQL7lW0FGEr9L0I6BzMKRuJq7LeCRaWxCa+1i4I++zctpEJ0D0csYBN2Ox/sm+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658245; c=relaxed/simple;
	bh=qlmarjm4bNR84rbu20fJIQS2A0OemxNPwz2MhN9FDdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4r/POSIvIjvK2KWLTavgcEZHJ4o1JUt1wx/IKET/8hhyI71sayl13sacs3xL+BS2gn9TdveEkKKxzkcXnph9WyPIlUerUWVBVngibbIa3E494jSJiB9ORO2WUNy8dADABObFGZf70q3kO+QiT6OVFfKutDn9lJpjgm3A/7NR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RoiFmCzi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso570075e9.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723658241; x=1724263041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HnUwdGhfSZGHxuMeMqzleyP++rz6g7MwzjmvPDN+MAg=;
        b=RoiFmCzi1b2j0+fmnuQgGsaW4TTH0xeHiNXkAyYwfuQD16xk3K7SUvCjQN08nrT9p/
         xohtWhWsYLFW1kF8Xgz5oxkkdyMyYZsmU04ZzhHUZBlbqkqwnEG2G60p/b/DuspSNn3b
         mem1S0ExBAy98PDXF7AyjazFIfIVWpC9mtkBH+t7mmobeBD3f84XCYEdElvafURjewlm
         ab5e6fegC2IVnWdKAc3EzlNwAEPfyPaL+lvCMLuHUCs6giCF2qlm/GTnHjnZAVUb1z3X
         Py8XyH4CJ2mwbeks0iYQvLj908JGKmnPxQtgJoiJNRMMtlujdQEnbrTgjfjy+upJeB44
         chtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723658241; x=1724263041;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnUwdGhfSZGHxuMeMqzleyP++rz6g7MwzjmvPDN+MAg=;
        b=HJTHfHOgcCiwSNyMPYgUiwzhS+jGJJ+1z4C+wdrZxwyMHJZkzF1sh4B0kvHAhHwi7f
         j2dEikRkPLnpcnUx1u2oxfPUFy2mFCv375wGN+b3seQ/mfuFAqlO7OpS21YF9NAAsakp
         CL/ar/E4dl0t/oIOSGCtiyLEyqxQ8vk9V6o37UOMw27algUoGEJla4d+PiXJGwa3CTwS
         JX0/RNzDUa902/v8iAmZLaL51k9HNIG6SlzACu3elXHDdsPKTXTKu12v9uI5Q/pMoWzi
         HwKtn+NYXPOxwYypSPZdf7nCJuBpJwQM5AZ8opXONRHtX0OeyecfHt9S6pZk4s5K4mOE
         RoVA==
X-Forwarded-Encrypted: i=1; AJvYcCUIi7yEa66Zg3TPq1yf1Z9SVRP2IVP1Ym5ZsjDokeNR6id/hRbOrbKvM4THW/mDAeT2uLBpJgCeXNBywN4MQmw5TjKhbL4gdx4=
X-Gm-Message-State: AOJu0YxdHN3yXSnokPqkZqcCdtdVUPFzNWfvE5ZVTGKc5EBbez5KkjoE
	OUvvHUKi2r0xx3kUJBmAZJhzPONSn9AjBlECh8NSkyeepbvP9/7QQ+Ymy3Fa4U4=
X-Google-Smtp-Source: AGHT+IGohuyYGGk60HZbxQ/ROWUPTaq5Wi5UopTp8W5NYw+7mjHHwwWxgpEiJsSVNDzahS1qQVmMhQ==
X-Received: by 2002:a5d:4850:0:b0:369:b7e3:497c with SMTP id ffacd0b85a97d-3717775fb8fmr2431134f8f.1.1723658240825;
        Wed, 14 Aug 2024 10:57:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3717314e38bsm4654498f8f.97.2024.08.14.10.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 10:57:20 -0700 (PDT)
Message-ID: <768894bb-a12a-4919-9b4d-b579c153a556@linaro.org>
Date: Wed, 14 Aug 2024 19:57:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] memory: samsung: exynos5422-dmc: use scoped device
 node handling to simplify error paths
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Lukasz Luba
 <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-tegra@vger.kernel.org
References: <20240812-cleanup-h-of-node-put-memory-v1-0-5065a8f361d2@linaro.org>
 <20240812-cleanup-h-of-node-put-memory-v1-3-5065a8f361d2@linaro.org>
 <20240814174246.00007e4e@Huawei.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240814174246.00007e4e@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2024 18:42, Jonathan Cameron wrote:
> On Mon, 12 Aug 2024 15:33:57 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> Obtain the device node reference with scoped/cleanup.h to reduce error
>> handling and make the code a bit simpler.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Trivial comments inline
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>>  drivers/memory/samsung/exynos5422-dmc.c | 31 +++++++++++--------------------
>>  1 file changed, 11 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
>> index da7ecd921c72..d3ae4d95a3ba 100644
>> --- a/drivers/memory/samsung/exynos5422-dmc.c
>> +++ b/drivers/memory/samsung/exynos5422-dmc.c
>> @@ -4,6 +4,7 @@
>>   * Author: Lukasz Luba <l.luba@partner.samsung.com>
>>   */
>>  
>> +#include <linux/cleanup.h>
>>  #include <linux/clk.h>
>>  #include <linux/devfreq.h>
>>  #include <linux/devfreq-event.h>
>> @@ -1176,10 +1177,10 @@ static int of_get_dram_timings(struct exynos5_dmc *dmc)
>>  {
>>  	int ret = 0;
>>  	int idx;
>> -	struct device_node *np_ddr;
> 
> This would definitely benefit from a
> struct device *dev = dmc->dev;

True, I'll do it in separate patch.

> 
>>  	u32 freq_mhz, clk_period_ps;
>>  
>> -	np_ddr = of_parse_phandle(dmc->dev->of_node, "device-handle", 0);
>> +	struct device_node *np_ddr __free(device_node) = of_parse_phandle(dmc->dev->of_node,
>> +									  "device-handle", 0);
> Trivial. Maybe consider the wrap suggested in patch 1.
>> +	struct device_node *np_ddr __free(device_node) =
> 		of_parse_phandle(dmc->dev->of_node, "device-handle", 0);

Ack.



Best regards,
Krzysztof


