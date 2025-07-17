Return-Path: <linux-pm+bounces-30992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F93B0897F
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 11:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB1C3B3DC0
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 09:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D4028A3EA;
	Thu, 17 Jul 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLBpKFoL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61F288CBE;
	Thu, 17 Jul 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745216; cv=none; b=AqZaVqPF1r8xte/vVXPt3MIslsbRmsitjdskSXh0Qv/spuCVR1ZhFhtJIuioU4g7hfOZpNpok6KYR0qn+Zfu/WqKw6u5TMkjo8Rr7tC0B/yNusReClifNdMY2I+a3iMD0kcEhiz+cekbW5CF8rX/YyIOXtWlodhnYin67RPKAhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745216; c=relaxed/simple;
	bh=n/jEGmNwmstPDrrsksmS7Eun3jba5X+4dX/kbanNKYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpK304jt9lbqBo9Shn2GMHJqiQ0P9U3LgBjVdwxxk6jv5PRiXlo+NJy90Ri3C2zr44p5lAsXhdpGBXSGsRjpWiAYJODDlw1iSSkbtB/q6WtArAujYSUEd59sRve5L/5Y3TXEu2XjB2y2yfjB4IuYMnKHI64vlktxlci0oFZ8/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLBpKFoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD3CC4CEE3;
	Thu, 17 Jul 2025 09:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752745216;
	bh=n/jEGmNwmstPDrrsksmS7Eun3jba5X+4dX/kbanNKYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eLBpKFoLhhM4XYYE2FkftIhVy1C5Vv5jMDARviBBZE7eDzWIDsKWNlVdHfVC4CqjV
	 HLTGY45sO5bGtBDGpGpgIBrsceQEVdb7Aa6ueHxmiYHbctgYb0pKIeyZYwzxn5JZ/c
	 KM3aMcOYAKk+7lKCaiNBS51q2udhyM0xNlEfqszg9Oqnzr/w3dasrFQB4S9CtJf/6s
	 EmeV105c6j9u8wCEzPcKSZPwR1Und1vZJ6afXi8JonYuPFmpvUWBQgYgxXYTS0IopC
	 9QGqZPa5J7poCwI0Ri+vl7L16QHU0qmJf6z8MzOReYi5QaH2/XpSvck+TfzZ51vhRD
	 0FJAf6Mp0HGFw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61208b86da2so187328eaf.2;
        Thu, 17 Jul 2025 02:40:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkB7Fi8FfTBmRWzycl835QN6FJ+6A5UcSv//zHSyogsgM8H+2mwR38TUHvriCUkgxBSArDqe3Yp01Urgk=@vger.kernel.org, AJvYcCW3L8L6AeQMdla/h9dcoPdS9iPh28IQ0k1Tgzk3Gg/j6mj1iR0VJeGMAJnbbA+8YEyp0NzLXu5mPjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmC99nX0kObSOFSI3afAmW5rr0HXuodCLXjjd2oOPt0taymNjP
	97fCO5oQ2ttGjqLM3I6KYU3lKZvcTNQBqM0xopyxt+uj+Ta89GSYxR/gr6Ly+9YvXw1I8Kye+h5
	5W7wrDUrwvxu51Bmt3bzA10gmiULd88A=
X-Google-Smtp-Source: AGHT+IHyFjB0hVzWZMrgRfqjqyCBvNUF3k8laQHHTCdJ62HP30es2BBivCx9gqjaAWEnntZ0aahfFQqpXc1LqYLpVgI=
X-Received: by 2002:a05:6820:4b87:b0:610:fc12:cbb4 with SMTP id
 006d021491bc7-6159fe1ef24mr5129587eaf.1.1752745215456; Thu, 17 Jul 2025
 02:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6198088.lOV4Wx5bFT@rjwysocki.net> <CAGETcx-ddJMua5_VMNofr2vZ9n5Oyo4iT6Bac825L8tFqqQsxg@mail.gmail.com>
In-Reply-To: <CAGETcx-ddJMua5_VMNofr2vZ9n5Oyo4iT6Bac825L8tFqqQsxg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jul 2025 11:40:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jBQbDx2G0ZUy+Jx2yAdt_KCOJhOEbpQfLar=yWwvbhOA@mail.gmail.com>
X-Gm-Features: Ac12FXw6-PWegMeVz_LQhekIZH8m6qssTfLXZ96WnnZI-UK1ShtRgVUHOqFUplU
Message-ID: <CAJZ5v0jBQbDx2G0ZUy+Jx2yAdt_KCOJhOEbpQfLar=yWwvbhOA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Rearrange suspend/resume error handling in
 the core
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 11:52=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
>
> On Wed, Jul 16, 2025 at 12:31=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Notice that device_suspend_noirq(), device_suspend_late() and
> > device_suspend() all set async_error on errors, so they don't really
> > need to return a value.  Accordingly, make them all void and use
> > async_error in their callers instead of their return values.
> >
> > Moreover, since async_error is updated concurrently without locking
> > during asynchronous suspend and resume processing, use READ_ONCE() and
> > WRITE_ONCE() for accessing it in those places to ensure that all of the
> > accesses will be carried out as expected.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Based on the current linux-pm.git material in linux-next.
> >
> > ---
> >  drivers/base/power/main.c |   79 ++++++++++++++++++++-----------------=
---------
> >  1 file changed, 35 insertions(+), 44 deletions(-)
> >
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -767,7 +767,7 @@
> >         TRACE_RESUME(error);
> >
> >         if (error) {
> > -               async_error =3D error;
> > +               WRITE_ONCE(async_error, error);
> >                 dpm_save_failed_dev(dev_name(dev));
> >                 pm_dev_err(dev, state, async ? " async noirq" : " noirq=
", error);
> >         }
> > @@ -824,7 +824,7 @@
> >         mutex_unlock(&dpm_list_mtx);
> >         async_synchronize_full();
> >         dpm_show_time(starttime, state, 0, "noirq");
> > -       if (async_error)
> > +       if (READ_ONCE(async_error))
> >                 dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
> >
> >         trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, fals=
e);
> > @@ -910,7 +910,7 @@
> >         complete_all(&dev->power.completion);
> >
> >         if (error) {
> > -               async_error =3D error;
> > +               WRITE_ONCE(async_error, error);
> >                 dpm_save_failed_dev(dev_name(dev));
> >                 pm_dev_err(dev, state, async ? " async early" : " early=
", error);
> >         }
> > @@ -971,7 +971,7 @@
> >         mutex_unlock(&dpm_list_mtx);
> >         async_synchronize_full();
> >         dpm_show_time(starttime, state, 0, "early");
> > -       if (async_error)
> > +       if (READ_ONCE(async_error))
> >                 dpm_save_failed_step(SUSPEND_RESUME_EARLY);
> >
> >         trace_suspend_resume(TPS("dpm_resume_early"), state.event, fals=
e);
> > @@ -1086,7 +1086,7 @@
> >         TRACE_RESUME(error);
> >
> >         if (error) {
> > -               async_error =3D error;
> > +               WRITE_ONCE(async_error, error);
> >                 dpm_save_failed_dev(dev_name(dev));
> >                 pm_dev_err(dev, state, async ? " async" : "", error);
> >         }
> > @@ -1150,7 +1150,7 @@
> >         mutex_unlock(&dpm_list_mtx);
> >         async_synchronize_full();
> >         dpm_show_time(starttime, state, 0, NULL);
> > -       if (async_error)
> > +       if (READ_ONCE(async_error))
> >                 dpm_save_failed_step(SUSPEND_RESUME);
> >
> >         cpufreq_resume();
> > @@ -1387,7 +1387,7 @@
> >   * The driver of @dev will not receive interrupts while this function =
is being
> >   * executed.
> >   */
> > -static int device_suspend_noirq(struct device *dev, pm_message_t state=
, bool async)
> > +static void device_suspend_noirq(struct device *dev, pm_message_t stat=
e, bool async)
> >  {
> >         pm_callback_t callback =3D NULL;
> >         const char *info =3D NULL;
> > @@ -1398,7 +1398,7 @@
> >
> >         dpm_wait_for_subordinate(dev, async);
> >
> > -       if (async_error)
> > +       if (READ_ONCE(async_error))
> >                 goto Complete;
> >
> >         if (dev->power.syscore || dev->power.direct_complete)
> > @@ -1431,7 +1431,7 @@
> >  Run:
> >         error =3D dpm_run_callback(callback, dev, state, info);
> >         if (error) {
> > -               async_error =3D error;
> > +               WRITE_ONCE(async_error, error);
> >                 dpm_save_failed_dev(dev_name(dev));
> >                 pm_dev_err(dev, state, async ? " async noirq" : " noirq=
", error);
> >                 goto Complete;
> > @@ -1457,12 +1457,10 @@
> >         complete_all(&dev->power.completion);
> >         TRACE_SUSPEND(error);
> >
> > -       if (error || async_error)
> > -               return error;
> > +       if (error || READ_ONCE(async_error))
> > +               return;
> >
> >         dpm_async_suspend_superior(dev, async_suspend_noirq);
> > -
> > -       return 0;
> >  }
> >
> >  static void async_suspend_noirq(void *data, async_cookie_t cookie)
> > @@ -1477,7 +1475,7 @@
> >  {
> >         ktime_t starttime =3D ktime_get();
> >         struct device *dev;
> > -       int error =3D 0;
> > +       int error;
>
> Are we still keeping around the error variable ... (question continues
> further down)
> >
> >         trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, tru=
e);
> >
> > @@ -1508,13 +1506,13 @@
> >
> >                 mutex_unlock(&dpm_list_mtx);
> >
> > -               error =3D device_suspend_noirq(dev, state, false);
> > +               device_suspend_noirq(dev, state, false);
> >
> >                 put_device(dev);
> >
> >                 mutex_lock(&dpm_list_mtx);
> >
> > -               if (error || async_error) {
> > +               if (READ_ONCE(async_error)) {
> >                         dpm_async_suspend_complete_all(&dpm_late_early_=
list);
> >                         /*
> >                          * Move all devices to the target list to resum=
e them
> > @@ -1528,9 +1526,8 @@
> >         mutex_unlock(&dpm_list_mtx);
> >
> >         async_synchronize_full();
> > -       if (!error)
> > -               error =3D async_error;
> >
> > +       error =3D READ_ONCE(async_error);
>
> Just to cache the value locally so that the value used for the "if()"
> check is the one that's sent to dpm_show_time()?

Generally, yes.

To be more precise, the READ_ONCE() is not really necessary after the
async_synchronize_full(), so "bare" async_error could be used going
forward, but then I would need to add a comment explaining this here
and in two other places, so I chose to just use the existing local
variable to store the value.

> Put another way, why can't we also delete the local "error" variable?

It could be deleted, but I preferred to make fewer changes in this patch.

> Assuming we need to keep "error":
>
> Reviewed-by: Saravana Kannan <saravanak@google.com>

Thanks!

