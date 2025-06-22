Return-Path: <linux-pm+bounces-29236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FA4AE3222
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 22:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07D416F617
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 20:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FF621507C;
	Sun, 22 Jun 2025 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfkmzOou"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4CE4409;
	Sun, 22 Jun 2025 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750625974; cv=none; b=HMu0q19OKnY2yuZl1812ch/gVKb45gIwE3GmWLkND3MldWXuIis9Bzf3EvhdK7KSG4IbUe3yCE7fmf93AJJiyp/a2TU1KYgWA6/5ANNbjCZQkPR5bbFUhMMKnRTMpGflZYGVcNXga8cLaVmxDjrrvWl4183GI7aXoacyPjfluOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750625974; c=relaxed/simple;
	bh=8YMK4lPlyBFWPRybG/UDVbwX/HzVAlNCWxUJvE/HP6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5AvKalJcbuu485w1N2OzD2vaNM9aIb9K2E5aIRxpMMjsFtBxdWXpppFLTTRkHSjTWxZlK7hoXOKwVom174gh2t7sKbbE70CvFElMCdH/u3uxdmlbqBh1Ily+U6K5jzuNts9rJ1ela5YVEarGvjNCvvHiu2J/p9nJMIXpSZuwb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfkmzOou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78D0C4CEE3;
	Sun, 22 Jun 2025 20:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750625974;
	bh=8YMK4lPlyBFWPRybG/UDVbwX/HzVAlNCWxUJvE/HP6w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MfkmzOouKrwq5EkGi039PmDyCPGcgMosT6K7xlPlapB9X+jAJ9f07GxBbOEkUUC/3
	 wydx/m+BjwGKfbJtcb7FACvS2McFN42YCH5/IGcktgIiQv5ABSH/MkOBIB6gTarU7s
	 kmg5iqoJftPPJaO0kH1VpvmVsg4sM9vOhBtyKMneUkP/2lLKHR+kZVcN2MWyWOkqmk
	 k18gfUsIpeiAYUCpFgEGb5AMRCQ7BMwgKIxQ7QEuzI/zXyzkfQ4dx0qZXMyvK46cXr
	 QQNtKXq8EJ7G8CQbSUniOIhhz6/dMblFzVgVlQDJcw4Fm/PpSUwlk229FPWxiVEYVr
	 /Nlnfyhj5bLYQ==
Message-ID: <b46dcef3-2893-4b94-81ef-a495e6a0e7ca@kernel.org>
Date: Sun, 22 Jun 2025 22:59:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: dell-ddv: Fix taking the
 psy->extensions_sem lock twice
To: Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andy@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
References: <20250620175807.418300-1-hansg@kernel.org>
 <3bfea893-fd3e-48b6-8a34-9ab36108efe2@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <3bfea893-fd3e-48b6-8a34-9ab36108efe2@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+ Cc sre, whom I should have Cc-ed from the beginning.

Hi Armin,

On 22-Jun-25 8:41 PM, Armin Wolf wrote:
> Am 20.06.25 um 19:58 schrieb Hans de Goede:
> 
>> dell_wmi_ddv_get_property() gets called with psy->extensions_sem
>> read-locked, it calls dell_wmi_ddv_battery_translate() which calls
>> power_supply_get_property() on the same psy which again read-locks
>> psy->extensions_sem.
>>
>> Lockdep rightfully complains about this:
>>
>>   ============================================
>>   WARNING: possible recursive locking detected
>> ...
>>   kworker/16:3/1230 is trying to acquire lock:
>>   ffff8c3143417658 (&psy->extensions_sem){++++}-{4:4},
>>    at: power_supply_get_property.part.0+0x23/0x160
>>   but task is already holding lock:
>>   ffff8c3143417658 (&psy->extensions_sem){++++}-{4:4},
>>    at: power_supply_get_property.part.0+0x23/0x160
>> ...
>>    Possible unsafe locking scenario:
>>
>>          CPU0
>>          ----
>>     lock(&psy->extensions_sem);
>>     lock(&psy->extensions_sem);
>>
>>    *** DEADLOCK ***
>> ...
>>   Call Trace:
>>    <TASK>
>>    ...
>>    down_read+0x3e/0x180
>>    ? power_supply_get_property.part.0+0x23/0x160
>>    power_supply_get_property.part.0+0x23/0x160
>>    dell_wmi_ddv_battery_translate+0x68/0x1d0 [dell_wmi_ddv]
>>    ? lock_acquire+0xd9/0x2c0
>>    dell_wmi_ddv_get_property+0x25/0x240 [dell_wmi_ddv]
>>    power_supply_get_property.part.0+0x87/0x160
>>    power_supply_format_property+0xc4/0x3d0
>>    add_prop_uevent+0x26/0x90
>>    power_supply_uevent+0xb9/0xf0
>>
>> This usually works fine, because read-locking can be done multiple times
>> but if someone tries to write-lock between the 2 read-lock calls then
>> the second read-lock will block on the write-lock and the write-lock will
>> be blocked on the first read-lock leading to a deadlock.
>>
>> The serial is part of the main psy device, not of an extension. Directly
>> call psy->desc->get_property() in dell_wmi_ddv_battery_translate() to fix
>> the double-lock issue.
>>
>> Note this also influences eppid_show() which is called directly rather
>> then through power_supply_get_property(). This is ok since the ACPI
>> battery is fully ready to be used when the battery hook's add_battery
>> callback is called.
> 
> Thank you very much for finding this issue, but i think that simply calling battery->desc->get_property()
> is not the right solution for this:
> 
> 1. We should still call psy_desc_has_property() to determine if the power supply actually support
>    POWER_SUPPLY_PROP_SERIAL_NUMBER.

Although it is currently not enforced in power_supply_core.c it seems
reasonable to assume that any powersupply must have a get_property
callback in their desc (the core also unconditionally calls this).

And most (all?) psy drivers I've seen have a default which returns -EINVAL
in their get_property() implementation which works just as well as
calling has_prop ...

My bigger worry is the lack of the:

>     if (atomic_read(&psy->use_cnt) <= 0) {
>         if (!psy->initialized)
>             return -EAGAIN;
>         return -ENODEV;
>     }

Check TBH.

> 2. At least another power supply extension user (the uniwill-laptop driver currently being under review)
>    suffers from a similar problem, so a more generic solution is needed.
> 
> Maybe we could introduce a new function for reading power supply properties that ignores any
> power supply extensions? This way future extension could use this function too.
> 
> I envision something like this:
>     
> int power_supply_get_property_direct(struct power_supply *psy,
>                 enum power_supply_property psp,
>                 union power_supply_propval *val)
> {
>     if (atomic_read(&psy->use_cnt) <= 0) {
>         if (!psy->initialized)
>             return -EAGAIN;
>         return -ENODEV;
>     }
> 
>     if (psy_desc_has_property(psy->desc, psp))
>         return psy->desc->get_property(psy, psp, val);
>     else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
>         return power_supply_battery_info_get_prop(psy->battery_info, psp, val);
>     else
>         return -EINVAL;
> }
> EXPORT_SYMBOL_GPL(power_supply_get_property_direct);
> 
> It basically is power_supply_get_property() without the extension logic.

While working on this fix I was thinking that something like this would be useful,
so +1 for this.

Maybe first do a prep patch where the extension handling in
power_supply_get_property() is moved last, then power_supply_get_property()
can just wrap this new helprr and on -EINVAL check the extensions.

Actually if you move the extensions check to last then the whole doublelock
issue goes away because the serial-number will be found before checking
extensions.

Or if you want to keep checking the extensions first change
the current power_supply_get_property() into a new
__power_supply_get_property() with a "bool check_extensions"
argument and make power_supply_get_property() wrap it pasing true
for check_extensions. Or some such, whatever you do try to avoid code
duplication but you already know this ...

> I can also write some
> documentation on how to implement power supply extensions in general.

That would also be good to have.

Regards,

Hans






>> Fixes: 058de163a376 ("platform/x86: dell-ddv: Implement the battery matching algorithm")
>> Signed-off-by: Hans de Goede <hansg@kernel.org>
>> ---
>>   drivers/platform/x86/dell/dell-wmi-ddv.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
>> index 67f3d7158403..95cc3139f271 100644
>> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
>> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
>> @@ -689,9 +689,11 @@ static int dell_wmi_ddv_battery_translate(struct dell_wmi_ddv_data *data,
>>         dev_dbg(&data->wdev->dev, "Translation cache miss\n");
>>   -    /* Perform a translation between a ACPI battery and a battery index */
>> -
>> -    ret = power_supply_get_property(battery, POWER_SUPPLY_PROP_SERIAL_NUMBER, &val);
>> +    /*
>> +     * Perform a translation between a ACPI battery and a battery index. Directly call
>> +     * desc->get_property() to avoid locking battery->extensions_sem a second time.
>> +     */
>> +    ret = battery->desc->get_property(battery, POWER_SUPPLY_PROP_SERIAL_NUMBER, &val);
>>       if (ret < 0)
>>           return ret;
>>   


