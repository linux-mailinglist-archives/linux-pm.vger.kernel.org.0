Return-Path: <linux-pm+bounces-15266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3C4992F60
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 16:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4449E285C39
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 14:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F261D54DC;
	Mon,  7 Oct 2024 14:27:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584661D2F4B;
	Mon,  7 Oct 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311264; cv=none; b=JObpbQ0dmrt14+gKD0LM6EiNV+88XPf+nb5nZQH1PRIH2x42iNq5F2sjMtVS8SFh+45ve9G2ggUXoH9+x38++QjsE0I+VlU5u748lW6mjEQvyrlIOiy2LjEJx9OPJYO4IlCP3bIhXmbFtNyy0jHX6lINxEqr8jGljPbZGE7vKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311264; c=relaxed/simple;
	bh=dXRNIrId85YuMJlo848dCqwvKRbQe1ea88bkNgKsWu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihKPz7rf6jeGu/fGtkFFPyznEGMmmzXZyG/Bdw2B026K3MYPBiLsvFeuAk2KDzBNPWwcPrSzu52TN4RPt5q4xfodmfZX08ndlugvQUGBakHSITSUhWJpx+KrnZLakHvfx9ZxNhSqPiRuPeV5RCD2OFGopH56MNtDG7CwdIXIjmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e2e4d16ce3so16905897b3.2;
        Mon, 07 Oct 2024 07:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728311261; x=1728916061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79tpInCGL6U4AlrlQFVSdWFkPcmYEJrqik5CbWnT8hI=;
        b=JyrwN7lrcRlJNtdDTEsauGLLitioJkyoM7OL9vsc2tqhtET5DAXz1C2V258CJRUnk3
         e/WuNRxYIDQn4F6+6q4inHBjE6LkQAsdzXMWwDyAfCjH+DSaaNala9dhGA3tFZRLEOcr
         h0I1og/Mv9ZjnucGnO27zcKLoUDyh5kiggTnyO9S5/MyNnDH3MZmS22eCp97mpwDM1RG
         4tgAw+kEzmqdNOYiF6DtTWq5PzYXzvIFg37yvctotBoz+zVPums1kUL7JCam67nlZAXI
         BdBHzEAPpaHeiNHq4c7f1GZJJB6ny0Ke4ydLvYFc5iwwLSILfZENaQeWUyADeU90Uwfj
         E/XA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Qy0tImsM9h+IQyat/PiH4gFiq/6y/nrqFjhF/GXR4190ZSGCm+lhlb2PMaPWVVJP0ZM/yER+fm76k1SC@vger.kernel.org, AJvYcCV8aQEKtifQ1+ru+hWBD6W4J+XovoGYHDnZvIFdcRPODTp/66DelzpevmnC4531kSx+bh7CmGAHoF/pOJjKXhE=@vger.kernel.org, AJvYcCV9JccKernBh56uslARj6ylXLaFeT+wFgvv50oPGKPGJxyedTMCAeophCZP7eDHpMKcnuzqlO3mJF8=@vger.kernel.org, AJvYcCVJ4jN1R2ojJB9HnvFFQduSlFinMfbRcexro6SUF37o+i4AT2Az3qNpTUNbP9FGBE8kebHfQkXx/qsoyOq50dLS8zY=@vger.kernel.org, AJvYcCW1dIpw/avgwjGgCTdbnzokAnvwnq4ChuBPYN+pl35sNCHXLYKRyKfRdFvER/6tEV/j0mW5uBFLo7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKyAOCIWEn0dK3sFHrkDFh1y2lJeAK3jRId7fh9bV9pGpq2auh
	678reFsiSYrptqnpmo3MA6/t5orSxqvESQfaDkhZAFInvWgzIGINMh0zhcoG
X-Google-Smtp-Source: AGHT+IGncgIoiiYf+GDOe3639/p+la+Gu38Eug/htFAj+fIW2pIqBGulNCGEonYU0CxM0/YOJ8W51Q==
X-Received: by 2002:a05:690c:45c7:b0:6e2:43ea:552 with SMTP id 00721157ae682-6e2c726fd44mr89445757b3.16.1728311260738;
        Mon, 07 Oct 2024 07:27:40 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93f8f43sm10358947b3.140.2024.10.07.07.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:27:40 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e1f48e7c18so34229667b3.3;
        Mon, 07 Oct 2024 07:27:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJu0vpKl7kRRVYXc09yANLH7HN8H7Y43YC/Chr6DibtGKUnRB4CtTanS3VnR5E6IzL/r4Vf2UNyX9u3M/c@vger.kernel.org, AJvYcCWOgzAVN+TIhfp9OX5gIGxdNT1oSgobGVfb4BygEcS8FAd4UCZkJo/GwxibhNwONPJRs+axFD/0t6vogUW4iQWkV7E=@vger.kernel.org, AJvYcCWwxdnzKBaIHptSHN7Gihdi/lyJBG/GGnNCyG3ysz8AVAsKXYVVW8vb3/6UnFMj36h3pPnUmq3IFQ8=@vger.kernel.org, AJvYcCXbk8POjYShQsTqMOSUpDl45XclgC/AcXxA7EkpKz0RupSNaP0PcXAEur0rsCoPY7/4SoA05xeOqno=@vger.kernel.org, AJvYcCXuhcvolDxYkJ9NSm5kW8mMpmT+T+2TVA6lcJklaUPpW/EquhCx6w3pvmwiWe3t9KPeESxm1E5hzJDuW14FOAE=@vger.kernel.org
X-Received: by 2002:a05:690c:3143:b0:664:4b9c:3de with SMTP id
 00721157ae682-6e2c726d631mr72101497b3.13.1728311260327; Mon, 07 Oct 2024
 07:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902132402.2628900-1-claudiu.beznea.uj@bp.renesas.com> <20240902132402.2628900-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240902132402.2628900-4-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Oct 2024 16:27:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVNDTfLQ1EuEWVk3sgi7XX=_kMVTH=ymfmCdxgEfJm6oA@mail.gmail.com>
Message-ID: <CAMuHMdVNDTfLQ1EuEWVk3sgi7XX=_kMVTH=ymfmCdxgEfJm6oA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] clk: renesas: r9a08g045: Mark the watchdog and
 always-on PM domains as IRQ safe
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, wim@linux-watchdog.org, 
	linux@roeck-us.net, ulf.hansson@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:24=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
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
> Changes in v3:
> - none

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

