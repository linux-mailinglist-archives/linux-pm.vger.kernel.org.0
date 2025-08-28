Return-Path: <linux-pm+bounces-33258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6D4B39DFF
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 15:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FDC189BF98
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A791B3101CD;
	Thu, 28 Aug 2025 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TceNxg98"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20630FC3C;
	Thu, 28 Aug 2025 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386112; cv=none; b=D/pLBn8QowbJPwKRv8/OhlNo/WlHjz7FzbOcNmh9Y7p2gE91MoDPSGZ7n0p18ObWUzfsx7JxUc1s5CZZvi8bsJF/SbsV8THRipA32/3wVR7JzIQ9aBMbi4bFPfYWtuN5ALgE8xIO+GQuzACahkISnVGd8+rjculgj6IJlUYmGlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386112; c=relaxed/simple;
	bh=9jvhaqpBDSx9Hd6J2Se0Q3oDBy5ViMkKwW51Stqb4XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cq6kWLe1Q2HvKpqaUAuCaJOVvwY+YcYZVxBDZI+mEbabNBYpSwodqWZ6zQOHfFkE/N51qHEpQlfuHitr6ZqPu3jgNBaKAGTNGqUFRteeEEL9xpWGTJoks964zW17PjyaM8W9DKarB573pIFYdDlZ8f66r40WiKMW5F/f5BIpRFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TceNxg98; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f4345cfd3so949843e87.1;
        Thu, 28 Aug 2025 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756386108; x=1756990908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bP8ECEjdehwcK86EPMIprw2k8XC/hjPKh1I7N6U1cdc=;
        b=TceNxg98fdQTsvjAvGnTxUpgi2PQo27nYPc3hQUzJtxCoi4lMLf1kPgCbH48r5Zd0J
         j+sg1Q1OxjBdecE2Y2Pl7C5Cdnyit5MSRiWzOepSSYZLJocduGjHzHEPn+hJkClgq4h7
         if+M5Jzny4lfjfF7XYwbUxP6mRqRVmZDjguVI7baKiyMyx7nVisiuckYWkSba9mqv++6
         jI3z7JDrRBRUIW7K92YaR/JcEOIVSUC8IySKJrKJcyu1KzdEFfEKmlDvFDkgP5UDsBgI
         XAtbENcSsZeuhFQwMuzLSxvP+EvQCgJMj1SKK75rbOV4g8dGJcWKwmZj6xwR3c8/Pz7Z
         XBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386108; x=1756990908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bP8ECEjdehwcK86EPMIprw2k8XC/hjPKh1I7N6U1cdc=;
        b=HIUji8bN88ONxRuI3KK5rF7AkFNm+e/PN75uEZMWTzrqbndFPtrfmg1EdbgoCMQOeP
         1Qg8f1MoCVVMEeMeJiWBcve+dlLbrLMb14WgUY4lzOlx2WOm49fKD4zfhtwX4SV6Resl
         ZKYepXOnzU0+2VAbVt3EgbC+3Y/lFIk4suE/M+Y5cvWlh9Z6BE7Hc1Hi/VD8Nl+XNt6U
         aPRLP5pOqbwdjtKo2im+Yqrjo9YkWB/sllLKgH0qmlmjbgrRk/uuqSU8rtiGRCcYBmDw
         BhMxtR9rA8u/H8/smCbxvJcK6QTwn2PgR+IrwsM3reCGzdZ+9TRE/Sr2EBrHYQ5cpElM
         YdRw==
X-Forwarded-Encrypted: i=1; AJvYcCXQo6Bs0U9LGk6DMoTj94sEVK0f1Db+QWSWe13G1GoIUoo5jFcsE+TU7aW9RMDWk8oCc1KnlTH0Cghe1Co=@vger.kernel.org, AJvYcCXhhtiOfr1YppfnKJsx4bEmVoVzQj2eO8YVV+CNomQLcWVk/R/qMoOgFOTe+OxMI5sJsdwghx+3LF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Pf+iuXBrcJFB0RMtqRuQn+MRkX7y4V7vWnAQeVAoAVG16sKz
	Cr4Kpe6hrV63yHkPq+isWjdBkWmFkVPR+HiWLXqaH1PbBVPdBctO4e28f2ayryrH
X-Gm-Gg: ASbGncsJNzzbVhgBHIwT85TUr3s8nigAhCcqmDT/rC93FPSvVaIudB8/8riQ8f8rfHN
	0gOsPtPbXZnPK8CX2YE+//ohNB1weoJXO29qrcs4DCMvI0/ZERjpqJj1iHpC0ZcrlhKOpUQ3AiR
	E6hzra3lLogYL4kB98aWP+FDN3CnG6Bp4Xv5c7XquLFlKJbtzu6MIODEJ8ijspOIpUw5mm0Wie3
	15cz+mHm7QJbJrmpePUhGpR+YiC6jdS0W77ek2emBpqghUFt0Kv5gFfrSmWfES+0p1Kh4hv/arl
	N/m47OHQ1aJcRYDTCGDg7O1OhVV0PSbmLMpZz0rncSKnTOjZrbcQSUq+Q1CiHPKNpM0QVmj9Rwf
	TQa7CtmFkeiH21OBe3gYJ4ULeVutYbFClkdzxnM4=
X-Google-Smtp-Source: AGHT+IGAicVclNSUJkB0bwmi8uYP6CokY9PVzAk0fjw5jJ1w6B2ET3N3wiZ1N92DpR/JWUNqpqb09w==
X-Received: by 2002:a05:6512:4403:b0:55f:3c0b:9ca9 with SMTP id 2adb3069b0e04-55f4f4c6cffmr2905243e87.1.1756386106907;
        Thu, 28 Aug 2025 06:01:46 -0700 (PDT)
Received: from [10.78.14.69] ([95.214.66.65])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c0223fsm3246639e87.5.2025.08.28.06.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:01:46 -0700 (PDT)
Message-ID: <35172e32-cecd-4d6e-9ff1-68dfa409f0ef@gmail.com>
Date: Thu, 28 Aug 2025 16:01:45 +0300
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
> 
>> +/* What should we do here? */
>> +BD_ISR_BAT(bat_ov, "bd71815-bat-over-det", false)
> 
> At overvoltage all charging should stop, I guess the hardware
> does that autonomouslyd and this is just to inform us that
> this has happened.
> 
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
> to indicate that a measurement of the open circuit voltage
> is available in some register, which enables you do do more
> precise capacity estimation, right?

I'll try to clarify this. No promises though ;)

> If it is useful depends on if the device is e.g. flashed with
> capacity tables vs OC voltage in the factory, and the charger
> then has "deep knowledge" of the battery it is handling, I guess
> this is how it works?

I am not 100% sure as I never had the whole setup with me. AFAICS, the 
used battery (at least in Kobo project) was a dummy one, and the device 
driver did fuel-gauge computation(s) based on the battery parameters and 
the CC.

The OCV and VDR tables were indeed measured (but AFAICS, not during 
manufacturing for each independent device. It was instead done during 
the R&D phase, for the type of battery that was used in these devices. 
Or, at least this is how I think it was done - based on discussion with 
HQ colleagues). Anyways, I think Andreas had these extracted from the 
downstream driver.

> Then this again is just informational, it
> informs you of what the device-internal charging algorithm
> is doing.
> 
> As for the temperature these are probably also just informational
> if all these states are already handled by the hardware itself.
> 
> They all seem to be intended so that you can essentially put
> these into custom sysfs or debugfs entries and then get out
> a graphical state machine of the battery charger. That requires
> deep knowledge of how the charger works (a datasheet)
> and has limited use for a normal user.

Thanks for sharing your insight Linus! It's always great to gain a bit 
more understanding :)

Yours,
	-- Matti


