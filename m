Return-Path: <linux-pm+bounces-11441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8FE93D873
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 20:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816BF2859F9
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 18:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B503D3B8;
	Fri, 26 Jul 2024 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="JW+Wax8E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CC23032A;
	Fri, 26 Jul 2024 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019374; cv=none; b=XK3rsacynS8nVAMT4PfdQXju2AoXrCbfU1grtDG0T9knddF/IPy1NP1EXThhoDA6DDzzYL9iphGoAN4gjR2HlPQbbDYv/vJSLnYU3APMysGk3bsZ+/J4KmaVE3+LyXYHO0mE7+8ytrw3mtNRLIRhljVx0324mog6AVMzY9l+cJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019374; c=relaxed/simple;
	bh=x5ZH7f1gyMXIZq/0/VN8//jwDAixwcpDKNRXC++wjik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kk5khT6HMdQyGW+NkQtZNz7wxqd9Vkupr6jn2UmeezWKiOKnNPkbi8TtMkaG6HH5txXr+1p3P8h9IL4PNbWk0QbhJQvJom+C3WeiFC575Y4d9zWy0LeuaZLJofWB3bGio2PL7tHC+hHXAbU/SO1StiPltM+KWOrGmPotF9xAQoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=JW+Wax8E; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1722019350; x=1722624150; i=w_armin@gmx.de;
	bh=2UN0cDi25KjXv8ixqvaqlCV0jKZUH4m9tkAbl5UaWRQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JW+Wax8EfGm0eYfG0GwC7sjzJbLniMJRvhKp+WrdWB+NjP79HI6474gl1a9XREo6
	 ZyZEuvtcpZauHU2xPcnKXyDQKhpRPqlWBStRU0+ZM1Pa0YKA4otmouPIG19ks70bn
	 lbFO6z7d6wAXlkcwynlluDSxJfjpTScbbvgtykyoBNn8a0urW2AAS33leZ6/BJYfu
	 0EGzVPNAMYKUUgctHr/MBTWmZqYWQDNvidYg12Ex95H2S8mKBO5mWgSoj0Blwx+6q
	 XLH9cGM4tp11SFitShoo/UwbPBxwww118Brm75nglzaUizmyjfPyXu6PcYou6tIc8
	 Hij0AC5TmOX2MVIz5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lcJ-1sWagP16zj-00Ddur; Fri, 26
 Jul 2024 20:42:30 +0200
Message-ID: <8fde7bae-b4e3-458e-8edc-22199f8bc7e2@gmx.de>
Date: Fri, 26 Jul 2024 20:42:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
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
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240726002538.558a4a97@5400>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CfQzfmXTSlXBiuM33eqyB2kUGSKMzHjsPHK7n2se9Cu872pQuqh
 XI0F/AC0cvxR+Uu1l8KixvtdthMFf0sjRAbAwv4V/z9ipfWX8CH8xizO5taXHWqGm5Hu1t6
 Fl5jUwaNzO+IkhQ22/32/43MNtqhSfJ+LIjxj7Rd9co1+BBPhw44IixlIR+pUyJqmSW+iEY
 sx0g8M89QyO/E/AcmaeSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vdk6nTULoGc=;RwXI471Le7VA9M7Dge5uPk1M/ft
 VrCcI67j1EkrA9LmAPTRVa41wzk74rC10BkuKkp5xhIU3aEqMIBe4h146e/F7MySiAOUDKCi+
 XRe75G51zK7YXpKKRNZ3M3VKOZcckfcq7cwcmtSVqF7y0Io3vgRyr6uUuyHpEAjzICfMN/ekJ
 b4iZp81Qb8BtaO8W9q5cPlyZEyPpWFALDkmPVlwvP8BcMAzlsmRfOyIEjHc5dWoMLWI/yyzn7
 KSiP0aa1WZa7pAkwq/TcAYifG+JfDOvWsxAwxCUEiGqAk+oBTI+Jm68uxjXKiihRBXY6b8AD3
 2ovBua6r4Gudyic0y5ZTAoJzKtSZHN4TGN/o+GgTHP1s/2uFcSaf43NGOe7s6Qa1qjDlJ/SvV
 ZoO35tV+QodF4lqMrjY+nZMgKH70UtFDxs9phxzzdi5QdXM3USPcs2YhBflXyzE+aU/74Vbu3
 cFMqnnCLwsH8IdKSVJSl4lHe22qk9xYHwgzK5Px9op6L18o6B6HWDi4l5yxBzUs1HEXAwcGjW
 D02Y/HSrEzJIO8r02mEME0N42zcWWVJh0FPaCn1kdlkBJWGh54qCc6mIhqIiWEpcik9LB+3wq
 5Hy0CrKuczBE/LRrPz2oMmM7d4s69hxLjd49MgGqdDd7aqeGXDdG04GU4Wza85BrEf6vUawII
 wYxHs3p4IdgywNjgJMW3/Ufq3DFs+Oi19lIwhOjoh2R5PF8iTLbAY7d11CwjuNjls73U5O0wJ
 CvXxQQTnWDxFALke8wm4Y9Af3ic6E2hk3TqZjrergEUIGhPeuRit2EjxX6ccYyheq1DA4xx1q
 9YJiHKt3eC4s0T9O5Sxhtl/g==

Am 26.07.24 um 06:25 schrieb Andres Salomon:

> On Fri, 26 Jul 2024 02:04:09 +0200
> Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
>> On Friday 26 July 2024 01:48:50 Armin Wolf wrote:
>>> Am 26.07.24 um 00:15 schrieb Pali Roh=C3=A1r:
>>>
>>>> On Thursday 25 July 2024 16:24:57 Andres Salomon wrote:
>>>>> On Thu, 25 Jul 2024 01:01:58 +0200
>>>>> Pali Roh=C3=A1r <pali@kernel.org> wrote:
>>>>>
>>>>>> On Wednesday 24 July 2024 18:23:18 Andres Salomon wrote:
> [...]
>>>>>> The issue here is: how to tell kernel that the particular
>>>>>> dell_battery_hook has to be bound with the primary battery?
>>>>>>
>>>>> So from userspace, we've got the expectation that multiple batteries
>>>>> would show up as /sys/class/power_supply/BAT0, /sys/class/power_supp=
ly/BAT1,
>>>>> and so on.
>>>> Yes, I hope so.
>>>>
>>>>> The current BAT0 entry shows things like 'capacity' even without thi=
s
>>>>> patch, and we're just piggybacking off of that to add charge_type an=
d
>>>>> other entries. So there shouldn't be any confusion there, agreed?
>>>> I have not looked at the battery_hook_register() code yet (seems that=
 I
>>>> would have to properly read it and understand it). But does it mean t=
hat
>>>> battery_hook_register() is adding hook just for "BAT0"?
>>>>
>>>> What I mean: cannot that hook be registered to "BAT1" too? Because if
>>>> yes then we should prevent it. Otherwise this hook which is for "Dell
>>>> Primary Battery" could be registered also for secondary battery "BAT1=
".
>>>> (I hope that now it is more clear what I mean).
>>> Hi,
>>>
>>> the battery hook is being registered to all ACPI batteries present on =
a given system,
>>> so you need to do some manual filtering when .add_battery() is called.
>> Ok. So it means that the filtering based on the primary battery in
>> add_battery callback is needed.
>>
> Thanks for the explanations. Seems simple enough to fix that, as some of
> the other drivers are checking battery->desc->name for "BAT0".
>
>
> One thing that I keep coming back to, and was reinforced as I looked at
> include/linux/power_supply.h; the generic power supply charge_type has
> values that are very close to Dells, but with different names. I could
> shoehorn them in, though, with the following mappings:
>
> POWER_SUPPLY_CHARGE_TYPE_FAST,         =3D> "express" (aka ExpressCharge=
)
> POWER_SUPPLY_CHARGE_TYPE_STANDARD,     =3D> "standard"
> POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,     =3D> "adaptive"
> POWER_SUPPLY_CHARGE_TYPE_CUSTOM,       =3D> "custom"
> POWER_SUPPLY_CHARGE_TYPE_LONGLIFE,     =3D> "primarily_ac"
>
> The main difference is that Primarily AC is described and documented as
> slightly different than Long Life, but I suspect the result is roughly
> the same thing. And the naming "Fast" and "Long Life" wouldn't match the
> BIOS naming of "ExpressCharge" and "Primarily AC".
>
> Until now I've opted to match the BIOS naming, but I'm curious what othe=
rs
> think before I send V3 of the patches.

I agree that POWER_SUPPLY_CHARGE_TYPE_FAST should be mapped the ExpressCha=
rge,
but i think that "primarily_ac" should become a official power supply char=
ging mode.

The reason is that for example the wilco-charger driver also supports such=
 a charging mode
(currently reported as POWER_SUPPLY_CHARGE_TYPE_TRICKLE) and the charging =
mode seems to be
both sufficiently different from POWER_SUPPLY_CHARGE_TYPE_LONGLIFE/POWER_S=
UPPLY_CHARGE_TYPE_TRICKLE
and sufficiently generic to be supported by a wide array of devices.

Thanks,
Armin Wolf


