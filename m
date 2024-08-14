Return-Path: <linux-pm+bounces-12219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A160D952197
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 19:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B9C1C21BBF
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 17:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CC31BD00F;
	Wed, 14 Aug 2024 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uvApKgPA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796551BCA19
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658206; cv=none; b=WQ1F/JetZeGMI73adCOTAG8G5Kt44o6i7Y64G4ZvbHHIM5rEuo6nqocYtyJe7oz5UD8cf347UHzFJFhmFEMPI/JVWOVSYyquhYSovClysIvfx1Oc8+ymjS5cbIVt8ct+rKSP0pD2oTXdhSDdn9ijKPIS6aKNEzU/ygX987Yg0Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658206; c=relaxed/simple;
	bh=d/MSdp3XR7zwtKYXz5Ikpz+56FamxFrWPxRngdr7nz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrljlR4F8/xNX+0h5sT8gdXkflPnez5Q2wv2NVmQXChuVYguyrmqRAoZwELIYRfZKeu11aC6BbahuSOMfqhuoh+bp1OMwqKY2+u6gs9JU+qXrn5fJIBTK65MRSxmHfvk+E5qU4npQiFSO53TzAvLBLuY+RtD/9QrJx+1+s6KA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uvApKgPA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so413645e9.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723658203; x=1724263003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nGAlIu8HRdwci3BUYdRQApMszL3LHUSsEB5CKbPjVuA=;
        b=uvApKgPAxgpOcUl+O0gVnWbB6fiebb7J0X88AfWbsNUgjL/hOsAlzlVzVfVsGygKiO
         q/BqLO56Tr3B3uuqQvl40xYXrL2RjA5SgGIsaAOrbj7UQFeDICxFBfzpgZCO03Dtza7n
         7w2LPFiqg1FSHB6HEwZyejuX1xhpY5aVP5LV8/pn0/iyzpgErGmJQkaGNioiLEqe0HMx
         w4b+yNhVIPEgtOgGmW7/kGBBjjSQQu2FK5UvdtDNLyxv7E9JCN/mKm9G/h4DaDe59S0h
         FHUkRbZ24hzByNw6py8myzd1qgFQcFRBP1su4CtZn5RO9K3yu3nSutOQ9mQ1cGUAvx/l
         ud9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723658203; x=1724263003;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGAlIu8HRdwci3BUYdRQApMszL3LHUSsEB5CKbPjVuA=;
        b=BpUI2UvmiAxpGXz/VCDjSEDIt8I39osoP8UesaDoEMMFQd6WHzAMMqcyuullrSyvow
         kV+31CE8YN2F7Kr8G2AP0eOqZ1sELbicOW2o1vAh5tnFZj59FeYTUKnSTnNBQR8dvINY
         4c/p6hhm4mNUnJ/WHUmxIk/1nEiU1/sGx7254ZQG/eBP5647wX8n7lIg8JeDkfBYJlK0
         69+sHJm2P7JFunU9WW5ex4jnFBm1HoY6bkdHLqnOlgKC2X95Vfwm/UyxzOu8O15/9Qb1
         IdaaDDmqGcib11qwbl2NOyWQZkjS0NZ3s/LsoHY+ELBqmSQ6BsNpD7p7X8nKYtRzkx9y
         Sj6A==
X-Forwarded-Encrypted: i=1; AJvYcCXz75Ks9YakOi/Gp1kD7FkJKDmRW0lDLv3t4g7MALwU65eRhy2utAVqbLECEqTBY/9tIvQ5t3cW+YxD9tEhWsAhPgXIavzaKXo=
X-Gm-Message-State: AOJu0Yw5omfrtjrNS8yhSBm/oKlbmbPwAqVTmmlyGdvW+kW/cP8DRVqD
	mkzGFqt14SzLsp6TOx7Ksn4lpD6r/sLB3c20p51znZM4B0nX9qgqq0OCPAmKlzc=
X-Google-Smtp-Source: AGHT+IHy7MlPKBiE3muUasS7PsbtV4vMEkDoQV8kAmuJW+tCODVoKU4QrStZeUKOymcCcAV8ND7NZw==
X-Received: by 2002:a05:600c:1f87:b0:428:1e8c:ff75 with SMTP id 5b1f17b1804b1-429dd268f26mr25564275e9.35.1723658202684;
        Wed, 14 Aug 2024 10:56:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded4de91sm27151585e9.34.2024.08.14.10.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 10:56:42 -0700 (PDT)
Message-ID: <0ad7c0a5-67d5-4a28-ba0c-76e7b96d1a81@linaro.org>
Date: Wed, 14 Aug 2024 19:56:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] memory: atmel-ebi: use scoped device node handling to
 simplify error paths
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
 <20240812-cleanup-h-of-node-put-memory-v1-1-5065a8f361d2@linaro.org>
 <20240814173834.000002c8@Huawei.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240814173834.000002c8@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2024 18:38, Jonathan Cameron wrote:
> On Mon, 12 Aug 2024 15:33:55 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> Obtain the device node reference with scoped/cleanup.h to reduce error
>> handling and make the code a bit simpler.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Hi,
> 
> Comments inline.
>> ---
>>  drivers/memory/atmel-ebi.c | 29 ++++++++++-------------------
>>  1 file changed, 10 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
>> index e8bb5f37f5cb..fcbfc2655d8d 100644
>> --- a/drivers/memory/atmel-ebi.c
>> +++ b/drivers/memory/atmel-ebi.c
>> @@ -6,6 +6,7 @@
>>   * Copyright (C) 2013 Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>   */
>>  
>> +#include <linux/cleanup.h>
>>  #include <linux/clk.h>
>>  #include <linux/io.h>
>>  #include <linux/mfd/syscon.h>
>> @@ -517,7 +518,7 @@ static int atmel_ebi_dev_disable(struct atmel_ebi *ebi, struct device_node *np)
>>  static int atmel_ebi_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>> -	struct device_node *child, *np = dev->of_node, *smc_np;
>> +	struct device_node *child, *np = dev->of_node;
>>  	struct atmel_ebi *ebi;
>>  	int ret, reg_cells;
>>  	struct clk *clk;
>> @@ -541,30 +542,24 @@ static int atmel_ebi_probe(struct platform_device *pdev)
>>  
>>  	ebi->clk = clk;
>>  
>> -	smc_np = of_parse_phandle(dev->of_node, "atmel,smc", 0);
>> +	struct device_node *smc_np __free(device_node) = of_parse_phandle(dev->of_node,
>> +									  "atmel,smc", 0);
> Trivial:
> I'd line break this as
>> +	struct device_node *smc_np __free(device_node) =
> 		of_parse_phandle(dev->of_node, "atmel,smc", 0);

Yeah, I have troubles with this constructor+destructor syntaxes. They
are way past 80 and 100 column, so maybe indeed should be wrapped at '='.

> 
>>  
>>  	ebi->smc.regmap = syscon_node_to_regmap(smc_np);
>> -	if (IS_ERR(ebi->smc.regmap)) {
>> -		ret = PTR_ERR(ebi->smc.regmap);
>> -		goto put_node;
>> -	}
>> +	if (IS_ERR(ebi->smc.regmap))
>> +		return PTR_ERR(ebi->smc.regmap);
>>  
>>  	ebi->smc.layout = atmel_hsmc_get_reg_layout(smc_np);
>> -	if (IS_ERR(ebi->smc.layout)) {
>> -		ret = PTR_ERR(ebi->smc.layout);
>> -		goto put_node;
>> -	}
>> +	if (IS_ERR(ebi->smc.layout))
>> +		return PTR_ERR(ebi->smc.layout);
>>  
>>  	ebi->smc.clk = of_clk_get(smc_np, 0);
>>  	if (IS_ERR(ebi->smc.clk)) {
>> -		if (PTR_ERR(ebi->smc.clk) != -ENOENT) {
>> -			ret = PTR_ERR(ebi->smc.clk);
>> -			goto put_node;
>> -		}
>> +		if (PTR_ERR(ebi->smc.clk) != -ENOENT)
>> +			return PTR_ERR(ebi->smc.clk);
>>  
>>  		ebi->smc.clk = NULL;
>>  	}
>> -	of_node_put(smc_np);
> 
> The large change in scope is a bit inelegant as it now hangs on to
> the smc_np much longer than before.
> 
> Maybe it's worth pulling out the modified code as a 
> atem_eb_probe_smc(struct device_node *smc_np, struct atmel_ebi_smc *smc )
> 
> or something like with a struct_group to define the atmel_ebi_smc
> 
> That would keep the tight scope for the data and generally simplify it
> a bit.


Are you speaking about any particular code optimization/performance
concerns or readability? Because scope in the latter, I believe, is not
the problem here. The entire point of __free() is that you do not care
about scope of variable or destructor. You know it will be freed, sooner
or later. If it happens later - no problem, anyway we don't have to
"think" about this variable or cleaning up because of __free().

Best regards,
Krzysztof


