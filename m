Return-Path: <linux-pm+bounces-23948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABCEA5E983
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 02:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4178E189CE04
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 01:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D35208A9;
	Thu, 13 Mar 2025 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0sxH77Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF254C6C
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741830430; cv=none; b=gTAtrGixHiQl1t6F5E9/rrPyRaqCNpeUe/v4mBFGrQ4jQQz+JM+Nv6nHH/Hcp5HS7L4v/0qCPAPtxuO1MNTyR8QrhIqkboldOHMVQrR4WtRPPROp8q/yYOh65Y8HWGvsAmXEAf7S4ud9pV8LnGrSG04ChoB//DJ7NwcpABnGbmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741830430; c=relaxed/simple;
	bh=eJgweNseQCI2D9GEAWm0wbnjfc9PoRMUEdQhKolkdxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8TZIQPInD1dILZkUIL+b5Xm3HPEZJOhVXbLcuG540gX9A1+Q/Wg6pAoU78+t8QHO//OUR1MeYGtBOcjlJyL+byZ+ao9USjplwhaajcegXaQrp9LAcrX6ivSsqlIXujgfzw3Ch4v1cWNk9dlbT3/KB45q3NydzhwbTQTrOQyS6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S0sxH77Z; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5499da759e8so1739312e87.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 18:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741830426; x=1742435226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BidaDh8d3foyw4r7prRPoY79Prlxtd8J3kdtqZjB7uc=;
        b=S0sxH77Z29Ur12j1DotXQGtFHYaVwsarFPZXHBHDy3F1BaEGs7QMPzwOpCyYiLAhnY
         LBtY5iKLxmoRAhdKAhxq0UKks5P/6X6m9+vWiAYH3BmXditbcQTS90XsEbuDnFuvws7n
         Z+q+FRw/jjg1yc+T+EXZUPSkom8BD2w5eFofTHaWqF/Zj2bKKDuAjviTqMVEMyEQ4XuK
         5Hn4D2vt+Bw/QGNMBR2UYvCepUmgw5StzyPsiAI2y4YQ65U6lDPFijcX/WPPdTp3gC7E
         heZzrsugFoM5+8FSylfRzyVQo2buDT3F0X4hfpTfKu7w7aoYkP0OAhanGqywYmZnFxqT
         Y/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741830426; x=1742435226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BidaDh8d3foyw4r7prRPoY79Prlxtd8J3kdtqZjB7uc=;
        b=ZYq7OBbY+yh8Xpf5vVdRB1tZ+H8ZywibvzqhZgLqmWApW8Dg+gtvWhDSQ5EBxCjSwe
         h4vUN+rPEfF9wr/x8dZ+W00uOphhXEvGjw6RThaJifqoil8h7aK9em6o4fmWOZ6kIxFE
         nz3esfDQvmpv6fjOa4liuQQJRG/ekvZ3qci2/YTQLKDxXAZ0CIQ+MKPPSrp/yXbyRl4i
         HVi/5GRTsUmnESwHPxoTPszCeF/iVowAbsGWx90n5qC9oeOYQwvb0FU9RPyOTvzZdsAo
         D0D+NP9algtJkLufvGJ2fotqMF769pTRu/PVbpzOUHhuJR68JZJjnvNF3micg4J8Kz73
         U9aw==
X-Gm-Message-State: AOJu0Ywb0OVbZz3NoLq6UJazspgo7JKDfNS6mW/HwwhpJWF+exUcbAi4
	FptCeZnlkgM3wI0r/XfbhEI+VPqb5Kqk6b3CNH1vkf8EEUhaYR4EkvIuXypu7gKso/ng5nGhVfi
	bH2xE9I9zJYiZMFBUb7HP+fZtyGzptoUDG8oX
X-Gm-Gg: ASbGncuVQTXRkEUwrkxVlRURIEGZZQyQQE3m3gIy5AsLHMClN2ahbuedeS0C7jpiwiK
	DXz7Mt79XSAGt6blmy8Wl96XWPcOgenrdWapUCSdhfqeMuqLw/kLuJQpOOoav1aZsGDUL5edP3i
	YiuUhbapg1oPj6BhBB7ONgFUYisSF6qjFCn8+8SwgPRHUchBiWBJTH
X-Google-Smtp-Source: AGHT+IGXjcqPog3YLZd3XA456d1/2r7M/uWgjDVDcwwZwKfq7btJjUoFXQkp27tOQqU33e0tZa63RGwWjJfKbaHp+0g=
X-Received: by 2002:a05:6512:3990:b0:549:68a7:177c with SMTP id
 2adb3069b0e04-549ba3d563fmr238704e87.7.1741830425813; Wed, 12 Mar 2025
 18:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net> <1819312.VLH7GnMWUR@rjwysocki.net>
In-Reply-To: <1819312.VLH7GnMWUR@rjwysocki.net>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 12 Mar 2025 18:46:29 -0700
X-Gm-Features: AQ5f1JoxP_uDsyltUX6ryNBbVmg9p4_BA7TrFqAr8M2uTlZczo-atwRYtkMjfxA
Message-ID: <CAGETcx86f+8cGBxMixgoOy2fwgtEO_ysN1q-h9PACxdRjRiFPw@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] PM: sleep: Resume children right after resuming
 the parent
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the delay, I wanted to double, triple, multiple check my
replies to make sure I didn't get it wrong. I hope I didn't.

On Tue, Feb 25, 2025 at 8:46=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> According to [1], the handling of device suspend and resume, and
> particularly the latter, involves unnecessary overhead related to
> starting new async work items for devices that cannot make progress
> right away because they have to wait for other devices.
>
> To reduce this problem in the resume path, use the observation that
> starting the async resume of the children of a device after resuming
> the parent is likely to produce less scheduling and memory management
> noise than starting it upfront while at the same time it should not
> increase the resume duration substantially.
>
> Accordingly, modify the code to start the async resume of the device's
> children when the processing of the parent has been completed in each
> stage of device resume and only start async resume upfront for devices
> without parents.
>
> Also make it check if a given device can be resumed asynchronously
> before starting the synchronous resume of it in case it will have to
> wait for another that is already resuming asynchronously.
>
> In addition to making the async resume of devices more friendly to
> systems with relatively less computing resources, this change is also
> preliminary for analogous changes in the suspend path.
>
> On the systems where it has been tested, this change by itself does
> not affect the overall system resume duration in a measurable way.
>
> Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravanak=
@google.com/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c |   72 +++++++++++++++++++++++++++++++++++++++=
+------
>  1 file changed, 63 insertions(+), 9 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -621,12 +621,41 @@
>         return false;
>  }
>
> +static int dpm_async_unless_in_progress(struct device *dev, void *fn)
> +{
> +       async_func_t func =3D fn;
> +
> +       if (!dev->power.work_in_progress)
> +               dpm_async_fn(dev, func);
> +
> +       return 0;
> +}
> +
> +static void dpm_async_resume_children(struct device *dev, async_func_t f=
unc)
> +{
> +       mutex_lock(&dpm_list_mtx);
> +
> +       /*
> +        * Start processing "async" children of the device unless it's be=
en
> +        * started already for them.
> +        *
> +        * This could have been done for the device's "async" consumers t=
oo, but
> +        * they either need to wait for their parents or the processing h=
as
> +        * already started for them after their parents were processed.
> +        */
> +       device_for_each_child(dev, func, dpm_async_unless_in_progress);

Is there a reason you aren't resuming the consumers? Or checking that
the children won't block on any suppliers?

Not dealing with device links might be ok for systems where there
aren't a lot of device links, but in DT based systems with fw_devlink
this patch will not make much of a difference. There'll still be a ton
of "sleep and try again" issues because of the supplier/consumer
dependencies. And when you include device links, it's a dependency
graph and no longer a dependency tree. So things become a bit more
complicated.

Also, not taking device links isn't consideration when kicking off
async work is not just about additional sleep/wake cycles, but it'll
also cause more thread creation because blocked "async" worker threads
will quickly use up the worker thread pool and more threads need to be
created.

> +
> +       mutex_unlock(&dpm_list_mtx);
> +}
> +
>  static void dpm_clear_async_state(struct device *dev)
>  {
>         reinit_completion(&dev->power.completion);
>         dev->power.work_in_progress =3D false;
>  }
>
> +static void async_resume_noirq(void *data, async_cookie_t cookie);
> +
>  /**
>   * device_resume_noirq - Execute a "noirq resume" callback for given dev=
ice.
>   * @dev: Device to handle.
> @@ -710,6 +739,8 @@
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async noirq" : " noirq",=
 error);
>         }
> +
> +       dpm_async_resume_children(dev, async_resume_noirq);

Similar comment here.

>  }
>
>  static void async_resume_noirq(void *data, async_cookie_t cookie)
> @@ -733,19 +764,24 @@
>         mutex_lock(&dpm_list_mtx);
>
>         /*
> -        * Trigger the resume of "async" devices upfront so they don't ha=
ve to
> -        * wait for the "non-async" ones they don't depend on.
> +        * Start processing "async" devices without parents upfront so th=
ey
> +        * don't wait for the "sync" devices they don't depend on.
>          */
>         list_for_each_entry(dev, &dpm_noirq_list, power.entry) {
>                 dpm_clear_async_state(dev);
> -               dpm_async_fn(dev, async_resume_noirq);
> +               if (!dev->parent)
> +                       dpm_async_fn(dev, async_resume_noirq);
>         }
>
>         while (!list_empty(&dpm_noirq_list)) {
>                 dev =3D to_device(dpm_noirq_list.next);
>                 list_move_tail(&dev->power.entry, &dpm_late_early_list);
>
> +               dpm_async_unless_in_progress(dev, async_resume_noirq);
> +
>                 if (!dev->power.work_in_progress) {
> +                       dev->power.work_in_progress =3D true;
> +
>                         get_device(dev);
>
>                         mutex_unlock(&dpm_list_mtx);
> @@ -781,6 +817,8 @@
>         device_wakeup_disarm_wake_irqs();
>  }
>
> +static void async_resume_early(void *data, async_cookie_t cookie);
> +
>  /**
>   * device_resume_early - Execute an "early resume" callback for given de=
vice.
>   * @dev: Device to handle.
> @@ -848,6 +886,8 @@
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async early" : " early",=
 error);
>         }
> +
> +       dpm_async_resume_children(dev, async_resume_early);

Similar comment here.

>  }
>
>  static void async_resume_early(void *data, async_cookie_t cookie)
> @@ -875,19 +915,24 @@
>         mutex_lock(&dpm_list_mtx);
>
>         /*
> -        * Trigger the resume of "async" devices upfront so they don't ha=
ve to
> -        * wait for the "non-async" ones they don't depend on.
> +        * Start processing "async" devices without parents upfront so th=
ey
> +        * don't wait for the "sync" devices they don't depend on.
>          */
>         list_for_each_entry(dev, &dpm_late_early_list, power.entry) {
>                 dpm_clear_async_state(dev);

I initially thought that there could be a race here, but it's not the
case because you are using the dpm_list_mtx here. However, since you
are grabbing the dpm_list_mtx lock before you loop through and kick
off the async threads for child devices it'll cause a lot of
unnecessary lock contention/waiting. Which is what this series is
trying to avoid in the first place.

If you take device links into consideration (which we need to do for
this patch series to improve suspend/resume for DT based systems),
there is an even higher chance of racing (or more lock contention)
because multiple threads might attempt to resume the same device.
Which is why in my patch series, I try to use the device links read
lock than using the single dpm_list_mtx mutex.

Thanks,
Saravana

> -               dpm_async_fn(dev, async_resume_early);
> +               if (!dev->parent)
> +                       dpm_async_fn(dev, async_resume_early);
>         }
>
>         while (!list_empty(&dpm_late_early_list)) {
>                 dev =3D to_device(dpm_late_early_list.next);
>                 list_move_tail(&dev->power.entry, &dpm_suspended_list);
>
> +               dpm_async_unless_in_progress(dev, async_resume_early);
> +
>                 if (!dev->power.work_in_progress) {
> +                       dev->power.work_in_progress =3D true;
> +
>                         get_device(dev);
>
>                         mutex_unlock(&dpm_list_mtx);
> @@ -919,6 +964,8 @@
>  }
>  EXPORT_SYMBOL_GPL(dpm_resume_start);
>
> +static void async_resume(void *data, async_cookie_t cookie);
> +
>  /**
>   * device_resume - Execute "resume" callbacks for given device.
>   * @dev: Device to handle.
> @@ -1012,6 +1059,8 @@
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async" : "", error);
>         }
> +
> +       dpm_async_resume_children(dev, async_resume);
>  }
>
>  static void async_resume(void *data, async_cookie_t cookie)
> @@ -1043,19 +1092,24 @@
>         mutex_lock(&dpm_list_mtx);
>
>         /*
> -        * Trigger the resume of "async" devices upfront so they don't ha=
ve to
> -        * wait for the "non-async" ones they don't depend on.
> +        * Start processing "async" devices without parents upfront so th=
ey
> +        * don't wait for the "sync" devices they don't depend on.
>          */
>         list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
>                 dpm_clear_async_state(dev);
> -               dpm_async_fn(dev, async_resume);
> +               if (!dev->parent)
> +                       dpm_async_fn(dev, async_resume);
>         }
>
>         while (!list_empty(&dpm_suspended_list)) {
>                 dev =3D to_device(dpm_suspended_list.next);
>                 list_move_tail(&dev->power.entry, &dpm_prepared_list);
>
> +               dpm_async_unless_in_progress(dev, async_resume);
> +
>                 if (!dev->power.work_in_progress) {
> +                       dev->power.work_in_progress =3D true;
> +
>                         get_device(dev);
>
>                         mutex_unlock(&dpm_list_mtx);
>
>
>

