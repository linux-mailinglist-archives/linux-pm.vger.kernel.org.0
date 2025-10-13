Return-Path: <linux-pm+bounces-36001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8F8BD5FB1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 21:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B449440746C
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 19:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4AA2D7DDC;
	Mon, 13 Oct 2025 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCeuLdKR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF33525783C
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384401; cv=none; b=f8qrVXDQ2O1qWQFRzXDXxcZuu5EhJGmsvjGut9uEtsHtz6JqXWyWAMHbLkNcxDhwNOspSuKGz2jdJ6q7ddClKKRLLwt54vjByDc9iUG2Svq3CjYM1hlzvXxi2ssM1XjtPIX57CviXQ5BGz0WqxpkkZltGZQiYgKT6EMj0LKhyb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384401; c=relaxed/simple;
	bh=TkcohfOmF1Ejm1AM0Vk7r4RSmdaveV0dmJRrJxD7Bbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+pAkjK5TjdZnBmHdu6g4mfi4+vm6YQIwmPb/J786ed2ffzl+4RLfUuyz2sALZ9B1WaRk4yKcV6B1Fpv8REPxMLhvS11gZquHdEG5bt6WNMh96x5uvr4hX6iEFh8HrckFLrADwYuH6ZZ2CN6CSnS/cr4kbmHQo0wL9a8h0r+kDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XCeuLdKR; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-59f64abbb61so1829555137.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760384399; x=1760989199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCvB7wixF2b7Khlrp7jtKDjTw9jSL1Nm3LuVyC2V/Kg=;
        b=XCeuLdKRLdY//7X0qEL+IJ++wLLF/t/4j8dT25Ly0RYyyUyCYrytL4RtOsIhWwPl12
         sPareFRfgLfPpubK3J14VHsd9Oy28REs0IUObHCuLLoCKP4fP7QsBHdcYqZUhvOiDhot
         J46Y5572kGwALndv0n9yDINHnggjlBYzcJHFumrsN0irQcA06AS6LW45nxtt3xF/VTXO
         dfd2rbgWtvD+hLkj21YtysE7uFIvdOFT++wHajFSAAFTFe9fN4ZTesED/9yG4WGbeAZG
         kfCitVOmfWjmxjYS8RCZg4O1gey7KfAm1l0pPBLDfFKoCECmt7Oew+pocNSo7x1NIBtU
         LGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760384399; x=1760989199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCvB7wixF2b7Khlrp7jtKDjTw9jSL1Nm3LuVyC2V/Kg=;
        b=IqbaCVR7PoENfG3Fp9VPetnw6YN84y/MY0kcGTe7uYjvU8RvewYS5x6YJj/vy+6esw
         DELtUuL56/am2UhzrlBak0uRhJkAHwoYpZXOB1o04Ang6hEQck9SN1Ea0QyuTOBpWLV7
         NFwjOQEC0m6ff235y9bG3f3L3FRAIDDZZLgByuh8cH5R59UrSt9cEwoy0WDtcBZYt8QY
         CiMy845+gJeA45DGdLj7q2YHtQGdf53HZknMeZG5hloTl0SKO0ouy1bbzBEeKuIf9+Sf
         aX8fFA6619CYVkzSc+3ozpyGjfiulzbQMQvqzdpjfv30Av3NEBa9oIRk4IVE7d35Tkpz
         FJtg==
X-Forwarded-Encrypted: i=1; AJvYcCUfIQdZol9iNExku25qq5nAsu2d1qtvpDOdqLWS44vrLU0A2MjfnMEsVvhgz6LVWVwBcFlBJ0BqTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQL5f7PlgjMri8XXzt9gsV7c6Msi4GJok5MRt8VhAxti/VW/L
	rr2ybm5sEmM12td3tpMVFtjVJ7WIchWDXGAku6rgBHJ1iZpEkgGCjdQguRiWQ6cn3vOG1l8H67G
	qSBLqazYDq2mYt+DMwKZWp8TUtKUROenUHbZc28DL
X-Gm-Gg: ASbGncvkJw2F7DMRwq+yp5cezlK/1dEgnVa/qJMHUCYXQGUnD7Xkk5ELfE4SXyewGxC
	8GfhNV4KY0pVxRQAq9Kl1M135FiDidb3DmBcxirz9XAJTnbAaVtlSdS1E0uqDy4HGIQIqcTKzXx
	aL3xcbRVmFw502rJatfbEmuaOtpUiZRcIi4Nx0VFUqHM2OSHBGhBAipMeNrkOoR0yqxQbyUt9/3
	KLUzZyZdJ/drtNd2otqzKwcLjHazDQ=
X-Google-Smtp-Source: AGHT+IG3bjcuKnY5DB73APO/3YHNlkHGh4E8SN+gdzu+ZboELr1bFlI2ndvEg86IMp4kEeywi4eGca5LSzg8fdPF55g=
X-Received: by 2002:a05:6102:6883:b0:523:fa25:9dcb with SMTP id
 ada2fe7eead31-5d5e226aab6mr8653137137.8.1760384398306; Mon, 13 Oct 2025
 12:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911185314.2377124-1-wusamuel@google.com> <CAJZ5v0hwgNt3+stLDpdVbrpDfomEaQ26KikUDFN2QjBpNMgbfQ@mail.gmail.com>
 <CAGETcx_h9FD=VQRMeLmJF7htCnHksVBbgMBan4H1mEJKwNJKeg@mail.gmail.com>
 <CAJZ5v0j-vHA1OC4QMHssN-NxV23EQkZCz4VYCjKaD42_LD_Oeg@mail.gmail.com> <CAJZ5v0h3wTGqTn-DqAKA6_bxF-=sQGauGJm_BUOxeQd87EQSYw@mail.gmail.com>
In-Reply-To: <CAJZ5v0h3wTGqTn-DqAKA6_bxF-=sQGauGJm_BUOxeQd87EQSYw@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 13 Oct 2025 12:39:21 -0700
X-Gm-Features: AS18NWASDjGuLEMkEIQgzIciFPAPjep4NXlJsD4sxGvqNTElrsvFwbBy0hS04zU
Message-ID: <CAGETcx-2K3nynx_BSURPvCCuB_U-wpjgcm2nHE5cygqm+tnfrw@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 11:46=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Mon, Oct 13, 2025 at 8:39=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Mon, Oct 13, 2025 at 8:34=E2=80=AFPM Saravana Kannan <saravanak@goog=
le.com> wrote:
> > >
> > > On Mon, Oct 13, 2025 at 11:15=E2=80=AFAM Rafael J. Wysocki <rafael@ke=
rnel.org> wrote:
> > > >
> > > > On Thu, Sep 11, 2025 at 8:53=E2=80=AFPM Samuel Wu <wusamuel@google.=
com> wrote:
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
> > > > > discussed specifically for suspend by Saravana Kannan at LPC 2024=
 [1],
> > > > > where the general consensus was to allow filesystem sync on a par=
allel
> > > > > thread. The same logic applies to both suspend and hibernate code=
 paths.
> > > > >
> > > > > There is extra care needed to account for back-to-back sleeps whi=
le
> > > > > still maintaining functionality to immediately abort during the
> > > > > filesystem sync stage.
> > > > >
> > > > > This patch handles this by serializing the filesystem sync sequen=
ce with
> > > > > an invariant; a subsequent sleep's filesystem sync operation will=
 only
> > > > > start when the previous sleep's filesystem sync has finished. Whi=
le
> > > > > waiting for the previous sleep's filesystem sync to finish, the
> > > > > subsequent sleep will still abort early if a wakeup event is trig=
gered,
> > > > > solving the original issue of filesystem sync blocking abort.
> > > > >
> > > > > [1]: https://lpc.events/event/18/contributions/1845/
> > > > >
> > > > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > > > ---
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
> > > > >  drivers/base/power/wakeup.c |  8 +++++
> > > > >  include/linux/suspend.h     |  4 +++
> > > > >  kernel/power/hibernate.c    |  5 ++-
> > > > >  kernel/power/main.c         | 70 +++++++++++++++++++++++++++++++=
++++++
> > > > >  kernel/power/suspend.c      |  7 ++--
> > > > >  5 files changed, 91 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wak=
eup.c
> > > > > index d1283ff1080b..daf07ab7ac3f 100644
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
> > > > > +               abort_sleep_during_fs_sync();
> > > > >
> > > > >         trace_wakeup_source_activate(ws->name, cec);
> > > > >  }
> > > > > @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> > > > >  void pm_system_wakeup(void)
> > > > >  {
> > > > >         atomic_inc(&pm_abort_suspend);
> > > > > +       abort_sleep_during_fs_sync();
> > > > >         s2idle_wake();
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> > > > > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > > > > index 317ae31e89b3..c961bdb00bb6 100644
> > > > > --- a/include/linux/suspend.h
> > > > > +++ b/include/linux/suspend.h
> > > > > @@ -444,6 +444,8 @@ void restore_processor_state(void);
> > > > >  extern int register_pm_notifier(struct notifier_block *nb);
> > > > >  extern int unregister_pm_notifier(struct notifier_block *nb);
> > > > >  extern void ksys_sync_helper(void);
> > > > > +extern void abort_sleep_during_fs_sync(void);
> > > > > +extern int pm_sleep_fs_sync(void);
> > > > >  extern void pm_report_hw_sleep_time(u64 t);
> > > > >  extern void pm_report_max_hw_sleep(u64 t);
> > > > >  void pm_restrict_gfp_mask(void);
> > > > > @@ -499,6 +501,8 @@ static inline void pm_restrict_gfp_mask(void)=
 {}
> > > > >  static inline void pm_restore_gfp_mask(void) {}
> > > > >
> > > > >  static inline void ksys_sync_helper(void) {}
> > > > > +static inline abort_sleep_during_fs_sync(void) {}
> > > > > +static inline int pm_sleep_fs_sync(void) {}
> > > > >
> > > > >  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
> > > > >
> > > > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > > > index 2f66ab453823..651dcd768644 100644
> > > > > --- a/kernel/power/hibernate.c
> > > > > +++ b/kernel/power/hibernate.c
> > > > > @@ -811,7 +811,10 @@ int hibernate(void)
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
> > > > > index 3cf2d7e72567..38b1de295cfe 100644
> > > > > --- a/kernel/power/main.c
> > > > > +++ b/kernel/power/main.c
> > > > > @@ -570,6 +570,76 @@ bool pm_sleep_transition_in_progress(void)
> > > > >  {
> > > > >         return pm_suspend_in_progress() || hibernation_in_progres=
s();
> > > > >  }
> > > > > +
> > > > > +static bool pm_sleep_fs_sync_queued;
> > > > > +static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
> > > > > +static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
> > > > > +
> > > > > +/**
> > > > > + * abort_sleep_during_fs_sync - Abort fs_sync to abort sleep ear=
ly
> > > > > + *
> > > > > + * This function aborts the fs_sync stage of suspend/hibernate s=
o that
> > > > > + * suspend/hibernate itself can be aborted early.
> > > >
> > > > This changelog needs to be more precise IMV.
> > > >
> > > > I'd actually call the function something like
> > > > pm_stop_waiting_for_fs_sync() and I'd say in the changelog that the
> > > > functions causes a suspend process to stop waiting on an fs sync in
> > > > progress and continue so that it can be aborted before the fs sync =
is
> > > > complete.
> > > >
> > > > > + */
> > > > > +void abort_sleep_during_fs_sync(void)
> > > > > +{
> > > > > +       spin_lock(&pm_sleep_fs_sync_lock);
> > > > > +       complete(&pm_sleep_fs_sync_complete);
> > > > > +       spin_unlock(&pm_sleep_fs_sync_lock);
> > > > > +}
> > > > > +
> > > > > +static void sync_filesystems_fn(struct work_struct *work)
> > > > > +{
> > > > > +       ksys_sync_helper();
> > > > > +
> > > > > +       spin_lock(&pm_sleep_fs_sync_lock);
> > > > > +       pm_sleep_fs_sync_queued =3D false;
> > > > > +       complete(&pm_sleep_fs_sync_complete);
> > > > > +       spin_unlock(&pm_sleep_fs_sync_lock);
> > > > > +}
> > > > > +static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
> > > > > +
> > > > > +/**
> > > > > + * pm_sleep_fs_sync - Trigger fs_sync with ability to abort
> > > > > + *
> > > > > + * Return 0 on successful file system sync, otherwise returns -E=
BUSY if file
> > > > > + * system sync was aborted.
> > > > > + */
> > > > > +int pm_sleep_fs_sync(void)
> > > > > +{
> > > > > +       bool need_pm_sleep_fs_sync_requeue;
> > > > > +
> > > > > +Start_fs_sync:
> > > > > +       spin_lock(&pm_sleep_fs_sync_lock);
> > > > > +       reinit_completion(&pm_sleep_fs_sync_complete);
> > > > > +       /*
> > > > > +        * Handle the case where a sleep immediately follows a pr=
evious sleep
> > > > > +        * that was aborted during fs_sync. In this case, wait fo=
r the previous
> > > > > +        * filesystem sync to finish. Then do another filesystem =
sync so any
> > > > > +        * subsequent filesystem changes are synced before sleepi=
ng.
> > > >
> > > > Is the extra sync really necessary?
> > >
> > > Yeah, since the fs syncs can take up to 25 seconds in some cases,
> > > there's enough time to create new dirty data that needs to be written
> > > to disk. So, we want to sync again to write all of that out as if the
> > > previous attempt/abort hadn't happened. And to do that correctly, we
> > > have to let the existing sync finish and then kick off the new one
> > > once the "work" and "completion" are in a good state.
> >
> > And if the new suspend is aborted while the new fs sync is in
> > progress, then you'll repeat the exercise and so on, possibly ad
> > infinitum?
>
> Also, by the above argument, you should do an extra fs sync after
> every fs sync taking "too much" time, not just when the previous
> suspend has been aborted during an fs sync.

The goal is to NOT regress what gets synced when we add the ability to
abort suspend while fs sync is in progress. I'm open to other ideas if
you can ensure we aren't regressing it.

But even if we ignore that, we clearly have to make sure the previous
sync/work isn't "in use" before we try to requeue the work. So, this
needs to be done anyway?

We also can't cancel/flush sync the work because that'll take us back
to square one where the abort can get hung up behind a fs sync
completing.

-Saravana

