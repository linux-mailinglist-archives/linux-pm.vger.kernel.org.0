Return-Path: <linux-pm+bounces-37358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00239C30F30
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 13:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A21524FA401
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484EB23F424;
	Tue,  4 Nov 2025 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aBnRRmHc"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EE02EBDFA
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258483; cv=none; b=X+Vtbaj813hh6BvwqCY7V30V8rb61Qbn8RTIYklN/DxA225ZrfHRxI206vAp5z/v7OkFJgXgK71yZeD28yiBrRzUgDUWubnz9ytPQBcXLexIa96f4gUdSyQM9d0aAMoMKDuKRvvssi4au1GuoAoxdWqpzwB/1LOysd0+XJqQlWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258483; c=relaxed/simple;
	bh=/Qy/aym9q8YCUfwjiPQd/n7jZkHfZZHQXb2JvW7Fapg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c2ztNYVq+IgrsIAzKD8R0tuTJDPkVXW7dxaK2hvK5RulUHY1kf41h00KdB1uRCHiGkhNHUu05F5E8fvE7jnaqjAdBV/EhLfEF9opJkSuhtD1Ns9YS/L7zvIMQ74xcAhidU0VWrQqtU1rCJlescxBMI4Nfuku16OwP/Lv1K59/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aBnRRmHc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762258478;
	bh=/Qy/aym9q8YCUfwjiPQd/n7jZkHfZZHQXb2JvW7Fapg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=aBnRRmHcCFeS3d9OTVFvs1wwX2Vs9HaoNn2YrPZE8uDhBVzlkTj6sgPxkUlFarxLn
	 8i2qN8t7/L9BhXtA0KQ3Dpjz9nUnnYGFLDXNaAnJ9qeay6hlmbz0CSsXc8jSwLZ8f+
	 HLwQqvKoFOr/i+1RbQu87tRjbUIZvPSX5OOaQb/nh5Vh0nTaVqTexDIwv/N12Uc5YU
	 SPgRA82Ntv4093s6Bj4S8AoWkmhGKzqiG0FojVMfqxoSgW4OiPO4/I+ifUEIcn0pE2
	 uoC8druNYC/56d0sGq7Qkd0cTXZOKR4qgOoP63HuY+Kpx9C8NbYF598KjaOH1lBRBP
	 avJQBG/43GP1g==
Received: from [192.168.100.50] (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 640E217E12AA;
	Tue,  4 Nov 2025 13:14:37 +0100 (CET)
Message-ID: <4b9d9753-e097-4b39-873c-da1a118f3321@collabora.com>
Date: Tue, 4 Nov 2025 17:14:07 +0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, Alex Deucher <alexander.deucher@amd.com>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/2] PM: Allow device drivers to manage the frozen
 state of a device
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
References: <20251025010058.2417352-1-superm1@kernel.org>
 <20251025010058.2417352-2-superm1@kernel.org>
 <CAJZ5v0icgrXW0ErPMqOnxKHXZ6cH4gd9274SkJfba981Z=s0fw@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAJZ5v0icgrXW0ErPMqOnxKHXZ6cH4gd9274SkJfba981Z=s0fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/4/25 12:50 AM, Rafael J. Wysocki wrote:
> On Sat, Oct 25, 2025 at 3:01 AM Mario Limonciello (AMD)
> <superm1@kernel.org> wrote:
>>
>> During a normal successful hibernate sequence devices will go through
>> the freeze() callbacks create an image, go through the thaw() callbacks,
>> and poweroff() callbacks.
>>
>> During a successful hibernate sequence some device drivers may want to
>> skip the thaw() callbacks.  This confuses the PM core though because it
>> thinks the device is no longer suspended.

With RFC [1] applied and hibernation is cancelled until or from inside of
dpm_suspend(), this series restores the amdgpu driver. 

hibernate()
-> hibernation_snapshot()
   -> dpm_suspend()

> 
> The problem only really occurs if hibernation is aborted before or
> during the final "poweroff" transition.
This isn't supported yet. I'm working on a new patch to cancel hibernation
after dpm_suspend() and before power_down(). But it causes missed resumption
of amdgpu even after applying this series. Probably some 
dpm_resume_start(PMSG_RECOVER) and dpm_resume_end(PMSG_RECOVER) are missing.
I've not been able to sort it out. 

Its a very late stage and I'm not getting console logs. I don't have serial
connection to get those logs as well.

I'll send the series without this patch in coming days if I'm not able to sort
it out.

[1] https://lore.kernel.org/all/20251018142114.897445-1-usama.anjum@collabora.com 

> 
> What happens is that if a driver decides to leave the device in the
> "frozen" state during its "thaw" callback and its "poweroff" callback
> is not invoked because hibernation is aborted earlier, the device will
> be left in the "frozen" state going forward.
> 
> The goal of the change should be to make the core detect that
> situation and "thaw" the device.
> 
>> To accommodate drivers that want to do this, introduce a new is_frozen
>> bit that the driver can set and manage.  From the driver perspective
>> any thaw() or restore() callbacks that are being skipped should set
>> is_frozen and return an error code.
> 
> "Restore" has nothing to do with this, it is just about "freeze".
> 
>> The PM core will then put the device back into the list of devices to resume for any aborted hibernate.
> 
> That's not what the patch does, though (see below).
> 
> All of this is mainly about what the core should do when it sees the
> "is_frozen" flag set, so a few observations to that end:
> 
> 1. That flag is only relevant when hibernation is aborted before
> invoking the given driver's "poweroff" callback (because that callback
> must be prepared to deal with a "frozen" device).
> 
> 2. If the final "poweroff" transition is aborted during its "prepare"
> phase, the "frozen" device may need to be "thawed" even if its
> driver's "prepare" callback is not invoked.
> 
> 3. There is a possibility, not taken into account so far, that
> hibernation is aborted because of a failure to save the image.  Then,
> "frozen" devices will need to be "thawed" before starting the final
> "poweroff" transition.
> 
> Moreover, I'm not sure if it really makes sense to invoke "complete"
> callbacks during the "thaw" transition for the devices left in the
> "frozen" state.
> 
> All of the above means that the approach needs to be rethought and my
> advice is to revert the commit causing the AMD driver to leave its
> device in the "frozen" for 6.18 (and previous kernels).
> 
>> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>> v2:
>>  * add tag
>>  * fix lkp robot issue
>>  * rebase on linux-pm/bleeding-edge
>> ---
>>  Documentation/driver-api/pm/devices.rst | 8 ++++++++
>>  drivers/base/power/main.c               | 7 +++++++
>>  include/linux/pm.h                      | 3 +++
>>  3 files changed, 18 insertions(+)
>>
>> diff --git a/Documentation/driver-api/pm/devices.rst b/Documentation/driver-api/pm/devices.rst
>> index 36d5c9c9fd113..55c6337271086 100644
>> --- a/Documentation/driver-api/pm/devices.rst
>> +++ b/Documentation/driver-api/pm/devices.rst
>> @@ -578,6 +578,14 @@ should already have been stored during the ``freeze``, ``freeze_late`` or
>>  the entire system, so it is not necessary for the callback to put the device in
>>  a low-power state.
>>
>> +Skipping thaw phase
>> +-------------------
>> +In some rare situations, it may be desirable to skip the thaw phases
>> +(``thaw_noirq``, ``thaw_early``, ``thaw``) of a device entirely.  This can be
>> +achieved by a device driver returning an error code from any of it's thaw
>> +callbacks but also setting dev->power.is_frozen to true.
> 
> Returning an error code should not be necessary.
> 
> Also this needs to be done in "thaw_noirq" or maybe even in
> "freeze_noirq" because "thaw_noirq" may involve some bus type actions
> changing the state of the device before the driver gets to it.
> 
> So the driver would opt in for leaving the device in the "frozen"
> state at the "noirq" stage of the preceding "freeze" transition.  That
> can be achieved by setting a "leave_in_freeze" flag, so no callbacks
> would be run for any devices with that flag set during the subsequent
> "thaw" transition.
> 
> If hibernation is aborted before the final "poweroff" transition
> begins, the "thaw*" and "complete" callbacks will have to be run for
> all of those devices (I'm wondering if any ordering issues may arise
> at that point; presumably, devices that depend on the "frozen" ones
> would also need to be "frozen"?).
> 
> During the final "poweroff" transition, since "complete" has not been
> called for any of the "frozen" devices, it should not be necessary to
> call "prepare" for any of them, so that one can be skipped.
> 
> Again, if hibernation is aborted at this point, all of the "thaw*" and
> complete callbacks need to be run for all of the "frozen" devices.
> 
> Now, "poweroff", "poweroff" and "poweroff_noirq" callbacks for the
> "frozen" devices need to be prepared to deal with them, but the exact
> rules there will need some consideration.  They kind of need to assume
> that "freeze" may be changed into "poweroff" transparently without a
> "thaw" in between and that generally depends on the bus type/PM domain
> involved.
> 
>> This indicates to the
>> +PM core that the device is still in the frozen state.  The PM core will consider
>> +this when resuming the device in later phases such as `restore` or `poweroff`.
>>
>>  Leaving Hibernation
>>  -------------------
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index 7a8807ec9a5d0..c5a192fc04344 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -1110,6 +1110,13 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
>>
>>   End:
>>         error = dpm_run_callback(callback, dev, state, info);
>> +#ifdef CONFIG_HIBERNATE_CALLBACKS
> 
> CONFIG_HIBERNATION should be sufficient.
> 
>> +       /* device manages frozen state */
>> +       if (error && dev->power.is_frozen) {
>> +               dev->power.is_suspended = true;
>> +               error = 0;
>> +       }
> 
> This assumes that the callback will run, but what if hibernation is
> aborted before running it?  Isn't that really the problem at hand?
> 
>> +#endif
>>
>>         device_unlock(dev);
>>         dpm_watchdog_clear(&wd);
>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>> index a72e42eec1303..852902fc72158 100644
>> --- a/include/linux/pm.h
>> +++ b/include/linux/pm.h
>> @@ -689,6 +689,9 @@ struct dev_pm_info {
>>  #else
>>         bool                    should_wakeup:1;
>>  #endif
>> +#ifdef CONFIG_HIBERNATE_CALLBACKS
>> +       bool                    is_frozen:1;    /* Owned by the driver */
>> +#endif
>>  #ifdef CONFIG_PM
>>         struct hrtimer          suspend_timer;
>>         u64                     timer_expires;
>> --


-- 
---
Thanks,
Usama

