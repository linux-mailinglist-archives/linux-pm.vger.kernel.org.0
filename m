Return-Path: <linux-pm+bounces-33746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E147B427D7
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886CB3B8EEA
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 17:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865022F1FCB;
	Wed,  3 Sep 2025 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="dtKQmq2J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F6309DD8
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919976; cv=none; b=rKS0v9v/kr4AIK1lIfVcx7m1U6KxDHG0Cl+OqYWNAxFhZU7RoSaPMThTt6wQpJn0d1saO7WuZVzoTZ4T6iirTHRu25ErH7nQ8sSpE/7BIl4Uy+FMK2N652ib73jMsC0OZMh8N8nHZX3hzk8wVZLt6ki8MSf1wfDNXeNJtGTRENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919976; c=relaxed/simple;
	bh=xphXsA+5DIcxgZrifSNomMJKOgNOPTt+7s3TKlRdytU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=GStdSAYv1chKlP8VQrfSBNM9IokpxdJJolPry5TMag+jtRnBMR7R9WJCEImLUmaSgLHviyPlkNgR/viJ4LzWwJrswCwBlcVuJnU56EfMj6Fkz2k2GIF66DD2UMv+1H0ypR4RX+ssvXOIQX6YVuGynUEF9RK0+A/uqEq45svZMnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=dtKQmq2J; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.36] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cH8VP4dnmz4d70;
	Wed,  3 Sep 2025 13:19:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1756919966; bh=xphXsA+5DIcxgZrifSNomMJKOgNOPTt+7s3TKlRdytU=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=dtKQmq2JoSxZzWeAApS50TjJ0lvhrcFfsZXb/LQhgWUqlJAPJ7sLadANwGfunRKn+
	 +0wZHbo1vEwM1LnNOzofOsoIFlpbVT6Yo7MXxSsd8uK35FUOjB0spBYefl3fvTVcTF
	 0Aptc6AZUoml3BbQk2Mo/SX9QBPOy4OdcsS/RQBg=
Message-ID: <03d67820-1e21-4361-b539-10b3ad346155@panix.com>
Date: Wed, 3 Sep 2025 10:19:23 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: I think there's an issue with e3f1164fc9e ("PM: EM: Support late
 CPUs booting and capacity adjustment") if there's "holes" in your CPU
 topology
To: Christian Loehle <christian.loehle@arm.com>, lukasz.luba@arm.com,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <40212796-734c-4140-8a85-854f72b8144d@panix.com>
 <27809ad9-2a35-475d-bef8-47a06e81d647@arm.com>
 <3d87a8c3-ecb9-4ee5-917c-f944915ee684@panix.com>
 <d23e3fe9-a8b8-49fd-8198-8868b41ee57f@arm.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
Cc: Kenneth C <kenny@panix.com>
In-Reply-To: <d23e3fe9-a8b8-49fd-8198-8868b41ee57f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


(Sorry for the delay, it's been a US holiday weekend here)

 > I wonder though, given that this works fine on my x86 nosmt hybrid 
(presumably something like yours?) is this actually an issue for you?

TBH, the real reason I'd looked into it was 'cause I was getting 
"energy_model: Accessing cpu1 policy failed" every few seconds spammed 
into my dmesg and I thought it may have been an error.

That being said, do you expect your patch to be upstreamed? Raphael 
seems to think it's OK.

I still have /proc/sys/kernel/sched_energy_aware == 1, and then there's:

sudo ls -las /sys/kernel/debug/energy_model/
total 0
0 drwxr-xr-x 16 root root 0 Sep  2 14:20 .
0 drwx------ 53 root root 0 Sep  2 14:20 ..
0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu0
0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu10
0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu12
0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu13
0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu14
0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu15
0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu16
0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu17
0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu18
0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu19
0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu2
0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu4
0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu6
0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu8

 > (and neutering a bunch of userspace stuff that insists on switching 
schedutil to something inferior)

Huh. What were these processes, so I can be on the lookout? I just 
switched to using the energy model so still weighing it all out to see 
if I'm sticking to it (I'm not sure if I'm seeing the battery-life 
benefits).

-Kenny

On 8/29/25 03:31, Christian Loehle wrote:
> On 8/28/25 18:42, Kenneth Crudup wrote:
>>
>>> So there's probably a problem here, but presumably your proposal breaks the late boot
>>> (i.e. what this code was initially supposed to support).
>>
>> Please explain?
>>
>> It seems to me (and I really don't know, just guessing here) that if there were remaining errors from not getting any further CPU policies that the loop would just run thru all CPUs "harmlessly".
> 
> It would miss not-online-yet CPUs and never run again (potentially).
> 
>>
>> Now perhaps to ensure the schedule_delayed_work() gets run, what about a flag that gets set if any CPU policy was accessed, and the schedule_delayed_work() gets run if it's never set?
> 
> Yeah that's the obvious immediate fix here, I've attached a patch for it. (please test!)
> I wonder though, given that this works fine on my x86 nosmt hybrid (presumably something like
> yours?) is this actually an issue for you?
> With intel_pstate=passive (and neutering a bunch of userspace stuff that insists on switching
> schedutil to something inferior) I get a working
> # cat /proc/sys/kernel/sched_energy_aware
> 1
> 
> with all online CPUs having an EM (see /sys/kernel/debug/energy_model/ )
> 
>> [snip]
> 
> +CC
> Dietmar who has also played with this and reviewed the x86 EM part.

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


