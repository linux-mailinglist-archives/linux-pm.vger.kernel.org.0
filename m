Return-Path: <linux-pm+bounces-37651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23006C4192E
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 21:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D453B39D4
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 20:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B35307AD9;
	Fri,  7 Nov 2025 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXtjYF0T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0B21257A
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546902; cv=none; b=nzDInax3y5sIIyv0fccdPn65gKQakFgPx9m3nzTU1AlxItevvGWe6zwy1e4/J/lRFZnH6OhL8yiosWxZPpR7K53FSsT6ZbbLPx+lQBBSSFDRuLcWWD97FFgCetD4QPY3OPVzmqGUUQfKn24sHzRpKL3JpJgEd1d/d777v7XByMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546902; c=relaxed/simple;
	bh=XdTrFM+muNKx80yCYm3GJBX5Km77XMXCwn9qA0trw5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtdsRwrbPC5OTcsEqbxgfpxeAOrmfuAkZYaebWscghgyUV0/jtFkeWThEk4O88MQya+vSLXHRm8KiKEZHzu7wcinGfMscR7fP9IG5aqkixUvoRfY/ytlOd8bnFgkAQ+T92P0oTuiDcuJvG9szpl7U8RqxhDeDMtCMhWoHb5vXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXtjYF0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC237C19423
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 20:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762546901;
	bh=XdTrFM+muNKx80yCYm3GJBX5Km77XMXCwn9qA0trw5E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RXtjYF0TemP/xaQRnA9RxSJLxKWgpGdSIy3q5/NjX8XlBys8CQlAQ2OfeKqh7Bi5J
	 wnz7WHJpU3if0KcvZZzEx/IRs2PtyNY0SAIKxe+yYsbbiJXFcM/NJUuW49BI8e8C8K
	 pqErIlWtaA0ClO9+YRR/DiI0tjtU658tgmuOBQyi1ljCQEW3Ns3LeJMPvjfZUyKaNY
	 HIh288eHJP1LOekOzxMe4hcN4t/mrwGW/tefjz3YKoZJ3M/fa/NUEWZ1Ne0A1MG6D7
	 Qjqc03ZDJ2qNBauQQVEoXul/JvQ0qLDi0NKX5S1MLeUKoMmb5DJDYfwfMKSBav7v6p
	 rkj45UfZrinNw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-656b32a0cc4so279036eaf.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 12:21:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvpykXO7FYFrzgUk8qbTrt+5PJu25OefV9T+s//KFD6NLxi2orM8ooicxyTqFIMpmDzX7KVw1jjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI4tH9NtQ/S3coq1cI8gI2yr3XQoXfuOxBUEmIxWLdqVhiyVj8
	zRzNhDvfFU5WyO2vyXAb27mbYlUiowJ1cM0mir55gHq0XQpaDlJE9MMy0wCMpquw9KTKjmQed0f
	4QmBvbuJz8RhZxA16Q9I3n1qcVOFz2Sc=
X-Google-Smtp-Source: AGHT+IHSW7bYuFpaP/EHUfjyaJpeKaCAsDxHqSJ8TJifR429GMhRlPnT6p7CfvR0HmD7ZTteJPuTe/Fx/LWEHEOcrzU=
X-Received: by 2002:a05:6820:4b91:b0:654:eea7:9c17 with SMTP id
 006d021491bc7-656d8e62734mr516884eaf.4.1762546901127; Fri, 07 Nov 2025
 12:21:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026050905.764203-1-superm1@kernel.org> <20251026050905.764203-2-superm1@kernel.org>
In-Reply-To: <20251026050905.764203-2-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 21:21:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gh46ORBUaiZapcZEzkhzgW6spH_Y7+pW=CYu+ccJvWzA@mail.gmail.com>
X-Gm-Features: AWmQ_bmRyzuayfd5brHh_7wCutSrwS_GyGgBygyvV8yQKaGwzxZQyWov8_IpQiE
Message-ID: <CAJZ5v0gh46ORBUaiZapcZEzkhzgW6spH_Y7+pW=CYu+ccJvWzA@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] PM: Introduce new PMSG_POWEROFF event
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, 
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>, 
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, AceLan Kao <acelan.kao@canonical.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	=?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
	Eric Naim <dnaim@cachyos.org>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 6:09=E2=80=AFAM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> PMSG_POWEROFF will be used for the PM core to allow differentiating betwe=
en
> a hibernation or shutdown sequence when re-using callbacks for common cod=
e.
>
> Hibernation is started by writing a hibernation method (such as 'platform=
'
> 'shutdown', or 'reboot') to use into /sys/power/disk and writing 'disk' t=
o
> /sys/power/state.
>
> Shutdown is initiated with the reboot() syscall with arguments on whether
> to halt the system or power it off.
>
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v9:
>  * Add more detail to commit message (Bjorn)
> v8:
>  * Break series into 3 parts
>  * Drop PMSG_NO_WAKEUP change
> v7:
>  * Reword commit
> v5:
>  * Re-order and split
>  * Add tags
> v4:
>  * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@ker=
nel.org/
> ---
>  drivers/base/power/main.c    | 7 +++++++
>  include/linux/pm.h           | 3 +++
>  include/trace/events/power.h | 3 ++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 451d54486645b..ecdd88b578a04 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -95,6 +95,8 @@ static const char *pm_verb(int event)
>                 return "restore";
>         case PM_EVENT_RECOVER:
>                 return "recover";
> +       case PM_EVENT_POWEROFF:
> +               return "poweroff";
>         default:
>                 return "(unknown PM event)";
>         }
> @@ -367,6 +369,7 @@ static pm_callback_t pm_op(const struct dev_pm_ops *o=
ps, pm_message_t state)
>         case PM_EVENT_FREEZE:
>         case PM_EVENT_QUIESCE:
>                 return ops->freeze;
> +       case PM_EVENT_POWEROFF:
>         case PM_EVENT_HIBERNATE:
>                 return ops->poweroff;
>         case PM_EVENT_THAW:
> @@ -401,6 +404,7 @@ static pm_callback_t pm_late_early_op(const struct de=
v_pm_ops *ops,
>         case PM_EVENT_FREEZE:
>         case PM_EVENT_QUIESCE:
>                 return ops->freeze_late;
> +       case PM_EVENT_POWEROFF:
>         case PM_EVENT_HIBERNATE:
>                 return ops->poweroff_late;
>         case PM_EVENT_THAW:
> @@ -435,6 +439,7 @@ static pm_callback_t pm_noirq_op(const struct dev_pm_=
ops *ops, pm_message_t stat
>         case PM_EVENT_FREEZE:
>         case PM_EVENT_QUIESCE:
>                 return ops->freeze_noirq;
> +       case PM_EVENT_POWEROFF:
>         case PM_EVENT_HIBERNATE:
>                 return ops->poweroff_noirq;
>         case PM_EVENT_THAW:
> @@ -1385,6 +1390,8 @@ static pm_message_t resume_event(pm_message_t sleep=
_state)
>                 return PMSG_RECOVER;
>         case PM_EVENT_HIBERNATE:
>                 return PMSG_RESTORE;
> +       case PM_EVENT_POWEROFF:
> +               return PMSG_ON;

I'm not sure if PMSG_ON is the right choice here (as stated elsewhere,
the "poweroff" transition at the end of system shutdown cannot really
be rolled back and this is all about what pm_message_t value to use
for the rollback), but even so, this change is unnecessary because
PMSG_ON is returned by default.

>         }
>         return PMSG_ON;
>  }

