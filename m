Return-Path: <linux-pm+bounces-27038-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2755AB300A
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 08:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725E016A8E8
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 06:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD66125525C;
	Mon, 12 May 2025 06:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OgUgEmMS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561AE2B9A4
	for <linux-pm@vger.kernel.org>; Mon, 12 May 2025 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747032539; cv=none; b=ennMFKhOq5c9e6TWCGvUn1Hdgd3/gW3LWwVUinQyzAwU3SLR9AeazMSj3md/ejlrmOUSXO6b6RoMvHoc5S7prrVIercIFpj0RvlR+nL3LTK5ZySlAKWhm8lXAiNpu1sYcLdsfT6X6MZmOi0waWL0g582GOy564V/8fzWXl61sjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747032539; c=relaxed/simple;
	bh=3hWNywDm1rmDL3n5pqpD/ttJsvAhh/MKDQWNxinnzr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=e0l9hokOKzlVFNgv/sdG1hC/4RDeAwdSs+TA2UI579c2gCRXHLIx9TJ+ita1KtbHfXlFeVt0BoKZtkPYhm1UibaodFoUnOimHr8RwP0KoDzQO34rFxpVdkPJv2Q6r7PhXitan52m6I9WItx0KLywSP8oCCw7OpuBRFb6uPQYWdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OgUgEmMS; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250512064848euoutp029da921298e8f6019752b750ae82ecae9~_tNQhg1AN0204202042euoutp02j
	for <linux-pm@vger.kernel.org>; Mon, 12 May 2025 06:48:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250512064848euoutp029da921298e8f6019752b750ae82ecae9~_tNQhg1AN0204202042euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747032528;
	bh=xk2dkJToJKLhJspcQw7pjNVsjfwwtKPzo+HUohnIT6M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=OgUgEmMSNCxMAJbxUvdPOZfQTIFZvL+QDxB9S3nWErrYh1jqy5apScBOxr7grJKyQ
	 lgy2so3X7k8FxN1AXf5s5nHOOJRKK5wAK1mQ/AsDYfGKYHlEHWx3F2oNur25pAOoKS
	 kBzadlvILnNb59zJkptnRS6tXnz0/c5+eGXbz87Q=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250512064848eucas1p14e6a595306293484fdfe4be546ba48a0~_tNQNSiEw1439814398eucas1p1E;
	Mon, 12 May 2025 06:48:48 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250512064847eusmtip1dc87bbb74bd18adbf01a8797b75f3e88~_tNPlHGIz0641506415eusmtip1O;
	Mon, 12 May 2025 06:48:47 +0000 (GMT)
Message-ID: <c00ec721-1193-4cfb-87ec-fd98f215720e@samsung.com>
Date: Mon, 12 May 2025 08:48:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] cpufreq/sched: Move cpufreq-specific EAS checks
 to cpufreq
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
	<linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukasz Luba
	<lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>, Srinivas
	Pandruvada <srinivas.pandruvada@linux.intel.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Ricardo Neri
	<ricardo.neri-calderon@linux.intel.com>, Pierre Gondois
	<pierre.gondois@arm.com>, Christian Loehle <christian.loehle@arm.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAJZ5v0j_fFk=EX0Z9_w1twQH-FpntHJvr4d0WSMBM6PevfEqNg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250512064848eucas1p14e6a595306293484fdfe4be546ba48a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250509234915eucas1p2846ecef88f268d78ab2e96d4a67002b0
X-EPHeader: CA
X-CMS-RootMailID: 20250509234915eucas1p2846ecef88f268d78ab2e96d4a67002b0
References: <2999205.e9J7NaK4W3@rjwysocki.net>
	<CGME20250509234915eucas1p2846ecef88f268d78ab2e96d4a67002b0@eucas1p2.samsung.com>
	<2317800.iZASKD2KPV@rjwysocki.net>
	<1bf3df62-0641-459f-99fc-fd511e564b84@samsung.com>
	<CAJZ5v0j_fFk=EX0Z9_w1twQH-FpntHJvr4d0WSMBM6PevfEqNg@mail.gmail.com>

On 10.05.2025 13:31, Rafael J. Wysocki wrote:
> On Sat, May 10, 2025 at 1:49 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 06.05.2025 22:37, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Doing cpufreq-specific EAS checks that require accessing policy
>>> internals directly from sched_is_eas_possible() is a bit unfortunate,
>>> so introduce cpufreq_ready_for_eas() in cpufreq, move those checks
>>> into that new function and make sched_is_eas_possible() call it.
>>>
>>> While at it, address a possible race between the EAS governor check
>>> and governor change by doing the former under the policy rwsem.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
>>> Tested-by: Christian Loehle <christian.loehle@arm.com>
>>> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> In my tests I've noticed that this patch, merged as commit 4854649b1fb4
>> ("cpufreq/sched: Move cpufreq-specific EAS checks to cpufreq"), causes a
>> regression on ARM64 Amlogic Meson SoC based OdroidN2 board. The board
>> finally lockups. Reverting $subject on top of next-20250509 fixes this
>> issue. Here is the lockdep warning observed before the lockup:
> Thanks for the report!
>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.15.0-rc5-next-20250509-dirty #10335 Tainted: G         C
>> cpufreq: cpufreq_policy_online: CPU2: Running at unlisted initial
>> frequency: 999999 kHz, changing to: 1000000 kHz
>> ------------------------------------------------------
>> kworker/3:1/79 is trying to acquire lock:
>> ffff00000494b380 (&policy->rwsem){++++}-{4:4}, at:
>> cpufreq_ready_for_eas+0x60/0xbc
>>
>> but task is already holding lock:
>> ffff8000832887a0 (sched_domains_mutex){+.+.}-{4:4}, at:
>> partition_sched_domains+0x54/0x938
>>
>> which lock already depends on the new lock.
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #2 (sched_domains_mutex){+.+.}-{4:4}:
>>          __mutex_lock+0xa8/0x598
>>          mutex_lock_nested+0x24/0x30
>>          partition_sched_domains+0x54/0x938
>>          rebuild_sched_domains_locked+0x2d4/0x900
>>          rebuild_sched_domains+0x2c/0x48
>>          rebuild_sched_domains_energy+0x3c/0x58
>>          rebuild_sd_workfn+0x10/0x1c
>>          process_one_work+0x208/0x604
>>          worker_thread+0x244/0x388
>>          kthread+0x150/0x228
>>          ret_from_fork+0x10/0x20
>>
>> -> #1 (cpuset_mutex){+.+.}-{4:4}:
>>          __mutex_lock+0xa8/0x598
>>          mutex_lock_nested+0x24/0x30
>>          cpuset_lock+0x1c/0x28
>>          __sched_setscheduler+0x31c/0x830
>>          sched_setattr_nocheck+0x18/0x24
>>          sugov_init+0x1b4/0x388
>>          cpufreq_init_governor.part.0+0x58/0xd4
>>          cpufreq_set_policy+0x2c8/0x3ec
>>          cpufreq_online+0x520/0xb20
>>          cpufreq_add_dev+0x80/0x98
>>          subsys_interface_register+0xfc/0x118
>>          cpufreq_register_driver+0x150/0x238
>>          dt_cpufreq_probe+0x148/0x488
>>          platform_probe+0x68/0xdc
>>          really_probe+0xbc/0x298
>>          __driver_probe_device+0x78/0x12c
>>          driver_probe_device+0xdc/0x164
>>          __device_attach_driver+0xb8/0x138
>>          bus_for_each_drv+0x80/0xdc
>>          __device_attach+0xa8/0x1b0
>>          device_initial_probe+0x14/0x20
>>          bus_probe_device+0xb0/0xb4
>>          deferred_probe_work_func+0x8c/0xc8
>>          process_one_work+0x208/0x604
>>          worker_thread+0x244/0x388
>>          kthread+0x150/0x228
>>          ret_from_fork+0x10/0x20
>>
>> -> #0 (&policy->rwsem){++++}-{4:4}:
>>          __lock_acquire+0x1408/0x2254
>>          lock_acquire+0x1c8/0x354
>>          down_read+0x60/0x180
>>          cpufreq_ready_for_eas+0x60/0xbc
>>          sched_is_eas_possible+0x144/0x170
>>          partition_sched_domains+0x504/0x938
>>          rebuild_sched_domains_locked+0x2d4/0x900
>>          rebuild_sched_domains+0x2c/0x48
>>          rebuild_sched_domains_energy+0x3c/0x58
>>          rebuild_sd_workfn+0x10/0x1c
>>          process_one_work+0x208/0x604
>>          worker_thread+0x244/0x388
>>          kthread+0x150/0x228
>>          ret_from_fork+0x10/0x20
>>
>> other info that might help us debug this:
>>
>> Chain exists of:
>>     &policy->rwsem --> cpuset_mutex --> sched_domains_mutex
>>
>>    Possible unsafe locking scenario:
>>
>>          CPU0                    CPU1
>>          ----                    ----
>>     lock(sched_domains_mutex);
>>                                  lock(cpuset_mutex);
>>                                  lock(sched_domains_mutex);
>>     rlock(&policy->rwsem);
>>
>>    *** DEADLOCK ***
> Well, it turns out that trying to acquire policy->rwsem under
> sched_domains_mutex is a bad idea.  It was added to
> cpufreq_policy_is_good_for_eas() to address a theoretical race, so it
> can be dropped safely.  A theoretical race is better than a real
> deadlock.
>
> Please test the attached patch.

This fixed the observed issue. Thanks!

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


