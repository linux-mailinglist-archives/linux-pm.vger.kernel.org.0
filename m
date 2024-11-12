Return-Path: <linux-pm+bounces-17419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738B9C5B25
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 16:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBB7280EBE
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD400200C8D;
	Tue, 12 Nov 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq3QO532"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BF71FF5F9;
	Tue, 12 Nov 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423394; cv=none; b=VOZ5BXR+nXzYyl8eiJB/6cf3gzPXzNRmOohUw4+0D20FRhB8TcrXXAmaTxM2LAqesFihRD9Uj/q5pbv3OIqzP/Rf9a6KCrSZj61Vsutzm6ciAHRurZ5f62o/LMFpVk2VGOJvrsJt6SskY7h1/HGObLp98M988rAsnzi7uy7o5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423394; c=relaxed/simple;
	bh=qxIC4rld0FPHod8NdRU09jShd6X6EHSN5siQxzb9Gwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hm41J3zMkfmWyrxKIsNcddu24jcOnjMNsTVn0MZrV11FP9lyNfnGaXmeQMv/mwgxXIx5NIQs7dQ0roDIEM9S39sHcVgWjQnhFOGOqVNAxUyo5nRoJywwHLSbiC7nMxApzTGVInbz3AXfCGZz2M1VRJugibkpxpM/lQUZHIZgb0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq3QO532; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4FCC4CECD;
	Tue, 12 Nov 2024 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423394;
	bh=qxIC4rld0FPHod8NdRU09jShd6X6EHSN5siQxzb9Gwc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kq3QO532tbM3UkTnRLUmqiMDKu0ZnktPl7xepwAZXSAQGDaR+1+oYiHdBzNpbDa4n
	 upEiqb8AAbUCMlQ3xKVRC43z90aGmxpB7eb5++jYrYA8/j0iOXbTkvOcdePnmdaxhS
	 34CkXQU8r2fm5OaGQPVgg2Oe94kGycp8X5kxBbN1L3NXtku0bmUiJeot+HokJAn8tm
	 HtOjsxJ91BY1sYkZipTXN9ii1pSTszdU49GwFramTfjjaJShD/57mMNCZaGn44BpbT
	 dYKcs7J8yJZu4+NjkUOnLSIQ5UD/sC0njL5gxl4omXsLRZSBPE67JlZgQlRRdtyiw1
	 n10f4QKHnes+w==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2884910c846so2597006fac.0;
        Tue, 12 Nov 2024 06:56:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUT1nA5axh7v+9i/W2vPBwpaEtNwXrOpgJUZhUhS/+qER4TCBE4EJ3ZimmE8y0OXmUq7VXLiBabdOE=@vger.kernel.org, AJvYcCVuP2FUwHZt0KsfALkFY8FBQ+iEUMHAoekbff3+lExJ48RHXUQS7tTCNDuAUtgPMxiyGwqHFBkSdojXJTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH17gDuM7Eiek7Z/hH6QOLm4VwGqhk0/Lt5g2QAdcwrs7/m8xm
	B8qtveVE3yEp8oijzlVCZtOIwNUriHYRcUjfxypHl635LkY4pc+X/a3uqEvNdqWXABS9F0PMrf0
	4IAmbj0drEMRmY14Q2KcTtqzJYvU=
X-Google-Smtp-Source: AGHT+IHFAYWHqbxLaFbPkmTvierSbnGFzPUTt9hfFxEPChysSqgnLSYON2CyCbY9fGuxis/j/P0apQyLfG4eRPNHhDY=
X-Received: by 2002:a05:6870:5589:b0:288:b902:1b6d with SMTP id
 586e51a60fabf-2956028130dmr13610046fac.26.1731423393453; Tue, 12 Nov 2024
 06:56:33 -0800 (PST)
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
 <20241112134959.GG6497@noisy.programming.kicks-ass.net>
In-Reply-To: <20241112134959.GG6497@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 15:56:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iYYYpg7MDf8_UmoUuzyiPMoPdjgSJmdBXGYCxVc4icWw@mail.gmail.com>
Message-ID: <CAJZ5v0iYYYpg7MDf8_UmoUuzyiPMoPdjgSJmdBXGYCxVc4icWw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: Peter Zijlstra <peterz@infradead.org>, artem.bityutskiy@linux.intel.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 2:50=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Nov 12, 2024 at 01:30:29PM +0100, Rafael J. Wysocki wrote:
>
> > > > Then we are back to the original approach though:
> > > >
> > > > https://lore.kernel.org/linux-pm/20241029101507.7188-3-patryk.wlazl=
yn@linux.intel.com/
> > >
> > > Well, that won't be brilliant for hybrid systems where the available
> > > states are different per CPU.
> >
> > But they aren't.
> >
> > At least so far that has not been the case on any platform known to me
> > and I'm not aware of any plans to make that happen (guess what, some
> > other OSes may be unhappy).
>
> Well, that's something at least.
>
> > > Also, all of this is a bit of a trainwreck... AFAICT AMD wants IO bas=
ed
> > > idle (per the 2018 commit). So they want the ACPI thing.
> >
> > Yes.
> >
> > > But on Intel we really don't want HLT, and had that MWAIT, but that h=
as
> > > real problems with KEXEC. And I don't think we can rely on INTEL_IDLE=
=3Dy.
> >
> > We could because it handles ACPI now and ACPI idle doesn't add any
> > value on top of it except for the IO-based idle case.
>
> You're saying we can mandate INTEL_IDLE=3Dy? Because currently defconfig
> doesn't even have it on.

It is conceivable.

> > > The ACPI thing doesn't support FFh states for it's enter_dead(), shou=
ld it?
> >
> > It does AFAICS, but the FFH is still MWAIT.
>
> What I'm trying to say is that acpi_idle_play_dead() doesn't seem to
> support FFh and as such won't ever use MWAIT.

Right, but if it finds an FFH state deeper than C1, it will fall back
to the next play_dead method.

> > > Anyway, ideally x86 would grow a new instruction to offline a CPU, bo=
th
> > > MWAIT and HLT have problems vs non-maskable interrupts.
> > >
> > > I really don't know what is best here, maybe moving that whole CPUID
> > > loop to boot, store the value in a per-cpu mwait_play_dead_hint. Have
> > > AMD explicitly clear the value, and avoid mwait when 0 -- hint 0 is
> > > equal to HLT anyway.
> > >
> > > But as said, we need a new instruction.
> >
> > Before that, there is the problem with the MWAIT hint computation in
> > mwait_play_dead() and in fact intel_idle does know what hint to use in
> > there.
>
> But we need to deal witn INTEL_IDLE=3Dn.

Then the code would do what it is doing today, as a matter of fallback.

> Also, I don't see any MWAIT_LEAF
> parsing in intel_idle.c. Yes, it requests the information, but then it
> mostly ignores it -- it only consumes two ECX bits or so.
>
> I don't see it finding a max-cstate from mwait_substates anywhere.

No, it gets this either from _CST or from a built-in table for the
given processor model.

> So given we don't have any such code, why can't we simply fix the cstate
> parsing we have in mwait_play_dead() and call it a day?

I'll leave this one to Artem, but there is at least one reason to
avoid doing that I know about: There is no guarantee that whatever has
been found was actually validated.

