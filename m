Return-Path: <linux-pm+bounces-12061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051E194E01D
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2024 07:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235A51C209D9
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2024 05:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE391798C;
	Sun, 11 Aug 2024 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="QZq7m2R0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494572595;
	Sun, 11 Aug 2024 05:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723354184; cv=none; b=DVzNf5Afi82VP+fK6VbpfXwtjz44+D/kBd/jlsU/dZqo6NVclvi8S/9b2j42ry3NiN9qR1Laq0dH7Q3IorSBDr1sppiXwgkgjSzWx1afLk6xJ/ielggV5m7HKcC7uC34vvdZAvPLdUpjCySALXbRwT43HkCjUPCRgDK0b/StDS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723354184; c=relaxed/simple;
	bh=NSI+tAxoFQdgbFWEEqSOojikI1mBVJ1zxBYqM/yfWg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzy2Nz/gvJAUgpWOx1uvCeS6cIJxXdi0EOh0agYgBKhsl3DYT4+HwIkGG2mMKf6YNC7xlK7xt2cTVS+xh2OOB0UBsJthi3NVue4E5dNeP1IvQ53weeZpH/L5orp1p5ocyp0ci7bQZ3U66JYJRn4hCW6z0rOBYJ0qnF+XMX/xIBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=QZq7m2R0; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723354133; x=1723958933; i=w_armin@gmx.de;
	bh=9BihNjSph28G/CJMlOn05YKLt4dp0FHTST4ZCny260I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QZq7m2R0RhBOmzqfMx5Q6xAVhXnQ4DKUQWD9hQUrGORCghF0vIw7y6n3+5ru89lq
	 4Xuij2xvqAuAQznC4KwhMB/6HN7dzuHAJMg30+VhFdAkdClyD5e0pgEbePYuU4ZJ1
	 fsSN/T0pKJ12085AxnoH+PeuCD/xIaPKLiaz6XyE5nDof0aCDt2dwGivVmQf0WO4i
	 FE7eGKKoO4V4z9jrIZABC/gWFV9u73zWKfocwN4AdKQfbr/5RoXhcOC2MUwp1YCOs
	 99RTst0WQcd55ulcv7kcAEOfm3e9A2Qg5ONh0rgq45K3DRgZKLTL/zUAnMnzuMhxK
	 lCXJYSAfakaKngALWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacSe-1s2Ik32S0g-00bwno; Sun, 11
 Aug 2024 07:28:53 +0200
Message-ID: <0f5735f3-6979-4cc3-8d9b-a953be210683@gmx.de>
Date: Sun, 11 Aug 2024 07:28:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Andres Salomon <dilinger@queued.net>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
References: <20240723220502.77cb0401@5400>
 <20240724203403.zcrx2lshbla3o2gp@pali> <20240724204523.xb6rp7ba6yqi5klt@pali>
 <20240724182318.66578a48@5400> <20240724230158.nsmxdgagfpanjtzi@pali>
 <20240725162457.34b480e1@5400> <20240725221511.mqb4tlam2r7yheoi@pali>
 <45c7c4c3-2f99-4ca0-9c85-a96a03ccfae8@gmx.de>
 <20240726000409.ejnvqkzco664q3zb@pali>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240726000409.ejnvqkzco664q3zb@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DaRlBUs8t0+4kilM5nTOS/Hv1PuYjtLzg7DbuipPmLwmpGPf5Kq
 FgaBZm3KhxpcQwzjsOK+5+v6xH+7e3bAUJfF+G8C5xlosBsvoVmMBALu8t19JF9RkGykieS
 xRSOJw4HgeOXF7Oj+gxIA+leZuqEqcCZzmEdrMTNsx1oagngi43jPF1uvJQ+ZlQwi/H3I0N
 E2B+Jx2BrPGcaKxaO3bCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wdpcmY8blOI=;a4tbfGhQT1GM7WM2wA/45lSHcfR
 Eaaw7OsRz6sSr2wnE7YrFp4O0f78UL/Sqmyz9GDu5Ihj337VRNwu0lAv5twrcaA5CoagCuCMY
 KxmhJvZIcejAkP61JFDTJmz6zJ7Qbp8TFITtHBq5TmZKFDkC6ppe9CQrF3AUMcbOyPMeEBndo
 OPga31H1FUWqrVJx4ysyIWAFYx+sMwwe31YXQ/EEZqYYUN9GCAncuRe8kRr8RNq6iLAx5dzKr
 ihVdkE+YctMUel/T9dz64ePtU5sgIGhINDAB7Sv4EbXZU/imLZjIrfC+1/X4pXrkEgb1CXyi2
 cSP+tOODWmMqxRjOsvTozy2kLpLZSEJKvdjPm5zi0w4hbMAmU6Hhk5px+kjzvSqdAGvM5ADvu
 P7RPo2nfICJfg1sXkQWI4l1g9dQA7pj+NhWo7VT9LnNxD43d716WPlJQC7GowvSOEekbUuHBN
 hBnNHOFir1m7R+D2Crw+ESAJuHJT0qeeeox2WJcZGAyEkB2AfBQqTZtBWVFDzWDpOO85YQ6F1
 IdqD5InJYDcxIaOUW8Z9FAQ40xSpbjlgcpReXcZ/uO/YggK62pzNiThPI/jM4yHrb2TFh92pm
 WiIBjSuQx72KKVnS3bZ8vRt45bNdEZw6jsJ+yEwNS2TZ9eNmZowYE5X7QmBSIeBisO27qgJiz
 NR65s/OwBKIhRph3W7+UgqOeRRUyVN+ZgWew0bbhdViMjZ/MSpl/AD8uXzE03Kp5zUsveg1xa
 Y+E1YyTfZt8xSpBBB06HDoQOllWfTXUOfo4JEyFZOboul7xXgBwh0BriQeHD/4Zje6w7ehawc
 cSrbzu7K9HofPr750lbogCD/jiC5kvJlg9HT8XMhXOW9M=

Am 26.07.24 um 02:04 schrieb Pali Roh=C3=A1r:

> On Friday 26 July 2024 01:48:50 Armin Wolf wrote:
>> Am 26.07.24 um 00:15 schrieb Pali Roh=C3=A1r:
>>
>>> On Thursday 25 July 2024 16:24:57 Andres Salomon wrote:
>>>> On Thu, 25 Jul 2024 01:01:58 +0200
>>>> Pali Roh=C3=A1r <pali@kernel.org> wrote:
>>>>
>>>>> On Wednesday 24 July 2024 18:23:18 Andres Salomon wrote:
>>>>>> On Wed, 24 Jul 2024 22:45:23 +0200
>>>>>> Pali Roh=C3=A1r <pali@kernel.org> wrote:
>>>>>>
>>>>>>> On Wednesday 24 July 2024 22:34:03 Pali Roh=C3=A1r wrote:
>>>>>>>> Hello, the driver change looks good. I have just few minor commen=
ts for
>>>>>>>> this change below.
>>>>>>>>
>>>>>>>> Anyway, if there is somebody on the list with Dell laptop with 2 =
or 3
>>>>>>>> batteries, see below, it would be nice to check how such laptop w=
ould
>>>>>>>> behave with this patch. It does not seem that patch should cause
>>>>>>>> regression but always it is better to do testing if it is possibl=
e.
>>>>>>>>
>>>>>>>> On Tuesday 23 July 2024 22:05:02 Andres Salomon wrote:
>>>>>> [...]
>>>>>>> And because CLASS_TOKEN_WRITE is being repeated, what about defini=
ng
>>>>>>> something like this?
>>>>>>>
>>>>>>>       static inline int dell_set_token_value(struct calling_interf=
ace_buffer *buffer, u16 class, u16 tokenid, u32 value)
>>>>>>>       {
>>>>>>>           dell_send_request_for_tokenid(buffer, class, CLASS_TOKEN=
_WRITE, tokenid, value);
>>>>>>>       }
>>>>>>>
>>>>>>> Just an idea. Do you think that it could be useful in second patch=
?
>>>>>>>
>>>>>> Let me implement the other changes first and then take a look.
>>>>> Ok.
>>>>>
>>>> For the helper function, I noticed that all of the CLASS_TOKEN_WRITEs
>>>> also have SELECT_TOKEN_STD except for one (dell_send_intensity). So I
>>>> think it makes sense to have the helper function also do that as well=
.
>>>> Eg,
>>>>
>>>> static inline int dell_set_std_token_value(struct calling_interface_b=
uffer *buffer, u16 tokenid, u32 value)
>>>> {
>>>> 	dell_send_request_for_tokenid(buffer, SELECT_TOKEN_STD, CLASS_TOKEN_=
WRITE, tokenid, value);
>>>> }
>>>>
>>>> I agree with your renaming to dell_send_request_for_tokenid, btw.
>>>>
>>>>
>>>>>>>>> +static int dell_battery_read(const int type)
>>>>>>>>> +{
>>>>>>>>> +	struct calling_interface_buffer buffer;
>>>>>>>>> +	int err;
>>>>>>>>> +
>>>>>>>>> +	err =3D dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_RE=
AD,
>>>>>>>>> +			SELECT_TOKEN_STD, type, 0);
>>>>>>>>> +	if (err)
>>>>>>>>> +		return err;
>>>>>>>>> +
>>>>>>>>> +	return buffer.output[1];
>>>>>>>> buffer.output[1] is of type u32. So theoretically it can contain =
value
>>>>>>>> above 2^31. For safety it would be better to check if the output[=
1]
>>>>>>>> value fits into INT_MAX and if not then return something like -ER=
ANGE
>>>>>>>> (or some other better errno code).
>>>> I ended up returning -EIO here, with the logic that if we're getting
>>>> some nonsense value from SMBIOS, it could either be junk in the store=
d
>>>> values or communication corruption.
>>>>
>>>> Likewise, I used -EIO for the checks in charge_control_start_threshol=
d_show
>>>> and charge_control_end_threshold_show when SMBIOS returns values > 10=
0%.
>>>>
>>>>
>>>>
>>>>>>>>> +	if (end < 0)
>>>>>>>>> +		end =3D CHARGE_END_MAX;
>>>>>>>>> +	if ((end - start) < CHARGE_MIN_DIFF)
>>>>>>>> nit: I'm not sure what is the correct coding style for kernel dri=
vers
>>>>>>>> but I thought that parenthesis around (end - start) are not being
>>>>>>>> written.
>>>>>>>>
>>>> I think it makes the comparison much easier to read. I'd prefer to
>>>> keep it, unless the coding style specifically forbids it.
>>> As I said I'm really not sure. So if nobody would complain then you ca=
n
>>> let it as is.
>>>
>>> You can use ./scripts/checkpatch.pl application which is in git tree,
>>> which does basic checks for code style. It cannot prove if something i=
s
>>> really correct but it can prove if something is incorrect.
>>>
>>>>
>>>>>>>>> +
>>>>>>>>> +static u32 __init battery_get_supported_modes(void)
>>>>>>>>> +{
>>>>>>>>> +	u32 modes =3D 0;
>>>>>>>>> +	int i;
>>>>>>>>> +
>>>>>>>>> +	for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
>>>>>>>>> +		if (dell_smbios_find_token(battery_modes[i].token))
>>>>>>>>> +			modes |=3D BIT(i);
>>>>>>>>> +	}
>>>>>>>>> +
>>>>>>>>> +	return modes;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static void __init dell_battery_init(struct device *dev)
>>>>>>>>> +{
>>>>>>>>> +	battery_supported_modes =3D battery_get_supported_modes();
>>>>>>>>> +
>>>>>>>>> +	if (battery_supported_modes !=3D 0)
>>>>>>>>> +		battery_hook_register(&dell_battery_hook);
>>>>>>>> Anyway, how is this battery_hook_register() suppose to work on sy=
stems
>>>>>>>> with multiple batteries? The provided API is only for the primary
>>>>>>>> battery, but on older Dell laptop it was possible to connect up t=
o
>>>>>>>> 3 batteries. Would not this case some issues?
>>>>>> This interface is _only_ for controlling charging of the primary ba=
ttery.
>>>>>> In theory, it should hopefully ignore any other batteries, which wo=
uld
>>>>>> need to have their settings changed in the BIOS or with a special t=
ool or
>>>>>> whatever.
>>>>> That is OK. But where it is specified that the hook is being registe=
red
>>>>> only for the primary battery? Because from the usage it looks like t=
hat
>>>>> the hook is applied either for all batteries present in the system o=
r
>>>>> for some one arbitrary chosen battery.
>>>>>
>>>>>> However, I'm basing that assumption on the SMBIOS interface. These =
tokens
>>>>>> are marked "Primary Battery". There are separate tokens marked "Bat=
tery
>>>>>> Slice", which from my understanding was an older type of battery th=
at
>>>>>   From SMBIOS perspective it is clear, each battery seems to have it=
s own
>>>>> tokens.
>>>>>
>>>>> The issue here is: how to tell kernel that the particular
>>>>> dell_battery_hook has to be bound with the primary battery?
>>>>>
>>>> So from userspace, we've got the expectation that multiple batteries
>>>> would show up as /sys/class/power_supply/BAT0, /sys/class/power_suppl=
y/BAT1,
>>>> and so on.
>>> Yes, I hope so.
>>>
>>>> The current BAT0 entry shows things like 'capacity' even without this
>>>> patch, and we're just piggybacking off of that to add charge_type and
>>>> other entries. So there shouldn't be any confusion there, agreed?
>>> I have not looked at the battery_hook_register() code yet (seems that =
I
>>> would have to properly read it and understand it). But does it mean th=
at
>>> battery_hook_register() is adding hook just for "BAT0"?
>>>
>>> What I mean: cannot that hook be registered to "BAT1" too? Because if
>>> yes then we should prevent it. Otherwise this hook which is for "Dell
>>> Primary Battery" could be registered also for secondary battery "BAT1"=
.
>>> (I hope that now it is more clear what I mean).
>> Hi,
>>
>> the battery hook is being registered to all ACPI batteries present on a=
 given system,
>> so you need to do some manual filtering when .add_battery() is called.
> Ok. So it means that the filtering based on the primary battery in
> add_battery callback is needed.
>
>> As a side note: i suspect that "newer" Dell machines use a different in=
terface for controlling
>> battery charging, since the Dell Power Manager software on my machine s=
eems to provide some
>> additional features not found in this token-based interface.
> Dell has released documentation of some other API, see the end of this f=
ile
> https://github.com/dell/libsmbios/blob/master/src/bin/smbios-battery-ctl
>
>> Unfortunately i am not sure if reverse-engineering the Dell software is=
 legal, does the kernel
>> community have some helping guides in this area? If it is legal, then i=
 would happily volunteer
>> to do the reverse-engineering.
> That is questionable. Some kernel drivers were written from reverse
> engineered data in past.
>
> Note that in some countries is reverse engineering legal if it is done
> for interoperability purposes (which this one could match).
>
>> Otherwise maybe someone at Dell can provide some clarifications if a di=
fferent interface for controlling
>> battery charging exists and how to use it?
> Try to send an off-list/private email to Dell.Client.Kernel@dell.com
> with details for what you are asking. Maybe they would have access to
> some new documentation.
>
I received no response to the email i send to Dell.Client.Kernel@dell.com,=
 so i started reverse-engineering
the Dell software which is used to control the battery charge settings.

My findings (as for now) are:

- there exists an extended battery control interface where the charge mode=
 can be set for each individual battery
- this extended interface uses the Dell SMBIOS calling interface together =
with some extensions
- the interface has a design flaw which makes it impossible to reliably su=
pport hot-swap batteries (thanks Dell!)
- the extended interface might only be supported on WMI-capable machines, =
but i need to verify this

I will need some more time for reverse-engineering the whole interface, bu=
t i believe adding support for it should
be possible.

For now, i think this patch series is the way forward.

Thanks,
Armin Wolf

>> Thanks,
>> Armin Wolf
>>
>>>> In the kernel, we're registering the acpi_battery_hook as "Dell Prima=
ry
>>>> Battery Extension". The functions set up by that acpi_battery_hook ar=
e
>>>> the only ones using battery_support_modes. We could make it more expl=
icit
>>>> by:
>>>> 1) renaming it to primary_battery_modes, along with
>>>> dell_primary_battery_{init,exit} and/or
>>>> 2) allocating the mode mask and strings dynamically, and storing that
>>>> inside of the dev kobject.
>>>>
>>>> However, #2 seems overly complicated for what we're doing. In the
>>>> circumstances that we want to add support for secondary batteries,
>>>> we're going to need to query separate tokens, add another
>>>> acpi_battery_hook, and also add a second mask. Whether that's a globa=
l
>>>> variable or kept inside pdev seems like more of a style issue than
>>>> anything else.
>>>>
>>>> #1 is easy enough to change, if you think that's necessary.
>>> I think that "Dell Primary Battery Extension" is OK. All SMBIOS code i=
s
>>> currently primary-battery only.
>>>
>>> The only my point is to prevent this &dell_battery_hook to be register=
ed
>>> for non-primary battery.
>>>

