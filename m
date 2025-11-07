Return-Path: <linux-pm+bounces-37656-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED97FC41C37
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 22:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C3464F4F6E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 21:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524F3238178;
	Fri,  7 Nov 2025 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjSRCErY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D22B1F461A
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762550169; cv=none; b=tdt2/AMKEozAeGuPEcruTFcLKLi6Ozh/9LDcishZsFUg4Y7nZ370V08pCKBygffZrZ6gUJ45wEPlJxbx4a5hGUocg3kgsRSRL/dlkUom+2qqxZLVyBDzjz0CbHb7eNuYqoQwz/svOYZwKg7kibRPNzf6m3wDEA+uyGkXNrA/uF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762550169; c=relaxed/simple;
	bh=jahd1A6NrGjxxhSg5p+0yLuTk6UAdJ7dcQOlFjdsY+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+UrrcsL8cCbfAHzq77wUsb8/JkxUdacWhyAMJrwiZtyKGNfSoBRSjdIgaBuPbEQ00xsag01ewPmTagny/b+DzdiWAg4GfICWZ5LyWQIcpFeOKmxA+/xMio1ZKUKnmqTMXdl8gnyGAfpymnTsRQ0yOnSRPSPAvh3KM3vWnAUW0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjSRCErY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE745C4CEF8
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 21:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762550168;
	bh=jahd1A6NrGjxxhSg5p+0yLuTk6UAdJ7dcQOlFjdsY+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VjSRCErYA6jYjIN9rOK7lEsOQWy4EPMqhFBKDPrbySzk3vztBS8dSsmb3jJrWLWVW
	 mJH1eZGLVUDws1cbXriawj/qk0yFWdpF2cAHwLVo8E6q15o4nMD+s5gCP7aj2s0J4l
	 +bXb8dtloznazmRmHTHGZsrjn+GLD12NGyUikjJj8iWEDr/JQ8lWDkRoILc8xmd+k/
	 NbOWmAGPrsWhZDErCg9FWMB8GqTrXxIIbwLuZoXwxO4SkyfKLHEAKsOXVU6xfgDKh/
	 pMqjg2kjCD0sIbw9se8Z9rIrohIaBOC5hWRhhKlvL9AVSglsGL/RVioLS4VQMACy6c
	 XepAMWoF2EI2g==
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-43325879139so11052495ab.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 13:16:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJa4xqqHRBuHD6Yfb6cWUdihFmSwYC54u+yOIRc3C/j3+gNTeeNKENx0Ww8T42ViY15puVSMdisA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVlxhpIPyN2b0PfIKEMOO6UDOkG0hfZnydlCFRo9imrfXsMwOG
	e8xnDF3+Xhmy/OcKKaPQKkJESI/yyOolGGZEcUyNL4Z5yejSDL+ipjjzOx5BQIhbeEYYVlRxY5w
	Sd6866SUy6LaO5JVHW4WK2z0jzPys0hU=
X-Google-Smtp-Source: AGHT+IE6smacNZz38kBqN1RpQOUoT8tWfgpyKwx3hnYYSUV4uyLAydqFqqiSZcZzvb8zebIK1oyZAJ05DVrvdODlcbc=
X-Received: by 2002:a05:6820:825:b0:654:f193:26dc with SMTP id
 006d021491bc7-656d879cd39mr508579eaf.2.1762549668939; Fri, 07 Nov 2025
 13:07:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030210110.298612-1-wusamuel@google.com> <CAJZ5v0gzKN1cXfj508G4_9O2hKR0HncW4et3BNbaV+5Erh=LMA@mail.gmail.com>
 <CAG2KctonFbbN9KrKWweQWaRKNN=rZkpWQCmyyY2rKfcAUzF=sA@mail.gmail.com> <CAJZ5v0g6F+iEdicqSBb5M6-EfKfdW3vfwsxa98H2mrn5by6hPA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g6F+iEdicqSBb5M6-EfKfdW3vfwsxa98H2mrn5by6hPA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 22:07:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iuRkf+xDHSiioZV=4-8PLx1eOz3bzojvuuC_Y1ZP1-VA@mail.gmail.com>
X-Gm-Features: AWmQ_bnp_4FQtp7B5FhBSSlBtxcVN6lgCv3FIUniU7YATlV4GMTiyjj6fTKnKjw
Message-ID: <CAJZ5v0iuRkf+xDHSiioZV=4-8PLx1eOz3bzojvuuC_Y1ZP1-VA@mail.gmail.com>
Subject: Re: [PATCH v6] PM: Support aborting sleep during filesystem sync
To: Samuel Wu <wusamuel@google.com>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, tuhaowen@uniontech.com, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 9:58=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Wed, Nov 5, 2025 at 2:20=E2=80=AFAM Samuel Wu <wusamuel@google.com> wr=
ote:
> >
> > On Tue, Nov 4, 2025 at 10:52=E2=80=AFAM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Thu, Oct 30, 2025 at 10:01=E2=80=AFPM Samuel Wu <wusamuel@google.c=
om> wrote:
> > > >
> > > > At the start of suspend and hibernate, filesystems will sync to sav=
e the
> > > > current state of the device. However, the long tail of the filesyst=
em
> > > > sync can take upwards of 25 seconds. If during this filesystem sync
> > > > there is some wakeup or abort signal, it will not be processed unti=
l the
> > > > sync is complete; from a user's perspective, this looks like the de=
vice
> > > > is unresponsive to any form of input.
> > > >
> > > > This patch adds functionality to handle a sleep abort signal when i=
n
> > > > the filesystem sync phase of suspend or hibernate. This topic was f=
irst
> > > > discussed by Saravana Kannan at LPC 2024 [1], where the general
> > > > consensus was to allow filesystem sync on a parallel thread. In cas=
e of
> > > > abort, the suspend process will stop waiting on an in-progress
> > > > filesystem sync, and continue by aborting suspend before the filesy=
stem
> > > > sync is complete.
> > > >
> > > > Additionally, there is extra care needed to account for back-to-bac=
k
> > > > sleeps while maintaining functionality to immediately abort during =
the
> > > > filesystem sync stage. Furthermore, in the case of the back-to-back
> > > > sleeps, a subsequent filesystem sync is needed to ensure the latest
> > > > files are synced right before sleep. If necessary, a subsequent sle=
ep's
> > > > filesystem sync will be queued, and will only start when the previo=
us
> > > > sleep's filesystem sync has finished. While waiting for the previou=
s
> > > > sleep's filesystem sync to finish, the subsequent sleep will still =
abort
> > > > early if a wakeup event is triggered, solving the original issue of
> > > > filesystem sync blocking abort.
> > > >
> > > > [1]: https://lpc.events/event/18/contributions/1845/
> > > >
> > > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > > ---
> > > > Changes in v6:
> > > > - Use spin_lock_irq() in thread context
> > > > - Use dedicated ordered workqueue for sync work items
> > > > - Use a counter instead of two bools for synchronization
> > > > - Queue fs_sync if it's not already pending on workqueue
> > > > - pm_wakeup_clear(0) is prequisite to this feature, so move it with=
in function
> > > > - Updated commit text for motive of back-to-back fs syncs
> > > > - Tighter lock/unlock around setup, checks, and loop
> > > > - Fix function definitions for CONFIG_PM_SLEEP=3Dn
> > > > - v5 link: https://lore.kernel.org/all/20251017233907.2305303-1-wus=
amuel@google.com/
> > > >
> > > > Changes in v5:
> > > > - Update spin_lock() to spin_lock_irqsave() since abort can be in I=
RQ context
> > > > - Updated changelog description to be more precise regarding contin=
uing abort
> > > >   sleep before fs_sync() is complete
> > > > - Rename abort_sleep_during_fs_sync() to pm_stop_waiting_for_fs_syn=
c()
> > > > - Simplify from a goto to do-while in pm_sleep_fs_sync()
> > > > - v4 link: https://lore.kernel.org/all/20250911185314.2377124-1-wus=
amuel@google.com
> > > >
> > > > Changes in v4:
> > > > - Removed patch 1/3 of v3 as it is already picked up on linux-pm
> > > > - Squashed patches 2/3 and 3/3 from v3 into this single patch
> > > > - Added abort during fs_sync functionality to hibernate in addition=
 to suspend
> > > > - Moved variables and functions for abort from power/suspend.c to p=
ower/main.c
> > > > - Renamed suspend_fs_sync_with_abort() to pm_sleep_fs_sync()
> > > > - Renamed suspend_abort_fs_sync() to abort_sleep_during_fs_sync()
> > > > - v3 link: https://lore.kernel.org/all/20250821004237.2712312-1-wus=
amuel@google.com/
> > > >
> > > > Changes in v3:
> > > > - Split v2 patch into 3 patches
> > > > - Moved pm_wakeup_clear() outside of if(sync_on_suspend_enabled) co=
ndition
> > > > - Updated documentation and comments within kernel/power/suspend.c
> > > > - v2 link: https://lore.kernel.org/all/20250812232126.1814253-1-wus=
amuel@google.com/
> > > >
> > > > Changes in v2:
> > > > - Added documentation for suspend_abort_fs_sync()
> > > > - Made suspend_fs_sync_lock and suspend_fs_sync_complete declaratio=
n static
> > > > - v1 link: https://lore.kernel.org/all/20250815004635.3684650-1-wus=
amuel@google.com
> > > >
> > > >  drivers/base/power/wakeup.c |  8 ++++
> > > >  include/linux/suspend.h     |  4 ++
> > > >  kernel/power/hibernate.c    |  5 ++-
> > > >  kernel/power/main.c         | 81 +++++++++++++++++++++++++++++++++=
++++
> > > >  kernel/power/suspend.c      |  4 +-
> > > >  5 files changed, 100 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeu=
p.c
> > > > index d1283ff1080b..689c16b08b38 100644
> > > > --- a/drivers/base/power/wakeup.c
> > > > +++ b/drivers/base/power/wakeup.c
> > > > @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wake=
up_source *ws)
> > > >
> > > >         /* Increment the counter of events in progress. */
> > > >         cec =3D atomic_inc_return(&combined_event_count);
> > > > +       /*
> > > > +        * wakeup_source_activate() aborts sleep only if events_che=
ck_enabled
> > > > +        * is set (see pm_wakeup_pending()). Similarly, abort sleep=
 during
> > > > +        * fs_sync only if events_check_enabled is set.
> > > > +        */
> > > > +       if (events_check_enabled)
> > > > +               pm_stop_waiting_for_fs_sync();
> > > >
> > > >         trace_wakeup_source_activate(ws->name, cec);
> > > >  }
> > > > @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> > > >  void pm_system_wakeup(void)
> > > >  {
> > > >         atomic_inc(&pm_abort_suspend);
> > > > +       pm_stop_waiting_for_fs_sync();
> > > >         s2idle_wake();
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> > > > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > > > index b02876f1ae38..4795f55f9cbe 100644
> > > > --- a/include/linux/suspend.h
> > > > +++ b/include/linux/suspend.h
> > > > @@ -450,6 +450,8 @@ void restore_processor_state(void);
> > > >  extern int register_pm_notifier(struct notifier_block *nb);
> > > >  extern int unregister_pm_notifier(struct notifier_block *nb);
> > > >  extern void ksys_sync_helper(void);
> > > > +extern void pm_stop_waiting_for_fs_sync(void);
> > > > +extern int pm_sleep_fs_sync(void);
> > > >  extern void pm_report_hw_sleep_time(u64 t);
> > > >  extern void pm_report_max_hw_sleep(u64 t);
> > > >  void pm_restrict_gfp_mask(void);
> > > > @@ -505,6 +507,8 @@ static inline void pm_restrict_gfp_mask(void) {=
}
> > > >  static inline void pm_restore_gfp_mask(void) {}
> > > >
> > > >  static inline void ksys_sync_helper(void) {}
> > > > +static inline void pm_stop_waiting_for_fs_sync(void) {}
> > > > +static inline int pm_sleep_fs_sync(void) { return 0; }
> > > >
> > > >  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
> > > >
> > > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > > index 53166ef86ba4..1874fde4b4f3 100644
> > > > --- a/kernel/power/hibernate.c
> > > > +++ b/kernel/power/hibernate.c
> > > > @@ -820,7 +820,10 @@ int hibernate(void)
> > > >         if (error)
> > > >                 goto Restore;
> > > >
> > > > -       ksys_sync_helper();
> > > > +       error =3D pm_sleep_fs_sync();
> > > > +       if (error)
> > > > +               goto Restore;
> > > > +
> > > >         if (filesystem_freeze_enabled)
> > > >                 filesystems_freeze();
> > > >
> > > > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > > > index a6cbc3f4347a..23ca87a172a4 100644
> > > > --- a/kernel/power/main.c
> > > > +++ b/kernel/power/main.c
> > > > @@ -582,6 +582,84 @@ bool pm_sleep_transition_in_progress(void)
> > > >  {
> > > >         return pm_suspend_in_progress() || hibernation_in_progress(=
);
> > > >  }
> > > > +
> > > > +static int pm_sleep_fs_syncs_queued;
> > > > +static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
> > > > +static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
> > > > +static struct workqueue_struct *pm_fs_sync_wq;
> > > > +
> > > > +static int __init pm_start_fs_sync_workqueue(void)
> > > > +{
> > > > +       pm_fs_sync_wq =3D alloc_ordered_workqueue("pm_fs_sync_wq", =
0);
> > > > +
> > > > +       return pm_fs_sync_wq ? 0 : -ENOMEM;
> > > > +}
> > > > +
> > > > +/**
> > > > + * pm_stop_waiting_for_fs_sync - Abort fs_sync to abort sleep earl=
y
> > > > + *
> > > > + * This function causes the suspend process to stop waiting on an =
in-progress
> > > > + * filesystem sync, such that the suspend process can be aborted b=
efore the
> > > > + * filesystem sync is complete.
> > > > + */
> > > > +void pm_stop_waiting_for_fs_sync(void)
> > > > +{
> > > > +       unsigned long flags;
> > > > +
> > > > +       spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > > > +       complete(&pm_sleep_fs_sync_complete);
> > > > +       spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> > > > +}
> > >
> > > Apart from the kernel test robot reports,
> >
> > Of course, I'll fix this in v7.
> >
> > > pm_stop_waiting_for_fs_sync() has become slightly too heavy for
> > > calling it from wakeup_source_activate().
> >
> > Trying to understand- are you saying spin_lock_irqsave() makes
> > pm_stop_waiting_for_fs_sync() too slow?
>
> Spin lock and the completion handling.
>
> This function has been designed to be as lightweight as reasonably
> possible and the $subject patch is adding a branch and a global
> spinlock locking to it.
>
> > > Waking up the suspend process from there should be sufficient.  The
> > > completion is not necessary for that in principle.
> >
> > Can you elaborate more on what "there" means and why completion isn't
> > necessary? From what I can see, the only way to abort the suspend
> > _early_ is with the completion.
>
> Well, there are wait queues.
>
> In the first place though, do you really need to stop the suspend
> process immediately after a wakeup event?
>
> This generally does not happen and wakeup sources are designed with
> the assumption that it need not happen: The suspend process will check
> if there is a pending wakeup at some places and wakeup sources just
> need to update the counters.
>
> Quite frankly, I don't see why the filesystem sync period needs to be
> special in that respect.  And if it need not be special, nothing needs
> to be added to wakeup_source_activate().

In case it is unclear where I'm going with this, the suspend process
can be made use wait_event_timeout() with a timeout of, say, 20 ms to
wait for pm_sleep_fs_syncs_queued to drop down to 0 in a loop and
check pm_wakeup_pending() in every iteration.

