Return-Path: <linux-pm+bounces-13165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67856964557
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 14:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C90EDB261FC
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 12:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3A01B8E80;
	Thu, 29 Aug 2024 12:45:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432241B86E2;
	Thu, 29 Aug 2024 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935516; cv=none; b=XjTwGwR9MqKDDrGu+QqTxiGwDuPRdcRQpXwwcwaSf8XQQIO97taKgisCfL1oz3R8ZH+MCK02EVaWKLwKR1JMG1uBO60ZCvi5iKYu5fez0lHJqC1RjPYdFI83DnkHDnox64FqjeUkBIrXcwRHVQTV8aDPw08wez0LupAZj/1EH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935516; c=relaxed/simple;
	bh=+LwzQuOMskdYCQNrSv2N8XSkkE9ud0IF6wQLEtd6zEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1z0z01CxJ68bbILITEWcZ3jnIdyjYzR7jxLdNunK+jEtXvr4eY2HzVWQfNRNjfkmsrHDBbP17tYech0vM6NWnJquWnhvBFpMRhGaCM4eiHwhTf24lzgbRZMfnEm08s7gtxWHsxnFQXar33wLT9oLyaD535Fjz2W5OZPZhLFMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6b44dd520ceso6144917b3.0;
        Thu, 29 Aug 2024 05:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724935513; x=1725540313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUjTeXLSWnZkbY07LBWpQrBCxuH3GeKukadOEJ6jzwk=;
        b=vyjUe4OkIk2GTJnx906gfWHqvrtkq+Y+JGthwrsEfCYwE+VQRrqKCJ/0uLXG6/XCBf
         xzkagx34jL9I04tPaqUMx9U78IartBee7MkSXAxBNX5C+3sGOln0wm96wscYvO0/9wi5
         1cxLgDi3kFuxK8XRrlCbHHsvQb6am5ikCx6vIslcOCwGrjsUHZcA1CCjvUzHhyl+XNJ6
         VMrCCig6qahkt5JBVhhhBM7IBwXqJKLPJN03v4GR8fp08+X8tAWLGspla0bzLJmioCl3
         VkFqr9tSs0OlfboePn4LGNa9gCKrIxacfbFzrWlzUUFlBKypUWFJkjBfrfvsWRQ1P10k
         bRsw==
X-Forwarded-Encrypted: i=1; AJvYcCUQTWyLnmkwG1xfQr2txqJCpQuwA2icvp9M2xKbhUxtorBQPRthMvDAH/hw1znKNV5HTBcVpM1pGDPJUs6J@vger.kernel.org, AJvYcCUZ2gtzm26QBLvSDcsDXf2gIqwys/V6cSQXhmQ86ElyAXcVWs9nDo+SbOTDrnyfwROIrumrLkFdcZY=@vger.kernel.org, AJvYcCV3apZ6EPvMwliVH7CejwY0WPmLxLSNRUV/LWf7VXxNKX96p7BV2gGwo4+Cc6gBDhfsGzVpoKdC+eLhMy8bNh4=@vger.kernel.org, AJvYcCVyM8qbxkxyELp7bcDZ+p7ALF0r0DqQpAwg4vBHP3NcKz+crf6M2BAg/esOYKk2yZcslUPPicD0UYo=@vger.kernel.org, AJvYcCW2781C6aljG4CKgz2TGgNuKMmBcUcWGB1284y2qW3dvWTYEUKn5ZvCCyB1ML2wAHXV94Qygcgi85FwzXbWlTzlN2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiWGeXmNIV0OzPdugm9ONtpF58PARNvjZdBjE1PMmpzK0nsseU
	+QzZP0RbT86E0aj2wrsuyJfBG6SrPlBtfSXMIGmzZPBc4rCCjW2C2fOkmTgj
X-Google-Smtp-Source: AGHT+IFAUogVjLo5+Zp77g4oRb2MIRnJj1pAtGZjSCI45VAEcUBNrrEcqVTZ6GHyebCbxY4AzWC+8g==
X-Received: by 2002:a05:690c:d0f:b0:65f:cdc6:e25d with SMTP id 00721157ae682-6d277f514c7mr26523757b3.45.1724935512917;
        Thu, 29 Aug 2024 05:45:12 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d39c8c93sm2245847b3.28.2024.08.29.05.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 05:45:12 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e115c8aa51fso673409276.1;
        Thu, 29 Aug 2024 05:45:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0/1Vfys8UijhdRthkzC3PLqnXF88YcngRpeVFyERj4+37oDbwS1HWiHbixh5laCVgQv0RcrduUfKEDdM1vkNRFVw=@vger.kernel.org, AJvYcCUEK2+MkUCenraSKZKsPxT6DSQMPHboY4pmjn66LOIOM0ziOfUJZFUuh9C/J9V7IihIur4He2JyArx5sPOK@vger.kernel.org, AJvYcCUHHbq1tfolJidAoW06SpTFQk2Bxp/UG+npzQsVN6xI4ckXlUEvHcMpzBWFpBrc/UgVipHHD0J7wOn0yQLpRZw=@vger.kernel.org, AJvYcCWTVqIVjj4x1jQunyb9Xomf5+cOupHfJ9J53ZhSTGWY+G6SwUrXdqEiBf2VfdhydcD1/2gV5TDyFZM=@vger.kernel.org, AJvYcCXniaAFKPeMtJBfoJtUuUBfRqgQOy8N+ahngXKyatGOgXKPOgsnWgtHa/L1LCPD0L5jr7TjmR9M4A0=@vger.kernel.org
X-Received: by 2002:a05:6902:2b0f:b0:e11:6f62:2290 with SMTP id
 3f1490d57ef6-e1a5ab89aafmr3001251276.24.1724935512448; Thu, 29 Aug 2024
 05:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828140602.1006438-1-claudiu.beznea.uj@bp.renesas.com> <20240828140602.1006438-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240828140602.1006438-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Aug 2024 14:45:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUcstyRDfaQ0Y=1NHgBYuRWjC0vuJj2j8USCTsEE1qKVA@mail.gmail.com>
Message-ID: <CAMuHMdUcstyRDfaQ0Y=1NHgBYuRWjC0vuJj2j8USCTsEE1qKVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] clk: renesas: r9a08g045: Mark the watchdog and
 always-on PM domains as IRQ safe
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, wim@linux-watchdog.org, 
	linux@roeck-us.net, ulf.hansson@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Wed, Aug 28, 2024 at 4:06=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> If the watchdog is part of a dedicated power domain (as it may be on
> RZ/G3S) the watchdog PM domain need to be powered on in the watchdog
> restart handler. Currently, only the clocks are enabled in the watchdog
> restart handler. To be able to also power on the PM domain we need to
> call pm_runtime_resume_and_get() on the watchdog restart handler, mark
> the watchdog device as IRQ safe and register the watchdog PM domain
> with GENPD_FLAG_IRQ_SAFE.
>
> Register watchdog PM domain as IRQ safe. Along with it the always-on
> PM domain (parent of the watchdog domain) was marked as IRQ safe.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - changed patch title; it was "clk: renesas: rzg2l-cpg: Mark
>   watchdog and always-on PM domains as IRQ safe"

Thanks for the update!

> --- a/drivers/clk/renesas/r9a08g045-cpg.c
> +++ b/drivers/clk/renesas/r9a08g045-cpg.c
> @@ -259,7 +259,7 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a=
08g045_pm_domains[] =3D {
>         /* Keep always-on domain on the first position for proper domains=
 registration. */
>         DEF_PD("always-on",     R9A08G045_PD_ALWAYS_ON,
>                                 DEF_REG_CONF(0, 0),
> -                               GENPD_FLAG_ALWAYS_ON),
> +                               GENPD_FLAG_ALWAYS_ON | GENPD_FLAG_IRQ_SAF=
E),
>         DEF_PD("gic",           R9A08G045_PD_GIC,
>                                 DEF_REG_CONF(CPG_BUS_ACPU_MSTOP, BIT(3)),
>                                 GENPD_FLAG_ALWAYS_ON),
> @@ -270,7 +270,8 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a=
08g045_pm_domains[] =3D {
>                                 DEF_REG_CONF(CPG_BUS_REG1_MSTOP, GENMASK(=
3, 0)),
>                                 GENPD_FLAG_ALWAYS_ON),
>         DEF_PD("wdt0",          R9A08G045_PD_WDT0,
> -                               DEF_REG_CONF(CPG_BUS_REG0_MSTOP, BIT(0)),=
 0),
> +                               DEF_REG_CONF(CPG_BUS_REG0_MSTOP, BIT(0)),
> +                               GENPD_FLAG_IRQ_SAFE),
>         DEF_PD("sdhi0",         R9A08G045_PD_SDHI0,
>                                 DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(=
0)), 0),
>         DEF_PD("sdhi1",         R9A08G045_PD_SDHI1,

Can't you just do this for all domains (e.g. in rzg2l_cpg_pd_setup()),
instead of limiting this to the wdt0 and always-on domains?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

