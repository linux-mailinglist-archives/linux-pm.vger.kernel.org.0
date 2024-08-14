Return-Path: <linux-pm+bounces-12222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803119521BA
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 20:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0470D1F21BF8
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B251BB699;
	Wed, 14 Aug 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y6z33loG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56FC524B4
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658478; cv=none; b=hnTz+wHudOAtNcIGoqXOWhXvPKHO0cLFouI9/UYZ78agLyhfqT71hip/ndAkARPXJcGFBf02tVLAshkXnCtXjGjSQ1OTKwnHXmK6FNzJi73cD7hmQmjRrllNoDwjcO9lMeWZRcf4LnO7zbUBJTYcw5FQqCl+CfeOV5lLGj1zb2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658478; c=relaxed/simple;
	bh=D9ysdIZnNkauYSLlh1fFwfnLMxelm3xkTf9ZAYk0HCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXDfJnZJbYO04h2OhWUmsvyfQDLuwC+JvsfNWLgpxSXWmaZ2r8DoIrpQp6Fn5MGmREHlegQ2xdWrNIUZssPA++vl/jg1QGUcEXIGlSSWu1RuJBJAQ/MXvY/2/BFa8mBu0TtXwZBjDnOgvHBZ242Ac6gyE6tSO2vvUGVYyOs9GPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y6z33loG; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f025b94e07so2178161fa.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 11:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723658475; x=1724263275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EqWT7co9LLm+zY9hTxt/0Ma/Ff/Hf5HofKmeJ3F+uhw=;
        b=Y6z33loGUjgahZXlYZFmBzkaWuX9jqrfVMgLAID2zKiGMs8DJ++nD9TBrxAzxQ1LQi
         MwLGURb/TY7UBZmxVuNN3we/qu6mPXvNKg4DOfgoRTU4SbP9SSDtLyFmIbHO2jSXL78m
         FDkyHATXJn6nOkvWn2VHsghzITtAV8AH2MmmuyF0aNl/xYM2zSR4j9CROvegE5ZlbkLK
         rZX3W8cFiRQOiYIELUjJ5t0A3P4Y+ACdZA8mSooHpWKeLmdM/ZnGfN/+7aUUQBZeyV1f
         IIuoQbODIm9/GLMl4J9uJYxS31KGXE4Mhlit0elAhXNSRh43RkPjvLmbvKvXMrD4IJ71
         ooag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723658475; x=1724263275;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqWT7co9LLm+zY9hTxt/0Ma/Ff/Hf5HofKmeJ3F+uhw=;
        b=tZzwj8pggdBPKN/QXMN3BhbPYHH/v3bp6mpMa1I8vA74run+VnYWgeMp6tcbV1lIjs
         w353EVfx0sa0lihjy6Gvlu884bUIFdL3r4/8ucHYLzpSnRIF2GjPUQ2bLo2uctBgDrdQ
         LVdxX76Ii45hGuKTZT/wAnS6PvVekxly5cwI6BLlQONWH8Wdp64I+gH1g7lfVfxKeNhU
         jFku/3r1KMphupbiol50Bz3DDQcOLOr0nSOyUxY38vWJUkraYc87SoodkxOfSwS3T0i3
         t89sQRe871WNzMV+bl5JAhl7hxzoVRPvmB4xL6ZBtf7CMerScNypiSbu71TaiVS0RTsI
         LA7g==
X-Forwarded-Encrypted: i=1; AJvYcCXp6vvV3qoXM+jhQ9Von0NwPVV04pi2hHQjl8obxK/ENtIvi1/6Ir7/mR2a5IFUYdtdRoLaWBto2LDo1p9gpYhC6RvIZfKrcSM=
X-Gm-Message-State: AOJu0YzUQ0Wy98adK9wDBAAml2PofI0NIQVHA2GtEc7GptTqRdrf6Zab
	mhy/CLfH7CJdPRm4pRNm/3qVnzJpQVDOiS67inT5xarZCAC62CUMgkqRFjt59z4=
X-Google-Smtp-Source: AGHT+IGOY+fHGA681Phv/bb+Nvm64Jh5qeSZOPlkH6pYx8qHLZa9/HUqI8ecTFDDn08I8Aj9PH7V0g==
X-Received: by 2002:a05:6512:687:b0:52c:d27b:ddcb with SMTP id 2adb3069b0e04-532eda8e7ecmr2795696e87.3.1723658474687;
        Wed, 14 Aug 2024 11:01:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded28cdasm26871565e9.16.2024.08.14.11.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 11:01:12 -0700 (PDT)
Message-ID: <03b93d98-5722-4592-9346-30a3b4f95d1f@linaro.org>
Date: Wed, 14 Aug 2024 20:01:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] memory: ti-aemif: simplify with scoped for each OF
 child loop
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
 <20240812-cleanup-h-of-node-put-memory-v1-9-5065a8f361d2@linaro.org>
 <20240814175541.00002023@Huawei.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240814175541.00002023@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2024 18:55, Jonathan Cameron wrote:
> On Mon, 12 Aug 2024 15:34:03 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> Use scoped for_each_available_child_of_node_scoped() when iterating over
>> device nodes to make code a bit simpler.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Nothing wrong with this patch, but I think you can add a precusor
> that will make this neater.
> 
> Jonathan
> 
>> ---
>>  drivers/memory/ti-aemif.c | 13 ++++---------
>>  1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
>> index e192db9e0e4b..cd2945d4ec18 100644
>> --- a/drivers/memory/ti-aemif.c
>> +++ b/drivers/memory/ti-aemif.c
>> @@ -330,7 +330,6 @@ static int aemif_probe(struct platform_device *pdev)
>>  	int ret = -ENODEV;
>>  	struct device *dev = &pdev->dev;
>>  	struct device_node *np = dev->of_node;
>> -	struct device_node *child_np;
>>  	struct aemif_device *aemif;
>>  	struct aemif_platform_data *pdata;
>>  	struct of_dev_auxdata *dev_lookup;
>> @@ -374,12 +373,10 @@ static int aemif_probe(struct platform_device *pdev)
>>  		 * functions iterate over these nodes and update the cs data
>>  		 * array.
>>  		 */
>> -		for_each_available_child_of_node(np, child_np) {
>> +		for_each_available_child_of_node_scoped(np, child_np) {
>>  			ret = of_aemif_parse_abus_config(pdev, child_np);
>> -			if (ret < 0) {
>> -				of_node_put(child_np);
>> +			if (ret < 0)
>>  				goto error;
> I'd precede this patch with use of
> devm_clk_get_enabled()
> 
> That would avoid what looks like potential mixed devm and not issues
> and let you return here.

Yep, that would be useful.

Best regards,
Krzysztof


