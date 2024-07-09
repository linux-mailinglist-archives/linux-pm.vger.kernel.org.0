Return-Path: <linux-pm+bounces-10838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F66B92B45B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 11:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5246F1C2030A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 09:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DAB1553A7;
	Tue,  9 Jul 2024 09:48:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A25152E03;
	Tue,  9 Jul 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518537; cv=none; b=TCy7RZOzUGPWwNf85RoV/E/I5LbgyiMNxusNkN3ir54mYfkYGYwxZf/iVNQWaSTPv5BQuGV19VkddQU6bTkMQbqFkXbNWNFgJJN88ZArVrovbV76c79OlyPmqkd5C3zg35PxRE7oeT+a3APfY0mcRnaRSYCP3eJzHqqWjQu4JgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518537; c=relaxed/simple;
	bh=p6HyUakPKG2/gUVP2W4O18eZ/kXn7hhUZPSBkg7AqHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cf7ScKyrYnE+gy66T7WVcLpki72jCjNRbbxI82EIxEzyMljyi/goXtycyfSelMhBvQ3DDVBtrnhQJF3iTSGTeFSutyYDcK59QrKKNhL9KDHpl11OKv/g7+EoShE/xYN58HpkejG9z0ssU2LUCOxqrFqxEDPmtZ8qMwlaS8lOdcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4E8F139F;
	Tue,  9 Jul 2024 02:49:13 -0700 (PDT)
Received: from [10.57.44.235] (unknown [10.57.44.235])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 794533F766;
	Tue,  9 Jul 2024 02:48:46 -0700 (PDT)
Message-ID: <b7028264-167a-410a-af0c-a9aa156ca993@arm.com>
Date: Tue, 9 Jul 2024 10:49:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: gov_power_allocator: Return early in manage if
 trip_max is null
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Nikita Travkin <nikita@trvn.ru>, kernel@collabora.com,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240702-power-allocator-null-trip-max-v1-1-47a60dc55414@collabora.com>
 <18b1724c-9bab-4501-b956-278896324e55@collabora.com>
 <CAJZ5v0jvsCCFFLPd7Rnrssf+WccKMjHX3NJEW5hdbLTriD6Rgg@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jvsCCFFLPd7Rnrssf+WccKMjHX3NJEW5hdbLTriD6Rgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/3/24 21:20, Rafael J. Wysocki wrote:
> On Wed, Jul 3, 2024 at 11:03 AM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 02/07/24 23:24, Nícolas F. R. A. Prado ha scritto:
>>> Commit da781936e7c3 ("thermal: gov_power_allocator: Allow binding
>>> without trip points") allowed the governor to bind even when trip_max
>>> is null. This allows a null pointer dereference to happen in the manage
>>> callback. Add an early return to prevent it, since the governor is
>>> expected to not do anything in this case.
>>>
>>> Fixes: da781936e7c3 ("thermal: gov_power_allocator: Allow binding without trip points")
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>> ---
>>> This issue was noticed by KernelCI during a boot test on the
>>> mt8195-cherry-tomato-r2 platform with the config in [1]. The stack trace
>>> is attached below.
>>>
>>> [1] http://0x0.st/XaON.txt
>>>
>>> [    4.015786] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>>> [    4.015791] Mem abort info:
>>> [    4.015793]   ESR = 0x0000000096000004
>>> [    4.015796]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [    4.015799]   SET = 0, FnV = 0
>>> [    4.015802]   EA = 0, S1PTW = 0
>>> [    4.015804]   FSC = 0x04: level 0 translation fault
>>> [    4.015807] Data abort info:
>>> [    4.015809]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>> [    4.015811]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>> [    4.015814]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>> [    4.015818] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000109809000
>>> [    4.015821] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
>>> [    4.015835] Modules linked in: mt8195_mt6359(+) mt6577_auxadc snd_soc_mt8195_afe mtk_scp_ipi snd_sof_utils mtk_wdt(+)
>>> [    4.015852] CPU: 2 PID: 13 Comm: kworker/u32:1 Not tainted 6.10.0-rc6 #1 c5d519ae8e7fec6bbe67cb8c50bfebcb89dfa54e
>>> [    4.015859] Hardware name: Acer Tomato (rev2) board (DT)
>>> [    4.015862] Workqueue: events_unbound deferred_probe_work_func
>>> [    4.015875] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [    4.015880] pc : power_allocator_manage+0x110/0x6a0
>>> [    4.015888] lr : __thermal_zone_device_update+0x1dc/0x400
>>> [    4.015893] sp : ffff8000800eb800
>>> [    4.015895] x29: ffff8000800eb810 x28: 0000000000000001 x27: 0000000000000001
>>> [    4.015903] x26: aaaaaaaaaaaaaaab x25: ffff07a0461c15a0 x24: ffffb58530ca67c0
>>> [    4.015911] x23: 0000000000000000 x22: ffff07a04098fcc0 x21: ffffb58532eec848
>>> [    4.015918] x20: ffff8000800eb920 x19: ffff07a0461c1000 x18: 0000000000000b4b
>>> [    4.015926] x17: 5359534255530031 x16: ffffb585310352e4 x15: 0000000000000020
>>> [    4.015933] x14: 0000000000000000 x13: ffffffff00000000 x12: 0000000000000040
>>> [    4.015940] x11: 0101010101010101 x10: ffffffffffffffff x9 : ffffb58530ca8d78
>>> [    4.015948] x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : 0000000000001388
>>> [    4.015955] x5 : 0000000000000000 x4 : 0000000000000384 x3 : 0000000000000000
>>> [    4.015962] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
>>> [    4.015970] Call trace:
>>> [    4.015972]  power_allocator_manage+0x110/0x6a0
>>> [    4.015978]  __thermal_zone_device_update+0x1dc/0x400
>>> [    4.015983]  thermal_zone_device_set_mode+0x7c/0xa0
>>> [    4.015987]  thermal_zone_device_enable+0x1c/0x28
>>> [    4.015991]  thermal_of_zone_register+0x43c/0x498
>>> [    4.015996]  devm_thermal_of_zone_register+0x6c/0xb8
>>> [    4.016001]  gadc_thermal_probe+0x140/0x214
>>> [    4.016007]  platform_probe+0x70/0xc4
>>> [    4.016012]  really_probe+0x140/0x270
>>> [    4.016018]  __driver_probe_device+0xfc/0x114
>>> [    4.016024]  driver_probe_device+0x44/0x100
>>> [    4.016029]  __device_attach_driver+0x64/0xdc
>>> [    4.016035]  bus_for_each_drv+0xb4/0xdc
>>> [    4.016041]  __device_attach+0xdc/0x16c
>>> [    4.016046]  device_initial_probe+0x1c/0x28
>>> [    4.016052]  bus_probe_device+0x44/0xac
>>> [    4.016057]  deferred_probe_work_func+0xb0/0xc4
>>> [    4.016063]  process_scheduled_works+0x114/0x330
>>> [    4.016070]  worker_thread+0x1c0/0x20c
>>> [    4.016076]  kthread+0xf8/0x108
>>> [    4.016081]  ret_from_fork+0x10/0x20
>>> [    4.016090] Code: d1030294 17ffffdd f94012c0 f9401ed7 (b9400000)
>>> [    4.016095] ---[ end trace 0000000000000000 ]---
>>> ---
>>>    drivers/thermal/gov_power_allocator.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
>>> index 45f04a25255a..1b2345a697c5 100644
>>> --- a/drivers/thermal/gov_power_allocator.c
>>> +++ b/drivers/thermal/gov_power_allocator.c
>>> @@ -759,6 +759,9 @@ static void power_allocator_manage(struct thermal_zone_device *tz)
>>>                return;
>>>        }
>>>
>>> +     if (!params->trip_max)
>>> +             return;
>>> +
>>
>> I'm not sure that this is the right thing to do.
>>
>> If you do that, allocate_power() will never be called, so the entire algo doesn't
>> work, making binding this completely useless (as it's going to be a noop..!).
>>
>> Check what get_governor_trips() says in the documentation:
>>
>>    * If there is only one trip point, then that's considered to be the
>>    * "maximum desired temperature" trip point and the governor is always
>>    * on.  If there are no passive or active trip points, then the
>>    * governor won't do anything.  In fact, its throttle function
>>    * won't be called at all.
>>
>> ....and it looks like you're aware of that, as you said that in the commit
>> description as well.
> 
> IIUC, the problematic commit allowed the power allocator governor to
> bind to a tripless thermal zone in order to prevent failing the entire
> thermal zone registration.
> 
> Yes, it will be a noop in this case because in the absence of any
> trips there will be nothing to do for it.  Still, user space can check
> the zone temperature via sysfs.
> 
> Adding a NULL pointer check before the place where the pointer in
> question is dereferenced is not a bad idea at all.


Yes, I agree. My apologies for being late.

Thanks Rafael for applying the patch.

Lukasz

