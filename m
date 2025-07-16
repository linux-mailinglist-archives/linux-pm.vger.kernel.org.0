Return-Path: <linux-pm+bounces-30956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 136F2B07FFE
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 23:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8FA14E08C7
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 21:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455E72ED869;
	Wed, 16 Jul 2025 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjvcdJOC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD502ECD11
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752702723; cv=none; b=oI1NmEA/QARScfhHSzt0NT13lXUdnAs48GmdGsc/gnTUp436vSANXFBCfFwVpr2ATAVUJNg3+3hdaP+wh4JTKhNL2saOEAMDs+APzGBnwPfwPpQAG/2ZR6CEfrOtbhTIdUo8OTKL0saloxw6dLK6MAVmmqDoON+HU+X+QqFqIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752702723; c=relaxed/simple;
	bh=Ch2tlYK+lFkiqXgNSqOKPn2MlZ4gJgr8uMm/TnLT6Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEh1iOHbK6J1RUmfQymjzqF8dV4iEISYP5yCZghvrTpw6m/nUc3HRKHFDauCnI/VuoQKoWar4orENKVoQF4Vyt0r1zMFwY0VGuB+3/grouYtgijWl4tSvjoeK+ftLk4mwvDGXbcCaVH45InF0P/dYZK8xmbsSFBX9Wihjb5eRX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjvcdJOC; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-87f0efa51c0so190999241.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 14:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752702719; x=1753307519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uXPQk6hRmhbSF8V14DLc/yhNRvrgo1G1fT5+KjBk5c=;
        b=BjvcdJOCjBwqreSvPEGcaNvXgnY8k5LwU13e5RGr0uOhUwJGPowVoboQemfTIqwfVK
         KsKUvWuh81SDQsZG1gTWKfO1j9f5Z3E0q6kg+qUQuN77gqiPG6eD4yIJdw1TRE5YDOPg
         Sp2reTZ0HUYJJo0/xeuVS5IJHrM8skPtfmDrm/8J+W5YWNdr2q+p+aWNWLcUybW7mNEn
         BIlLYACtjQscJHLqdc9z7r6dG8l9//HOZf8vnlsp56BKp1Qr/vDcSUfwTdewITgcoA5P
         aDYlrQqw53NSUZ23zHov3l6FUVzdoI5wTUbEJ2Nleg8CNc+WajA0RX8yu0csiesVJyi9
         WdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752702719; x=1753307519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uXPQk6hRmhbSF8V14DLc/yhNRvrgo1G1fT5+KjBk5c=;
        b=VhfprtTaLbfqti4Cc1U4qgHe3fPcuNXpEqDFtyOJRHvJ/isT6pe7XW1GNOUUDVHEPF
         GHZbScQRhc8TgWTyMf3Hsfg2RO0oxDGZ3fbJOAOLq42dJFLF4/0c4gmeLLmZcbjemok2
         qnyFPKcGZxYTzZe7d1ICJZfmy6kVIoJvpb8pDNIVtTNuvKFTSj0mjS42hEa4MCdX+E65
         xB6JTHtMyD2/rwPmS40oSdkwABXgs3tNfsjUA+UKGOddJfBXEIygWzjm1pi5dkhrolKL
         GjPUxAdQqOg9zmREz9vV8fpkN9b8l6R+IgBD+EMPLDi8O03AThSwXYDJfHrW3seYS+kg
         bfzw==
X-Gm-Message-State: AOJu0YxG31IbZnQXMuuAc8UpC7UQlYJRmvJ65TsjCF4I7r9zYGmuxdAy
	AdsNzBRXOKrd2Q55ZKZYj2AaPslxUB4V50ScbYecHB4dHVBrU/JzZqwKbZ28WBUrivxcNwk0e+A
	FmDNzj8dr6q007SElbf+GdieLT1tm3os+SuthRpGvA/K7DQH90r4kBo1J
X-Gm-Gg: ASbGncuN0drdOno/D8jxIDJNx7EgGeB2MDZtkg2zHaSSaadPoXCzq8Gc+EWM9yMULTh
	N6D9i7zGzu3U0Vsgq2h1LaMIZmd5Jo06ck7s0rZmgFF39pUbA8J8m+jAEK+XqDXSIvT+HvBYTAh
	QosgZMpPzot8loXvPq6FSCCLsk+oR9QoYYRiP43m6CnF5uq8Ul+/lTrQxUIhTnfa50I1L6VkhNP
	9l5oIqSP0IHGoYuPZzWjAtFjJmVOOg/FBQwlg==
X-Google-Smtp-Source: AGHT+IGQWwBEzsHdrraNzyCDa0q42Pd5XLN5TuBKkjyYAtZa4roG3jaLawrftuxYZzBsy4p9g1N6LTwy4QoFO9mmN6U=
X-Received: by 2002:a05:6102:cc8:b0:4f3:36bc:554e with SMTP id
 ada2fe7eead31-4f890239799mr2960352137.16.1752702718422; Wed, 16 Jul 2025
 14:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6198088.lOV4Wx5bFT@rjwysocki.net>
In-Reply-To: <6198088.lOV4Wx5bFT@rjwysocki.net>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 16 Jul 2025 14:51:21 -0700
X-Gm-Features: Ac12FXxMul7_ze1EjafvCq-YvJEn1jMq6HOKboTbOX10FBO1bERgm-lOY4avJSg
Message-ID: <CAGETcx-ddJMua5_VMNofr2vZ9n5Oyo4iT6Bac825L8tFqqQsxg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Rearrange suspend/resume error handling in
 the core
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 12:31=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Notice that device_suspend_noirq(), device_suspend_late() and
> device_suspend() all set async_error on errors, so they don't really
> need to return a value.  Accordingly, make them all void and use
> async_error in their callers instead of their return values.
>
> Moreover, since async_error is updated concurrently without locking
> during asynchronous suspend and resume processing, use READ_ONCE() and
> WRITE_ONCE() for accessing it in those places to ensure that all of the
> accesses will be carried out as expected.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Based on the current linux-pm.git material in linux-next.
>
> ---
>  drivers/base/power/main.c |   79 ++++++++++++++++++++-------------------=
-------
>  1 file changed, 35 insertions(+), 44 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -767,7 +767,7 @@
>         TRACE_RESUME(error);
>
>         if (error) {
> -               async_error =3D error;
> +               WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async noirq" : " noirq",=
 error);
>         }
> @@ -824,7 +824,7 @@
>         mutex_unlock(&dpm_list_mtx);
>         async_synchronize_full();
>         dpm_show_time(starttime, state, 0, "noirq");
> -       if (async_error)
> +       if (READ_ONCE(async_error))
>                 dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
>
>         trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false)=
;
> @@ -910,7 +910,7 @@
>         complete_all(&dev->power.completion);
>
>         if (error) {
> -               async_error =3D error;
> +               WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async early" : " early",=
 error);
>         }
> @@ -971,7 +971,7 @@
>         mutex_unlock(&dpm_list_mtx);
>         async_synchronize_full();
>         dpm_show_time(starttime, state, 0, "early");
> -       if (async_error)
> +       if (READ_ONCE(async_error))
>                 dpm_save_failed_step(SUSPEND_RESUME_EARLY);
>
>         trace_suspend_resume(TPS("dpm_resume_early"), state.event, false)=
;
> @@ -1086,7 +1086,7 @@
>         TRACE_RESUME(error);
>
>         if (error) {
> -               async_error =3D error;
> +               WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async" : "", error);
>         }
> @@ -1150,7 +1150,7 @@
>         mutex_unlock(&dpm_list_mtx);
>         async_synchronize_full();
>         dpm_show_time(starttime, state, 0, NULL);
> -       if (async_error)
> +       if (READ_ONCE(async_error))
>                 dpm_save_failed_step(SUSPEND_RESUME);
>
>         cpufreq_resume();
> @@ -1387,7 +1387,7 @@
>   * The driver of @dev will not receive interrupts while this function is=
 being
>   * executed.
>   */
> -static int device_suspend_noirq(struct device *dev, pm_message_t state, =
bool async)
> +static void device_suspend_noirq(struct device *dev, pm_message_t state,=
 bool async)
>  {
>         pm_callback_t callback =3D NULL;
>         const char *info =3D NULL;
> @@ -1398,7 +1398,7 @@
>
>         dpm_wait_for_subordinate(dev, async);
>
> -       if (async_error)
> +       if (READ_ONCE(async_error))
>                 goto Complete;
>
>         if (dev->power.syscore || dev->power.direct_complete)
> @@ -1431,7 +1431,7 @@
>  Run:
>         error =3D dpm_run_callback(callback, dev, state, info);
>         if (error) {
> -               async_error =3D error;
> +               WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async noirq" : " noirq",=
 error);
>                 goto Complete;
> @@ -1457,12 +1457,10 @@
>         complete_all(&dev->power.completion);
>         TRACE_SUSPEND(error);
>
> -       if (error || async_error)
> -               return error;
> +       if (error || READ_ONCE(async_error))
> +               return;
>
>         dpm_async_suspend_superior(dev, async_suspend_noirq);
> -
> -       return 0;
>  }
>
>  static void async_suspend_noirq(void *data, async_cookie_t cookie)
> @@ -1477,7 +1475,7 @@
>  {
>         ktime_t starttime =3D ktime_get();
>         struct device *dev;
> -       int error =3D 0;
> +       int error;

Are we still keeping around the error variable ... (question continues
further down)
>
>         trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true)=
;
>
> @@ -1508,13 +1506,13 @@
>
>                 mutex_unlock(&dpm_list_mtx);
>
> -               error =3D device_suspend_noirq(dev, state, false);
> +               device_suspend_noirq(dev, state, false);
>
>                 put_device(dev);
>
>                 mutex_lock(&dpm_list_mtx);
>
> -               if (error || async_error) {
> +               if (READ_ONCE(async_error)) {
>                         dpm_async_suspend_complete_all(&dpm_late_early_li=
st);
>                         /*
>                          * Move all devices to the target list to resume =
them
> @@ -1528,9 +1526,8 @@
>         mutex_unlock(&dpm_list_mtx);
>
>         async_synchronize_full();
> -       if (!error)
> -               error =3D async_error;
>
> +       error =3D READ_ONCE(async_error);

Just to cache the value locally so that the value used for the "if()"
check is the one that's sent to dpm_show_time()?

Put another way, why can't we also delete the local "error" variable?

Assuming we need to keep "error":

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

>         if (error)
>                 dpm_save_failed_step(SUSPEND_SUSPEND_NOIRQ);
>
> @@ -1585,7 +1582,7 @@
>   *
>   * Runtime PM is disabled for @dev while this function is being executed=
.
>   */
> -static int device_suspend_late(struct device *dev, pm_message_t state, b=
ool async)
> +static void device_suspend_late(struct device *dev, pm_message_t state, =
bool async)
>  {
>         pm_callback_t callback =3D NULL;
>         const char *info =3D NULL;
> @@ -1602,11 +1599,11 @@
>
>         dpm_wait_for_subordinate(dev, async);
>
> -       if (async_error)
> +       if (READ_ONCE(async_error))
>                 goto Complete;
>
>         if (pm_wakeup_pending()) {
> -               async_error =3D -EBUSY;
> +               WRITE_ONCE(async_error, -EBUSY);
>                 goto Complete;
>         }
>
> @@ -1640,7 +1637,7 @@
>  Run:
>         error =3D dpm_run_callback(callback, dev, state, info);
>         if (error) {
> -               async_error =3D error;
> +               WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async late" : " late", e=
rror);
>                 goto Complete;
> @@ -1654,12 +1651,10 @@
>         TRACE_SUSPEND(error);
>         complete_all(&dev->power.completion);
>
> -       if (error || async_error)
> -               return error;
> +       if (error || READ_ONCE(async_error))
> +               return;
>
>         dpm_async_suspend_superior(dev, async_suspend_late);
> -
> -       return 0;
>  }
>
>  static void async_suspend_late(void *data, async_cookie_t cookie)
> @@ -1678,7 +1673,7 @@
>  {
>         ktime_t starttime =3D ktime_get();
>         struct device *dev;
> -       int error =3D 0;
> +       int error;
>
>         trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
>
> @@ -1711,13 +1706,13 @@
>
>                 mutex_unlock(&dpm_list_mtx);
>
> -               error =3D device_suspend_late(dev, state, false);
> +               device_suspend_late(dev, state, false);
>
>                 put_device(dev);
>
>                 mutex_lock(&dpm_list_mtx);
>
> -               if (error || async_error) {
> +               if (READ_ONCE(async_error)) {
>                         dpm_async_suspend_complete_all(&dpm_suspended_lis=
t);
>                         /*
>                          * Move all devices to the target list to resume =
them
> @@ -1731,9 +1726,8 @@
>         mutex_unlock(&dpm_list_mtx);
>
>         async_synchronize_full();
> -       if (!error)
> -               error =3D async_error;
>
> +       error =3D READ_ONCE(async_error);
>         if (error) {
>                 dpm_save_failed_step(SUSPEND_SUSPEND_LATE);
>                 dpm_resume_early(resume_event(state));
> @@ -1822,7 +1816,7 @@
>   * @state: PM transition of the system being carried out.
>   * @async: If true, the device is being suspended asynchronously.
>   */
> -static int device_suspend(struct device *dev, pm_message_t state, bool a=
sync)
> +static void device_suspend(struct device *dev, pm_message_t state, bool =
async)
>  {
>         pm_callback_t callback =3D NULL;
>         const char *info =3D NULL;
> @@ -1834,7 +1828,7 @@
>
>         dpm_wait_for_subordinate(dev, async);
>
> -       if (async_error) {
> +       if (READ_ONCE(async_error)) {
>                 dev->power.direct_complete =3D false;
>                 goto Complete;
>         }
> @@ -1854,7 +1848,7 @@
>
>         if (pm_wakeup_pending()) {
>                 dev->power.direct_complete =3D false;
> -               async_error =3D -EBUSY;
> +               WRITE_ONCE(async_error, -EBUSY);
>                 goto Complete;
>         }
>
> @@ -1938,7 +1932,7 @@
>
>   Complete:
>         if (error) {
> -               async_error =3D error;
> +               WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async" : "", error);
>         }
> @@ -1946,12 +1940,10 @@
>         complete_all(&dev->power.completion);
>         TRACE_SUSPEND(error);
>
> -       if (error || async_error)
> -               return error;
> +       if (error || READ_ONCE(async_error))
> +               return;
>
>         dpm_async_suspend_superior(dev, async_suspend);
> -
> -       return 0;
>  }
>
>  static void async_suspend(void *data, async_cookie_t cookie)
> @@ -1970,7 +1962,7 @@
>  {
>         ktime_t starttime =3D ktime_get();
>         struct device *dev;
> -       int error =3D 0;
> +       int error;
>
>         trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
>         might_sleep();
> @@ -2005,13 +1997,13 @@
>
>                 mutex_unlock(&dpm_list_mtx);
>
> -               error =3D device_suspend(dev, state, false);
> +               device_suspend(dev, state, false);
>
>                 put_device(dev);
>
>                 mutex_lock(&dpm_list_mtx);
>
> -               if (error || async_error) {
> +               if (READ_ONCE(async_error)) {
>                         dpm_async_suspend_complete_all(&dpm_prepared_list=
);
>                         /*
>                          * Move all devices to the target list to resume =
them
> @@ -2025,9 +2017,8 @@
>         mutex_unlock(&dpm_list_mtx);
>
>         async_synchronize_full();
> -       if (!error)
> -               error =3D async_error;
>
> +       error =3D READ_ONCE(async_error);
>         if (error)
>                 dpm_save_failed_step(SUSPEND_SUSPEND);
>
>
>
>

