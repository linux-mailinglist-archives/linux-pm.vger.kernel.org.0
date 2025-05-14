Return-Path: <linux-pm+bounces-27142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15174AB7100
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 18:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91BBF7B543C
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 16:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE94627C152;
	Wed, 14 May 2025 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwMlMM78"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81A27BF6D
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239302; cv=none; b=WD89L45ZjYJwsw5tfqwqG70mSHjuDVGAZvp3X97hLKJpzUKWty5uum8JftwAUIG0CEVr6MXFw1ATsQPKMHY8D9EZFJF8sUITbvfuwUWIEyCG56Kms/sK7ctHTH4PBg0EriO5ZdqByKRDTyW4n/PDVt/171LbGJv8SSyOIwNqi9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239302; c=relaxed/simple;
	bh=HCOMnFCtczRVgbfqUPOyCzqQcaNUh9WXzukH82q+WMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhtycQxWkBFEsZAuO7/S9yzXwmGtGrkfP7EBn8r6HVwWDRmM7Gj5vviZuEXP6OFhIr4841ULIT8/3i9tVS883pcQ1mc1IxCO1Zs8Mp2XY+XqJJjhM+Rq1ISCW9dLwujAGfZDOmpsTrVujBZK42o2lfiQ8HXqFtbRbfm1I5JhkOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwMlMM78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE07C4CEE3;
	Wed, 14 May 2025 16:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747239302;
	bh=HCOMnFCtczRVgbfqUPOyCzqQcaNUh9WXzukH82q+WMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VwMlMM78GllGgw8rTPs4u6AaOX6Eg3LNBWJlLOV79ZRHJQLgkipthUOu6O64ARKyU
	 s9WDGLTUXaa5RzWk9gE6+oXcw03jEGaKy7UzWLPgspLb2iqjTBJiC+FqVD5lcgI+0D
	 ZOui4CMNlgEjEPkrTvCCOKPHcInnhh1Hb5hMVIJGw1LGaJ1x/90SZn8zkzdYqH1HtR
	 6XXi5h88ZSHf2I2Vwd1wUoRYZ+q5dFkrqIRQIe42Xe3qChgklfMS1+K5r9s+nLNaRB
	 6fBGyXryI0gqUaLL64GB+CEexpqnZRG9/pzmKgr5snn8YULwVgGajzt41t+A3OlnJm
	 LSPUtUHMwrn3g==
Message-ID: <e3aa4d7d-e854-4ee2-aa5d-6371e8aa4ed8@kernel.org>
Date: Wed, 14 May 2025 11:15:00 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: Use hibernate flows for system power off
To: Denis Benato <benato.denis96@gmail.com>, mario.limonciello@amd.com,
 rafael@kernel.org, len.brown@intel.com, pavel@kernel.org,
 gregkh@linuxfoundation.org, dakr@kernel.org
Cc: AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 linux-pm@vger.kernel.org
References: <20250512212628.2539193-1-superm1@kernel.org>
 <6cc4caa4-ca75-4b32-83a9-1dea761046ef@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <6cc4caa4-ca75-4b32-83a9-1dea761046ef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/14/2025 10:45 AM, Denis Benato wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> When the system is powered off the kernel will call device_shutdown()
>> which will issue callbacks into PCI core to wake up a device and call
>> it's shutdown() callback.  This will leave devices in ACPI D0 which can
>> cause some devices to misbehave with spurious wakeups and also leave some
>> devices on which will consume power needlessly.
>>
>> The issue won't happen if the device is in D3 before system shutdown, so
>> putting device to low power state before shutdown solves the issue.
>>
>> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
>> compatible with the current Power Resource states. In other words, all
>> devices are in the D3 state when the system state is S4."
>>
>> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
>> state is similar to the S4 state except that OSPM does not save any
>> context." so it's safe to assume devices should be at D3 for S5.
>>
>> To accomplish this, modify the PM core to call all the device hibernate
>> callbacks when turning off the system. To avoid issues when the kernel
>> is compiled without hibernate support introduce a new internal PM message
>> type "SHUTDOWN" which points to all the same callbacks as hibernate would.
>>
>> Cc: AceLan Kao <acelan.kao@canonical.com>
>> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
>> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Cc: Denis Benato <benato.denis96@gmail.com>
>> Cc: Merthan Karakaş <m3rthn.k@gmail.com>
>> Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/
>> Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@kernel.org/
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Hello,
> 
> As for the previous version this patch makes my laptop shutdown cleanly very quickly
> and I could not link to any regressions or change in behavior while laptop is on.
> 
> Tested-by: Denis Benato <benato.denis96@gmail.com>

Thanks Denis, that's great news to hear.

FTR I noticed that this needs some error handling in case the hibernate 
flows fail, so assuming Rafael is generally amenable to this direction 
the next spin I'll add something like this instead to fall back to the 
previous shutdown flow if that happens.

+#ifdef CONFIG_PM_SLEEP
+       if (dpm_suspend_start(PMSG_SHUTDOWN))
+               goto resume_devices;
+       if (dpm_suspend_end(PMSG_SHUTDOWN))
+               goto resume_devices;
+       return;
+
+resume_devices:
+       pr_emerg("Failed to power off devices, using shutdown instead.\n");
+       dpm_resume_end(PMSG_RESTORE);
+#endif
	device_shutdown();

>> ---
>> This is the spiritual successor to "PCI/PM: Put devices to low power
>> state on shutdown" as well as "Improvements to system power consumption
>> at S5"
>> ---
>>   drivers/base/power/main.c | 6 ++++++
>>   include/linux/pm.h        | 5 +++++
>>   kernel/reboot.c           | 6 ++++++
>>   3 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index 29561f7346d93..58adedc4dab23 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -363,6 +363,8 @@ static pm_callback_t pm_op(const struct dev_pm_ops *ops, pm_message_t state)
>>   	case PM_EVENT_RESTORE:
>>   		return ops->restore;
>>   #endif /* CONFIG_HIBERNATE_CALLBACKS */
>> +	case PM_EVENT_SHUTDOWN:
>> +		return ops->poweroff;
>>   	}
>>   
>>   	return NULL;
>> @@ -397,6 +399,8 @@ static pm_callback_t pm_late_early_op(const struct dev_pm_ops *ops,
>>   	case PM_EVENT_RESTORE:
>>   		return ops->restore_early;
>>   #endif /* CONFIG_HIBERNATE_CALLBACKS */
>> +	case PM_EVENT_SHUTDOWN:
>> +		return ops->poweroff_late;
>>   	}
>>   
>>   	return NULL;
>> @@ -431,6 +435,8 @@ static pm_callback_t pm_noirq_op(const struct dev_pm_ops *ops, pm_message_t stat
>>   	case PM_EVENT_RESTORE:
>>   		return ops->restore_noirq;
>>   #endif /* CONFIG_HIBERNATE_CALLBACKS */
>> +	case PM_EVENT_SHUTDOWN:
>> +		return ops->poweroff_noirq;
>>   	}
>>   
>>   	return NULL;
>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>> index f0bd8fbae4f2c..536defa771716 100644
>> --- a/include/linux/pm.h
>> +++ b/include/linux/pm.h
>> @@ -490,6 +490,9 @@ const struct dev_pm_ops name = { \
>>    * HIBERNATE	Hibernation image has been saved, call ->prepare() and
>>    *		->poweroff() for all devices.
>>    *
>> + * SHUTDOWN	System is going to shut down, call ->prepare() and ->poweroff()
>> + * 		for all devices.
>> + *
>>    * QUIESCE	Contents of main memory are going to be restored from a (loaded)
>>    *		hibernation image, call ->prepare() and ->freeze() for all
>>    *		devices.
>> @@ -536,6 +539,7 @@ const struct dev_pm_ops name = { \
>>   #define PM_EVENT_USER		0x0100
>>   #define PM_EVENT_REMOTE		0x0200
>>   #define PM_EVENT_AUTO		0x0400
>> +#define PM_EVENT_SHUTDOWN	0x0800
>>   
>>   #define PM_EVENT_SLEEP		(PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
>>   #define PM_EVENT_USER_SUSPEND	(PM_EVENT_USER | PM_EVENT_SUSPEND)
>> @@ -550,6 +554,7 @@ const struct dev_pm_ops name = { \
>>   #define PMSG_QUIESCE	((struct pm_message){ .event = PM_EVENT_QUIESCE, })
>>   #define PMSG_SUSPEND	((struct pm_message){ .event = PM_EVENT_SUSPEND, })
>>   #define PMSG_HIBERNATE	((struct pm_message){ .event = PM_EVENT_HIBERNATE, })
>> +#define PMSG_SHUTDOWN	((struct pm_message){ .event = PM_EVENT_SHUTDOWN, })
>>   #define PMSG_RESUME	((struct pm_message){ .event = PM_EVENT_RESUME, })
>>   #define PMSG_THAW	((struct pm_message){ .event = PM_EVENT_THAW, })
>>   #define PMSG_RESTORE	((struct pm_message){ .event = PM_EVENT_RESTORE, })
>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>> index ec087827c85cd..083c143f99e40 100644
>> --- a/kernel/reboot.c
>> +++ b/kernel/reboot.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/kexec.h>
>>   #include <linux/kmod.h>
>>   #include <linux/kmsg_dump.h>
>> +#include <linux/pm.h>
>>   #include <linux/reboot.h>
>>   #include <linux/suspend.h>
>>   #include <linux/syscalls.h>
>> @@ -305,7 +306,12 @@ static void kernel_shutdown_prepare(enum system_states state)
>>   		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
>>   	system_state = state;
>>   	usermodehelper_disable();
>> +#ifdef CONFIG_PM_SLEEP
>> +	dpm_suspend_start(PMSG_SHUTDOWN);
>> +	dpm_suspend_end(PMSG_SHUTDOWN);
>> +#else
>>   	device_shutdown();
>> +#endif
>>   }
>>   /**
>>    *	kernel_halt - halt the system
> 


