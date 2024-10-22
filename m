Return-Path: <linux-pm+bounces-16216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0C49AA108
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 13:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0BE1F241AC
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 11:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F6419C578;
	Tue, 22 Oct 2024 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wq3XPbVV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4319CC26
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595953; cv=none; b=oLPfcDv/HfxnKQ7ze8dEeMw9uU8cw0uebWX5O9JoKl6NhLGpXMMFZmXhQEFVlJuXkdhuqd8UtPV65DLzTaROgeuoAkfUlKeoVdkAIialmdq9I8eq8cMG5dmH84LLe81t2pl5lQ/sYln7C4FCyRiUheNrsrXEZSwahidWPTLF42Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595953; c=relaxed/simple;
	bh=Dz/ZB4lNp9lyR1xwx/BuRQkbirfZXwN2QmdkffNol5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWA6u12rjkA1QoT6tNyhREQ9ZEQkTcAEDQbE7NQVpGx0cUJ7yFuMqwgwS2vY/mAU49mUSCPrYmWIyjtXExq65HmlzumfZiTWX6gXwbkHVVSbR/SmY6uOobvYNsdaxvrzRHirve6ZOxhiHf2SzGegMth0aKeZDP5QfDPYePIGqn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wq3XPbVV; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e305c2987bso52298297b3.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 04:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729595950; x=1730200750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MzJp5XRWFw3tagzJfYi+1NlfVG6/VmewVK1n5BPqdsg=;
        b=Wq3XPbVV+gTNXRdpPE548MBgpBWg3hO8zYvqfgGTuPox3lSIvYX70XEV9qYiEfwdzp
         yRPeE/1/h5/k5IH1+afOsQZ9eYrUXYaGD8nMPPmZDb78TMdtsbhb6qJvdzdHLQlzZsfR
         nHk6jftFWtNHkHHIFVohFve7zYLgyuJVD/bPQHWLT0XVZiTXAg9osfdL1XAG4M0W/gWb
         Fxee2rwc1CvMLn8ueJZgkGW5VrcEQ2RQFQDRUEaTjrj5zLAFAZiLwuuAYZz73aFA5puN
         tfyhU+1/OH7OC6beLVa/2DZsejH7IPh4JcES+Yb8CnMcq7UcGJlKeKPVRpmrwEM2a/9I
         nLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729595950; x=1730200750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzJp5XRWFw3tagzJfYi+1NlfVG6/VmewVK1n5BPqdsg=;
        b=FB7jg8rVdkM066dU4GLcpWdr0wZePpSebKn/XYhgg5SyIrTGVDjy9cltOJ+8MYDnkF
         UiGInOCiba0uwdpOvaoCFG6KPw6hsXTaYm0hA/2pqkoudE4h5PL9iabtZ1Jd6cJoL0Ii
         vm+tOPp6Cz4lJVu2qpua7Fe8+IdNt2mutxx1lkp922VovQmI1KODGDxf8ELwHgLND++1
         sRXgZ8TqARZ+8JGHi4aOVCGl3lByX20TC97XrRzUXIIxlVL1rjWiKXwdaaLvFqgdg8RH
         LN7OzZwNdo9jir7FZmHJfMGHRngnyXhfVKc0dDGqhA58Wr0Glgj64tgAP5K6oK796/l4
         xxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU9vaDzrJDS+PdsKFwhwdp6a7traOYUOk5Rx5Ee+G9HdvQfobCtO1smnMAn0QYA4kEMwo/Q51n4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuTO0RP6L0ZjwSZs2fCogAWNw/eb8Tf7gQhqu+q9JaUl+Di6Hz
	cPx/xsthnVTcDKeiEIzzEu+qmI6fHW3SbcLpRMuE2su6UbXvDEdx9mmgyCvxM/7AlkSSEPgIrIB
	SaBNChEow4v+lXQeXrsaQvhpYAY9aoXxMDqMabw==
X-Google-Smtp-Source: AGHT+IHxzR+VpzMk0eh95mSXUtTh66zqaFoWZe+jU+3M8XaoYrSUTlH5qGcn4JE3hwp9jxfkDs6kXsSRFaOTgLSjoxY=
X-Received: by 2002:a05:690c:4a09:b0:6e7:e76e:5852 with SMTP id
 00721157ae682-6e7e76e6470mr6643617b3.32.1729595950231; Tue, 22 Oct 2024
 04:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-tisci-pd-boot-state-v1-1-849a6384131b@ideasonboard.com>
In-Reply-To: <20241022-tisci-pd-boot-state-v1-1-849a6384131b@ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 22 Oct 2024 13:18:34 +0200
Message-ID: <CAPDyKFozUxHDSt6oR62EQE=gSBXifM1PBvJ_owei_MptyANEKQ@mail.gmail.com>
Subject: Re: [PATCH RFC] pmdomain: ti-sci: Set PD on/off state according to
 the HW state
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Hilman <khilman@baylibre.com>, vishalm@ti.com, sebin.francis@ti.com, d-gole@ti.com, 
	Devarsh Thakkar <devarsht@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 08:41, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> At the moment the driver sets the power state of all the PDs it creates
> to off, regardless of the actual HW state. This has two drawbacks:
>
> 1) The kernel cannot disable unused PDs automatically for power saving,
>    as it thinks they are off already
>
> 2) A more specific case (but perhaps applicable to other scenarios
>    also): bootloader enabled splash-screen cannot be kept on the screen.
>
> The issue in 2) is that the driver framework automatically enables the
> device's PD before calling probe() and disables it after the probe().
> This means that when the display subsystem (DSS) driver probes, but e.g.
> fails due to deferred probing, the DSS PD gets turned off and the driver
> cannot do anything to affect that.
>
> Solving the 2) requires more changes to actually keep the PD on during
> the boot, but a prerequisite for it is to have the correct power state
> for the PD.
>
> The downside with this patch is that it takes time to call the 'is_on'
> op, and we need to call it for each PD. In my tests with AM62 SK, using
> defconfig, I see an increase from ~3.5ms to ~7ms. However, the added
> feature is valuable, so in my opinion it's worth it.
>
> The performance could probably be improved with a new firmware API which
> returns the power states of all the PDs.
>
> There's also a related HW issue at play here: if the DSS IP is enabled
> and active, and its PD is turned off without first disabling the DSS
> display outputs, the DSS IP will hang and causes the kernel to halt if
> and when the DSS driver accesses the DSS registers the next time.
>
> With the current upstream kernel, with this patch applied, this means
> that if the bootloader enables the display, and the DSS driver is
> compiled as a module, the kernel will at some point disable unused PDs,
> including the DSS PD. When the DSS module is later loaded, it will hang
> the kernel.
>
> The same issue is already there, even without this patch, as the DSS
> driver may hit deferred probing, which causes the PD to be turned off,
> and leading to kernel halt when the DSS driver is probed again. This
> issue has been made quite rare with some arrangements in the DSS
> driver's probe, but it's still there.
>
> So, because of the DSS hang issues, I think this patch is still an RFC.
> Hopefully we can sort out all the issues, but this patch (or similar)
> will be part of the solution so I'd like to get some acks/nacks/comments
> for this. Also, this change might have side effects to other devices
> too, if the drivers expect the PD to be on, so testing is needed.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

This patch seems reasonable to me, however I am deferring to apply it
until yours and other confirmations about tests.

In regards to the "disable unused genpd" problem, I am working on it
in-between all the other stuff. I do understand that it probably
starts being annoying waiting for me, so I will try to get this
prioritized. We really need to get this solved.

Kind regards
Uffe

> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 1510d5ddae3d..14c51a395d7e 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -126,6 +126,23 @@ static bool ti_sci_pm_idx_exists(struct ti_sci_genpd_provider *pd_provider, u32
>         return false;
>  }
>
> +static bool ti_sci_pm_pd_is_on(struct ti_sci_genpd_provider *pd_provider,
> +                              int pd_idx)
> +{
> +       bool is_on;
> +       int ret;
> +
> +       if (!pd_provider->ti_sci->ops.dev_ops.is_on)
> +               return false;
> +
> +       ret = pd_provider->ti_sci->ops.dev_ops.is_on(pd_provider->ti_sci,
> +                                                    pd_idx, NULL, &is_on);
> +       if (ret)
> +               return false;
> +
> +       return is_on;
> +}
> +
>  static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -161,6 +178,8 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>                                 break;
>
>                         if (args.args_count >= 1 && args.np == dev->of_node) {
> +                               bool is_on;
> +
>                                 if (args.args[0] > max_id) {
>                                         max_id = args.args[0];
>                                 } else {
> @@ -189,7 +208,10 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>                                 pd->idx = args.args[0];
>                                 pd->parent = pd_provider;
>
> -                               pm_genpd_init(&pd->pd, NULL, true);
> +                               is_on = ti_sci_pm_pd_is_on(pd_provider,
> +                                                          pd->idx);
> +
> +                               pm_genpd_init(&pd->pd, NULL, !is_on);
>
>                                 list_add(&pd->node, &pd_provider->pd_list);
>                         }
>
> ---
> base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
> change-id: 20241022-tisci-pd-boot-state-33cf02efd378
>
> Best regards,
> --
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>

