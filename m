Return-Path: <linux-pm+bounces-17407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD1D9C57C1
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 13:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48D81F22705
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9891CD1FF;
	Tue, 12 Nov 2024 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXa3YGZ9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19821591F0;
	Tue, 12 Nov 2024 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414641; cv=none; b=s00LdndhzLFUT+7nr488dbMZqxYmvjjSGkkarVAs3UuNZIBo3xkOlAvmdmx3ZUjHBbrXvNo2GAl2KChvYsdXtQfjQPTgaH8XHkQC5ef+tDuTEqy4yX07Hb/D9hVtWW/ZOENUUlHNLBj/A3ThMwzlOmuKc62Q9wXT9TQC6HRqFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414641; c=relaxed/simple;
	bh=K6Dr3DZqEZ782kmjrEis62LDeTz0JIo7DNxCv/hKvqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIQQAA+NQ/bg0X+s7eakWiA/JhdOJDH4LnbbtCzZ+VXap7hk13BJ4Y7RC+HFp0OyO8y5JIpLSc/ri9wN2u/ORDei1DiEN/6IjBq+21vWn+4JkBO7KoiCxr6TM4Oi6YAqZWY7bskC+H0l0lla7ErYgAdhtrDHi5xYZqRSQi5oEsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXa3YGZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEF4C4CED5;
	Tue, 12 Nov 2024 12:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731414641;
	bh=K6Dr3DZqEZ782kmjrEis62LDeTz0JIo7DNxCv/hKvqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hXa3YGZ9dR2+1f6FCtTJSjt9ISZ9dhkKKDSsPJfO1OaEYqclMYMmBzpA49vEv/UpL
	 ZT8gKs5yV4BYInZXZloZfF4SzisT70RZlubd8IvfIDRublyWYLehLid1Ju1xHiIiYc
	 foJC2O5pWfDJER2VMZlEMDIL0O4shRT/1ekdF3SziuhrnzEsPDzAefkujR9ic1EGEg
	 VOmY5sp/Grk3QkDWW5Fgo5TBOl7/P7Ob0P9PhC96HOu01NVkonYF9bJZ0v0WeMMo9y
	 OoGsXbMETc6FNcLarshtXHEzXNDoHRO7yREGdOHM6QZfOgQ+F5KQI0eQX1VgZvualh
	 eIvDtvhPguUZw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-290ff24354dso2467517fac.0;
        Tue, 12 Nov 2024 04:30:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1Vnx9+5a3isqptdFLwWqZ5BsvCnbxo0Nt3biUrzYOqoUrt1414XtTWJA8vTBNe81PjypHuDOPM1BM4H0=@vger.kernel.org, AJvYcCUW3CbFQPCjnBuGRNlCNRx1AWSdomfX+/3PZ7avflFhfX7JsHRVo/CL+zRYvJfiVFiIJ1JrZTFZLWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTntMZuCfqvLd34+ycMuQaL1TrlJkUm1++yhIvr95yw9WqrWat
	b3WTimIPhALQpu3NtsdmyXMYxwOO6v9H5gQzYdmrn338yJhLyv4Zfo67HTBlxaw1zT/QPXnlWjF
	3sP/atMeqAyVqvND16J9bnxe46GE=
X-Google-Smtp-Source: AGHT+IHoAB+gqnV2MrGVPi3KTzsa88+X+L2vVRUSftu+5gpdSmntzoRnIuDGayV1g9aN+QDEKILfaxK1oq2l5r9D63M=
X-Received: by 2002:a05:6870:8294:b0:288:5c55:dfd5 with SMTP id
 586e51a60fabf-2956036bb08mr13538264fac.31.1731414640537; Tue, 12 Nov 2024
 04:30:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com> <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0ivAk1xrcJgiJnDWnL3GdijSdsuV4K_4ORjnsjPUVAEnA@mail.gmail.com> <20241112121843.GF6497@noisy.programming.kicks-ass.net>
In-Reply-To: <20241112121843.GF6497@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 13:30:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iSP4Gh2FwKdkOw20N4hzwQ94+WmnT+3EY94QG3gORWzA@mail.gmail.com>
Message-ID: <CAJZ5v0iSP4Gh2FwKdkOw20N4hzwQ94+WmnT+3EY94QG3gORWzA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 1:18=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Nov 12, 2024 at 01:03:49PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 12, 2024 at 12:47=E2=80=AFPM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
> > >
> > > On Fri, Nov 08, 2024 at 01:29:08PM +0100, Patryk Wlazlyn wrote:
> > > > The generic implementation, based on cpuid leaf 0x5, for looking up=
 the
> > > > mwait hint for the deepest cstate, depends on them to be continuous=
 in
> > > > range [0, NUM_SUBSTATES-1]. While that is correct on most Intel x86
> > > > platforms, it is not architectural and may not result in reaching t=
he
> > > > most optimized idle state on some of them.
> > > >
> > > > Prefer cpuidle_play_dead() over the generic mwait_play_dead() loop =
and
> > > > fallback to the later in case of missing enter_dead() handler.
> > > >
> > > > Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> > > > ---
> > > >  arch/x86/kernel/smpboot.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > > > index 44c40781bad6..721bb931181c 100644
> > > > --- a/arch/x86/kernel/smpboot.c
> > > > +++ b/arch/x86/kernel/smpboot.c
> > > > @@ -1416,9 +1416,9 @@ void native_play_dead(void)
> > > >       play_dead_common();
> > > >       tboot_shutdown(TB_SHUTDOWN_WFS);
> > > >
> > > > -     mwait_play_dead();
> > > >       if (cpuidle_play_dead())
> > > > -             hlt_play_dead();
> > > > +             mwait_play_dead();
> > > > +     hlt_play_dead();
> > > >  }
> > >
> > > Yeah, I don't think so. we don't want to accidentally hit
> > > acpi_idle_play_dead().
> >
> > Fair enough.
> >
> > Then we are back to the original approach though:
> >
> > https://lore.kernel.org/linux-pm/20241029101507.7188-3-patryk.wlazlyn@l=
inux.intel.com/
>
> Well, that won't be brilliant for hybrid systems where the available
> states are different per CPU.

But they aren't.

At least so far that has not been the case on any platform known to me
and I'm not aware of any plans to make that happen (guess what, some
other OSes may be unhappy).

> Also, all of this is a bit of a trainwreck... AFAICT AMD wants IO based
> idle (per the 2018 commit). So they want the ACPI thing.

Yes.

> But on Intel we really don't want HLT, and had that MWAIT, but that has
> real problems with KEXEC. And I don't think we can rely on INTEL_IDLE=3Dy=
.

We could because it handles ACPI now and ACPI idle doesn't add any
value on top of it except for the IO-based idle case.

> The ACPI thing doesn't support FFh states for it's enter_dead(), should i=
t?

It does AFAICS, but the FFH is still MWAIT.

> Anyway, ideally x86 would grow a new instruction to offline a CPU, both
> MWAIT and HLT have problems vs non-maskable interrupts.
>
> I really don't know what is best here, maybe moving that whole CPUID
> loop to boot, store the value in a per-cpu mwait_play_dead_hint. Have
> AMD explicitly clear the value, and avoid mwait when 0 -- hint 0 is
> equal to HLT anyway.
>
> But as said, we need a new instruction.

Before that, there is the problem with the MWAIT hint computation in
mwait_play_dead() and in fact intel_idle does know what hint to use in
there.

