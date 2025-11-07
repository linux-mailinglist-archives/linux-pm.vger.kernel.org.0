Return-Path: <linux-pm+bounces-37655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5A3C41AA0
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 21:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4348B4E0689
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 20:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B0E30E846;
	Fri,  7 Nov 2025 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVF7aB53"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0659123A9B3
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549115; cv=none; b=JR6tw/UKSXotksDfGs3GRv4odUN5rjytRMoneF3m7N1oHk/7r4dXLISc4O2h69OYmHXocDoo34KHAPh3xHQcaqQun3nBZXks/A5QtAcffUFk4Obil6acrDj+cB6jXVxkM0gXQEhYygIELBiIdAKDiT4RGia1NFC+rFC/BsQ21M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549115; c=relaxed/simple;
	bh=iUq0bsAV3M+TRuQJgO2p1d6Al5A/ILBH5+OR693PeGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTmWO21iA16L9OJNXEO1A7zXPX/US8L2e7TIfxFCUSlhOG5gq2t3w2EaYfdRHba3yI+S94d/BEzV8dq+b2V7odfsqKz417cZDJd4xEgUwN2B0PzSNwNtZYxUdoGkrC6OZcJ7PpJ3/mwBeviF+1fnKRrHhOwpoL7pTWAJmxdguSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVF7aB53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D55C2BC87
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 20:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762549114;
	bh=iUq0bsAV3M+TRuQJgO2p1d6Al5A/ILBH5+OR693PeGk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RVF7aB53pdDgGCGtPAw++52vi+KAK578Lyb1qga/ht6SUD9w87O+IkOuhUbLm1/VD
	 ARSrpdCS1kNiWQ/+yVfg5D2ugW6/khSgn+kb3oUTD3ZjVU0hr7U8Y1/kqRLDQ7shvm
	 0j6Do0F31Pf4M601H56IgHvoydDxdZ6+wONNwN4BEjLA9BHySynfoFRdVCHcvI1g6s
	 kP+7ZNJkaZPnuxykh7HxRoxGjvD9bWVtd1R86TtgmIWbie2HbcvMsd60aOXW85N58P
	 M6ZBxI6gi5R4dmawkvbLbA+U76uMZdEjKTvetSM4suOmEU9AlRSYxT1+Zfdy9CYRuv
	 5wqJos0DInUpg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-656c4ed6ea9so216489eaf.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 12:58:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmzznZdMqLq2ApqrnUDxl7upybCGm9Ps8FkrH6EefaCL2HQ+XmcTdgejS3BjgqcBlwtaQgYUWD7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtbkLIVhQyjsKfP7XZKMC6a2n1kG5q9twZHwAXYPaOn7nmFYjR
	I0tBmKyx0ueiZLGLc0wz0rrL6LyERmZUW4OyIwsXl+CiZCbB2v4Mxq+s0E8zzQl4IA5tRWr9HqP
	kwDaib6mAXinGtxlLFl1Tbz1BzGy2d7M=
X-Google-Smtp-Source: AGHT+IGO+47BAZKtpv7PN90zNrlKFOfKGAVtIiUUWQdWGLi0JsCvuPgSS/0JSI1e6C4DpbY+MVmZXTHIscDGD5ggRFo=
X-Received: by 2002:a05:6808:c148:b0:43f:64bc:8b7e with SMTP id
 5614622812f47-4502a1d85e0mr415404b6e.15.1762549113720; Fri, 07 Nov 2025
 12:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030210110.298612-1-wusamuel@google.com> <CAJZ5v0gzKN1cXfj508G4_9O2hKR0HncW4et3BNbaV+5Erh=LMA@mail.gmail.com>
 <CAG2KctonFbbN9KrKWweQWaRKNN=rZkpWQCmyyY2rKfcAUzF=sA@mail.gmail.com>
In-Reply-To: <CAG2KctonFbbN9KrKWweQWaRKNN=rZkpWQCmyyY2rKfcAUzF=sA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 21:58:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g6F+iEdicqSBb5M6-EfKfdW3vfwsxa98H2mrn5by6hPA@mail.gmail.com>
X-Gm-Features: AWmQ_bnAouEQQKPJ4YOtDONxAXNKBzmg44egm746mG12focbDzwPedbl84e4Pg0
Message-ID: <CAJZ5v0g6F+iEdicqSBb5M6-EfKfdW3vfwsxa98H2mrn5by6hPA@mail.gmail.com>
Subject: Re: [PATCH v6] PM: Support aborting sleep during filesystem sync
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, tuhaowen@uniontech.com, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 2:20=E2=80=AFAM Samuel Wu <wusamuel@google.com> wrot=
e:
>
> On Tue, Nov 4, 2025 at 10:52=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Thu, Oct 30, 2025 at 10:01=E2=80=AFPM Samuel Wu <wusamuel@google.com=
> wrote:
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
> > > filesystem sync stage. Furthermore, in the case of the back-to-back
> > > sleeps, a subsequent filesystem sync is needed to ensure the latest
> > > files are synced right before sleep. If necessary, a subsequent sleep=
's
> > > filesystem sync will be queued, and will only start when the previous
> > > sleep's filesystem sync has finished. While waiting for the previous
> > > sleep's filesystem sync to finish, the subsequent sleep will still ab=
ort
> > > early if a wakeup event is triggered, solving the original issue of
> > > filesystem sync blocking abort.
> > >
> > > [1]: https://lpc.events/event/18/contributions/1845/
> > >
> > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > ---
> > > Changes in v6:
> > > - Use spin_lock_irq() in thread context
> > > - Use dedicated ordered workqueue for sync work items
> > > - Use a counter instead of two bools for synchronization
> > > - Queue fs_sync if it's not already pending on workqueue
> > > - pm_wakeup_clear(0) is prequisite to this feature, so move it within=
 function
> > > - Updated commit text for motive of back-to-back fs syncs
> > > - Tighter lock/unlock around setup, checks, and loop
> > > - Fix function definitions for CONFIG_PM_SLEEP=3Dn
> > > - v5 link: https://lore.kernel.org/all/20251017233907.2305303-1-wusam=
uel@google.com/
> > >
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
> > >  kernel/power/main.c         | 81 +++++++++++++++++++++++++++++++++++=
++
> > >  kernel/power/suspend.c      |  4 +-
> > >  5 files changed, 100 insertions(+), 2 deletions(-)
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
> > > index b02876f1ae38..4795f55f9cbe 100644
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
> > > +static inline void pm_stop_waiting_for_fs_sync(void) {}
> > > +static inline int pm_sleep_fs_sync(void) { return 0; }
> > >
> > >  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
> > >
> > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > index 53166ef86ba4..1874fde4b4f3 100644
> > > --- a/kernel/power/hibernate.c
> > > +++ b/kernel/power/hibernate.c
> > > @@ -820,7 +820,10 @@ int hibernate(void)
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
> > > index a6cbc3f4347a..23ca87a172a4 100644
> > > --- a/kernel/power/main.c
> > > +++ b/kernel/power/main.c
> > > @@ -582,6 +582,84 @@ bool pm_sleep_transition_in_progress(void)
> > >  {
> > >         return pm_suspend_in_progress() || hibernation_in_progress();
> > >  }
> > > +
> > > +static int pm_sleep_fs_syncs_queued;
> > > +static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
> > > +static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
> > > +static struct workqueue_struct *pm_fs_sync_wq;
> > > +
> > > +static int __init pm_start_fs_sync_workqueue(void)
> > > +{
> > > +       pm_fs_sync_wq =3D alloc_ordered_workqueue("pm_fs_sync_wq", 0)=
;
> > > +
> > > +       return pm_fs_sync_wq ? 0 : -ENOMEM;
> > > +}
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
> >
> > Apart from the kernel test robot reports,
>
> Of course, I'll fix this in v7.
>
> > pm_stop_waiting_for_fs_sync() has become slightly too heavy for
> > calling it from wakeup_source_activate().
>
> Trying to understand- are you saying spin_lock_irqsave() makes
> pm_stop_waiting_for_fs_sync() too slow?

Spin lock and the completion handling.

This function has been designed to be as lightweight as reasonably
possible and the $subject patch is adding a branch and a global
spinlock locking to it.

> > Waking up the suspend process from there should be sufficient.  The
> > completion is not necessary for that in principle.
>
> Can you elaborate more on what "there" means and why completion isn't
> necessary? From what I can see, the only way to abort the suspend
> _early_ is with the completion.

Well, there are wait queues.

In the first place though, do you really need to stop the suspend
process immediately after a wakeup event?

This generally does not happen and wakeup sources are designed with
the assumption that it need not happen: The suspend process will check
if there is a pending wakeup at some places and wakeup sources just
need to update the counters.

Quite frankly, I don't see why the filesystem sync period needs to be
special in that respect.  And if it need not be special, nothing needs
to be added to wakeup_source_activate().

