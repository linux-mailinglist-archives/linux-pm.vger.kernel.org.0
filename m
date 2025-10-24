Return-Path: <linux-pm+bounces-36768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93D8C05301
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 10:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFF740160E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 08:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCDE305E2D;
	Fri, 24 Oct 2025 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahFR4Xe4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5AB305E14
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295094; cv=none; b=oE7IGcA9rxP0oeokmC7oCu570cIrQSsQdu+n9OUo+bGp6g1O2kxjdq877fZwMaQeedXlhmsVkdtnrFAlEwmolfVgGlsMaURO17jTTu6ZMwhNH7e0x0ehPpNLDzsQBtoh64Ix6lfbzT+1QGCI5r+demCLcSU4i0VLVtxwtU67cyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295094; c=relaxed/simple;
	bh=7jbWwF4hBbdiXyxATfpKtCq76A/2hxuhoy8084Lb2bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJNRFhhLPwMzLncKCD8azWgVCxwbqabl8p49JCIggm8XXyT1/FgbVC6vYyFbFQUt3IVgeNof6SR94oROKnLcwI3zziXm+BQHLSyBnu6K0CVrxFg+jB8rHH+dbwoVh9fVYPPXEK6hh4zQm3CVtRhrZoAAfSNPE3bUayR0a70Hi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahFR4Xe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D916DC4AF0C
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 08:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761295093;
	bh=7jbWwF4hBbdiXyxATfpKtCq76A/2hxuhoy8084Lb2bw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ahFR4Xe4vGJQC0deTmW+3RZFAPIxiE9YwSaFuuhS8wNdyryDPBEpFWtB9Sj8iYtrb
	 rmzeV5WIuEQa7bf0kKpRa/h5pytdC2AeeswzvYZZquhh8H4o5DRfYAgac6a+9r5cFU
	 CPN3QSWs/O0qsrh8rYljFqPnOttajsvsKHVt7hZ1r5+27+rbRdFJ1o5CCPwlPXQVPT
	 doUMsSex0KkrLBAVwnTtI8DXY3uDVHYdH2Z4GOPdJQTw5tQev2AtMCTtkXp6HIx05/
	 pB3KeLHN65VzihCyIiKFNk8PV1xIINM9M91QhIhGbksTPoYqY+eEGLS7YH18KxUqmw
	 AMQCttexeYDAQ==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c3e2221217so307408a34.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 01:38:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTkkLpIbzvAZcj1Jdy/b8kuoYoZMi9g4Babdq2PGzKrPPTXYf4nwhcTPyoCrx2iMCjpekocVtIjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnFPp6Qb3mLNWqDLYBS/0584Zj8WtqxfXa2Uv4tEnvOiFYbdPv
	9z8IZ7wxDsjNuxxYnu+6I1NNEziGlEqfBFBNfaga/3Eyirenk878PjqaZ0bQlmtzImXRqOXSMe0
	WtnmtYHVUv0ejRWDoHXeXrFezd5QmnYg=
X-Google-Smtp-Source: AGHT+IFNMP+6PW+gib+wWUVkUGqGUDTOYSIW+l0A4z1HHfhVKizQqVUiVdiCiTKSMLQ7E3o9RJjoq3RhDrdeTNWgsYA=
X-Received: by 2002:a05:6808:6783:b0:438:40c3:875a with SMTP id
 5614622812f47-44bd416669amr2628692b6e.7.1761295093098; Fri, 24 Oct 2025
 01:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017233907.2305303-1-wusamuel@google.com> <CAJZ5v0g37NNj3inHcrZG8NHeTAGAncLAY7t9Yj3bTAv7GgAQJQ@mail.gmail.com>
 <CAGETcx8ZL3jAwFRxO1B8SFSWmC2jCitc9_61hBG-N2AvzRQv7w@mail.gmail.com>
In-Reply-To: <CAGETcx8ZL3jAwFRxO1B8SFSWmC2jCitc9_61hBG-N2AvzRQv7w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 24 Oct 2025 10:37:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jiLzMvwBfcXKJEOMqa_U=6OeWymnBCBdxYfcgU+7P1Aw@mail.gmail.com>
X-Gm-Features: AS18NWCBf9ARpxLgVmhFEb3gs4qG-h6lnqB7P0uzM2fl0gQtjRurOrUZXDDZMfg
Message-ID: <CAJZ5v0jiLzMvwBfcXKJEOMqa_U=6OeWymnBCBdxYfcgU+7P1Aw@mail.gmail.com>
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Samuel Wu <wusamuel@google.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, tuhaowen@uniontech.com, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 12:47=E2=80=AFAM Saravana Kannan <saravanak@google.=
com> wrote:
>
> On Thu, Oct 23, 2025 at 12:43=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > On Sat, Oct 18, 2025 at 1:39=E2=80=AFAM Samuel Wu <wusamuel@google.com>=
 wrote:
> > >
> > > At the start of suspend and hibernate, filesystems will sync to save =
the
> > > current state of the device. However, the long tail of the filesystem
> > > sync can take upwards of 25 seconds. If during this filesystem sync
> > > there is some wakeup or abort signal, it will not be processed until =
the
> > > sync is complete; from a user's perspective, this looks like the devi=
ce
> > > is unresponsive to any form of input.
> > >
> > > This patch adds functionality to handle a sleep abort signal when in
> > > the filesystem sync phase of suspend or hibernate. This topic was fir=
st
> > > discussed by Saravana Kannan at LPC 2024 [1], where the general
> > > consensus was to allow filesystem sync on a parallel thread. In case =
of
> > > abort, the suspend process will stop waiting on an in-progress
> > > filesystem sync, and continue by aborting suspend before the filesyst=
em
> > > sync is complete.
> > >
> > > Additionally, there is extra care needed to account for back-to-back
> > > sleeps while maintaining functionality to immediately abort during th=
e
> > > filesystem sync stage. This patch handles this by serializing the
> > > sequence with an invariant; a subsequent sleep's filesystem sync
> > > operation will only start when the previous sleep's filesystem sync h=
as
> > > finished. While waiting for the previous sleep's filesystem sync to
> > > finish, the subsequent sleep will still abort early if a wakeup event=
 is
> > > triggered, solving the original issue of filesystem sync blocking abo=
rt.
> >
> > It would be good to spell out the rationale for starting another
> > filesystem sync when suspend starts while the previous sync is still
> > in progress.
> >
> > > [1]: https://lpc.events/event/18/contributions/1845/
> > >
> > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > ---
> > > Changes in v5:
> > > - Update spin_lock() to spin_lock_irqsave() since abort can be in IRQ=
 context
> > > - Updated changelog description to be more precise regarding continui=
ng abort
> > >   sleep before fs_sync() is complete
> > > - Rename abort_sleep_during_fs_sync() to pm_stop_waiting_for_fs_sync(=
)
> > > - Simplify from a goto to do-while in pm_sleep_fs_sync()
> > > - v4 link: https://lore.kernel.org/all/20250911185314.2377124-1-wusam=
uel@google.com
> > >
> > > Changes in v4:
> > > - Removed patch 1/3 of v3 as it is already picked up on linux-pm
> > > - Squashed patches 2/3 and 3/3 from v3 into this single patch
> > > - Added abort during fs_sync functionality to hibernate in addition t=
o suspend
> > > - Moved variables and functions for abort from power/suspend.c to pow=
er/main.c
> > > - Renamed suspend_fs_sync_with_abort() to pm_sleep_fs_sync()
> > > - Renamed suspend_abort_fs_sync() to abort_sleep_during_fs_sync()
> > > - v3 link: https://lore.kernel.org/all/20250821004237.2712312-1-wusam=
uel@google.com/
> > >
> > > Changes in v3:
> > > - Split v2 patch into 3 patches
> > > - Moved pm_wakeup_clear() outside of if(sync_on_suspend_enabled) cond=
ition
> > > - Updated documentation and comments within kernel/power/suspend.c
> > > - v2 link: https://lore.kernel.org/all/20250812232126.1814253-1-wusam=
uel@google.com/
> > >
> > > Changes in v2:
> > > - Added documentation for suspend_abort_fs_sync()
> > > - Made suspend_fs_sync_lock and suspend_fs_sync_complete declaration =
static
> > > - v1 link: https://lore.kernel.org/all/20250815004635.3684650-1-wusam=
uel@google.com
> > >
> > >  drivers/base/power/wakeup.c |  8 ++++
> > >  include/linux/suspend.h     |  4 ++
> > >  kernel/power/hibernate.c    |  5 ++-
> > >  kernel/power/main.c         | 75 +++++++++++++++++++++++++++++++++++=
++
> > >  kernel/power/suspend.c      |  7 +++-
> > >  5 files changed, 96 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.=
c
> > > index d1283ff1080b..689c16b08b38 100644
> > > --- a/drivers/base/power/wakeup.c
> > > +++ b/drivers/base/power/wakeup.c
> > > @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup=
_source *ws)
> > >
> > >         /* Increment the counter of events in progress. */
> > >         cec =3D atomic_inc_return(&combined_event_count);
> > > +       /*
> > > +        * wakeup_source_activate() aborts sleep only if events_check=
_enabled
> > > +        * is set (see pm_wakeup_pending()). Similarly, abort sleep d=
uring
> > > +        * fs_sync only if events_check_enabled is set.
> > > +        */
> > > +       if (events_check_enabled)
> > > +               pm_stop_waiting_for_fs_sync();
> > >
> > >         trace_wakeup_source_activate(ws->name, cec);
> > >  }
> > > @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> > >  void pm_system_wakeup(void)
> > >  {
> > >         atomic_inc(&pm_abort_suspend);
> > > +       pm_stop_waiting_for_fs_sync();
> > >         s2idle_wake();
> > >  }
> > >  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> > > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > > index b02876f1ae38..dc6829b3836f 100644
> > > --- a/include/linux/suspend.h
> > > +++ b/include/linux/suspend.h
> > > @@ -450,6 +450,8 @@ void restore_processor_state(void);
> > >  extern int register_pm_notifier(struct notifier_block *nb);
> > >  extern int unregister_pm_notifier(struct notifier_block *nb);
> > >  extern void ksys_sync_helper(void);
> > > +extern void pm_stop_waiting_for_fs_sync(void);
> > > +extern int pm_sleep_fs_sync(void);
> > >  extern void pm_report_hw_sleep_time(u64 t);
> > >  extern void pm_report_max_hw_sleep(u64 t);
> > >  void pm_restrict_gfp_mask(void);
> > > @@ -505,6 +507,8 @@ static inline void pm_restrict_gfp_mask(void) {}
> > >  static inline void pm_restore_gfp_mask(void) {}
> > >
> > >  static inline void ksys_sync_helper(void) {}
> > > +static inline pm_stop_waiting_for_fs_sync(void) {}
> > > +static inline int pm_sleep_fs_sync(void) {}
> > >
> > >  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
> > >
> > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > index 14e85ff23551..9c8db4b3c114 100644
> > > --- a/kernel/power/hibernate.c
> > > +++ b/kernel/power/hibernate.c
> > > @@ -824,7 +824,10 @@ int hibernate(void)
> > >         if (error)
> > >                 goto Restore;
> > >
> > > -       ksys_sync_helper();
> > > +       error =3D pm_sleep_fs_sync();
> > > +       if (error)
> > > +               goto Restore;
> > > +
> > >         if (filesystem_freeze_enabled)
> > >                 filesystems_freeze();
> > >
> > > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > > index 3cf2d7e72567..81a53d833358 100644
> > > --- a/kernel/power/main.c
> > > +++ b/kernel/power/main.c
> > > @@ -570,6 +570,81 @@ bool pm_sleep_transition_in_progress(void)
> > >  {
> > >         return pm_suspend_in_progress() || hibernation_in_progress();
> > >  }
> > > +
> > > +static bool pm_sleep_fs_sync_queued;
> > > +static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
> > > +static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
> > > +
> > > +/**
> > > + * pm_stop_waiting_for_fs_sync - Abort fs_sync to abort sleep early
> > > + *
> > > + * This function causes the suspend process to stop waiting on an in=
-progress
> > > + * filesystem sync, such that the suspend process can be aborted bef=
ore the
> > > + * filesystem sync is complete.
> > > + */
> > > +void pm_stop_waiting_for_fs_sync(void)
> > > +{
> > > +       unsigned long flags;
> > > +
> > > +       spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > > +       complete(&pm_sleep_fs_sync_complete);
> > > +       spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> > > +}
> > > +
> > > +static void sync_filesystems_fn(struct work_struct *work)
> > > +{
> > > +       unsigned long flags;
> > > +
> > > +       ksys_sync_helper();
> > > +       spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > > +       pm_sleep_fs_sync_queued =3D false;
> > > +       complete(&pm_sleep_fs_sync_complete);
> > > +       spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> > > +}
> > > +static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
> > > +
> > > +/**
> > > + * pm_sleep_fs_sync - Trigger fs_sync with ability to abort
> > > + *
> > > + * Return 0 on successful file system sync, otherwise returns -EBUSY=
 if file
> > > + * system sync was aborted.
> > > + */
> > > +int pm_sleep_fs_sync(void)
> > > +{
> > > +       bool need_pm_sleep_fs_sync_requeue;
> > > +       unsigned long flags;
> > > +
> > > +       do {
> > > +               spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > > +               reinit_completion(&pm_sleep_fs_sync_complete);
> > > +               /*
> > > +                * Handle the case where a sleep immediately follows =
a previous
> > > +                * sleep that was aborted during fs_sync. In this cas=
e, wait for
> > > +                * the previous filesystem sync to finish. Then do an=
other
> > > +                * filesystem sync so any subsequent filesystem chang=
es are
> > > +                * synced before sleeping.
> > > +                */
> > > +               if (pm_sleep_fs_sync_queued) {
> > > +                       need_pm_sleep_fs_sync_requeue =3D true;
> > > +               } else {
> > > +                       need_pm_sleep_fs_sync_requeue =3D false;
> > > +                       pm_sleep_fs_sync_queued =3D true;
> > > +                       schedule_work(&sync_filesystems);
> > > +               }
> > > +               spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags)=
;
> > > +
> > > +               /*
> > > +                * Completion is triggered by fs_sync finishing or an=
 abort sleep
> > > +                * signal, whichever comes first
> > > +                */
> > > +               wait_for_completion(&pm_sleep_fs_sync_complete);
> > > +               if (pm_wakeup_pending())
> > > +                       return -EBUSY;
> > > +       } while (need_pm_sleep_fs_sync_requeue);
> > > +
> > > +       return 0;
> > > +}
> >
> > If I'm not mistaken, the mechanism by which one more sync is started
> > right after completing the previous one (that was in progress when
> > suspend started) can be designed differently.
> >
> > 1. Use a dedicated ordered workqueue for the sync work items.
> > 2. Use a counter instead of the two boolean vars for synchronization.
> > 3. In pm_sleep_fs_sync(), if the counter is less than 2, increment the
> > counter and queue up a sync work item.
> > 4. In sync_filesystems_fn(), decrement the counter.
>
> The problem with this is that we can't reuse the same work item. We'll
> have to allocate one each time. Otherwise, we'll be queuing one that's
> already queued. Right?

Of course you can't queue up an already queued work, but there may be
two of them and then in 3 above use work0 when the counter is 0 and
use work1 when the counter is 1.  No big deal.

