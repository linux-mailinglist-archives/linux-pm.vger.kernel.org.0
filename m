Return-Path: <linux-pm+bounces-34436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7873BB52AAE
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 09:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245DF5835A5
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 07:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8262BEFEB;
	Thu, 11 Sep 2025 07:56:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DF29E114;
	Thu, 11 Sep 2025 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577377; cv=none; b=YvPJ1YY5XKKeNtSH2T8XvnmPSpKCKL+K8dH412/vVT5gLam4L9B0s8mxOfz/1IO9MUX80NaFihqUp7OAClNzujjny06um/hpRlMPey/qINWUNOXhKWVO5xMOsApBqAukEYuel9KlGNzxqyYy/gsCYHcjNmRkN9ZcuvNjo18nChE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577377; c=relaxed/simple;
	bh=dzgZxal19Vqp0wezraV67O5eYSRhr69yaYwwxgc5pl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHMzyWGi/WBMtm0mb9QVsI1Au977XWNSUYJpmgC956D13o5CCqsFe/fgZ9YQPMBgsJUSpTlIgPbAiIZz4ZBAaLtwnMOgNDjHJwYLB9ihvsH564dOZiqe1wdGQ7rCJ94mu0wOpZ7K2PDF/5K3s14EobMjGCJszNelqm9XhTxa1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5300b29615cso416052137.0;
        Thu, 11 Sep 2025 00:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577374; x=1758182174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXxtbIpMN7aU+UMtLOY1wQvwhq9wcmE2BRs0YRXR44o=;
        b=C3cTQGYHTfLULxazPn0iTyMe0XwlHzJZwUSm0ddS3hWZdJHkNY6Xr97n/NRdvOTnvI
         gR4uccLm7pwb72kPniR+pc1e/TF6wu5seP+/xocdu+Ftf0U4RmqbIdeBsIb++68Sn9qh
         3C0Uk12+l4Rt6424Iaq7PkXllPpdnjGQJUbzIqQterBDQ73jr5aJp+rNKdtvi3c5hTcF
         DB8+7QpVwgD+XwnCJDUPH4PcNQuIGr+u6NrnWkh65b3W8LbJz1K7rs4HqhWG07s+I/Ky
         lk3cSjMGgWb3fA5yZv/lKjICZAVmodv2hUHruSWJMHFPnsUdzeL+XMMFM7VgrpPtXSWt
         zdyw==
X-Forwarded-Encrypted: i=1; AJvYcCVJKLJVjuWyunD/nhpDuee2iFcesW1AccIsdMxyg6Ova2sNEWzLqBEg2BYBTSuG4iWnlH1GzADef8k=@vger.kernel.org, AJvYcCWWCBHEb4a3o+nn1xIe2FgEerRTanWri2+bR0PJ+SaGqMCT2vsrlQape3TP0z9U/RQW92uM3rCmkZ7eKiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfX3JvzcyhmU/F5UwHI1TzHxGJG+IeXJag0YAs/T2wlP5F7K7o
	O2NVkGUOi2mIxCrDpgAu4588DwW4yMZjAuZc3ZfKY90ysOzwDq4k8waaDt/DKejl
X-Gm-Gg: ASbGncv8s22dSm6zTmbsbUua6UM6FgbKb+Kwqz/UBt0QyiRGxJdNDFMV9rxGYR9wRTk
	3RkTfnza4F7NUB0JYOQyYnRZSkLFV7pRcheSe9EipoX2xQ3SuJrksjXthSBw8hPKjfCSMgXeOr5
	abcPFcUHq+gJ5Cs2thGdm+vWPG/l4nIVX4ojaUNM/zqhMwEH1a1FrhxIszmsp18WuyH7fqq4qQ2
	LcXDFCB/g/qiG316Aw44mE0HglLFhv3qQSSYTZdxB1HPWHLzy0BYmK8I1C4dYW0XR8aSWM40dAR
	N9kdd3mrILXR2olj38+Q+VENfnBr5DOeW3PvYr1f7f3Gm6h3zO9OQyE/aUXcToaX6klutqpgwnK
	r3X4Qq+LcELNbyQHtX8RFvrYhE/KLhNKlkLFOflEuZZUFFbOWsjI5jwO8dRsjYQUUL5r3YMsIOP
	4=
X-Google-Smtp-Source: AGHT+IEmaBW3DOYVC19n0pTqKqiSR+C62o7t3ABJ5AdLJaE2v0Ak2+aWw06uoqXZtN+yAlW9wagjEg==
X-Received: by 2002:a05:6102:809f:b0:4e4:5ed0:19b2 with SMTP id ada2fe7eead31-53d1c3d661dmr278035137.9.1757577373613;
        Thu, 11 Sep 2025 00:56:13 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5537062ca23sm189728137.6.2025.09.11.00.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 00:56:13 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5464d3b50e3so162372e0c.1;
        Thu, 11 Sep 2025 00:56:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXptPkb3CHtL0WHP07ljd1Zn6M54XROg7FKmkU/noyW5WjaMVn14i+Y4+6I8F3tIkpo8EBVDNGQL5M=@vger.kernel.org, AJvYcCXscNigPe9y2DCIagjgDcX7OEswZ7FjG9mtCVKxcOuvLvBBmpmEda2J4ofchWzZGGfoJw8MlOVWRllETIQ=@vger.kernel.org
X-Received: by 2002:a05:6102:3a0e:b0:4fa:25a2:5804 with SMTP id
 ada2fe7eead31-53d1c3d7886mr6590613137.10.1757577373049; Thu, 11 Sep 2025
 00:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909111130.132976-1-ulf.hansson@linaro.org> <20250909111130.132976-2-ulf.hansson@linaro.org>
In-Reply-To: <20250909111130.132976-2-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2025 09:56:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUFXioe36r9mzNchHw3DGyEiVA-=ajTp333jowEsrxMNw@mail.gmail.com>
X-Gm-Features: AS18NWAoOrpJbTee-4MheB9wiiHBjhuIG7cLb2hP-U4LE07BEhE1otcBQ_oHwLc
Message-ID: <CAMuHMdUFXioe36r9mzNchHw3DGyEiVA-=ajTp333jowEsrxMNw@mail.gmail.com>
Subject: Re: [PATCH 1/5] pmdomain: core: Restore behaviour for disabling
 unused PM domains
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org, 
	Stephen Boyd <sboyd@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Diederik de Haas <didi.debian@cknow.org>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ulf,

On Tue, 9 Sept 2025 at 13:11, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Recent changes to genpd prevents those PM domains being powered-on during
> initialization from being powered-off during the boot sequence. Based upon
> whether CONFIG_PM_CONFIG_PM_GENERIC_DOMAINS_OF is set of not, genpd relies
> on the sync_state mechanism or the genpd_power_off_unused() (which is a
> late_initcall_sync), to understand when it's okay to allow these PM domains
> to be powered-off.
>
> This new behaviour in genpd has lead to problems on different platforms.
> Let's therefore restore the behavior of genpd_power_off_unused().
> Moreover, let's introduce GENPD_FLAG_NO_STAY_ON, to allow genpd OF
> providers to opt-out from the new behaviour.
>
> Link: https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/all/20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com/
> Reported-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -115,6 +115,12 @@ struct dev_pm_domain_list {
>   *                             genpd provider specific way, likely through a
>   *                             parent device node. This flag makes genpd to
>   *                             skip its internal support for this.
> + *
> + * GENPD_FLAG_NO_STAY_ON:      For genpd OF providers a powered-on PM domain at
> + *                             initialization is prevented from being
> + *                             powered-off until the ->sync_state() callback is
> + *                             invoked. This flag informs genpd to allow a
> + *                             power-off without waiting for ->sync_state().

This also restores power-down of pmdomains after a failed device
probe (due to a real issue, or just -EPROBE_DEFER), possibly
interfering with other devices that are part of the same pmdomain(s)
but haven't been probed yet. E.g. what if your serial console is
part of the same pmdomain?  Probably the pmdomain(s) should not
be powered down immediately, but only later, when either sync state
or genpd_power_off_unused() kicks in.

But this is a pre-existing issue, so not a blocked for this patch.

>   */
>  #define GENPD_FLAG_PM_CLK       (1U << 0)
>  #define GENPD_FLAG_IRQ_SAFE     (1U << 1)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

