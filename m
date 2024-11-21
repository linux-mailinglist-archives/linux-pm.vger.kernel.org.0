Return-Path: <linux-pm+bounces-17891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059059D5286
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E4C284068
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8D81BBBC1;
	Thu, 21 Nov 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ympKcLxU"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F714BF87;
	Thu, 21 Nov 2024 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213773; cv=none; b=XrilfhrWy6WQGih4h0sf52lTp7kXin4Lc2IiRpi8MU5ZjZ9jOaKMdoJVGpOcFVBpRFyF3hNjJqU+oQMhHXxWHT+2yCMyxr0nl0GV9Ff4P/wsLGUr1LnKzpDZkQhkYsUb4b/LMQg11BWmM8g/+62zH3wV5GuBTyMkSwry147D7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213773; c=relaxed/simple;
	bh=mI2H/Nxd4qd9x6WNZznbONc9sLhdlZ8jJSX1IZinMEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QanzE1EYmK0PkG62XFkcQ6bdS2zZnhnBI/PepA97omS782fWAvMJZTc8RzC4kU/+hnlywJ03mT5wNvN8Y6/T2ppddYvg6H9b1xifCP7VcWGLBVNsIhGKzMGIk1ngyQq5+X2+md72arXSPXi1sLqEVSMhPrme0F9NPODtzpPbd6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ympKcLxU; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 519552E096BE;
	Thu, 21 Nov 2024 20:29:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1732213767;
	bh=2EmKV4JJ+rT5f1YhVJu72OOYRIQ5iSHyakk7UTHywUc=;
	h=Received:From:Subject:To;
	b=ympKcLxU9QAysWIelOLk8sdnZezh6Y+e63Py+ADpI1OoMUVc5rDciAIUKiUtx5YRU
	 aTUm3ASWtMhpAF7Dn3lBH6eQFON3AchczAnnJnmNxvZY3wR/6bQlXDd/4GR+c1mbaT
	 R7gEZotuhtDT8gs80Rg2Onu1nlGlzNMypWgEV5T8=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f172.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-2fb561f273eso14276841fa.2;
        Thu, 21 Nov 2024 10:29:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXdJYv28RrseGcZnEKPgu4O+2ZbJgC/KxniLWr0bLcE5OkCCbxr8pgDh1OlhTXd7JYNrr/jMTystswaiwsTTTt0OkYH@vger.kernel.org
X-Gm-Message-State: AOJu0YzNmFNMMfU3swxG68R5q8YgFdaLGjcTuDAtroh1B5fvJr3hOPWh
	HCv02mMVfLuykX18iht+fFfbmODpXwzwAzLn+zWGvkMaV4Aea+reiaPmjV1DHR4cTmFN0wy1cJC
	XI+GruNOEvEOgfO7B1j1eg8qWGK0=
X-Google-Smtp-Source: 
 AGHT+IEJRqWCS/dCL/O0lar/j0xLeGI4O/KFaQVuPjLoZj4tqY5aTi//5S3npdexsG15egMUPgZllCxV0mKjfuGzm7I=
X-Received: by 2002:a05:651c:50b:b0:2f3:b71a:1e91 with SMTP id
 38308e7fff4ca-2ff8dbe7af5mr46030871fa.17.1732213764720; Thu, 21 Nov 2024
 10:29:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121172239.119590-1-lkml@antheas.dev>
 <20241121172239.119590-6-lkml@antheas.dev>
 <bee4cc61-ea6f-43fa-a752-6a69465e6517@amd.com>
In-Reply-To: <bee4cc61-ea6f-43fa-a752-6a69465e6517@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 21 Nov 2024 19:29:13 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGjE633JL6BvvBfZcoKidCqvT+gFiVanPO3Bwot484mcg@mail.gmail.com>
Message-ID: 
 <CAGwozwGjE633JL6BvvBfZcoKidCqvT+gFiVanPO3Bwot484mcg@mail.gmail.com>
Subject: Re: [RFC 05/13] acpi/x86: s2idle: add modern standby transition
 function
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
	Kyle Gospodnetich <me@kylegospodneti.ch>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <173221376614.2360.9359975455324368092@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Thu, 21 Nov 2024 at 19:16, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 11/21/2024 11:22, Antheas Kapenekakis wrote:
> > Add a new function to transition modern standby states and call it
> > as part of the suspend sequence to make sure it begins under the
> > Modern Standby "Sleep" state.
>  > > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >   include/linux/suspend.h |  11 ++++
> >   kernel/power/power.h    |   1 +
> >   kernel/power/suspend.c  | 127 ++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 139 insertions(+)
> >
> > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > index 01ee64321cda..b8fe781d8026 100644
> > --- a/include/linux/suspend.h
> > +++ b/include/linux/suspend.h
> > @@ -40,6 +40,15 @@ typedef int __bitwise suspend_state_t;
> >   #define PM_SUSPEND_MIN              PM_SUSPEND_TO_IDLE
> >   #define PM_SUSPEND_MAX              ((__force suspend_state_t) 4)
> >
> > +typedef int __bitwise standby_state_t;
>
> As this is series is working on emulating semantics of "Modern Standby"
> on Windows, why not name it all "modern_standby"?
>
> IE
>
> modern_standby_state_t
> PM_MODERN_STANDBY_ACTIVE
> PM_MODERN_STANDBY_SCREEN_OFF

I would rather keep the name more generalizable. Modern Standby is the
Microsoft term. That was the idea behind it at least. If other drivers
want to hook into this, I think it would be desirable as well. As far
as the s2ildle x86 semantics thats up in the air htough.

> > +
> > +#define PM_STANDBY_ACTIVE            ((__force standby_state_t) 0)
> > +#define PM_STANDBY_SCREEN_OFF        ((__force standby_state_t) 1)
> > +#define PM_STANDBY_SLEEP             ((__force standby_state_t) 2)
> > +#define PM_STANDBY_RESUME            ((__force standby_state_t) 3)
> > +#define PM_STANDBY_MIN                       PM_STANDBY_ACTIVE
> > +#define PM_STANDBY_MAX                       ((__force standby_state_t) 4)
> > +
> >   /**
> >    * struct platform_suspend_ops - Callbacks for managing platform dependent
> >    *  system sleep states.
> > @@ -281,6 +290,8 @@ extern void arch_suspend_enable_irqs(void);
> >
> >   extern int pm_suspend(suspend_state_t state);
> >   extern bool sync_on_suspend_enabled;
> > +extern int pm_standby_transition(standby_state_t state);
> > +extern int pm_standby_state(void);
> >   #else /* !CONFIG_SUSPEND */
> >   #define suspend_valid_only_mem      NULL
> >
> > diff --git a/kernel/power/power.h b/kernel/power/power.h
> > index de0e6b1077f2..4ee067cd0d4d 100644
> > --- a/kernel/power/power.h
> > +++ b/kernel/power/power.h
> > @@ -207,6 +207,7 @@ extern void swsusp_show_speed(ktime_t, ktime_t, unsigned int, char *);
> >   extern const char * const pm_labels[];
> >   extern const char *pm_states[];
> >   extern const char *mem_sleep_states[];
> > +extern const char *standby_states[];
> >
> >   extern int suspend_devices_and_enter(suspend_state_t state);
> >   #else /* !CONFIG_SUSPEND */
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index a42e8514ee7a..1865db71a0c2 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -45,12 +45,21 @@ static const char * const mem_sleep_labels[] = {
> >       [PM_SUSPEND_MEM] = "deep",
> >   };
> >   const char *mem_sleep_states[PM_SUSPEND_MAX];
> > +static const char * const standby_labels[] = {
> > +     [PM_STANDBY_ACTIVE] = "active",
> > +     [PM_STANDBY_SCREEN_OFF] = "screen_off",
> > +     [PM_STANDBY_SLEEP] = "sleep",
> > +     [PM_STANDBY_RESUME] = "resume",
> > +};
> > +const char *standby_states[PM_STANDBY_MAX];
> >
> >   suspend_state_t mem_sleep_current = PM_SUSPEND_TO_IDLE;
> >   suspend_state_t mem_sleep_default = PM_SUSPEND_MAX;
> >   suspend_state_t pm_suspend_target_state;
> >   EXPORT_SYMBOL_GPL(pm_suspend_target_state);
> >
> > +standby_state_t standby_current = PM_STANDBY_ACTIVE;
> > +
> >   unsigned int pm_suspend_global_flags;
> >   EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
> >
> > @@ -188,6 +197,16 @@ void __init pm_states_init(void)
> >        * initialize mem_sleep_states[] accordingly here.
> >        */
> >       mem_sleep_states[PM_SUSPEND_TO_IDLE] = mem_sleep_labels[PM_SUSPEND_TO_IDLE];
> > +     /* All systems support the "active" state. */
> > +     standby_states[PM_STANDBY_ACTIVE] = standby_labels[PM_STANDBY_ACTIVE];
> > +     /*
> > +      * Not all systems support these states, where they will have increased
> > +      * power consumption. If deemed necessary, they should be gated to not
> > +      * mislead userspace.
> > +      */
> > +     standby_states[PM_STANDBY_SCREEN_OFF] = standby_labels[PM_STANDBY_SCREEN_OFF];
> > +     standby_states[PM_STANDBY_SLEEP] = standby_labels[PM_STANDBY_SLEEP];
> > +     standby_states[PM_STANDBY_RESUME] = standby_labels[PM_STANDBY_RESUME];
>
> Shouldn't these states only be enabled when LPS0 support was found?  IE
> shouldn't they be enabled by acpi_register_lps0_dev() and disabled by
> acpi_unregister_lps0_dev()

This is a place i want to look more into. Yes I agree that these
states should be hidden. However, we have the issue right now where
s2idle is globally enabled too, even if the platform does not support
S3 or advertise S0 support in the FADT. Windows correctly hibernates
Ayaneo devices that do not advertise either for example, where linux
just makes them enter a semi broken state. Ayaneo has started
releasing updated BIOSes that fix that though so that fixes that issue
until another manufacturer decides to do that.

I would also like to see if it is possible to hide individual states
if the hardware does not support them. However, I think ACPI does not
advertise support for any of these states. IE you either support all
of them or none of them through the UUID existing.

> >   }
> >
> >   static int __init mem_sleep_default_setup(char *str)
> > @@ -354,6 +373,108 @@ static bool platform_suspend_again(suspend_state_t state)
> >               suspend_ops->suspend_again() : false;
> >   }
> >
> > +static int platform_standby_transition_internal(standby_state_t state)
> > +{
> > +     int error;
> > +
> > +     if (state == standby_current)
> > +             return 0;
> > +     if (state > PM_STANDBY_MAX)
> > +             return -EINVAL;
> > +
> > +     pm_pr_dbg("Transitioning from standby state %s to %s\n",
> > +               standby_states[standby_current], standby_states[state]);
> > +
> > +     /* Resume can only be entered if we are on the sleep state. */
> > +     if (state == PM_STANDBY_RESUME) {
> > +             if (standby_current != PM_STANDBY_SLEEP)
> > +                     return -EINVAL;
> > +             standby_current = PM_STANDBY_RESUME;
> > +             return platform_standby_turn_on_display();
> > +     }
> > +
> > +     /*
> > +      * The system should not be able to re-enter Sleep from resume as it
> > +      * is undefined behavior. As part of setting the state to "Resume",
> > +      * were promised a transition to "Screen Off" or "Active".
> > +      */
> > +     if (standby_current == PM_STANDBY_RESUME && state == PM_STANDBY_SLEEP)
> > +             return -EINVAL;
> > +
> > +     /* Resume is the Sleep state logic-wise. */
> > +     if (standby_current == PM_STANDBY_RESUME)
> > +             standby_current = PM_STANDBY_SLEEP;
> > +
> > +     if (standby_current < state) {
> > +             for (; standby_current < state; standby_current++) {
> > +                     switch (standby_current + 1) {
> > +                     case PM_STANDBY_SCREEN_OFF:
> > +                             error = platform_standby_display_off();
> > +                             break;
> > +                     case PM_STANDBY_SLEEP:
> > +                             error = platform_standby_sleep_entry();
> > +                             break;
> > +                     }
> > +
> > +                     if (error)
> > +                             return error;
> > +             }
> > +     } else if (standby_current > state) {
> > +             for (; standby_current > state; standby_current--) {
> > +                     switch (standby_current) {
> > +                     case PM_STANDBY_SLEEP:
> > +                             error = platform_standby_sleep_exit();
> > +                             break;
> > +                     case PM_STANDBY_SCREEN_OFF:
> > +                             error = platform_standby_display_on();
> > +                             break;
> > +                     }
> > +
> > +                     if (error)
> > +                             return error;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * pm_standby_transition - Transition between Modern Standby states
> > + *
> > + * Fires the appropriate firmware notifications to transition to the requested
> > + * state. Returns an error if the transition fails. The function does not
> > + * rollback. It is up to userspace to handle the error and re-transition when
> > + * appropriate.
> > + */
> > +int pm_standby_transition(standby_state_t state)
> > +{
> > +     unsigned int sleep_flags;
> > +     int error;
> > +
> > +     sleep_flags = lock_system_sleep();
> > +     error = platform_standby_transition_internal(state);
> > +     unlock_system_sleep(sleep_flags);
> > +
> > +     return error;
> > +}
> > +EXPORT_SYMBOL_GPL(pm_standby_transition);
> > +
> > +/**
> > + * pm_standby_state - Returns the current standby state
> > + */
> > +int pm_standby_state(void)
> > +{
> > +     unsigned int sleep_flags;
> > +     int state;
> > +
> > +     sleep_flags = lock_system_sleep();
> > +     state = standby_current;
> > +     unlock_system_sleep(sleep_flags);
> > +
> > +     return state;
> > +}
> > +EXPORT_SYMBOL_GPL(pm_standby_state);
> > +
> >   #ifdef CONFIG_PM_DEBUG
> >   static unsigned int pm_test_delay = 5;
> >   module_param(pm_test_delay, uint, 0644);
> > @@ -586,6 +707,7 @@ static void suspend_finish(void)
> >   static int enter_state(suspend_state_t state)
> >   {
> >       int error;
> > +     standby_state_t standby_prior;
> >
> >       trace_suspend_resume(TPS("suspend_enter"), state, true);
> >       if (state == PM_SUSPEND_TO_IDLE) {
> > @@ -601,6 +723,9 @@ static int enter_state(suspend_state_t state)
> >       if (!mutex_trylock(&system_transition_mutex))
> >               return -EBUSY;
> >
> > +     standby_prior = standby_current;
> > +     platform_standby_transition_internal(PM_STANDBY_SLEEP);
> > +
> >       if (state == PM_SUSPEND_TO_IDLE)
> >               s2idle_begin();
> >
> > @@ -630,6 +755,8 @@ static int enter_state(suspend_state_t state)
> >       pm_pr_dbg("Finishing wakeup.\n");
> >       suspend_finish();
> >    Unlock:
> > +     platform_standby_transition_internal(standby_prior);
> > +
> >       mutex_unlock(&system_transition_mutex);
> >       return error;
> >   }
>

