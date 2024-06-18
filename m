Return-Path: <linux-pm+bounces-9491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDA790DAA0
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 19:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368311C22B4F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0E013DDD2;
	Tue, 18 Jun 2024 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StCHpqHr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358D13BC35;
	Tue, 18 Jun 2024 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731651; cv=none; b=egGgGxJ1CiZDYbjiHYNqtgLDY/A7aD0Oi5z7BdUHi8yvozyAwqNKE62VIhSdJ3fQs1Fubsp9QVmPW04ZqpuLYtMHmiKyn7trERAf6NlFcg0k2HBPNmBaviAXhxOSkoKnaR8uVwHgFQjk2ly+nXbnmE8lGkZYqoZ8uzXw/two5dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731651; c=relaxed/simple;
	bh=PvggezZOx8I51XpTY2I6XHhoeCKDN4i12/4cdMboB88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSW1rQKA+F/ZJjvyJcPKjmFmRhTwGfWaID+F9lwXv/i1f9BwbxjAmEO2AqivJm9uaGc/c6BF9z43Bg3sB90MGmus2pAgtoTrw9ioDbQn69maVwni4CRUHAq+LPcDzIv7efGuvVwzue2MjY9W+OousiHZ0OgV3mhNqknzASh412Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StCHpqHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB16C4AF1A;
	Tue, 18 Jun 2024 17:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718731651;
	bh=PvggezZOx8I51XpTY2I6XHhoeCKDN4i12/4cdMboB88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=StCHpqHrbsQeGkKqhu7koH1e+0bMPjBULzVsTayfSoeeEUu2A9Lr1KFDGfngMN9HS
	 Bj7Hf7Y4eHm0o55YI4WzwqTeCvlOVypF9hoZ7SqCbZwhFPT7fhhC5sTZA+w5HhN0Lr
	 rg3IVewVpYDM2b2YpxRWBP7B24qlZ/rfTVzGYwgtFnBCJLlvQ/wAgIOnIB9Vz6jx4K
	 03ai5Q1fSXuZNtwTABe7GwDNScuOnxx/+lLMVX0sUm289P8XF7nksBp5mSbC7Qs/Ve
	 MmLEmGLY3UfLk6TG0xGHXskIlYDvyzZJpN4sq7/9G0TkGjyyg7Ng7lp+8F9KSlGeNA
	 0+Z50Fin1x1vQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-250495bcd4fso346624fac.1;
        Tue, 18 Jun 2024 10:27:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcOFhu+uAd2H5SSWhU5nG9O8jBY3Ov7JbevcqrKaQKF+EEr+sEPviEEpJFVx4apkXOx+OazcoRRVG8vSn18mn/jyguCkyhPi7xCvh9QxyGKNT1KnRR6j0ItKfIRHr6RE5mJVDxV9w=
X-Gm-Message-State: AOJu0YwPisa8MM233iI+kvRMR/5ongFACEFxq8fxg7Q7UPiAZ1zX61Bb
	pwNT3iehC+dodu/9Hu0MolTmeh2oJwRth/yp4PM48wYLbNlWF2Zkt034qyTWXxQvR2niPeYwAP4
	idGAMQ8x8tg+GDTL6aPN2pPv06PU=
X-Google-Smtp-Source: AGHT+IGMDorx3YEJm/c+8y/HsAeafHKDCKId4YqOv7yTMYPvkZemm1RudKf3mbjqyuWAPpK4cU5bYBEppyGxi0/v81c=
X-Received: by 2002:a05:6870:82ac:b0:259:4012:6c94 with SMTP id
 586e51a60fabf-25c949cd773mr518804fac.2.1718731650067; Tue, 18 Jun 2024
 10:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618121327.2177-1-kaiyen.chang@intel.com> <20240618121327.2177-2-kaiyen.chang@intel.com>
In-Reply-To: <20240618121327.2177-2-kaiyen.chang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Jun 2024 19:27:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gK=v0P7Fapn=5-YdZ9_NTGL0PfA__ogmP_3Hx0=5qAEg@mail.gmail.com>
Message-ID: <CAJZ5v0gK=v0P7Fapn=5-YdZ9_NTGL0PfA__ogmP_3Hx0=5qAEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PM: Start asynchronous suspend threads upfront
To: Kaiyen Chang <kaiyen.chang@intel.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 2:13=E2=80=AFPM Kaiyen Chang <kaiyen.chang@intel.co=
m> wrote:
>
> Currently, when performing a suspend operation, all devices on the
> dpm_list must wait for the "synchronous" devices that are listed
> after them to complete before the main suspend thread can start
> their suspend routines, even if they are "asynchronous". If the
> suspend routine of a synchronous device must enter a waiting state
> for some reason, it will cause the main suspend thread to go to
> sleep, thereby delaying the processing of all subsequent devices,
> including asynchronous ones, ultimately extending the overall
> suspend time.
>
> By starting the asynchronous suspend threads upfront, we can allow
> the system to handle the suspend routines of these asynchronous
> devices in parallel, without waiting for the suspend routines of
> the synchronous devices listed after them to complete, and without
> breaking their order with respect to their parents and children.
> This way, even if the main suspend thread is blocked, these
> asynchronous suspend threads can continue to run without being
> affected.
>
> Signed-off-by: Kaiyen Chang <kaiyen.chang@intel.com>

How exactly has this been tested?

In the past, changes going in this direction caused system suspend to
hang on at least some platforms (including the ones in my office).

> ---
> Change from v1: Fix some unclear parts in the commit messages.
> ---
>  drivers/base/power/main.c | 90 +++++++++++++++++++++++++--------------
>  1 file changed, 57 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 4a67e83300e1..6ddd6ef36625 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1283,6 +1283,7 @@ static void async_suspend_noirq(void *data, async_c=
ookie_t cookie)
>
>  static int dpm_noirq_suspend_devices(pm_message_t state)
>  {
> +       struct device *dev;
>         ktime_t starttime =3D ktime_get();
>         int error =3D 0;
>
> @@ -1293,26 +1294,33 @@ static int dpm_noirq_suspend_devices(pm_message_t=
 state)
>
>         mutex_lock(&dpm_list_mtx);
>
> +       /*
> +        * Trigger the suspend of "async" devices upfront so they don't h=
ave to
> +        * wait for the "non-async" ones that don't depend on them.
> +        */
> +
> +       list_for_each_entry_reverse(dev, &dpm_late_early_list, power.entr=
y)
> +               dpm_async_fn(dev, async_suspend_noirq);
> +
>         while (!list_empty(&dpm_late_early_list)) {
> -               struct device *dev =3D to_device(dpm_late_early_list.prev=
);
> +               dev =3D to_device(dpm_late_early_list.prev);
>
>                 list_move(&dev->power.entry, &dpm_noirq_list);
>
> -               if (dpm_async_fn(dev, async_suspend_noirq))
> -                       continue;
> -
> -               get_device(dev);
> +               if (!dev->power.async_in_progress) {
> +                       get_device(dev);
>
> -               mutex_unlock(&dpm_list_mtx);
> +                       mutex_unlock(&dpm_list_mtx);
>
> -               error =3D device_suspend_noirq(dev, state, false);
> +                       error =3D device_suspend_noirq(dev, state, false)=
;
>
> -               put_device(dev);
> +                       put_device(dev);
>
> -               mutex_lock(&dpm_list_mtx);
> +                       mutex_lock(&dpm_list_mtx);
>
> -               if (error || async_error)
> -                       break;
> +                       if (error || async_error)
> +                               break;
> +               }
>         }
>
>         mutex_unlock(&dpm_list_mtx);
> @@ -1454,6 +1462,7 @@ static void async_suspend_late(void *data, async_co=
okie_t cookie)
>   */
>  int dpm_suspend_late(pm_message_t state)
>  {
> +       struct device *dev;
>         ktime_t starttime =3D ktime_get();
>         int error =3D 0;
>
> @@ -1466,26 +1475,33 @@ int dpm_suspend_late(pm_message_t state)
>
>         mutex_lock(&dpm_list_mtx);
>
> +       /*
> +        * Trigger the suspend of "async" devices upfront so they don't h=
ave to
> +        * wait for the "non-async" ones that don't depend on them.
> +        */
> +
> +       list_for_each_entry_reverse(dev, &dpm_suspended_list, power.entry=
)
> +               dpm_async_fn(dev, async_suspend_late);
> +
>         while (!list_empty(&dpm_suspended_list)) {
> -               struct device *dev =3D to_device(dpm_suspended_list.prev)=
;
> +               dev =3D to_device(dpm_suspended_list.prev);
>
>                 list_move(&dev->power.entry, &dpm_late_early_list);
>
> -               if (dpm_async_fn(dev, async_suspend_late))
> -                       continue;
> -
> -               get_device(dev);
> +               if (!dev->power.async_in_progress) {
> +                       get_device(dev);
>
> -               mutex_unlock(&dpm_list_mtx);
> +                       mutex_unlock(&dpm_list_mtx);
>
> -               error =3D device_suspend_late(dev, state, false);
> +                       error =3D device_suspend_late(dev, state, false);
>
> -               put_device(dev);
> +                       put_device(dev);
>
> -               mutex_lock(&dpm_list_mtx);
> +                       mutex_lock(&dpm_list_mtx);
>
> -               if (error || async_error)
> -                       break;
> +                       if (error || async_error)
> +                               break;
> +               }
>         }
>
>         mutex_unlock(&dpm_list_mtx);
> @@ -1719,6 +1735,7 @@ static void async_suspend(void *data, async_cookie_=
t cookie)
>   */
>  int dpm_suspend(pm_message_t state)
>  {
> +       struct device *dev;
>         ktime_t starttime =3D ktime_get();
>         int error =3D 0;
>
> @@ -1733,26 +1750,33 @@ int dpm_suspend(pm_message_t state)
>
>         mutex_lock(&dpm_list_mtx);
>
> +       /*
> +        * Trigger the suspend of "async" devices upfront so they don't h=
ave to
> +        * wait for the "non-async" ones that don't depend on them.
> +        */
> +
> +       list_for_each_entry_reverse(dev, &dpm_prepared_list, power.entry)
> +               dpm_async_fn(dev, async_suspend);
> +
>         while (!list_empty(&dpm_prepared_list)) {
> -               struct device *dev =3D to_device(dpm_prepared_list.prev);
> +               dev =3D to_device(dpm_prepared_list.prev);
>
>                 list_move(&dev->power.entry, &dpm_suspended_list);
>
> -               if (dpm_async_fn(dev, async_suspend))
> -                       continue;
> -
> -               get_device(dev);
> +               if (!dev->power.async_in_progress) {
> +                       get_device(dev);
>
> -               mutex_unlock(&dpm_list_mtx);
> +                       mutex_unlock(&dpm_list_mtx);
>
> -               error =3D device_suspend(dev, state, false);
> +                       error =3D device_suspend(dev, state, false);
>
> -               put_device(dev);
> +                       put_device(dev);
>
> -               mutex_lock(&dpm_list_mtx);
> +                       mutex_lock(&dpm_list_mtx);
>
> -               if (error || async_error)
> -                       break;
> +                       if (error || async_error)
> +                               break;
> +               }
>         }
>
>         mutex_unlock(&dpm_list_mtx);
> --
> 2.34.1
>

