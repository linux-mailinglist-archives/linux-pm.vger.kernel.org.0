Return-Path: <linux-pm+bounces-24002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9972A6034C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 22:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B45419C3226
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 21:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA271DE2A6;
	Thu, 13 Mar 2025 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvZBQdWx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C40747F
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900649; cv=none; b=s6sactfZarlJzxhhjjWHLSIYqzlgo9egU5QwfxpZIJj5nNC4av92dFAYPcCdFXZ439DRv3iawjF+lauMAWvdSPBjI6yZi7YURgJ+h2vtD6hMxvOchzfRiHgujB0TnDjNhwPTaiHPgP2rlC3tKdUfivMEXx+44fE0610X34sbMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900649; c=relaxed/simple;
	bh=DXNDuMtmyXbX3v+RPP6wJCnBxqdLrboBKDVRfo/w9ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQkTuatGeRl8NuzOGXTtmr4EC37M93S3COdsRDFNYYprd82iNyQItIqjbtvLSI2Z7mG0JnrsI+WWU45VpOFKQGSNKHLl2swfZFDDF6Uoxo33b4PH/WnFr5548kdF5FMrRUqgWubQJvdEgFAKwKkMC129z8oEfY18IxBwpBP1xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MvZBQdWx; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54954fa61c9so1735801e87.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741900646; x=1742505446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+qO8Ld5TtBeLkg2T5L6Eb6u3WLqIYZMB7VrYVuOAj4=;
        b=MvZBQdWxsoDhDD2Ghvk+zB48banxPuxdxD5e7ieSZzREjD+QIxSvGjzR00uF9mkPVc
         is8IxvrlTU1eLvRfz+K88ytQ2ZXu5XoOxfR+aw7vQGtcJNLwnvrhdfSziJwVGkeX1ZkQ
         XIvzrFd7CPTAUrVfjt4y3pZDYKqR07b/SmpbE1U6M3QQCRkBB5bt2uUfy0usW6dUcFUF
         8Ur2fFlMXqAH7e2dLUFtr7I54eaNxb7FzxKMHlZ2hUGLEwMbXtEKYoSCZZSUJqxLVB7E
         reDWiiBy7nCeLnZ2uN+G4Fd3O8A3CP7hzgQY2CbJ27Zh4aVJNprwBsiP+WKss9wGrR7j
         HD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900646; x=1742505446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+qO8Ld5TtBeLkg2T5L6Eb6u3WLqIYZMB7VrYVuOAj4=;
        b=ZhjHEU9MMtmgCup6Et5SxauQra6PIwQ8QQP7z8ItutyhnwapPk0jq91kBElneOtTem
         RgiOVraXl73W+tuOpAJZooH7OYy18MmpfwS1tcScwhgwT6u3uMr8l3Z1XORnQEl8yHEr
         ECw94oaaI4wSMVOa1Dd3pvBUV3c479gadDPbTyP4NUdXurBMT0xDREhnPkuL8UQ6h2cO
         eIjkzlRXyMQ7sEDOH+CSa24VffQyKYtxXvHH0ClPHG3mjqNKG8NdEV+wyjNMzvvHCBut
         wQqG4a/DjuJu+Uib72bOn8Fg+Ak+v5QZ+g8tLKLA4gxDm7EQY5DOdFVDxO4GiRxC1tAa
         TLkw==
X-Gm-Message-State: AOJu0YxpdC5KtoNeEKwfXHlSoxBMdKfhP/xE2kX1Zwf2d8MupdF7vgce
	prAZcgzMUfPLsF6uWgjHtAxw229G7gJcde1sU7QCDbdRu4cjrXAen4xMP7epky63eyGs6pPL7dr
	/LkDDTUoEPTO2yMS0J5zcUi8rnS6st4sNQg4z
X-Gm-Gg: ASbGncuP05TB8hpfuCtsjiXMPwANrZxOtdneMe6y9l5oGyvL9IF7xdbmYo3OcXqYvPi
	nlGr24vhmc4LISX+DLwcu5lx2EKezv5K1vWHemXHtfSPRiSVZzyaByiBWlmu1Hw8TdYEakZpWDT
	QHdd3dX49LS0gREcQJ3xXyS5ZlswAO3il+mt5BEbQq2WSPZMoG3dq+
X-Google-Smtp-Source: AGHT+IH99uu799BbzDm0ohnWzePnOxYy0aCEGEo+GWtBeiYA94ucPhvuzOveYoISGhRq/2TXr+rGepNf3uSl9/4VgJY=
X-Received: by 2002:a05:6512:2823:b0:545:5a5:b69f with SMTP id
 2adb3069b0e04-549c38f542bmr9227e87.9.1741900645353; Thu, 13 Mar 2025 14:17:25
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1915694.tdWV9SEqCh@rjwysocki.net> <3271724.5fSG56mABF@rjwysocki.net>
In-Reply-To: <3271724.5fSG56mABF@rjwysocki.net>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 13 Mar 2025 14:16:48 -0700
X-Gm-Features: AQ5f1JracqW3_YRpjutqu_pmpCsmOl-Dzw1YlsDD-FAsILh9T31-LXzAZp2qCYQ
Message-ID: <CAGETcx8WwG96FEOyKR-qFA=S6GhpH-EKpVtghNtxt-CQ-3UB_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PM: sleep: Suspend parents and suppliers after
 suspending subordinates
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 1:35=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> In analogy with the previous change affecting the resume path,
> make device_suspend() start the async suspend of the device's parent
> and suppliers after the device itself has been processed and make
> dpm_suspend() start processing "async" leaf devices (that is, devices
> without children or consumers) upfront because they don't need to wait
> for any other devices.
>
> On the Dell XPS13 9360 in my office, this change reduces the total
> duration of device suspend by approximately 100 ms (over 20%).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> ---
>
> v1 -> v2:
>    * Adjust for the changes in patch [1/3].
>    * Fix walking suppliers in dpm_async_suspend_superior().
>    * Use device links read locking in dpm_async_suspend_superior() (Sarav=
ana).
>    * Move all devices to the target list even if there are errors in
>      dpm_suspend() so they are properly resumed during rollback (Saravana=
).
>
> ---
>  drivers/base/power/main.c |   78 +++++++++++++++++++++++++++++++++++++++=
+++----
>  1 file changed, 72 insertions(+), 6 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1231,6 +1231,50 @@
>
>  /*------------------------- Suspend routines -------------------------*/
>
> +static bool dpm_leaf_device(struct device *dev)
> +{
> +       struct device *child;
> +
> +       lockdep_assert_held(&dpm_list_mtx);
> +
> +       child =3D device_find_any_child(dev);
> +       if (child) {
> +               put_device(child);
> +
> +               return false;
> +       }
> +
> +       /*
> +        * Since this function is required to run under dpm_list_mtx, the
> +        * list_empty() below will only return true if the device's list =
of
> +        * consumers is actually empty before calling it.
> +        */
> +       return list_empty(&dev->links.consumers);
> +}

We need the equivalent of this for resume.

> +
> +static void dpm_async_suspend_superior(struct device *dev, async_func_t =
func)
> +{
> +       struct device_link *link;
> +       int idx;
> +
> +       mutex_lock(&dpm_list_mtx);
> +
> +       /* Start processing the device's parent if it is "async". */
> +       if (dev->parent)
> +               dpm_async_with_cleanup(dev->parent, func);
> +
> +       mutex_unlock(&dpm_list_mtx);
> +
> +       idx =3D device_links_read_lock();
> +
> +       /* Start processing the device's "async" suppliers. */
> +       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
> +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> +                       dpm_async_with_cleanup(link->supplier, func);

We should check that the rest of the consumers of the supplier are
"done" before we queue the supplier. With 386 device links (and the
number only increases as we add support for more properties), there's
no doubt that we'll hit this often.

> +
> +       device_links_read_unlock(idx);

Is passing idx to unlock a new (within the past 6 months) thing? I
don't remember having to do this in the past.

> +}
> +
>  /**
>   * resume_event - Return a "resume" message for given "suspend" sleep st=
ate.
>   * @sleep_state: PM message representing a sleep state.
> @@ -1656,6 +1700,8 @@
>         device_links_read_unlock(idx);
>  }
>
> +static void async_suspend(void *data, async_cookie_t cookie);
> +
>  /**
>   * device_suspend - Execute "suspend" callbacks for given device.
>   * @dev: Device to handle.
> @@ -1785,7 +1831,13 @@
>
>         complete_all(&dev->power.completion);
>         TRACE_SUSPEND(error);
> -       return error;
> +
> +       if (error || async_error)
> +               return error;
> +
> +       dpm_async_suspend_superior(dev, async_suspend);
> +
> +       return 0;
>  }
>
>  static void async_suspend(void *data, async_cookie_t cookie)
> @@ -1803,6 +1855,7 @@
>  int dpm_suspend(pm_message_t state)
>  {
>         ktime_t starttime =3D ktime_get();
> +       struct device *dev;
>         int error =3D 0;
>
>         trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
> @@ -1816,12 +1869,28 @@
>
>         mutex_lock(&dpm_list_mtx);
>
> +       /*
> +        * Start processing "async" leaf devices upfront because they don=
't need
> +        * to wait.
> +        */
> +       list_for_each_entry_reverse(dev, &dpm_prepared_list, power.entry)=
 {
> +               dpm_clear_async_state(dev);
> +               if (dpm_leaf_device(dev))
> +                       dpm_async_with_cleanup(dev, async_suspend);
> +       }
> +
>         while (!list_empty(&dpm_prepared_list)) {
> -               struct device *dev =3D to_device(dpm_prepared_list.prev);
> +               dev =3D to_device(dpm_prepared_list.prev);
>
>                 list_move(&dev->power.entry, &dpm_suspended_list);
>
> -               dpm_clear_async_state(dev);
> +               /*
> +                * Move all devices to the target list to resume them pro=
perly
> +                * on errors.
> +                */

I did this initially on my end, but we have so many devices that
looping through them had a measurable impact. It's better to just
splice the lists on error.

-Saravana

> +               if (error || async_error)
> +                       continue;
> +
>                 if (dpm_async_fn(dev, async_suspend))
>                         continue;
>
> @@ -1834,9 +1903,6 @@
>                 put_device(dev);
>
>                 mutex_lock(&dpm_list_mtx);
> -
> -               if (error || async_error)
> -                       break;
>         }
>
>         mutex_unlock(&dpm_list_mtx);
>
>
>

