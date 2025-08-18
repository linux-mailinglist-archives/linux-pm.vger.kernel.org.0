Return-Path: <linux-pm+bounces-32516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EABDCB29DF4
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7FA7A6437
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 09:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED737286D50;
	Mon, 18 Aug 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF/LwvyZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CBC3176E8;
	Mon, 18 Aug 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509569; cv=none; b=DssYVVPOzY9IxubE0l2Zd69EXKCbkx0sjK0XRkA4uzEU6zvfW+6sZNcwXbdGV9ZBmh72H/7NnDyTe8hYpN6+0mWqLmabdVNH5hEterKUkcMEkYP8SAdHoq0geT1w+/H0a6VGl7c0Tzvkpa8bsP2E/RqpTK6wV9OdZxmZ6Ejj1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509569; c=relaxed/simple;
	bh=W0DgWqmDCqSETdSrXD0Kf8DDncOUX9lCuW22CQm3Tmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlhgqdRf3GFb/FMlX4auighMe9MtW+bFZHeNoFjXDXYwR6nzi2LxdNCUhf5tKH36FQ9acXhjE/+SXBzRQ5ZZjF3/8UFS91yXrrCYc7VEbiIgyJVo/WmsgUWqkBgVsijm5SUjhDdfIyV22cbdhD8Y0t0IDsth/ObAcPK3YkIoFUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF/LwvyZ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55ce528022eso4249999e87.3;
        Mon, 18 Aug 2025 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755509565; x=1756114365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fx05yrHUYBsYGAdTpBEjSjXwj06iGFTHWr4t3qrVKvk=;
        b=aF/LwvyZbjb0Avt/xbe2q3MFLu2ir3uhSbbd0cM6XwcCdwvuEc+X3s02ONtogmnY7J
         3m4nSrilngOES3SVWlrEsgg0RVhW6ExNemBMc7PZQwwas8U6U6VsgsOPooakBuH68Euc
         c8fF0PzWWOZrgzEqncxhalyHKdaYGPuw8CTxx/tvA6lKUtsElnKI5GcKwJzQUE/d8Q2L
         7rMvFNN6ij+Sc0Pu2TjDqj6jSl8Hk7fvDR6Fy+NtptVsXN2FJ8NnqmMoIgEp500w0LTH
         ZCB3R2VYXjMj9W1vU+Lp1lJVQocE+VSTbH9N4h78nsmreNV0fghl5kU/HYJbbIdflz/K
         rOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509565; x=1756114365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fx05yrHUYBsYGAdTpBEjSjXwj06iGFTHWr4t3qrVKvk=;
        b=wN9qvu3rXYkyhCOWjEQBP3PBCGAiqdPCMBkIbRDvjYQspDDLmT4lVle7REivgoXGej
         oySGEXoHcZVXIWxubAtOP0/l2oz2jfpmDHT2BDrUUs166Sx8kSN1T8uBh4B99iuJtK1D
         HpbG0xQH4Ei75pTElqxIi3eqka5KYRB8T6HxEN5bdH6yTLu9jKzLwDrn4eQXS/uENzpk
         gREJOBvKbNQOG6e20KzuB2G9nY2gRWt6QqXrBRUO7H1fsFUmSrdhn7tTmmbny81897/W
         bdQ4FblBakSQz/NvyfDKJSPZwn+IklzRRPbDD2ahGneNsbuTuic42Rd42knfWPQiywYd
         1Jpw==
X-Forwarded-Encrypted: i=1; AJvYcCU0janJ00f2q2yc170VrwuV3uF3LHZZQYYe0wj48Qoz4N7GcHwBqkjAXDvO5xvviW5OKRJs3/4hmnGDsbY=@vger.kernel.org, AJvYcCVImRQJuAls3Fkw6LYVeCptE+r63VHM3zBhXQf3jg74Yw21IV8pik8LphA1HpcveQ/C58wAjlWXSKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEGlxEygSXwHBsp/NOAPWn3ANu9pwKLBLCvEjZAGa/7QKjxTUn
	fI91B6LMe/v58UBk3ifpWItRmN2m2p5kYh9ajWPQx2FuW3z8ngErjpFmzxc4CQ==
X-Gm-Gg: ASbGncvYobIRuhWpnnwDVHuyNe3vX+rFvlmJ6db9i/vZb9gkbiJAEDcOKUWOkIfDk1C
	/7E3ujDMUCWVTVrLFlsBtyZbEJmeMqnyYOcAn8BjrqbW3Q7rh1rDcGEJh7lVifHB2pmWkQxAUVl
	lc0bpd+/zavN21qaCvec3w9jmjx1CB6YCviTA+Z7Mnugz+e4grNsMymlcmasHybjCdYM7R0Jrlu
	OK/wB4e5LDscMtm7sSCvpotCUTnwGuczSBLVJx8CPEXQA1pNxQSNTLcTiolhlo45P70FuOFhOut
	PEUw2vqPOvTU+jdh8mCg+rU8fwMsfOjAAHnUjCe5tUslpQ4+RjY1Ygs6/Rv1FxThVyn8Sx0e9a8
	+yXtGjWTe1IH+BgLs4FBnr9lOguiyVIu39esNyH8Vz54ODLxIqqIFSHqD6pgMwq/Xu/DCO0Hk49
	vB1pFLteGSAucX6g==
X-Google-Smtp-Source: AGHT+IECcL58I4bTIB588XmvSxwLGTOMxMZWyECDrR+MGlTTCgzVx9ojgO60sBu37Sf7X4Xfdil/rQ==
X-Received: by 2002:a05:6512:3f14:b0:55b:8bd4:acab with SMTP id 2adb3069b0e04-55ceeba34f6mr2790479e87.38.1755509564470;
        Mon, 18 Aug 2025 02:32:44 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55df8db740esm251060e87.165.2025.08.18.02.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 02:32:43 -0700 (PDT)
Message-ID: <3dd9aa2d-a318-4a94-b53f-11dac139ccb2@gmail.com>
Date: Mon, 18 Aug 2025 12:32:43 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] power: supply: Add bd718(15/28/78) charger driver
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
 <20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>
 <bf82cd81-bcc7-4929-aa84-b749533d5b95@kernel.org>
 <20250817101121.19a86716@akair>
 <bbd17f22-8834-42d8-a109-971bdd2e0fa1@kernel.org>
 <e8955365-73c0-4c7a-a579-0ee6940340b2@gmail.com>
 <20250818103600.0c3a015d@akair>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250818103600.0c3a015d@akair>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2025 11:36, Andreas Kemnade wrote:
> Hi Matti,
> 
> Am Mon, 18 Aug 2025 09:34:02 +0300
> schrieb Matti Vaittinen <mazziesaccount@gmail.com>:
> 
>> On 17/08/2025 11:13, Krzysztof Kozlowski wrote:
>>> On 17/08/2025 10:11, Andreas Kemnade wrote:
>>>> Am Sun, 17 Aug 2025 07:58:35 +0200
>>>> schrieb Krzysztof Kozlowski <krzk@kernel.org>:
>>>>   
>>>>> On 16/08/2025 21:19, Andreas Kemnade wrote:
>>>>>> Add charger driver for ROHM BD718(15/28/78) PMIC charger block.
>>>>>> It is a stripped down version of the driver here:
>>>>>> https://lore.kernel.org/lkml/dbd97c1b0d715aa35a8b4d79741e433d97c562aa.1637061794.git.matti.vaittinen@fi.rohmeurope.com/
>>>>>
>>>>> Why are you duplicating the driver? Why original cannot be used?
>>>>>
>>>>>   
>>>> I am not duplicating the driver. That patch series never went in. I am
>>>> stripping it down to let things go in step by step. I have also talked
>>>> with Sebastian about this. And he also prefers a step by step approach
>>>> to have it more easily reviewed.
>>>> I also do not have the infrastructure to test things like capacity
>>>> degradation over time. There is non-trivial rebasing work involved, so
>>>> I even do not feel confident submitting such at all.
>>>
>>>
>>> OK, but if you refer to other work, then also please explain why this is
>>> stripped down.
>>
>> First of all, thanks a ton Andreas for continuing this work which I
>> never managed to finish!
>>
>> Battery fuel-gauging with coulomb-counter is hard. I believe we can get
>> some results with the original RFC code - but it requires quite a bit of
>> effort. AFAIR, there are (at least) 4 "pain-points".
>>
> Newest rebase I have is for 6.15. Yes, capacity calculation is hard.
> Even the ugly-patched Kobo vendor driver has some surprises. It once
> says battery is empty, then I put in charger, rebooted into debian,
> Vbat = 4.1V even with charger detached.

:/

> I think the fuel-gauging stuff itself should go in a step by step
> approach.

I agree.

> I am wondering how sophisticated other drivers and hardware
> are.

I have no deep knowledge on this (either). I remember having some 
(email) discussions with Linus W about Samsung's chargers / batteries... 
My understanding is that there are very different levels of 
"sophistication", both in HW and in SW. I really find this fascinating. 
Unfortunately, there has also been infamous exploding batteries and 
other less pleasant events. Hence this is also slightly dangerous area.

> The rn5t618/rc5t619 mainline driver just uses raw coloumb counter
> values and there is no compensation for anything. Some hardware does
> more sophisticated things itself.

Yes.

>> 1. Lack of persistent storage for charging cycles. For proper
>> fuel-gauging, we would need information about battery aging. The PMIC
>> has nothing to store the charging cycle counter when power is cut.
>> That'd require some user-space solution which could store the cycle
>> information in a persistent storage && tell it to the driver at
>> start-up. I don't know if there is open-source userspace solution for this.
>>
> I do not think so, and you will have trouble if you have dual-boot or
> from some alternative boot media involved.

I didn't even think about it. So, even with persistent PMIC areas, if 
software is doing the charging count book-keeping, it won't be great for 
a generic design. (May work Ok with an embedded device which is likely 
to not get booted with other flavours of software).

> The BQ27000 stuff has afaik
> hw calculation of battery capacity to deal with this.
> 
>> 2. Battery parameters. This is the real problem. In order to make the
>> fuel-gauging work, the driver needs proper battery information. I wrote
>> the original driver to be able to retrieve the data from a
>> static-battery DT node - but I have a feeling the device-vendor using
>> this PMIC provided battery-info via module parameters. I am not sure if
>> those parameters can be recovered - and as Andreas said, defining them
>> is not easy task. By minimum we would need the OCV-tables and some aging
>> + temperature degradation effects (or VDR-tables which ROHM uses for
>> it's zero-correction algorithm - but AFAIR, defining those VDR tables is
>> not widely known information).
>>
> Kobo kernels have these tables as part of the driver, the right one is
> selected via an index in the NTX_HWCONFIG blob provided by the
> bootloader to the kernel. So that is not necessarily a problem. It
> could be translated into dt.
> 
> static int ocv_table_28_PR284983N[23] = {
>          //4200000, 4162288, 4110762, 4066502, 4025265, 3988454, 3955695, 3926323, 3900244, 3876035, 3834038, 3809386, 3794093, 3782718, 3774483, 3768044, 3748158, 3728750, 3704388, 3675577, 3650676, 3463852, 2768530
>          4200000, 4166349, 4114949, 4072016, 4031575, 3995353, 3963956, 3935650, 3910161, 3883395, 3845310, 3817535, 3801354, 3789708, 3781393, 3774994, 3765230, 3749035, 3726707, 3699147, 3671953, 3607301, 3148394
> };
> 
> static int vdr_table_h_28_PR284983N[23] = {
>          //100, 100, 101, 101, 102, 102, 103, 103, 104, 104, 105, 106, 106, 107, 107, 108, 108, 109, 110, 112, 124, 157, 786
>          100, 100, 101, 102, 102, 105, 106, 107, 112, 108, 108, 105, 105, 108, 110, 110, 110, 111, 112, 114, 120, 131, 620
> };
> 
> static int vdr_table_m_28_PR284983N[23] = {
>          //100, 100, 101, 101, 102, 102, 103, 103, 104, 104, 105, 102, 100, 100, 102, 103, 103, 105, 108, 112, 124, 157, 586
>          100, 100, 103, 106, 110, 114, 115, 119, 122, 122, 115, 113, 112, 114, 117, 124, 126, 123, 122, 126, 140, 156, 558
> };
> 
> static int vdr_table_l_28_PR284983N[23] = {
>          //100, 100, 103, 105, 110, 110, 113, 112, 112, 112, 105, 110, 110, 111, 122, 131, 138, 143, 150, 166, 242, 354, 357
>          100, 100, 105, 110, 114, 117, 121, 125, 126, 122, 116, 114, 115, 118, 124, 132, 140, 148, 156, 170, 210, 355, 579
> };
> 
> static int vdr_table_vl_28_PR284983N[23] = {
>          //100, 100, 103, 106, 108, 111, 114, 117, 118, 115, 108, 106, 108, 113, 115, 114, 118, 125, 144, 159, 204, 361, 874
>          100, 100, 109, 115, 118, 123, 127, 130, 140, 139, 134, 130, 128, 138, 140, 150, 154, 164, 178, 204, 271, 362, 352
> };

Oh, good. If we can get the right battery parameters from the vendor 
driver, then the main problem gets solved. Although, multiple sets of 
different VDR tables probably means, that there are variants with 
different types of battery out there. I assume the bootloader can 
somehow detect the battery type to provide the correct blob?

> 
>> 3. ADC offset. The coulomb-counter operates by measuring and integrating
>> voltage-drop over known Rsense resistor. If (when) the ADC has some
>> measurement offset, it will produce a systematic error which accumulates
>> over time. Hence a calibration is required. The BD718[15/28] have an ADC
>> calibration routine, but AFAIR, there was some limitations. I don't
>> remember all the dirty details, but it probably didn't work too well if
>> current consumption was varying during the calibration(?). I think
>> running the calibration is not supported by the driver.
>>
> Yes, that is a pain.

I am pretty sure I can dig the registers which initiate the ADC 
calibration, but I don't have real devices with real battery to test it. 
I can try to find that information if if you wish to experiment with it 
though...

...The BD718xx had a magic "test register area" - where this calibration 
stuff (amongst other, very hazardous things) resides. Problem is that 
this "test register area" is implemented in a way, that it is behind 
another I2C slave address, which can be enabled by a magic write 
sequence. Enabling it from a generically usable driver can't really be 
done. It would be hazardous if there was another device in the I2C with 
the same slave address as the "test register area".

> [...]
>> TLDR; It'd be hard to do accurate fuel-gauging without proper
> battery
>> information and some extra work. We could probably get some rough
>> estimates about the capacity - but implementing it only makes sense if
>> there is someone really using it. Charger control on the other hand
>> makes some sense. [It at least allows Andreas to charge his eReader
>> using solar-power when on a biking hiking! How cool is that? ;)]
>>
> And using a hub dynamo.
> For now I have a user space script to help me, probably moving that into
> input_current_limit.

Sounds good to me.

> But it is really nice to see if things are charging or are discharging
> unusually fast.
> It is a pity that such power sources are not taken into consideration
> in standards or charges much. Around 20 year ago or something, I could
> just attach a Thinkpad to a solar panel, there was a smooth transition
> between discharging a litte (displaying battery discharging time in
> weeks) and more ore less charging. Today often the recommendation is to
> put somehow another battery in between. But that is technically
> somehow nonsense. You need a buffer for power and another one in the
> row.

Yours,
	-- Matti

