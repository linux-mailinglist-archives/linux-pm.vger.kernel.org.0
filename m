Return-Path: <linux-pm+bounces-34486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C8EB535EE
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 16:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FEA1884381
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D85A34167D;
	Thu, 11 Sep 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbE/LbQC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16148341673
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601559; cv=none; b=FOPLvISqHGEIPr35oxS6RlrRVMKmyo4qEsut3S7IE0z8eTeXogJ9ZCgjNB8OkHBKGqKLoMAt9z0F9Dh6327cuSlldkdlYPFXF2LSL41yf6nGAONV1JNjMZGCqjH1GYiFqYBF5KJkQo8ZENoedB8ohOKDHg4M9S7ayw7SREXSZoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601559; c=relaxed/simple;
	bh=t6RyhrLfGhw9qzteCVG9AMG+iFTGfnSwB9AnX4yy/F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0m2hchFyKmWf4WOl+yhplRzoUYNmY6eUiimnqJUxZ7kkjwryGJ0dCXqc9q8fyjCxGlrArplSRtGT5UpSm+g2MCOlqbkeYwPeJjOs7hmu59MRungM4mIyAIayvEQpEi+aluK1oPZh/9eVlKJqFIQXVlED9CCR3XnBUClYfP51GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CbE/LbQC; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ea0297e9cd4so473486276.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757601555; x=1758206355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HbBobC0v4eff32ngfVq0VfnRgl2Ah0/8T2f7fqD3KKw=;
        b=CbE/LbQCRJc0c7MHBrAlRUXwMmWciDvhRA1WE5SunzE1zQ3NIxGva+2xSl2nCHvx+x
         hF47/JqCfnt+LVCgaKuBx9ZowcI2uo5JIJP+HcvH4L/d1eYW5q+KngHCa3BgBjDfHPyq
         Ki4Zem7bBXMWhSNTGhRT/EXFbHPWF1AyMXHqp/JQjiWgvVbSiGTzTfRTo7iv9VapU5tv
         llNQbIVXxhXjd6Y8mTKLVqoLQ0bGE6mDj5gWfwNSY+kZ+hqDCIRBf4U6E2SJvvgLRAm/
         KMOrdQsf4Wb2U7qaJFmCoRH+lU5cJGhtQsS7QcR8g7v6d+3ydeTNGg2Othtc9rUsi8KO
         UPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601555; x=1758206355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbBobC0v4eff32ngfVq0VfnRgl2Ah0/8T2f7fqD3KKw=;
        b=dvhlxBIFsnMlF7p4ZbXzFXClLPXbLSDwv/uGQD6KI5sxaeZeOWWi1XFEEnySH3aoG2
         L7B7UJKZxTrueyt7jJh3svy7LA+C2fZQ6ogLBAO0QCLbHrBuevQbab8LBJ1g1FCNr5TG
         rmiwmGP728qAiz1cOGSe85LpLbsx0vuSFepjWYOI1pxyDbb9pkW8fOZJvfisPjX/j3kC
         HrKwCRtmUHtJzv/7JXoIegViaKkQBoZRcvuzC5TrzdrT1e+TQkP/6p6X0nqAcJweRlZT
         Ai2Ool8AfcrdQJD4ER/SHxADP0NpN4r+MiobT37D+zxpTjeJ9vgD6VKKyOGNXV9E6qnl
         VOCA==
X-Forwarded-Encrypted: i=1; AJvYcCUSqlsftqXjMFHnILXyDXfTRyWWPI3YhTJBHJfbFHEP5U2kd3EQY6xW/2mK95iQuUh5tYLqyIAMJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yydee/LEtWdoZk4goj8BXwVKhQ6DHCjz/1BInFdHeidqgAE8Umb
	KT3louFfQIiL4RoVPeRSfvgK1VUMuYIpok9tmp9g/OcM/ejYrKVmJnlXSQG/4dTKVKmyfvBG3Uo
	aWaG65c3NdbTwLs7Dokk69qmEwdZrc3JMbCmUeZwyjg==
X-Gm-Gg: ASbGncvepZpWosGEo5L9DzGr6VjHGR9VQay/I3vrq/GY1e70/BF7LaGO5m7zWP7/6y6
	74RgCa9jKK7JbpTUzm7s9Q1vpmr91bymmlvKZtx0C8MzBNv+1OhJnkh6ZEP7IpGov/4DRVOmdZw
	NWmV/pz+ANtu6h9ToLcjNYLDG9Bi7abMiQSfn/1KVi8UwF4n/FN3Kk0XCK7mMySfbgKpCKvS97l
	EwlR5nTLelEG2yxzDsBzqk+m06iyw==
X-Google-Smtp-Source: AGHT+IFpL041NgNSYHspWH4yA4/NKoHQ52gMrPlor7yXw7ilhVJwKEDCxgkx2t/OXO5Qx5pnzT4qSKghDDvsooOyxsE=
X-Received: by 2002:a05:6902:2b8d:b0:e93:2a04:5ca8 with SMTP id
 3f1490d57ef6-e9f66ed6197mr17981110276.20.1757601554561; Thu, 11 Sep 2025
 07:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-tisci-pd-boot-state-v2-1-a1a4173cf859@ideasonboard.com>
In-Reply-To: <20250908-tisci-pd-boot-state-v2-1-a1a4173cf859@ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Sep 2025 16:38:37 +0200
X-Gm-Features: Ac12FXzjgykrwXF_mwcytWvOKCsY08WwCbQyF230DEbX6oK_0mRBUlw2K8vwsXE
Message-ID: <CAPDyKFqj1Ed85z8Zwt5hioOGhiCxX95JZcHz98b6=zXm8tjR0A@mail.gmail.com>
Subject: Re: [PATCH RFC v2] pmdomain: ti-sci: Set PD on/off state according to
 the HW state
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Hilman <khilman@baylibre.com>, vishalm@ti.com, sebin.francis@ti.com, d-gole@ti.com, 
	Devarsh Thakkar <devarsht@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 10:35, Tomi Valkeinen
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
> With recent change from Ulf (e.g. commit 13a4b7fb6260 ("pmdomain: core:
> Leave powered-on genpds on until late_initcall_sync")), the sync state
> mechanism comes to rescue. It will keep the power domains enabled, until
> the drivers have probed, or the sync-state is triggered via some other
> mechanism (e.g. manually by the boot scripts).
>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Makes perfect sense to me! Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - Clarify the current state wrt. sync state in the patch description
> - Rebase to current upstream
> - No other changes
> - Link to v1: https://lore.kernel.org/r/20241022-tisci-pd-boot-state-v1-1-849a6384131b@ideasonboard.com
> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 82df7e44250b..e5d1934f78d9 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -200,6 +200,23 @@ static bool ti_sci_pm_idx_exists(struct ti_sci_genpd_provider *pd_provider, u32
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
> @@ -231,6 +248,8 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>                                                    index, &args)) {
>
>                         if (args.args_count >= 1 && args.np == dev->of_node) {
> +                               bool is_on;
> +
>                                 of_node_put(args.np);
>                                 if (args.args[0] > max_id) {
>                                         max_id = args.args[0];
> @@ -264,7 +283,10 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>                                     pd_provider->ti_sci->ops.pm_ops.set_latency_constraint)
>                                         pd->pd.domain.ops.suspend = ti_sci_pd_suspend;
>
> -                               pm_genpd_init(&pd->pd, NULL, true);
> +                               is_on = ti_sci_pm_pd_is_on(pd_provider,
> +                                                          pd->idx);
> +
> +                               pm_genpd_init(&pd->pd, NULL, !is_on);
>
>                                 list_add(&pd->node, &pd_provider->pd_list);
>                         } else {
>
> ---
> base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
> change-id: 20241022-tisci-pd-boot-state-33cf02efd378
>
> Best regards,
> --
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>

