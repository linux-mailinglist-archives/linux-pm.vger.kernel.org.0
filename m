Return-Path: <linux-pm+bounces-8811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7A59012BF
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 18:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069EE282354
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAB517A92C;
	Sat,  8 Jun 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qV4JeyJR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4061FC5;
	Sat,  8 Jun 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717864047; cv=none; b=Ochi+wjWL+MY0xHPzxLc3YgNdPQJbY5cxPjrxIQluD3uxPkIQNmvaYwB2Wdi27WgJugKf5H8pD9Ev1f3jNQd506EWKRzoEs7inyCFORZY7LSiV5M6AU0lCURbPwAj41OwT2CaU62I1JLkXFCgjfAQSWNI171ni9vc8kJQoHmJjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717864047; c=relaxed/simple;
	bh=4AP+uZdUJqdnDDKphWx/Fxmr/zRPvWllf+uUvcU/6Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBrz/jA9m9isE0lmQBnnsjX8iLmFBi1H/nmHOytljP7Wr7djE23WP+41YsJWwhhL0H+3IjySgvnEsQ8ekKdrUbuZ1phArXHrPMBCqyr4yfkM3fjOjb+mN3IvkiB5gZXh2stH007yAcnN1XPLeTo5GuQsU3mGr+ZninoVz8Gdwpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qV4JeyJR; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717864030; x=1718468830; i=w_armin@gmx.de;
	bh=Z6KgVHDjOSvO3PJ3xAOgeNTDQVx25j0SF0gxQxw/NcY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qV4JeyJR4EFaU3DWTFemSDqnpnC7pmgOMJAkA9gP6PiYZ7IOR27jjM4vy4SibvxI
	 JCRDGu/p4SlPPs143+HKkVmDTlhXU/YfJd/i9WpxeEBfy0FSFBKSuDYDYRj+57Rl8
	 hsmaU9raMGmb9s0Vo03DvQ0H2gK7w61slcy/qisOFz+DoL8doczjL2c8+SX/Ohf/B
	 UcjTNeDNrei1u7pWaqe6569qOtLYnCQFWkUxFM6+JSp4Qmut5s1v3Na/xxYvry/5f
	 rPpblWVpEooLKAYe4UJaos16Hai+snJmK7Z+CW6x5FmKJAg1TzJvywTkllpaeJWfZ
	 KFRdE6ofv/lefXCY8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([91.137.126.34]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My36T-1sdrAv1HuJ-00xg6Z; Sat, 08
 Jun 2024 18:27:10 +0200
Message-ID: <992978fb-d74c-4da7-a103-9b623b78d889@gmx.de>
Date: Sat, 8 Jun 2024 18:27:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/6] power: supply: extension API
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>, Jeremy Soller <jeremy@system76.com>,
 System76 Product Development <productdev@system76.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net>
 <41964782-222c-45fa-846e-3656eff5b3a9@gmx.de>
 <86cafef5-8a41-46c8-8ee6-6b25dd165b58@t-8ch.de>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <86cafef5-8a41-46c8-8ee6-6b25dd165b58@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GOyTqoSSFp1ivbCO+MvAe/yrqU6GuASswCXiIsIxaGPT3tH1BmH
 ZR4PxwKT1ldI07fUCimqtHEZ2jxOSDhVeRBRZ40JXg5wiGawsxCPEI0CL+hrzsYPQoOvm0T
 J4rEDVeLdlfpMwKSOVisNf1xHgjTdPq+OSlLsLM2WB3/GVmYu3nSydyV44mCHZZ/1cTZ0Co
 LOVUdwM2pPMV1UbRAnDPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A8fMnGVG5Sc=;xZVYy731RS9p8z+T2Ro4LoxQkfR
 IbA4yD3Y3t75uMzsXhtFQDLGwgJ3MFhvyyzjPxsnJlqHI6MDc3inPFEhynl+ceFQF3q1w4Fb6
 ruTpdt4b2VNJ5qQOVxOVxuICQYnuuIfj8f1+JKoDhnv+W2/p9yj0zql8N224aN9RzoA4B5FZD
 4sEMTNqcdxvXkK87K91w5CEGS+dTfNX7USInZr7Ugqlr50Zl6TPoibqYyXjP9tD3anqD5hjrN
 WGYEJuA4MNwGtde0lu/hvVn579i1V5TIAkL3wS2rUcVnXt2VBKYOmw24mngGzcWEz7WGJG31n
 NZeGMmZVM5RHyLb0nPWjCZzJtJ5I7A4NIn1pFJsJqEbswwsDiFvVMmvYWlKJxyTnKJ/yZswQM
 LJkNdEkkxeY4hN0si1njTPPsd/ihuqdG+1Atla+tRPv1E3RHFuD8JDEfQGihTug7Q7rYgZObb
 IbsNLo8/rLxppB8Z9HIK/0GCMcCsVPZFAgar6CySyEjllTj/CopSernpz0BWOGzVBvloy2H2r
 3FHSuWBoH5oD5YF67h9KoD3JLtKHUCWHFvx6PwycTNBZ/crRKWYlqpOUIEnQFsYr2pj3hQAjm
 GwNGUgfWmdOAN9pDjeLruBWjCuKb3rsgJ+ATWJrgS6KRME6hJeZgTsGYtG8AXe7SPxnRm/+/O
 QBXgvuFXKYWNJDTP1UVjl1mHoO3HEskDwlO8o2JQKnbmtwzqSA2pVVcXs+GpI8etHPEWKrR1t
 E1xJzmP1ie0pFmx9Bbdb8Iz1MjopEBWnaWLelRQr7hJigOOeZ5gh5JhAID7l/hlypNlz1jXlt
 wTIfzj6je6RWoQH3hCMjc/wnpbkWVleeHSuZMKMGSRhho=

Am 07.06.24 um 12:26 schrieb Thomas Wei=C3=9Fschuh:

> On 2024-06-07 01:10:02+0000, Armin Wolf wrote:
>> Am 06.06.24 um 16:50 schrieb Thomas Wei=C3=9Fschuh:
>>
>>> Introduce a mechanism for drivers to extend the properties implemented
>>> by a power supply.
>>>
>>> Motivation
>>> ----------
>>>
>>> Various drivers, mostly in platform/x86 extend the ACPI battery driver
>>> with additional sysfs attributes to implement more UAPIs than are
>>> exposed through ACPI by using various side-channels, like WMI,
>>> nonstandard ACPI or EC communication.
>>>
>>> While the created sysfs attributes look similar to the attributes
>>> provided by the powersupply core, there are various deficiencies:
>>>
>>> * They don't show up in uevent payload.
>>> * They can't be queried with the standard in-kernel APIs.
>>> * They don't work with triggers.
>>> * The extending driver has to reimplement all of the parsing,
>>>     formatting and sysfs display logic.
>>> * Writing a extension driver is completely different from writing a
>>>     normal power supply driver.
>>> * Properties can not be properly overriden.
>>>
>>> The proposed extension API avoids all of these issues.
>>> An extension is just a "struct power_supply_ext" with the same kind of
>>> callbacks as in a normal "struct power_supply_desc".
>>>
>>> The API is meant to be used via battery_hook_register(), the same way =
as
>>> the current extensions.
>>>
>>> For example my upcoming cros_ec charge control driver[0] saves 80 line=
s
>>> of code with this patchset.
>>>
>>> Contents
>>> --------
>>>
>>> * Patch 1 and 2 are generic preparation patches, that probably make
>>>     sense without this series.
>>> * Patch 3 implements the extension API itself.
>>> * Patch 4 implements a PoC locking scheme for the extension API.
>>> * Patch 5 adds extension support to test_power.c
>>> * Patch 6 converts the in-tree platform/x86/system76 driver to the
>>>     extension API.
>>>
>>> Open issues
>>> -----------
>>>
>>> * Newly registered properties will not show up in hwmon.
>>>     To do that properly would require some changes in the hwmon core.
>>>     As far as I know, no current driver would extend the hwmon propert=
ies anyways.
>>> * As this is only useful with the hooks of CONFIG_ACPI_BATTERY, should
>>>     it also be gated behind this or another config?
>>> * Only one extension can be used at a time.
>>>     So far this should be enough, having more would complicate the
>>>     implementation.
>>> * Is an rw_semaphore acceptable?
>>>
>>> [0] https://lore.kernel.org/lkml/20240528-cros_ec-charge-control-v2-0-=
81fb27e1cff4@weissschuh.net/
>> Nice, i love this proposal!
> Good to hear!
>
>> I agree that the hwmon update functionality will need some changes in t=
he hwmon core to work,
>> but there would be at least one driver benefiting from this (dell-wmi-d=
dv). Maybe we can add
>> support for this at a later point in time.
> Surely. Alternatively we could re-register the hwmon device after an
> extension was added.
>
>> The possibility of registering multiple power supply extensions on a si=
ngle power supply will
>> be necessary to support battery charge control on Dell notebooks in the=
 future. This is because
>> there will be two drivers on Dell notebooks which register battery exte=
nsions: dell-wmi-ddv and
>> dell-laptop (when support for battery charge control is supported somed=
ay).
>>
>> How difficult would it be to support such scenarios? If its very diffic=
ult, then maybe we can implement
>> this later when the need arises.
> It's not really difficult. The problem is in the callback functions
> going from a 'struct power_supply' back to the correct extension struct
> for use with container_of() to access the drivers private data.
>
> But we can add a marker member to 'struct power_supply_ext' with which
> the callback can figure out which of the registered extensions is its
> own. Something like "led_hw_trigger_type" in the LED subsystem.

Maybe we can do the same thing as the battery hook API and just pass a poi=
nter to
the power_supply_ext instance to the callbacks. They then can use containe=
r_of()
to access the drivers private data if the struct power_supply_ext is embed=
ded
inside the private data struct.

>
> And some documentation about how conflicts are to be resolved.
>
> Thomas

Sound like a plan, i suggest that extensions be prevented from registering=
 with
a power supply containing conflicting properties or containing extensions =
with
conflicting properties.

As a side note, maybe there is a way to make power_supply_update_groups() =
available
for other power supply drivers? Afaik the ACPI battery driver would benefi=
t from this too.

Thanks,
Armin Wolf

>>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>>> ---
>>> Thomas Wei=C3=9Fschuh (6):
>>>         power: supply: sysfs: use power_supply_property_is_writeable()
>>>         power: supply: core: avoid iterating properties directly
>>>         power: supply: core: implement extension API
>>>         power: supply: core: add locking around extension access
>>>         power: supply: test-power: implement a power supply extension
>>>         platform/x86: system76: Use power_supply extension API
>>>
>>>    drivers/platform/x86/system76_acpi.c      |  83 +++++++++---------
>>>    drivers/power/supply/power_supply.h       |   9 ++
>>>    drivers/power/supply/power_supply_core.c  | 136 +++++++++++++++++++=
+++++++++--
>>>    drivers/power/supply/power_supply_hwmon.c |  48 +++++------
>>>    drivers/power/supply/power_supply_sysfs.c |  39 ++++++---
>>>    drivers/power/supply/test_power.c         | 102 +++++++++++++++++++=
+++
>>>    include/linux/power_supply.h              |  25 ++++++
>>>    7 files changed, 357 insertions(+), 85 deletions(-)
>>> ---
>>> base-commit: 2df0193e62cf887f373995fb8a91068562784adc
>>> change-id: 20240602-power-supply-extensions-07d949f509d9

