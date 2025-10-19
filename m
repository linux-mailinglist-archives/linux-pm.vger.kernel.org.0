Return-Path: <linux-pm+bounces-36434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD54BEE768
	for <lists+linux-pm@lfdr.de>; Sun, 19 Oct 2025 16:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65323189A763
	for <lists+linux-pm@lfdr.de>; Sun, 19 Oct 2025 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953941E1DE9;
	Sun, 19 Oct 2025 14:45:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D87523A;
	Sun, 19 Oct 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760885158; cv=none; b=H0JUnMFSyNjsugGKj7VCM6nOIEUj5Ap/GrXLkMNgeuHr0YoDGLutraOcVzk7aokObCnHTn4gS0Fmpl6tzp43qKyhtacpxcw0WwtDJr22Bq7HQl7bmYnuZMlvt9paD0VvYUSKi58J7H5ii9n5onlXQAWvh84lcNuJ2CXgTQOFGM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760885158; c=relaxed/simple;
	bh=+PY8OhwufxF8YChVTC1aU7xqK63arGfigRz8WI0DmHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MsIfhteuxRkCNXAbF4cnCZh51ockCJFPwjaQrwAyTW7XIaBeptuLDZQRT6/YpIegtl44BvsskAdEw2AyaHYirDiQ74NciJPjyKBJqeUJrAspZ4YYwPypF/KKSG7/tY3GiobtI0Bm34xeLBiaQ8aYPfyIePuWnzBjnyw66KIvBWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 187111007;
	Sun, 19 Oct 2025 07:45:41 -0700 (PDT)
Received: from [10.57.36.38] (unknown [10.57.36.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 597373F66E;
	Sun, 19 Oct 2025 07:45:47 -0700 (PDT)
Message-ID: <8ccf53bd-81cc-4c7b-88b5-5d7aeebf2c3f@arm.com>
Date: Sun, 19 Oct 2025 15:45:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RE: [PATCH v1] cpuidle: governors: menu: Predict longer idle time
 when in doubt
To: Doug Smythies <dsmythies@telus.net>,
 "'Rafael J. Wysocki'" <rafael@kernel.org>,
 'Sergey Senozhatsky' <senozhatsky@chromium.org>
Cc: 'Linux PM' <linux-pm@vger.kernel.org>,
 'LKML' <linux-kernel@vger.kernel.org>,
 'Artem Bityutskiy' <artem.bityutskiy@linux.intel.com>,
 'Tomasz Figa' <tfiga@chromium.org>
References: <4687373.LvFx2qVVIh@rafael.j.wysocki>
 <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com>
 <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com>
 <28ecb23b-ecee-409a-9771-24f801081d07@arm.com>
 <CAJZ5v0jMoEVUaYYPx6EtHFxsg6TF-QtDWJGrasGK7C2C+JxOFw@mail.gmail.com>
 <001801dc4041$607c19f0$21744dd0$@telus.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <001801dc4041$607c19f0$21744dd0$@telus.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/18/25 16:10, Doug Smythies wrote:
> Hi all,
> 
> I have been following and testing these menu.c changes over the last months,
> but never reported back on this email list because:
> 1.) I never found anything significant to report.
> 2.) I always seemed to be a week or more behind the conversations.

Your input is always appreciated!

> 
> On 2025.10.18 04:47 Rafael wrote:
>> On Fri, Oct 17, 2025 at 8:37 PM Christian Loehle wrote:
>>> On 10/17/25 10:39, Rafael J. Wysocki wrote:
>>>> On Fri, Oct 17, 2025 at 10:22 AM Christian Loehle wrote:
>>>>> On 10/16/25 17:25, Rafael J. Wysocki wrote:
>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>
>>>>>> It is reported that commit 85975daeaa4d ("cpuidle: menu: Avoid discarding
>>>>>> useful information") led to a performance regression on Intel Jasper Lake
>>>>>> systems because it reduced the time spent by CPUs in idle state C7 which
>>>>>> is correlated to the maximum frequency the CPUs can get to because of an
>>>>>> average running power limit [1].
> 
> I would like to understand Sergey's benchmark test better, and even try
> to repeat the results on my test system. I would also like to try to 
> separate the variables in an attempt to isolate potential contributors.
> 
> To eliminate the PL1 effect, limit the CPU frequency to 2300 MHz and repeat
> the test. To eliminate potential CPU frequency scaling contributions, use the
> performance CPU frequency scaling governor. Both changes at once would
> be an acceptable first step.
> 
> Sergey: Would you be willing to do that test?
> Sergey: Could you provide more details about your test?

+1
Depending on what the actual test does maybe offlining CPUs and comparing would
be interesting too (if this means that we never reach throttling on this system).

> 
>>From the turbostat data of the other day, it seems that the system was
> only power throttled for about 25 seconds for each test. What we don't know
> is how long the test took overall or the magnitude of any contributions from
> the power limit throttling.

If I didn't mess up it should be >800s, at least from the sum of idle time
Sergey provided. (excludes active time)
That makes the powerthrottling story less plausible IMO.

> 
> Extracted PL1 area from the turbostat data:
> 
> cpu0: PKG Limit #1: ENabled (6.000000 Watts, 28.000000 sec, clamp ENabled)
> 
> 	MHz		Power
> Sample	revert	base	revert	base
> 17	1150	3039	2.15	9.49	<<< base over power limit
> 18	2898	3086	6.26	8.63	<<< revert over power limit
> 19	2968	3017	8.67	9.07
> 20	3054	2642	8.22	7.47
> 21	2910	2510	9	5.57	<<< base throttled
> 22	2950	2438	8.62	5.74
> 23	2300	2571	5.61	5.67	<<< revert throttled
> 24	2423	2667	5.81	6.01
> 25	2560	1827	5.65	2.81	<<< base not throttled
> 26	2478	829	5.5	1.84 
> 27	1552	992	2.36	1.86	<<< revert not throttled
> 
>>From my testing of kernels 6.17-rc1, rc2,rc3 in August and September:
> 
> 779b1a1cb13a cpuidle: governors: menu: Avoid selecting states with too much latency - v6.17-rc3
> fa3fa55de0d6 cpuidle: governors: menu: Avoid using invalid recent intervals data - v6.17-rc2
> baseline reference: v6.17-rc1
> d4a7882f93bf cpuidle: menu: Optimize bucket assignment when next_timer_ns equals KTIME_MAX - v6.16-rc1
> 
> there was an area of about 11% regression in the 2 core ping-pong sweep test.
> After modifying the PL1 limits on my test system so that it would engage for the entire test,
> I re-ran the test with kernel 6.18-rc1 (ref) and also with this patch (rjw).
> The results were identical for each test.
> Some supporting graphs are attached.
> 
>>>>>> [snip]
>>>>> [snip]
>>>>> Anyway, the patch makes sense, let me run some tests and get back.
>>>>
>>>> Thanks!
>>>
>>> Unfortunately this patch regresses my tests about as much as a revert of
>>> 85975daeaa4d would.
>>> (menu-1 is $SUBJECT, menu-m current mainline, menu-r mainline with
>>> 85975daeaa4d reverted):
> 
> So I could better understand the magnitudes of things,
> Christain's test results averaged and restated:
> 
> Averages:					% regression
> mmcblk1	menu-1		1502.3		36.3%
> 		menu-m	2356.7	
> 		menu-r		1483.3		37.1%
> 
> mmcblk2	menu-1		3389.0		41.1%
> 		menu-m	5754.7	
> 		menu-r		3438.3		40.3%
> 
> nvme0n1	menu-1		5812.0		47.4%
> 		menu-m	11059.0	
> 		menu-r		5386.7		51.3%
> 
> sda		menu-1		934.7		42.6%
> 		menu-m	1629.3	
> 		menu-r		907.3		44.3%
> 
> nullb0		menu-1		101466.0	0.1%
> 		menu-m	101559.7	
> 		menu-r		101708.0	-0.1%
> 
> mtdblock3	menu-1		158.7		29.2%
> 		menu-m	224.0	
> 		menu-r		142.7		36.3%
> 
> So, except for nulb0 pretty significant.

(nullb0 is just some sanity check, cpuidle shouldn't really ever
play a role here FWIW)
Thanks for summarising, next time it'll come with such a summary as well.

> 
> Whereas Sergey's results are the other way around by similar magnitudes.
> 
> 6.1-base:	84.5	+42.0%
> 6.1-base-fixup:	76.5	+28.5%
> 6.1-revert:	59.5	
> backport:	78.5	+31.9%
> 


