Return-Path: <linux-pm+bounces-19464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053489F6FFB
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 23:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 843C17A0551
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 22:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272C51FAC55;
	Wed, 18 Dec 2024 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ul9u/xl/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC1518B46A
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734560597; cv=none; b=JyJ3GaQRw2vKCmScnVKWezcE1iN3YPP1mP0i6yarE9DVr2h1Zn7E953MIkG2ss6DX1dNwC48mqu/je64/pIvnfFOoe6qJQdAoBp1H4bKrpZaNoGGOEpm6DwAsYeA5k3xn+NB8QmLeM7MvRzxYjY4n66Jxk9CZVLXZAWE3OgD+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734560597; c=relaxed/simple;
	bh=e54dzShIhWtAvpJM+N0g5H7FNJbiDV4gjPM03z+nUcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpHSIpWKETSC6x3cndgDyelOCyQNlsm5JtGAcU+xcPWk4dBtZELCr4E6h3vs++Ph/Fx4vg9itF6Mq0bWSdmOeVFmQsaj/tTDXYg/VWl52Wp4Mpb8PHIiHRMynIlNDAiUWdcYNbO4rK10mYuppJVMpP0mWzPgESJLZt+KSzPD36o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ul9u/xl/; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so28005ab.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 14:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734560594; x=1735165394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMgNXVsDBO2oQT0Up+C0FnN7vyy4sTLkPXPENnLdaSc=;
        b=ul9u/xl/iM0PUYj7YmN24/hpCYbC4NQSXJvWyeuhol8cYVPzzWBnq0L/9ZuBhWD7cA
         Nac58sIXLq3oIITulYTuT+si6XhzmbVCyNskPPfpuf3vSA/z6kBBxPvzGv+v+mI7mSWC
         q+DxzhnKc/Y+MtQVv6nMafV+rEZIJvleSfD73RahQER9xXquT6ZP2xtMPr7zZQtckLho
         q9WJU86eImyejWRtSW/akerZn+H2E9y2sJVIYiBEGJxUILIgqBNZYz+c/3OKieAMeS64
         36BuO1qpwWsi+4HL8vrwQ9ImRso353N74HHvHQ2VLxCElYnV39gHvT2Fprf5LUONqQAs
         vv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734560594; x=1735165394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMgNXVsDBO2oQT0Up+C0FnN7vyy4sTLkPXPENnLdaSc=;
        b=j0jNlrb/hQYR1GOKVSWPYEZIQXnAFW8Z2xDCym0NRTjiB86PwAUe21zigj31XIZs5x
         ZRODp4DPFZd37OBLODVClnd4nGd+ABK/po6kpscJwQt5iguk9Tdq4BFVftrnflw6sVcy
         IDblS79k83aE4gZR0L0r916XIQbKaZ/1DjdLRSv7NPgNGCUuaLn/2iK8qM4GFg9sJn3n
         uCiF6Kgm1GfyzJpouL9di54VaoErIxcCiiaNzUf2LnpgNkURWX8gzpwmM8JS5EsHNXYQ
         Sy8U7K2QvEN6Ik2xhCcSLo+4ybV1RJgL65JOpjWGUuWsEMBMzwxDhg8Jp8Atq6NadsjK
         LD0w==
X-Forwarded-Encrypted: i=1; AJvYcCUbICVJttXs9Lfl5qUuiOq+hwwMcMa3hEeqq/33KimrncoJhxs1dAk+vOrxZ0ZGe8kcH94A1crG/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyili6srRzPxHRJk3flFxaTVzi94Mm5069+xBXIHtZ4dXCV4yXk
	/cjdM4XOH+QYfx3CreOVH8bhhWawlMgHzlq08nWLXLW5nd+sVQmyXxBwSGxW+3wPlFVBoYM03Vx
	bwh55EttXOpFRE36PYwK5amGoAUp8kU1nsnoN
X-Gm-Gg: ASbGncsaeiWshzdcheDAnAUX2NyEtuZKc0eAtOUASWuKYgt64abIlT9BnsW7OYqnJha
	5RmjnEhFgGcp6YNQUzlh1zfFHr2bAgXmU4lX6wLKP0zfMq7n7pvuwO2++Dvwrck5yfQ==
X-Google-Smtp-Source: AGHT+IHEoM0w7xN78CqOGUAuwh1KfJWMPbmxCRhMlqM+KRO4ynNFWgb6bwpwXY7zH/xdoruJi1B2K7QgbUwEhIYNU2w=
X-Received: by 2002:a05:6e02:1d86:b0:3a7:c7fc:1fdd with SMTP id
 e9e14a558f8ab-3c0aa57583amr163515ab.3.1734560594112; Wed, 18 Dec 2024
 14:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com> <Z0-R-_GPWu-iVAYM@google.com>
 <CALMp9eTCe1-ZA47kcktTQ4WZ=GUbg8x3HpBd0Rf9Yx_pDFkkNg@mail.gmail.com>
 <Z0-3bc1reu1slCtL@google.com> <CALMp9eRqHkiZMMJ2MDXOHPbGx1rE9n5R2aR-F=qkuGo0BPS=og@mail.gmail.com>
 <Z1MnoQcYpzE-4EZy@google.com>
In-Reply-To: <Z1MnoQcYpzE-4EZy@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 18 Dec 2024 14:23:03 -0800
Message-ID: <CALMp9eSbRzDs2iSEL=rAXTzj822bhzpm69qGWkt5n4Tk72JJcw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/22] KVM: x86: Virtualize IA32_APERF and IA32_MPERF MSRs
To: Sean Christopherson <seanjc@google.com>
Cc: Mingwei Zhang <mizhang@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Perry Yuan <perry.yuan@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 8:34=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Wed, Dec 04, 2024, Jim Mattson wrote:
> > Wherever the context-switching happens, I contend that there is no
> > "clean" virtualization of APERF. If it comes down to just a question
> > of VM-entry/VM-exit or vcpu_load()/vcpu_put(), we can collect some
> > performance numbers and try to come to a consensus, but if you're
> > fundamentally opposed to virtualizing APERF, because it's messy, then
> > I don't see any point in pursuing this further.
>
> I'm not fundamentally opposed to virtualizing the feature.  My complaints=
 with
> the series are that it doesn't provide sufficient information to make it =
feasible
> for reviewers to provide useful feedback.  The history you provided is a =
great
> start, but that's still largely just background information.  For a featu=
re as
> messy and subjective as APERF/MPERF, I think we need at least the followi=
ng:
>
>   1. What use cases are being targeted (e.g. because targeting only SoH w=
ould
>      allow for a different implementation).
>   2. The exact requirements, especially with respect to host usage.  And =
the
>      the motivation behind those requirements.
>   3. The high level design choices, and what, if any, alternatives were c=
onsidered.
>   4. Basic rules of thumb for what is/isn't accounted in APERF/MPERF, so =
that it's
>      feasible to actually maintain support long-term.
>
> E.g. does the host need to retain access to APERF/MPERF at all times?  If=
 so, why?
> Do we care about host kernel accesses, e.g. in the scheduler, or just use=
rspace
> accesses, e.g. turbostat?
>
> What information is the host intended to see?  E.g. should APERF and MPER=
F stop
> when transitioning to the guest?  If not, what are the intended semantics=
 for the
> host's view when running VMs with HLT-exiting disabled?  If the host's vi=
ew of
> APERF and MPREF account guest time, how does that mesh with upcoming medi=
ated PMU,
> where the host is disallowed from observing the guest?
>
> Is there a plan for supporting VMs with a different TSC frequency than th=
e host?
> How will live migration work, without generating too much slop/skew betwe=
en MPERF
> and GUEST_TSC?
>
> I don't expect the series to answer every possible question upfront, but =
the RFC
> provided _nothing_, just a "here's what we implemented, please review".

Sean,

Thanks for the thoughtful pushback. You're right: the RFC needs more
context about our design choices and rationale.

My response has been delayed as I've been researching the reads of
IA32_APERF and IA32_MPERF on every scheduler tick. Thanks for pointing
me to commit 1567c3e3467c ("x86, sched: Add support for frequency
invariance") off-list. Frequency-invariant scheduling was, in fact,
the original source of these RDMSRs.

The code in the aforementioned commit would have allowed us to
virtualize APERFMPERF without triggering these frequent MSR reads,
because arch_scale_freq_tick() had an early return if
arch_scale_freq_invariant() was false. And since KVM does not
virtualize MSR_TURBO_RATIO_LIMIT, arch_scale_freq_invariant() would be
false in a VM.

However, in commit bb6e89df9028 ("x86/aperfmperf: Make parts of the
frequency invariance code unconditional"), the early return was
weakened to only bail out if
cpu_feature_enabled(X86_FEATURE_APERFMPERF) is false. Hence, even if
frequency-invariant scheduling is disabled, Linux will read the MSRs
every scheduler tick when APERFMPERF is available.

As we discussed off-list, it appears that the primary motivation for
this change was to minimize the crosscalls executed when examining
/proc/cpuinfo. I don't really think that use case justifies reading
these MSRs *every scheduler tick*, but I'm admittedly biased.

1. Guest Requirements

Unlike vPMU, which is primarily a development tool, our customers want
APERFMPERF enabled on their production VMs, and they are unwilling to
trade any amount of performance for the feature. They don't want
frequency-invariant scheduling; they just want to observe the
effective frequency (possibly via /proc/cpuinfo).

These requests are not limited to slice-of-hardware VMs. No one can
tell me what customers expect with respect to KVM "steal time," but it
seems to me that it would be disingenuous to ignore "steal time." By
analogy with HDC, the effective frequency should drop to zero when the
vCPU is "forced idle."

2. Host Requirements

The host needs reliable APERF/MPERF access for:
- Frequency-invariant scheduling
- Monitoring through /proc/cpuinfo
- Turbostat, maybe?

Our goal was for host APERFMPERF to work as it always has, counting
both host cycles and guest cycles. We lose cycles on every WRMSR, but
most of the time, the loss should be very small relative to the
measurement.

To be honest, we had not even considered breaking APERF/MPERF on the
host. We didn't think such an approach would have any chance of
upstream acceptance.

3. Design Choices

We evaluated three approaches:

a) Userspace virtualization via MSR filtering

   This approach was implemented before we knew about
   frequency-invariant scheduling. Because of the frequent guest
   reads, we observed a 10-16% performance hit, depending on vCPU
   count. The performance impact was exacerbated by contention for a
   legacy PIC mutex on KVM_RUN, but even if the mutex were replaced
   with a reader/writer lock, the performance impact would be too
   high. Hence, we abandoned this approach.

b) KVM intercepts RDMSR of APERF/MPERF

   This approach was ruled out by back-of-the-envelope
   calculation. We're not going to be able to provide this feature for
   free, but we could argue that 0.01% overhead is negligible. On a 2
   GHz processor that gives us a budget of 200,000 cycles per
   second. With a 250 Hz guest tick generating 500 RDMSR intercepts
   per second, we have a budget of just 400 cycles per
   intercept. That's likely to be insufficient for most platforms. A
   guest with CONFIG_HZ_1000 would drop the budget to just 100 cycles
   per intercept. That's unachievable.

   We should have a discussion about just how much overhead is
   negligible, and that may open the door to other implementation
   options.

c) Current RDMSR pass-through approach

   The biggest downside is the loss of cycles on every WRMSR. An NMI
   or SMI in the critical region could result in millions of lost
   cycles. However, the damage only persists until all in-progress
   measurements are completed.

   We had considered context-switching host and guest values on
   VM-entry and VM-exit. This would have kept everything within KVM,
   as long as the host doesn't access the MSRs during an NMI or
   SMI. However, 4 additional RDMSRs and 4 additional WRMSRs on a
   VM-enter/VM-exit round-trip would have blown the budget. Even
   without APERFMPERF, an active guest vCPU takes a minimum of two
   VM-exits per timer tick, so we have even less budget per
   VM-enter/VM-exit round-trip than we had per RDMSR intercept in (b).

   Internally, we have already moved the mediated vPMU context-switch
   from VM-entry/VM-exit to the KVM_RUN loop boundaries, so it seemed
   natural to do the same for APERFMPERF. I don't have a
   back-of-the-envelope calculation for this overhead, but I have run
   Virtuozzo's cpuid_rate benchmark in a guest with and without
   APERFMPERF, 100 times for each configuration, and a Student's
   t-test showed that there is no statistically significant difference
   between the means of the two datasets.

4. APERF/MPERF Accounting

   Virtual MPERF cycles are easy to define. They accumulate at the
   virtual TSC frequency as long as the vCPU is in C0. There are only
   a few ways the vCPU can leave C0. If HLT or MWAIT exiting is
   disabled, then the vCPU can leave C) in VMX non-root operation (or
   AMD guest mode). If HLT exiting is not disabled, then the vCPU will
   leave C0 when a HLT instruction is intercepted, and it will reenter
   C0 when it receives an interrupt (or a PV kick) and starts running
   again.

   Virtual APERF cycles are more ambiguous, especially in VMX root
   operation (or AMD host mode). I think we can all agree that they
   should accumulate at some non-zero rate as long as the code being
   executed on the logical processor contributes in some way to guest
   vCPU progress, but should the virtual APERF accumulate cycles at
   the same frequency as the physical APERF? Probably not. Ultimately,
   the decision was pragmatic. Virtual APERF accumulates at the same
   rate as physical APERF while the guest context is live in the
   MSR. Doing anything else would have been too expensive.

5. Live Migration

   The IA32_MPERF MSR is serialized independently of the
   IA32_TIME_STAMP_COUNTER MSR. Yes, this means that the two MSRs do
   not advance in lock step across live migration, but this is no
   different from a general purpose vPMU counter programmed to count
   "unhalted reference cycles." In general, our implementation of
   guest IA32_MPERF is far superior to the vPMU implementation of
   "unhalted reference cycles."

6. Guest TSC Scaling

   It is not possible to support TSC scaling with IA32_MPERF
   RDMSR-passthrough on Intel CPUs, because reads of IA32_MPERF in VMX
   non-root operation are not scaled by the hardware. It is possible
   to support TSC scaling with IA32_MPERF RDMSR-passthrough on AMD
   CPUs, but the implementation is left as an exercise for the reader.

