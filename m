Return-Path: <linux-pm+bounces-27148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6064AB729C
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 19:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF871BA1B56
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 17:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D9C1EFF81;
	Wed, 14 May 2025 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3hGXgdU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1919D09C
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243148; cv=none; b=t9smsi66oIfH0EnVC7RdL5o/+Q6swxSguQhEPrnB20eAzeOPkx2LhXXpNEu4go9oPq5UxFQ6qcwjGmScJm8L1CUydXJjKmlyz6PcM19O14EHJs7fBaFE/w0LejZN/1XkCsYL+/ugor7TEkWOodhULjUVGbDQifCiMQILj61wFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243148; c=relaxed/simple;
	bh=j9AhNxGKdSM2FBd5oRycxcvZWBFE2+WGaSSC3eYpXko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXzCisiIHOGPJENSUC/VimnhezkyHX7K587gNipjc7l+NgaUxx1wlLPVfKgmDsVKBLjWtKwA3NYrtt9KNgPlIMu+dCxGz8PlyugjOANj6hvJSZtj4xv+T28th0y/ChJMe8GBznzm3fsIEN1dMOLu93y8pLfjoYt09Gh4BP9NKM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3hGXgdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A4AC4CEE9
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 17:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747243147;
	bh=j9AhNxGKdSM2FBd5oRycxcvZWBFE2+WGaSSC3eYpXko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f3hGXgdUwF4mNJVliKSM5U28Snuz12h6Tt1eMkrBSRLrN1jh6BL5HERKBTAXIfLAR
	 wP5GLWIF52NJoKLiDo5T+cVqMDcN//N9UGmEmObWchKoARHFQ/CgINGp6wsdZa0T0d
	 R6u6g+gt5sS3NhK3+9l+L6u9U1KqppUGph1Fp+qSOvJ78LAbq34gzPd1Cw/EUi73NW
	 OA88G5tQggXoUFPNRXU/MnEtdsi2C9rXivYcGFeBgwAXETIVBspG3fDmI0E6X3AH3h
	 UM6HBN+P+SNOO5G46Yo8a0Nq4wh/MKDG06u8/e4P8IFdtOgRUguuxK1YN239pJ4aCO
	 G6IQ4oezoWlig==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-731e277a6b0so6645223a34.1
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 10:19:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuFzz78XGMseJ73PIdkwdKSMErmkgT8HS58sxVORSz+ppWmwWwscA/H7vAoUObfM2zVnXLMxi3xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcSIL5LPlA+YXnS/2sFqVakoMrioQ6ooUPZjgjkQtRpu1mBzuO
	g+GISKoOG8izW6n1fv+8cOMCB88Qf4fU1co2CckSRquB/2sEXVhBa+7QXjXrUmoe66pCbsqOuZN
	K4/4KOIFRvQy2VzE75gCidCBK9Gk=
X-Google-Smtp-Source: AGHT+IH8QzV4onzAUCGhiRM8wupsDRIT7OdrQ9Nuo781kfonjlM93BxnegRkX+1y8MRc3abBqNJsO6sXFGiGu9m+oQ8=
X-Received: by 2002:a05:6871:3a1f:b0:2c2:260:d77b with SMTP id
 586e51a60fabf-2e32b05a8f3mr2488017fac.5.1747243146861; Wed, 14 May 2025
 10:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512212628.2539193-1-superm1@kernel.org>
In-Reply-To: <20250512212628.2539193-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 May 2025 19:18:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hrKEJa8Ad7iiAvQ3d_0ysVhzZcXSYc5kkL=6vtseF+bg@mail.gmail.com>
X-Gm-Features: AX0GCFveLDDnwRn0VFJ2x3Hgg3Cy31FRGrI9bthVX7yi12znfaZQGf3BvRFbumY
Message-ID: <CAJZ5v0hrKEJa8Ad7iiAvQ3d_0ysVhzZcXSYc5kkL=6vtseF+bg@mail.gmail.com>
Subject: Re: [PATCH] PM: Use hibernate flows for system power off
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org, len.brown@intel.com, 
	pavel@kernel.org, gregkh@linuxfoundation.org, dakr@kernel.org, 
	AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Denis Benato <benato.denis96@gmail.com>, 
	=?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 11:26=E2=80=AFPM Mario Limonciello <superm1@kernel.=
org> wrote:
>
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
> callbacks when turning off the system.

I really like the idea, but more care is needed.

> To avoid issues when the kernel
> is compiled without hibernate support introduce a new internal PM message
> type "SHUTDOWN" which points to all the same callbacks as hibernate would=
.

Which doesn't really address the problem because those callbacks
depend on PM_SLEEP or HIBERNATE_CALLBACKS in the majority of cases.

These callbacks really should only be used if hibernation is
supported.  Or to be more precise, when CONFIG_HIBERNATE_CALLBACKS is
set.  Doing it unconditionally is asking for trouble.

> Cc: AceLan Kao <acelan.kao@canonical.com>
> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> Cc: Denis Benato <benato.denis96@gmail.com>
> Cc: Merthan Karaka=C5=9F <m3rthn.k@gmail.com>
> Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limon=
ciello@amd.com/
> Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@=
kernel.org/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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
> @@ -363,6 +363,8 @@ static pm_callback_t pm_op(const struct dev_pm_ops *o=
ps, pm_message_t state)
>         case PM_EVENT_RESTORE:
>                 return ops->restore;
>  #endif /* CONFIG_HIBERNATE_CALLBACKS */
> +       case PM_EVENT_SHUTDOWN:
> +               return ops->poweroff;
>         }
>
>         return NULL;
> @@ -397,6 +399,8 @@ static pm_callback_t pm_late_early_op(const struct de=
v_pm_ops *ops,
>         case PM_EVENT_RESTORE:
>                 return ops->restore_early;
>  #endif /* CONFIG_HIBERNATE_CALLBACKS */
> +       case PM_EVENT_SHUTDOWN:
> +               return ops->poweroff_late;
>         }
>
>         return NULL;
> @@ -431,6 +435,8 @@ static pm_callback_t pm_noirq_op(const struct dev_pm_=
ops *ops, pm_message_t stat
>         case PM_EVENT_RESTORE:
>                 return ops->restore_noirq;
>  #endif /* CONFIG_HIBERNATE_CALLBACKS */
> +       case PM_EVENT_SHUTDOWN:
> +               return ops->poweroff_noirq;

Actually, the event can still be "poweroff" whether this is
hibernation or power-off-shutdown, but using it on reboot-shutdown
would be kind of wasteful.

>         }
>
>         return NULL;
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index f0bd8fbae4f2c..536defa771716 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -490,6 +490,9 @@ const struct dev_pm_ops name =3D { \
>   * HIBERNATE   Hibernation image has been saved, call ->prepare() and
>   *             ->poweroff() for all devices.
>   *
> + * SHUTDOWN    System is going to shut down, call ->prepare() and ->powe=
roff()
> + *             for all devices.
> + *
>   * QUIESCE     Contents of main memory are going to be restored from a (=
loaded)
>   *             hibernation image, call ->prepare() and ->freeze() for al=
l
>   *             devices.
> @@ -536,6 +539,7 @@ const struct dev_pm_ops name =3D { \
>  #define PM_EVENT_USER          0x0100
>  #define PM_EVENT_REMOTE                0x0200
>  #define PM_EVENT_AUTO          0x0400
> +#define PM_EVENT_SHUTDOWN      0x0800
>
>  #define PM_EVENT_SLEEP         (PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
>  #define PM_EVENT_USER_SUSPEND  (PM_EVENT_USER | PM_EVENT_SUSPEND)
> @@ -550,6 +554,7 @@ const struct dev_pm_ops name =3D { \
>  #define PMSG_QUIESCE   ((struct pm_message){ .event =3D PM_EVENT_QUIESCE=
, })
>  #define PMSG_SUSPEND   ((struct pm_message){ .event =3D PM_EVENT_SUSPEND=
, })
>  #define PMSG_HIBERNATE ((struct pm_message){ .event =3D PM_EVENT_HIBERNA=
TE, })
> +#define PMSG_SHUTDOWN  ((struct pm_message){ .event =3D PM_EVENT_SHUTDOW=
N, })
>  #define PMSG_RESUME    ((struct pm_message){ .event =3D PM_EVENT_RESUME,=
 })
>  #define PMSG_THAW      ((struct pm_message){ .event =3D PM_EVENT_THAW, }=
)
>  #define PMSG_RESTORE   ((struct pm_message){ .event =3D PM_EVENT_RESTORE=
, })
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
> @@ -305,7 +306,12 @@ static void kernel_shutdown_prepare(enum system_stat=
es state)
>                 (state =3D=3D SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NU=
LL);
>         system_state =3D state;
>         usermodehelper_disable();
> +#ifdef CONFIG_PM_SLEEP
> +       dpm_suspend_start(PMSG_SHUTDOWN);
> +       dpm_suspend_end(PMSG_SHUTDOWN);
> +#else
>         device_shutdown();
> +#endif
>  }
>  /**
>   *     kernel_halt - halt the system
> --

