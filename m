Return-Path: <linux-pm+bounces-23950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29CAA5E989
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 02:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22FEF17AFC6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 01:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744ED2AD31;
	Thu, 13 Mar 2025 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zf9ysgEs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFC9208A9
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741830474; cv=none; b=cK1Hd5rvgh6AtmKNK9ieMLLFZnNxPjefXfUcTdsvp3BswCG1JU72R0mtwDlhXoeVW0jWRthihWo6m/tydCVXmMQ07UQeaYgbzZn1MjAyBipCqW1IwZ8Z5g9Ax03vpXnPYYZ/c05gJqcTNuj15LSYobQZ59hJLM3dSJZb7LkxwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741830474; c=relaxed/simple;
	bh=JXYJpN1bl6l6EhN1PqsffQzL+dYYLgRDi7LBkvLgIuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cY/o8z4oCoiITBI8tEhG61e8lFqVJiZeiAzIZxHRqDg4y1ebg3QVKCwCvdj9oCMwxs/AoaylmsJ927xM35Ewv7oDQiFNNGbpfla5N0yWbb2F30AUXwVGY0Sll/2+ahAgHjiuxkMSIN65ZAr6sO1nt2R2DxqsgFkTHO+wKbbW73k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zf9ysgEs; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54996d30bfbso373472e87.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 18:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741830470; x=1742435270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3/spb3qXJ4NahJTapd88icwEqd3UeK2ahBi2LPP2yU=;
        b=zf9ysgEs/52Yi9Nzvh8pzTWhwhak3g4B5O97Ay/rDjv7AkKk6Ts3ZTAFyFTR2+M3aH
         8T8hSIyRAb/zt5vDGjatWlTORK/FvpX7Xi5dh4VrbcWyQAekjnRi1d1g7KU28Yw5x8tK
         kmCVMDsILzsVXE1UiBLWyUOWspZY7pRRTVTJkmiV2btAM2Cw3gjUAe6jAELevo81PeSk
         f8YjhB3U7d2HKtzR80a6zND7TAH/KigZbb59aqRK/3+GXfwiB3O9Fdw6X461WvJKyf+9
         IOeuaVfVxbXVD4EPFwhtuzi9H+5SzBt8Cn6GM9ReM5TE1ZdOOVieHw2ryqVXoG8btaMW
         Jbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741830470; x=1742435270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3/spb3qXJ4NahJTapd88icwEqd3UeK2ahBi2LPP2yU=;
        b=BRSdnUmHt+LNJb8vajdkDlz8NWrQKVHaMar1Xns99ySHURWcmsnp4IToC+v8NZRQXp
         agnS5tAtoIlOkXf+vUvpuk+tT5jIt/2LYxIeWBWhvzlFtH1OWGVV3dKg4EX/vT6QS7hS
         fmESib8VMwVJiDxZRrFdxFoQ5qypGJYlnNKmfMsC/kMnvfhTJOLqXxQ60KD3M3yCT3tA
         5UXX2hI0hiuumeNPT9Q8DjTs/dbKi5/LrN2OVqJtt8mJpD+tzJa/51vNfCSylXsIC5jK
         N8UC62cEbMTXnq1ILqXm1RoqBG9/RZK4gNsVZm5JMLj6cBp9TZXaXvpuYlvJDl7liOAX
         aTbg==
X-Gm-Message-State: AOJu0YxqO8RNjB4ZeaJRd4RLHdVlqE8TQaCxaxi4pKp0gZhrUT/2LnVW
	YRJEcc0+BvGB/Ig0rm67DG7I2x87jgHeCt+Il8VS1k6Kj3JvfuR7YHOGxzCi1zK38euJxg4nOdC
	MtwneDZTYyuEMvz4ATu98x1sjvBl04citiLKj
X-Gm-Gg: ASbGncuNaqutHmMUtksOdBChRaPY3JXkA2puEBEjNj8r6Usc2uIHmMCU21yS/CqQh8L
	YtJtamv/9/ymNbwI2gBgtvL3ziZMAiuvSWoSYtQQy+JNQhSKVCGh8Y5XdhoNh5irVRQjQmutwai
	h/UWjzJeNByQTpy3wsNWAjWFnoEJqNDZJUW6hADQT0YBY7aMH2XCix
X-Google-Smtp-Source: AGHT+IGfrE0FD7ElHYVtgn+Jzz49Ecmh8odTcnd44SieAVCNHGDKoeXuaEzeSrks1fs1ZI7cRhKIFOEKI4pgrNixsHQ=
X-Received: by 2002:a05:6512:ad1:b0:549:8c86:190b with SMTP id
 2adb3069b0e04-54990ec17f7mr10167266e87.39.1741830470334; Wed, 12 Mar 2025
 18:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net> <2016539.usQuhbGJ8B@rjwysocki.net>
In-Reply-To: <2016539.usQuhbGJ8B@rjwysocki.net>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 12 Mar 2025 18:47:13 -0700
X-Gm-Features: AQ5f1Jq875T67hHOe71r_YySZQpkiSdeWx-nk7GkjWbyFBLj9VIYwLJrN7RkuuI
Message-ID: <CAGETcx8WOezY5-MePZ8X8f7_deys1eB-VvQLQwUPtd5MO8ApSA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] PM: sleep: Make late and noirq suspend of devices
 more asynchronous
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:46=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> In analogy with previous changes, make device_suspend_late() and
> device_suspend_noirq() start the async suspend of the device's parent
> and suppliers after the device itself has been processed and make
> dpm_suspend_late() and dpm_noirq_suspend_devices() start processing
> "async" leaf devices (that is, devices without children or consumers)
> upfront because they don't need to wait for any other devices.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c |   60 +++++++++++++++++++++++++++++++++++++++=
-------
>  1 file changed, 52 insertions(+), 8 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1317,6 +1317,8 @@
>         device_links_read_unlock(idx);
>  }
>
> +static void async_suspend_noirq(void *data, async_cookie_t cookie);
> +
>  /**
>   * device_suspend_noirq - Execute a "noirq suspend" callback for given d=
evice.
>   * @dev: Device to handle.
> @@ -1396,7 +1398,13 @@
>  Complete:
>         complete_all(&dev->power.completion);
>         TRACE_SUSPEND(error);
> -       return error;
> +
> +       if (error || async_error)
> +               return error;
> +
> +       dpm_async_suspend_superior(dev, async_suspend_noirq);
> +
> +       return 0;
>  }
>
>  static void async_suspend_noirq(void *data, async_cookie_t cookie)
> @@ -1410,6 +1418,7 @@
>  static int dpm_noirq_suspend_devices(pm_message_t state)
>  {
>         ktime_t starttime =3D ktime_get();
> +       struct device *dev;
>         int error =3D 0;
>
>         trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true)=
;
> @@ -1419,15 +1428,28 @@
>
>         mutex_lock(&dpm_list_mtx);
>
> +       /*
> +        * Start processing "async" leaf devices upfront because they don=
't need
> +        * to wait.
> +        */
> +       list_for_each_entry_reverse(dev, &dpm_late_early_list, power.entr=
y) {
> +               dpm_clear_async_state(dev);
> +               if (dpm_leaf_device(dev))
> +                       dpm_async_fn(dev, async_suspend_noirq);
> +       }
> +
>         while (!list_empty(&dpm_late_early_list)) {
> -               struct device *dev =3D to_device(dpm_late_early_list.prev=
);
> +               dev =3D to_device(dpm_late_early_list.prev);
>
>                 list_move(&dev->power.entry, &dpm_noirq_list);

This issue is present in the previous patch too, but it's easier for
me to point it out here. Suspend abort will break now.

For example, say the devices are suspended in the order A -> B -> C ->
D -> E if everything was sync.

Case 1: Fully sync devices
If C aborts, only A and B will be in the dpm_noirq_list. When we try
to undo the suspend, we just resume devices in dpm_noirq_list and that
just resumes A and B.

Case 2: Only C is sync.
When C aborts, A, B, D and E could have finished suspending. But only
A and B will be in the dpm_noirq_list. When we try to undo the
suspend, we just resume devices in dpm_noirq_list and that just
resumes A and B. D and E never get resumed.

My fix for this is to move all devices to dpm_noirq_list if a suspend
aborts and then using the existing
is_suspended/is_noirq_suspended/is_late_suspended flags to skip over
devices that haven't been suspended. That works nicely except in
is_suspended and I tried to fix it in [2]. But you had an issue with
[2] that I didn't fully understand and I meant to dig deeper and fix.
But I didn't get around to it as I got swamped with other work.

[2] - https://lore.kernel.org/linux-pm/20241114220921.2529905-2-saravanak@g=
oogle.com/

Thanks,
Saravana



>
> -               dpm_clear_async_state(dev);
> -               if (dpm_async_fn(dev, async_suspend_noirq))
> +               dpm_async_unless_in_progress(dev, async_suspend_noirq);
> +
> +               if (dev->power.work_in_progress)
>                         continue;
>
> +               dev->power.work_in_progress =3D true;
> +
>                 get_device(dev);
>
>                 mutex_unlock(&dpm_list_mtx);
> @@ -1492,6 +1514,8 @@
>         spin_unlock_irq(&parent->power.lock);
>  }
>
> +static void async_suspend_late(void *data, async_cookie_t cookie);
> +
>  /**
>   * device_suspend_late - Execute a "late suspend" callback for given dev=
ice.
>   * @dev: Device to handle.
> @@ -1568,7 +1592,13 @@
>  Complete:
>         TRACE_SUSPEND(error);
>         complete_all(&dev->power.completion);
> -       return error;
> +
> +       if (error || async_error)
> +               return error;
> +
> +       dpm_async_suspend_superior(dev, async_suspend_late);
> +
> +       return 0;
>  }
>
>  static void async_suspend_late(void *data, async_cookie_t cookie)
> @@ -1586,6 +1616,7 @@
>  int dpm_suspend_late(pm_message_t state)
>  {
>         ktime_t starttime =3D ktime_get();
> +       struct device *dev;
>         int error =3D 0;
>
>         trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
> @@ -1597,15 +1628,28 @@
>
>         mutex_lock(&dpm_list_mtx);
>
> +       /*
> +        * Start processing "async" leaf devices upfront because they don=
't need
> +        * to wait.
> +        */
> +       list_for_each_entry_reverse(dev, &dpm_suspended_list, power.entry=
) {
> +               dpm_clear_async_state(dev);
> +               if (dpm_leaf_device(dev))
> +                       dpm_async_fn(dev, async_suspend_late);
> +       }
> +
>         while (!list_empty(&dpm_suspended_list)) {
> -               struct device *dev =3D to_device(dpm_suspended_list.prev)=
;
> +               dev =3D to_device(dpm_suspended_list.prev);
>
>                 list_move(&dev->power.entry, &dpm_late_early_list);
>
> -               dpm_clear_async_state(dev);
> -               if (dpm_async_fn(dev, async_suspend_late))
> +               dpm_async_unless_in_progress(dev, async_suspend_late);
> +
> +               if (dev->power.work_in_progress)
>                         continue;
>
> +               dev->power.work_in_progress =3D true;
> +
>                 get_device(dev);
>
>                 mutex_unlock(&dpm_list_mtx);
>
>
>

