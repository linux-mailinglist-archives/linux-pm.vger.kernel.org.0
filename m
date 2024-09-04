Return-Path: <linux-pm+bounces-13509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D2996B10B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 08:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990AA1C238F1
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 06:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C827E84A46;
	Wed,  4 Sep 2024 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="XTrLsKM5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1EF84A5E;
	Wed,  4 Sep 2024 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430252; cv=none; b=VcSLG/NcJKMJeFARcX2soowSJYfJ7Qtw+xZhI8bImA/1DQM6FyPPiIJUSCLiS0+wIPPjicrJhlGbO8DYyjfAdgRATYnAAcEBV/2B0yKiqsTzQm0RK45xAJQYdhJz0WBbX0J2cUgVllbZ3Co6Nkf5+zBX56W835nijle5REZM9WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430252; c=relaxed/simple;
	bh=tT5xdBKyAffEoJ3EwqkwtBD3YsRNv2Iggt63GrMvxts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvbHUQ2nfm+u+R6HbY2DkUGp9zy00LmbNCnSaAe/ViuwgIg1RNWgCmm82cvbOM2tx/H+FWw9ve2qyimcb/VyHEjgc69e5vXL7pxaov0xZ2eq/neysbu/TUdxOB5O6gPPXAeb8uyqEVOA19xI3TZci2LjztvJawi4Jn83w44X7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=XTrLsKM5; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.123.3] (kenny-tx.gotdns.com [162.196.229.233])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4WzBtq0SM9zy3Q;
	Wed,  4 Sep 2024 02:10:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1725430243; bh=tT5xdBKyAffEoJ3EwqkwtBD3YsRNv2Iggt63GrMvxts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XTrLsKM5n1UYh+vbloCJEIJXYoDOXZgopen7ej2JiPNkMkeI0w3jhDeowEOel/Hqu
	 zIFmHJqf+bL8XMpWxDEX8WTUGC5uca90py5nvoVrrdGZkoA/BkAnQPtBXZxVAYgDe5
	 XSQTZg8vbGTqCJF8aw1Urma5CuAXuh1pEnfJf10Y=
Message-ID: <5e7183c8-1843-4390-aef1-1772e538a359@panix.com>
Date: Tue, 3 Sep 2024 23:10:41 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My Dell XPS-9320 (kernel 6.10.x, et al.) doesn't detect
 Thunderbolt additions when coming out of suspend or hibernate
To: Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, linux-usb@vger.kernel.org
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Kenneth Crudup <kenny@panix.com>
References: <c9feac08-a1fd-4e03-a708-1046793443db@panix.com>
 <ZsvxR-dQAZtwNi0g@wunner.de> <6322b3f1-c5d9-4291-96da-72b85248dea0@panix.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <6322b3f1-c5d9-4291-96da-72b85248dea0@panix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


... or, maybe not. Turns out that sometimes my system can't suspend 
(just hangs, spinning hard somewhere based on the heat and the fans) 
when plugged into a Thunderbolt dock at the time of suspend.

-K

On 8/30/24 12:52, Kenneth Crudup wrote:
> 
> Huh. So I checked out Linus' master (currently up to 6.11-rc5) and it 
> seems to be doing the right thing now; I left a USB-C ALT monitor setup 
> plugged in when I suspended, then came back to my 4K monitor setup via 
> TB and it came up in the right resolution and everything.
> 
> Excellent news, so I'll keep using Linus' master until 6.11 is released.
> 
> Oh, and to answer your question, no, my system doesn't (perceptively) 
> wake up when suspended if I connect/disconnect USB/TB cables.
> 
> ... and unfortunately all I have now is (power-hungry) s0ix sleep.
> 
> -Kenny
> 
> On 8/25/24 20:06, Lukas Wunner wrote:
>> [cc += Mika, linux-usb]
>>
>> On Wed, Aug 21, 2024 at 03:05:59PM -0700, Kenneth Crudup wrote:
>>> Subject says it all, but to recap my laptop doesn't detect Thunderbolt
>>> topology changes when resuming or coming out of hibernate; i.e., the 
>>> only
>>> time a TB topology change happens is if a TB cable is disconnected while
>>> suspended or hibernated, but if one is connected, or a different TB 
>>> setup
>>> altogether is connected when the system resumes it doesn't notice the
>>> topology change until I disconnect and reconnect.
>>>
>>> I'm currently running 6.10.6, but this has been going on for a while.
>>>
>>> [    0.000000] DMI: Dell Inc. XPS 9320/0KNXGD, BIOS 2.12.0 04/11/2024
>>> ...
>>> [    0.136807] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1280P 
>>> (family:
>>> 0x6, model: 0x9a, stepping: 0x3)
>>
>> This commit went into v6.11-rc1 and will at least detect replacement
>> of PCI devices (to a certain extent):
>>
>> https://git.kernel.org/linus/9d573d19547b
>>
>> However PCI is layered on top of (tunneled through) the Thunderbolt
>> switching fabric and that's where the real problem likely is here.
>>
>> Maybe you can open a bug at bugzilla.kernel.org and attach full dmesg
>> and lspci -vvv output in the working case (device attachment at runtime)
>> and the non-working case (device attachment during system sleep).
>>
>> Does the machine wake up if you attach devices during system sleep?
>> Are you suspending to ACPI S0ix, S3 or S4?
>>
>> Thanks,
>>
>> Lukas
>>
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

