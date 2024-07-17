Return-Path: <linux-pm+bounces-11220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A25093451E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 01:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEA71F2220C
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 23:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9918E4D8BA;
	Wed, 17 Jul 2024 23:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="Y/9pS4Q9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACF4947E
	for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721259993; cv=none; b=XAabbvB3KF5v4PMRIKYIqyC4YEIRW8V4s9hn1qX87nZIJPHLESBXoZRN2xXrK/76UOzhqqqLlKVZ1OQsyMzHVrS/y56drp0fERGoKwVQj2UEZ1R1uB7I7s4DMIon/FAWaUjNNMEiwuWdmiOr/vGZumptPzjEXZyaXDAKry6g1a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721259993; c=relaxed/simple;
	bh=BYBe7GCWh1mxQcGSZIilFN44Jf6SBePPgzECZbyRpfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8ei0hRLnYJpX9FzSblzFM+kBblexXFbllp/SFK6s0BMQZwG63XpeiZFJoDwxUdndDOPXlzqzWrRGQwgP31V8c7Q6Bw8y3jQfN7e/Gpi0VvkUq566Lf5wlwFR7S8SZUQ5WsBEvt5sFtJePsEZTT/pSjEvOcvExbF0CRAjEf1Hh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=Y/9pS4Q9; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.80.67] (unknown [207.7.121.250])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4WPXdc431lz4Dsh;
	Wed, 17 Jul 2024 19:46:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1721259989; bh=BYBe7GCWh1mxQcGSZIilFN44Jf6SBePPgzECZbyRpfE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y/9pS4Q9erzr7k6rvRInRJVcVZUfXO4afPrA7yK6O5kiQj4ktuVOIcPhwddkbP1o1
	 UXYAzRX4pDNEu1eDGxmUUg/LD0COm7/637W2yz7+Drr/xuz/AgpCjYpk8CR5loYtXT
	 sIlZfCACIKnCv/H9kgEgIzS+cjHY0NyeIE/qbBEo=
Message-ID: <bff3e11e-7b60-4e23-933a-3e84fd82aabc@panix.com>
Date: Wed, 17 Jul 2024 16:46:27 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Kenneth Crudup <kenny@panix.com>
Cc: vidyas@nvidia.com, bhelgaas@google.com, andrea.righi@canonical.com,
 vicamo.yang@canonical.com, linux-pm@vger.kernel.org
References: <218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com>
 <1c6a9a8c-a6f-c884-7d58-5c713b1d77d7@panix.com>
 <CAAd53p70Hkv6vaim0HOncSQGBPO83f4QOGLE869T+4WKWdLjBw@mail.gmail.com>
 <0481ec61-3a57-4b4b-a0d8-b8b523af3f17@panix.com>
 <CAAd53p7NpwK11AyMtAOiFxAEJ8Ho=V=93gwje_2j=h3a=L5G9Q@mail.gmail.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <CAAd53p7NpwK11AyMtAOiFxAEJ8Ho=V=93gwje_2j=h3a=L5G9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Seems to be working OK, I do think running power states seem to be 
spending more time in pc10/cpuLPI/SysLPI, but that's just 
seat-of-the-pants though.

While-suspended battery drain seems about the same, however:

----
[E130] 518 /home/kenny> cat /tmp/battery-levels
suspend-in:  Wed, 17 Jul 2024 09:33:33 -0700
/sys/power/wakeup_count:46
/sys/power/suspend_stats/success:0
/sys/class/power_supply/BAT0/charge_full:3882000
/sys/class/power_supply/BAT0/capacity:100
/sys/class/power_supply/BAT0/voltage_now:12856000
/sys/class/power_supply/BAT0/status:Full
/sys/class/power_supply/BAT0/capacity_level:Full
/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us:0
/sys/kernel/debug/pmc_core/slp_s0_residency_usec:0
----------
suspend-out: Wed, 17 Jul 2024 16:38:37 -0700
/sys/kernel/debug/pmc_core/slp_s0_residency_usec:0
/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us:0
/sys/class/power_supply/BAT0/charge_full:3882000
/sys/class/power_supply/BAT0/capacity:89
/sys/class/power_supply/BAT0/voltage_now:12206000
/sys/class/power_supply/BAT0/status:Discharging
/sys/class/power_supply/BAT0/capacity_level:Normal
/sys/power/suspend_stats/success:1
/sys/power/wakeup_count:52
==================================================

[17/16:44:11 kenny@xps-9320]
----

On 7/16/24 18:59, Kai-Heng Feng wrote:
> Hi Kenneth,
> 
> On Tue, Jul 16, 2024 at 2:27 AM Kenneth Crudup <kenny@panix.com> wrote:
>>
>>
>> No joy yet for 6.10, so here's my patches, maybe it'll save someone some
>> time (they're pretty much the same as 6.9) .
>>
>> Fingers crossed for 6.11!
> 
> I forgot to Cc you when I sent the patch [0].
> 
> It will be great if you can test it out.
> 
> [0] https://lore.kernel.org/linux-pci/20240530085227.91168-1-kai.heng.feng@canonical.com/
> 
> Kai-Heng
> 
>>
>> -Kenny
>>
>> On 3/21/24 03:12, Kai-Heng Feng wrote:
>>> Hi Kenneth,
>>>
>>> On Tue, Mar 12, 2024 at 10:37 AM Kenneth R. Crudup <kenny@panix.com> wrote:
>>>>
>>>>
>>>> On Sat, 4 Nov 2023, Kenneth R. Crudup wrote:
>>>>
>>>>> The only release kernel that was able to get this laptop to fully get into
>>>>> low-power (unfortunately only s0ix) was the Ubuntu-6.2.0- ... series from Ubuntu
>>>>
>>>>> I'd bisected it to the following commits:
>>>>> 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for suspend/resume
>>>>> 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register programming
>>>>> 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD domain
>>>>> 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind VMD
>>>>> 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name instead
>>>>
>>>> Since (for what I'm sure is a good reason ... I hope :) ) this has yet to make
>>>> it into mainline, here's the set of commits refactored for v6.8; maybe someone
>>>> scanning the archives for a solution to their Dell draining too much power can
>>>> use them.
>>>>
>>>> But is there anything I can do to help these go in? I saw that "Refactor L1
>>>> PM Substates Control Register programming" is still reverted, is that still
>>>> an issue on the machine it affected?
>>>
>>> Let me work on this.
>>>
>>> I think both VMD and Thunderbolt devices need ASPM enabled by default
>>> regardless of BIOS setting, but I am not sure if PCI folks will like
>>> the idea.
>>>
>>> Kai-Heng
>>>
>>>>
>>>>           -Kenny
>>>>
>>>> --
>>>> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
>>>
>>
>> --
>> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange
>> County CA
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

