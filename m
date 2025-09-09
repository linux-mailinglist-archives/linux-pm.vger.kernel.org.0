Return-Path: <linux-pm+bounces-34190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B462B49EC5
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 03:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F964E3B7B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 01:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8238321FF45;
	Tue,  9 Sep 2025 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8bwLMNz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749B21C9E5
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757382134; cv=none; b=Hcn4RVDovYEYqBnCkl2QVgZ9Z2htcTIs5vf0JobQN1b/1h9ETJ8kXKa1K+B+dYgM2caCeWJXtuHfS96L+mFZXyVgHiu42NI8/yPQxFEascxTqRpjLLxQ4UZHL9D4t/J8Dp+Fo8T/fLJZg6lxAnZgITBDzZTzrXFZVw6qJPbyUvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757382134; c=relaxed/simple;
	bh=oJhN3z3H5QEIgAJhWdiwxVmZqq21uVCwvZbBwZUXNS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxbbT8lFrS3UGa2oUlf5AQY3TabXLckpQuLgfxTwp0+sIejbfBVkcmfiOgwLuKK6XagDIC9QhIQ3P5gcWjOWZjEjwIzgnBKFsem2tUW5+pqKrcho7zlABwXaDXJzkgIgJclu8SlokaZZYLjlRvozfot8RNDSnbKZ+vgoqDTaZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8bwLMNz; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-529f4770585so3354904137.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2025 18:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757382131; x=1757986931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yq92p50racd2GkMTL0hC1g4bBfuWl2nmhdLmR0buDtY=;
        b=b8bwLMNzW5VAowZXaNN5KP8de9zhsjZCAgi0D6G8TvBINF/1vRdQiqeud/Zg/jXQwW
         CA+ySFYcSnWgzGt3lUIha4gKIbj5qJy1YVbZhvUyCCpWxCVC4fybz4AkaKdY/o/wwii5
         2EM1FYToQvBLa8s2W9w2mKBP5YLwLKqg/nksM+j6P0aAx/ZIhw7yuyjaIyLKvwQV98sT
         WbosQrVfNC1JXR/NgXL3v3/OyEQAbkJJz3PnTD/5G5awKuomaKUFSt5rM+xdDrTnamcr
         no34a0v3sd31BEmf+3sliRlv8oHUX+hCCps/yU8MSOdSx/NbmzrUpXb5ECrWaDozSUGB
         Cb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757382131; x=1757986931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yq92p50racd2GkMTL0hC1g4bBfuWl2nmhdLmR0buDtY=;
        b=ExmeoZeutngHJuEcuipSkoxXVr66xUj4Hi36jI+dz3Y3mcvEJnyIGMrFHFqWI+PlR+
         iGP9wtMJ0As+WkMHCVW8kmCj9WjiVcAMnB1Y5+Of9rOEAQ5ADE6Y4upbX5clk5i8Jo9z
         60Q9QtI1x5ugHp+VofUt0m+h8CtEKj7/DS8a/xyCobo9RRQ30On06lKEzzaXr96+Y3i6
         zHgCjO7c7tZhnO2s8jCap7YBCmYWHZfw9oFmDFBmzzQ0h6+oB7YWA2dTCXAqi6HPeiRh
         pVn9jxNmdIlfiu/ytV99QUie/WZUa435Jnd95LAGpwgsER3wIXEwk66CLST31QO4g8xC
         NKbg==
X-Forwarded-Encrypted: i=1; AJvYcCWSEo0z0PPRuhnXe993Ofb3PbrmkKvQt2TWQW0vx36OCtmWYh+z3E49t4T/soWlHwmUWSJjBpBndA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13Tj96MQ+dfGu6Jr6V5FpQTTXhyazgZ7cVMMGTgsLMF4+Ggwk
	TMRmFuWR0oXXv0aZUMTMHFgayYFFW7u8kPxTnXMpxwBQ2acwDtgS4Lx3n0M/cc0+AEcgyNIGC5e
	1C5QiKW3Bh3AYF3xvMB7IOPhTvkjFcrapMML1qhjb
X-Gm-Gg: ASbGncvaVxIiPbV7Y3e0HcMXRpMdfNzC+RgdrWm30kHaTOd1iJuppydGahb2j7y+f/c
	4IgLrhIrM/wlSEjUcaqt+3MoJM4NB0YKKOywFU+kW4+3grfhhf0idycAEm4+I8NJ4lmrmoasa1K
	pcxVLxgURGilOTz8I24W6kd7H/Nam84TqNkZWBw51L0+vjEkMkAAGHJuBEA0Ip2KUn8c8jNL0sk
	goC2YlG4/Cr7QVb
X-Google-Smtp-Source: AGHT+IF3vhdZPmb5ybTgxyrmoQoXJwh0Mf3bRPKRutRWXQTtu8T57KEv3Ttry6FrenAzhRe0bcLcRUgdkmXs6s7w27s=
X-Received: by 2002:a05:6102:4a98:b0:4fd:53e0:b522 with SMTP id
 ada2fe7eead31-53d21db63c7mr2937824137.19.1757382131115; Mon, 08 Sep 2025
 18:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821004237.2712312-1-wusamuel@google.com> <20250821004237.2712312-3-wusamuel@google.com>
 <CAJZ5v0gT2h_SgPDh=t-XWxgWnm8diG_rMuDVo-RnQxqvA7chPw@mail.gmail.com>
 <CAGETcx-3n9Qkiu70Pd2=sjSRsXNMf=CsJQdNLbHUS089qf=vsw@mail.gmail.com> <CAJZ5v0gerKe7fmTh==F4HOOAmF60devB2N8pV1fn9QzX45JzAA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gerKe7fmTh==F4HOOAmF60devB2N8pV1fn9QzX45JzAA@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 8 Sep 2025 18:41:34 -0700
X-Gm-Features: AS18NWBGMgHafWWmMBMQU-LCiP507gytlnc-4UBn_03OWYCIAP5kGsJMd_y-Ip0
Message-ID: <CAGETcx8x5G75sQ9zVkxe+BpK7WsEk+LS6KDMd5BBR=xWPMtevg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PM: Support aborting suspend during filesystem sync
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 2:38=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Fri, Sep 5, 2025 at 7:07=E2=80=AFAM Saravana Kannan <saravanak@google.=
com> wrote:
> >
> > On Fri, Sep 5, 2025 at 2:22=E2=80=AFAM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> > >
> > > On Thu, Aug 21, 2025 at 2:43=E2=80=AFAM Samuel Wu <wusamuel@google.co=
m> wrote:
> > > >
> > > > At the start of suspend, filesystems will sync to save the current =
state
> > > > of the device. However, the long tail of the filesystem sync can ta=
ke
> > > > upwards of 25 seconds. If during this filesystem sync there is some
> > > > wakeup or abort signal, it will not be processed until the sync is
> > > > complete; from a user's perspective, this looks like the device is
> > > > unresponsive to any form of input.
> > > >
> > > > This patch adds functionality to handle a suspend abort signal when=
 in
> > > > the filesystem sync phase of suspend. This topic was first discusse=
d by
> > > > Saravana Kannan at LPC 2024 [1], where the general consensus was to
> > > > allow filesystem sync on a parallel thread.
> > > >
> > > > [1]: https://lpc.events/event/18/contributions/1845/
> > > >
> > > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > >
> > > The idea is fine with me, but I have comments on the implementation.
> > >
> > > First off, I'm not sure how the split of patch [3/3] from this one
> > > helps because that patch adds mandatory functionality.
> >
> > It makes the reviewing a lot easier -- at least for me. Especially if
> > you want to come back and look at the change history. But we are happy
> > to squash it if you feel strongly.
> >
> > >  Patch [2/3]
> > > cannot be applied without patch [3/3], so as far as I'm concerned, it
> > > is not applicable at all.
> > >
> > > > ---
> > > >  drivers/base/power/wakeup.c |  8 +++++++
> > > >  include/linux/suspend.h     |  2 ++
> > > >  kernel/power/suspend.c      | 48 +++++++++++++++++++++++++++++++++=
++--
> > > >  3 files changed, 56 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeu=
p.c
> > > > index d1283ff1080b..af4cf3e6ba44 100644
> > > > --- a/drivers/base/power/wakeup.c
> > > > +++ b/drivers/base/power/wakeup.c
> > > > @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wake=
up_source *ws)
> > > >
> > > >         /* Increment the counter of events in progress. */
> > > >         cec =3D atomic_inc_return(&combined_event_count);
> > > > +       /*
> > > > +        * wakeup_source_activate() aborts suspend only if events_c=
heck_enabled
> > > > +        * is set (see pm_wakeup_pending()). Similarly, abort suspe=
nd during
> > > > +        * fs_sync only if events_check_enabled is set.
> > > > +        */
> > > > +       if (events_check_enabled)
> > > > +               suspend_abort_fs_sync();
> > > >
> > > >         trace_wakeup_source_activate(ws->name, cec);
> > > >  }
> > > > @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> > > >  void pm_system_wakeup(void)
> > > >  {
> > > >         atomic_inc(&pm_abort_suspend);
> > > > +       suspend_abort_fs_sync();
> > > >         s2idle_wake();
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> > > > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > > > index 317ae31e89b3..68d2e8a7eeb1 100644
> > > > --- a/include/linux/suspend.h
> > > > +++ b/include/linux/suspend.h
> > > > @@ -276,6 +276,7 @@ extern void arch_suspend_enable_irqs(void);
> > > >
> > > >  extern int pm_suspend(suspend_state_t state);
> > > >  extern bool sync_on_suspend_enabled;
> > > > +extern void suspend_abort_fs_sync(void);
> > > >  #else /* !CONFIG_SUSPEND */
> > > >  #define suspend_valid_only_mem NULL
> > > >
> > > > @@ -296,6 +297,7 @@ static inline bool idle_should_enter_s2idle(voi=
d) { return false; }
> > > >  static inline void __init pm_states_init(void) {}
> > > >  static inline void s2idle_set_ops(const struct platform_s2idle_ops=
 *ops) {}
> > > >  static inline void s2idle_wake(void) {}
> > > > +static inline void suspend_abort_fs_sync(void) {}
> > > >  #endif /* !CONFIG_SUSPEND */
> > > >
> > > >  static inline bool pm_suspend_in_progress(void)
> > > > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > > > index 4bb4686c1c08..edacd2a4143b 100644
> > > > --- a/kernel/power/suspend.c
> > > > +++ b/kernel/power/suspend.c
> > > > @@ -31,6 +31,7 @@
> > > >  #include <linux/compiler.h>
> > > >  #include <linux/moduleparam.h>
> > > >  #include <linux/fs.h>
> > > > +#include <linux/workqueue.h>
> > > >
> > > >  #include "power.h"
> > > >
> > > > @@ -74,6 +75,19 @@ bool pm_suspend_default_s2idle(void)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
> > > >
> > > > +static DECLARE_COMPLETION(suspend_fs_sync_complete);
> > > > +
> > > > +/**
> > > > + * suspend_abort_fs_sync - Abort fs_sync to abort suspend early
> > >
> > > This name is kind of misleading because the function doesn't abort
> > > fs_sync.  It aborts suspend while fs_sync is in progress.
> > >
> > > The fs_sync is continuing and needs to be waited for to complete, at
> > > least in subsequent suspend/hibernate cycles.
> > >
> > > Does system shutdown need to wait for it too?
> >
> > If the system shutdown does a sync in parallel, does it matter this
> > one is going on in parallel too? Doesn't seem any different then
> > shutting down right after userspace calls fsync.
> >
> > Also, we allow skip sync on suspend today. So I doubt shutdown depends
> > on sync on suspend for correctness of shutdown.
>
> What if the sync is still in progress when shutdown takes place?
> Could shutdown somehow break it and cause data corruption, say?

We will take a closer look.

>
> > > > + *
> > > > + * This function aborts the fs_sync stage of suspend so that suspe=
nd itself can
> > > > + * be aborted early.
> > > > + */
> > > > +void suspend_abort_fs_sync(void)
> > > > +{
> > > > +       complete(&suspend_fs_sync_complete);
> > > > +}
> > > > +
> > > >  void s2idle_set_ops(const struct platform_s2idle_ops *ops)
> > > >  {
> > > >         unsigned int sleep_flags;
> > > > @@ -403,6 +417,34 @@ void __weak arch_suspend_enable_irqs(void)
> > > >         local_irq_enable();
> > > >  }
> > > >
> > > > +static void sync_filesystems_fn(struct work_struct *work)
> > > > +{
> > > > +       ksys_sync_helper();
> > > > +       complete(&suspend_fs_sync_complete);
> > > > +}
> > > > +static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
> > > > +
> > > > +/**
> > > > + * suspend_fs_sync_with_abort - Trigger fs_sync with ability to ab=
ort
> > > > + *
> > > > + * Return 0 on successful file system sync, otherwise returns -EBU=
SY if file
> > > > + * system sync was aborted.
> > > > + */
> > > > +static int suspend_fs_sync_with_abort(void)
> > >
> > > The "with_abort" part is not needed in this name and I'd prefer
> > > pm_sleep_ to be used instead of suspend_
> > >
> > > > +{
> > > > +       reinit_completion(&suspend_fs_sync_complete);
> > > > +       schedule_work(&sync_filesystems);
> > >
> > > If you used a dedicated workqueue for this, waiting for the previousl=
y
> > > scheduled filesystems sync would be as simple as calling
> > > flush_workqueue(pm_fs_sync_wq);
> >
> > Yeah, that was our first thought too. But unfortunately, we might want
> > to abort the suspend while the flush is happening (patch 3/3). Which
> > we can't do with flush_workqueue() and we go back to square one where
> > a suspend can't be aborted for a long time. That's why we need to
> > write it this way.
>
> So this is an optimization which I'm not sure is really necessary.
> Maybe let's start with the flush_workqueue() approach and then
> complicate things if it is demonstrated to be insufficient?

Unfortunately, back to back suspend attempts are very common in
Android. When we have a lot of dirty pages and approach the long tail
of 25 seconds to sync the file system, this is not a corner case at
all.

Also, even if it's only a 1% chance of happening, that's 10 million
users when the total population is a billion users. And this is very
user perceptible issue that significantly degrades the user experience
(it has happened to me too).

>
> > >
> > > > +       /*
> > > > +        * Completion is triggered by fs_sync finishing or a suspen=
d abort
> > > > +        * signal, whichever comes first
> > > > +        */
> > > > +       wait_for_completion(&suspend_fs_sync_complete);
> > > > +       if (pm_wakeup_pending())
> > > > +               return -EBUSY;
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  /**
> > > >   * suspend_enter - Make the system enter the given sleep state.
> > > >   * @state: System sleep state to enter.
> > > > @@ -588,14 +630,16 @@ static int enter_state(suspend_state_t state)
> > > >         if (state =3D=3D PM_SUSPEND_TO_IDLE)
> > > >                 s2idle_begin();
> > > >
> > > > +       pm_wakeup_clear(0);
> > > >         if (sync_on_suspend_enabled) {
> > > >                 trace_suspend_resume(TPS("sync_filesystems"), 0, tr=
ue);
> > > > -               ksys_sync_helper();
> > > > +               error =3D suspend_fs_sync_with_abort();
> > >
> > > The same thing would also be useful for hibernation.  Is there any
> > > reason for not doing it there?
> >
> > No reason not to. We could add support for that in a different patch
> > series?
>
> Not really.
>
> > Hibernate abort is not the top priority for us right now.
>
> With all due respect, please handle them both or none.  Otherwise,
> you'd create an arbitrary divergence that would become a maintenance
> burden going forward.

Fair enough. We can take care of that too.

Thanks,
Saravana

