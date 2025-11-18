Return-Path: <linux-pm+bounces-38181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46640C6A204
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 15:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99F864E4E71
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC083570A4;
	Tue, 18 Nov 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEUr89IB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2135C1B2
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763477111; cv=none; b=LANHbD3o6PrVd8ZkdI02NAhu7OtP1YMGqYyhA8loWfTw0DYTmAMk9BluWgDZBr62Ykq0X+x6x8P4CaCzsnMivSqpbwHXPoOaZZZYcAPP4mcUk98VSuoUTZhPX6H+hAQpu13K2Imiz4c8w8rB8DAOBtZS7YsANu0yLUbyEH19o/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763477111; c=relaxed/simple;
	bh=WenJVCogUnM3pGpFcwziW6Fp+9yd6t1dV2fU7Xi6Alc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfyF7r7v/gi8JgMv5lS8HjltqE7aB2WPuC+efYmUVpM8N2svex1j9EzpfCBxn91FeZr9JaxsGnElAIJAmajV0CMvOb/RxQ6a4XMq62KFPbZsCiI8qGGHsAhMk2m+ee/d8r8fe6kS0Jyo5pHR9xtTq3+SncbqhmR440D8s2gmM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bEUr89IB; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7895017c722so22671827b3.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 06:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763477109; x=1764081909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dxv4h7ofkzean2g/SBkB1c70TV7EMeFgRSSskiCZXY8=;
        b=bEUr89IBwvHrkekcKnjPwhACZRp9uHNgV1lhP2zf9DZ1EIMjE5w1KTavhbIOSbwxNh
         8Ff223m1u3f9LJCaPYPV70dODeNum8TYTprNEap8iuqIDKu7FYSV/UWpm+SJEvfbkDdH
         CSzRkNrNT2/bQatng8eGCqjGL/QPdmXskVYLDA35V7NReoSHLCxqVR5L8X+jtgX2g47h
         21rcVtk/70kmuIaAAKDF9+nknMMuoUEqsHoGNu0VytkxyAZOulTbbFN//FFSmaYKYBU3
         4rP49WAxNWw+8oDARggR6tPl1Ldsmdsc23K28nxyo4mm9pqwybxW0Y6ky9ZOl7uwxWXx
         xABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763477109; x=1764081909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxv4h7ofkzean2g/SBkB1c70TV7EMeFgRSSskiCZXY8=;
        b=Ge9b1OfZX79SaIMgd20U7x9aKgaCloT0jek8YcpQZxg7OeKuFgTDJnDnZUnYdwY7V4
         I6Yw9xm96GR1LjzKMCUdXScf2Dei8RqGySsvlLlU0X2r08AXYvCcbBG4WQE+UcmiHGPj
         yunw7d9Q3JsUgMDOZSbbHpXshAItSWTzf555W0tvniRSc7tdBwe661WH6vw6cPaI7Qz+
         H4dCeNLaiB8voO2AaE8HW5t1AyboEo+b13S3gKSaqA86otTyvMLh8/TpRrNaMyw/yjHZ
         0Wpv1KaPOlseWSC+q6jq2dIJJRDJDqkZ9RZQmVyP4hhZEmmZopHKjmbTHnJMZLPHVE8w
         uMrg==
X-Forwarded-Encrypted: i=1; AJvYcCWfqvO+VBhWrlb1WNApuZ1ov9TNthzDH5VhogKZQQpLuV/4g0GSzKyRqna7tcnFlV+of4KAWO/z2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhglV0e06e3g4Ks0dG5EEQNkAY3z0i8x6Gy1/paQi6bYI0drFm
	zc1Ht3KUSVszvLkgdc9WJvYdtCbFhtZf4245RLkVyBxgUBv0GgA3PrHrjaggP5xbRgUdbMQegaD
	gMz8SsI1zdUI3Tq8FMt3ZzfModLPTAjfiGDeuAL3Vpg==
X-Gm-Gg: ASbGncu2YBEOE+scN3rxtHHPHTFfXAQy2BGQI7PNjJEsn78eMJ6djD2wd73V8bfsA0v
	j1crknnxcVCdNr3GZ0hroBfwvxK32qzIUTTbKroXqt4LPDoSEjV53gfQBd3v39v/Hur8m7Tb/hB
	gTBqBv0sadR4u0ZglSnsQ8B2JYEXoaFOCZ2hH84nMvCx/NorpiseLSXBPK/Yx8ZEZgBmU2Z2Ycv
	lwOrdGOmRNO1sJA+gbDdfjNtBoNDrKC+bRm0Da5GmPj14XVMYQOfg3kR/YntYzTfdDVZRCm
X-Google-Smtp-Source: AGHT+IF7dxRUgvG46HM4+Rwc//gSMA7288zU/dLypnRqJ7Ti0QMfdRIpamc5xKZmVlaZsx7Wbl3epvjvS9InQfkzXCM=
X-Received: by 2002:a05:690c:3802:b0:787:cad1:bdbf with SMTP id
 00721157ae682-78929eef73amr146762497b3.53.1763477108864; Tue, 18 Nov 2025
 06:45:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com>
 <CAJZ5v0iTMhWoBfbrPabdo7TkNuOwtC=-6acSe9tbDmyzZEoXwg@mail.gmail.com>
 <5941318.DvuYhMxLoT@rafael.j.wysocki> <12784270.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12784270.O9o76ZdvQC@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Nov 2025 15:44:32 +0100
X-Gm-Features: AWmQ_bn6eOA_VKuMFyefgoEE9Geca2TO4X2U23GfUd5Xp4xmmVMzfrrokKx24cc
Message-ID: <CAPDyKFqByMzQruYZTBL0T47Ww2KTF1Py91K-wrQ9GuTeW3fx9A@mail.gmail.com>
Subject: Re: [PATCH v4] PM: sleep: core: Fix runtime PM enabling in device_resume_early()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rose Wu <ya-jou.wu@mediatek.com>, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, wsd_upstream <wsd_upstream@mediatek.com>, 
	linux-mediatek@lists.infradead.org, "artis. chiu" <artis.chiu@mediatek.com>, 
	"Johnny-cc. Kao" <Johnny-cc.Kao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Nov 2025 at 15:16, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Runtime PM should only be enabled in device_resume_early() if it has
> been disabled for the given device by device_suspend_late().  Otherwise,
> it may cause runtime PM callbacks to run prematurely in some cases
> which leads to further functional issues.
>
> Make two changes to address this problem.
>
> First, reorder device_suspend_late() to only disable runtime PM for a
> device when it is going to look for the device's callback or if the
> device is a "syscore" one.  In all of the other cases, disabling runtime
> PM for the device is not in fact necessary.  However, if the device's
> callback returns an error and the power.is_late_suspended flag is not
> going to be set, enable runtime PM so it only remains disabled when
> power.is_late_suspended is set.
>
> Second, make device_resume_early() only enable runtime PM for the
> devices with the power.is_late_suspended flag set.
>
> Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
> Reported-by: Rose Wu <ya-jou.wu@mediatek.com>
> Closes: https://lore.kernel.org/linux-pm/70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com/
> Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> v3 -> v4:
>    * Reorder the syscore check in device_resume_early() after the
>      is_late_suspended check (Ulf)
>    * Update the changelog to reflect the above.
>
> v2 -> v3:
>    * Also set is_late_suspended for syscore devices to avoid skipping runtime PM
>      disabling for them (Ulf).
>    * Update the changelog to reflect the above.
>
> v1 -> v2:
>    * Add pm_runtime_enable() to device_suspend_late() error path (Rose).
>    * Update the changelog to reflect the above.
>
> ---
>  drivers/base/power/main.c |   25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -903,12 +903,15 @@ static void device_resume_early(struct d
>         TRACE_DEVICE(dev);
>         TRACE_RESUME(0);
>
> -       if (dev->power.syscore || dev->power.direct_complete)
> +       if (dev->power.direct_complete)
>                 goto Out;
>
>         if (!dev->power.is_late_suspended)
>                 goto Out;
>
> +       if (dev->power.syscore)
> +               goto Skip;
> +
>         if (!dpm_wait_for_superior(dev, async))
>                 goto Out;
>
> @@ -941,11 +944,11 @@ Run:
>
>  Skip:
>         dev->power.is_late_suspended = false;
> +       pm_runtime_enable(dev);
>
>  Out:
>         TRACE_RESUME(error);
>
> -       pm_runtime_enable(dev);
>         complete_all(&dev->power.completion);
>
>         if (error) {
> @@ -1630,12 +1633,6 @@ static void device_suspend_late(struct d
>         TRACE_DEVICE(dev);
>         TRACE_SUSPEND(0);
>
> -       /*
> -        * Disable runtime PM for the device without checking if there is a
> -        * pending resume request for it.
> -        */
> -       __pm_runtime_disable(dev, false);
> -
>         dpm_wait_for_subordinate(dev, async);
>
>         if (READ_ONCE(async_error))
> @@ -1646,9 +1643,18 @@ static void device_suspend_late(struct d
>                 goto Complete;
>         }
>
> -       if (dev->power.syscore || dev->power.direct_complete)
> +       if (dev->power.direct_complete)
>                 goto Complete;
>
> +       /*
> +        * Disable runtime PM for the device without checking if there is a
> +        * pending resume request for it.
> +        */
> +       __pm_runtime_disable(dev, false);
> +
> +       if (dev->power.syscore)
> +               goto Skip;
> +
>         if (dev->pm_domain) {
>                 info = "late power domain ";
>                 callback = pm_late_early_op(&dev->pm_domain->ops, state);
> @@ -1679,6 +1685,7 @@ Run:
>                 WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async late" : " late", error);
> +               pm_runtime_enable(dev);
>                 goto Complete;
>         }
>         dpm_propagate_wakeup_to_parent(dev);
>
>
>

