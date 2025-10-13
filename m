Return-Path: <linux-pm+bounces-35996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002BABD5C4A
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC5C18A446A
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 18:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3B2C11ED;
	Mon, 13 Oct 2025 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1PGi3l6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03B327F19F
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381196; cv=none; b=QA2FqDVTod6QmCqmmAGeUXfG49YaGMWKkxvwLZYfnlvDVkUsw91wJsqxzHnSFA7LJBDjaIS8Yxr5nlN4lLmZtr8scQ/qCSjwLEqtsMXuNHkrNr50xnlv8BsuPz80YQWom/62Dp6sVtqrgXdmMI7tsAIE+1R9VHyomHAXA61P+tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381196; c=relaxed/simple;
	bh=mBtJhnETt0hTDiUKFO+59SNXP+ZxWMLNeyzQGpqBOWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GElrDd0WGrEoUeQWAa/3cBY1rYcFC+Lo3U87uqqFO/tVfWPppfTdf1NhJ+vlNhQJY338VzoYnCwM4IpBSTI/I+fCRwy4Hrj0osor/QVNKjtYKrX/CCBZtV+EGF136siv3ZWoOId7PleUkk+DHr2SOvIYh/JtHRDBP7sG+6ysMHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1PGi3l6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1357AC16AAE
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760381196;
	bh=mBtJhnETt0hTDiUKFO+59SNXP+ZxWMLNeyzQGpqBOWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e1PGi3l6dfbdkmzddT1JveDQ0AoaMbFZOrfoExq/+yhCMWl2+sy6bCxO0NHyh7M//
	 0++dl2EMMQxQeDrW7OViRTXZY7m6xt321yUpdIIwPOMSSGQ926fjIh4aPK5l7yGUAg
	 RUWtogsuxIXqFYAB/iOoO6PY9rB7IGEPoiERqZGv52aLyv27pYQ/3cZy6K2jk8UXa2
	 /F4FBqjVIIi8OdKit+m5brYQ2Wd9GHCK3oDZJ1VU+0Otv7bWjmjwKBlu3ysg6zwgcA
	 /joE5GFW5SaYzpjxWvXw/cFD7faVfCzykH4apjX9BPZuvp6NlFpdwX+bEskFJDBcyw
	 gcDcdd2/gSzeA==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7bc626c5467so3583369a34.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 11:46:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaSbItM1HgKLChfIQ+Mh6KuYs2vPo49ZJgAz7/mHTE3qHNv6dEAKlgggLGpFnGPL5LVfLTBcqyMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIt+rYlGlMkeQjQLRY1YV8ZLPdMsbbH0PFHrMqsXiaJF0coOmn
	FOboV1FH+Vm9tclZSGSJbKdwDcnqkvCw4aHBzHDYn2jwUmFgMf3+a1z4CpIyrHlkfEapJHm/JWj
	i3ua+/NTbCFYQMCh81RzXDmTkdqHa1OU=
X-Google-Smtp-Source: AGHT+IGuq+BrkphL2FtJncLNSS4bUqD2dOADdoot48fgPb5HUX57UyGLyXdLbC37EI64I+QMeO4c/yjw20wli9LnHU8=
X-Received: by 2002:a05:6808:2207:b0:438:3680:d66e with SMTP id
 5614622812f47-4417b3dd45cmr10489369b6e.39.1760381195338; Mon, 13 Oct 2025
 11:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911185314.2377124-1-wusamuel@google.com> <CAJZ5v0hwgNt3+stLDpdVbrpDfomEaQ26KikUDFN2QjBpNMgbfQ@mail.gmail.com>
 <CAGETcx_h9FD=VQRMeLmJF7htCnHksVBbgMBan4H1mEJKwNJKeg@mail.gmail.com> <CAJZ5v0j-vHA1OC4QMHssN-NxV23EQkZCz4VYCjKaD42_LD_Oeg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j-vHA1OC4QMHssN-NxV23EQkZCz4VYCjKaD42_LD_Oeg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Oct 2025 20:46:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h3wTGqTn-DqAKA6_bxF-=sQGauGJm_BUOxeQd87EQSYw@mail.gmail.com>
X-Gm-Features: AS18NWBZB_WoShcgFc1uWIU00P94uSTT9W5FUp5C_fduKGCXZpG6wAWPv1nDlaI
Message-ID: <CAJZ5v0h3wTGqTn-DqAKA6_bxF-=sQGauGJm_BUOxeQd87EQSYw@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
To: Saravana Kannan <saravanak@google.com>
Cc: Samuel Wu <wusamuel@google.com>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:39=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Oct 13, 2025 at 8:34=E2=80=AFPM Saravana Kannan <saravanak@google=
.com> wrote:
> >
> > On Mon, Oct 13, 2025 at 11:15=E2=80=AFAM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> > >
> > > On Thu, Sep 11, 2025 at 8:53=E2=80=AFPM Samuel Wu <wusamuel@google.co=
m> wrote:
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
> > > > discussed specifically for suspend by Saravana Kannan at LPC 2024 [=
1],
> > > > where the general consensus was to allow filesystem sync on a paral=
lel
> > > > thread. The same logic applies to both suspend and hibernate code p=
aths.
> > > >
> > > > There is extra care needed to account for back-to-back sleeps while
> > > > still maintaining functionality to immediately abort during the
> > > > filesystem sync stage.
> > > >
> > > > This patch handles this by serializing the filesystem sync sequence=
 with
> > > > an invariant; a subsequent sleep's filesystem sync operation will o=
nly
> > > > start when the previous sleep's filesystem sync has finished. While
> > > > waiting for the previous sleep's filesystem sync to finish, the
> > > > subsequent sleep will still abort early if a wakeup event is trigge=
red,
> > > > solving the original issue of filesystem sync blocking abort.
> > > >
> > > > [1]: https://lpc.events/event/18/contributions/1845/
> > > >
> > > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > > ---
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
> > > >  drivers/base/power/wakeup.c |  8 +++++
> > > >  include/linux/suspend.h     |  4 +++
> > > >  kernel/power/hibernate.c    |  5 ++-
> > > >  kernel/power/main.c         | 70 +++++++++++++++++++++++++++++++++=
++++
> > > >  kernel/power/suspend.c      |  7 ++--
> > > >  5 files changed, 91 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeu=
p.c
> > > > index d1283ff1080b..daf07ab7ac3f 100644
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
> > > > +               abort_sleep_during_fs_sync();
> > > >
> > > >         trace_wakeup_source_activate(ws->name, cec);
> > > >  }
> > > > @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> > > >  void pm_system_wakeup(void)
> > > >  {
> > > >         atomic_inc(&pm_abort_suspend);
> > > > +       abort_sleep_during_fs_sync();
> > > >         s2idle_wake();
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> > > > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > > > index 317ae31e89b3..c961bdb00bb6 100644
> > > > --- a/include/linux/suspend.h
> > > > +++ b/include/linux/suspend.h
> > > > @@ -444,6 +444,8 @@ void restore_processor_state(void);
> > > >  extern int register_pm_notifier(struct notifier_block *nb);
> > > >  extern int unregister_pm_notifier(struct notifier_block *nb);
> > > >  extern void ksys_sync_helper(void);
> > > > +extern void abort_sleep_during_fs_sync(void);
> > > > +extern int pm_sleep_fs_sync(void);
> > > >  extern void pm_report_hw_sleep_time(u64 t);
> > > >  extern void pm_report_max_hw_sleep(u64 t);
> > > >  void pm_restrict_gfp_mask(void);
> > > > @@ -499,6 +501,8 @@ static inline void pm_restrict_gfp_mask(void) {=
}
> > > >  static inline void pm_restore_gfp_mask(void) {}
> > > >
> > > >  static inline void ksys_sync_helper(void) {}
> > > > +static inline abort_sleep_during_fs_sync(void) {}
> > > > +static inline int pm_sleep_fs_sync(void) {}
> > > >
> > > >  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
> > > >
> > > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > > index 2f66ab453823..651dcd768644 100644
> > > > --- a/kernel/power/hibernate.c
> > > > +++ b/kernel/power/hibernate.c
> > > > @@ -811,7 +811,10 @@ int hibernate(void)
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
> > > > index 3cf2d7e72567..38b1de295cfe 100644
> > > > --- a/kernel/power/main.c
> > > > +++ b/kernel/power/main.c
> > > > @@ -570,6 +570,76 @@ bool pm_sleep_transition_in_progress(void)
> > > >  {
> > > >         return pm_suspend_in_progress() || hibernation_in_progress(=
);
> > > >  }
> > > > +
> > > > +static bool pm_sleep_fs_sync_queued;
> > > > +static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
> > > > +static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
> > > > +
> > > > +/**
> > > > + * abort_sleep_during_fs_sync - Abort fs_sync to abort sleep early
> > > > + *
> > > > + * This function aborts the fs_sync stage of suspend/hibernate so =
that
> > > > + * suspend/hibernate itself can be aborted early.
> > >
> > > This changelog needs to be more precise IMV.
> > >
> > > I'd actually call the function something like
> > > pm_stop_waiting_for_fs_sync() and I'd say in the changelog that the
> > > functions causes a suspend process to stop waiting on an fs sync in
> > > progress and continue so that it can be aborted before the fs sync is
> > > complete.
> > >
> > > > + */
> > > > +void abort_sleep_during_fs_sync(void)
> > > > +{
> > > > +       spin_lock(&pm_sleep_fs_sync_lock);
> > > > +       complete(&pm_sleep_fs_sync_complete);
> > > > +       spin_unlock(&pm_sleep_fs_sync_lock);
> > > > +}
> > > > +
> > > > +static void sync_filesystems_fn(struct work_struct *work)
> > > > +{
> > > > +       ksys_sync_helper();
> > > > +
> > > > +       spin_lock(&pm_sleep_fs_sync_lock);
> > > > +       pm_sleep_fs_sync_queued =3D false;
> > > > +       complete(&pm_sleep_fs_sync_complete);
> > > > +       spin_unlock(&pm_sleep_fs_sync_lock);
> > > > +}
> > > > +static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
> > > > +
> > > > +/**
> > > > + * pm_sleep_fs_sync - Trigger fs_sync with ability to abort
> > > > + *
> > > > + * Return 0 on successful file system sync, otherwise returns -EBU=
SY if file
> > > > + * system sync was aborted.
> > > > + */
> > > > +int pm_sleep_fs_sync(void)
> > > > +{
> > > > +       bool need_pm_sleep_fs_sync_requeue;
> > > > +
> > > > +Start_fs_sync:
> > > > +       spin_lock(&pm_sleep_fs_sync_lock);
> > > > +       reinit_completion(&pm_sleep_fs_sync_complete);
> > > > +       /*
> > > > +        * Handle the case where a sleep immediately follows a prev=
ious sleep
> > > > +        * that was aborted during fs_sync. In this case, wait for =
the previous
> > > > +        * filesystem sync to finish. Then do another filesystem sy=
nc so any
> > > > +        * subsequent filesystem changes are synced before sleeping=
.
> > >
> > > Is the extra sync really necessary?
> >
> > Yeah, since the fs syncs can take up to 25 seconds in some cases,
> > there's enough time to create new dirty data that needs to be written
> > to disk. So, we want to sync again to write all of that out as if the
> > previous attempt/abort hadn't happened. And to do that correctly, we
> > have to let the existing sync finish and then kick off the new one
> > once the "work" and "completion" are in a good state.
>
> And if the new suspend is aborted while the new fs sync is in
> progress, then you'll repeat the exercise and so on, possibly ad
> infinitum?

Also, by the above argument, you should do an extra fs sync after
every fs sync taking "too much" time, not just when the previous
suspend has been aborted during an fs sync.

