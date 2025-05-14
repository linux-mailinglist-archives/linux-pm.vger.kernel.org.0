Return-Path: <linux-pm+bounces-27141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F930AB7036
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 17:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B894C3BC53F
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 15:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04D11E5B97;
	Wed, 14 May 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZrBFdwl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF28721FF31
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747237506; cv=none; b=L1adYc/uCUp1FqcjC/y4kJGMi+vP7fjp5nfb/cFAeeDwtC6z9gC/9misib57quIrI21KlPe2F3Vocl75bPtuFAm/wAtWJdtj3YrmnQt+MPIjQ346tKMn1d8csqPNvlaBeIgC8HzVWxkl49uxm/FTCwjxZG5Zqb2ZbeaaTW68eQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747237506; c=relaxed/simple;
	bh=XO/jwt9TXibKbOqvKRRD8ZUu8VlfJY0RzoNkqqPX0aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EpZiDhPnRygDlLilRr1rYzDBZDSDLaUt3i6cZn6Rp0T+vFpbiaIE3rR96LNN+hPDlxdhNCtFa9Y9qLyPGE9OoBteaB5L2Qj26qS/SpLNL7EhfbfORZftlTXJ+NzzO1sj0491KkQ6mDLS3y9faIXTXAD1NacGFWpQLh6DscUXe7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZrBFdwl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso53274325e9.3
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747237503; x=1747842303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ckxhe2vAfurztr9MpqpHLfLEc8RXVw4lzcAqpr8KAHw=;
        b=MZrBFdwlMvuv4lDFIrzmCE3IO3//fterafay4ZoBOnQx1epHwaL4VaXZ6W6i9j8QjO
         Iv16maBoLrGRkmD2CHRrJV07VKXYNYqmuLq1PgFayCS+95Bb42m+kKEtrZc+RTArDXya
         82LD72bso+FJM+JUeqXFWTNPY/9FTgJZXisi9eDoRcFneAp7qOxGtml1ZHMt/GdygykZ
         qJsns3Re3e/Q7ZRLdlq9rLJV2M65JSzXu+mfp7be7Y3SuIrX1GZN4CUzSBg7pVWc/AdH
         /S6rPT2T0fKOEdR3H0KkZ+kxAZDfRofI54Q7cqqNgWy5kP4lxzEpFDHp7d5B46ujbZbC
         Kuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747237503; x=1747842303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ckxhe2vAfurztr9MpqpHLfLEc8RXVw4lzcAqpr8KAHw=;
        b=BzdkYiOPG25allbdJpPqpe6dtO0lBtdOUYH3XGV7HwJ6+fTLrXY41UDkU7Wt5qj3Nq
         SJcHMuJlhznD9T2k0SpfYypNuB4IhuFl8uD+JenlvjKpe0rQprn8V8qCVwybT6DdCfYB
         NfwE/tDJkVUN6dGqwfPeRRs7cRG8HOvnyHGo4WW30YRxTEsXgN7NvMNxYUJfEoLzLY8l
         XXEpY+E7ym2SxDcvntJD72XBrcd3q5z1wD/iEpmjt7p3jre4wGGMwLZQczslphnXr6jS
         b+MkeVkVPun6EPFkuL8AKjfBK4ziPdiEyTDIHkZESOMo2kaQ6aNYVtBr34zvpaLUg8pQ
         ZmdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkl/SUbBKMLsDM5Va3F+XuwalwcYVQtWcLRhh+hspQzYWjjKrELXM1Aon3mQ9TNpjg2KYWLb216w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9NCcyJcohUmo1wh+p+NoIctK0/c4jOQ/PSxx2zuq7D4Y5MHD5
	q0OnXV60A+moFOiyDqNhS0UIMPWGzWoacL/FwmyeWjvJx5hKz9Bm
X-Gm-Gg: ASbGncs299adn2KaRcYmKbZJLy4LdW96BS3ORtMcTvGCfBGplERmRGlXff9BjCyWqHW
	bhXlcALHdhBfAQg0VXjqu+6XwR5wKeZbq5ta9dZwPEGYsvJFDIZeLIyzFNuUKx6Ei1ddeFjxkOM
	Jh1sBh0+ypmdZm6mqJzM853zlP5vHzlLvKpy0Qzc4MJf2JRW63Srn4aAv/eEfCJUhXu3B9c+nJO
	lxNM2GdrhQ8dVpsah1Q+DWjl34pEP4rampjabtoa/UkcBt//dcAI8Fo8L6RtcSgjk286tRcndWr
	qBmi8nprQc1wu+UGR4AQi4A3wTT+nmC2R9hAzUQkYcTRjl1OL5MI8bpjUstgMJY=
X-Google-Smtp-Source: AGHT+IElWuy3lBioPx4eMErdoIrYQ4XyvS8ucEjHk8pQic+52bEF0uOUK9PgkzLrL0z+EpTEjgFNZA==
X-Received: by 2002:a05:600c:3f08:b0:441:d438:4ea5 with SMTP id 5b1f17b1804b1-442f2168ac4mr37490515e9.20.1747237502888;
        Wed, 14 May 2025 08:45:02 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f396c093sm34601345e9.27.2025.05.14.08.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 08:45:02 -0700 (PDT)
Message-ID: <6cc4caa4-ca75-4b32-83a9-1dea761046ef@gmail.com>
Date: Wed, 14 May 2025 17:45:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: Use hibernate flows for system power off
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
 rafael@kernel.org, len.brown@intel.com, pavel@kernel.org,
 gregkh@linuxfoundation.org, dakr@kernel.org
Cc: AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 linux-pm@vger.kernel.org
References: <20250512212628.2539193-1-superm1@kernel.org>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <20250512212628.2539193-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> From: Mario Limonciello <mario.limonciello@amd.com>
>
> When the system is powered off the kernel will call device_shutdown()
> which will issue callbacks into PCI core to wake up a device and call
> it's shutdown() callback.  This will leave devices in ACPI D0 which can
> cause some devices to misbehave with spurious wakeups and also leave some
> devices on which will consume power needlessly.
>
> The issue won't happen if the device is in D3 before system shutdown, so
> putting device to low power state before shutdown solves the issue.
>
> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
> compatible with the current Power Resource states. In other words, all
> devices are in the D3 state when the system state is S4."
>
> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
> state is similar to the S4 state except that OSPM does not save any
> context." so it's safe to assume devices should be at D3 for S5.
>
> To accomplish this, modify the PM core to call all the device hibernate
> callbacks when turning off the system. To avoid issues when the kernel
> is compiled without hibernate support introduce a new internal PM message
> type "SHUTDOWN" which points to all the same callbacks as hibernate would.
>
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> Cc: Denis Benato <benato.denis96@gmail.com>
> Cc: Merthan Karakaş <m3rthn.k@gmail.com>
> Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/
> Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@kernel.org/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Hello,

As for the previous version this patch makes my laptop shutdown cleanly very quickly
and I could not link to any regressions or change in behavior while laptop is on.

Tested-by: Denis Benato <benato.denis96@gmail.com>
> ---
> This is the spiritual successor to "PCI/PM: Put devices to low power
> state on shutdown" as well as "Improvements to system power consumption
> at S5"
> ---
>  drivers/base/power/main.c | 6 ++++++
>  include/linux/pm.h        | 5 +++++
>  kernel/reboot.c           | 6 ++++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 29561f7346d93..58adedc4dab23 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -363,6 +363,8 @@ static pm_callback_t pm_op(const struct dev_pm_ops *ops, pm_message_t state)
>  	case PM_EVENT_RESTORE:
>  		return ops->restore;
>  #endif /* CONFIG_HIBERNATE_CALLBACKS */
> +	case PM_EVENT_SHUTDOWN:
> +		return ops->poweroff;
>  	}
>  
>  	return NULL;
> @@ -397,6 +399,8 @@ static pm_callback_t pm_late_early_op(const struct dev_pm_ops *ops,
>  	case PM_EVENT_RESTORE:
>  		return ops->restore_early;
>  #endif /* CONFIG_HIBERNATE_CALLBACKS */
> +	case PM_EVENT_SHUTDOWN:
> +		return ops->poweroff_late;
>  	}
>  
>  	return NULL;
> @@ -431,6 +435,8 @@ static pm_callback_t pm_noirq_op(const struct dev_pm_ops *ops, pm_message_t stat
>  	case PM_EVENT_RESTORE:
>  		return ops->restore_noirq;
>  #endif /* CONFIG_HIBERNATE_CALLBACKS */
> +	case PM_EVENT_SHUTDOWN:
> +		return ops->poweroff_noirq;
>  	}
>  
>  	return NULL;
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index f0bd8fbae4f2c..536defa771716 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -490,6 +490,9 @@ const struct dev_pm_ops name = { \
>   * HIBERNATE	Hibernation image has been saved, call ->prepare() and
>   *		->poweroff() for all devices.
>   *
> + * SHUTDOWN	System is going to shut down, call ->prepare() and ->poweroff()
> + * 		for all devices.
> + *
>   * QUIESCE	Contents of main memory are going to be restored from a (loaded)
>   *		hibernation image, call ->prepare() and ->freeze() for all
>   *		devices.
> @@ -536,6 +539,7 @@ const struct dev_pm_ops name = { \
>  #define PM_EVENT_USER		0x0100
>  #define PM_EVENT_REMOTE		0x0200
>  #define PM_EVENT_AUTO		0x0400
> +#define PM_EVENT_SHUTDOWN	0x0800
>  
>  #define PM_EVENT_SLEEP		(PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
>  #define PM_EVENT_USER_SUSPEND	(PM_EVENT_USER | PM_EVENT_SUSPEND)
> @@ -550,6 +554,7 @@ const struct dev_pm_ops name = { \
>  #define PMSG_QUIESCE	((struct pm_message){ .event = PM_EVENT_QUIESCE, })
>  #define PMSG_SUSPEND	((struct pm_message){ .event = PM_EVENT_SUSPEND, })
>  #define PMSG_HIBERNATE	((struct pm_message){ .event = PM_EVENT_HIBERNATE, })
> +#define PMSG_SHUTDOWN	((struct pm_message){ .event = PM_EVENT_SHUTDOWN, })
>  #define PMSG_RESUME	((struct pm_message){ .event = PM_EVENT_RESUME, })
>  #define PMSG_THAW	((struct pm_message){ .event = PM_EVENT_THAW, })
>  #define PMSG_RESTORE	((struct pm_message){ .event = PM_EVENT_RESTORE, })
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index ec087827c85cd..083c143f99e40 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -13,6 +13,7 @@
>  #include <linux/kexec.h>
>  #include <linux/kmod.h>
>  #include <linux/kmsg_dump.h>
> +#include <linux/pm.h>
>  #include <linux/reboot.h>
>  #include <linux/suspend.h>
>  #include <linux/syscalls.h>
> @@ -305,7 +306,12 @@ static void kernel_shutdown_prepare(enum system_states state)
>  		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
>  	system_state = state;
>  	usermodehelper_disable();
> +#ifdef CONFIG_PM_SLEEP
> +	dpm_suspend_start(PMSG_SHUTDOWN);
> +	dpm_suspend_end(PMSG_SHUTDOWN);
> +#else
>  	device_shutdown();
> +#endif
>  }
>  /**
>   *	kernel_halt - halt the system

