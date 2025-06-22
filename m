Return-Path: <linux-pm+bounces-29239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9170AE32BA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 00:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6882016E2C0
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 22:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8451F8BA6;
	Sun, 22 Jun 2025 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="E+4rDzDP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778501E51F6;
	Sun, 22 Jun 2025 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750630091; cv=none; b=ChE3Z94DJjfaqU0/rO3UQ9ApZs8rstRGx2Gub/d7okf4ilNuw+bkYX6vWZd4sNl3e/mrQTq8PPn1/o+ObDWtEJQbPzJUlH5EjdyNhJsK9R7xxPApGQcwJyF9tDXFtA5YZSlr/dGMDTd4dM/Jxyvx7RH0eZrSMPmtSsmEQ59SNtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750630091; c=relaxed/simple;
	bh=PtFGCRLHkJNwMA6e2lxLufWv9YqHxpFTh/Dwu/k41Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pc4yfrXUFaqt5AEFi3WomQ/5xQ7/Q6FD3vuVhes/Gfbm551mDj/J9LsMMTJp3dKfQfS4DEG31J/SY1zG7eSX8cMaKmdWsaL5dcL07TtZ1RVKqmEnKdfe7yzjEwymKuuWiFNPdgbY5P/cSH5CKQ8QbGaxAOpHgJvY18nrLob9UsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=E+4rDzDP; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750630086; x=1751234886; i=w_armin@gmx.de;
	bh=Jq8WhCNCRHJk4ojopkU6xTYdlL3SYxOba5mqjoAZmKI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=E+4rDzDPTs2YDGVhNEzfom0+as8JDp4Y5Jfcq5gCsJwBd6MmQHrMnyxRHEOZ2Hmx
	 LkqVz/fzQ1WhCfK0+on2xc48YRex3ojEL0ye/Oyr5ogZa8T4kvpSlHzefCFr+8HQf
	 wu3nsqV98/XxfwdihyOquzfmVqLVbCjR8Orq8b4y3BcaqtrCozDlV5o8/v1IYlFfD
	 +EQIfRl4Y1u7sB+i4H2PoNSL5/fvzEWEnH71ASsaKBhZLEvrABfmFbz7iwl7AGBrI
	 U7zEJttzr/U177CJ2+msGdqylqfEZQt2vpiEl1DQ1UDUstv1gbgIoVA5ojK6gnCih
	 AkyriHtQp2sPXClgoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbkM-1uAgSA18DE-00JIfx; Mon, 23
 Jun 2025 00:08:06 +0200
Message-ID: <13e25678-d73f-49b1-afed-94812a9c10fb@gmx.de>
Date: Mon, 23 Jun 2025 00:08:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: dell-ddv: Fix taking the
 psy->extensions_sem lock twice
To: Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
References: <20250620175807.418300-1-hansg@kernel.org>
 <3bfea893-fd3e-48b6-8a34-9ab36108efe2@gmx.de>
 <b46dcef3-2893-4b94-81ef-a495e6a0e7ca@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <b46dcef3-2893-4b94-81ef-a495e6a0e7ca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bF9d18b3LmYXxieQ+MVaS0t3QA6uuWAHszpX5qJaYGH1lmbEcnx
 L4NEHwixpl+QLBDtO/sFEK58ueCzOt8jTT++AoNvybfoZyxvDBGdYOfq2gVJv9gqWIL1TZs
 IhV4UN4KTDI7fbtgVlmfJYKum2gi3fiCAim5TK7ul0IWldEwkC07pCAasPW1aKgvIzztl++
 QdH9uTZO8eHgLtb+U4XsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MxoSjwDD/Is=;tfHF3ldRLvtsSl8IvFd7pDjeds9
 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
 uQxqf7H7eqoIvBc0AhqJ1OpOcbFOMU5+7PQ4MA==

Am 22.06.25 um 22:59 schrieb Hans de Goede:

> + Cc sre, whom I should have Cc-ed from the beginning.
>
> Hi Armin,
>
> On 22-Jun-25 8:41 PM, Armin Wolf wrote:
>> Am 20.06.25 um 19:58 schrieb Hans de Goede:
>>
>>> dell_wmi_ddv_get_property() gets called with psy->extensions_sem
>>> read-locked, it calls dell_wmi_ddv_battery_translate() which calls
>>> power_supply_get_property() on the same psy which again read-locks
>>> psy->extensions_sem.
>>>
>>> Lockdep rightfully complains about this:
>>>
>>>  =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>  =C2=A0 WARNING: possible recursive locking detected
>>> ...
>>>  =C2=A0 kworker/16:3/1230 is trying to acquire lock:
>>>  =C2=A0 ffff8c3143417658 (&psy->extensions_sem){++++}-{4:4},
>>>  =C2=A0=C2=A0 at: power_supply_get_property.part.0+0x23/0x160
>>>  =C2=A0 but task is already holding lock:
>>>  =C2=A0 ffff8c3143417658 (&psy->extensions_sem){++++}-{4:4},
>>>  =C2=A0=C2=A0 at: power_supply_get_property.part.0+0x23/0x160
>>> ...
>>>  =C2=A0=C2=A0 Possible unsafe locking scenario:
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU0
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----
>>>  =C2=A0=C2=A0=C2=A0 lock(&psy->extensions_sem);
>>>  =C2=A0=C2=A0=C2=A0 lock(&psy->extensions_sem);
>>>
>>>  =C2=A0=C2=A0 *** DEADLOCK ***
>>> ...
>>>  =C2=A0 Call Trace:
>>>  =C2=A0=C2=A0 <TASK>
>>>  =C2=A0=C2=A0 ...
>>>  =C2=A0=C2=A0 down_read+0x3e/0x180
>>>  =C2=A0=C2=A0 ? power_supply_get_property.part.0+0x23/0x160
>>>  =C2=A0=C2=A0 power_supply_get_property.part.0+0x23/0x160
>>>  =C2=A0=C2=A0 dell_wmi_ddv_battery_translate+0x68/0x1d0 [dell_wmi_ddv]
>>>  =C2=A0=C2=A0 ? lock_acquire+0xd9/0x2c0
>>>  =C2=A0=C2=A0 dell_wmi_ddv_get_property+0x25/0x240 [dell_wmi_ddv]
>>>  =C2=A0=C2=A0 power_supply_get_property.part.0+0x87/0x160
>>>  =C2=A0=C2=A0 power_supply_format_property+0xc4/0x3d0
>>>  =C2=A0=C2=A0 add_prop_uevent+0x26/0x90
>>>  =C2=A0=C2=A0 power_supply_uevent+0xb9/0xf0
>>>
>>> This usually works fine, because read-locking can be done multiple tim=
es
>>> but if someone tries to write-lock between the 2 read-lock calls then
>>> the second read-lock will block on the write-lock and the write-lock w=
ill
>>> be blocked on the first read-lock leading to a deadlock.
>>>
>>> The serial is part of the main psy device, not of an extension. Direct=
ly
>>> call psy->desc->get_property() in dell_wmi_ddv_battery_translate() to =
fix
>>> the double-lock issue.
>>>
>>> Note this also influences eppid_show() which is called directly rather
>>> then through power_supply_get_property(). This is ok since the ACPI
>>> battery is fully ready to be used when the battery hook's add_battery
>>> callback is called.
>> Thank you very much for finding this issue, but i think that simply cal=
ling battery->desc->get_property()
>> is not the right solution for this:
>>
>> 1. We should still call psy_desc_has_property() to determine if the pow=
er supply actually support
>>  =C2=A0=C2=A0 POWER_SUPPLY_PROP_SERIAL_NUMBER.
> Although it is currently not enforced in power_supply_core.c it seems
> reasonable to assume that any powersupply must have a get_property
> callback in their desc (the core also unconditionally calls this).
>
> And most (all?) psy drivers I've seen have a default which returns -EINV=
AL
> in their get_property() implementation which works just as well as
> calling has_prop ...
>
> My bigger worry is the lack of the:
>
>>      if (atomic_read(&psy->use_cnt) <=3D 0) {
>>          if (!psy->initialized)
>>              return -EAGAIN;
>>          return -ENODEV;
>>      }
> Check TBH.
>
>> 2. At least another power supply extension user (the uniwill-laptop dri=
ver currently being under review)
>>  =C2=A0=C2=A0 suffers from a similar problem, so a more generic solutio=
n is needed.
>>
>> Maybe we could introduce a new function for reading power supply proper=
ties that ignores any
>> power supply extensions? This way future extension could use this funct=
ion too.
>>
>> I envision something like this:
>>     =20
>> int power_supply_get_property_direct(struct power_supply *psy,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 enum power_supply_property psp,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 union power_supply_propval *val)
>> {
>>  =C2=A0=C2=A0=C2=A0=C2=A0if (atomic_read(&psy->use_cnt) <=3D 0) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!psy->initialized)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn -EAGAIN;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
>>  =C2=A0=C2=A0=C2=A0=C2=A0}
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0if (psy_desc_has_property(psy->desc, psp))
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return psy->desc->get_prope=
rty(psy, psp, val);
>>  =C2=A0=C2=A0=C2=A0=C2=A0else if (power_supply_battery_info_has_prop(ps=
y->battery_info, psp))
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return power_supply_battery=
_info_get_prop(psy->battery_info, psp, val);
>>  =C2=A0=C2=A0=C2=A0=C2=A0else
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> }
>> EXPORT_SYMBOL_GPL(power_supply_get_property_direct);
>>
>> It basically is power_supply_get_property() without the extension logic=
.
> While working on this fix I was thinking that something like this would =
be useful,
> so +1 for this.
>
> Maybe first do a prep patch where the extension handling in
> power_supply_get_property() is moved last, then power_supply_get_propert=
y()
> can just wrap this new helprr and on -EINVAL check the extensions.
>
> Actually if you move the extensions check to last then the whole doublel=
ock
> issue goes away because the serial-number will be found before checking
> extensions.
>
> Or if you want to keep checking the extensions first change
> the current power_supply_get_property() into a new
> __power_supply_get_property() with a "bool check_extensions"
> argument and make power_supply_get_property() wrap it pasing true
> for check_extensions. Or some such, whatever you do try to avoid code
> duplication but you already know this ...
>> I can also write some
>> documentation on how to implement power supply extensions in general.
> That would also be good to have.
>
> Regards,
>
> Hans

Alright, i will send the necessary patches soon.

Thanks,
Armin Wolf

>>> Fixes: 058de163a376 ("platform/x86: dell-ddv: Implement the battery ma=
tching algorithm")
>>> Signed-off-by: Hans de Goede <hansg@kernel.org>
>>> ---
>>>  =C2=A0 drivers/platform/x86/dell/dell-wmi-ddv.c | 8 +++++---
>>>  =C2=A0 1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platfo=
rm/x86/dell/dell-wmi-ddv.c
>>> index 67f3d7158403..95cc3139f271 100644
>>> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
>>> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
>>> @@ -689,9 +689,11 @@ static int dell_wmi_ddv_battery_translate(struct =
dell_wmi_ddv_data *data,
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(&data->wdev->dev, "Tran=
slation cache miss\n");
>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 /* Perform a translation between a ACPI ba=
ttery and a battery index */
>>> -
>>> -=C2=A0=C2=A0=C2=A0 ret =3D power_supply_get_property(battery, POWER_S=
UPPLY_PROP_SERIAL_NUMBER, &val);
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Perform a translation between a ACPI batte=
ry and a battery index. Directly call
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * desc->get_property() to avoid locking batt=
ery->extensions_sem a second time.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 ret =3D battery->desc->get_property(battery, POWER=
_SUPPLY_PROP_SERIAL_NUMBER, &val);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>   =20
>

