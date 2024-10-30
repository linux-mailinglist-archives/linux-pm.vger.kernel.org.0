Return-Path: <linux-pm+bounces-16762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 104E09B6D24
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 20:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C1B2B2169F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 19:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509AC1D0B81;
	Wed, 30 Oct 2024 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gt5ZLZsX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BD21D07A2;
	Wed, 30 Oct 2024 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318046; cv=none; b=OV6IUTAa1JXkt6OdzS8maNLIRPXBYV5gZZZ4x6jDkalHEEhFboyPnB9BINhJEWO5/2RiVzNihhM+hMGVnffgc1tlp+jtFLnb36pqjeiYkM9JJAdHUbGBAlWY6JYVgWhuhg35d1B1zykSRPdQar1AZ6uLVwZFdh0GPJRwXobPVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318046; c=relaxed/simple;
	bh=6dgFv0ScZrtTIDtWns7r3IG7FX5zk+FYzLYFQLcuGqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uo5lehf2+lJ30fNpZmUvf1/fajc/l3e4sVRMYCQvlickCTmQUi40p1lJpBC7ccKQKNSzvPToujTqOwVsCaJ7k6ez8MNKgY14UBQjdKAJQUx/hrgNekaNKTRcXpmdpPktlThjjXh9m29cfmHabw9Eza6tVT7bD2Nj+elx0TJXnTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gt5ZLZsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A881EC4CED3;
	Wed, 30 Oct 2024 19:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730318045;
	bh=6dgFv0ScZrtTIDtWns7r3IG7FX5zk+FYzLYFQLcuGqk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gt5ZLZsXcgHmv/c/pccmqH1QKWVp4l3/4yyZEdeO8+BBqBeLkV82X9r9rG0EwU1Z9
	 snisbAnIJpI1pqqIXTmkZ4c1qdiKYe+ZFa40Fe1gUs//Jx5vJ/Okv+n5uqKbfDsZs+
	 /4L0XkklQ0nEijn33Zjkrj/gl05xWWzuTEq7JsBKIlf/6QMCXthDRVrv6PWfuw79uF
	 KPP3hdQN5OdR+uTDROurC7hjHe98/q48UmsWScw/nxHH219qSHQysL5x+9P105cLWR
	 MtpD2RUm8qGxu1e/SVGDgUg/FSMxHbDPt+JBULWbWfIiBZFYagu8OpSKKRAM0ihpib
	 5S21u19ta/OqQ==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7180cc146d8so91941a34.0;
        Wed, 30 Oct 2024 12:54:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdFZXPMsFvLlGRIQyMChMUAuuiqI0CsKMe7+SB6yH6H4Iwc1Jlt89t1LPixENXkrwWpWX/SdupPwaeSb4=@vger.kernel.org, AJvYcCWasKpnSm8YVSgaFZZaTuDIXPVdfS1LFNpA1GXz/Jg36toQgcU49CsU6QSH1oQRzTsDss00zKeD5Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX+9T8k2razrlUChoD4CNff1Ohnv5XYYz34C/D2gKClMx90bLP
	IhiomNcZEMNQLSBVIHdZcd6ZIkBntvfRyCPQ59adn/+fKOIjeVJXX1Jezfj36lsvxiExaoSnjzG
	V0kRaUHH67/bumMVnLalLOn8/idE=
X-Google-Smtp-Source: AGHT+IHAP0IXH1cTeJej5GFb0EKHw585EkuL1Jg2TTCm09EUI1wB7fOJUMzdgLpH1LTeobOnFSE4Z34nK9iVaqAQ+OI=
X-Received: by 2002:a05:6871:3a0c:b0:25e:1711:90e3 with SMTP id
 586e51a60fabf-2946467a3c8mr4859696fac.2.1730318044935; Wed, 30 Oct 2024
 12:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029101507.7188-1-patryk.wlazlyn@linux.intel.com>
 <20241029101507.7188-3-patryk.wlazlyn@linux.intel.com> <e332a243-5a98-49ed-81be-b6db305d5dc5@intel.com>
 <35946efe3b8b8b686ba4ea0ed5c9f15c50ca6ef8.camel@linux.intel.com> <000fd68e-2b24-4eb3-b2d7-e4856b403212@intel.com>
In-Reply-To: <000fd68e-2b24-4eb3-b2d7-e4856b403212@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Oct 2024 20:53:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j+Qc+5PtPdsDy5B0iAGWOxYbKdUOkVmL_jPNVO8fNK=g@mail.gmail.com>
Message-ID: <CAJZ5v0j+Qc+5PtPdsDy5B0iAGWOxYbKdUOkVmL_jPNVO8fNK=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/smp: Allow forcing the mwait hint for play
 dead loop
To: Dave Hansen <dave.hansen@intel.com>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:32=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 10/30/24 02:58, Artem Bityutskiy wrote:
> > On Tue, 2024-10-29 at 11:30 -0700, Dave Hansen wrote:
> > 1. Could we at least set up a few rules here?  Like, say what the hints
> > are, what values can they have?
> >
> > The hints are 8-bit values, lower 4 bits define "sub-state", higher 4 b=
its
> > define the state.
> >
> > The state value (higher 4 bits) correspond to the state enumerated by C=
PUID leaf
> > 5 (Value 0 is C0, value 1 is C1, etc). The sub-state value is an opaque=
 number.
> >
> > The hint is provided to the mwait instruction via EAX.
>
> OK, so can you distill that down to something succinct and get it in a
> comment above the new function, please?
>
> > 2. Where do they come from?
> >
> > Hardware C-states are defined by the specific platform (e.g., C1, C1E, =
CC6,
> > PC6). Then they are "mapped" to the SDM C-states (C0, C1, C2, etc). The=
 specific
> > platform defines the hint values.
> >
> > Intel typically provides the hint values in the EDS (External Design
> > Specification) document. It is typically non-public.
> >
> > Intel also discloses the hint values for open-source projects like Linu=
x, and
> > then Intel engineers submit them to the intel_idle driver.
> >
> > Some of the hints may also be found via ACPI _CST table.
>
> What about the mwait_play_dead() loop that calculates the hint?  Doesn't
> that derive the hint from CPUID?
>
> > 3. Can this get called more than once?
> >
> > It is not supposed to. The idea is that if a driver like intel_idle is =
used, it
> > can call 'set_mwait_play_dead_hint()' and provide the most optimal hint=
 number
> > for the offline code.
>
> There are two important nuggets in there:
>
> First, an idle driver can but is not required to set the hint.  This
> would be good comment material.
>
> Second, only one thing is supposed to set the hint.  This is a good
> thing to WARN() about.
>
> > 4. Does it _need_ to be set?
> >
> > No. It is more of an optimization. But it is an important optimization =
which may
> > result in saving a lot of money in a datacenter.
> >
> > Typically using a "wrong" hint value is non-fatal, at least I did not s=
ee it
> > being fatal so far. The CPU will map it to some hardware C-state reques=
t, but
> > which one - depends on the "wrong" value and the CPU. It just may be su=
b-
> > optimal.
>
> OK, so this tells me we *don't* want some kind of:
>
>         WARN_ON(play_dead_mwait_hint =3D=3D PLAY_DEAD_MWAIT_HINT_UNSET);
>
> warning.
>
> > 5. What's the behavior when it is not set?
> >
> > The offline code will fall-back to the generic non-architectural algori=
thm,
> > which provides correct results for all server platforms I dealt with si=
nce 2017.
> > It should provide the correct hint for most client platforms, as far as=
 I am
> > aware.
> >
> > Sierra Forest Xeon is the first platform where the generic algorithm pr=
ovides a
> > sub-optimal value 0x21. It is not fatal, just sub-optimal.
>
> What is the non-architectural algorithm?  Which Linux code are you
> referring to?
>
> > Note: I am working with Intel firmware team on having the FW "re-mappin=
g" hint
> > 0x21 to hint 0x23, so that "unaware" Linux kernel also ends up with req=
uesting
> > the deepest C-state for an offline CPU.
>
> That would be great as well.  Thanks for doing that!
>
> > 6. Who is responsible for calling this?
> >
> > The idea for now is that the intel_idle driver calls it.
> >
> > But in theory, in the future, any driver/platform code may call it if i=
t "knows"
> > what's the most optimal hint, I suppose. I do not have a good example t=
hough.
>
> So let's look at how this works:
>
> void native_play_dead(void)
> {
> ...
>         mwait_play_dead();
>         if (cpuidle_play_dead())
>                 hlt_play_dead();
> }
>
> This _existing_ code has three different ways of playing dead (in this
> order of preference):
>
>  1. mwait
>  2. cpuidle
>  3. hlt
>
> It has (at least) two different mechanisms for telling which of these to
> call:
>
>   1. mwait has a bunch of built-in logic that will ensure the CPU
>      should use for playing dead.  If not, it does nothing and returns.
>   2. cpuidle_play_dead() (only used by acpi_idle_driver as far as I can
>      tell) will return an error if it does not support playing dead
>
> If 1 and 2 fail, then hlt_play_dead() gets called.
>
> But the really fun part of this is that idle driver is *called* here.

Currently, cpuidle_play_dead() is for the cases when MWAIT is not supported=
.

> The driver that is also responsible for overriding the mwait hint.

So no, intel_idle is not called there because it only uses MWAIT.

> So this series opts to have the boot code plumb the hint back into a
> basically undocumented global variable while also assuming that the
> system is *going* to use mwait.  It then does *nothing* with the
> callback just adjacent to the code it wants to modify.
>
> Seems rather spaghetti-like to me.
>
> To make it worse, go look at da6fa7ef67f0 ("x86/smpboot: Don't use
> mwait_play_dead() on AMD systems").  It hacks AMD-specific code in
> mwait_play_dead() just to force the cpuidle code to get called.
>
> What if we did this?  First, introduce a helper:
>
>         bool mwait_play_dead_with_hint(u32 hint)
>
> and then restructure native_play_dead() to look like this:
>
> static mwait_play_dead_generic(void)
> {
>         u32 hint =3D get_deepest_mwait_hint();
>
>         return mwait_play_dead_with_hint(hint);
> }
>
> void native_play_dead(void)
> {
>         bool used;
>
>         used =3D cpuidle_play_dead();
>         if (used)
>                 return;
>
>         used =3D mwait_play_dead_generic();
>         if (used)
>                 return;
>
>         hlt_play_dead();
> }
>
> If the cpuidle drivers want to use mwait with a different hint, they
> override the *EXISTING* drv->states[].enter_dead() functionality and
> call mwait_play_dead_with_hint() with their new hint.  Then they don't
> need to pass anything _over_ to the mwait code.
>
> Wouldn't something like that makes this all much more straightforward?

Well, except for one detail which is this beautiful thing in mwait_play_dea=
d():

if (READ_ONCE(md->control) =3D=3D CPUDEAD_MWAIT_KEXEC_HLT) {
    /*
     * Kexec is about to happen. Don't go back into mwait() as
     * the kexec kernel might overwrite text and data including
     * page tables and stack. So mwait() would resume when the
     * monitor cache line is written to and then the CPU goes
     * south due to overwritten text, page tables and stack.
     *
     * Note: This does _NOT_ protect against a stray MCE, NMI,
     * SMI. They will resume execution at the instruction
     * following the HLT instruction and run into the problem
     * which this is trying to prevent.
     */
    WRITE_ONCE(md->status, CPUDEAD_MWAIT_KEXEC_HLT);
    while(1)
         native_halt();

clearly referred to as a kexec() hack, which cannot be done in
cpuidle_play_dead() because the cpuidle driver doesn't know how to get
to md->control.

And even if it did, it is kind of not its business to deal with this stuff.

