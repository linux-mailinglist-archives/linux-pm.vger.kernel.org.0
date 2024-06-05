Return-Path: <linux-pm+bounces-8652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471F28FD106
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 16:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E69286D51
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86623224EA;
	Wed,  5 Jun 2024 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXnApwH1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A419D8AB;
	Wed,  5 Jun 2024 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598634; cv=none; b=hf67X1zeQQMVzmCCxau6yQ6oFoqZMOtDYyojgv7fZud3+2JF6Jfy2XmLHRt/xj18B7ayuvM+ALCiccw+YLWzFCydPKfq7dJYttAGXP0/kEOhUk9GfOwqGhP1fgvAUHp9Fxndg/aKb5CatHLUP7EtHKGQ+yqSaCqeyboDJ/kVYRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598634; c=relaxed/simple;
	bh=Sb/jG58L9OQoNfoAxJYNWr5/aZrpNieBK/yrnVB4x4c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ECBTDTLoB+SXtVNOOKXgCRjahwIynPYlnB6IQkmuwGrVHR7glba2e0kwXxe15mQ8rfWb1zKm2oP73FXkInWuZWbjcG36hUEZBZe2ZI05P2SJSFF0MkB3NhSaWQSZJTFKQTYtcHX/TgQMn+0+QrfeRHgzu6q9E2GAL1Unhtcodsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXnApwH1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a692130eb19so342413866b.2;
        Wed, 05 Jun 2024 07:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717598631; x=1718203431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qByNMwxXX4ivi26JfgBsfFLgqmTESa4XXOPqaCiIKWY=;
        b=hXnApwH1E5aYU73u4t9CqeNi8PCHEdRq6FRKUl6nbSr5l78ES2bRK8xW0NLzJv8bKf
         a9AcArjC7c+15KCHqdwYXlMcy7qWST8MjnlwekfbxNGvKgHV5ufweYAr4levlE7bBimO
         26bz4ZaTme+wGAIZqLbJccSqCQm3mwvZ2hCK2rYnrI75Ss79V0lv7BY4UX5AZZDuXNfl
         tk8AgF96zO43S8H9c++8PwiVLXCVY52YwPhb3KiqyeKjQmLfgMyTR6pLPQNxAXEc1ip3
         fc16nY8fMArCqdjcSasujmzZsHJDrEfEFWYSN/MrO9jIt9qzD07XRwUHr8OXDuF+tfQu
         wvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717598631; x=1718203431;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qByNMwxXX4ivi26JfgBsfFLgqmTESa4XXOPqaCiIKWY=;
        b=V14Yqx6UxnvC09j4CCCfo+DjI7N+0m1P1Ey6/8qeiU6dF0SgvqFNFRml0J1PG8briC
         UUytGA51Qortij1BDwvND8IsvZ2Px1GNqttzJNQC0scZGZjp7/QUD6TA1CwMXMERFx18
         +X4a/OTiUs2dMtAp0PAmgo+OqafK2zmw85PDHvgNNe8oHghG88Ah2WhkUq4wc0h5zONt
         vS43lkxGQsErGM74b7lpcAMW2/tH+vRYvlXS2SVYQ76AhMh+br24e8kltGbPB6DSo+4l
         d5Hjby949jnGhGIbAFgwztE4CAtux//xP74/oniAkShmlQXi+fLRQqxp1VBbSuDI3Mow
         nFYA==
X-Forwarded-Encrypted: i=1; AJvYcCVxNuUMDnaMh8p2yUGsaA8VsLv76GXNW9k9bBP+ceYVn4wQ5VlNHXeZ5wJCIgjo8miln6JeHIzSReP8f5aqZfOELo9lhKICQQk4hgSjnn6IIhRNNvZ5e2n54SkkbO7oM8lpxA1BWDIpm0gFyUfD53b7mtVbxPDASb4ZQcJSGi6L2BhgpsRv0NusTO4IRrp70QfHE1wEP35yvhAfSio+fkE+TqgFSnw=
X-Gm-Message-State: AOJu0YwVC1LS3ROT0vWkrVEPy4W5i1dECN4Qn8NdFf26YstivhK6/+UI
	jMVsRKUYJmJySrgHWlxVtXfY9jTixEM7hd4agWk7+Ma0ZkjYIdNnqLmLuw==
X-Google-Smtp-Source: AGHT+IFagiMMgOracxl4APCyCa7Db8mxloo+5oQtHl11gJk6HqZyhy9pD4aiwLNxg/ZH+8cCM+248g==
X-Received: by 2002:a17:907:2918:b0:a68:733b:d419 with SMTP id a640c23a62f3a-a699faa9909mr153408666b.7.1717598630698;
        Wed, 05 Jun 2024 07:43:50 -0700 (PDT)
Received: from [192.168.50.244] (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68e6b5cdf8sm564187666b.81.2024.06.05.07.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 07:43:50 -0700 (PDT)
Message-ID: <9f88a533-cb99-4fa4-836d-9a8bd68992a2@gmail.com>
Date: Wed, 5 Jun 2024 16:43:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH RFC 06/11] power: supply: max77693: Set charge current
 limits during init
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
 <20240530-max77693-charger-extcon-v1-6-dc2a9e5bdf30@gmail.com>
 <d740ff64-2de6-424c-9fc0-f1064f8c4f8b@kernel.org>
 <0b611c4b-23d2-4c33-a6be-c15a04e8b99a@gmail.com>
 <311c13e0-2f14-4134-afb5-128bc82111e7@kernel.org>
Content-Language: en-US
In-Reply-To: <311c13e0-2f14-4134-afb5-128bc82111e7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.05.2024 14:18, Krzysztof Kozlowski wrote:
> On 31/05/2024 13:55, Artur Weber wrote:
>> On 31.05.2024 11:47, Krzysztof Kozlowski wrote:
>>> On 30/05/2024 10:55, Artur Weber wrote:
>>>> There are two charger current limit registers:
>>>>
>>>> - Fast charge current limit (which controls current going from the
>>>>     charger to the battery);
>>>> - CHGIN input current limit (which controls current going into the
>>>>     charger through the cable, and is managed by the CHARGER regulator).
>>>>
>>>> Add functions for setting both of the values, and set them to a
>>>> safe default value of 500mA at initialization.
>>>>
>>>> The default value for the fast charge current limit can be modified
>>>> by setting the maxim,fast-charge-current-microamp DT property; the
>>>> CHGIN input current limit will be set up later in the charger detection
>>>> mechanism.
>>>>
>>>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>>>> ---
>>>>    drivers/power/supply/max77693_charger.c | 45 +++++++++++++++++++++++++++++++++
>>>>    1 file changed, 45 insertions(+)
>>>>
>>>> diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
>>>> index 894c35b750b3..d59b1524b0a4 100644
>>>> --- a/drivers/power/supply/max77693_charger.c
>>>> +++ b/drivers/power/supply/max77693_charger.c
>>>> @@ -28,6 +28,7 @@ struct max77693_charger {
>>>>    	u32 min_system_volt;
>>>>    	u32 thermal_regulation_temp;
>>>>    	u32 batttery_overcurrent;
>>>> +	u32 fast_charge_current;
>>>>    	u32 charge_input_threshold_volt;
>>>>    };
>>>>    
>>>> @@ -591,6 +592,35 @@ static int max77693_set_batttery_overcurrent(struct max77693_charger *chg,
>>>>    			CHG_CNFG_12_B2SOVRC_MASK, data);
>>>>    }
>>>>    
>>>> +static int max77693_set_input_current_limit(struct max77693_charger *chg,
>>>> +		unsigned int uamp)
>>>> +{
>>>> +	dev_dbg(chg->dev, "CHGIN input current limit: %u\n", uamp);
>>>
>>> That's quite useless debug. It duplicates
>>> max77693_set_fast_charge_current(). Just drop entire wrapper.
>>
>> It doesn't duplicate max77693_set_fast_charge_current, they modify two
>> separate registers. Quote from the commit message:
> 
> But it is the same uamp value. Debug messages should not be per register
> write, because we are not debugging here registers...
> 
>>
>>> There are two charger current limit registers:
>>>
>>> - Fast charge current limit (which controls current going from the
>>>   charger to the battery);
>>> - CHGIN input current limit (which controls current going into the
>>>    charger through the cable, and is managed by the CHARGER regulator).
>>
>> max77693_set_fast_charge_current sets up the "fast charge current"
>> register (in CNFG_02, CHG_CNFG_02_CC). The CHARGER regulators sets the
>> CHGIN input current (in CNFG_09, CHG_CNFG_09_CHGIN_ILIM).
>>
>> (Apparently the CHARGER regulator is supposed to handle the fast
>> charge current, but it does not; I wrote about this in the "CHARGER
>> regulator" section of the patchset description.)
>>
>>>> +
>>>> +	return regulator_set_current_limit(chg->regu, (int)uamp, (int)uamp);
>>>> +}
>>>> +
>>>> +static int max77693_set_fast_charge_current(struct max77693_charger *chg,
>>>> +		unsigned int uamp)
>>>> +{
>>>> +	unsigned int data;
>>>> +
>>>> +	data = (uamp / 1000) * 10 / 333; /* 0.1A/3 steps */
>>>> +
>>>> +	if (data > CHG_CNFG_02_CC_MASK) {
>>>> +		dev_err(chg->dev, "Wrong value for fast charge current\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	data <<= CHG_CNFG_02_CC_SHIFT;
>>>> +
>>>> +	dev_dbg(chg->dev, "Fast charge current: %u (0x%x)\n", uamp, data);
>>>> +
>>>> +	return regmap_update_bits(chg->max77693->regmap,
>>>> +			MAX77693_CHG_REG_CHG_CNFG_02,
>>>> +			CHG_CNFG_02_CC_MASK, data);
>>>
>>> I am surprised that you set current limit via regulator but actual
>>> charging current value here. I think both should go to regulator in such
>>> case.
>>
>> As in, both fast charge current and input current should be set up by
>> the CHARGER regulator? Sure, sounds good to me.

Now that I look at it, there's one small problem with moving this to the 
CHARGER regulator - the CHGIN input limit and the fast charge current 
limit have different ranges for values; CHGIN input limit accepts values 
from 60mA to 2.58A, whereas fast charge current accepts values from 0mA 
to ~2.1A. (This also means the limits I described for the fast charge 
current property in [PATCH 2/11] are wrong...)

Should we limit the CHARGER regulator to 2.1A (would require fixing 
every DTS that defines the limits... though maybe they should be 
hardcoded in the driver anyways?), or leave the limit as-is and cap the 
fast charge current if the CHARGER current limit is set above 2.1A, or 
something else entirely?

Best regards
Artur

