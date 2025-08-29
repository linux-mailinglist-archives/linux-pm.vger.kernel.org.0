Return-Path: <linux-pm+bounces-33375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C48B3B381
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 08:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0612F16BD10
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 06:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B929224A066;
	Fri, 29 Aug 2025 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTADtQ+R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51C1246BB9;
	Fri, 29 Aug 2025 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449306; cv=none; b=tAjR5OPCDEVTGjK8VRuW/XRWIVj3lMqmmu8tEwD7eT/KzVKSjnvw96im0MCcatRHTDGczq0j7rgPubDzcJtSksvjpfnWWbM1E7tkVWcQqsoA+U4ZB7Yl40cgI5cZvrUCc71qmJ5y+lzff5M5L3ngfwpK+dW1rv8sno+MgKMaOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449306; c=relaxed/simple;
	bh=fdtZWzuOmKQsqZawWqW/m9ttzMU0Pd/PfXC77PLBFPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsBbyMG61FM+EsyMZMPLUc2AeyO2oDPeUc8fNT7kvl2rRiJcK0KVHjlEnBHk6N6C+VB+Oxht2E9ABkiTfxmFtFni0Zsp+kO9HICzj3b6ZUW2tbzcT46vwuft92kXcfKM0Iznw6F5UfybLyKQLb7N4dUwfKP56WItLWXG0bkXiX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTADtQ+R; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso77745e87.0;
        Thu, 28 Aug 2025 23:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756449303; x=1757054103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CP6pmH3KP22aqopIlUvg/BFkwtIWDv/4zdv9pHulrKI=;
        b=aTADtQ+RoMphHxpnKr9tjy27AlyWZ1YSoJ/Yfc2n9Ckws29xMzUSMpTms8llWkmbGz
         pvn7QYlfTZ4XeIXFy5mt/ygF9qB/diUonUdMyE1eOrpI2b1zUZsGxbIMiIeH00EFyNwl
         b50NEbfy9tsUFthc1xoLS4Lj9s6KYTNKckMiL3Sudgl4TA1hi7MYXyaGB1V5t2vUTf+Y
         VeiuBcw3JGk0ZeR3a20lJKZcX5s/kEyEGsFVlmR399Ry5Mz7Z2+yr4hzqp7AUjgvThuQ
         U80Emq0oAQ6K3NGzArDfT6hAGY3onRMXHUYmERzczLzKJIJ/KNyEukAG6OEzKI/NKRj4
         w6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756449303; x=1757054103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CP6pmH3KP22aqopIlUvg/BFkwtIWDv/4zdv9pHulrKI=;
        b=k/qfeLbseZB+8tLOqE5gDlNvRPVQM97xd3hqXHwLLvydpsHMHf4akmOkgTcSxXcC2B
         G+KdLywcCeHv5Zu8ZBzwe93aPNWSVC1k/pQWznsFF04CZ8AzBsQTqFgr2YptoQ2wbTAi
         +wguzZWhB4LuIouL8u8vJzc63ydGIWN7/oqUpa3aN8x1Xx+zmj7QuZVcCwvIgn7arYR0
         diB581qIBrd02En01lBmHe35E40hsiT+yLRsagOFvS/MnbGDfywClqyPjSXKad8Xv5Ni
         L5PXexfnvQZmt222KyntJxjfhNyzuzPAg5tz0FRRulJm6HU70zNzf8ckO97aRIV8qGEt
         NigQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXYlB93qrXntTDMOo3S/6ArCgJErLGOvCA3SyCHwcf049PoZspSLELw5O2y1tbDhZgtDpT5Xrc9slODLI=@vger.kernel.org, AJvYcCWbEgUyBQfmRHK/uUVp0eQOOtF9HFo3vbXujqjwVHvxiTy+9AWngmbftKukW0/RyaQauPsGfdGdYpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIlHglKKvXHR5OtXaX7NninIiBHMQkDgbro0CHF1UaDAsEWhyT
	voCt7szC8TzSPXjqNgm3d0lRAAUgk+KwAvHvqckN3CK0frrQLKm95sk+
X-Gm-Gg: ASbGnctHM8HIh/JG2ma0eB+5nuK/2HMIQ10RuI8t5kqBTE6a+yisGx9dRXTIlmvmzIs
	+nFAZ3AFT/AeBeleYelNmOepdfQCkSUg54P+WLc6VQCit3CmnopPOlYRSmaZ0kbu6Z/roj0a7uB
	o8PzZKCkfzIgqLVcEX/mzgkxYrG1lUBRJM9r3ANw21Bp9TfalkR1eYu+NyoNmdlI8RPPQnC6o2e
	5oR+Fx7fhhafH5T0aPwxX93vWyvVFtgnDYwNHxR0IQGd6lYRcK+TCoch2vKnjRyIlXi5KnpNWzb
	gYHQcIZ06mOJQHzFqUx41HP7ud9Vy6SKdggtWsuBPHAI2DPUAXC4tToPcVdru6aQLO83XpLQsXm
	xFXmbM8e/eWEpQGYI9jk0iImcraGA+CXPuQYNZOfTBAi+rV8Hy+nCk7feul2R0d4aMwNcl231J4
	DhtNI=
X-Google-Smtp-Source: AGHT+IF6IwFUQ/X42JSbRT0fB74zgGgtMOwc4qXnbzVnHAmYzdOvgQ+dDQulumlbzxOo9Vj2aK0TkA==
X-Received: by 2002:a05:6512:23a7:b0:55f:53ec:fad4 with SMTP id 2adb3069b0e04-55f53ecfda7mr3292104e87.9.1756449302421;
        Thu, 28 Aug 2025 23:35:02 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f67a4569esm377497e87.143.2025.08.28.23.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 23:35:01 -0700 (PDT)
Message-ID: <6341e004-880c-4a81-811d-a8b367aab39d@gmail.com>
Date: Fri, 29 Aug 2025 09:35:00 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] power: supply: Add bd718(15/28/78) charger driver
To: Linus Walleij <linus.walleij@linaro.org>,
 Andreas Kemnade <andreas@kemnade.info>
Cc: Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20250821-bd71828-charger-v3-0-cc74ac4e0fb9@kemnade.info>
 <20250821-bd71828-charger-v3-2-cc74ac4e0fb9@kemnade.info>
 <CACRpkdbZN3LB=iVwL0YLEoUOiPMSePdOF_NEGWuCncDAjWY4XA@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CACRpkdbZN3LB=iVwL0YLEoUOiPMSePdOF_NEGWuCncDAjWY4XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi deee Ho again peeps!

I'm back home from Amsterdam, and found the datasheets :)

On 28/08/2025 10:45, Linus Walleij wrote:
> Hi Andreas / Cong,
> 
> On Thu, Aug 21, 2025 at 8:25 PM Andreas Kemnade <andreas@kemnade.info> wrote:
> 
>> Add charger driver for ROHM BD718(15/28/78) PMIC charger block.
>> It is a stripped down version of the driver here:
>> https://lore.kernel.org/lkml/dbd97c1b0d715aa35a8b4d79741e433d97c562aa.1637061794.git.matti.vaittinen@fi.rohmeurope.com/
>>
>> For the ease of review and to do a step-by-step approach remove all the
>> coloumb counter related stuff and do not sneak in BD71827 support. That
>> also avoids non-trivial rebasing of the above series.
>>
>> Changes besides that:
>> Replace the custom property by a standard one and do not use megaohms
>> for the current sense resistor.
>>
>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> I think it looks good to merge:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> It contains some interesting pointers for future work:
> 
>> +/* TODO: Verify the meaning of these interrupts */
>> +BD_ISR_BAT(rechg_det, "Recharging", true)
>> +BD_ISR_BAT(rechg_res, "Recharge ending", true)
>> +BD_ISR_DUMMY(temp_transit, "Temperature transition")
>> +BD_ISR_BAT(therm_rmv, "bd71815-therm-rmv", false)
>> +BD_ISR_BAT(therm_det, "bd71815-therm-det", true)
>> +BD_ISR_BAT(bat_dead, "bd71815-bat-dead", false)
>> +BD_ISR_BAT(bat_short_res, "bd71815-bat-short-res", true)
>> +BD_ISR_BAT(bat_short, "bd71815-bat-short-det", false)
>> +BD_ISR_BAT(bat_low_res, "bd71815-bat-low-res", true)
>> +BD_ISR_BAT(bat_low, "bd71815-bat-low-det", true)
>> +BD_ISR_BAT(bat_ov_res, "bd71815-bat-over-res", true)
> 
> Some of these look like they should immediately shut down the
> system, I suppose the battery charger does this autonomously
> but it should probably also trigger an emergency shutdown
> of Linux, right?

Yes. The shutdown for charging, or, in some cases for all power outputs, 
is automatically handled by the PMIC hardware. (Well, I am not sure 
about the 'over-current' IRQ, will see if I can find out more about it).

>> +/* What should we do here? */
>> +BD_ISR_BAT(bat_ov, "bd71815-bat-over-det", false)
> 
> At overvoltage all charging should stop, I guess the hardware
> does that autonomouslyd and this is just to inform us that
> this has happened.

Yes. That's my understanding.

>> +BD_ISR_BAT(bat_mon_res, "bd71815-bat-mon-res", true)
>> +BD_ISR_BAT(bat_mon, "bd71815-bat-mon-det", true)
>> +BD_ISR_BAT(bat_cc_mon, "bd71815-bat-cc-mon2", false)
>> +BD_ISR_BAT(bat_oc1_res, "bd71815-bat-oc1-res", true)
>> +BD_ISR_BAT(bat_oc1, "bd71815-bat-oc1-det", false)
>> +BD_ISR_BAT(bat_oc2_res, "bd71815-bat-oc2-res", true)
>> +BD_ISR_BAT(bat_oc2, "bd71815-bat-oc2-det", false)
>> +BD_ISR_BAT(bat_oc3_res, "bd71815-bat-oc3-res", true)
>> +BD_ISR_BAT(bat_oc3, "bd71815-bat-oc3-det", false)
>> +BD_ISR_BAT(temp_bat_low_res, "bd71815-temp-bat-low-res", true)
>> +BD_ISR_BAT(temp_bat_low, "bd71815-temp-bat-low-det", true)
>> +BD_ISR_BAT(temp_bat_hi_res, "bd71815-temp-bat-hi-res", true)
>> +BD_ISR_BAT(temp_bat_hi, "bd71815-temp-bat-hi-det", true)
> 
> The "oc" stuff is "open circuit" and probably different interrupts

I see I chose a confusing prefix, 'oc', sorry. In this case it doesn't 
come from "open circuit" but "over current" - and yes, I had to look it 
up from the MFD driver / data-sheet - which is a clear indication naming 
isn't as good as it could be. Anyways, it seems these over-current 
limits for the IRQ can be set by the software. I'm not sure if exceeding 
these limits causes hardware to do anything else but an IRQ though.

> to indicate that a measurement of the open circuit voltage
> is available in some register, which enables you do do more
> precise capacity estimation, right?

AFAIR, the ROHM fuel-gauge algorithm used OCV tables when battery was 
not really open, but 'relaxed', to adjust the coulomb counter based on 
the SOC estimated from the OCV. The 'relaxed' condition was met when the 
current consumption had been 'small', and battery had not been charged 
'recently'. I have a vague memory the BD71828 had some hardware support 
for knowing battery was 'relaxed', the BD71815 and BD71827 might have 
used coulomb counter 'history' for this. I can try to remember all this 
a bit better if Andreas continues to upstream also the fuel-gauging 
logic from the original RFC. But yeah, these interrupts were for over 
current.

> If it is useful depends on if the device is e.g. flashed with
> capacity tables vs OC voltage in the factory, and the charger
> then has "deep knowledge" of the battery it is handling, I guess
> this is how it works? Then this again is just informational, it
> informs you of what the device-internal charging algorithm
> is doing.
> 
> As for the temperature these are probably also just informational
> if all these states are already handled by the hardware itself.

Yes. AFAIR, the boundaries for the thermal areas can be adjusted by 
software though. [There are also the "thermal shutdown" limits when also 
the PMIC's other power outputs (not just charging) will be disabled. 
AFAIR, the TSD limit can't be configured though.] On certain temperature 
areas the charging is reduced, and the "amount of reduction" can also be 
set by the software.

State transitions are still handled by the hardware so these interrupts 
are indeed only informative.

> They all seem to be intended so that you can essentially put
> these into custom sysfs or debugfs entries and then get out
> a graphical state machine of the battery charger. That requires
> deep knowledge of how the charger works (a datasheet)
> and has limited use for a normal user.

Yours,
	-- Matti

