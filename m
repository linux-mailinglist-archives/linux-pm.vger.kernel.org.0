Return-Path: <linux-pm+bounces-6809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163978ACFD3
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 16:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A322FB2090E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 14:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF641514F2;
	Mon, 22 Apr 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn3axPr8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DB32AD2D
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797168; cv=none; b=H8Ti0AceQ/IaCbp9FdsqkleVJUyDaz6q61WUG2boFWXt+fapzbAx/vXYcjFQ0I8WQ0qOndgEsXQAZtfjgS9UcTIo9diT5up3LN96JNi2zFrFlpzL6mspMJdE/dnKibOhEQkCZYitCejdOG56+aAaa2BoZUMB2vwnmFPBGlUe56U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797168; c=relaxed/simple;
	bh=PdqvqNq99Ng+Jmdf6F5mBVmsRKks2fS6qv9bSbGnb7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLjwMdyxW4Qd8j5V8Ay+S/syJ0MKzvk5cw551mv9HHejmKg3Rzu1Cgqn5Y9FHFG+YzsLWvtqgdwHC+tdrLPJBq7+HZtrOJCgSpSG3YvuMsB7MR3meYyM6mUzdwC0Kf3n33pBz47T1X8jRN0s4yk+At//TfUTTYhD93Voz4HCLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kn3axPr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C40C4AF07
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713797168;
	bh=PdqvqNq99Ng+Jmdf6F5mBVmsRKks2fS6qv9bSbGnb7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kn3axPr8YiBsWETpA2M/ix65vGfGP8ocnCWoKw6tZNQse7yZNfquxeqQTNRGHW7Yh
	 fhNuY+Ig19j0hq9aO7yHx5HGCB0EAvGYhSpS5eOO2xJ5A3J7GdGdIkpq+r1/Bqd5/S
	 lTIWdVYv85fgDdJpkIZwZqsjOJ1mqOOh2q1Lq2GDYr8V6k6w+RqJl7JYNiX9ZjJv7h
	 3yHKw83fjfOIU6YxedUvGIxrqKY6WsDgRAZNBvJnaQ1PFzOFtcWF0Ic+QPQQBUr52B
	 chVHYWtdqmwdR6yLDY5BWwrHWuUYWc4JekI6U+hxZSX63+pNnG2tujSS5ZXjfR7Khs
	 MXpDjcL+zzBVA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aca32d3f78so872346eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 07:46:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQGx/wy8lAH/veZgipkFGjt9mJlXvMyvSTR4CBj0gM81EKd7qLTeluVMKnte0J/TVQiRt6e2AMUDb1YUsAJF66Xhh7IQ1Xd/I=
X-Gm-Message-State: AOJu0YyJi+R5VZB1XLicVvkbisQRO8RpbwgWnQdKU13Ss691aMN9asQ3
	E8+ZA9GdiaY7SOXftG2Lrg86MKF4C19PfSj3zNgu+S0ectj4e/y0slmvOko6dEEe9KPrDt6rzjS
	/DQqi0h4s3vxA84xhX8K5+A2GhLs=
X-Google-Smtp-Source: AGHT+IE9d3ZV6ojo5jb74zKRRtoQNwrRmdf8OfNVn0lAYrma5L0DVTLgb5K6aMM7zU8NRyKnKNY3lpYZZyBns82jEwY=
X-Received: by 2002:a05:6871:520e:b0:23a:69ea:90ef with SMTP id
 ht14-20020a056871520e00b0023a69ea90efmr1482746oac.3.1713797167252; Mon, 22
 Apr 2024 07:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422093619.118278-1-xiongxin@kylinos.cn> <37847b26-1c1e-48d3-a74e-bd2bcc6e1fda@amd.com>
In-Reply-To: <37847b26-1c1e-48d3-a74e-bd2bcc6e1fda@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 16:45:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gmF0Lcy_nHSvTDnu4C3N0mipaeJqHff=00fgWdtwOzMw@mail.gmail.com>
Message-ID: <CAJZ5v0gmF0Lcy_nHSvTDnu4C3N0mipaeJqHff=00fgWdtwOzMw@mail.gmail.com>
Subject: Re: [PATCH] Revert "include/linux/suspend.h: Only show pm_pr_dbg
 messages at suspend/resume"
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: xiongxin <xiongxin@kylinos.cn>, rafael@kernel.org, len.brown@intel.com, 
	pavel@ucw.cz, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 4:33=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 4/22/2024 04:36, xiongxin wrote:
> > This reverts commit cdb8c100d8a4b4e31c829724e40b4fdf32977cce.
> >
> > In the suspend process, pm_pr_dbg() is called before setting
> > pm_suspend_target_state. As a result, this part of the log cannot be
> > output.
> >
> > pm_pr_dbg() also outputs debug logs for hibernate, but
> > pm_suspend_target_state is not set, resulting in hibernate debug logs
> > can only be output through dynamic debug, which is very inconvenient.
>
> As an alternative, how about exporting and renaming the variable
> in_suspend in kernel/power/hibernate.c and considering that to tell if
> the hibernate process is going on?
>
> Then it should work just the same as it does at suspend.

Well, this is not the only part that stopped working AFAICS.  I'll
queue up the revert.

Thanks!

> >
> > Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> >
> > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > index da6ebca3ff77..415483b89b11 100644
> > --- a/include/linux/suspend.h
> > +++ b/include/linux/suspend.h
> > @@ -503,7 +503,6 @@ static inline void unlock_system_sleep(unsigned int=
 flags) {}
> >   #ifdef CONFIG_PM_SLEEP_DEBUG
> >   extern bool pm_print_times_enabled;
> >   extern bool pm_debug_messages_on;
> > -extern bool pm_debug_messages_should_print(void);
> >   static inline int pm_dyn_debug_messages_on(void)
> >   {
> >   #ifdef CONFIG_DYNAMIC_DEBUG
> > @@ -517,14 +516,14 @@ static inline int pm_dyn_debug_messages_on(void)
> >   #endif
> >   #define __pm_pr_dbg(fmt, ...)                                       \
> >       do {                                                    \
> > -             if (pm_debug_messages_should_print())           \
> > +             if (pm_debug_messages_on)                       \
> >                       printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);  \
> >               else if (pm_dyn_debug_messages_on())            \
> >                       pr_debug(fmt, ##__VA_ARGS__);   \
> >       } while (0)
> >   #define __pm_deferred_pr_dbg(fmt, ...)                              \
> >       do {                                                    \
> > -             if (pm_debug_messages_should_print())           \
> > +             if (pm_debug_messages_on)                       \
> >                       printk_deferred(KERN_DEBUG pr_fmt(fmt), ##__VA_AR=
GS__); \
> >       } while (0)
> >   #else
> > @@ -542,8 +541,7 @@ static inline int pm_dyn_debug_messages_on(void)
> >   /**
> >    * pm_pr_dbg - print pm sleep debug messages
> >    *
> > - * If pm_debug_messages_on is enabled and the system is entering/leavi=
ng
> > - *      suspend, print message.
> > + * If pm_debug_messages_on is enabled, print message.
> >    * If pm_debug_messages_on is disabled and CONFIG_DYNAMIC_DEBUG is en=
abled,
> >    *  print message only from instances explicitly enabled on dynamic d=
ebug's
> >    *  control.
> > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > index a9e0693aaf69..aa754241aaa6 100644
> > --- a/kernel/power/main.c
> > +++ b/kernel/power/main.c
> > @@ -611,12 +611,6 @@ power_attr_ro(pm_wakeup_irq);
> >
> >   bool pm_debug_messages_on __read_mostly;
> >
> > -bool pm_debug_messages_should_print(void)
> > -{
> > -     return pm_debug_messages_on && pm_suspend_target_state !=3D PM_SU=
SPEND_ON;
> > -}
> > -EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
> > -
> >   static ssize_t pm_debug_messages_show(struct kobject *kobj,
> >                                     struct kobj_attribute *attr, char *=
buf)
> >   {
>

