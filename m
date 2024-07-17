Return-Path: <linux-pm+bounces-11195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EB793360F
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 06:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5D71F220A7
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 04:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CE26FC7;
	Wed, 17 Jul 2024 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="le8iOK7H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C58628
	for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 04:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721191216; cv=none; b=TfDpAbhAIKmTHIY1/yT2vrOZOlwxbZVSI2oHcFmrNiTypSVPFntWkkC5zsQmXouwLbBsmVgD8nLLWjxP9kl2eJBd41GwQ4dPG4ivfBDDV10t+MwJ/lwpG7oQnmdKPsFYKXVNW7hsOaPSMj2Ys7h5T4RqxDfvwYjExUxNPoCnA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721191216; c=relaxed/simple;
	bh=k77KMcbS26ebFSq/dGyRTkkAKJWM/IGSqRLrEr/Yi68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4LnRSrD/MHm+pWGvq1mNNjeWXC2TnuKgJ1dZ0SpWhf5Xl9Q69kIGlJSoHFGAWNpaOwErUAWNTvHJ03JBkgs+r1Wpv+4Rl7nsbF/7Ms+77dLJvvvT8/TxOv3Po2vYJhIv2rUwOHjw/CrypeGBHararNFZNM/8DliG9zvDfg67ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=le8iOK7H; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.55.28] (ip174-65-98-148.sd.sd.cox.net [174.65.98.148])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4WP3By0ZJGzqhM;
	Wed, 17 Jul 2024 00:40:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1721191211; bh=k77KMcbS26ebFSq/dGyRTkkAKJWM/IGSqRLrEr/Yi68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=le8iOK7HBjNqhV/YqIXkpFmtiI5GjtS1+75I2u3/crdwpbXI4uoWQUIt9vhbtaOAE
	 4MJ6xmUg5uoOJM4uo464tTNbuOVPJtPjj7T5Ljt8BveHUKK1JX2AF12jt5UDD5H8O8
	 HWrRM/1Pg4IpVOivu7at9/6GfWb215Ep4EZhxafA=
Message-ID: <74f21e5a-3a0f-4096-90bf-ba36cab4e767@panix.com>
Date: Tue, 16 Jul 2024 21:40:08 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: vidyas@nvidia.com, bhelgaas@google.com, andrea.righi@canonical.com,
 vicamo.yang@canonical.com, linux-pm@vger.kernel.org
References: <218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com>
 <1c6a9a8c-a6f-c884-7d58-5c713b1d77d7@panix.com>
 <CAAd53p70Hkv6vaim0HOncSQGBPO83f4QOGLE869T+4WKWdLjBw@mail.gmail.com>
 <0481ec61-3a57-4b4b-a0d8-b8b523af3f17@panix.com>
 <CAAd53p7NpwK11AyMtAOiFxAEJ8Ho=V=93gwje_2j=h3a=L5G9Q@mail.gmail.com>
 <78abaf37-774f-4bbd-945a-2432d4ace5f8@panix.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <78abaf37-774f-4bbd-945a-2432d4ace5f8@panix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

So far, so good.

----
[E0] 502 /home/kenny> dmesg | fgrep -i aspm
[    0.156949] ACPI FADT declares the system doesn't support PCIe ASPM, 
so disable it
[    0.590419] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM 
ClockPM Segments MSI EDR HPX-Type3]
[    0.597007] acpi PNP0A08:00: FADT indicates ASPM is unsupported, 
using BIOS configuration
[    1.402419] pci 10000:e0:06.0: enable ASPM for pci bridge behind vmd
[    1.719570] pci 10000:e1:00.0: BIOS can't program ASPM, let OS control it
[16/21:37:27 kenny@xps-9320]
[E0] 503 /home/kenny> cat /tmp/battery-levels
suspend-in:  Tue, 16 Jul 2024 20:59:44 -0700
/sys/power/wakeup_count:9880
/sys/power/suspend_stats/success:0
/sys/class/power_supply/BAT0/charge_full:3882000
/sys/class/power_supply/BAT0/capacity:56
/sys/class/power_supply/BAT0/voltage_now:11690000
/sys/class/power_supply/BAT0/status:Discharging
/sys/class/power_supply/BAT0/capacity_level:Normal
/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us:13549469
/sys/kernel/debug/pmc_core/slp_s0_residency_usec:13549930
----------
suspend-out: Tue, 16 Jul 2024 21:37:15 -0700
/sys/kernel/debug/pmc_core/slp_s0_residency_usec:13549930
/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us:13549469
/sys/class/power_supply/BAT0/charge_full:3882000
/sys/class/power_supply/BAT0/capacity:55
/sys/class/power_supply/BAT0/voltage_now:11622000
/sys/class/power_supply/BAT0/status:Discharging
/sys/class/power_supply/BAT0/capacity_level:Normal
/sys/power/suspend_stats/success:1
/sys/power/wakeup_count:9884
==================================================

[16/21:37:49 kenny@xps-9320]
----

I'll have more info in the next few days.

-K

On 7/16/24 20:39, Kenneth Crudup wrote:
> 
> OK, I'll test it out. But in the meantime, I've seen this:
> 
> ----
> [E0] 502 /home/kenny> dmesg | fgrep -i aspm
> [    0.160156] ACPI FADT declares the system doesn't support PCIe ASPM, 
> so disable it
> [    0.591366] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM 
> ClockPM Segments MSI EDR HPX-Type3]
> [    0.597820] acpi PNP0A08:00: FADT indicates ASPM is unsupported, 
> using BIOS configuration
> [    1.375136] pci 10000:e0:06.0: enable ASPM for pci bridge behind vmd
> [    1.689608] pci 10000:e1:00.0: can't override BIOS ASPM; OS doesn't 
> have ASPM control
> [16/20:19:35 kenny@xps-9320]
> [E0] 503 /home/kenny>
> ----
> 
> IOW, it doesn't appear to override ASPM but I still see power savings.
> 
> Gimme a few and I'll let you know how it worked out.
> 
> -K
> 
> On 7/16/24 18:59, Kai-Heng Feng wrote:
>> Hi Kenneth,
>>
>> On Tue, Jul 16, 2024 at 2:27 AM Kenneth Crudup <kenny@panix.com> wrote:
>>>
>>>
>>> No joy yet for 6.10, so here's my patches, maybe it'll save someone some
>>> time (they're pretty much the same as 6.9) .
>>>
>>> Fingers crossed for 6.11!
>>
>> I forgot to Cc you when I sent the patch [0].
>>
>> It will be great if you can test it out.
>>
>> [0] 
>> https://lore.kernel.org/linux-pci/20240530085227.91168-1-kai.heng.feng@canonical.com/
>>
>> Kai-Heng
>>
>>>
>>> -Kenny
>>>
>>> On 3/21/24 03:12, Kai-Heng Feng wrote:
>>>> Hi Kenneth,
>>>>
>>>> On Tue, Mar 12, 2024 at 10:37 AM Kenneth R. Crudup <kenny@panix.com> 
>>>> wrote:
>>>>>
>>>>>
>>>>> On Sat, 4 Nov 2023, Kenneth R. Crudup wrote:
>>>>>
>>>>>> The only release kernel that was able to get this laptop to fully 
>>>>>> get into
>>>>>> low-power (unfortunately only s0ix) was the Ubuntu-6.2.0- ... 
>>>>>> series from Ubuntu
>>>>>
>>>>>> I'd bisected it to the following commits:
>>>>>> 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for 
>>>>>> suspend/resume
>>>>>> 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register 
>>>>>> programming
>>>>>> 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under 
>>>>>> VMD domain
>>>>>> 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints 
>>>>>> behind VMD
>>>>>> 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name 
>>>>>> instead
>>>>>
>>>>> Since (for what I'm sure is a good reason ... I hope :) ) this has 
>>>>> yet to make
>>>>> it into mainline, here's the set of commits refactored for v6.8; 
>>>>> maybe someone
>>>>> scanning the archives for a solution to their Dell draining too 
>>>>> much power can
>>>>> use them.
>>>>>
>>>>> But is there anything I can do to help these go in? I saw that 
>>>>> "Refactor L1
>>>>> PM Substates Control Register programming" is still reverted, is 
>>>>> that still
>>>>> an issue on the machine it affected?
>>>>
>>>> Let me work on this.
>>>>
>>>> I think both VMD and Thunderbolt devices need ASPM enabled by default
>>>> regardless of BIOS setting, but I am not sure if PCI folks will like
>>>> the idea.
>>>>
>>>> Kai-Heng
>>>>
>>>>>
>>>>>           -Kenny
>>>>>
>>>>> -- 
>>>>> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, 
>>>>> Orange County CA
>>>>
>>>
>>> -- 
>>> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange
>>> County CA
>>
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

