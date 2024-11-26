Return-Path: <linux-pm+bounces-18121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E5E9D966A
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 12:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75BB4161859
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 11:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F90119066E;
	Tue, 26 Nov 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrhDWaUx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4819785270;
	Tue, 26 Nov 2024 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732621573; cv=none; b=a4/JGHx3Nav1s7HFgIsAP1MYfIpxIbTEbA0pKhgwO750DjOhcC0WQdlVWn6txf161U5olMa6F1HS3nH1M7IwtUUa0jLUKeeM4htFIvEw+MLx4HljzXOVvqN2wa3N3DoH29vtSYX+FFAe++Hte8u3SoXsrZqASjmVI69JTvUJ5Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732621573; c=relaxed/simple;
	bh=REThgyDlgyyVP5tex9MMoroU0GNEA9fyxCuO98fSg54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=et+L2jQmw3yhf9AXFfHjSltjsMwkkCUcECO0tqvJ7RVDl9mJnsT4Dx7EtO5JDt+/bRMYpp4RijJkx18caIXukHV9umUMbdw6n1gF/TJy9vUN7l1azh1w5WlMtY79jzxOn+9f7hgRpy1JnR3N1cyw0SEAcFNeWNxlESIRTRw1C+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrhDWaUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98B8C4CECF;
	Tue, 26 Nov 2024 11:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732621572;
	bh=REThgyDlgyyVP5tex9MMoroU0GNEA9fyxCuO98fSg54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lrhDWaUxBsDePpkepCSBDYwLQ9DVA0K17Za+gD1Gu+slRceGz3z/Su/NqHw/yCzlo
	 Zd+4jN7/R42rYGg8HVk2mnZoQ98GclaR18uh0DQgKTynaQRQnjbXOdUVTuv6mKoDYr
	 ikLaV5afwJ8ZgnK1fBeLnXlfJFna0L0R6+NrAZ49e0VCmN5OG7cVSEpq5+T6XXQ4BH
	 FMt5TxyVSFqaCUZxqoNI0xp9XYOG5K5sF//62fWe3si5E0HdNKOC/hDtRGLS9FWOok
	 n/oOSLMIP8WymGltar/6DKUD7yl8vzFJygfaPp/C7VdKPBR8BuKmkKPKu007Hhm1Sq
	 Z64AgTlZS8xeA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2976afeb682so1224018fac.0;
        Tue, 26 Nov 2024 03:46:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRMPMVdCVDlyPFCm+jwAFxheKcxnJgtX0KmVQ5uTR3Urheln/Dw8hSMb60+1bAv1QQIVVLduqFMdBti+0=@vger.kernel.org, AJvYcCWyWnnVx86Cv4RK1bpylCDka4yPgfRj7wa58td2Hda+AJv3XIoykdsMIl7kW9bfV04xdQpuX9Ns5+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG8IMviuZgDyYOaTYrLtTR/DqN7Mk+ms2H0TQ68BqpMKAlZyuN
	8PhmsBUp4fmO6aM5Cvm+96zUGY84luUE4dDpqAwAbIHktk21+a5tMteBAmVid+PUvNFlx+ryJVG
	q/Vnmg4bmI5vNWTwKG4LkxgjsTgE=
X-Google-Smtp-Source: AGHT+IGXSZeifjYgi0GU80vBtCBB8upzp1KpRPE3UNlwsF5+qp3vLgi9aeGnNAbTchherNzd1dlGovNdq5vwvngV6Hc=
X-Received: by 2002:a05:6870:4689:b0:297:2974:4fa9 with SMTP id
 586e51a60fabf-29729747f79mr12551989fac.1.1732621572007; Tue, 26 Nov 2024
 03:46:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-5-patryk.wlazlyn@linux.intel.com> <CAJZ5v0iBCKmp-Hs25chq_-z7-VB_+MqTPVmowACJkTz7KOUtEg@mail.gmail.com>
 <1023ee1a-1fc5-498f-be5b-a59a7317ef5a@linux.intel.com>
In-Reply-To: <1023ee1a-1fc5-498f-be5b-a59a7317ef5a@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Nov 2024 12:45:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jyPb7Qy81RKsuCmwQrbdGMCO71OtzxaCSnwY4f9T-SQw@mail.gmail.com>
Message-ID: <CAJZ5v0jyPb7Qy81RKsuCmwQrbdGMCO71OtzxaCSnwY4f9T-SQw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/8] x86/smp: Allow calling mwait_play_dead with
 arbitrary hint
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 12:37=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> >> The MWAIT instruction needs different hints on different CPUs to reach
> >> the most specific idle states. The current hint calculation* in
> >> mwait_play_dead() code works in practice on current hardware, but it
> >> fails on a recent one, Intel's Sierra Forest and possibly some future =
ones.
> >> Those newer CPUs' power efficiency suffers when the CPU is put offline=
.
> >>
> >>  * The current calculation is the for loop inspecting edx in
> >>    mwait_play_dead()
> >>
> >> The current implementation for looking up the mwait hint for the deepe=
st
> >> cstate, in mwait_play_dead() code works by inspecting CPUID leaf 0x5 a=
nd
> >> calculates the mwait hint based on the number of reported substates.
> >> This approach depends on the hints associated with them to be continuo=
us
> >> in the range [0, NUM_SUBSTATES-1]. This continuity is not documented a=
nd
> >> is not met on the recent Intel platforms.
> >>
> >> For example, Intel's Sierra Forest report two cstates with two substat=
es
> >> each in cpuid leaf 5:
> >>
> >>   Name*   target cstate    target subcstate (mwait hint)
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>   C1      0x00             0x00
> >>   C1E     0x00             0x01
> >>
> >>   --      0x10             ----
> >>
> >>   C6S     0x20             0x22
> >>   C6P     0x20             0x23
> >>
> >>   --      0x30             ----
> >>
> >>   /* No more (sub)states all the way down to the end. */
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >>    * Names of the cstates are not included in the CPUID leaf 0x5, they=
 are
> >>      taken from the product specific documentation.
> >>
> >> Notice that hints 0x20 and 0x21 are skipped entirely for the target
> >> cstate 0x20 (C6), being a cause of the problem for the current cpuid
> >> leaf 0x5 algorithm.
> >>
> >> Allow cpuidle code to provide mwait play dead loop with known, mwait
> >> hint for the deepest idle state on a given platform, skipping the cpui=
d
> >> based calculation.
> >>
> >> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> >
> > I'm going to risk saying that the changelog doesn't match the code
> > changes in the patch any more.
> >
> > The code changes are actually relatively straightforward: The bottom
> > half of mwait_play_dead() is split off, so it can be called from
> > multiple places.
> >
> > The other places from which to call it are cpuidle drivers
> > implementing :enter_dead() callbacks that may want to use MWAIT as the
> > idle state entry method.  The ACPI processor_idle driver and
> > intel_idle will be updated by subsequent patches to do so.
> >
> > The reason for it is mostly consistency: If the cpuidle driver uses a
> > specific idle state for things like suspend-to-idle, it is better to
> > let it decide what idle state to use for "play_dead" because it may
> > know better.
> >
> > Another reason is what mwait_play_dead() does to determine the MWAIT
> > argument (referred to as a "hint"), but IMO it belongs in a changelog
> > of a later patch because this one doesn't actually do anything about
> > it.  In fact, it is not expected to change the behavior of the code.
>
> The commit message here is to justify the change. I thought that giving
> some context is important. Do you suggest moving this under a
> different commit or don't mention the SRF and C6 states at all?

I would move it to the patch that actually makes a difference for SRF.
This one doesn't do that.

