Return-Path: <linux-pm+bounces-17408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DD99C5933
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 14:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15516B27C00
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D101F77A8;
	Tue, 12 Nov 2024 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyxhwPY8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDAA1CD21F;
	Tue, 12 Nov 2024 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415144; cv=none; b=T0id25RWJ3qUVb41ls1T8pC4FdB9Ks9NsDTBTfnol4FBgUWSyip+VtwlxnUJxYCdHZ0D/1yeVIDX0o19UPfU7c7eMkcIhvgIUx+pX5daWNdNHidUhv1y1PXaECV+5I1oNg/GwX0ZMTv9TyzjSP/b04ka8Eg1PZJ3jBbeG+evtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415144; c=relaxed/simple;
	bh=N4/8wlm1eng4Hy8SQIOja9o8TBOWCC1rA9dzCmeq74g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFpO4n4lVXoZnrDYX71lxelX9VfRQbSbUS2YyTbV9RdjKiD3X+QH4pXYAYGwJcgsnTfIiVVFUKSyjrdEds46GnjHP0Ba1es5ccdiOlf7di4uhZhqT00h1XQQlQYB5nhdFyDmJtD2b3T6XGqSnqbbwU8xRhO7W+L5rhQ94AA+UBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyxhwPY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227A2C4CED8;
	Tue, 12 Nov 2024 12:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731415144;
	bh=N4/8wlm1eng4Hy8SQIOja9o8TBOWCC1rA9dzCmeq74g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZyxhwPY8wTWIGmakAwH9963GxTWVQi/wuv/wl+1aoMxh+4nPM5gF5H4YTbF9K8hHw
	 vRhVNNnz1I+FvWzV9obecxUivnXyGid/dIdtIYCTzRrhsRKPDXNG+0WzYXjICwxC4b
	 Q4a7ZcsGml2vJL0M8USI+ZLaUNLInoD4tvZHeCv6dO+ByGf0dlAdJ/VGs47+5Y83Qq
	 nF5b+hpNg9d3QWbx1+0IXrDFgyWuyh2aVzlKYAS5hep4eBXbuJt5/nCsekN0BrC+b7
	 pDhelYa+I6VFWwhaRLqBjHxltU5A4we7BYomQEnaM2CFQ+01GTbtf4ElXAYB6AieRK
	 DWpH1/3hVSi+Q==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ee461f5dedso3143712eaf.0;
        Tue, 12 Nov 2024 04:39:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULOkD8VrFlJRJxo90NxMwTxU/lxowcsO9FawKvN+N3k6qArO9ERhj1s7/4fnP4XInATnuz/r11cuDPcuc=@vger.kernel.org, AJvYcCXDjAY+NxhrcXF3IW7ZK7Nvfyn4UJ/l3g31CVnhQtpdEID74709b9jnKGcYa1Hyj4Xxui+hvJJ/VdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0HpVNeQfyi1Ihv+2lPPmz249fiAKo2kJjogle33CGMp0u4NyI
	WKjC7yfyfW4INjUYZ5OExFO8G7a/sthaLHNsdb4o5h+FQ3bBf5aMR4M9vsxHv0pxx0OutWZ43re
	Is/sTNv/rUrXIARm/pTvY9rJqI8s=
X-Google-Smtp-Source: AGHT+IEJD2mJ4ekhgu15efydIEY2Qgss3Lswcq7pE79TnMQBE7sDvGH7u4UtNrfv/HETCyJ9xUMUXQM5Wl6biQNwiSs=
X-Received: by 2002:a05:6820:1a0e:b0:5ee:bb2:bdc3 with SMTP id
 006d021491bc7-5ee57ba8dbfmr10710801eaf.2.1731415143440; Tue, 12 Nov 2024
 04:39:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com> <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0ivAk1xrcJgiJnDWnL3GdijSdsuV4K_4ORjnsjPUVAEnA@mail.gmail.com>
 <20241112121843.GF6497@noisy.programming.kicks-ass.net> <CAJZ5v0iSP4Gh2FwKdkOw20N4hzwQ94+WmnT+3EY94QG3gORWzA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iSP4Gh2FwKdkOw20N4hzwQ94+WmnT+3EY94QG3gORWzA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 13:38:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gUxbm7hw8c56yo7V7d49aob7FLOsRYf6fa40-4FtYiGw@mail.gmail.com>
Message-ID: <CAJZ5v0gUxbm7hw8c56yo7V7d49aob7FLOsRYf6fa40-4FtYiGw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 1:30=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Nov 12, 2024 at 1:18=E2=80=AFPM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Tue, Nov 12, 2024 at 01:03:49PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Nov 12, 2024 at 12:47=E2=80=AFPM Peter Zijlstra <peterz@infra=
dead.org> wrote:
> > > >
> > > > On Fri, Nov 08, 2024 at 01:29:08PM +0100, Patryk Wlazlyn wrote:
> > > > > The generic implementation, based on cpuid leaf 0x5, for looking =
up the
> > > > > mwait hint for the deepest cstate, depends on them to be continuo=
us in
> > > > > range [0, NUM_SUBSTATES-1]. While that is correct on most Intel x=
86
> > > > > platforms, it is not architectural and may not result in reaching=
 the
> > > > > most optimized idle state on some of them.
> > > > >
> > > > > Prefer cpuidle_play_dead() over the generic mwait_play_dead() loo=
p and
> > > > > fallback to the later in case of missing enter_dead() handler.
> > > > >
> > > > > Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> > > > > ---
> > > > >  arch/x86/kernel/smpboot.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.=
c
> > > > > index 44c40781bad6..721bb931181c 100644
> > > > > --- a/arch/x86/kernel/smpboot.c
> > > > > +++ b/arch/x86/kernel/smpboot.c
> > > > > @@ -1416,9 +1416,9 @@ void native_play_dead(void)
> > > > >       play_dead_common();
> > > > >       tboot_shutdown(TB_SHUTDOWN_WFS);
> > > > >
> > > > > -     mwait_play_dead();
> > > > >       if (cpuidle_play_dead())
> > > > > -             hlt_play_dead();
> > > > > +             mwait_play_dead();
> > > > > +     hlt_play_dead();
> > > > >  }
> > > >
> > > > Yeah, I don't think so. we don't want to accidentally hit
> > > > acpi_idle_play_dead().
> > >
> > > Fair enough.
> > >
> > > Then we are back to the original approach though:
> > >
> > > https://lore.kernel.org/linux-pm/20241029101507.7188-3-patryk.wlazlyn=
@linux.intel.com/
> >
> > Well, that won't be brilliant for hybrid systems where the available
> > states are different per CPU.
>
> But they aren't.
>
> At least so far that has not been the case on any platform known to me
> and I'm not aware of any plans to make that happen (guess what, some
> other OSes may be unhappy).
>
> > Also, all of this is a bit of a trainwreck... AFAICT AMD wants IO based
> > idle (per the 2018 commit). So they want the ACPI thing.
>
> Yes.
>
> > But on Intel we really don't want HLT, and had that MWAIT, but that has
> > real problems with KEXEC. And I don't think we can rely on INTEL_IDLE=
=3Dy.
>
> We could because it handles ACPI now and ACPI idle doesn't add any
> value on top of it except for the IO-based idle case.
>
> > The ACPI thing doesn't support FFh states for it's enter_dead(), should=
 it?
>
> It does AFAICS, but the FFH is still MWAIT.

Sorry, no, it doesn't.

It might I guess, but it would have been dead code in the vast
majority of configurations in the field.

