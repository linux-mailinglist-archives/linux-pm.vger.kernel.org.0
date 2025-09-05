Return-Path: <linux-pm+bounces-33946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 358ACB4537F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 11:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762F51B2250D
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 09:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3477727FD78;
	Fri,  5 Sep 2025 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j44SWj6C"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F6327A461;
	Fri,  5 Sep 2025 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065126; cv=none; b=TIcZaWxiXP3ZORyWCmyAWMWcEecWSp4Iw7smgH23YSOFZJBssLR9yXLFSoTpqQIJKnIkICG2y525blPdKibRrNVmU+FdYOvCqcijgmu5krkRjpLkAGHMf5QBova6KSlxlpIvXzizbZD6H5nGtA4g7w5lpNqnxO+iwS52DS6S274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065126; c=relaxed/simple;
	bh=ZXaFrt9i/Zexp7oaUDcso7SN63//LxatgI/6HSA8Giw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt42LWGfYqIkRQ9k/PGm9r06UajGRMmdgMxZrwOq5y7FVw0HcuJbsknkktZeXvWAvr4MOmhowrUao+vMvomtlmRHb0qCBTyid/AE22p1JZPgrh+xV15yKTE2j2D0Q3pH+T2EuSd0yscDvf754EiZ7nckST3P/8/Az1vMc90YQiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j44SWj6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0DDC4CEFA;
	Fri,  5 Sep 2025 09:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757065125;
	bh=ZXaFrt9i/Zexp7oaUDcso7SN63//LxatgI/6HSA8Giw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j44SWj6CxiUu7e5XArfAYlXStTeOxBbofW0ClA7L381ZlFDbIU2NE8hP2igP2+MRH
	 xa4AOV7+PjFomikfmcCEbT5cDHH+8VAozK90wB+EM5DanJGLztZ6Nbpi7TXiNMZlpz
	 kX5HnoXXmDRbR3v8vc/HiPkinbQNLEd/s9deNB2AlNFDVqBofVLsKMiT45/0s+G05F
	 +gVgO6KFDAObtjtpVHA/S+OXbnGxUqh55wKSb3ZaCwAbqV5osOgQWdHNFLdugcCBNE
	 sgu/JH48I/oo0bAzY3GMqo+ExrIms5bbKTzP7roC3ExqeLqZUDQh3OJIWny7hkQhUa
	 O39U57e0j1/CQ==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-746da717f35so350446a34.1;
        Fri, 05 Sep 2025 02:38:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCA/IZaAf5Ce2yo3yfmdfmJPFkbate3be4KLc7RtjZJm3D7PRnJdhHeKjLnnVKWvtel5IHaltXUoU=@vger.kernel.org, AJvYcCWL1UF+7ZimfdHMn0gVN/4Hk7SPxc+wPP059wN7zIHOyIrpAtyUog/fWbRaUx4XlWAbHC6USNSjESR9hr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwhXAtwK4rUwaBnJKledVvuiy8JPFMBtDrluT7ss0cxlA95+56
	/EQLLjQegj71BB5TtGPRIwjn0xduK6YsNZuwKMxk7+uRb7B6+4oMLj2YG4PDSyA1MP/S0LHSOQ9
	h+FyiaZ73brcXx6sWrf5mVUQ2XVa5BFc=
X-Google-Smtp-Source: AGHT+IGm7twXTPVY7IRIlpZAiiAReECz1MkEtN3DZ34Dl8XpNEF1Dovisp3FGfZxNEoD+Hz/ZCU5ARSyk+W8aTBrhQI=
X-Received: by 2002:a05:6830:4708:b0:742:f9b1:ee7d with SMTP id
 46e09a7af769-74569e08887mr10945527a34.16.1757065124802; Fri, 05 Sep 2025
 02:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821004237.2712312-1-wusamuel@google.com> <20250821004237.2712312-3-wusamuel@google.com>
 <CAJZ5v0gT2h_SgPDh=t-XWxgWnm8diG_rMuDVo-RnQxqvA7chPw@mail.gmail.com> <CAGETcx-3n9Qkiu70Pd2=sjSRsXNMf=CsJQdNLbHUS089qf=vsw@mail.gmail.com>
In-Reply-To: <CAGETcx-3n9Qkiu70Pd2=sjSRsXNMf=CsJQdNLbHUS089qf=vsw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 11:38:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gerKe7fmTh==F4HOOAmF60devB2N8pV1fn9QzX45JzAA@mail.gmail.com>
X-Gm-Features: Ac12FXxzM3VloGlZbcfgaU72dwB_dLGpcFI5tVBEhd5hWqEDrqBHuo1EcjCdORc
Message-ID: <CAJZ5v0gerKe7fmTh==F4HOOAmF60devB2N8pV1fn9QzX45JzAA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PM: Support aborting suspend during filesystem sync
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Samuel Wu <wusamuel@google.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 7:07=E2=80=AFAM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> On Fri, Sep 5, 2025 at 2:22=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> >
> > On Thu, Aug 21, 2025 at 2:43=E2=80=AFAM Samuel Wu <wusamuel@google.com>=
 wrote:
> > >
> > > At the start of suspend, filesystems will sync to save the current st=
ate
> > > of the device. However, the long tail of the filesystem sync can take
> > > upwards of 25 seconds. If during this filesystem sync there is some
> > > wakeup or abort signal, it will not be processed until the sync is
> > > complete; from a user's perspective, this looks like the device is
> > > unresponsive to any form of input.
> > >
> > > This patch adds functionality to handle a suspend abort signal when i=
n
> > > the filesystem sync phase of suspend. This topic was first discussed =
by
> > > Saravana Kannan at LPC 2024 [1], where the general consensus was to
> > > allow filesystem sync on a parallel thread.
> > >
> > > [1]: https://lpc.events/event/18/contributions/1845/
> > >
> > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> >
> > The idea is fine with me, but I have comments on the implementation.
> >
> > First off, I'm not sure how the split of patch [3/3] from this one
> > helps because that patch adds mandatory functionality.
>
> It makes the reviewing a lot easier -- at least for me. Especially if
> you want to come back and look at the change history. But we are happy
> to squash it if you feel strongly.
>
> >  Patch [2/3]
> > cannot be applied without patch [3/3], so as far as I'm concerned, it
> > is not applicable at all.
> >
> > > ---
> > >  drivers/base/power/wakeup.c |  8 +++++++
> > >  include/linux/suspend.h     |  2 ++
> > >  kernel/power/suspend.c      | 48 +++++++++++++++++++++++++++++++++++=
--
> > >  3 files changed, 56 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.=
c
> > > index d1283ff1080b..af4cf3e6ba44 100644
> > > --- a/drivers/base/power/wakeup.c
> > > +++ b/drivers/base/power/wakeup.c
> > > @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup=
_source *ws)
> > >
> > >         /* Increment the counter of events in progress. */
> > >         cec =3D atomic_inc_return(&combined_event_count);
> > > +       /*
> > > +        * wakeup_source_activate() aborts suspend only if events_che=
ck_enabled
> > > +        * is set (see pm_wakeup_pending()). Similarly, abort suspend=
 during
> > > +        * fs_sync only if events_check_enabled is set.
> > > +        */
> > > +       if (events_check_enabled)
> > > +               suspend_abort_fs_sync();
> > >
> > >         trace_wakeup_source_activate(ws->name, cec);
> > >  }
> > > @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> > >  void pm_system_wakeup(void)
> > >  {
> > >         atomic_inc(&pm_abort_suspend);
> > > +       suspend_abort_fs_sync();
> > >         s2idle_wake();
> > >  }
> > >  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> > > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > > index 317ae31e89b3..68d2e8a7eeb1 100644
> > > --- a/include/linux/suspend.h
> > > +++ b/include/linux/suspend.h
> > > @@ -276,6 +276,7 @@ extern void arch_suspend_enable_irqs(void);
> > >
> > >  extern int pm_suspend(suspend_state_t state);
> > >  extern bool sync_on_suspend_enabled;
> > > +extern void suspend_abort_fs_sync(void);
> > >  #else /* !CONFIG_SUSPEND */
> > >  #define suspend_valid_only_mem NULL
> > >
> > > @@ -296,6 +297,7 @@ static inline bool idle_should_enter_s2idle(void)=
 { return false; }
> > >  static inline void __init pm_states_init(void) {}
> > >  static inline void s2idle_set_ops(const struct platform_s2idle_ops *=
ops) {}
> > >  static inline void s2idle_wake(void) {}
> > > +static inline void suspend_abort_fs_sync(void) {}
> > >  #endif /* !CONFIG_SUSPEND */
> > >
> > >  static inline bool pm_suspend_in_progress(void)
> > > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > > index 4bb4686c1c08..edacd2a4143b 100644
> > > --- a/kernel/power/suspend.c
> > > +++ b/kernel/power/suspend.c
> > > @@ -31,6 +31,7 @@
> > >  #include <linux/compiler.h>
> > >  #include <linux/moduleparam.h>
> > >  #include <linux/fs.h>
> > > +#include <linux/workqueue.h>
> > >
> > >  #include "power.h"
> > >
> > > @@ -74,6 +75,19 @@ bool pm_suspend_default_s2idle(void)
> > >  }
> > >  EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
> > >
> > > +static DECLARE_COMPLETION(suspend_fs_sync_complete);
> > > +
> > > +/**
> > > + * suspend_abort_fs_sync - Abort fs_sync to abort suspend early
> >
> > This name is kind of misleading because the function doesn't abort
> > fs_sync.  It aborts suspend while fs_sync is in progress.
> >
> > The fs_sync is continuing and needs to be waited for to complete, at
> > least in subsequent suspend/hibernate cycles.
> >
> > Does system shutdown need to wait for it too?
>
> If the system shutdown does a sync in parallel, does it matter this
> one is going on in parallel too? Doesn't seem any different then
> shutting down right after userspace calls fsync.
>
> Also, we allow skip sync on suspend today. So I doubt shutdown depends
> on sync on suspend for correctness of shutdown.

What if the sync is still in progress when shutdown takes place?
Could shutdown somehow break it and cause data corruption, say?

> > > + *
> > > + * This function aborts the fs_sync stage of suspend so that suspend=
 itself can
> > > + * be aborted early.
> > > + */
> > > +void suspend_abort_fs_sync(void)
> > > +{
> > > +       complete(&suspend_fs_sync_complete);
> > > +}
> > > +
> > >  void s2idle_set_ops(const struct platform_s2idle_ops *ops)
> > >  {
> > >         unsigned int sleep_flags;
> > > @@ -403,6 +417,34 @@ void __weak arch_suspend_enable_irqs(void)
> > >         local_irq_enable();
> > >  }
> > >
> > > +static void sync_filesystems_fn(struct work_struct *work)
> > > +{
> > > +       ksys_sync_helper();
> > > +       complete(&suspend_fs_sync_complete);
> > > +}
> > > +static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
> > > +
> > > +/**
> > > + * suspend_fs_sync_with_abort - Trigger fs_sync with ability to abor=
t
> > > + *
> > > + * Return 0 on successful file system sync, otherwise returns -EBUSY=
 if file
> > > + * system sync was aborted.
> > > + */
> > > +static int suspend_fs_sync_with_abort(void)
> >
> > The "with_abort" part is not needed in this name and I'd prefer
> > pm_sleep_ to be used instead of suspend_
> >
> > > +{
> > > +       reinit_completion(&suspend_fs_sync_complete);
> > > +       schedule_work(&sync_filesystems);
> >
> > If you used a dedicated workqueue for this, waiting for the previously
> > scheduled filesystems sync would be as simple as calling
> > flush_workqueue(pm_fs_sync_wq);
>
> Yeah, that was our first thought too. But unfortunately, we might want
> to abort the suspend while the flush is happening (patch 3/3). Which
> we can't do with flush_workqueue() and we go back to square one where
> a suspend can't be aborted for a long time. That's why we need to
> write it this way.

So this is an optimization which I'm not sure is really necessary.
Maybe let's start with the flush_workqueue() approach and then
complicate things if it is demonstrated to be insufficient?

> >
> > > +       /*
> > > +        * Completion is triggered by fs_sync finishing or a suspend =
abort
> > > +        * signal, whichever comes first
> > > +        */
> > > +       wait_for_completion(&suspend_fs_sync_complete);
> > > +       if (pm_wakeup_pending())
> > > +               return -EBUSY;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  /**
> > >   * suspend_enter - Make the system enter the given sleep state.
> > >   * @state: System sleep state to enter.
> > > @@ -588,14 +630,16 @@ static int enter_state(suspend_state_t state)
> > >         if (state =3D=3D PM_SUSPEND_TO_IDLE)
> > >                 s2idle_begin();
> > >
> > > +       pm_wakeup_clear(0);
> > >         if (sync_on_suspend_enabled) {
> > >                 trace_suspend_resume(TPS("sync_filesystems"), 0, true=
);
> > > -               ksys_sync_helper();
> > > +               error =3D suspend_fs_sync_with_abort();
> >
> > The same thing would also be useful for hibernation.  Is there any
> > reason for not doing it there?
>
> No reason not to. We could add support for that in a different patch
> series?

Not really.

> Hibernate abort is not the top priority for us right now.

With all due respect, please handle them both or none.  Otherwise,
you'd create an arbitrary divergence that would become a maintenance
burden going forward.

Thanks!

