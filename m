Return-Path: <linux-pm+bounces-35993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A686BD5BB1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E0DA4E2E33
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 18:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5A22D6407;
	Mon, 13 Oct 2025 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9WhwbvD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0529D282
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380451; cv=none; b=OyT9hS2Mb4pOwd8ZkBKqzEbo+wkKB5IdMAtlfOZkbiQeQ+AidN5j+xw/QtgwbC3ATM8dE3w/NsVqMDqITwuQueFpwh7LkiKy8um4JEImGfqd6pow3cAXk16Jkzgqp+0pg995bnAPruDqWOdVZ5p/dro+ajqFzdvJNj34YuGsNj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380451; c=relaxed/simple;
	bh=5LnAgViMiKMRbBY4et56GTpCNlAjhXD4RXHlow+I7eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aswgNgYwPEFMqxqnG8wUorbEPJSCKwWq8JvX0OgdEZctMaKV3NimkMeCroxTPtxGpUUUtgCD7xyyYCI8JJuoxNK0e3xhqCo8PndODw1r38J989nVV5t694OLoLvb/5Iz+nGyVwGzRnNpC5LXDBYheYwHsyjJdmhKWw9I92xs4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9WhwbvD; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-90f6d66e96dso1080356241.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 11:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760380448; x=1760985248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0B54f/AnNUIxL2OBvTZwWELhos8wcslYDXA8kI7xzpQ=;
        b=h9WhwbvDQu6Ffk8TBKyxzROrxp41pu4w40GyLRRe/roR4xSsuvCV+HHvlfzUgUjDky
         SdMAcKaUDOMPVGhhZXCRCte2UIwqI4T3OYtsZRsNd4sGO78m/uIdADjlRH01aSjfwxqg
         GHOwNiR+wDwU7OrCTVtsN8MwUkt/mBZOyM/6CvdC0Vd+24fUU/lHTSHPCra02RqTFE9i
         4MwgF3uZsiTpU/cC0xj8HLzlqsF0dChwgQC1mw3rDrOdhjHCAQEtC+cvWDFm2H0TY88R
         7FwiJhBQKJj1oDjw4pOe90H1MJa7LxUuserXVHy/LRfVUOqZGBRS6q9I7JfT4cTXfbFy
         IUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760380448; x=1760985248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0B54f/AnNUIxL2OBvTZwWELhos8wcslYDXA8kI7xzpQ=;
        b=oqDW6KPpAJDAoEbB+8OmRyb8Fsu315yIg0vScMoGDyhS5DiQ8E2OXm6kYKlQqaXuKU
         0utlHlUlcPJg8b1DNfuS33buZD+gd6t41cKzsqUjOigBw2oLHQruoo/oN4lnYwL1gIue
         uNwRMAGhjC382F+qGE6sIPDBRjK0jB+3H8gpIseaz3XVkthJMgOulrNbh2NZNjTM5g30
         WaDAn60bEZM3VsZM9FELNlOsyIf/3npTxlMcL20oHN1s54LT+agwz0fzBjUa4yXCs8U3
         hLq5iAeA7p99vpADcVetAVGyL29lbJo7pzvMAXvmNwyRhuazNDfvdRegdpOOFSyTIPQz
         UooQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9CPrNskfnOGGSckCa4xTq7MPK7JB9JOQ3jv3Zt3CNa8PBoRlLoVzjyeL26CAZFObphaNxbjUX5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4QNiIP7Q8dJ/4Et6OVMSJY70YajnGhTIXkB7Fz/O85jKJ/W9u
	iwLg8N1asTGMhvR8G+klTiFRJE/bFe5CkvPGaec8apYPNB7Dqe/dQB8m28YbGIRpRGnpp6u2Zlx
	/g5zLWNW5L/chOF0cW4WtxRlYK1z92+b3ffCmz3LG
X-Gm-Gg: ASbGncuXXhNfaCQkbalo0mpXux8zgrtlWBl4BZSBZLIjaPxd6+Jnmv18zSoUm71ZMGr
	Th1R5J2UGOX7gP+2dT0W47a5oo8PBgtH1MzUm1qXPW9+bxL72s95+y/uEFseDBt0RmevUYDaADH
	5h8y2KYHZ/gl+QliuV0Z/21y8SmNuwR3K9ZYaq3UyLOBJhW1MQj3DP7f/X0l+bPlMvS7INNlCAN
	samvTI+Sx+BgaZ2r6sYQZ1iYvUSoS4AzgmYBYUGTg==
X-Google-Smtp-Source: AGHT+IGkYGQSR0tOXHsQ+XvzpvkpLMYSuq4N41LlDVCJgHCU6ONZkKW/CJcMYCwZGQ/9a3WweDJ6FXKqAQoML2XS38Q=
X-Received: by 2002:a05:6102:4427:b0:5c3:d964:a689 with SMTP id
 ada2fe7eead31-5d5e23d9a99mr7575403137.32.1760380447642; Mon, 13 Oct 2025
 11:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911185314.2377124-1-wusamuel@google.com> <CAJZ5v0hwgNt3+stLDpdVbrpDfomEaQ26KikUDFN2QjBpNMgbfQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hwgNt3+stLDpdVbrpDfomEaQ26KikUDFN2QjBpNMgbfQ@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 13 Oct 2025 11:33:31 -0700
X-Gm-Features: AS18NWCudBcPQel2gAEZNCzAVLifulqIJIY4wCXC3AUJOWMrl9i1agCVF2RVHfk
Message-ID: <CAGETcx_h9FD=VQRMeLmJF7htCnHksVBbgMBan4H1mEJKwNJKeg@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 11:15=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Thu, Sep 11, 2025 at 8:53=E2=80=AFPM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > At the start of suspend and hibernate, filesystems will sync to save th=
e
> > current state of the device. However, the long tail of the filesystem
> > sync can take upwards of 25 seconds. If during this filesystem sync
> > there is some wakeup or abort signal, it will not be processed until th=
e
> > sync is complete; from a user's perspective, this looks like the device
> > is unresponsive to any form of input.
> >
> > This patch adds functionality to handle a sleep abort signal when in
> > the filesystem sync phase of suspend or hibernate. This topic was first
> > discussed specifically for suspend by Saravana Kannan at LPC 2024 [1],
> > where the general consensus was to allow filesystem sync on a parallel
> > thread. The same logic applies to both suspend and hibernate code paths=
.
> >
> > There is extra care needed to account for back-to-back sleeps while
> > still maintaining functionality to immediately abort during the
> > filesystem sync stage.
> >
> > This patch handles this by serializing the filesystem sync sequence wit=
h
> > an invariant; a subsequent sleep's filesystem sync operation will only
> > start when the previous sleep's filesystem sync has finished. While
> > waiting for the previous sleep's filesystem sync to finish, the
> > subsequent sleep will still abort early if a wakeup event is triggered,
> > solving the original issue of filesystem sync blocking abort.
> >
> > [1]: https://lpc.events/event/18/contributions/1845/
> >
> > Suggested-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > ---
> > Changes in v4:
> > - Removed patch 1/3 of v3 as it is already picked up on linux-pm
> > - Squashed patches 2/3 and 3/3 from v3 into this single patch
> > - Added abort during fs_sync functionality to hibernate in addition to =
suspend
> > - Moved variables and functions for abort from power/suspend.c to power=
/main.c
> > - Renamed suspend_fs_sync_with_abort() to pm_sleep_fs_sync()
> > - Renamed suspend_abort_fs_sync() to abort_sleep_during_fs_sync()
> > - v3 link: https://lore.kernel.org/all/20250821004237.2712312-1-wusamue=
l@google.com/
> >
> > Changes in v3:
> > - Split v2 patch into 3 patches
> > - Moved pm_wakeup_clear() outside of if(sync_on_suspend_enabled) condit=
ion
> > - Updated documentation and comments within kernel/power/suspend.c
> > - v2 link: https://lore.kernel.org/all/20250812232126.1814253-1-wusamue=
l@google.com/
> >
> > Changes in v2:
> > - Added documentation for suspend_abort_fs_sync()
> > - Made suspend_fs_sync_lock and suspend_fs_sync_complete declaration st=
atic
> > - v1 link: https://lore.kernel.org/all/20250815004635.3684650-1-wusamue=
l@google.com
> >
> >  drivers/base/power/wakeup.c |  8 +++++
> >  include/linux/suspend.h     |  4 +++
> >  kernel/power/hibernate.c    |  5 ++-
> >  kernel/power/main.c         | 70 +++++++++++++++++++++++++++++++++++++
> >  kernel/power/suspend.c      |  7 ++--
> >  5 files changed, 91 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index d1283ff1080b..daf07ab7ac3f 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup_s=
ource *ws)
> >
> >         /* Increment the counter of events in progress. */
> >         cec =3D atomic_inc_return(&combined_event_count);
> > +       /*
> > +        * wakeup_source_activate() aborts sleep only if events_check_e=
nabled
> > +        * is set (see pm_wakeup_pending()). Similarly, abort sleep dur=
ing
> > +        * fs_sync only if events_check_enabled is set.
> > +        */
> > +       if (events_check_enabled)
> > +               abort_sleep_during_fs_sync();
> >
> >         trace_wakeup_source_activate(ws->name, cec);
> >  }
> > @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> >  void pm_system_wakeup(void)
> >  {
> >         atomic_inc(&pm_abort_suspend);
> > +       abort_sleep_during_fs_sync();
> >         s2idle_wake();
> >  }
> >  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > index 317ae31e89b3..c961bdb00bb6 100644
> > --- a/include/linux/suspend.h
> > +++ b/include/linux/suspend.h
> > @@ -444,6 +444,8 @@ void restore_processor_state(void);
> >  extern int register_pm_notifier(struct notifier_block *nb);
> >  extern int unregister_pm_notifier(struct notifier_block *nb);
> >  extern void ksys_sync_helper(void);
> > +extern void abort_sleep_during_fs_sync(void);
> > +extern int pm_sleep_fs_sync(void);
> >  extern void pm_report_hw_sleep_time(u64 t);
> >  extern void pm_report_max_hw_sleep(u64 t);
> >  void pm_restrict_gfp_mask(void);
> > @@ -499,6 +501,8 @@ static inline void pm_restrict_gfp_mask(void) {}
> >  static inline void pm_restore_gfp_mask(void) {}
> >
> >  static inline void ksys_sync_helper(void) {}
> > +static inline abort_sleep_during_fs_sync(void) {}
> > +static inline int pm_sleep_fs_sync(void) {}
> >
> >  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
> >
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index 2f66ab453823..651dcd768644 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -811,7 +811,10 @@ int hibernate(void)
> >         if (error)
> >                 goto Restore;
> >
> > -       ksys_sync_helper();
> > +       error =3D pm_sleep_fs_sync();
> > +       if (error)
> > +               goto Restore;
> > +
> >         if (filesystem_freeze_enabled)
> >                 filesystems_freeze();
> >
> > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > index 3cf2d7e72567..38b1de295cfe 100644
> > --- a/kernel/power/main.c
> > +++ b/kernel/power/main.c
> > @@ -570,6 +570,76 @@ bool pm_sleep_transition_in_progress(void)
> >  {
> >         return pm_suspend_in_progress() || hibernation_in_progress();
> >  }
> > +
> > +static bool pm_sleep_fs_sync_queued;
> > +static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
> > +static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
> > +
> > +/**
> > + * abort_sleep_during_fs_sync - Abort fs_sync to abort sleep early
> > + *
> > + * This function aborts the fs_sync stage of suspend/hibernate so that
> > + * suspend/hibernate itself can be aborted early.
>
> This changelog needs to be more precise IMV.
>
> I'd actually call the function something like
> pm_stop_waiting_for_fs_sync() and I'd say in the changelog that the
> functions causes a suspend process to stop waiting on an fs sync in
> progress and continue so that it can be aborted before the fs sync is
> complete.
>
> > + */
> > +void abort_sleep_during_fs_sync(void)
> > +{
> > +       spin_lock(&pm_sleep_fs_sync_lock);
> > +       complete(&pm_sleep_fs_sync_complete);
> > +       spin_unlock(&pm_sleep_fs_sync_lock);
> > +}
> > +
> > +static void sync_filesystems_fn(struct work_struct *work)
> > +{
> > +       ksys_sync_helper();
> > +
> > +       spin_lock(&pm_sleep_fs_sync_lock);
> > +       pm_sleep_fs_sync_queued =3D false;
> > +       complete(&pm_sleep_fs_sync_complete);
> > +       spin_unlock(&pm_sleep_fs_sync_lock);
> > +}
> > +static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
> > +
> > +/**
> > + * pm_sleep_fs_sync - Trigger fs_sync with ability to abort
> > + *
> > + * Return 0 on successful file system sync, otherwise returns -EBUSY i=
f file
> > + * system sync was aborted.
> > + */
> > +int pm_sleep_fs_sync(void)
> > +{
> > +       bool need_pm_sleep_fs_sync_requeue;
> > +
> > +Start_fs_sync:
> > +       spin_lock(&pm_sleep_fs_sync_lock);
> > +       reinit_completion(&pm_sleep_fs_sync_complete);
> > +       /*
> > +        * Handle the case where a sleep immediately follows a previous=
 sleep
> > +        * that was aborted during fs_sync. In this case, wait for the =
previous
> > +        * filesystem sync to finish. Then do another filesystem sync s=
o any
> > +        * subsequent filesystem changes are synced before sleeping.
>
> Is the extra sync really necessary?

Yeah, since the fs syncs can take up to 25 seconds in some cases,
there's enough time to create new dirty data that needs to be written
to disk. So, we want to sync again to write all of that out as if the
previous attempt/abort hadn't happened. And to do that correctly, we
have to let the existing sync finish and then kick off the new one
once the "work" and "completion" are in a good state.

>
> Some files may still be updated after it is complete and before all
> tasks are frozen.

The time window can be very large here. The one you are referring to
is just a few milliseconds.

-Saravana


>
> > +        */
> > +       if (pm_sleep_fs_sync_queued) {
> > +               need_pm_sleep_fs_sync_requeue =3D true;
> > +       } else {
> > +               need_pm_sleep_fs_sync_requeue =3D false;
> > +               pm_sleep_fs_sync_queued =3D true;
> > +               schedule_work(&sync_filesystems);
> > +       }
> > +       spin_unlock(&pm_sleep_fs_sync_lock);
> > +
> > +       /*
> > +        * Completion is triggered by fs_sync finishing or an abort sle=
ep
> > +        * signal, whichever comes first
> > +        */
> > +       wait_for_completion(&pm_sleep_fs_sync_complete);
> > +       if (pm_wakeup_pending())
> > +               return -EBUSY;
> > +       if (need_pm_sleep_fs_sync_requeue)
> > +               goto Start_fs_sync;
>
> Wouldn't a do { .. } while () work here instead of the goto?
>
> > +
> > +       return 0;
> > +}
> > +
> >  #endif /* CONFIG_PM_SLEEP */
> >
> >  #ifdef CONFIG_PM_SLEEP_DEBUG
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 4bb4686c1c08..c019a4396c1f 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -31,6 +31,7 @@
> >  #include <linux/compiler.h>
> >  #include <linux/moduleparam.h>
> >  #include <linux/fs.h>
> > +#include <linux/workqueue.h>
> >
> >  #include "power.h"
> >
> > @@ -588,14 +589,16 @@ static int enter_state(suspend_state_t state)
> >         if (state =3D=3D PM_SUSPEND_TO_IDLE)
> >                 s2idle_begin();
> >
> > +       pm_wakeup_clear(0);
> >         if (sync_on_suspend_enabled) {
> >                 trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> > -               ksys_sync_helper();
> > +               error =3D pm_sleep_fs_sync();
> >                 trace_suspend_resume(TPS("sync_filesystems"), 0, false)=
;
> > +               if (error)
> > +                       goto Unlock;
> >         }
> >
> >         pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels=
[state]);
> > -       pm_wakeup_clear(0);
> >         pm_suspend_clear_flags();
> >         error =3D suspend_prepare(state);
> >         if (error)
> > --

