Return-Path: <linux-pm+bounces-8463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBFA8D6105
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 13:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F831F24560
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B1F157E7D;
	Fri, 31 May 2024 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmqCSz+r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7966D156257;
	Fri, 31 May 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717156528; cv=none; b=J+CKE9HKl8jM9eT5MCwk3nJ+c16Nnn7F/fDTwirgEOQ7mSX45i/omPMD/An8qfOForMq6QAapMVow17PXimB92RMpjfgwVF/yDSms573CxsFKZ6hWls8+kcdZWZCDnDXGq5BPHSHC2JbDS79vxj6xFlifFex4XnKAZSCELIT2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717156528; c=relaxed/simple;
	bh=CBKzv3CRd2OOutXfqI+Jz8p5xY2ZBVrp7l2FWlg5yuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t0di56wJcl5AzUTGdZLuioQq5cnUW7fx3Y7LZ9M7kMRjbcHVNZQqu3uFHRmng3E1En24eCDGIM4uFDxScuAbLDlr1YEQ6LzyzfOB+/MpvnbsiUHYaD0konmG8709pQlJtgk+IvkvNh4zTw+mSrP9KoQG7opldf9cXRYgYoVAVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmqCSz+r; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6267778b3aso168588766b.3;
        Fri, 31 May 2024 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717156525; x=1717761325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4EQS2Qufu6k4fIxkqPPPmFNyZB1HQhHIFpQwHJxd/E=;
        b=JmqCSz+rSaLUGIzYsRhSHeR0JTtikC021AzJ84mY++mAs9niq6X9v1J6kYh+tZoTQG
         ycoTj/fdYr/Rn0SjbXwqM7WgL+HRPJtX6aOYbQeXok556C2nujHn+t9RnaV6tCKEPtv5
         kxDWrLFDeysJ38OKTLWI83sqiIyw0Aj9yNCC209DROts8jQKhI8z3mKcSbWv5QQcBYKM
         +3BtJc6dS7VtxLtxit0yfQ2aNmjguSXiRYrTq6CI056yOp4Uq9K97Zwvte3UZC1dJXyw
         nacr+f0trsL10KcPSx2jL34UF0KkNfXm5r2rObq2okOGvGP9VKlYi6Q3WZI+wFG6HaP8
         QF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717156525; x=1717761325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4EQS2Qufu6k4fIxkqPPPmFNyZB1HQhHIFpQwHJxd/E=;
        b=dzd829Zf9JTqSbX97JC+83IfkiJQhpvPMhWQYtnLjl8cjNiKB53qxKJFRDHx7gCNWE
         b6fHSm8VqPfvo/R/Q4Y7i7djDsWKt3c2LdrAvqAD4PNJD2hF54UIBM8m2cA1rJYdSG20
         XwGDGuqlJICmSLewJvHcREIwUANVF4D0o5RjVIEkgL/BnRNTsczylq7XKlGZ8rR6KFBI
         SJNQhQm2ckifvDIdbrWu/Z6M2OZvNPFgCarhewBkgPM1BncZI8DEkeIdqIJLyBnuPJFk
         6hcirKJmPA5+fCslLItV+jz7dmozhsnZ5L0+XMOr/bysFHHO7DaULA7whZbG9ablEmzW
         LkDA==
X-Forwarded-Encrypted: i=1; AJvYcCWVlFldybqtqnXbrja1d0JNAeN3gQhfY8o2SGBdKDgMHLHB04ujXDSQ5UMy30uF6F/NCfEdmD2nckU3VUyL/F5oI5bVaIbvBYeMZeEaPOUmSdcW1aL/DQoqnZy6xwTZJmZh7GwBn9ve3n9RjNp/28OIiVykPxknm+9+8f+KF3SXGv31cCaXMER5OZAQNtp18O1GZDKITFxcT9ypFBAfT4h2fEoBowg=
X-Gm-Message-State: AOJu0YwcW8vpfrqyU5P4sx+F0Gj0MrD6k1lwsZxNvJx4aIxNRda6Bnx9
	YBEi4zNI3syx7doBAcbWwG6WMSdm3ahr2Qx2UcG7T7FeXVDotyfa
X-Google-Smtp-Source: AGHT+IF5s93wOrD7fv1QbKpmM06TGIoSvHaQfAxyubxSj+LQPazSFbI1YaveD5sUsyWaTvIT4JPZOA==
X-Received: by 2002:a17:906:d109:b0:a63:535b:b316 with SMTP id a640c23a62f3a-a68208f0f9cmr134945966b.44.1717156524515;
        Fri, 31 May 2024 04:55:24 -0700 (PDT)
Received: from [192.168.50.244] (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eb34449bsm77607466b.213.2024.05.31.04.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 04:55:24 -0700 (PDT)
Message-ID: <0b611c4b-23d2-4c33-a6be-c15a04e8b99a@gmail.com>
Date: Fri, 31 May 2024 13:55:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <d740ff64-2de6-424c-9fc0-f1064f8c4f8b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.05.2024 11:47, Krzysztof Kozlowski wrote:
> On 30/05/2024 10:55, Artur Weber wrote:
>> There are two charger current limit registers:
>>
>> - Fast charge current limit (which controls current going from the
>>    charger to the battery);
>> - CHGIN input current limit (which controls current going into the
>>    charger through the cable, and is managed by the CHARGER regulator).
>>
>> Add functions for setting both of the values, and set them to a
>> safe default value of 500mA at initialization.
>>
>> The default value for the fast charge current limit can be modified
>> by setting the maxim,fast-charge-current-microamp DT property; the
>> CHGIN input current limit will be set up later in the charger detection
>> mechanism.
>>
>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>> ---
>>   drivers/power/supply/max77693_charger.c | 45 +++++++++++++++++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>
>> diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
>> index 894c35b750b3..d59b1524b0a4 100644
>> --- a/drivers/power/supply/max77693_charger.c
>> +++ b/drivers/power/supply/max77693_charger.c
>> @@ -28,6 +28,7 @@ struct max77693_charger {
>>   	u32 min_system_volt;
>>   	u32 thermal_regulation_temp;
>>   	u32 batttery_overcurrent;
>> +	u32 fast_charge_current;
>>   	u32 charge_input_threshold_volt;
>>   };
>>   
>> @@ -591,6 +592,35 @@ static int max77693_set_batttery_overcurrent(struct max77693_charger *chg,
>>   			CHG_CNFG_12_B2SOVRC_MASK, data);
>>   }
>>   
>> +static int max77693_set_input_current_limit(struct max77693_charger *chg,
>> +		unsigned int uamp)
>> +{
>> +	dev_dbg(chg->dev, "CHGIN input current limit: %u\n", uamp);
> 
> That's quite useless debug. It duplicates
> max77693_set_fast_charge_current(). Just drop entire wrapper.

It doesn't duplicate max77693_set_fast_charge_current, they modify two
separate registers. Quote from the commit message:

> There are two charger current limit registers:
> 
> - Fast charge current limit (which controls current going from the
>  charger to the battery);
> - CHGIN input current limit (which controls current going into the
>   charger through the cable, and is managed by the CHARGER regulator).

max77693_set_fast_charge_current sets up the "fast charge current"
register (in CNFG_02, CHG_CNFG_02_CC). The CHARGER regulators sets the
CHGIN input current (in CNFG_09, CHG_CNFG_09_CHGIN_ILIM).

(Apparently the CHARGER regulator is supposed to handle the fast
charge current, but it does not; I wrote about this in the "CHARGER
regulator" section of the patchset description.)

>> +
>> +	return regulator_set_current_limit(chg->regu, (int)uamp, (int)uamp);
>> +}
>> +
>> +static int max77693_set_fast_charge_current(struct max77693_charger *chg,
>> +		unsigned int uamp)
>> +{
>> +	unsigned int data;
>> +
>> +	data = (uamp / 1000) * 10 / 333; /* 0.1A/3 steps */
>> +
>> +	if (data > CHG_CNFG_02_CC_MASK) {
>> +		dev_err(chg->dev, "Wrong value for fast charge current\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	data <<= CHG_CNFG_02_CC_SHIFT;
>> +
>> +	dev_dbg(chg->dev, "Fast charge current: %u (0x%x)\n", uamp, data);
>> +
>> +	return regmap_update_bits(chg->max77693->regmap,
>> +			MAX77693_CHG_REG_CHG_CNFG_02,
>> +			CHG_CNFG_02_CC_MASK, data);
> 
> I am surprised that you set current limit via regulator but actual
> charging current value here. I think both should go to regulator in such
> case.

As in, both fast charge current and input current should be set up by
the CHARGER regulator? Sure, sounds good to me.

I've noticed that on the original kernel, both of the values are
modified together too (only exception is that fast charge current would
be set to 0 when the cable was unplugged, but the input current stayed
at 500mA. This doesn't seem to affect anything, though.).

At one point I actually considered going the other way around - moving
all charger register handling into the charger driver, instead of having
it be a regulator. As far as I can tell, only some Samsung-submitted
charger drivers (max77693, max8997, max8998, max14577) use a regulator
to manage the charger current (if anything, some power supply drivers
expose an OTG/VBUS regulator, might be something for us to consider as
well...).

I see you wrote at least the max14577 and part of the max77693 driver;
out of curiosity, what's the benefit of doing it through a current
regulator (as opposed to adding set functions for the relevant
properties in the charger driver)? I've noticed the downstream driver
has a very similar pattern[1], I wonder if it's just a port of that or
if there's a more concrete reason.

Best regards
Artur

[1] https://github.com/gr8nole/android_kernel_samsung_smdk4x12/blob/lineage-14.1/drivers/regulator/max77693.c (everything related to MAX77693_CHARGER)

