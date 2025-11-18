Return-Path: <linux-pm+bounces-38164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC3DC6954F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 13:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3DD4E2AB53
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 12:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748DF303A10;
	Tue, 18 Nov 2025 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FacV8anF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EEC30E84A
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763468278; cv=none; b=PIrPPpCJBNGjLDW8xp7grKj/L7cDKPqAsL4yRZWzBLmHYtD3oZiQtiA4s7su3GTnX3AphSNs/NiKMKweDqTBshoVaETLlA5mGznkBwX46t2lny5WouvPCoZdGWrGEjRBqMDu3C+/zT5TofmWX0Magv/w4izGoflOcvIg8fPUIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763468278; c=relaxed/simple;
	bh=FNe+kP0p7Di8wItZWzeO7bbNlnk0l60J+PG7Qvastds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roe50dQdE9DSscDsHXfO7Cv5y8QXmrJ9OtyI/fTDgvqIdmBFaEHALa+znetYmGrWZjyzjpprazwSRFNP1FgFZXhxVcPvEpngzlF7s8L7H48CAUagrAVmMbfQ4ZQHO5vqQmW6TtIMuGQjIJ/1WhNHEG4LUlPRUQDUDALc4yJnRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FacV8anF; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63bc1aeb427so4833367d50.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 04:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763468275; x=1764073075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zKYPCwTfCB7LQ2acnCdecHo4LMsa2525wI+rQ4Lsj0Q=;
        b=FacV8anFQhsMPGQJX4/qgyJ8CHPXgvK+pFWxshk6g1r5YWVbJeJPsvBkMXqjCZr9+u
         ksG/EH/pM09/QyJJTkNEjtKOU0Fjk++BNLN4CbI+LVQQKrierPUomBwObyl2HmThnoCa
         Gez2AI5aTBz+KUd9jdUEJNnnXVckh7001GX9zLQqn/xTvzoE+NN0UEsNDtw5OFOct4o2
         HxSWzGWLqrxA2wyJi9Fi7kT/k3q2IpcSPo9qiNHl7cSFIv+y5yT0hV3rcLjvZpIyhFXn
         bHGIwoeVnTzP8oBNZLmZBMSo/0bAA9Ka+SYQ88s4xbXycPnaTsKlT08e713UaCDwsrVN
         NaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763468275; x=1764073075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKYPCwTfCB7LQ2acnCdecHo4LMsa2525wI+rQ4Lsj0Q=;
        b=pmoNRUVmbR3pzdctse7ElIyTpTGPuayXu63xc6Lt0BsBvybQdiM/Ix6Y6se1FR9FVh
         CzbeMgpf2qc5iZi3zsJHcetXckPBInUPufhXbc2fQ3qk+yXcgzQkY6rhgSys7gNC/ejm
         gqcynG71aW78gg+/HfrAQoSuZIJgZA6l/iv6yv7vAES5daLLxbNiT0Ap9VycimmJleJ6
         ux1CvLLPhR7XTshD2RLP7jUrR7Zh3QM2Z64/eN9ECVklMBumRfAKp5iaD3cVbUneCz3V
         ST8UdHr5ZEcbAAgAvMGIF/L6kKNJBpr/Mhb8XusbEO7okckcdVXC/eJ+6HgHv3M2oLeg
         MrbA==
X-Gm-Message-State: AOJu0YxoxTD2e5xV8uUrMf61q3I5CJ5zH8cdv11ngVQoEWGWM4MHvAGK
	dTzVo0G1OEUuRKAjTdh/mEGXc9I+T2EGqh+hRxK5PO14Rj3+gbQ3M2XJnuEPIE08w328nyya18h
	gBB3gt+zQA9FAH/wSLrKo5r5KwlRZQmO6UO00pAVOBQ==
X-Gm-Gg: ASbGnctVz5IawOY5h8FBckITOGIHTJYl8UCLXtftF5t+IUcYgciyfd/gHD4G4ap7vf7
	3sOMEUsHexUNf4ux2nHMXoE6bFSM6s4fi1rl97k+HVbaQElgGQ4/P0TLDcYeIsDxLOMSBUebqyV
	MSSq37wGOJfx2OsDcoDryusnQap7EVUULaaaJsMpPFwyhylS3XE/yJAiB0ZHbnzEn/O2DCrzNyW
	jWzu2BGkRarx0CzYPKHovMXTttXDqeWihIo1ecbMehPlTBhIy3bqsdCgzWyOR3wrMuWeb3s
X-Google-Smtp-Source: AGHT+IH5vkW38a0isCVA2e5T5WYOS8uIIq20npmgKu3RFPtWa3i0ZtmInZUSNURmsnwULuvyfghDcOs4ottSeTikfjQ=
X-Received: by 2002:a53:d048:0:10b0:63f:b922:eda7 with SMTP id
 956f58d0204a3-641e74df9efmr11495816d50.23.1763468275130; Tue, 18 Nov 2025
 04:17:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com>
 <5940388.DvuYhMxLoT@rafael.j.wysocki> <119e2410ca32a0d55fa6febf93c7a3164b391db0.camel@mediatek.com>
 <12782716.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12782716.O9o76ZdvQC@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Nov 2025 13:17:19 +0100
X-Gm-Features: AWmQ_bmVtAxNobSpolx7esNrHBiYpoTIJhpwBf5EtPC4hxdNMXHJAkDPR0Y0clA
Message-ID: <CAPDyKFqzt70rkHaRP62zErkMi2kFC1iY-NHPWjK0FWZSjZ00jA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: core: Fix runtime PM enabling in device_resume_early()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Rose Wu <ya-jou.wu@mediatek.com>, 
	rafael.j.wysocki@intel.com, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, wsd_upstream <wsd_upstream@mediatek.com>, 
	linux-mediatek@lists.infradead.org, "artis. chiu" <artis.chiu@mediatek.com>, 
	"Johnny-cc. Kao" <Johnny-cc.Kao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Nov 2025 at 12:48, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tuesday, November 18, 2025 9:31:08 AM CET Rose Wu wrote:
> > Hi,
> >
> > On Mon, 2025-11-17 at 19:57 +0100, Rafael J. Wysocki wrote:
> > >
> > > Make two changes to address this problem.
> > >
> > > First, reorder device_suspend_late() to only disable runtime PM for a
> > > device if the power.is_late_suspended flag is going to be set for it.
> > > In all of the other cases, disabling runtime PM for the device is not
> > > in fact necessary.
> > >
> > > Second, make device_resume_early() only enable runtime PM for the
> > > devices with the power.is_late_suspended flag set.
> > >
> >
> > My concern is with the error path in device_suspend_late().
> > If a device fails its dpm_run_callback(), it appears that its
> > power.is_late_suspended flag is not set, potentially leaving its runtime
> > PM disabled during the resume sequence.
>
> Right, pm_runtime_enable() is missing in the error path after calling
> dpm_run_callback().
>
> ---
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
> device when it is going to look for the device's callback.  In all of
> the other cases, disabling runtime PM for the device is not in fact
> necessary.  However, if the device's callback returns an error and the
> power.is_late_suspended flag is not going to be set, enable runtime
> PM so it only remains disabled when power.is_late_suspended is set.
>
> Second, make device_resume_early() only enable runtime PM for the
> devices with the power.is_late_suspended flag set.
>
> Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
> Reported-by: Rose Wu <ya-jou.wu@mediatek.com>
> Closes: https://lore.kernel.org/linux-pm/70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com/
> Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v1 -> v2: Add pm_runtime_enable() to device_suspend_late() error path (Rose).
>
> ---
>  drivers/base/power/main.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -941,11 +941,11 @@ Run:
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
> @@ -1630,12 +1630,6 @@ static void device_suspend_late(struct d
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
> @@ -1649,6 +1643,12 @@ static void device_suspend_late(struct d
>         if (dev->power.syscore || dev->power.direct_complete)
>                 goto Complete;
>
> +       /*
> +        * Disable runtime PM for the device without checking if there is a
> +        * pending resume request for it.
> +        */
> +       __pm_runtime_disable(dev, false);
> +

Moving this here means we are going to keep runtime pm enabled for
syscore devices during system wide suspend/resume. That's quite a
change in behaviour for a fix for a regression, I think. Not saying
that it can't work though.

Although, perhaps better to call __pm_runtime_disable() a few lines
earlier and use a separate flag to track that we need to call
pm_runtime_enable() in device_resume_early()?

>         if (dev->pm_domain) {
>                 info = "late power domain ";
>                 callback = pm_late_early_op(&dev->pm_domain->ops, state);
> @@ -1679,6 +1679,7 @@ Run:
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

Kind regards
Uffe

