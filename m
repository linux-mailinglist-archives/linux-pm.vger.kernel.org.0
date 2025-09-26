Return-Path: <linux-pm+bounces-35442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDB3BA298C
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 08:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74CD561D10
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 06:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F712280A56;
	Fri, 26 Sep 2025 06:58:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF227FD46
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869880; cv=none; b=TwQKJVoqo9tSO2p8Ty2ybYxrs3w1ycLVq1BBWfDajJjcHWZqaQRzx3g6w0ENfec2mWHH3eJ5hKnR3GT4tpzx6foRyBMX0ngR6V9wglziP9ZTq+eOxfE4eDO14QYoTdmd3tpXeYYkysw5ADqMfHFLm+Tl5ny9Hwo6e4Fc2dEr8J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869880; c=relaxed/simple;
	bh=dw8VodF5d0G5wyZprT1Cfu9CVLPEqqgX7pSeump3QdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FH/d2lUso9eQ+2BopiArM/WG9gyXmsyA7jz1PolcjwdCD3P32EXkInXA2F/QxMl5OVTzhv8aafcFp2fymHX/irL/QuPaULUIn28QXFi8+1hc66NgZqwYe5WNDuSfPLWIsdgiMeoOROs5fkaVKTpUliXqbJ5f3fSLC059u0HALjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5a392946c4aso1078571137.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 23:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869877; x=1759474677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjQDtyvvVNH5A+YlQavoDIDNO01bRK+FCcEXT++J39I=;
        b=abOogFM9Xqcm0JmK21aBjlp/E/Aqm68Az3T4CZNfpl3QF4TKvTMWoSqgAnSGLCpOR3
         gNV7hx2y9riQCMCxLEBXr7xignGQmaA7pEL9BZU6QwUQXQyXphE14I9N0mUV42KEDjpy
         TNWDDplWO/JgG1YUEQOpdX6e3jwCOzB1qrkJnt31cIKzWmyU2ozTJITrZFeuavC9jxN6
         fCaH8AafOEwGhh+ab1uUR+NlkadAVWkT6X0LA9ZSYcS+SxSqmMAFhPh9MbzAOGDp4NAh
         vn6L6uj7XZ8rS+IXZkuql99KbhhxUxMJeIhyBnmFjULjGxX3j6bXlYKXqaLpoHVqnvPl
         BsTg==
X-Forwarded-Encrypted: i=1; AJvYcCXP6pa3SFy/hDKZk7Wq1x7FpII8bLrVyBtos56XmFzioYJ0ueVDF0x6YdeC9Dvwa3lKYh7Lyb+nHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1AlPyRM+V3O303WZJ7Jd1ldIqDsk3jKdlG2BmS2O3N9H3XeOl
	N/x4QRqNrfFLwdjrKXrMlOvZapaYfSb1UFTlaCNrLgVStkc8BAu+0XnxB4ngpE+q
X-Gm-Gg: ASbGncuokAQlw07mmT5mxfrUdUrwW8ZBXmPL/q5Lb8GmpSozV4L+rl8AAAoeD3E5DV3
	7wWD9uitTLr7XU+B6Qb5ge8fD7jhRP0uE2GGl5e/rK23dg37magB+WNoAABqdKMFTRdToV2UtAx
	pQpL9sZDBZjFoX3PEtDgfC8b5OVgGRnQP53pkO/E1T6wDbTIKTxG4nsxAsrfXKahzweQcNZ3ry8
	jb4WnTv34As/f2eSLCO55JrjcLO7Drw8DQCEfy4VuYryQysqGNGevFO8ZA6nUywZeuwdTCpl3Gw
	r/vSCH3CASEDmyZ+rzeEkpcBA/gH79OZDVOIcKLcpIsoI6yXH2TSDiVMnKKOyA+7C3NGW6mBqtz
	qPWB3WBI4adXjP2vGwnnNkuJMGcQDui3SqfzA3Nnagsd6y3Q3vS+4VwzmRKj1uYYBuaGnMyE=
X-Google-Smtp-Source: AGHT+IHpqnlxeqq7oAKg8O8gK8igKoLznjENTWqGc66//PoghSILrMw2COD7QuQyZkev9zblrpQhgA==
X-Received: by 2002:a05:6102:50a0:b0:592:b33e:3ba3 with SMTP id ada2fe7eead31-5acc4634c20mr2655832137.5.1758869876759;
        Thu, 25 Sep 2025 23:57:56 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae389dcefcsm1077262137.10.2025.09.25.23.57.56
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 23:57:56 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-59d576379b9so939706137.1
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 23:57:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfkUpMseoSCoMDMR+Q6yGRyG+O/nAke9XLgSQA2Unb2EgqKedK1Xm5H9wEGT1a+ZWLQPxidbdiFA==@vger.kernel.org
X-Received: by 2002:a05:6102:442c:b0:5a3:6a6f:21ad with SMTP id
 ada2fe7eead31-5acd0182a34mr2333473137.30.1758869876161; Thu, 25 Sep 2025
 23:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com>
 <CAMuHMdX1BacUfqtmV8g7NpRnY9aTdL=fh+jC7OryMLz4ijaOCg@mail.gmail.com>
 <CAPDyKFqANQZmGXd8ccA5qWiGrCor2N=W_7dmV+OK8hMd_+zmmw@mail.gmail.com>
 <CAMuHMdVrkr56XsRsbG7H-tLHVzmP+g-7=5Nrv9asC25ismwiYA@mail.gmail.com> <CAGETcx-L-KypYZEkdKRBfZHDhFMTUuwKEGVQ-7QPv=++6uwLSw@mail.gmail.com>
In-Reply-To: <CAGETcx-L-KypYZEkdKRBfZHDhFMTUuwKEGVQ-7QPv=++6uwLSw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Sep 2025 08:57:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWjhXjjw9wFw5Me-wAX0nA+gK2mdGxLyBJJCWDHZ58LeQ@mail.gmail.com>
X-Gm-Features: AS18NWD2sqCNW31Hr76xpW5m_kx80ye1q9D4_pFDoOhvkwDietXEmUuVKInRsEY
Message-ID: <CAMuHMdWjhXjjw9wFw5Me-wAX0nA+gK2mdGxLyBJJCWDHZ58LeQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
To: Saravana Kannan <saravanak@google.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

On Fri, 26 Sept 2025 at 00:41, Saravana Kannan <saravanak@google.com> wrote=
:
> On Thu, Aug 7, 2025 at 2:43=E2=80=AFAM Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:
> > On Wed, 30 Jul 2025 at 12:29, Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
> > > On Wed, 30 Jul 2025 at 11:56, Geert Uytterhoeven <geert@linux-m68k.or=
g> wrote:
> > > > BTW, the "pending due to"-messages look weird to me.
> > > > On R-Car M2-W (r8a7791.dtsi) I see e.g.:
> > > >
> > > >     genpd_provider ca15-cpu0: sync_state() pending due to e6020000.=
watchdog
> > > >     renesas-cpg-mssr e6150000.clock-controller: sync_state() pendin=
g
> > > > due to e6020000.watchdog
> > > >
> > > > ca15-cpu0 is the PM Domain holding the first CPU core, while
> > > > the watchdog resides in the always-on Clock Domain, and uses the
> > > > clock-controller for PM_CLK handling.
> >
> > Unfortunately the first PM Domain is "ca15-cpu0", which is blocked on
> > these bogus pending states, and no PM Domain is powered off.
>
> Can you explain why you call these as bogus? Sorry if you already
> explained it. But the reason I'm asking is to see if you can set a
> flag for the watchdog device so fw_devlink will completely ignore it.

"bogus" refers to "1." below.

Furthermore, devices that are located in an alway-on domain should
not block the sync state.

> It looks like there's a driver for this watchdog node? Why is it not
> probing then?

Because this particular revision of the SoC has a hardware bug that
prevents the watchdog timer from rebooting the system, and the driver
detects that.

Anyway, if the driver is not available, unused power domains should
still be powered down, like before.

> > If I remove the "sync_state =3D false" above, genpd_provider_sync_state=
()
> > considers all domains, and does power down all unused domains (even
> > multiple times, as expected).
> >
> > Upon closer look, all "pending due to" messages I see claim that the
> > first (index 0) PM Domain is pending on some devices, while all of
> > these devices are part of a different domain (usually the always-on
> > domain, which is always the last (32 or 64) on R-Car).
> >
> > So I think there are two issues:
> >   1. Devices are not attributed to the correct PM Domain using
> >      fw_devlink sync_state,
>
> Is it a fw_devlink issue? Or is this a multi-domain controller?

This is a multi-domain controller.

> >   2. One PM Domain of a multi-domain controller being blocked should
> >      not block all other domains handled by the same controller.
>
> This is going to take a while to sort out. But the current behavior is
> the safest. How grumpy will you be if we don't fix this :)

Depending on your definition of "safe".  Keeping all power domains on
increases power consumption and heat generation, and may cause e.g. CPU
frequency throttling to kick in, slowing down operation of the system.

Thanks!

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

