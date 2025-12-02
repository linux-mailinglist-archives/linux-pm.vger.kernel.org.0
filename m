Return-Path: <linux-pm+bounces-39082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8294C9BE0C
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 15:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DB03A8145
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225E724293C;
	Tue,  2 Dec 2025 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ioD2t41M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E6122D7A5
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764687570; cv=none; b=lddMpR8iyt0nsmMzIvdBNysdhyRJ/Ek8w/FWOEgNTY9ENDxDwQzbBT7yNynKmrD8nrEEzNrzYKeDlyqZCU6+mVO1gXWOBpKYVeC7v97jIptwbwYKqWGQH9RpDIjunnJMYoopFRLbJo6hqB3kXH3W+ng8lbc+zwLuO/Jjhi2J+9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764687570; c=relaxed/simple;
	bh=V9g9cpv3V3NHhykrvaTFUzVlSKcxiplW5+x3kp6pAVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ez02xC2tZxGAFzns2Zvisa+wpe6zjcI89kMzf6Pb04kaPOB4vQ8a74VeyxI+6WMDzQHK23C8SKFxoqOHP88B758GVq+M/Ufa53ijbUNnjtmrK5tie+xzFrEah590KkVQJgfTdnGHUxrBM6G04BUuPDmqXvQYRX6jsuDZuoSYaJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ioD2t41M; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6420c0cf4abso5394880d50.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 06:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764687567; x=1765292367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy7z8LxUgbNx9+lmwxL4ukKa87u8XopMnGtj0ZiMAlE=;
        b=ioD2t41M8d5B/9KcplTCdfhCb6Np+yDHg8N6lCqekwNvLUI/vMNDqINTeKSSCiU5wo
         p5Vqx0nhvPsdL4gIt1Mfp0gjdhYlyzB7Q4ZSN89N8Criv1mTycXHzQZSG7R+3ghTaQRI
         IFcBSQubNTXyv6ycjVeooSKLBOrPkCeDNyo7/4bjnd+KJaSiQySFEu1bTbbWj6xFtyov
         wMx5dOEkCKmnrko0kgcaiXR5cZ1PpJhUKdr0MQJ0MciLg2F8hdAKZoUp7ZXa6TwAYXfC
         +LCCAum8Vklkx1DYNwEO4HXTMBgSMxZJrMKpzgUmWTH/IO49LftP6TYWycSrbDiRd/EP
         ys/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764687567; x=1765292367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sy7z8LxUgbNx9+lmwxL4ukKa87u8XopMnGtj0ZiMAlE=;
        b=ZtMueqp9BNJuVa4OKHBL+PMyApSXNnVbvBgU4gm5xBxXk3Pge+Fn5SDgKigyF0KafD
         bTFnXPYnR3b6lFLlWkqi7Lb79Lt6+WYDRWvY7NHH1zCoALdcS2pmIsG5HeVcF2KLjIAj
         hbqklKgNl3jWVMxy0Z7mwbX0IUJ5hpkAMvBVjWNm4gXuKDyo2U1XwKrcNPIXuhZW9hSd
         mPE9h/KRaGEv7FZWnj4MRNgvh3Z3CBy12i2LyoH1Ym+BDs4XHjUyHOk6tOF2z00JOdYg
         n8sNaeRxHARVJSwjZ/PPSUgb6gT9a2EmcN2+PV/B63k2bpVbKwI4Tp90zCApefOaoK53
         br9g==
X-Forwarded-Encrypted: i=1; AJvYcCWREOC7BIUERiEtzjnGjBUVTEVC8yEDIwVPVLzihYLX3E8SIkaacNlBxwbmCxZcadfIA9CJph7DxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhszQwHUOtSDhQr6pKo0ynp0DLTO+oYEm46n0okdC2Ft37lLm/
	/YCQoy3/B+2++DyZP4YluN6Y6KQsA1fQw6Wg1T76Polr0H7LM/dBUr44CvxJf6GVT+6mLpeEswD
	a8yLRFcp3GeFIGJvCHoDiSvY88P4OvCAV2PXkA7S3jg==
X-Gm-Gg: ASbGncv6o/bHi4ATPSXUlm6RsorYCWThL2Lp93ym7xkzrqCXhcnlrg+Ylfk7y8rJN+z
	rBZXqwAbJULEQsEizDHaIcI+BBQkeYoO+W8IsZNtNDT1bsjuNf8+XWtW5/xuhgxlywis9upt87X
	io4uo9KkEMRsL2h13Ad0zM+jgsKIN7pb9lJpsicQ5MVA/z5b89R7BEiy7IxhU5S3X9d/banJIm0
	AXkXUrJheNHMGibSB9sk1rPy46jn2Dq04G1PLuNAyDwYW2H778qRrOPzf0v2WSEdL62SXzgL5O1
	11dRtQ4=
X-Google-Smtp-Source: AGHT+IHCagcg+F87Vxj+xtbNAi0aCBaiVLKpwwpglzgGDq/L/txM55fGjFqp7Aok2JAJVihGtDfMXK6wBzjDIOjbJCs=
X-Received: by 2002:a05:690e:1904:b0:640:fabf:565d with SMTP id
 956f58d0204a3-64302b102a7mr27965390d50.43.1764687566900; Tue, 02 Dec 2025
 06:59:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
 <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com> <6216669.lOV4Wx5bFT@rafael.j.wysocki>
In-Reply-To: <6216669.lOV4Wx5bFT@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Dec 2025 15:58:50 +0100
X-Gm-Features: AWmQ_bnsvgauegVF9oV0tfqOAOqJaUR4paRwwtYaVZxwAPEyFlPZGgD7UMGrM7w
Message-ID: <CAPDyKFo_GQrUTrKgScBHo=MuRVP7dra9_NoDxHq8sVb7=sqCCA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Do not flag runtime PM workqueue as freezable
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: YangYang <yang.yang@vivo.com>, Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Dec 2025 at 20:58, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Monday, December 1, 2025 7:47:46 PM CET Rafael J. Wysocki wrote:
> > On Mon, Dec 1, 2025 at 10:46=E2=80=AFAM YangYang <yang.yang@vivo.com> w=
rote:
>
> [cut]
>
> > If blk_queue_enter() or __bio_queue_enter() is allowed to race with
> > disabling runtime PM for q->dev, failure to resume q->dev is alway
> > possible and there are no changes that can be made to
> > pm_runtime_disable() to prevent that from happening.  If
> > __pm_runtime_disable() wins the race, it will increment
> > power.disable_depth and rpm_resume() will bail out when it sees that
> > no matter what.
> >
> > You should not conflate "runtime PM doesn't work when it is disabled"
> > with "asynchronous runtime PM doesn't work after freezing the PM
> > workqueue".  They are both true, but they are not the same.
>
> So I've been testing the patch below for a few days and it will eliminate
> the latter, but even after this patch runtime PM will be disabled in
> device_suspend_late() and if the problem you are facing is still there
> after this patch, it will need to dealt with at the driver level.
>
> Generally speaking, driver involvement is needed to make runtime PM and
> system suspend/resume work together in the majority of cases.
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject:
>
> Till now, the runtime PM workqueue has been flagged as freezable, so it
> does not process work items during system-wide PM transitions like
> system suspend and resume.  The original reason to do that was to
> reduce the likelihood of runtime PM getting in the way of system-wide
> PM processing, but now it is mostly an optimization because (1) runtime
> suspend of devices is prevented by bumping up their runtime PM usage
> counters in device_prepare() and (2) device drivers are expected to
> disable runtime PM for the devices handled by them before they embark
> on system-wide PM activities that may change the state of the hardware
> or otherwise interfere with runtime PM.  However, it prevents
> asynchronous runtime resume of devices from working during system-wide
> PM transitions, which is confusing because synchronous runtime resume
> is not prevented at the same time, and it also sometimes turns out to
> be problematic.
>
> For example, it has been reported that blk_queue_enter() may deadlock
> during a system suspend transition because of the pm_request_resume()
> usage in it [1].  That happens because the asynchronous runtime resume
> of the given device is not processed due to the freezing of the runtime
> PM workqueue.  While it may be better to address this particular issue
> in the block layer, the very presence of it means that similar problems
> may be expected to occur elsewhere.
>
> For this reason, remove the WQ_FREEZABLE flag from the runtime PM
> workqueue and make device_suspend_late() use the generic variant of
> pm_runtime_disable() that will carry out runtime PM of the device
> synchronously if there is pending resume work for it.
>
> Also update the comment before the pm_runtime_disable() call in
> device_suspend_late() to document the fact that the runtime PM
> should not be expected to work for the device until the end of
> device_resume_early().
>
> This change may, even though it is not expected to, uncover some
> latent issues related to queuing up asynchronous runtime resume
> work items during system suspend or hibernation.  However, they
> should be limited to the interference between runtime resume and
> system-wide PM callbacks in the cases when device drivers start
> to handle system-wide PM before disabling runtime PM as described
> above.
>
> Link: https://lore.kernel.org/linux-pm/20251126101636.205505-2-yang.yang@=
vivo.com/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I agree with the above and this seems like a reasonable change to me.
Yep, it's not entirely easy to know whether all users of
pm_request_resume() (and similar) are fine with this too, but in
general I think they should.

So, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c |    7 ++++---
>  kernel/power/main.c       |    2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1647,10 +1647,11 @@ static void device_suspend_late(struct d
>                 goto Complete;
>
>         /*
> -        * Disable runtime PM for the device without checking if there is=
 a
> -        * pending resume request for it.
> +        * After this point, any runtime PM operations targeting the devi=
ce
> +        * will fail until the corresponding pm_runtime_enable() call in
> +        * device_resume_early().
>          */
> -       __pm_runtime_disable(dev, false);
> +       pm_runtime_disable(dev);
>
>         if (dev->power.syscore)
>                 goto Skip;
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -1125,7 +1125,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
>
>  static int __init pm_start_workqueues(void)
>  {
> -       pm_wq =3D alloc_workqueue("pm", WQ_FREEZABLE | WQ_UNBOUND, 0);
> +       pm_wq =3D alloc_workqueue("pm", WQ_UNBOUND, 0);
>         if (!pm_wq)
>                 return -ENOMEM;
>
>
>
>

