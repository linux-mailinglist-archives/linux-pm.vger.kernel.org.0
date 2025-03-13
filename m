Return-Path: <linux-pm+bounces-24005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5ACA6044F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 23:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A020816EDBD
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 22:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6211F8726;
	Thu, 13 Mar 2025 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/qyLaUA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D681F7075;
	Thu, 13 Mar 2025 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904994; cv=none; b=OwwUvSAWBTH54MW1A7AMpna7PDnfgE1Bu2EYZ+tkqSsqZfveaoYMxqGjn9G9CqNdhOpVRCrTbYFN3+8i6c47ZsCZDDz8kPfmi8tp3YUQOMS5xAVn/3XTP5N+A8oypLCPGuUGtBa2JAQSVLC59+okaENeOH1fMUD/hHGXdCpiWZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904994; c=relaxed/simple;
	bh=NGshL9iMXY0ehUq8wmMfgZiKRFGwxuvuWj6XAEH8dyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQ2FJ/3JdSuvv8gvxM3TMHwsgo4ZgNmq7sAJiyI20LNyRybiELUL/auUJLEvhkVoINCH6qHSAo/HLwzDl/HzegXHc4edtPeUgwTBuG2q/Pd0p8vfw0Unq9U3Cjap5npF0al6f4OiRAXjNI3SCxZEhjVz/4DqMlejZmflA9U9sjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/qyLaUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F209C4CEEA;
	Thu, 13 Mar 2025 22:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741904993;
	bh=NGshL9iMXY0ehUq8wmMfgZiKRFGwxuvuWj6XAEH8dyA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P/qyLaUAeaZ1mwWxrO6OXgv5ABgXOxKlFWwVh9rNmeZQyHSDauMT2x4cvbsgYTiHq
	 wCh9Gu7+orVSNHEsKtB7HiidDw/lalHD1Ctqg78ldgXf5OiAvw0X8F41vcGvVCjlXy
	 IN1w3iWWFruGEJBpR8CfULOcY3/s8kwEbEJbEnYfpKeAaJJfUrFRfcJ9IMrtLMHPnf
	 oCVHDfFeWU6G5iAajy/XAgZDDIZGJv/Gg5ZD4RNBS5Z56yIt0TABlJnQ+uv+IXWfNp
	 KCPc2Pgkg3DA1XvtUjC/RIyUBDzrpIZi4IdZ0ntaypfX3JsbuY+N3ilnAkVA9zCkSc
	 uWsB1encKz1mA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso1324407fac.2;
        Thu, 13 Mar 2025 15:29:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGdsjChpy8DmVDiTaux3xAqo8oG2v2mgfzr+52kaAr/Ur6YX7RcGSVZFLosHgr208Jm6KocXPyR/g=@vger.kernel.org, AJvYcCVAHteS2XNzmGZpg4yP430A+qi3Gt9QuUs1Y/5PRmSUtsIOYMYqBDCozEjnbnA+DnMA2zw5t+6+0KN30lY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdl3Z4kyVWKwHalLItM8RLQWDIuqlVqAgPurX6JBUlbkLijqf8
	PM3uzNqwBi7f7axsadu3gDnQHPn8hqnkJBnIw/ovBlZOqsi+8kNL/9Kz+4Bu+J+vU0mCsIkrCAc
	/SCtdcBHQg0IDbNr3j506CB+EO3Q=
X-Google-Smtp-Source: AGHT+IHBLoRlMYuRBtFJaK8V5rF3lwV6A9GZLjOGQwWPR/VOLdETvfPG9zhNx/uJXKclKEXyjxM1YIgCVeBXsqTmaKw=
X-Received: by 2002:a05:6870:7e07:b0:2c2:5ac3:4344 with SMTP id
 586e51a60fabf-2c690f944f8mr181907fac.15.1741904992358; Thu, 13 Mar 2025
 15:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1915694.tdWV9SEqCh@rjwysocki.net> <3346996.44csPzL39Z@rjwysocki.net>
 <CAGETcx_s1YHMQraDS23iPkax_rAF7u7BrC7nP4mQjZHZ5Rww6w@mail.gmail.com>
In-Reply-To: <CAGETcx_s1YHMQraDS23iPkax_rAF7u7BrC7nP4mQjZHZ5Rww6w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Mar 2025 23:29:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j_exikLyS7MeZT75hD-8y1uwJdYQvDjwepCOmow506Zw@mail.gmail.com>
X-Gm-Features: AQ5f1JqEB7dscluXjmLaCWlIMLZ7rQZ1bXmXghIxR_E3ZE1fIZmzgz8oP3_7knc
Message-ID: <CAJZ5v0j_exikLyS7MeZT75hD-8y1uwJdYQvDjwepCOmow506Zw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: sleep: Resume children after resuming the parent
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 10:17=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
>
> On Thu, Mar 13, 2025 at 1:35=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.=
net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > According to [1], the handling of device suspend and resume, and
> > particularly the latter, involves unnecessary overhead related to
> > starting new async work items for devices that cannot make progress
> > right away because they have to wait for other devices.
> >
> > To reduce this problem in the resume path, use the observation that
> > starting the async resume of the children of a device after resuming
> > the parent is likely to produce less scheduling and memory management
> > noise than starting it upfront while at the same time it should not
> > increase the resume duration substantially.
> >
> > Accordingly, modify the code to start the async resume of the device's
> > children when the processing of the parent has been completed in each
> > stage of device resume and only start async resume upfront for devices
> > without parents.
> >
> > Also make it check if a given device can be resumed asynchronously
> > before starting the synchronous resume of it in case it will have to
> > wait for another that is already resuming asynchronously.
> >
> > In addition to making the async resume of devices more friendly to
> > systems with relatively less computing resources, this change is also
> > preliminary for analogous changes in the suspend path.
> >
> > On the systems where it has been tested, this change by itself does
> > not affect the overall system resume duration in a significant way.
> >
> > Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravan=
ak@google.com/ [1]
> > Suggested-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2:
> >    Use a separate lock for power.work_in_progress protection which shou=
ld
> >    reduce lock contention on dpm_list_mtx.
> >
> > ---
> >  drivers/base/power/main.c |   80 +++++++++++++++++++++++++++++++++++--=
---------
> >  1 file changed, 61 insertions(+), 19 deletions(-)
> >
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -63,6 +63,7 @@
> >  static DEFINE_MUTEX(dpm_list_mtx);
> >  static pm_message_t pm_transition;
> >
> > +static DEFINE_MUTEX(async_wip_mtx);
>
> I think (not sure) this can be a spinlock.

No, it can't, because async_schedule_dev_nocall() allocates memory
with GFP_KERNEL.

> >  static int async_error;
> >
> >  static const char *pm_verb(int event)
> > @@ -597,8 +598,11 @@
> >                 && !pm_trace_is_enabled();
> >  }
> >
> > -static bool dpm_async_fn(struct device *dev, async_func_t func)
> > +static bool __dpm_async(struct device *dev, async_func_t func)
> >  {
> > +       if (dev->power.work_in_progress)
> > +               return true;
> > +
> >         if (!is_async(dev))
> >                 return false;
> >
> > @@ -611,14 +615,37 @@
> >
> >         put_device(dev);
> >
> > +       return false;
> > +}
> > +
> > +static bool dpm_async_fn(struct device *dev, async_func_t func)
> > +{
> > +       guard(mutex)(&async_wip_mtx);
> > +
> > +       return __dpm_async(dev, func);
> > +}
> > +
> > +static int dpm_async_with_cleanup(struct device *dev, void *fn)
> > +{
> > +       guard(mutex)(&async_wip_mtx);
> > +
> > +       if (!__dpm_async(dev, fn))
> > +               dev->power.work_in_progress =3D false;
> > +
> > +       return 0;
> > +}
> > +
> > +static void dpm_async_resume_children(struct device *dev, async_func_t=
 func)
> > +{
> >         /*
> > -        * async_schedule_dev_nocall() above has returned false, so fun=
c() is
> > -        * not running and it is safe to update power.work_in_progress =
without
> > -        * extra synchronization.
> > +        * Start processing "async" children of the device unless it's =
been
> > +        * started already for them.
> > +        *
> > +        * This could have been done for the device's "async" consumers=
 too, but
> > +        * they either need to wait for their parents or the processing=
 has
> > +        * already started for them after their parents were processed.
> >          */
> > -       dev->power.work_in_progress =3D false;
> > -
> > -       return false;
> > +       device_for_each_child(dev, func, dpm_async_with_cleanup);
>
> Continuing my comments from v1 here, it's not a good assumption to
> make that the child can start resuming just because the parent has
> finished resuming.

Well, there is one dependency less for it, so it makes sense to start
async processing for it because it may be ready.  It doesn't have to
be ready for sure, but if it's not ready, it'll wait.

I know that you want to avoid the waiting at all, but I'm not
convinced that this is necessary and even that this is the right
approach and I'm afraid the only way to convince me would be to
demonstrate it.

Explicit dependency tracking here would be extra overhead and
complexity and I'm not going to do it until I know that it is actually
worth the hassle.

> In my example, I have 386 device links and ~600
> devices that have some sort of suspend ops (I think the total device
> node count is ~1700).

However, some of those device links are between parents and children
IIRC.  If so, then how many?

> I'm even more confused by why you think resume needs to be asymmetric
> with suspend. In suspend, you kick off all the suppliers too when a
> device is done suspending, but in resume you don't kick off all the
> consumers.

This is based on the assumption that the majority of devices will have
a parent and since the diameter of the graph is less than the number
of devices, there are devices with multiple children whereas each
device can only have one parent.

Quite likely there are also devices with multiple consumers, but how
many devices with multiple suppliers are there?

> >  }
> >
> >  static void dpm_clear_async_state(struct device *dev)
> > @@ -627,6 +654,8 @@
> >         dev->power.work_in_progress =3D false;
> >  }
> >
> > +static void async_resume_noirq(void *data, async_cookie_t cookie);
> > +
> >  /**
> >   * device_resume_noirq - Execute a "noirq resume" callback for given d=
evice.
> >   * @dev: Device to handle.
> > @@ -710,6 +739,8 @@
> >                 dpm_save_failed_dev(dev_name(dev));
> >                 pm_dev_err(dev, state, async ? " async noirq" : " noirq=
", error);
> >         }
> > +
> > +       dpm_async_resume_children(dev, async_resume_noirq);
> >  }
> >
> >  static void async_resume_noirq(void *data, async_cookie_t cookie)
> > @@ -733,19 +764,20 @@
> >         mutex_lock(&dpm_list_mtx);
> >
> >         /*
> > -        * Trigger the resume of "async" devices upfront so they don't =
have to
> > -        * wait for the "non-async" ones they don't depend on.
> > +        * Start processing "async" devices without parents upfront so =
they
> > +        * don't wait for the "sync" devices they don't depend on.
> >          */
> >         list_for_each_entry(dev, &dpm_noirq_list, power.entry) {
> >                 dpm_clear_async_state(dev);
> > -               dpm_async_fn(dev, async_resume_noirq);
> > +               if (!dev->parent)
>
> This check isn't sufficient. There are plenty of devices where they
> have no parent, but they have many suppliers.

Again, how many?

> That's the reality in the DT world. And when you do deeper down the tree
> (dpm_async_resume_children), the children typically have more
> suppliers.

The numbers you gave above don't seem to support this, though, and
even so, by the time the parent has resumed, it is quite likely that
the suppliers have resumed either.

> You can also check for "no suppliers" to find the true leaf nodes and
> start with them, but that means you also have to kick off the
> consumers when you finish your resume.

That can be done, but how much of a difference will it really make?
You are saying "a lot", but this is not really quantitative.

> We definitely need to check
> device links for this patchset to be useful for me. With my patch
> series, it's effectively just NCPU kworkers running continuously on
> each CPU. Won't be the case if we don't check the device links. And as
> I said before, the overhead isn't just about context switches, but
> also forking more kworker threads.

What about comparing this series with your series on the system in
question and sharing the numbers?  You could easily get a stake in the
ground this way.

Cheers, Rafael

