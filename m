Return-Path: <linux-pm+bounces-23992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E54B6A5FDDE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 18:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3A53B3719
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 17:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E2D18A6CE;
	Thu, 13 Mar 2025 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2PumhKT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD5A172767;
	Thu, 13 Mar 2025 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887301; cv=none; b=uLSUFT2ZuiOWOkI9mzl/VKqP9il2/8vX4vGAWM5rzo8CwtZhAUjMm9BZKXK7tj4ndVt1oIdVq/myR5KQsJxhLFLGrim3C+1n4fPhRXHQBmVSWXybrJPzg46czmkOJEFw8KoaA6az92KejLbd1Io26JGj95un9Fr/jdYMuC+FNeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887301; c=relaxed/simple;
	bh=J2z8NcjRoOgH8VIXKNgR5zahQp8ngHOxIFhmvl2oblc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/db2EpyqluCQzOxstWFkSLaYec7LCQEqS4Cmw0L34Z1b20wysdMxSdVzdRyKWeGOkcAv9Oycrg0NBH2246duyPwI+gamXQ8cFxsFHSU1QmhfMe8ftYnaKNYBoFnEQXtiD3logkf5p+cwDgiO209LoujM6M/tgM4MpKvxyWxQkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2PumhKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96212C4CEEE;
	Thu, 13 Mar 2025 17:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741887300;
	bh=J2z8NcjRoOgH8VIXKNgR5zahQp8ngHOxIFhmvl2oblc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X2PumhKTwbNsNJdK+ya8mgw+MrwaBuVrOhW3DHMq48RcUBzTw6qHZqg4yi1AA62Xf
	 EyP6WlrdtAG+R7L3EyWye/XFZIft4jO7ancUXgF2g41dX25xcC2K0G5/+x8i7clFhe
	 MUcsA1PYGCXjfaz5iiXGfj6kgWfGMAfLDosEZYceylZyiG6eZg70dyMlDLG9zWMs+/
	 cwK9M2YJ5rwVgJAKMWRfn2sOcjs79fem+o6SXKbZjs0o6va9j04syHqrOSSLALASbX
	 QxaPRwMehB4n2QVXP+DMsZSkRyzp/iCdkG/918VzoTzQkjepJq+0Q//kNooF911l9V
	 CRfmVJTJIAFuQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2c186270230so430233fac.0;
        Thu, 13 Mar 2025 10:35:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGnnyu/SqTi4fs/4PUIUrbOUI3Ik2fQ9EbXhFehDUkgwnzRDJkwLNrwzHpGfkqfhLqfHcw6OOT66gJeJQVQuazNGE=@vger.kernel.org, AJvYcCUZ8MLFx4g4KViLSgpDcomKTpFOcTDFBGYx63SHFlNjVzenc4DZdoi32TBNVSUwD70/g6JKBzdzbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBYeC0Wc3RuHiDZ/G0EjaoVNN/rb4DhxhuDCJzAxpRYuFk5Toy
	OEQjgT34S51RfAMoIUcVZozN4L2iIlHLyBuj+1oscHiO8NYtHxNtw8gmM0IQvducsdHHkUgtlL3
	r/v9f3uNqQCt+oxRH0izWDOPB+dE=
X-Google-Smtp-Source: AGHT+IGdRRu31wT7cGzromNnacu6XOMN7ZeMhxmjoohMDhJ24RU+xVzR1A+jnvmEyhoFHXC6lCWG1Fk16dtC7NZki6A=
X-Received: by 2002:a05:6871:714:b0:2c1:62e9:584b with SMTP id
 586e51a60fabf-2c2e89df055mr6545781fac.39.1741887299835; Thu, 13 Mar 2025
 10:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdXN9A-1P_qe=BwKjLaoqxU8iJUQK6h8=s-apR4Y0em_0Q@mail.gmail.com>
 <CAMuHMdXXWH0Do5zXWJ1Uc6dyEb9o1chGSyeyzgDrX+v1wZ7e_A@mail.gmail.com>
 <CAGETcx_wA9RB9QhMPqsLHDFZ4cwOFgE8dBL9ssFkT=J6DEgjGg@mail.gmail.com>
 <CAMuHMdUCXJkg3rkngXf7cqa50u-TEAOntV6O=Nvg33Q9diPJPw@mail.gmail.com>
 <CAMuHMdWLEHwjaNnysDZ_Unqj-SwmUdwRao_oJvYvVsQ9SCn06A@mail.gmail.com>
 <CAMuHMdXcJN5M7PqJ1eABOOCfeMjvs51rMRzMxU=d2L=3LVgh_w@mail.gmail.com> <CAJZ5v0jKOeZxzUXu9bHA4=SDio1FT3ZmfoOGqNNZO2+DN+U21Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jKOeZxzUXu9bHA4=SDio1FT3ZmfoOGqNNZO2+DN+U21Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Mar 2025 18:34:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iJqUGX8cL2ZEm3420VMP0nWY2rPwCNsLLCs+sCaDDtbQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jo4DwIGZ5MbS8se1x-el_NOl_6RZN4URqJSPcs5HUxdRGrYR1iZwI2wtak
Message-ID: <CAJZ5v0iJqUGX8cL2ZEm3420VMP0nWY2rPwCNsLLCs+sCaDDtbQ@mail.gmail.com>
Subject: Re: s2idle blocked on dev->power.completion
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Saravana Kannan <saravanak@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
	Linux PM list <linux-pm@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 6:27=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi Geert,
>
> On Thu, Mar 13, 2025 at 5:48=E2=80=AFPM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> >
> > Hi Saravana,
> >
> > On Thu, 13 Mar 2025 at 15:32, Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
> > > On Thu, 13 Feb 2025 at 11:26, Geert Uytterhoeven <geert@linux-m68k.or=
g> wrote:
> > > > On Thu, 13 Feb 2025 at 09:31, Saravana Kannan <saravanak@google.com=
> wrote:
> > > > > On Mon, Feb 10, 2025 at 2:24=E2=80=AFAM Geert Uytterhoeven <geert=
@linux-m68k.org> wrote:
> > > > > > On Fri, 7 Feb 2025 at 16:08, Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:
> > > > > > > Instrumenting all dev->power.completion accesses in
> > > > > > > drivers/base/power/main.c reveals that resume is blocked in d=
pm_wait()
> > > > > > > in the call to wait_for_completion() for regulator-1p2v, whic=
h is
> > > > > > > indeed a dependency for the SN65DSI86 DSI-DP bridge.  Compari=
ng
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > Looking at /sys/devices/virtual/devlink, the non-working case=
 has the
> > > > > > > following extra entries:
> > > > > >
> > > > > > Note that the SN65DSI86 DSI-DP bridge driver uses the auxiliary=
 bus
> > > > > > to create four subdevices:
> > > > > >   - ti_sn65dsi86.aux.0,
> > > > > >   - ti_sn65dsi86.bridge.0,
> > > > > >   - ti_sn65dsi86.gpio.0,
> > > > > >   - ti_sn65dsi86.pwm.0.
> > > > > > None of them have supplier:* symlinks in sysfs, so perhaps that=
 is
> > > > > > the root cause of the issue?
> > > > >
> > > > > Sorry, I haven't had time to look into this closely. Couple of
> > > > > questions/suggestions that might give you some answers.
> > > > >
> > > > > Is this an issue only happening for s2idle or for s2ram too? I'd =
guess
> > > > > both, but if not, that might tell you something?
> > > >
> > > > The two (very similar) boards I could reproduce the issue on do not
> > > > support s2ram yet.
> > > >
> > > > > The only reason the wait_for_completion() wouldn't work is becaus=
e the
> > > > > supplier is not "completing"?
> > > >
> > > > Yes, the diff shows ca. 70 additional calls to "complete_all()" in =
the
> > > > good case.
> >
> > >   4. When the issue happens, /sys/devices/virtual/devlink shows 3
> > >      more links:
> > >        A. platform:feb00000.display is a supplier of platform:fed8000=
0.dsi-encoder
> > >        B. platform:fed80000.dsi-encoder is a supplier of platform:feb=
00000.display
> >
> > Their status file report "dormant".
> >
> > >        C. i2c:1-002c is a supplier of platform:fed80000.dsi-encoder
> >
> > Its status file reports "available".
> >
> > >   5. What happens in dpm_noirq_resume_devices()?
> > >
> > >        /*
> > >         * Trigger the resume of "async" devices upfront so they don't=
 have to
> > >         * wait for the "non-async" ones they don't depend on.
> > >         */
> > >         i2c-1 (i2c bus) and 1-002c (bridge device) are async,
> > >         thus triggered first.
> > >         After that, the remaining devices are resumed.
> > >
> > >      In the bad case:
> > >
> > >        device_resume_noirq(fed80000.dsi-encoder, async=3Dfalse)
> > >          dpm_wait_for_superior()
> > >            parent soc: skipping wait_for_completion()
> > >            dpm_wait_for_suppliers()
> > >              supplier feb00000.display: skipped, DL_STATE_DORMANT
> > >              ^^^^^^^^^^^^^^^^^^^^^^^^^
> > > Cfr. extra link A above (harmless)
> > >
> > >              supplier e6150000.clock-controller: skipping wait_for_co=
mpletion()
> > >              supplier 1-002c: wait_for_completion() =3D> BLOCKED
> > >              ^^^^^^^^^^^^^^^
> > > Cfr. extra link C above, but the bridge device hasn't been resumed ye=
t.
> >
> > Changing the test for "DL_STATE_DORMANT"[1] in dpm_wait_for_suppliers()
> > to also include "DL_STATE_AVAILABLE" makes it skip supplier 1-002c,
> > and fixes the issue.  Does that make sense?
>
> Good question.
>
> DL_STATE_AVAILABLE essentially means that the consumer hasn't been
> probed yet, but it doesn't mean that it can be suspended before its
> supplier.

I really meant "resumed before its supplier", sorry for the confusion.

Generally speaking, suppliers need to be resumed first regardless of
the status of the consumers.

Also, adding a device link between two devices by itself cannot create
a deadlock unless it goes against some other dependency.

