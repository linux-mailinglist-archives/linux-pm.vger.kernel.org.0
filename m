Return-Path: <linux-pm+bounces-23984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2DCA5F96A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 16:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1470B188E999
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC9726138E;
	Thu, 13 Mar 2025 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYbhLtFt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A419CFC08;
	Thu, 13 Mar 2025 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879017; cv=none; b=SAiG8uRdwXFGOWQrsibMT2L5Ph++GMvd50Z0oTfn+7wdPaVmwbAoXHfR1nFqvoBshzGYIWTRblHsDtmYmIJiyBVNfezrAl6EELalFF5/15Ke1HFgm5gzbuPFdOueUAhyVBJzq0eOyemFLRZc2GXthqs0iR1HLOwt64D1mx0mH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879017; c=relaxed/simple;
	bh=DyKj9OAa2ndB89I7PHXBVdazlTpuCK87qB36+y9pYA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAplMSkqZB0Vh3eyfmPx+3t5nDV3U5vi6O+sMOFkjtelQbh7ifxtpjgdskTfLdSOppb2A4XctQeS9qa2/se9Dmm5BedXMWqCpymdbjTCR/9HClK9hxcJL3BJPT1w5TN03dZhHemtpL+tA/CI9KMFi2N5/92FPTlKl6XPkFd6tIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYbhLtFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22346C4CEEF;
	Thu, 13 Mar 2025 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741879017;
	bh=DyKj9OAa2ndB89I7PHXBVdazlTpuCK87qB36+y9pYA0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TYbhLtFtYEXK+uv1q24tILG+lYtNYIrd4pQNa/9SmlklHialPyIYiXsFTDJBNg4sc
	 xrA6Xv/yfEopEB+Wlg/lbKykvoNr5jDhLXWxMuovb3HCZ2NZUFiIx2ltDfJFgvbWw3
	 KLimv7QyOmx09xrVrb9nDdFh4wt64xW/tPEkhIwmC55J6G/ONqXIC41crJOGADT90x
	 sRwEYyo0KwkXXtu1XanD2FZ4pM5zAnBmic1HriWUONdNdMZ+2ZwOBR8OCoGZYGBRtI
	 wXPVpl1QLDqvZHh68wJQ1R7rzdPbtbjok2SxtO7G+YYLGQbpwnqlzKJV+10GXnvKHc
	 nVkjwV7dZCHRw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2bcf9d9b60aso375602fac.3;
        Thu, 13 Mar 2025 08:16:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDMebEWuT9H7Numxqn40i7t86W+zCiKtveIrZwPp6fvxNMsD/UuRayUdy3meNcMEpUtB4FMunj0xP8ACE=@vger.kernel.org, AJvYcCVNSilFGpBnfemmE3IaAvFU/N/Kfz7x8/L4baWSJPT2yYF1lhR9FgZ05Y2zFk/QkQi/azjefrfIYCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyZN1mOskWgJX8NTQpPevW/HeNM15TudO1H4RQ71XS4J3DDBbL
	XlTkBL/vT+3idsFei2ob/d0W+Pw8RSnrL/cv+gcK1NMJWBXI90rr8RrjwDK4rkupPeDenOiZ7ZI
	lJa0Xxswk2oLXWa0EpeFQHXIAnHI=
X-Google-Smtp-Source: AGHT+IGDbZclqQ1GbUjtmZyTVw+IYyTYwSB+gf+fjqifHQkYzUUn3GyZrK/a0wZ8fqz076tKmAztOClVvit2aC01ztw=
X-Received: by 2002:a05:6870:9a1a:b0:29e:2caf:8cc with SMTP id
 586e51a60fabf-2c2e89c517fmr6263469fac.37.1741879016219; Thu, 13 Mar 2025
 08:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net> <1819312.VLH7GnMWUR@rjwysocki.net>
 <CAGETcx86f+8cGBxMixgoOy2fwgtEO_ysN1q-h9PACxdRjRiFPw@mail.gmail.com>
In-Reply-To: <CAGETcx86f+8cGBxMixgoOy2fwgtEO_ysN1q-h9PACxdRjRiFPw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Mar 2025 16:16:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jWEVU=68hnSiFRSmmF=5cne0ev1U8ebftvYN2NkhJ=UA@mail.gmail.com>
X-Gm-Features: AQ5f1JoKYOrAq2WDF2VauXThtL-C_IrV9ksQwFiE2m5IInRPHNvIiDGbh-Vh_fs
Message-ID: <CAJZ5v0jWEVU=68hnSiFRSmmF=5cne0ev1U8ebftvYN2NkhJ=UA@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] PM: sleep: Resume children right after resuming
 the parent
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 2:47=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> Sorry for the delay, I wanted to double, triple, multiple check my
> replies to make sure I didn't get it wrong. I hope I didn't.
>
> On Tue, Feb 25, 2025 at 8:46=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.=
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
> > not affect the overall system resume duration in a measurable way.
> >
> > Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravan=
ak@google.com/ [1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/main.c |   72 +++++++++++++++++++++++++++++++++++++=
+++------
> >  1 file changed, 63 insertions(+), 9 deletions(-)
> >
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -621,12 +621,41 @@
> >         return false;
> >  }
> >
> > +static int dpm_async_unless_in_progress(struct device *dev, void *fn)
> > +{
> > +       async_func_t func =3D fn;
> > +
> > +       if (!dev->power.work_in_progress)
> > +               dpm_async_fn(dev, func);
> > +
> > +       return 0;
> > +}
> > +
> > +static void dpm_async_resume_children(struct device *dev, async_func_t=
 func)
> > +{
> > +       mutex_lock(&dpm_list_mtx);
> > +
> > +       /*
> > +        * Start processing "async" children of the device unless it's =
been
> > +        * started already for them.
> > +        *
> > +        * This could have been done for the device's "async" consumers=
 too, but
> > +        * they either need to wait for their parents or the processing=
 has
> > +        * already started for them after their parents were processed.
> > +        */
> > +       device_for_each_child(dev, func, dpm_async_unless_in_progress);
>
> Is there a reason you aren't resuming the consumers? Or checking that
> the children won't block on any suppliers?

This is deliberate and the above comment is about it.

At this point, all of the consumers either still need to wait for
their parents, in which case it is not useful to queue them up, or
their parent's have already completed the resume and started their
processing, if they are async.

Checking if children won't block can be added here, but then (a) the
code will need to track their dependencies and (b) walking the
consumers would become necessary which is extra overhead.

Arguably, there are no devices with tons of children, so adding
several async work items that will just wait until they get unblocked
here should not add too much overhead.

> Not dealing with device links might be ok for systems where there
> aren't a lot of device links, but in DT based systems with fw_devlink
> this patch will not make much of a difference. There'll still be a ton
> of "sleep and try again" issues because of the supplier/consumer
> dependencies.

That IMO really needs to be evaluated because it all depends on how
much it takes to resume individual devices.

> And when you include device links, it's a dependency graph and no longer
> a dependency tree. So things become a bit more complicated.

They are, but all I said above still holds I believe.

> Also, not taking device links isn't consideration when kicking off
> async work is not just about additional sleep/wake cycles, but it'll
> also cause more thread creation because blocked "async" worker threads
> will quickly use up the worker thread pool and more threads need to be
> created.

Again, this needs to be evaluated and an actual system.  It would have
been the case if devices had taken no time to actually resume, but it
is far from reality AFAICS.

[skip]

> >  }
> >
> >  static void async_resume_early(void *data, async_cookie_t cookie)
> > @@ -875,19 +915,24 @@
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
> >         list_for_each_entry(dev, &dpm_late_early_list, power.entry) {
> >                 dpm_clear_async_state(dev);
>
> I initially thought that there could be a race here, but it's not the
> case because you are using the dpm_list_mtx here. However, since you
> are grabbing the dpm_list_mtx lock before you loop through and kick
> off the async threads for child devices it'll cause a lot of
> unnecessary lock contention/waiting.

I don't think this is what happens here.  It is only processing the
devices without parents which are not too many.

> Which is what this series is trying to avoid in the first place.
>
> If you take device links into consideration (which we need to do for
> this patch series to improve suspend/resume for DT based systems),
> there is an even higher chance of racing (or more lock contention)
> because multiple threads might attempt to resume the same device.
> Which is why in my patch series, I try to use the device links read
> lock than using the single dpm_list_mtx mutex.

I think that you are talking about acquiring dpm_list_mtx in
dpm_async_resume_children().

The reason for acquiring it there is dpm_async_unless_in_progress()
and particularly the power.work_in_progress check in it and the
invocation of dpm_async_fn() which manipulates power.work_in_progress.

If dpm_list_mtx is too contentious for this, the device's power.lock
can be used for protecting the power.work_in_progress accesses in
principle, but that would mean more complexity in the code.

This is unrelated to whether or not device links are walked in
dpm_async_resume_children() (well, if they were, it would need to be
renamed), though.

