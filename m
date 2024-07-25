Return-Path: <linux-pm+bounces-11412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3255D93CB6B
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 01:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 952CDB2146E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 23:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F320144D2B;
	Thu, 25 Jul 2024 23:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="gQIpSpcF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681083BBC2;
	Thu, 25 Jul 2024 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721951381; cv=none; b=CrlbRmWfyOZly2wGmAQ1GsYlEIAZhr58SiP5+IYOMsN4geYwtCe/iG9I00+RWAtuS/vNcaMQ6STCZbmUKOAhZ9gi24paHQsLVpaGgeUxk+ZbO9K1PEXhGCv7F7XSMewU0FZKH5fMrMTfG3rO8vQ3ze5g1jl2jic8hCUgwMnGMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721951381; c=relaxed/simple;
	bh=hPgjUKJrcuD0qiu4AZ3NwEYTPJh9Vb8Ll3yoa99MnHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGX3ZIi7mB6E6OW+WVB0KweERUY5PjT1avbtVeokgBp4bH3849/4GP/5xpsgr+ou6OM35YNwE2ezL1yijMekyDhVYrM77iZ4Dy1KS/kyWFv8aO7+ABJR1tWmR46MCGlGtEtwg2hJMy8TTnb5sFjs0B81KMAjBes9oxoCXMQkeWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=gQIpSpcF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721951334; x=1722556134; i=w_armin@gmx.de;
	bh=b9qIv0PFChQf3DNf9sbFYVFtXE/WFhkfHoNrEo/ANos=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gQIpSpcFqC3z/KivRPLbsDAj0aWhr+MU+AF6qo/VRGpnSw1404Ghu7TTNI2xpHZ1
	 aZATV09jDQ6zTPhYWKdfZGPmbyA+GlGXzIu6L3QVIYFWTc6zjNuxYedTuOQLHCJIY
	 VrTpHWpujdd1hjEOiDbFO8DQnDtICg4nN1Ein0WkKltV4rULl3OvgGO7tyyBuaDHu
	 GN8gn3ZdzPGm588YboBb1sJpO0MyLwh+IAyaAYAB4vJX43UOuJg4qcoX11h+oLTS2
	 3+cK4L7yf9ST5Swqw0vEdCmn8TTqs3G9yojPSIBHZkO9Mvf/effJD9IMchOyEuTSf
	 nz6/45YC9i2J6yX5jQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXyJ-1snHCr2Iwx-00LPn1; Fri, 26
 Jul 2024 01:48:54 +0200
Message-ID: <45c7c4c3-2f99-4ca0-9c85-a96a03ccfae8@gmx.de>
Date: Fri, 26 Jul 2024 01:48:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Andres Salomon <dilinger@queued.net>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Matthew Garrett <mjg59@srcf.ucam.org>, Sebastian Reichel <sre@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
References: <20240723220502.77cb0401@5400>
 <20240724203403.zcrx2lshbla3o2gp@pali> <20240724204523.xb6rp7ba6yqi5klt@pali>
 <20240724182318.66578a48@5400> <20240724230158.nsmxdgagfpanjtzi@pali>
 <20240725162457.34b480e1@5400> <20240725221511.mqb4tlam2r7yheoi@pali>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240725221511.mqb4tlam2r7yheoi@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nbNNcZF5yxIfHJ1Da3+B5aP4Nx7lg9eaqd47KNKUaIRWTTmsa5U
 lwODPylCNuu64weaJTWK8ETsNAy9p2gCSo23sYWvM4FiURw1T8MwXHJJhMeG1OnPgCYM2Nz
 zCFr7vexGxANq49tFZG4hOYwqT95DAMdxTeT6RuSkT5/N21ZLT92gw4Dv6tSJt/3NqilAeN
 Lw5vq/jQJ7J9yHbw4cdsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LpNCppc8lWg=;4LMANo8d2wuYqdpbnSaOZ7EUgui
 VSjCpuJR/Egnbx0FesxdJjMisieeP7z85CC+l1lO6hGYdqHlQFqOi1eZSo0WhKv/PlBmR+M2s
 DcKNkTjYiHuqjDVtohpo3ry0ht/uH80V+Ip9Z0ADjwMF386VX1E2ueyVtrOP3SOJplRDmO5v8
 PNf36lr9A2XFxSJ7JoLQ1iy1K3Zfp9x25GmN2qsQqz5fjXVNarA9G0JSz7E5rWUANtLVz/KAE
 wOZhNROkGbcnjCp6mqStYwfnAWRnykZbnk8+yBokP8JhugtC5Dj0+a9Kd2KsIv9uyWDQd1Pfg
 zW3rKpCCPfAmE8e0BklbuyLB1fIVwHUDFCFBJ4V7RshZnUlgEKri3AqX7zR+v98AmdP0Buqjp
 VffMiW62x8Udv9wQ7FeEF4xL33rScZIupL3zAVdvly71EHofMSsOI3rXQFrQNLetAOZ56CB0u
 M7dGUm0As2eiUttSKAMPGii/XLmSeu04tkh0y5WmbOQVmw61O48Oqu31sJz2qM0k/HRSsRKn9
 hD6qLnNu6E56S33YQfv/3qSpmcowwYQgEN4Raeaxl3MhIQGjom1uZs+SE+hWd7XuzI+xCaRMq
 k43NwH18gKdh8La/pqs0+mA8HR4TCadPxJ1TpnT1P1MksnIX57NgMU5RmBWa/MAjylTQ8fIv0
 LsYFp8eDHglJwxxEPPUJR6qE3AkuA8haIQM91Witc/GZejLMTg3sNJa+kCwDK3rnCGZP1RiuH
 oii38Y5+tjs5hp2Mr7F+QPx1/xMI1kEZrZ8pkDtfnbgUhaBl0uoTJZMczBfRW3QtmoJfcZkr8
 ncJZmp3e3/P8hin/hhJee7lw==

Am 26.07.24 um 00:15 schrieb Pali Roh=C3=A1r:

> On Thursday 25 July 2024 16:24:57 Andres Salomon wrote:
>> On Thu, 25 Jul 2024 01:01:58 +0200
>> Pali Roh=C3=A1r <pali@kernel.org> wrote:
>>
>>> On Wednesday 24 July 2024 18:23:18 Andres Salomon wrote:
>>>> On Wed, 24 Jul 2024 22:45:23 +0200
>>>> Pali Roh=C3=A1r <pali@kernel.org> wrote:
>>>>
>>>>> On Wednesday 24 July 2024 22:34:03 Pali Roh=C3=A1r wrote:
>>>>>> Hello, the driver change looks good. I have just few minor comments=
 for
>>>>>> this change below.
>>>>>>
>>>>>> Anyway, if there is somebody on the list with Dell laptop with 2 or=
 3
>>>>>> batteries, see below, it would be nice to check how such laptop wou=
ld
>>>>>> behave with this patch. It does not seem that patch should cause
>>>>>> regression but always it is better to do testing if it is possible.
>>>>>>
>>>>>> On Tuesday 23 July 2024 22:05:02 Andres Salomon wrote:
>>>> [...]
>>>>> And because CLASS_TOKEN_WRITE is being repeated, what about defining
>>>>> something like this?
>>>>>
>>>>>      static inline int dell_set_token_value(struct calling_interface=
_buffer *buffer, u16 class, u16 tokenid, u32 value)
>>>>>      {
>>>>>          dell_send_request_for_tokenid(buffer, class, CLASS_TOKEN_WR=
ITE, tokenid, value);
>>>>>      }
>>>>>
>>>>> Just an idea. Do you think that it could be useful in second patch?
>>>>>
>>>> Let me implement the other changes first and then take a look.
>>> Ok.
>>>
>> For the helper function, I noticed that all of the CLASS_TOKEN_WRITEs
>> also have SELECT_TOKEN_STD except for one (dell_send_intensity). So I
>> think it makes sense to have the helper function also do that as well.
>> Eg,
>>
>> static inline int dell_set_std_token_value(struct calling_interface_buf=
fer *buffer, u16 tokenid, u32 value)
>> {
>> 	dell_send_request_for_tokenid(buffer, SELECT_TOKEN_STD, CLASS_TOKEN_WR=
ITE, tokenid, value);
>> }
>>
>> I agree with your renaming to dell_send_request_for_tokenid, btw.
>>
>>
>>>>>>> +static int dell_battery_read(const int type)
>>>>>>> +{
>>>>>>> +	struct calling_interface_buffer buffer;
>>>>>>> +	int err;
>>>>>>> +
>>>>>>> +	err =3D dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_READ=
,
>>>>>>> +			SELECT_TOKEN_STD, type, 0);
>>>>>>> +	if (err)
>>>>>>> +		return err;
>>>>>>> +
>>>>>>> +	return buffer.output[1];
>>>>>> buffer.output[1] is of type u32. So theoretically it can contain va=
lue
>>>>>> above 2^31. For safety it would be better to check if the output[1]
>>>>>> value fits into INT_MAX and if not then return something like -ERAN=
GE
>>>>>> (or some other better errno code).
>>
>> I ended up returning -EIO here, with the logic that if we're getting
>> some nonsense value from SMBIOS, it could either be junk in the stored
>> values or communication corruption.
>>
>> Likewise, I used -EIO for the checks in charge_control_start_threshold_=
show
>> and charge_control_end_threshold_show when SMBIOS returns values > 100%=
.
>>
>>
>>
>>>>
>>>>>>
>>>>>>> +	if (end < 0)
>>>>>>> +		end =3D CHARGE_END_MAX;
>>>>>>> +	if ((end - start) < CHARGE_MIN_DIFF)
>>>>>> nit: I'm not sure what is the correct coding style for kernel drive=
rs
>>>>>> but I thought that parenthesis around (end - start) are not being
>>>>>> written.
>>>>>>
>> I think it makes the comparison much easier to read. I'd prefer to
>> keep it, unless the coding style specifically forbids it.
> As I said I'm really not sure. So if nobody would complain then you can
> let it as is.
>
> You can use ./scripts/checkpatch.pl application which is in git tree,
> which does basic checks for code style. It cannot prove if something is
> really correct but it can prove if something is incorrect.
>
>>
>>
>>>>>>> +
>>>>>>> +static u32 __init battery_get_supported_modes(void)
>>>>>>> +{
>>>>>>> +	u32 modes =3D 0;
>>>>>>> +	int i;
>>>>>>> +
>>>>>>> +	for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
>>>>>>> +		if (dell_smbios_find_token(battery_modes[i].token))
>>>>>>> +			modes |=3D BIT(i);
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	return modes;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void __init dell_battery_init(struct device *dev)
>>>>>>> +{
>>>>>>> +	battery_supported_modes =3D battery_get_supported_modes();
>>>>>>> +
>>>>>>> +	if (battery_supported_modes !=3D 0)
>>>>>>> +		battery_hook_register(&dell_battery_hook);
>>>>>> Anyway, how is this battery_hook_register() suppose to work on syst=
ems
>>>>>> with multiple batteries? The provided API is only for the primary
>>>>>> battery, but on older Dell laptop it was possible to connect up to
>>>>>> 3 batteries. Would not this case some issues?
>>>> This interface is _only_ for controlling charging of the primary batt=
ery.
>>>> In theory, it should hopefully ignore any other batteries, which woul=
d
>>>> need to have their settings changed in the BIOS or with a special too=
l or
>>>> whatever.
>>> That is OK. But where it is specified that the hook is being registere=
d
>>> only for the primary battery? Because from the usage it looks like tha=
t
>>> the hook is applied either for all batteries present in the system or
>>> for some one arbitrary chosen battery.
>>>
>>>> However, I'm basing that assumption on the SMBIOS interface. These to=
kens
>>>> are marked "Primary Battery". There are separate tokens marked "Batte=
ry
>>>> Slice", which from my understanding was an older type of battery that
>>>  From SMBIOS perspective it is clear, each battery seems to have its o=
wn
>>> tokens.
>>>
>>> The issue here is: how to tell kernel that the particular
>>> dell_battery_hook has to be bound with the primary battery?
>>>
>> So from userspace, we've got the expectation that multiple batteries
>> would show up as /sys/class/power_supply/BAT0, /sys/class/power_supply/=
BAT1,
>> and so on.
> Yes, I hope so.
>
>> The current BAT0 entry shows things like 'capacity' even without this
>> patch, and we're just piggybacking off of that to add charge_type and
>> other entries. So there shouldn't be any confusion there, agreed?
> I have not looked at the battery_hook_register() code yet (seems that I
> would have to properly read it and understand it). But does it mean that
> battery_hook_register() is adding hook just for "BAT0"?
>
> What I mean: cannot that hook be registered to "BAT1" too? Because if
> yes then we should prevent it. Otherwise this hook which is for "Dell
> Primary Battery" could be registered also for secondary battery "BAT1".
> (I hope that now it is more clear what I mean).

Hi,

the battery hook is being registered to all ACPI batteries present on a gi=
ven system,
so you need to do some manual filtering when .add_battery() is called.

As a side note: i suspect that "newer" Dell machines use a different inter=
face for controlling
battery charging, since the Dell Power Manager software on my machine seem=
s to provide some
additional features not found in this token-based interface.

Unfortunately i am not sure if reverse-engineering the Dell software is le=
gal, does the kernel
community have some helping guides in this area? If it is legal, then i wo=
uld happily volunteer
to do the reverse-engineering.

Otherwise maybe someone at Dell can provide some clarifications if a diffe=
rent interface for controlling
battery charging exists and how to use it?

Thanks,
Armin Wolf

>> In the kernel, we're registering the acpi_battery_hook as "Dell Primary
>> Battery Extension". The functions set up by that acpi_battery_hook are
>> the only ones using battery_support_modes. We could make it more explic=
it
>> by:
>> 1) renaming it to primary_battery_modes, along with
>> dell_primary_battery_{init,exit} and/or
>> 2) allocating the mode mask and strings dynamically, and storing that
>> inside of the dev kobject.
>>
>> However, #2 seems overly complicated for what we're doing. In the
>> circumstances that we want to add support for secondary batteries,
>> we're going to need to query separate tokens, add another
>> acpi_battery_hook, and also add a second mask. Whether that's a global
>> variable or kept inside pdev seems like more of a style issue than
>> anything else.
>>
>> #1 is easy enough to change, if you think that's necessary.
> I think that "Dell Primary Battery Extension" is OK. All SMBIOS code is
> currently primary-battery only.
>
> The only my point is to prevent this &dell_battery_hook to be registered
> for non-primary battery.
>

