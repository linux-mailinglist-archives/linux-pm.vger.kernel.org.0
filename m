Return-Path: <linux-pm+bounces-17421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA009C5B3A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 16:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E99E1F23534
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDD81FF7A8;
	Tue, 12 Nov 2024 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZzPj0Lo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B301FF056;
	Tue, 12 Nov 2024 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423633; cv=none; b=lFngVt+MhRMDMV6wnqCN39+Ci/DndWyUd6HusTqcD9oGch0VAAJ9rSPikOqHvL81qh7KOqYisHsINq05jnR+iVYY4lk6NZIM6G+99XLMPS9WRcipX2WuarNajYkqTLLXqu/iQydTw6QAJdA0dNqyH6DK4rtAp0mq9mQcKeTQA94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423633; c=relaxed/simple;
	bh=p116ZlWcJSC5OBPJgPS9UqyA/VfRXQ1FZ2hqv5Zijjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgwmS5oCxuDTQf6/eFCbi5O7Xm7xVmJkR9jM84OYBLAwPgVJ7sfpbgNJ8ov6sHCBrxjOxmJKwoXqpTJt/xFkxQouogpM0gIi7IDNev8cv8I/1l82P2QMWx+MnFgV1iqAj9fmvwknrRFefxUUCRdSAKGT4qUlP9Q/r1Uw8dlNLmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZzPj0Lo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5FFC4CED0;
	Tue, 12 Nov 2024 15:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423633;
	bh=p116ZlWcJSC5OBPJgPS9UqyA/VfRXQ1FZ2hqv5Zijjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UZzPj0LosGFBGATy/AEsLHE97zJ+8eMiIhBd0apa3Nk0BNbSPO5OTDjHz/k8Ri0fw
	 iCcEwPxjmHeD5ZgfCW2zHPZhSYEyCx3cUQovJfLElNSgV1xUZxEzTvsDMjqwAewCy9
	 18MpzjmY7A5V0DtOWML20xHDH9va2GLbnH+kHM5N6t2MyS+mgjx07/HzSMz4AV+3dB
	 XF71WkLvnm5qHwSAuKBXV1yyg6DfVAN+ak54MnbPOCVWOEyWCSm3ujBTFZ3rJsNVcV
	 be8vyjiVRQfJDzVnRxbhVgYLuPgHP3GW8jdr/d7J78eeDJal8nvkObdM+gcFkvyYPd
	 7HAPHKbWR/xPw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-29538198f2fso2851645fac.1;
        Tue, 12 Nov 2024 07:00:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0EL4C+NQnxjV74LrWoBaCbp6zth8Rihdhm10RL5HEcM1NGOV/uaUULfoGS9igmLQRbHLGr09DHfw=@vger.kernel.org, AJvYcCVjbSMdg0J70dmIoVTggYNgW4cfN0/bddGDThJ4O4bk3ErhC+MAt8AFv05yV5RQ2QEvZvpIHnnwtOIMyBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYXD7nZ29CesasctRSUVZwm5doPWiVPaiNG+UBKecATvfFyX6W
	+7lKHVq8VrMmmYjBssMrXHzggjHBelUkagXDOozscDj5MhHlN5I2TNgkkJWlmX5xE7cpF+Y1UoN
	BNbGKEotpWTHOgRWALYvZFp8S1S0=
X-Google-Smtp-Source: AGHT+IFI9GNg7IPdb2tePq/0unuINTg3s7VcqoQ9tRcOl9CoW/yGaLJ9bgvFxb+V6AJAIqz7HyZNKKpxsm54qwn9ze4=
X-Received: by 2002:a05:6870:46a3:b0:26f:f1ea:6a71 with SMTP id
 586e51a60fabf-295600992d4mr13179732fac.7.1731423632299; Tue, 12 Nov 2024
 07:00:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com> <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com> <20241112145618.GR22801@noisy.programming.kicks-ass.net>
In-Reply-To: <20241112145618.GR22801@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 16:00:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ihEvOuUWoN++5qYx=KqrRnm4np7_j6hDd=aFnHkkFYZg@mail.gmail.com>
Message-ID: <CAJZ5v0ihEvOuUWoN++5qYx=KqrRnm4np7_j6hDd=aFnHkkFYZg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 3:56=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Nov 12, 2024 at 02:23:14PM +0100, Rafael J. Wysocki wrote:
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
> > Having inspected the code once again, I'm not sure what your concern is=
.
> >
> > :enter.dead() is set to acpi_idle_play_dead() for all states in ACPI
> > idle - see acpi_processor_setup_cstates() and the role of the type
> > check is to filter out bogus table entries (the "type" must be 1, 2,
> > or 3 as per the spec).
> >
> > Then cpuidle_play_dead() calls drv->states[i].enter_dead() for the
> > deepest state where it is set and if this is FFH,
> > acpi_idle_play_dead() will return an error.  So after the change, the
> > code above will fall back to mwait_play_dead() then.
> >
> > Or am I missing anything?
>
> So it relies on there being a C2/C3 state enumerated and that being FFh.
> Otherwise it will find a 'working' state and we're up a creek.
>
> Typically I expect C2/C3 FFh states will be there on Intel stuff, but it
> seems awefully random to rely on this hole. AMD might unwittinly change
> the ACPI driver (they're the main user) and then we'd be up a creek.
>
> Robustly we'd teach the ACPI driver about FFh and set enter_dead on
> every state -- but we'd have to double check that with AMD.
>
> At the same time, intel_idle should then also set enter_dead on all
> states.
>
> And then the mwait case is only ever reached if CPUIDLE=3Dn.

So that's why I would prefer intel_idle, if configured, to give
mwait_play_dead() a hint on the MWAIT hint to use.  Otherwise the
latter would just fall back to the current method.

This would not be bullet-proof, but it would take the opportunity to
work better if it could.

