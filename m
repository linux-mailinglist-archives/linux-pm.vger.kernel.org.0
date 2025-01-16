Return-Path: <linux-pm+bounces-20556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A1EA13E7E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C52E1886557
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 15:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F350D22CBE5;
	Thu, 16 Jan 2025 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v4K18D1Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA80222CBD2
	for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042924; cv=none; b=ZxJZbyCti/fxCBgtIl0dZbfObx/ecD050rLrIg8gXIwkZe+wtTUsnoiquANhv7vzDiTn2OuGAG8RZDxXkWOS0ETg8me705GPo9Y25C3pnR1l+eo80AT1RmsEHX83KaLVvV8UJ05TYxdJ0cT3viga/NqrRTNiUXkZTNW6cWEDMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042924; c=relaxed/simple;
	bh=GpmSCB4ZBI6fcR200jXSiKpPHuPVfQZgx8k35EDFNEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P80H1Ho8Uu/KwYEDfMrrShyTXpvrg+0bZgoHbqnRji/kYuxxfQzCigOZAeHol5sP1r7obO8RyAhajrT0mkMWOK5yaCkPwDaz+fCGuBjYYAXsLJGlD//ybiqeVL71dz1MRuDhsmSzatHEA0ZA6k/O/bfoS6BdgDDl+DDQuJM6Rl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v4K18D1Y; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e549be93d5eso2066513276.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 07:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737042921; x=1737647721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B45HWnEsrErBTAeUwa7tm1CnNcKF+XSXxGQyP0Z/A4w=;
        b=v4K18D1YCrpWnSuQgbu1ftdj136YQVBRZ1D2b0C1Cw4lH7nvo7ms1MPsGoMUlA1hJN
         9gU4orEmZC8Hg7yNDGpgWK49XcqwpkifQJNKl38SVRen9hkCEAZ+vX0gWCrpWgCR0Hus
         l7C7IkzouBEp7uT15yAIptUgF09eU6x5Uoa/6ZT5RXI70QDY6g2w/qFLTiHqnXOE0o73
         Hr1uIpEjClrSlsJtqa6m5A6OlhPjOwiADzE7FJasVBsglhqeKBKBDAqXVqO5i3/VkEgp
         O7RYk+iwI20oYCkd8V0Q/1UBXWmMUYf3XGAUJLr2pvgY5t6XuwtUHZh3unhtP36bi9OC
         50YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737042921; x=1737647721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B45HWnEsrErBTAeUwa7tm1CnNcKF+XSXxGQyP0Z/A4w=;
        b=J9hCC9L4V8sXoS3YKVcuONfPEZpMPwKHzjmSSqrQ1bVVm9FCVGMdl/5sIN5JP5u2ys
         njTYSysRSFToSrhG7894HNhLXvvB9T0GldkdfLZ2lItuEr15dN82kk69GIII5drcBADA
         ZqvyCGKZ0gygErS4aw72h9CoBoDtZSmXt6L88tQH2Hg/2aM32D50ay4/n63uZsDWLqyY
         AQ4vU741iwLwi8JXDj9slH9lbU43tVJJw1MZNwd173n7YgCe2nm2mJLwmo/EU0Cr/7xM
         dpIi72203fhPwRvqVd75uquQm4FpP3RkpNrBYR+ttmblrB4Fl0KLG/AmD1PlhCa+aVya
         wunQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu/lz9N4lUtWbEgyrZauBaMuVF/cwRgF75FW5sLFNqcLuDDzSHfBsS1uxlzABSYssIs0iInhObEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCXFIYH/N+1NqGMiVZ4nRds8fFJdKdp9uHakpbWlfiKCNNWGoc
	sv7kynHcuPCp4ArpSmvuLqLHoPK8DF0igveD4gOcuvJ75Xg33CfUdJeR/q687WnFXpxfAQzac+Y
	C6/HTmIq5hZFostRayXm932FiJ6bGbeI/Cpbo4w==
X-Gm-Gg: ASbGncvY6iZ140JDqtiDKrSRvOH5jTpuwUj0n1fp3Mx28neS/ecu1cRJBuqmoaAhRQG
	evnKwJywPC/Zz6Fet9wOFIrPw2YKw8QHawwXEcn4=
X-Google-Smtp-Source: AGHT+IFQm6e6xAyFhrMcdkapL0mAOMeXFBpQgfySeoKqGhVVcHMO8CDPC1zu1enV5UtEJJessy0bZP29VGeAaJ42B/Q=
X-Received: by 2002:a05:6902:2b07:b0:e57:5cac:25e8 with SMTP id
 3f1490d57ef6-e575cac2cf8mr14087935276.9.1737042920814; Thu, 16 Jan 2025
 07:55:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115113931.1181309-1-sudeep.holla@arm.com>
In-Reply-To: <20250115113931.1181309-1-sudeep.holla@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 16 Jan 2025 16:54:44 +0100
X-Gm-Features: AbW1kvYRA44-AR-_rg9xZ3QiKo5WmpcDxOP-Aqv9AX2XHkvx9lSEhKZYQIIk2BY
Message-ID: <CAPDyKFrrdkBAPBw5JOv5HLnOj2L=6ZjE+O7h8N3MFC64ebcNEg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Send an explicit request
 to set the current state
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org, 
	Cristian Marussi <cristian.marussi@arm.com>, 
	Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jan 2025 at 12:39, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On a system with multiple active SCMI agents, one agent(other than OSPM/
> Linux or bootloader) would request to turn on a shared power domain
> before the Linux boots/initialise the genpds. So when the Linux boots
> and gets the power state as already ON, it just registers the genpd with
> a default ON state.
>
> However, when the driver that needs this shared power domain is probed
> genpd sees that the power domain status is ON and never makes any SCMI
> call to power it up which is correct. But, since Linux didn't make an
> explicit request to turn on the shared power domain, the SCMI platform
> firmware will not know if the OSPM agent is actively using it.
>
> Suppose the other agent that requested the shared power domain to be
> powered ON requests to power it OFF as it no longer needs it, the SCMI
> platform firmware needs to turn it off if there are no active users of
> it which in the above scenaro is the case.
>
> As a result of SCMI platform firmware turning off the resource, OSPM/
> Linux will crash the moment as it expects the shared power domain to be
> powered ON.
>
> Send an explicit request to set the current state when setting up the
> genpd power domains so that OSPM registers its vote in the power domain
> state with the SCMI platform firmware.
>
> The other option is to not read the state and set the genpds as default
> OFF, but it can't handle the scenario on certain platforms where SCMI
> platform keeps all the power domains turned ON by default for faster boot
> (or any other such variations) and expect the OSPM to turn off the unused
> domains if power saving is required.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Link: https://lore.kernel.org/all/Z4aBkezSWOPCXcUh@bogus
> Reported-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> Reported-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

I read up on the discussion and it looks like there is not really a
simple solution here.

In principle if a boot-loader wants to do a handover and leave the
power-domain powered-on for the kernel, the additional call to
->state_set() *could* bump the usagecount in the SCMI FW, forever
leaving the power-domain on.

I guess this problem only exists for power-domains being shared across
scmi agents. Perhaps some kind of configuration flag can help us to
determine what to do?

> ---
>  drivers/pmdomain/arm/scmi_pm_domain.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> Hi Ulf,
>
> We need your feedback or suggestions for better solution on this matter.
> Let us know if we can do something better with the genpd's help to resolve
> this issue.

At initialization, genpd tries to get the correct state of the HW. If
the power-domain is on, genpd believes that it will stay on until it
requests it to be powered-off.

That said, I know we have FW's that aren't capable of informing us
about the power-domain's current state. For this, I (and Abel Vesa)
have been exploring how to introduce an "unknown-default" power-state,
which would mean that genpd would request on or off the first time
there is a transition of the genpd's power-state. This is on my TODO
list, perhaps that is something that can help here too?

Kind regards
Uffe

>
> Regards,
> Sudeep
>
> diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
> index a7784a8bb5db..86b531e15b85 100644
> --- a/drivers/pmdomain/arm/scmi_pm_domain.c
> +++ b/drivers/pmdomain/arm/scmi_pm_domain.c
> @@ -96,6 +96,14 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
>                         continue;
>                 }
>
> +               /*
> +                * Register the explicit power on request to the firmware so
> +                * that it is tracked as used by OSPM agent and not
> +                * accidentally turned off with OSPM's knowledge
> +                */
> +               if (state == SCMI_POWER_STATE_GENERIC_ON)
> +                       power_ops->state_set(ph, i, state);
> +
>                 scmi_pd->domain = i;
>                 scmi_pd->ph = ph;
>                 scmi_pd->name = power_ops->name_get(ph, i);
> --
> 2.34.1
>

