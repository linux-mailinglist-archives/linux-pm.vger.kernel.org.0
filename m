Return-Path: <linux-pm+bounces-8470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD98D619C
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 14:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F7A1F22636
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 12:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E571586C0;
	Fri, 31 May 2024 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fye8/JRS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB24158204;
	Fri, 31 May 2024 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158140; cv=none; b=EN08YMgUIT7yVUt2gDKRIw/Tyo/8NSu/+3bvqr8zPJH4Ky7rJp9lDIS9dLPefWf3cZk5y1YZfyJqtrukFetj5RZcsHdIyH3hnpcuXBegCgs1N8HCbx/79ew7IRF9KyAbJRfvHo9UGVXMEjJ9/OfJPgV6uOun2bPLxfWNwQR291k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158140; c=relaxed/simple;
	bh=vhO5X0I88ctG2CbABJ4wZ7Ahj4pq3KkAlEOiIK6CBOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjJ1KwvaeABDL9+vvow7SoEPAUQo1Piiv3LqtP8mXjMNu0GynbWtQBEigklxM68fvtj0hfZswNWgNxqYPUSc8pOU/cgu8Ag24CC66n6jqQIcY24dsRECZ84X2seq3HDZwgYEVN20s3hLP0pnwlnZlpdemfu3omJ1+W784T+k4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fye8/JRS; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ae38957e8so2290342e87.1;
        Fri, 31 May 2024 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717158137; x=1717762937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5kJ1sDty/eVEPO+eSrUbXkiddRniVES73Z/uRFMSYg=;
        b=fye8/JRSkHhmidjcMcGQRcJ6awGJgVibzA7yK2XgoFWBmX2XRcEBKFu073H+t4umDY
         HGTC00GXUYA63G+OnjJH72vmmBkWXxy9MoMflTrVbEZCjI92w0XNnRu3D2etBwkexQOA
         ivkA1bh46+vFP1yJ9K/MUOUhlKmbM+34NhEh2rtVgdwnjOcNfy6iJpEbQS84WiSdV9Ba
         jelttqojq4p9aJo9eKfVCOozrxerM/xlkGwGhpgB0LUOKoZB1Pf4NHbHWQ+ZFl+KW96e
         Jzw/ksvdoebOmbxw7yRBrmMJFtRxpatQ7IKKU6tK3np/9W57dCcXNS1WnHP5c1MY9Apf
         vccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717158137; x=1717762937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5kJ1sDty/eVEPO+eSrUbXkiddRniVES73Z/uRFMSYg=;
        b=sNci64kdVTMDy3PWhenHDLCfvSrc9dNsWfauKHY5lDWtWjB/WCj3nazxq5fk6Zi8El
         O3ql1H7grmncUw87dKo6Z8AYEh6cj56ca49t7kORz33G8fTn8/YzoDS5FalrLqK4XCbT
         knhdXEhOhwDcpzUx3gEC0c+TUj1GYlAXC1IGalOuPoD4600FAsVHX3UtyDNEIcIGZDBu
         E4OCgsj+rk2GtC7RpUQnSBrvfxhS6rWqCXOgAA4bZkFmNZyeHw4ddK2yVAPUQ4PZt4cT
         c9bVv7u0kaB8kGDYYwGg0w0pyN3xF1z2WRM20W8pwMQZ06E4yuHHHXv8ZQN/45wsN5RW
         LZ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWItYbzmYe0aPkX7WntZEktZZABR201cko+1F4iuAp3uop6W5CxAvlUR0Qr5ZBZEMCLkP9UzFKNl2gzNqms78S7+afINKWPi0568TfGrLjYKIpvIhJAxNd6BozfNKmbPdOTfUnYRjBbOn4vGr/58kuv5ih93myVgt9ABvyTsuLF8KoW38OzMCLnbTzCZFfdQFEGJetY7iplNtDfXs+3ap9gZFuufPk=
X-Gm-Message-State: AOJu0YwpuZyz9psWG9Ie9t+5N6i7ua8o+QPIK21XttYMRezx+GFEXsdU
	9JjLvYnDDsvkaRDgVX/qWMxu7suUZs2fGSoMdofOmGhL437rfPUTunwCwQ==
X-Google-Smtp-Source: AGHT+IEmhull5yrUySeRXrHW/tjiEC268HC6Sn/SZcvaOro5h58LwGsGzi4JuQxR02lwGxLqimyPcQ==
X-Received: by 2002:a19:8c42:0:b0:529:bca0:73c1 with SMTP id 2adb3069b0e04-52b89564335mr1157671e87.10.1717158136386;
        Fri, 31 May 2024 05:22:16 -0700 (PDT)
Received: from [192.168.50.244] (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b99445sm947745a12.18.2024.05.31.05.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 05:22:15 -0700 (PDT)
Message-ID: <e0b8a451-1bce-4cc2-8793-9372dcb558da@gmail.com>
Date: Fri, 31 May 2024 14:22:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 05/11] power: supply: max77693: Expose
 INPUT_CURRENT_LIMIT and CURRENT_MAX
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>,
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>,
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
References: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
 <20240530-max77693-charger-extcon-v1-5-dc2a9e5bdf30@gmail.com>
 <3b3beca0-80f7-4a20-93d0-01af89fcf508@kernel.org>
Content-Language: en-US
From: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <3b3beca0-80f7-4a20-93d0-01af89fcf508@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.05.2024 11:38, Krzysztof Kozlowski wrote:
> On 30/05/2024 10:55, Artur Weber wrote:
>> There are two charger current limit registers:
>>
>> - Fast charge current limit (which controls current going from the
>>    charger to the battery);
>> - CHGIN input current limit (which controls current going into the
>>    charger through the cable, and is managed by the CHARGER regulator).
>>
> 
> 
> 
>> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>> +		ret = max77693_get_input_current_limit(chg, &val->intval);
>> +		break;
>> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
>> +		ret = max77693_get_fast_charge_current(regmap, &val->intval);
>> +		break;
>>   	case POWER_SUPPLY_PROP_MODEL_NAME:
>>   		val->strval = max77693_charger_model;
>>   		break;
>> @@ -680,6 +727,11 @@ static int max77693_charger_probe(struct platform_device *pdev)
>>   	chg->dev = &pdev->dev;
>>   	chg->max77693 = max77693;
>>   
>> +	chg->regu = devm_regulator_get(chg->dev, "CHARGER");
>> +	if (IS_ERR(chg->regu))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(chg->regu),
>> +				     "failed to get charger regulator\n");\
> 
> This breaks users... and where is the binding?
Assuming "this" means "erroring out if the CHARGER regulator is not
found":

The way it works here is that the CHARGER regulator is fetched directly
from the parent max77693 device (it's defined in the regulator subnode
in DT). I suppose we could add a DT property for it, in the charger node
(like we do for the USB connector), though I don't know if anyone would
use any other regulator here than the CHARGER regulator of the max77693
regulator device. (And after all, we're using it here to modify charger
registers... maybe another point to my argument that we should be
handling all of this directly in the charger driver instead of deferring
it to a regulator.)

Best regards
Artur

[1] https://lore.kernel.org/all/20160927081344.GC4394@kozik-lap/
[2] https://lore.kernel.org/all/298d81d5-fe41-e2d1-32a7-d3dc35b0fe25@kernel.org/

