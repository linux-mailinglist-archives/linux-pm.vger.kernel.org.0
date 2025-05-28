Return-Path: <linux-pm+bounces-27741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39994AC6BA0
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 16:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02B31BA05E2
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 14:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8112882DC;
	Wed, 28 May 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFPu6Nv5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422B013AF2;
	Wed, 28 May 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442332; cv=none; b=bpg6XFc9kjHRmFVkYg+nSj8Kze/3g3Oq78y7Jf4NZJ6rswpt+CJhDoBs4i8jl8ZtCTK6Gi2JqaNc6BXaPTMZoSihKG4uLx8L6/qSUef6RqrUWz3360Qm/2J6YZwhAb3s1IvRYh1lep0UOfP3dG4W1Od9Dr/bpCDE/FDvfshfP78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442332; c=relaxed/simple;
	bh=IGnOjm9mSj79ffcLMCdQ5dCfH2Vp1XxSc1dFI2W3IWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifMkcnpaD/q3RrpjMlcQ8ZF8VjpCm7hePPpPRyed1m1BGkakFXFtpYXytBqeXPJyI0oJOurG6Jj86rP6PtLyCqIxQVEoXoSxHU65n/92CmKzpj5yPMBCFSQBbgFx3wpOOGCZ1wMfBV4I5526qr/USfqTVSOtqZK6Wxg6kiXDLkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFPu6Nv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4869C4CEF0;
	Wed, 28 May 2025 14:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748442331;
	bh=IGnOjm9mSj79ffcLMCdQ5dCfH2Vp1XxSc1dFI2W3IWU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pFPu6Nv5KUg54HCB1RFBZehdsUXuEPF41F5OcBAmTuDSqDk71OuYotBlFk6ApoS6/
	 qDP2JKUFl4ozF0Apnlw7dCeWRz/Z3LGMvFfm7zS6B5UcKQN4btfND+V5Jr9dq+J7aH
	 YPAAxwr4Y0AbWePJtjRmdxXuibZn4/J/JodkKIzBIaFTMxoGSrgpvnYXvwwSeso581
	 i515JJQaspU14NCE7XD2vbIdq3b3ZsvgRXjFsXOc4v6Jxct+lDcMyrPzOC7b1p4P5q
	 Egbl/e5nWToQz9BRJeTjX4pPJnFg/BskCw1WgQgzbFTPJHNixez+UKj/cG5MolZuy3
	 Tt2fGENUuNbcA==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f9a7cbc8f1so929804b6e.0;
        Wed, 28 May 2025 07:25:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaioPM6b07S/HU7hCjZ0DkieQ5kqazmwDK1h1VqawMpWHPJPLSz0uHr4tYm/dh4T5QzsmfMOdZwbC3XP8=@vger.kernel.org, AJvYcCXpNHc2/bHC/vnTw4dn/W4o10qBBkzkvNU9HqbPCmh9mRUCMiCJaYAEQ0cx/Syoep75vQWb821TTag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw63c8tbhT7pfNOdSF4U4zsbv8tiWuEqbedGpJWM+izO8DX2G3o
	TL0XtsJyeJIHNRsb1uEikIpP395xbBG66mPn7QyHWC242WY2cQW2v3wNG664VNnpzXberGaAV1K
	wfjXBIu3wLjtB4wk4h90ssUt7Ybc6yBQ=
X-Google-Smtp-Source: AGHT+IFBffpsH1BwM4rm3RKitOIYehD5JkfJiM7Akv8GtbDS6I+0PNtu7adSWCuQP2UV0B5aF4Hy2BVM7MD0imWH0JM=
X-Received: by 2002:a05:6808:3307:b0:401:918a:5b81 with SMTP id
 5614622812f47-406468464ccmr9420552b6e.25.1748442330895; Wed, 28 May 2025
 07:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2006806.PYKUYFuaPT@rjwysocki.net> <20250528131759.GA39944@noisy.programming.kicks-ass.net>
 <CAJZ5v0i=TWMjPKxGa8eT-prV=dtQo=pwys5amcj3QL9qo=EYyQ@mail.gmail.com> <20250528133807.GC39944@noisy.programming.kicks-ass.net>
In-Reply-To: <20250528133807.GC39944@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 May 2025 16:25:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g2+OVdFM-bUCOynNivUc4doxH=ukt9e9Z_nKpoZh6gPA@mail.gmail.com>
X-Gm-Features: AX0GCFsL9gL26hQm_JdbGOMd4-i0oGeAZbKK_nVZQB08D27ommvyh01AYcly-4Q
Message-ID: <CAJZ5v0g2+OVdFM-bUCOynNivUc4doxH=ukt9e9Z_nKpoZh6gPA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] x86/smp: Fix power regression introduced by commit 96040f7273e2
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	x86 Maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Todd Brandt <todd.e.brandt@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 3:45=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, May 28, 2025 at 03:20:16PM +0200, Rafael J. Wysocki wrote:
> > On Wed, May 28, 2025 at 3:18=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Wed, May 28, 2025 at 02:53:13PM +0200, Rafael J. Wysocki wrote:
> > > > Hi Everyone,
> > > >
> > > > Commit 96040f7273e2 ("x86/smp: Eliminate mwait_play_dead_cpuid_hint=
()")
> > > > that shipped in 6.15 introduced a nasty power regression on systems=
 that
> > > > start with "nosmt" in the kernel command line which prevents it fro=
m entering
> > > > deep package idle states (for instance, PC10) later on.  Idle power=
, including
> > > > power in suspend-to-idle, goes up significantly on those systems as=
 a result.
> > > >
> > > > Address this by reverting commit 96040f7273e2 (patch [1/2]) and usi=
ng a
> > > > different approach, which is to retain mwait_play_dead_cpuid_hint()=
 and
> > > > still prefer it to hlt_play_dead() in case it is needed when cpuidl=
e is
> > > > not available, but prefer cpuidle_play_dead() to it by default (pat=
ch [2/2]).
> > >
> > > I don't understand. The revert says the reason it regresses is that i=
t
> > > goes into play_dead before cpuidle is initialized. The fix is then to
> > > call cpuidle first.
> > >
> > > But if cpuidle isn't initialized yet, how does that fix anything?
> >
> > The revert fixes the bug.
>
> This is not what I asked.
>
> > The other patch does what the reverted commit was supposed to be
> > doing, but differently.
>
> No, it does not.

If cpuidle is available and works, it will do the same thing.

> The whole point was that mwait_play_dead did not DTRT because hints are
> stupid and it could not select the deepest C state in an unambiguous
> fashion.

Yes, on some systems.

> And now you're restoring that -- code you all argued was fundamentally
> buggered.
>
> Yes is 'fixes' things on old platforms, but it is equally broken on the
> new platforms where you all argued it was broken on. So either way
> around you're going to need to fix those, and this isn't it.

There are systems where mwait_play_dead_cpuid_hint() does not work and
there are systems where it works.  Some of the latter are actually
new.

Regardless, if cpuidle_play_dead() runs before it and cpuidle is
there, the right thing will be done because cpuidle_play_dead() will
not return in that case.

The only question is what to do when cpuidle is not there.

The commit reverted by the first patch removed
mwait_play_dead_cpuid_hint() altogether, so it never runs and the only
fallback is hlt_play_dead(), but this doesn't work for disabling SMT
siblings.

If mwait_play_dead_cpuid_hint() is allowed to run before
hlt_play_dead() though, then worst-case it may use an unrecognized
MWAIT hint and the CPU should fall back to C1.  If the MWAIT hint is
valid though, it will enter a deep idle state and that's what happens
on all of the systems tested in the lab (20+), including the most
recent ones.

> Now, SMT siblings are all AP, by definition. So can't we simply send
> them INIT instead of doing CLI;HLT, that way they drop into
> Wait-for-SIPI and the ucode can sort it out?

No, I don't think so.  I don't think that Wait-for-SIPI is an idle state.

But we are discussing patch [2/2] here while really the problem is
that the commit in question is broken, so it needs to be reverted in
the first place.

