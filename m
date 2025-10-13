Return-Path: <linux-pm+bounces-35995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B12BD5BEA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B49421437
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 18:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D022D5939;
	Mon, 13 Oct 2025 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9dJ+Qfn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D402F2D193C
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380752; cv=none; b=b/vYs1TmPcbwXEaT62h2Nk3VsBiUU1NfJiWGWZaauXmKp50LiMaZxUxTo9RgIN3h385flvT3ACd62NYIWDNQCTZ4J+9Tv9k509MCmMOExTujdv8uu9zZOpJVoaP4FxA8b2qAM5jZoRPRRvzgg1uU4Z+MlzpQSUTUtRYHwTuwuAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380752; c=relaxed/simple;
	bh=3zADZOChwWc+niXkE9mWkU3rlgltawR2lp1hEaeD+0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tT0XbenpJebGN3fqiOuu8DC4RrRAgUCU20UO91eQmV8yA+4hN89c1sOOby/fd7LvpMLjUKHXsw675APFphHVUFA/0Bt4uCdRujRoRnopLolaZBVGougl+DmmFAjqw0oww5eAgoSwyIkOE4bSuOrwypYNfhuccVOmKiCDcxhwgbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9dJ+Qfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714C4C19422
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760380752;
	bh=3zADZOChwWc+niXkE9mWkU3rlgltawR2lp1hEaeD+0M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r9dJ+Qfn0w6SOAU2sleL+A6u5fk6miKWj5sVbifAKGCCcfnQMaGJ5+4Ez1FSD2VLq
	 vnGIScEx3FObKU9bjtWGantfwGCTUl62HmQylqlcoGASH38F853eb4QDg9HPuER4Y2
	 FJYYrD7utDTHRldAmYVXgPYWLvGTIWgp1mXnNk0c//0jcSR08OfXjCm33dEVRDOaJp
	 gpyltK7Mt/s10yBAd71WHRCoQOM7iiSBYK6n1NsfOMCx94ZtSqmWMNPYM05gm2T5M/
	 43zH0kclqy/MO+nSuZTM3wakcEqTaRcvIKpMomyXr5szs41bp4t3Zb7g2xV31Jzih0
	 4J2dlBRXRrMdg==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-43f554ed252so2511799b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 11:39:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9M34RNXqxcFSXJGfDB0Vx6HZR1lgSv2Iul+JwLkXQLjBuBoJuk7q5xhO6GjkMPACdrkRpONm+xQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTw782QXG2V6coml9IlybveJStES3UPD2nKWDFJgaQpRhI527A
	cw2/JUAmOedQXAWao4StB63z4tamuDQiZkZo6Z+AGq2acEMxIuz3cpCg2BHqJGXpiDpOjO89a/J
	f6pxRHssCaeUOa/MiEqcUrI9INl4+7V8=
X-Google-Smtp-Source: AGHT+IEJ02887KezrfRa8ZB7U/yPt50HVSyz/jPMXYlXtzkQN/u0+BbVmDiTRmfAJIIOMRJ7wyuEf8pFUo422PWED88=
X-Received: by 2002:a05:6808:201f:b0:438:3def:446a with SMTP id
 5614622812f47-4417b3fc68amr10214424b6e.45.1760380751695; Mon, 13 Oct 2025
 11:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911185314.2377124-1-wusamuel@google.com> <CAJZ5v0hwgNt3+stLDpdVbrpDfomEaQ26KikUDFN2QjBpNMgbfQ@mail.gmail.com>
 <CAGETcx_h9FD=VQRMeLmJF7htCnHksVBbgMBan4H1mEJKwNJKeg@mail.gmail.com>
In-Reply-To: <CAGETcx_h9FD=VQRMeLmJF7htCnHksVBbgMBan4H1mEJKwNJKeg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Oct 2025 20:39:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j-vHA1OC4QMHssN-NxV23EQkZCz4VYCjKaD42_LD_Oeg@mail.gmail.com>
X-Gm-Features: AS18NWDmt7y5RWZrM65VnMfXOmBsjEbJKzDxT1TENJrI0SK-5ZcwdDBlB4zv7y0
Message-ID: <CAJZ5v0j-vHA1OC4QMHssN-NxV23EQkZCz4VYCjKaD42_LD_Oeg@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Samuel Wu <wusamuel@google.com>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:34=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Mon, Oct 13, 2025 at 11:15=E2=80=AFAM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > On Thu, Sep 11, 2025 at 8:53=E2=80=AFPM Samuel Wu <wusamuel@google.com>=
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
> > > discussed specifically for suspend by Saravana Kannan at LPC 2024 [1]=
,
> > > where the general consensus was to allow filesystem sync on a paralle=
l
> > > thread. The same logic applies to both suspend and hibernate code pat=
hs.
> > >
> > > There is extra care needed to account for back-to-back sleeps while
> > > still maintaining functionality to immediately abort during the
> > > filesystem sync stage.
> > >
> > > This patch handles this by serializing the filesystem sync sequence w=
ith
> > > an invariant; a subsequent sleep's filesystem sync operation will onl=
y
> > > start when the previous sleep's filesystem sync has finished. While
> > > waiting for the previous sleep's filesystem sync to finish, the
> > > subsequent sleep will still abort early if a wakeup event is triggere=
d,
> > > solving the original issue of filesystem sync blocking abort.
> > >
> > > [1]: https://lpc.events/event/18/contributions/1845/
> > >
> > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > ---
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
> > >  drivers/base/power/wakeup.c |  8 +++++
> > >  include/linux/suspend.h     |  4 +++
> > >  kernel/power/hibernate.c    |  5 ++-
> > >  kernel/power/main.c         | 70 +++++++++++++++++++++++++++++++++++=
++
> > >  kernel/power/suspend.c      |  7 ++--
> > >  5 files changed, 91 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.=
c
> > > index d1283ff1080b..daf07ab7ac3f 100644
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
> > > +               abort_sleep_during_fs_sync();
> > >
> > >         trace_wakeup_source_activate(ws->name, cec);
> > >  }
> > > @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> > >  void pm_system_wakeup(void)
> > >  {
> > >         atomic_inc(&pm_abort_suspend);
> > > +       abort_sleep_during_fs_sync();
> > >         s2idle_wake();
> > >  }
> > >  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> > > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > > index 317ae31e89b3..c961bdb00bb6 100644
> > > --- a/include/linux/suspend.h
> > > +++ b/include/linux/suspend.h
> > > @@ -444,6 +444,8 @@ void restore_processor_state(void);
> > >  extern int register_pm_notifier(struct notifier_block *nb);
> > >  extern int unregister_pm_notifier(struct notifier_block *nb);
> > >  extern void ksys_sync_helper(void);
> > > +extern void abort_sleep_during_fs_sync(void);
> > > +extern int pm_sleep_fs_sync(void);
> > >  extern void pm_report_hw_sleep_time(u64 t);
> > >  extern void pm_report_max_hw_sleep(u64 t);
> > >  void pm_restrict_gfp_mask(void);
> > > @@ -499,6 +501,8 @@ static inline void pm_restrict_gfp_mask(void) {}
> > >  static inline void pm_restore_gfp_mask(void) {}
> > >
> > >  static inline void ksys_sync_helper(void) {}
> > > +static inline abort_sleep_during_fs_sync(void) {}
> > > +static inline int pm_sleep_fs_sync(void) {}
> > >
> > >  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
> > >
> > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > index 2f66ab453823..651dcd768644 100644
> > > --- a/kernel/power/hibernate.c
> > > +++ b/kernel/power/hibernate.c
> > > @@ -811,7 +811,10 @@ int hibernate(void)
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
> > > index 3cf2d7e72567..38b1de295cfe 100644
> > > --- a/kernel/power/main.c
> > > +++ b/kernel/power/main.c
> > > @@ -570,6 +570,76 @@ bool pm_sleep_transition_in_progress(void)
> > >  {
> > >         return pm_suspend_in_progress() || hibernation_in_progress();
> > >  }
> > > +
> > > +static bool pm_sleep_fs_sync_queued;
> > > +static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
> > > +static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
> > > +
> > > +/**
> > > + * abort_sleep_during_fs_sync - Abort fs_sync to abort sleep early
> > > + *
> > > + * This function aborts the fs_sync stage of suspend/hibernate so th=
at
> > > + * suspend/hibernate itself can be aborted early.
> >
> > This changelog needs to be more precise IMV.
> >
> > I'd actually call the function something like
> > pm_stop_waiting_for_fs_sync() and I'd say in the changelog that the
> > functions causes a suspend process to stop waiting on an fs sync in
> > progress and continue so that it can be aborted before the fs sync is
> > complete.
> >
> > > + */
> > > +void abort_sleep_during_fs_sync(void)
> > > +{
> > > +       spin_lock(&pm_sleep_fs_sync_lock);
> > > +       complete(&pm_sleep_fs_sync_complete);
> > > +       spin_unlock(&pm_sleep_fs_sync_lock);
> > > +}
> > > +
> > > +static void sync_filesystems_fn(struct work_struct *work)
> > > +{
> > > +       ksys_sync_helper();
> > > +
> > > +       spin_lock(&pm_sleep_fs_sync_lock);
> > > +       pm_sleep_fs_sync_queued =3D false;
> > > +       complete(&pm_sleep_fs_sync_complete);
> > > +       spin_unlock(&pm_sleep_fs_sync_lock);
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
> > > +
> > > +Start_fs_sync:
> > > +       spin_lock(&pm_sleep_fs_sync_lock);
> > > +       reinit_completion(&pm_sleep_fs_sync_complete);
> > > +       /*
> > > +        * Handle the case where a sleep immediately follows a previo=
us sleep
> > > +        * that was aborted during fs_sync. In this case, wait for th=
e previous
> > > +        * filesystem sync to finish. Then do another filesystem sync=
 so any
> > > +        * subsequent filesystem changes are synced before sleeping.
> >
> > Is the extra sync really necessary?
>
> Yeah, since the fs syncs can take up to 25 seconds in some cases,
> there's enough time to create new dirty data that needs to be written
> to disk. So, we want to sync again to write all of that out as if the
> previous attempt/abort hadn't happened. And to do that correctly, we
> have to let the existing sync finish and then kick off the new one
> once the "work" and "completion" are in a good state.

And if the new suspend is aborted while the new fs sync is in
progress, then you'll repeat the exercise and so on, possibly ad
infinitum?

> >
> > Some files may still be updated after it is complete and before all
> > tasks are frozen.
>
> The time window can be very large here. The one you are referring to
> is just a few milliseconds.

It can take up to 20 sec.

