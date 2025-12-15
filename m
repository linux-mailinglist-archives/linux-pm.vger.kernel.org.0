Return-Path: <linux-pm+bounces-39594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA54DCBEC55
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 16:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32A45301699F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A64308F02;
	Mon, 15 Dec 2025 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRHO+1CH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA72EFD9C
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765813759; cv=none; b=cc8gyHd785gv7KOR2vOQr8gDXL5XMQ3fetWLJyWrk/x9Oka1neIOgQ3zwTUHZty2otMnlgRwTuknAyOmonzQhwptdiI+Jr/vdetnhUtnNgBVKfQTkruD9CXc52YdUFAzlB988iN2AeLZv7ThswQQIy0jf4Vm0g8owUdQIlPYyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765813759; c=relaxed/simple;
	bh=8j/vzTKPUpZPTn7s+qpAiEl5hgbgjwM9lNT4jLzmpr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zwuf3kvKyavZEHj/pPI0m/vVi9d561nkeoHsS9vGHRhJ3gOf3DZJUgl+GJ1QnFwb1xnNvVV9nPR22nTfw90aedIaNHhIGstMuqNALDv9adtGU/UBpqFT9qYGhK+OLmIQ1kEHZWuTejZJvRxmcNoT4NgQqTBwRIByR6FRAq0qzBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BRHO+1CH; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-641e942242cso2829428d50.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 07:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765813757; x=1766418557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e08qkOpj3WfbTFuZmyrzV5+JluhiQ0mupHHDg3KLdTw=;
        b=BRHO+1CH1QpI6NyUzM+HFXVBq1oD3Y4kWjRAc2GZvyUkoGoYsjzVtkg2kBEPOXgh4Y
         ANovG/fRt26eSogTaHGdfRk/0gQUS9zYTaQqSPOXfmwNrXZ3t2wFxAKmEeiYSjOVmVdn
         FhykiTKTT4Gd1U1WmrThYcO6KWC3EklT184okTlS3iToq1uxrFsCZTA5JgT8+nmfsWr/
         PDOEH0dpMd5IVAfB+vCp8WnaIZmHkIm1DqgRBi8+X2NdUHtslujFXWtm+Wbn/Aegg7A+
         OVGngRJINV3nAhzryP+Ya/xfeloKIzszlMBEuGqk7XFmhEEcyZB1AKJx4GjYtkw5/okx
         IH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765813757; x=1766418557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e08qkOpj3WfbTFuZmyrzV5+JluhiQ0mupHHDg3KLdTw=;
        b=uXMF2lTyoszXKw0td7aGAFabpNs4vk1wk+mfjIzi0DVDtpC9iQBE1WAePSazcpJN/i
         akovwKZWj0zXzorVfaqQ3V6VtkSdEESVnPK9qhlfSi/G7z6SGhTcQU8dODxmei7QlAq8
         MeAejkAf5t/awV/Lkj+eOWOCkcGgSkhtYZv3UBtghxls+qdOnLZm5bqXL7WUjDCcapZj
         HfozXstBaocpJjJS5FTS+iwJmEz8+StTTs6eaV9r+7dYlKyrN8dGrV8JhFcTmXQU/slp
         QWWM5GVQcopMhP0lQt2nlEJmSvSv2BT5d/547En3pXP70Z3P88+VPywdFBrWXRMd3lHu
         xgWg==
X-Forwarded-Encrypted: i=1; AJvYcCX3lveLLq1zLo2JNEC+Z+/hYOKQLX9UFMEyLkIkg1PucG9jAp7HVtDTSobaIHBpHYH1jLOzNm83jA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaparLI5PMe/dIeSR1XUwU8IOyVxYOJRtOPOptBtuecpl/pBkW
	+0qe3V0rJXiOJcbx1j3BTj5dVDqKb/R/+yRkovJMrYJb+zonZj1nRUt4iArbp34jqVDfNCruhj4
	Aox1gr2MvULukwuTmz6mZBtF5JpFVn1cbS5dwVagY7g==
X-Gm-Gg: AY/fxX58wa/R4zQmCG6XCyhXVn8JGJaD56dDmJX5XEkfo8gtdFlxg+6Pclp3wEYXzzk
	yow8BpONbzEp99FjBS3QQtKJIqyRLDC4B1uDBFSKoGP7iqazkIRzpDB7K9FTnwiQQMK7+iAmSmg
	a47n1+5Prb+ZPM9nlIpFdaLKHkBg9qxz42PVRkGxm85UtLoeO5gk+OBUQpjNKg/BBGjFiOo8bFj
	+dbUUo42V8Z7OGI4Djn60oGDqCPGmbLVeo1dgvj4p3zObqt0nnq+yeBuZ3Icj6c7NSofS4Mf6wC
	dw+R2Ng=
X-Google-Smtp-Source: AGHT+IG42Dlb5H8RBa3dDWJe/njq8QKAlsDYFOIdkUNzlr/ALH53QmEtN3T7DTv+XnZyzYJx5usU9tSBf+EChkTQgJU=
X-Received: by 2002:a05:690e:1244:b0:644:43f7:11aa with SMTP id
 956f58d0204a3-645555cdd52mr8764242d50.13.1765813756587; Mon, 15 Dec 2025
 07:49:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215122154.3180001-1-ed.tsai@mediatek.com> <12807571.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12807571.O9o76ZdvQC@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 15 Dec 2025 16:48:39 +0100
X-Gm-Features: AQt7F2p9LaiGdJ2wDLThy2UohaIFGncIyGbhH9qnDbL_6WQ4z7c1iocSPb_Ocjg
Message-ID: <CAPDyKFpdixuO_ySig9dajFsv40J7d5ML67h6MwCkemrq3fft_Q@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Do not clear needs_force_resume with
 enabled runtime PM
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ed Tsai <ed.tsai@mediatek.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	chun-hung.wu@mediatek.com, freddy.shin@mediatek.com, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Dec 2025 at 15:21, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Monday, December 15, 2025 1:21:42 PM CET ed.tsai@mediatek.com wrote:
> > From: Ed Tsai <ed.tsai@mediatek.com>
> >
> > needs_force_resume is a bitfield member in struct dev_pm_info and must
> > be accessed under the same lock as its bitfield group.
> >
> > A real concurrent write was observed between needs_force_resume and
> > idle_notification; stacks below:
> >
> > write needs_force_resume:
> >   pm_runtime_reinit+0x110/0x360
> >   really_probe+0xe0/0x464
> >   __driver_probe_device+0x9c/0x104
> >   driver_probe_device+0x3c/0x1a8
> >   __device_attach_driver+0x100/0x17c
> >   bus_for_each_drv+0x10c/0x168
> >   __device_attach_async_helper+0x7c/0xf4
> >   async_run_entry_fn+0x4c/0x1b4
> >   process_scheduled_works+0x1dc/0x498
> >   worker_thread+0x220/0x320
> >   kthread+0x150/0x27c
> >   ret_from_fork+0x10/0x20
> >
> > write idle_notification:
> >   rpm_idle+0x464/0x5f8
> >   __pm_runtime_idle+0x7c/0x170
> >   scsi_autopm_put_device+0x18/0x28
> >   scsi_sysfs_add_sdev+0x1a0/0x1d8
> >   scsi_probe_and_add_lun+0xbd8/0xcd0
> >   __scsi_add_device+0xb8/0x11c
> >   ufshcd_async_scan+0xb4/0x3a4
> >   async_run_entry_fn+0x4c/0x1b4
> >   process_scheduled_works+0x1dc/0x498
> >   worker_thread+0x220/0x320
> >   kthread+0x150/0x27c
> >   ret_from_fork+0x10/0x20
> >
> > Fixes: 89d9cec3b1e9 ("PM: runtime: Clear power.needs_force_resume in pm_runtime_reinit()")
> > Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
> > ---
> >  drivers/base/power/runtime.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 84676cc24221..3328543b1ed8 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1879,11 +1879,22 @@ void pm_runtime_reinit(struct device *dev)
> >                               pm_runtime_put(dev->parent);
> >               }
> >       }
> > +
> >       /*
> >        * Clear power.needs_force_resume in case it has been set by
> >        * pm_runtime_force_suspend() invoked from a driver remove callback.
> >        */
> > +     if (dev->power.irq_safe)
> > +             spin_lock(&dev->power.lock);
> > +     else
> > +             spin_lock_irq(&dev->power.lock);
> > +
> >       dev->power.needs_force_resume = false;
> > +
> > +     if (dev->power.irq_safe)
> > +             spin_unlock(&dev->power.lock);
> > +     else
> > +             spin_unlock_irq(&dev->power.lock);
> >  }
> >
> >  /**
> >
>
> Thanks for the patch, but this happens because the flag is cleared when
> runtime PM is enabled which shouldn't be necessary, so I'd prefer to make
> the change below.
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1] PM: runtime: Do not clear needs_force_resume with enabled runtime PM
>
> Commit 89d9cec3b1e9 ("PM: runtime: Clear power.needs_force_resume in
> pm_runtime_reinit()") added provisional clearing of power.needs_force_resume
> to pm_runtime_reinit(), but it is done unconditionally which is a
> mistake because pm_runtime_reinit() may race with driver probing
> and removal [1].
>
> To address this, notice that power.needs_force_resume should never
> be set when runtime PM is enabled and so it only needs to be cleared
> when runtime PM is disabled, and update pm_runtime_init() to only
> clear that flag when runtime PM is disabled.
>
> Fixes: 89d9cec3b1e9 ("PM: runtime: Clear power.needs_force_resume in pm_runtime_reinit()")
> Reported-by: Ed Tsai <ed.tsai@mediatek.com>
> Closes: https://lore.kernel.org/linux-pm/20251215122154.3180001-1-ed.tsai@mediatek.com/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/runtime.c |   22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1878,16 +1878,18 @@ void pm_runtime_init(struct device *dev)
>   */
>  void pm_runtime_reinit(struct device *dev)
>  {
> -       if (!pm_runtime_enabled(dev)) {
> -               if (dev->power.runtime_status == RPM_ACTIVE)
> -                       pm_runtime_set_suspended(dev);
> -               if (dev->power.irq_safe) {
> -                       spin_lock_irq(&dev->power.lock);
> -                       dev->power.irq_safe = 0;
> -                       spin_unlock_irq(&dev->power.lock);
> -                       if (dev->parent)
> -                               pm_runtime_put(dev->parent);
> -               }
> +       if (pm_runtime_enabled(dev))
> +               return;
> +
> +       if (dev->power.runtime_status == RPM_ACTIVE)
> +               pm_runtime_set_suspended(dev);
> +
> +       if (dev->power.irq_safe) {
> +               spin_lock_irq(&dev->power.lock);
> +               dev->power.irq_safe = 0;
> +               spin_unlock_irq(&dev->power.lock);
> +               if (dev->parent)
> +                       pm_runtime_put(dev->parent);
>         }
>         /*
>          * Clear power.needs_force_resume in case it has been set by
>
>
>

