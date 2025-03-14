Return-Path: <linux-pm+bounces-24017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8518FA60EC6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 11:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B9F1696D9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 10:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9716D1F4611;
	Fri, 14 Mar 2025 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCyWJbMS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D91DF98D;
	Fri, 14 Mar 2025 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947931; cv=none; b=p1okLWfth4NHrg6If0rXUJKOHzMN2K67qitCAUNr2OTot6Xme9wNhPRug4MR5eTW2voIT+wgGft12JgRxM8ZOFlIQ7pENOIVBORR7rj/bpNdASOgA96UWVy+U4nXh4ZK0pppGXxjrr0JLnqVgM9UlaYPqCIOSpS/2UwAbjm3G+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947931; c=relaxed/simple;
	bh=AG/eNSTAyLb2lMhGDeMRh7SSv4P8ZWRc4mTh0oRA59E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUhIjs3R00IaWvG6zZUFjUNIauB6MYMg7ttAin5iLo0QEAKh2Xu4udTZdMTOmh/6cl9vPEFPu8wdQJCiPHktlrUKHuj3W0YYMemQUjbTIEGDQDNZKZBTwXxElZVCHycwWOulUrG1L64JB6LYxWWP87ORwouLRmJJC6CzSyy9xw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCyWJbMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5244C4CEE9;
	Fri, 14 Mar 2025 10:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741947930;
	bh=AG/eNSTAyLb2lMhGDeMRh7SSv4P8ZWRc4mTh0oRA59E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PCyWJbMSomAYqAPJAMQ5EgmkrmVpW6ezD6Prfkuw3Rhwl4J1jCCkgctGPWB8jnhVa
	 HH7hzQgIUCi+OY0vIJfRxCR/rQqLgLAJVM9TmQGbXdekhYsgUdoKBT5Td7Xrun6c2d
	 QaAc4iS3vxB0LUBEeBiqrZXgQLFRVvATCc5QBlKVVTe5QY37+7z26KaaF5PDhtNMD8
	 W1Fk6fM6VANuoPK4YVjLr9FOf7Ybox+YFuSJ8qHoAepjAkN+wE7GMV7ufQDiu2ihnF
	 iXiGIOAGTD4APU/SEQpG7HgoGUgg3XoICUTE/CXvcw8MAOE7L+x6SGSeUAQJprjTsH
	 Wjk3UI8by8FZw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2b38896c534so1033051fac.0;
        Fri, 14 Mar 2025 03:25:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU19nY6C6nCyqQn2KgF8QyO17zRd+c4iZn2KBrCk/jPsHBv7RpQ3x9fdU6JB5xtShCFRKZsO5ysVg==@vger.kernel.org, AJvYcCWpm+3hDIWWj2ESQh6atTU/wVLWUHe9Au5AvArwkWNtkAp3Z+MLs3cDtWcyxkYLH2/xnPjD5mYWKJEv/cI8R71bo2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwewG78Z7847u6tmktTrqkKWn99SX+ROJPPBEWHeLbPP2Ps+tqF
	TmrYbjOH6KWjiTZ3VWy7dbmXFCJ3FcqFpb+vELdwRHJnk6bWBRP2h9wgZpK53rkX7VgPyqUziEZ
	7NLhEDcCLcsDsHJT+Y0ikUAohPQA=
X-Google-Smtp-Source: AGHT+IE4RCxh38i4rnA0o53HFt+7tZoe11FwhRuyFgknmrPg1GJtTDJSY8/eP6jePQJHW8SjndG8GBzf9ukIf5lISOw=
X-Received: by 2002:a05:6870:8087:b0:29e:3d0b:834 with SMTP id
 586e51a60fabf-2c690f1be5bmr1046732fac.5.1741947930172; Fri, 14 Mar 2025
 03:25:30 -0700 (PDT)
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
 <CAMuHMdXcJN5M7PqJ1eABOOCfeMjvs51rMRzMxU=d2L=3LVgh_w@mail.gmail.com>
 <CAJZ5v0jKOeZxzUXu9bHA4=SDio1FT3ZmfoOGqNNZO2+DN+U21Q@mail.gmail.com>
 <CAJZ5v0iJqUGX8cL2ZEm3420VMP0nWY2rPwCNsLLCs+sCaDDtbQ@mail.gmail.com> <CAMuHMdVTbf60gk-sfyHME6Xi_9wiW_VNvgsH0+Uy54WWpg4jiw@mail.gmail.com>
In-Reply-To: <CAMuHMdVTbf60gk-sfyHME6Xi_9wiW_VNvgsH0+Uy54WWpg4jiw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Mar 2025 11:25:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hE+4-MRWUm54=nN33naY7VYCxFun6cH3bTKR=KUtG48Q@mail.gmail.com>
X-Gm-Features: AQ5f1JpQyzTnLmCCX37pTTgCDB6y7WftTXrB91pYLhvS5Hi971mFy0KLi5UJuOk
Message-ID: <CAJZ5v0hE+4-MRWUm54=nN33naY7VYCxFun6cH3bTKR=KUtG48Q@mail.gmail.com>
Subject: Re: s2idle blocked on dev->power.completion
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
	Linux PM list <linux-pm@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Fri, Mar 14, 2025 at 10:05=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Rafael,
>
> On Thu, 13 Mar 2025 at 18:35, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> > On Thu, Mar 13, 2025 at 6:27=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > > On Thu, Mar 13, 2025 at 5:48=E2=80=AFPM Geert Uytterhoeven <geert@lin=
ux-m68k.org> wrote:
> > > > On Thu, 13 Mar 2025 at 15:32, Geert Uytterhoeven <geert@linux-m68k.=
org> wrote:
> > > > > On Thu, 13 Feb 2025 at 11:26, Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> > > > > > On Thu, 13 Feb 2025 at 09:31, Saravana Kannan <saravanak@google=
.com> wrote:
> > > > > > > On Mon, Feb 10, 2025 at 2:24=E2=80=AFAM Geert Uytterhoeven <g=
eert@linux-m68k.org> wrote:
> > > > > > > > On Fri, 7 Feb 2025 at 16:08, Geert Uytterhoeven <geert@linu=
x-m68k.org> wrote:
> > > > > > > > > Instrumenting all dev->power.completion accesses in
> > > > > > > > > drivers/base/power/main.c reveals that resume is blocked =
in dpm_wait()
> > > > > > > > > in the call to wait_for_completion() for regulator-1p2v, =
which is
> > > > > > > > > indeed a dependency for the SN65DSI86 DSI-DP bridge.  Com=
paring
> > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > > > Looking at /sys/devices/virtual/devlink, the non-working =
case has the
> > > > > > > > > following extra entries:
> > > > > > > >
> > > > > > > > Note that the SN65DSI86 DSI-DP bridge driver uses the auxil=
iary bus
> > > > > > > > to create four subdevices:
> > > > > > > >   - ti_sn65dsi86.aux.0,
> > > > > > > >   - ti_sn65dsi86.bridge.0,
> > > > > > > >   - ti_sn65dsi86.gpio.0,
> > > > > > > >   - ti_sn65dsi86.pwm.0.
> > > > > > > > None of them have supplier:* symlinks in sysfs, so perhaps =
that is
> > > > > > > > the root cause of the issue?
> > > > > > >
> > > > > > > Sorry, I haven't had time to look into this closely. Couple o=
f
> > > > > > > questions/suggestions that might give you some answers.
> > > > > > >
> > > > > > > Is this an issue only happening for s2idle or for s2ram too? =
I'd guess
> > > > > > > both, but if not, that might tell you something?
> > > > > >
> > > > > > The two (very similar) boards I could reproduce the issue on do=
 not
> > > > > > support s2ram yet.
> > > > > >
> > > > > > > The only reason the wait_for_completion() wouldn't work is be=
cause the
> > > > > > > supplier is not "completing"?
> > > > > >
> > > > > > Yes, the diff shows ca. 70 additional calls to "complete_all()"=
 in the
> > > > > > good case.
> > > >
> > > > >   4. When the issue happens, /sys/devices/virtual/devlink shows 3
> > > > >      more links:
> > > > >        A. platform:feb00000.display is a supplier of platform:fed=
80000.dsi-encoder
> > > > >        B. platform:fed80000.dsi-encoder is a supplier of platform=
:feb00000.display
> > > >
> > > > Their status file report "dormant".
> > > >
> > > > >        C. i2c:1-002c is a supplier of platform:fed80000.dsi-encod=
er
> > > >
> > > > Its status file reports "available".
> > > >
> > > > >   5. What happens in dpm_noirq_resume_devices()?
> > > > >
> > > > >        /*
> > > > >         * Trigger the resume of "async" devices upfront so they d=
on't have to
> > > > >         * wait for the "non-async" ones they don't depend on.
> > > > >         */
> > > > >         i2c-1 (i2c bus) and 1-002c (bridge device) are async,
> > > > >         thus triggered first.
> > > > >         After that, the remaining devices are resumed.
> > > > >
> > > > >      In the bad case:
> > > > >
> > > > >        device_resume_noirq(fed80000.dsi-encoder, async=3Dfalse)
> > > > >          dpm_wait_for_superior()
> > > > >            parent soc: skipping wait_for_completion()
> > > > >            dpm_wait_for_suppliers()
> > > > >              supplier feb00000.display: skipped, DL_STATE_DORMANT
> > > > >              ^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > Cfr. extra link A above (harmless)
> > > > >
> > > > >              supplier e6150000.clock-controller: skipping wait_fo=
r_completion()
> > > > >              supplier 1-002c: wait_for_completion() =3D> BLOCKED
> > > > >              ^^^^^^^^^^^^^^^
> > > > > Cfr. extra link C above, but the bridge device hasn't been resume=
d yet.
> > > >
> > > > Changing the test for "DL_STATE_DORMANT"[1] in dpm_wait_for_supplie=
rs()
> > > > to also include "DL_STATE_AVAILABLE" makes it skip supplier 1-002c,
> > > > and fixes the issue.  Does that make sense?
> > >
> > > Good question.
> > >
> > > DL_STATE_AVAILABLE essentially means that the consumer hasn't been
> > > probed yet, but it doesn't mean that it can be suspended before its
> > > supplier.
> >
> > I really meant "resumed before its supplier", sorry for the confusion.
> >
> > Generally speaking, suppliers need to be resumed first regardless of
> > the status of the consumers.
>
> Exactly, and that's being violated here.
> Before resume, dpm_noirq_list contains:
>      [...]
>    - fed80000.dsi-encoder
>      [...]
>    - regulator-1p2v
>      [...]
>    - 1-002c
> which is the order in which devices are to be resumed.
>
> regulator-1p2v is a supplier of 1-002c: OK.
> 1-002c is a supplier of fed80000.dsi-encoder: NG.
>
> As devices are resumed in the inverse order they have been suspended
> before, suspend order is also wrong.  Hence checking also for
> DL_STATE_AVAILABLE would just fix the symptom, and not the cause, right?

Right.

