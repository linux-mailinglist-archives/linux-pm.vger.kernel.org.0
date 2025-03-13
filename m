Return-Path: <linux-pm+bounces-23988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0094DA5FC82
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 17:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A437A7CBE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 16:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDDF1FAC42;
	Thu, 13 Mar 2025 16:48:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637DB126C03;
	Thu, 13 Mar 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884526; cv=none; b=C8rmuM3xpKJVGRJd2xyROoMWCMBUjMQd6SBr3X6a3J1U5PeiMVymMNY5sT+UGEgv51oEbHfBImgdFi++QqvG+sqb4H4FS87Cic1Bd19plEQPhUYpsKCenoTIDFaMus9JL8lq4M8RMbD3Bx6pAi5Uy3H24P+nuSr8J8+dduiF74A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884526; c=relaxed/simple;
	bh=ihatrWyg/H40s8cnRfeXugTi2GFjdX7CEEuJjpbqy5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uerVIPasfxYNNMnl5RCosMKOq5JZlBJyMqLTwxDilyB6eTF+PRjg66INwLPDmkQE3YtmOSXWBcS8oZo9TORYaVbF6q4jezTyExB4efrQ0NfWNtVOzD1uGsQINfHqfZLO2X+BFP/1o9Lv7WqUDgk4AJ1jSLn6hHZ7w60wlms9oSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86911fd168dso474755241.1;
        Thu, 13 Mar 2025 09:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884523; x=1742489323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrfw6BdH8MD0atOJWU+atZIlWEB0GsesjOa67f4JQFg=;
        b=f8ZXZJx+tlJuDYkNeJVykuBmc170RwlwsASoOZTdiMP+yHi51Or78M0FVIA3I08T0Q
         IfL5Ip5qSGsBPSGSRgPZC+OHrAvq0gixVULCF7jX06gtGiH7jgOjkdGx33eVzNff8Dok
         kjrhIQLEoPZM0tH10R7gyPR7aoOYBZVzu3WW+2BpZioQhzXfv6oPp5KBd8u96tGkxcpM
         OmyjkmE2fPJUvbZvTv0OCEwjUzVOBjKuseBS0HTMsgR19YJLtPqpuvsB1Dlx/9XPkaQ4
         dPh3wyKM0BdozTKgN329w7cB64ly+qrPHGqkpe5Dfzt6mzbsz34kMRk/0YZHdG9qp+pA
         cLkg==
X-Forwarded-Encrypted: i=1; AJvYcCXQjIC+AxeiVfWnB/chLOWHCC+UFNDocsejn4oDkmAUcFPu5D/UYd0PSVfwuKQ3Gbl56nSU0sNkAujmMmsP/L5qSqQ=@vger.kernel.org, AJvYcCXiEJnQ24WSZpui3cFJ4Jji5i2CMESmraf33yGM18KlqR2d3oiRTLVxRGzG2jB3gkNJwzSiyG8fgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW+b3c08YY7jSTmv+zZpRM1W85A7daC875oay8coyYhTYKq+zF
	/zK0sOgYMXlE1z7y+o6bM4rwti0N/jb6a3UOHfr7Ae8o0H7+Jv1OrnBpqvWZVIE=
X-Gm-Gg: ASbGncvcdGqWqO73+8+yMQvRzboEpBN0LMN+CTk2PZbo4vKrhRQSaXDKy6VhUoiNJf2
	6aq+L+NH+uGhcrtHYrysDPP03iGp1zJfHCdEdrD7WXH4BHObf7Yg/NGCKx0HCN6kDeYY/w5SZUj
	eXVYifToMD2IwdI5jQu9wF2Md8rRy5FGf/T7J8vmxGzk3dFg8nksOMiA0izJd9xnghys4nyslOL
	AmHngqM/KULOihNhPqs5NOX9/FQ66YWNarbRIHJjqV26r2jowrUIKV+aT/77xS4e3U1z4nBnHIx
	Hnk+0MChSgVEOSYnwaH2flBTqE948eZz1V+9JK3kk7LTLpy9+tuJZwCEnf5WEBnJ91/RFyXQ8P1
	pGU/GaC4=
X-Google-Smtp-Source: AGHT+IHcWaL8guBTFIMNXUar1nGN18e4ItKStal2MXGrM8n0n4Jkn/xAa11X+4Q4dVd3qyV4iuS/jw==
X-Received: by 2002:a05:6102:3f02:b0:4ba:974c:891e with SMTP id ada2fe7eead31-4c37eda04ebmr899756137.17.1741884522886;
        Thu, 13 Mar 2025 09:48:42 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d90d68a13sm250192241.5.2025.03.13.09.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 09:48:42 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-868da0af0fcso502451241.2;
        Thu, 13 Mar 2025 09:48:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUY+ihppORP5l+M/sg2NgZmJjJRizmMbyGtSIWvXmqkPDiV/Tz345wT6AdM7C4UHsHvSkUQdSlc0w==@vger.kernel.org, AJvYcCVbhGn/R9O+WGq8yYEZnME2eT5FYjSUG1C5QkSGItkW1NHYnSaBDQNRELWrpj/vKnFbNc8PEXqzrBss0CIOHcGMXfc=@vger.kernel.org
X-Received: by 2002:a05:6102:3e11:b0:4c1:9328:107d with SMTP id
 ada2fe7eead31-4c37edea758mr1275968137.24.1741884522491; Thu, 13 Mar 2025
 09:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdXN9A-1P_qe=BwKjLaoqxU8iJUQK6h8=s-apR4Y0em_0Q@mail.gmail.com>
 <CAMuHMdXXWH0Do5zXWJ1Uc6dyEb9o1chGSyeyzgDrX+v1wZ7e_A@mail.gmail.com>
 <CAGETcx_wA9RB9QhMPqsLHDFZ4cwOFgE8dBL9ssFkT=J6DEgjGg@mail.gmail.com>
 <CAMuHMdUCXJkg3rkngXf7cqa50u-TEAOntV6O=Nvg33Q9diPJPw@mail.gmail.com> <CAMuHMdWLEHwjaNnysDZ_Unqj-SwmUdwRao_oJvYvVsQ9SCn06A@mail.gmail.com>
In-Reply-To: <CAMuHMdWLEHwjaNnysDZ_Unqj-SwmUdwRao_oJvYvVsQ9SCn06A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Mar 2025 17:48:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXcJN5M7PqJ1eABOOCfeMjvs51rMRzMxU=d2L=3LVgh_w@mail.gmail.com>
X-Gm-Features: AQ5f1JomkofPPtQ7zXslnmFk_uvpA4OoXG79ky7o55RIlfGqGEip72q7DKrcluM
Message-ID: <CAMuHMdXcJN5M7PqJ1eABOOCfeMjvs51rMRzMxU=d2L=3LVgh_w@mail.gmail.com>
Subject: Re: s2idle blocked on dev->power.completion
To: Saravana Kannan <saravanak@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
	Linux PM list <linux-pm@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

On Thu, 13 Mar 2025 at 15:32, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
> On Thu, 13 Feb 2025 at 11:26, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> > On Thu, 13 Feb 2025 at 09:31, Saravana Kannan <saravanak@google.com> wr=
ote:
> > > On Mon, Feb 10, 2025 at 2:24=E2=80=AFAM Geert Uytterhoeven <geert@lin=
ux-m68k.org> wrote:
> > > > On Fri, 7 Feb 2025 at 16:08, Geert Uytterhoeven <geert@linux-m68k.o=
rg> wrote:
> > > > > Instrumenting all dev->power.completion accesses in
> > > > > drivers/base/power/main.c reveals that resume is blocked in dpm_w=
ait()
> > > > > in the call to wait_for_completion() for regulator-1p2v, which is
> > > > > indeed a dependency for the SN65DSI86 DSI-DP bridge.  Comparing
> > > >
> > > > [...]
> > > >
> > > > > Looking at /sys/devices/virtual/devlink, the non-working case has=
 the
> > > > > following extra entries:
> > > >
> > > > Note that the SN65DSI86 DSI-DP bridge driver uses the auxiliary bus
> > > > to create four subdevices:
> > > >   - ti_sn65dsi86.aux.0,
> > > >   - ti_sn65dsi86.bridge.0,
> > > >   - ti_sn65dsi86.gpio.0,
> > > >   - ti_sn65dsi86.pwm.0.
> > > > None of them have supplier:* symlinks in sysfs, so perhaps that is
> > > > the root cause of the issue?
> > >
> > > Sorry, I haven't had time to look into this closely. Couple of
> > > questions/suggestions that might give you some answers.
> > >
> > > Is this an issue only happening for s2idle or for s2ram too? I'd gues=
s
> > > both, but if not, that might tell you something?
> >
> > The two (very similar) boards I could reproduce the issue on do not
> > support s2ram yet.
> >
> > > The only reason the wait_for_completion() wouldn't work is because th=
e
> > > supplier is not "completing"?
> >
> > Yes, the diff shows ca. 70 additional calls to "complete_all()" in the
> > good case.

>   4. When the issue happens, /sys/devices/virtual/devlink shows 3
>      more links:
>        A. platform:feb00000.display is a supplier of platform:fed80000.ds=
i-encoder
>        B. platform:fed80000.dsi-encoder is a supplier of platform:feb0000=
0.display

Their status file report "dormant".

>        C. i2c:1-002c is a supplier of platform:fed80000.dsi-encoder

Its status file reports "available".

>   5. What happens in dpm_noirq_resume_devices()?
>
>        /*
>         * Trigger the resume of "async" devices upfront so they don't hav=
e to
>         * wait for the "non-async" ones they don't depend on.
>         */
>         i2c-1 (i2c bus) and 1-002c (bridge device) are async,
>         thus triggered first.
>         After that, the remaining devices are resumed.
>
>      In the bad case:
>
>        device_resume_noirq(fed80000.dsi-encoder, async=3Dfalse)
>          dpm_wait_for_superior()
>            parent soc: skipping wait_for_completion()
>            dpm_wait_for_suppliers()
>              supplier feb00000.display: skipped, DL_STATE_DORMANT
>              ^^^^^^^^^^^^^^^^^^^^^^^^^
> Cfr. extra link A above (harmless)
>
>              supplier e6150000.clock-controller: skipping wait_for_comple=
tion()
>              supplier 1-002c: wait_for_completion() =3D> BLOCKED
>              ^^^^^^^^^^^^^^^
> Cfr. extra link C above, but the bridge device hasn't been resumed yet.

Changing the test for "DL_STATE_DORMANT"[1] in dpm_wait_for_suppliers()
to also include "DL_STATE_AVAILABLE" makes it skip supplier 1-002c,
and fixes the issue.  Does that make sense?

If yes, I will send a proper patch.

Thanks!

[1] https://elixir.bootlin.com/linux/v6.13.6/source/drivers/base/power/main=
.c#L270

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

