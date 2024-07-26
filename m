Return-Path: <linux-pm+bounces-11443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F60193D888
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 20:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53D3B21355
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD7133CC4;
	Fri, 26 Jul 2024 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="VVTIzdZg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432DC3032A;
	Fri, 26 Jul 2024 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019611; cv=none; b=M/vKn1UKiVu0rN95xI2FTcwxip5pVEDyA9Y9KZrqKtgKXNRMWtDV7zknmXLpar0tiDYTEcENrJzLfKVXCjtYIhcuEFMnyMv39Ak3psoi3wuuM9+tVTX2hlmUjf2SDS0HYHvHXOAwBcto3Hypwp8pwxVfRt9ki3TzDyRWj45EGqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019611; c=relaxed/simple;
	bh=J+xl3Z+UAWgFBCGwIgsGabOuk/jS6OeF3g7UKaL7Ncg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ELm7/sayFsNIrlGbWr6vRb2Tws5JezZp51KDpVyOScmHVruY4MlBuDWoVmwd4EHWsR3hkJ8qwPqsSO60qqE3PSL4dE67yw8v2JXdju+RyeL4XMRAhrToWi8O0+SN77Fo0eoBKH+JqatQtkGf5L6owWWCCdUoJ6zNr+VtMnr2xpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=VVTIzdZg; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1722019587; x=1722624387; i=w_armin@gmx.de;
	bh=yqAr4ZDzpG0PehiJt9d0a8FTYMRJn1THifPggGv6zkY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VVTIzdZg2i5UFmH8ao/0AzfCbbCEVnrPo50MNA/a316JXSglvts6gi0Vi4soXvzf
	 +FBh9maqKN3SGhY4y7HTwvIESK+aWiuKs4jQduuAJ10/BH4zpo+1rhus6WqnBmJ6H
	 lMIp6vacaQKgmDfzjj8bp0C8FkDtjDV9NtvA7kOfo6NqvponakHyXUrtjB8g2Vm2g
	 EH+48sN4AVC1GQYFRei+ukoZpL1gI5V2r8owPSKxNT8OIj06q17P2SrQRBgROvLDU
	 ynq2emhgF6maigyii+IQ9Mi6DwU/Exo8jhJz2BFRDcUUKZxt0yJOxSfjWXbgxiDlW
	 xdwuzHM7Nu426sr6hA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQnF-1sW0nW0p1p-004HwH; Fri, 26
 Jul 2024 20:46:27 +0200
Message-ID: <5cfe4c42-a003-4668-8c3a-f18fb6b7fba6@gmx.de>
Date: Fri, 26 Jul 2024 20:46:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
From: Armin Wolf <W_Armin@gmx.de>
To: Andres Salomon <dilinger@queued.net>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Matthew Garrett <mjg59@srcf.ucam.org>, Sebastian Reichel <sre@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
References: <20240723220502.77cb0401@5400>
 <20240724203403.zcrx2lshbla3o2gp@pali> <20240724204523.xb6rp7ba6yqi5klt@pali>
 <20240724182318.66578a48@5400> <20240724230158.nsmxdgagfpanjtzi@pali>
 <20240725162457.34b480e1@5400> <20240725221511.mqb4tlam2r7yheoi@pali>
 <45c7c4c3-2f99-4ca0-9c85-a96a03ccfae8@gmx.de>
 <20240726000409.ejnvqkzco664q3zb@pali> <20240726002538.558a4a97@5400>
 <8fde7bae-b4e3-458e-8edc-22199f8bc7e2@gmx.de>
Content-Language: en-US
In-Reply-To: <8fde7bae-b4e3-458e-8edc-22199f8bc7e2@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V6J7qks7S2KQ74PO4KqnJExjptza6K7Ks/KjKXHnYQF52fz5RwY
 8Sb8exKUQd+LoM48tX9gx/e28cp9VPV5rLLxIleKJDXzS8joDXw1vpuRJ/RggrRf0zlSGYE
 dsk+XEMAH3qDNBX1DRV/++fz8ga9OqtjcArVr4Zd6dP3DsCDvnA3vV8YXyFGrj6i5C2BY2G
 ufLSkBUqRuh8ThHf3e+vw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Mml7q4va/a0=;LCIsKFskO+aL7dbmNFWqI9FnaSH
 U5XI7c7+ymEz10n+ElPomXhPKNgV+sw/smj2wzGogZRHrYxouMaBAlqbqJKsNe2NJ437aEXd9
 itA8PjOaaC2YVg5yilzQvceE0TA/156z5mWxiKE9nGKDLLNUF33Ss1RgK1apYTIpsQ9nziO6h
 oNxxIsg+w4eFcFx9v1sjetQj/HI2pkWGWkfxZduvBccbUwby1TKJ1vMTWpNykeOaGdRo/Tllp
 WLYrvgW6fTLbOpVaYEpvJbVI2/jmwN53spM4m8YjI/CaSzT2k533BDH+lrbsBIAGaCC+cwWA+
 2/c6FFGtRWwKZh3cQGS+Z3GB6NwGfk5IGmxxrNuCZ8bPLyijAA4RY2jl92iOqSAmhomz/Cwuw
 mUCleqEVuu+aQATyW/uWZnJHec08D7um0M8E0RAf0Vabz/qyvySwD2Yb1ivCVRuS+cuc2uxFe
 YXRoxxk/xuUVwjes6x5n3SYZJmSIC5XFAWLLvffGP2Xbbr4UwnPXHEPmtdLHVexjxXhwIIF7m
 ID4SgXNTT7MhfMEebm/E709Tb65LtuAU7NKnXyfBwKgJPvQ7QYDMZRPUNrqtAM9venceNew0e
 iuS9//zr0YSHvV3/3GYTqZpB5j3QcUkC7WQhyMYkdsAuublZOcYJvYHbke3N9EWfRzgeHUHhu
 B+9m9emvMtzYrB22G7iwX1GyI24LSSHx43m1zo8hlgFg4MnQg3O+cPhVW7c045nhZybie4KH6
 za7MQjf5akzAwhWPCSuDJuxyJadoy+BA67574Jm1F2yCNzygdxJ/PFArn3W/C5bB+sOaIggyW
 mlFp+QyYpXMNbtstLdPZEXOQ==

Am 26.07.24 um 20:42 schrieb Armin Wolf:

> Am 26.07.24 um 06:25 schrieb Andres Salomon:
>
>> On Fri, 26 Jul 2024 02:04:09 +0200
>> Pali Roh=C3=A1r <pali@kernel.org> wrote:
>>
>>> On Friday 26 July 2024 01:48:50 Armin Wolf wrote:
>>>> Am 26.07.24 um 00:15 schrieb Pali Roh=C3=A1r:
>>>>
>>>>> On Thursday 25 July 2024 16:24:57 Andres Salomon wrote:
>>>>>> On Thu, 25 Jul 2024 01:01:58 +0200
>>>>>> Pali Roh=C3=A1r <pali@kernel.org> wrote:
>>>>>>
>>>>>>> On Wednesday 24 July 2024 18:23:18 Andres Salomon wrote:
>> [...]
>>>>>>> The issue here is: how to tell kernel that the particular
>>>>>>> dell_battery_hook has to be bound with the primary battery?
>>>>>>>
>>>>>> So from userspace, we've got the expectation that multiple batterie=
s
>>>>>> would show up as /sys/class/power_supply/BAT0,
>>>>>> /sys/class/power_supply/BAT1,
>>>>>> and so on.
>>>>> Yes, I hope so.
>>>>>
>>>>>> The current BAT0 entry shows things like 'capacity' even without
>>>>>> this
>>>>>> patch, and we're just piggybacking off of that to add charge_type
>>>>>> and
>>>>>> other entries. So there shouldn't be any confusion there, agreed?
>>>>> I have not looked at the battery_hook_register() code yet (seems
>>>>> that I
>>>>> would have to properly read it and understand it). But does it
>>>>> mean that
>>>>> battery_hook_register() is adding hook just for "BAT0"?
>>>>>
>>>>> What I mean: cannot that hook be registered to "BAT1" too? Because i=
f
>>>>> yes then we should prevent it. Otherwise this hook which is for "Del=
l
>>>>> Primary Battery" could be registered also for secondary battery
>>>>> "BAT1".
>>>>> (I hope that now it is more clear what I mean).
>>>> Hi,
>>>>
>>>> the battery hook is being registered to all ACPI batteries present
>>>> on a given system,
>>>> so you need to do some manual filtering when .add_battery() is called=
.
>>> Ok. So it means that the filtering based on the primary battery in
>>> add_battery callback is needed.
>>>
>> Thanks for the explanations. Seems simple enough to fix that, as some o=
f
>> the other drivers are checking battery->desc->name for "BAT0".
>>
>>
>> One thing that I keep coming back to, and was reinforced as I looked at
>> include/linux/power_supply.h; the generic power supply charge_type has
>> values that are very close to Dells, but with different names. I could
>> shoehorn them in, though, with the following mappings:
>>
>> POWER_SUPPLY_CHARGE_TYPE_FAST,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D> "express" (aka ExpressCharge)
>> POWER_SUPPLY_CHARGE_TYPE_STANDARD,=C2=A0=C2=A0=C2=A0=C2=A0 =3D> "standa=
rd"
>> POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,=C2=A0=C2=A0=C2=A0=C2=A0 =3D> "adapti=
ve"
>> POWER_SUPPLY_CHARGE_TYPE_CUSTOM,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D> "custom"
>> POWER_SUPPLY_CHARGE_TYPE_LONGLIFE,=C2=A0=C2=A0=C2=A0=C2=A0 =3D> "primar=
ily_ac"
>>
>> The main difference is that Primarily AC is described and documented as
>> slightly different than Long Life, but I suspect the result is roughly
>> the same thing. And the naming "Fast" and "Long Life" wouldn't match th=
e
>> BIOS naming of "ExpressCharge" and "Primarily AC".
>>
>> Until now I've opted to match the BIOS naming, but I'm curious what
>> others
>> think before I send V3 of the patches.
>
> I agree that POWER_SUPPLY_CHARGE_TYPE_FAST should be mapped the
> ExpressCharge,
> but i think that "primarily_ac" should become a official power supply
> charging mode.
>
> The reason is that for example the wilco-charger driver also supports
> such a charging mode
> (currently reported as POWER_SUPPLY_CHARGE_TYPE_TRICKLE) and the
> charging mode seems to be
> both sufficiently different from
> POWER_SUPPLY_CHARGE_TYPE_LONGLIFE/POWER_SUPPLY_CHARGE_TYPE_TRICKLE
> and sufficiently generic to be supported by a wide array of devices.
>
> Thanks,
> Armin Wolf
>
I just read the documentation regarding the charge_type sysfs attribute an=
d it states that:

Trickle:
	Extends battery lifespan, intended for users who
	primarily use their Chromebook while connected to AC.

So i think that "primarily_ac" should be mapped to POWER_SUPPLY_CHARGE_TYP=
E_TRICKLE.

Thanks,
Armin Wolf


