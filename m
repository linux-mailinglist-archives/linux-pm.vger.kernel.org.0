Return-Path: <linux-pm+bounces-37871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05B4C54498
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 20:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1154D3A5F3F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 19:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BF7337B8A;
	Wed, 12 Nov 2025 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3/48C949"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F2280CFC
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976340; cv=none; b=C2bE9fyAtcrAQRBbJMiyO9++lPVxVCNFH8cMl6W8tPW/rFpKQWeKE32LPBJv7c2O50k3shAUJOt+bcexYQ4Cb/3ApXYWG+lPlxRjTWt4HevHZrbD/pX7W20tUZo7qsvqb5hO7ltY8BK/AmWOenlQBMSO+aXZAGHjRNbsDfIqA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976340; c=relaxed/simple;
	bh=E2HD+c51SZ97bkXCjzHmyamdQL6ZOVeflviKQgbUD/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4/ewFB9GejR1VGGEu4dh0mofq8luMxwphFyTIG14v3uve1uixsCac4ZqMKVvBqN+SkV/fYM2+UxPVamtYGtMnL4fJctFkSJDU7LJaFaY/ad7hOYvvuJpzzY5rnLcPzFys9th5Oma077ngf6An9Z4II4mqDB4zpah4mEpciNK9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3/48C949; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b72db05e50fso222208066b.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 11:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762976337; x=1763581137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDsJItWN3I00tdRKqku+snq63VDDa3w8qQtSqI5tEPw=;
        b=3/48C949j6gaSbMK16DL+LMnpYe8ejKwBvLPaYh+CPvUqAsOJVkij1EzJWBCP81HqD
         xECXCxoS8VnSnm3qm0FfXL1oDmeJcILX4YohhWx7gFz4cQnLX5YzRvJb8DpGyWKF6B9z
         Q07/2rJ2NrPD55NpQaw/cT/xlkIfhr0l6I/aFZPwi2lFvtwoptQdEUr/JWw+EoAid58L
         HbchZiWxqRksXMHgvaal1y53hV5coGiiUBC9AKzNUA4aUBTfeYQBAjeDINIUbzTYbUNh
         SCjt6oqiMrMH7X/LndLMS0zcNMNq4W1kSvFsDqoFOKMv6KSoefyrT5uSE6Ji4D8put8W
         mrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762976337; x=1763581137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pDsJItWN3I00tdRKqku+snq63VDDa3w8qQtSqI5tEPw=;
        b=K91SGtv82nt2CeKBYWwPq1vyulqFq7uXLZvdmM/LwbuP+/aNDyBh/08QX0/NuCs65V
         XxJpu9SX4qq1FrL8i8xudGEEZivk6TQiDFhPpJBKSZEE2QIAGtJrmEZQhF54RMvNm+9X
         ztDAoF/WmGxutdOTkKY3UobEHBoH8W15h27DSEjTIF74lUeC1iaANyx9usRN/wiTWjJO
         NAJkp11Q7WiaQCNnsd6rd0ove1Lt7bJGMIZBD9rlAo8FObZjC0/gFmKTrlSnqUq1bGax
         c10JKs6YVFVjFbGz/jqArQxuSl0Z8WXTjBRASZvpwsC+hBUPcoJGbuUoyG0Rjcx8dhYN
         ZdUw==
X-Forwarded-Encrypted: i=1; AJvYcCUKa6ptda4RH23nGTxOE8It/1FDi1Nyn/K4t6OXjo7DQQmLJKypBTZQgCECUmDYz7sLyiA4dOk/TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVVE3V5ZRhrmrYVxjDm9BNpR4AsUmcxiJga60SFEahUja6fSx8
	IkcHkwU455j06dGjJY7JqsMYehit2zqMzVWF4LEbSgZqufgEBl5MdjI8FaKXavR+vNF6CtEqDn+
	E5XnSbc44u5oFHVEnVR+Hih+JI+2+YeJ2y9nB7iWz
X-Gm-Gg: ASbGncszc6nch/AEBCLEWXLYEg7+fN53r1Ebb4I0PHH8UCFTMfV2OUzLjHK9Mu7nl6K
	1aaAVV8w0n1w9swyMP5RaSWT7LQ6+OgmxR1UVe46ol0EcdsZhTzXg+VqmWU1qKcx11XDESx18iD
	Nh+gX9R2++z7RK6l5/FMoqRvkkmUH4o7wtjSrAvt/zYlC89WtwQ6VF1Ls3BvgYjwK3ICdQapKkN
	GFJzWvqTF0WlndpdIM0i7dDU5fsGso0tjBDRXh5hV1AHE3LzyWDBTlm09IGdPVUKU6oyxIUAXVm
	3srzclYS82Ys/A9+l7kr7JQcuw==
X-Google-Smtp-Source: AGHT+IHHXpduW3gx1lSqFCe8yWw5MiqVJgyQvr1aJc7UWZV0RVrJYwr5BVlFdmXm4WFkE7FNWLLHjy19GnzuLBTfLEU=
X-Received: by 2002:a17:906:478d:b0:b72:5d4a:45eb with SMTP id
 a640c23a62f3a-b7331998bc0mr431156066b.14.1762976336761; Wed, 12 Nov 2025
 11:38:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030210110.298612-1-wusamuel@google.com> <CAJZ5v0gzKN1cXfj508G4_9O2hKR0HncW4et3BNbaV+5Erh=LMA@mail.gmail.com>
 <CAG2KctonFbbN9KrKWweQWaRKNN=rZkpWQCmyyY2rKfcAUzF=sA@mail.gmail.com>
 <CAJZ5v0g6F+iEdicqSBb5M6-EfKfdW3vfwsxa98H2mrn5by6hPA@mail.gmail.com> <CAJZ5v0iuRkf+xDHSiioZV=4-8PLx1eOz3bzojvuuC_Y1ZP1-VA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iuRkf+xDHSiioZV=4-8PLx1eOz3bzojvuuC_Y1ZP1-VA@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 12 Nov 2025 11:38:45 -0800
X-Gm-Features: AWmQ_bltB3Dz3tiLtKXKzEzn_l3xwOPWPBD5PxD6BMBHn9C2dio2_CENsN2e9OY
Message-ID: <CAG2KctpoabtE8L=3PqhuBVr6QCc1p17F1kE88=t4aOOfGpzaxw@mail.gmail.com>
Subject: Re: [PATCH v6] PM: Support aborting sleep during filesystem sync
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, tuhaowen@uniontech.com, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 1:15=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Fri, Nov 7, 2025 at 9:58=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> >
> > On Wed, Nov 5, 2025 at 2:20=E2=80=AFAM Samuel Wu <wusamuel@google.com> =
wrote:
> > >
> > > On Tue, Nov 4, 2025 at 10:52=E2=80=AFAM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> > > >
> > > > On Thu, Oct 30, 2025 at 10:01=E2=80=AFPM Samuel Wu <wusamuel@google=
.com> wrote:
> > > > >
> > > > > At the start of suspend and hibernate, filesystems will sync to s=
ave the
> > > > > current state of the device. However, the long tail of the filesy=
stem
> > > > > sync can take upwards of 25 seconds. If during this filesystem sy=
nc
> > > > > there is some wakeup or abort signal, it will not be processed un=
til the
> > > > > sync is complete; from a user's perspective, this looks like the =
device
> > > > > is unresponsive to any form of input.
> > > > >
> > > > > This patch adds functionality to handle a sleep abort signal when=
 in
> > > > > the filesystem sync phase of suspend or hibernate. This topic was=
 first
> > > > > discussed by Saravana Kannan at LPC 2024 [1], where the general
> > > > > consensus was to allow filesystem sync on a parallel thread. In c=
ase of
> > > > > abort, the suspend process will stop waiting on an in-progress
> > > > > filesystem sync, and continue by aborting suspend before the file=
system
> > > > > sync is complete.
> > > > >
> > > > > Additionally, there is extra care needed to account for back-to-b=
ack
> > > > > sleeps while maintaining functionality to immediately abort durin=
g the
> > > > > filesystem sync stage. Furthermore, in the case of the back-to-ba=
ck
> > > > > sleeps, a subsequent filesystem sync is needed to ensure the late=
st
> > > > > files are synced right before sleep. If necessary, a subsequent s=
leep's
> > > > > filesystem sync will be queued, and will only start when the prev=
ious
> > > > > sleep's filesystem sync has finished. While waiting for the previ=
ous
> > > > > sleep's filesystem sync to finish, the subsequent sleep will stil=
l abort
> > > > > early if a wakeup event is triggered, solving the original issue =
of
> > > > > filesystem sync blocking abort.
> > > > >
> > > > > [1]: https://lpc.events/event/18/contributions/1845/
> > > > >
> > > > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > > > ---
> > > > > Changes in v6:
> > > > > - Use spin_lock_irq() in thread context
> > > > > - Use dedicated ordered workqueue for sync work items
> > > > > - Use a counter instead of two bools for synchronization
> > > > > - Queue fs_sync if it's not already pending on workqueue
> > > > > - pm_wakeup_clear(0) is prequisite to this feature, so move it wi=
thin function
> > > > > - Updated commit text for motive of back-to-back fs syncs
> > > > > - Tighter lock/unlock around setup, checks, and loop
> > > > > - Fix function definitions for CONFIG_PM_SLEEP=3Dn
> > > > > - v5 link: https://lore.kernel.org/all/20251017233907.2305303-1-w=
usamuel@google.com/
> > > > >
> > > > > Changes in v5:
> > > > > - Update spin_lock() to spin_lock_irqsave() since abort can be in=
 IRQ context
> > > > > - Updated changelog description to be more precise regarding cont=
inuing abort
> > > > >   sleep before fs_sync() is complete
> > > > > - Rename abort_sleep_during_fs_sync() to pm_stop_waiting_for_fs_s=
ync()
> > > > > - Simplify from a goto to do-while in pm_sleep_fs_sync()
> > > > > - v4 link: https://lore.kernel.org/all/20250911185314.2377124-1-w=
usamuel@google.com
> > > > >
> > > > > Changes in v4:
> > > > > - Removed patch 1/3 of v3 as it is already picked up on linux-pm
> > > > > - Squashed patches 2/3 and 3/3 from v3 into this single patch
> > > > > - Added abort during fs_sync functionality to hibernate in additi=
on to suspend
> > > > > - Moved variables and functions for abort from power/suspend.c to=
 power/main.c
> > > > > - Renamed suspend_fs_sync_with_abort() to pm_sleep_fs_sync()
> > > > > - Renamed suspend_abort_fs_sync() to abort_sleep_during_fs_sync()
> > > > > - v3 link: https://lore.kernel.org/all/20250821004237.2712312-1-w=
usamuel@google.com/
> > > > >
> > > > > Changes in v3:
> > > > > - Split v2 patch into 3 patches
> > > > > - Moved pm_wakeup_clear() outside of if(sync_on_suspend_enabled) =
condition
> > > > > - Updated documentation and comments within kernel/power/suspend.=
c
> > > > > - v2 link: https://lore.kernel.org/all/20250812232126.1814253-1-w=
usamuel@google.com/
> > > > >
> > > > > Changes in v2:
> > > > > - Added documentation for suspend_abort_fs_sync()
> > > > > - Made suspend_fs_sync_lock and suspend_fs_sync_complete declarat=
ion static
> > > > > - v1 link: https://lore.kernel.org/all/20250815004635.3684650-1-w=
usamuel@google.com
> > > > >
> > > > >  drivers/base/power/wakeup.c |  8 ++++
> > > > >  include/linux/suspend.h     |  4 ++
> > > > >  kernel/power/hibernate.c    |  5 ++-
> > > > >  kernel/power/main.c         | 81 +++++++++++++++++++++++++++++++=
++++++
> > > > >  kernel/power/suspend.c      |  4 +-
> > > > >  5 files changed, 100 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wak=
eup.c
> > > > > index d1283ff1080b..689c16b08b38 100644
> > > > > --- a/drivers/base/power/wakeup.c
> > > > > +++ b/drivers/base/power/wakeup.c
> > > > > @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wa=
keup_source *ws)
> > > > >
> > > > >         /* Increment the counter of events in progress. */
> > > > >         cec =3D atomic_inc_return(&combined_event_count);
> > > > > +       /*
> > > > > +        * wakeup_source_activate() aborts sleep only if events_c=
heck_enabled
> > > > > +        * is set (see pm_wakeup_pending()). Similarly, abort sle=
ep during
> > > > > +        * fs_sync only if events_check_enabled is set.
> > > > > +        */
> > > > > +       if (events_check_enabled)
> > > > > +               pm_stop_waiting_for_fs_sync();
> > > > >
> > > > >         trace_wakeup_source_activate(ws->name, cec);
> > > > >  }
> > > > > @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> > > > >  void pm_system_wakeup(void)
> > > > >  {
> > > > >         atomic_inc(&pm_abort_suspend);
> > > > > +       pm_stop_waiting_for_fs_sync();
> > > > >         s2idle_wake();
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> > > > > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > > > > index b02876f1ae38..4795f55f9cbe 100644
> > > > > --- a/include/linux/suspend.h
> > > > > +++ b/include/linux/suspend.h
> > > > > @@ -450,6 +450,8 @@ void restore_processor_state(void);
> > > > >  extern int register_pm_notifier(struct notifier_block *nb);
> > > > >  extern int unregister_pm_notifier(struct notifier_block *nb);
> > > > >  extern void ksys_sync_helper(void);
> > > > > +extern void pm_stop_waiting_for_fs_sync(void);
> > > > > +extern int pm_sleep_fs_sync(void);
> > > > >  extern void pm_report_hw_sleep_time(u64 t);
> > > > >  extern void pm_report_max_hw_sleep(u64 t);
> > > > >  void pm_restrict_gfp_mask(void);
> > > > > @@ -505,6 +507,8 @@ static inline void pm_restrict_gfp_mask(void)=
 {}
> > > > >  static inline void pm_restore_gfp_mask(void) {}
> > > > >
> > > > >  static inline void ksys_sync_helper(void) {}
> > > > > +static inline void pm_stop_waiting_for_fs_sync(void) {}
> > > > > +static inline int pm_sleep_fs_sync(void) { return 0; }
> > > > >
> > > > >  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
> > > > >
> > > > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > > > index 53166ef86ba4..1874fde4b4f3 100644
> > > > > --- a/kernel/power/hibernate.c
> > > > > +++ b/kernel/power/hibernate.c
> > > > > @@ -820,7 +820,10 @@ int hibernate(void)
> > > > >         if (error)
> > > > >                 goto Restore;
> > > > >
> > > > > -       ksys_sync_helper();
> > > > > +       error =3D pm_sleep_fs_sync();
> > > > > +       if (error)
> > > > > +               goto Restore;
> > > > > +
> > > > >         if (filesystem_freeze_enabled)
> > > > >                 filesystems_freeze();
> > > > >
> > > > > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > > > > index a6cbc3f4347a..23ca87a172a4 100644
> > > > > --- a/kernel/power/main.c
> > > > > +++ b/kernel/power/main.c
> > > > > @@ -582,6 +582,84 @@ bool pm_sleep_transition_in_progress(void)
> > > > >  {
> > > > >         return pm_suspend_in_progress() || hibernation_in_progres=
s();
> > > > >  }
> > > > > +
> > > > > +static int pm_sleep_fs_syncs_queued;
> > > > > +static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
> > > > > +static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
> > > > > +static struct workqueue_struct *pm_fs_sync_wq;
> > > > > +
> > > > > +static int __init pm_start_fs_sync_workqueue(void)
> > > > > +{
> > > > > +       pm_fs_sync_wq =3D alloc_ordered_workqueue("pm_fs_sync_wq"=
, 0);
> > > > > +
> > > > > +       return pm_fs_sync_wq ? 0 : -ENOMEM;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * pm_stop_waiting_for_fs_sync - Abort fs_sync to abort sleep ea=
rly
> > > > > + *
> > > > > + * This function causes the suspend process to stop waiting on a=
n in-progress
> > > > > + * filesystem sync, such that the suspend process can be aborted=
 before the
> > > > > + * filesystem sync is complete.
> > > > > + */
> > > > > +void pm_stop_waiting_for_fs_sync(void)
> > > > > +{
> > > > > +       unsigned long flags;
> > > > > +
> > > > > +       spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > > > > +       complete(&pm_sleep_fs_sync_complete);
> > > > > +       spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> > > > > +}
> > > >
> > > > Apart from the kernel test robot reports,
> > >
> > > Of course, I'll fix this in v7.
> > >
> > > > pm_stop_waiting_for_fs_sync() has become slightly too heavy for
> > > > calling it from wakeup_source_activate().
> > >
> > > Trying to understand- are you saying spin_lock_irqsave() makes
> > > pm_stop_waiting_for_fs_sync() too slow?
> >
> > Spin lock and the completion handling.
> >
> > This function has been designed to be as lightweight as reasonably
> > possible and the $subject patch is adding a branch and a global
> > spinlock locking to it.
> >
> > > > Waking up the suspend process from there should be sufficient.  The
> > > > completion is not necessary for that in principle.
> > >
> > > Can you elaborate more on what "there" means and why completion isn't
> > > necessary? From what I can see, the only way to abort the suspend
> > > _early_ is with the completion.
> >
> > Well, there are wait queues.
> >
> > In the first place though, do you really need to stop the suspend
> > process immediately after a wakeup event?

Yes, we would like to stop suspend as soon as a wakeup event occurs. A
delay in processing the wakeup event manifests as an unresponsive
device; for example, it is a poor user experience when pressing the
lock button lags on the order of seconds.

> > This generally does not happen and wakeup sources are designed with
> > the assumption that it need not happen: The suspend process will check
> > if there is a pending wakeup at some places and wakeup sources just
> > need to update the counters.

Agree, generally this isn't a concern but even 1% of cases means over
a million devices are affected. Coming back to the original premise,
the checks at discrete points are not sufficient since they don't
handle the cases when fs_sync takes 20+ seconds.

> > Quite frankly, I don't see why the filesystem sync period needs to be
> > special in that respect.  And if it need not be special, nothing needs
> > to be added to wakeup_source_activate().

fs_sync is special because it's been empirically identified as a phase
of suspend which causes suspend to be more than 100x slower.

> In case it is unclear where I'm going with this, the suspend process
> can be made use wait_event_timeout() with a timeout of, say, 20 ms to
> wait for pm_sleep_fs_syncs_queued to drop down to 0 in a loop and
> check pm_wakeup_pending() in every iteration.

Understood, this sounds similar to the polling idea in that of
try_to_freeze_tasks(). However, there have been efforts just to save
even <10ms in the suspend timeline, so the event driven approach would
be more performant than polling; also especially since we've been
refining the event driven approach in this patch for the past 6
versions.

Appreciate the feedback and discussion, please let me know what you
think. Thanks!

Sam

