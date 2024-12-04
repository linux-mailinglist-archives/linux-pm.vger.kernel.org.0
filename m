Return-Path: <linux-pm+bounces-18528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8609E3A48
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 13:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55419B23CB0
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16A71B218D;
	Wed,  4 Dec 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xFOafY8q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38201974EA
	for <linux-pm@vger.kernel.org>; Wed,  4 Dec 2024 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315468; cv=none; b=GQK5f5xTF1+Tw0z5M6l7c+10EF0xF6HEHARqEnvt+iMWlZDDZVZ4UBw3dVUHiaPoIb9NJ9EVKwxIVC8L+1FiHXNSeZWXotMq0q+z6mrqjn1amvgDzB87aU7fY8NSYaZMPcnY2waTYaXw6vaKdxbPDA5A7OceweSB0T6w09SUa7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315468; c=relaxed/simple;
	bh=s3kWsiCRa6B19UIZQkjAzxK3N99JoQbccSVKzVbgCuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtsTvme/lcoSx2XfqFS8b7s+GO7Lf/e3EgHou7RTNaiqfrgg2qSXemU4MWcmfvhPIz+nSh2TINlzYQdKC89cbeny8Zc7b9fdV6+9CicpC7Dn8cQY+4FtFp0RpQ/h7Qk1L6p/kLpwIkhPPUU+5ydoejGVUVTUDKP66moreYMzsJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xFOafY8q; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a7bc2d7608so108135ab.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2024 04:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733315466; x=1733920266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s3kWsiCRa6B19UIZQkjAzxK3N99JoQbccSVKzVbgCuE=;
        b=xFOafY8qhVNYXktOgDQ+lFZlEjLJvkYbQhVhfVxS+LZysk8F42R96vKqy8AfWA11LU
         kBMjN3cx/lmAjGdFFC57I42zi6PFfxIjaaoW57lczxPQMQqZfl99h/Gz4qcw6dGjtYDM
         8k+qsDG8RkE8Y3s9Yckdg2SzeMI2DauTPc/K2GvqG+BTS0YKUluYZkyKBlG4/Og87+LU
         8u5mg369shont6QCH4YfaPz2PBPb5nwTPu80bUMLYCzfuiy19JaFoK+gSUATzM1NysyD
         Dbw+Ot3PVwCJwtw1RflEB9goZ3DkLQsICksVun5edj8XPcI2mRLVI1BuoPa38SetMa6G
         tuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733315466; x=1733920266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3kWsiCRa6B19UIZQkjAzxK3N99JoQbccSVKzVbgCuE=;
        b=bXAG4tf7pvYZsLt3vLrcfr4Phc/w3vqiyHnSi5jtrP0EqbaCrhORUQMuZb7qSte1ve
         DGKgzNoX4C69eEdxNV1VzwoRF82B3Bm40Gve/JQ21BSq5SfLKQD4pl7BL1Y5lMetytzX
         FKMIvTqCB1pa2z+LP03VEUyTC6mPRBUW3/2tb/2pY8VHz/MCVEv31xtfD6FjwJ+rpR2h
         edZsWMooqrgPIJsUoBzdp4DfBVYCJAQO/tv20fF/gLZTXhSgx5Jlf/sbMTqf+DzEwCJl
         w3f5bMbPXfvf6NwJLHBUx59XpE9DO5p7pqGANpSXepPuWrfeUhJb5cXRBs0fvanCqzmW
         vx8A==
X-Forwarded-Encrypted: i=1; AJvYcCWX+0aJkvU+G99yWKHh14HnPuQ6dQyOgA/T0tYljwR8823n17Q8rXOXsIdz2j9lbDw8HlC9YhCk1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpj4O64DllPB3ztlHXn2pXpnmGwUQbp1zrXR3CJyQaveaw86Da
	Ru8jvdgqEjHuWgU8IZBc93AJoI2Tnt5ZGR5pQlI4xIxZHU54pkUBEMwt+qdZMxjD6Lkhrks5S0C
	RawU+VgSPa6+IIhbTqEunedqGLTIFwlYbkrqE
X-Gm-Gg: ASbGncshFV0CEKeWCA4riUX9KakCOrg+SWdFouWIdzOsW8mKj3bJZFAPjJEgGTry1na
	KXhWogCT0k2V35ADHFlWWGd2tiXJB3A==
X-Google-Smtp-Source: AGHT+IGpnBMzSCeQfVCtzkYgOrmdOwo2Kfhc16GqhtSBaf/8iCMGMf9zeNwSnSGpHfMqSftYnYb95UZvkSMHlJNTiUI=
X-Received: by 2002:a05:6e02:3084:b0:3a7:d763:902a with SMTP id
 e9e14a558f8ab-3a800b1364bmr2337715ab.23.1733315465860; Wed, 04 Dec 2024
 04:31:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com> <Z0-R-_GPWu-iVAYM@google.com>
 <CALMp9eTCe1-ZA47kcktTQ4WZ=GUbg8x3HpBd0Rf9Yx_pDFkkNg@mail.gmail.com> <Z0-3bc1reu1slCtL@google.com>
In-Reply-To: <Z0-3bc1reu1slCtL@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 4 Dec 2024 04:30:54 -0800
Message-ID: <CALMp9eRqHkiZMMJ2MDXOHPbGx1rE9n5R2aR-F=qkuGo0BPS=og@mail.gmail.com>
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

Here is the sordid history behind the proposed APERFMPERF implementation.

First of all, I have never considered this feature for only
"slice-of-hardware" VMs, for two reasons:
(1) The original feature request was first opened in 2015, six months
before I joined Google, and long before Google Cloud had anything
remotely resembling a slice-of-hardware offering.
(2) One could argue that Google Cloud still has no slice-of-hardware
offering today.
Hence, an implementation that only works for "slice-of-hardware" is
essentially a science fair project. We might learn a lot, but there is
no ROI.

I dragged my feet on this for a long time, because
(1) Without actual guest C-state control, it seems essentially
pointless (though I probably didn't give sufficient weight to the warm
fuzzy feeling it might give customers).
(2) It's one of those things that's impossible to virtualize with
precision, and I can be a real pedant sometimes.
(3) I didn't want to expose a power side-channel that could be used to
spy on other tenants.

In 2019, Google Cloud launched the C2 VM family, with MWAIT-exiting
disabled for whole socket shapes. Though MWAIT hints aren't full
C-state control, and we still had the 1 MHz host timer tick that would
probably keep the guest out of deep C-states, my first objection
started to collapse. As I softened in my old age, the second objection
seemed indefensible, especially after I finally caved on nested posted
interrupt processing, which truly is unvirtualizable. But, especially
after the whole Meltdown/Spectre debacle, I was holding firm to my
third objection, despite counter-arguments that the same information
could be obtained without APERFMPERF. I guess I'm still smarting from
being proven completely wrong about RowHammer.

Finally, in December 2021, I thought I had a reasonable solution. We
could implement APERFMPERF in userspace, and the low fidelity would
make me feel comfortable about my third objection. "How would
userspace get this information," you may ask. Well, Google Cloud has
been carrying local patches to log guest {APERF, MPERF, TSC} deltas
since Ben Serebrin added it in 2017. Though the design document only
stipulated that the MSRs should be sampled at VMRUN entry and exit,
the original code actually sampled at VM-entry and VM-exit, with a
limitation of sampling at those additional points only if 500
microseconds had elapsed since the last samples were taken. Ben
calculated the effective frequency at each sample point to populate a
histogram, but that's not really relevant to APERFMPERF
virtualization. I just mention it to explain why those
VM-entry/VM-exit sample points were there. This code accounted for
everything between vcpu_load() and vcpu_put() when accumulating
"guest" APERF and MPERF, and this data eventually formed the basis of
our userspace implementation of APERFMPERF virtualization.

In 2022, Riley Gamson implemented APERFMPERF virtualization in
userspace, using KVM_X86_SET_MSR_FILTER to intercept guest accesses to
the MSRs, and using Ben's "turbostat" data to derive the values to be
returned. The APERF delta could be used as-is, but I was insistent
that MPERF needed to track guest TSC cycles while the vCPU was not
halted. My reasoning was this:
(1) The specification says so. Okay; it actually says that MPERF
"[i]ncrements at fixed interval (relative to TSC freq.) when the
logical processor is in C0," but even turbostat makes the
architecturally prohibited assumption that MPERF and TSC tick at the
same frequency.
(2) It would be disingenuous to claim the effective frequency *while
running* for a duty-cycle limited f1-micro or g2-small VM, or for
overcommitted VMs that are forced to timeshare with other tenants.

APERF is admittedly tricky to virtualize. For instance, how many
virtual "core clock counts at the coordinated clock frequency" should
we count while KVM is emulating CPUID? That's unclear. We're certainly
not trying to *emulate* APERF, so the number of cycles the physical
CPU takes to execute the instruction isn't relevant. The virtual CPU
just happens to take a few thousand cycles to execute CPUID. Consider
it a quirk. Similarly, in the case of zswap, some memory accesses take
a *really* long time. Or consider KVM time as the equivalent of SMM
time on physical hardware. SMM cycles are accumulated by APERF. It may
seem like a memory access just took 60 *milliseconds*, but most of
that time was spent in SMM. (That's taken from a recent real-world
example.) As much as I hate SMM, it provides a convenient rug to sweep
virtualization holes under.

At this point, I should note that Aaron Lewis eliminated the
rate-limited "turbostat" sampling at VM-entry/VM-exit early this year,
because it was too expensive. Admittedly, most of the cost was
attributed to reading MSR_C6_CORE_RESIDENCY, which Drew Schmitt added
to Ben's sampling in 2018. But this did factor into my thinking
regarding cost.

The target intercept was the C3 VM family, which is not
"slice-of-hardware," and, ironically, does not disable MWAIT-exiting
even for full socket shapes (because we realized after launching C2
that that was a huge mistake). However, the userspace approach was
abandoned before C3 launch, because of performance issues. You may
laugh, but when we advertised APERFMPERF to Linux guests, we were
surprised to find that every vCPU started sampling these MSRs every
timer tick. I still haven't looked into why. I'm assuming it has
something to do with a perception of "fairness" in scheduling, and I
just hope that it doesn't give power-hungry instruction mixes like
AVX-512 and AMX an even greater fraction of CPU time because their
effective frequency is low. In any case, we were seeing 10% to 16%
performance degradations when APERFMPERF was advertised to Linux
guests, and that was a non-starter. If that seems excessive, it is. A
large part of this is due to contention for an unfortunate exclusive
lock on the legacy PIC that our userspace grabs and releases for each
KVM_RUN ioctl. That could be fixed with a reader/writer lock, but the
point is that we were seeing KVM exits at a much higher rate than ever
before. I accept full responsibility for this debacle. I thought maybe
these MSRs would get sampled once a second while running turbostat. I
had no idea that the Linux kernel was so enamored of these MSRs.

Just doing a back-of-the-envelope calculation based on a 250 Hz guest
tick and 50000 cycles for a KVM exit, this implementation was going to
cost 1% or more in guest performance. We certainly couldn't enable it
by default, but maybe we could enable it for the specific customers
who had been clamoring for the feature. However, when I asked Product
Management how much performance customers were willing to trade for
this feature, the answer was "none."

Okay. How do we achieve that? The obvious approach is to intercept
reads of these MSRs and do some math in KVM. I found that really
unpalatable, though. For most of our VM families, the dominant source
of consistent background VM-exits is the host timer tick. The second
highest source is the guest timer tick. With the host timer tick
finally going away on the C4 VM family, the guest timer tick now
dominates. On Intel parts, where we take advantage of hardware EOI
virtualization, we now have two VM-exits per guest timer tick (one for
writing the x2APIC initial count MSR, and one for the VMX-preemption
timer). I couldn't defend doubling that with intercepted reads of
APERF and MPERF.

Well, what about the simple hack of passing through the host values? I
had considered this, despite the fact that it would only work for
slice-of-hardware. I even coerced Josh Don into "fixing" our scheduler
so that it wouldn't allow two vCPU threads (a virtual hyperthread
pair) to flip-flop between hyperthreads on their assigned physical
core. However, I eventually dismissed this as
(1) too much of a hack
(2) broken with live migration
(3) disingenuous when multiple tasks are running on the logical processor.

Yes, (3) does happen, even with our C4 VM family. During copyless
migration, two vCPU threads share a logical processor. During live
migration, I believe the live migration threads compete with vCPU
threads. And there is still at least one kworker thread competing for
cycles.

Actually writing the guest values into the MSRs was initially
abhorrent to me, because of the inherent lossage on every write. But,
I eventually got over it, and partially assuaged my revulsion by
writing the MSRs infrequently. I would much have preferred APERF and
MPERF equivalents of IA32_TSC_ADJUST, but I don't have the patience to
wait for the CPU vendors. BTW, as an aside, just how is AMD's scaling
of MPERF by the TSC_RATIO MSR even remotely useful without an offset?

One requirement I refuse to budge on is that host usage of APERFMPERF
must continue to work exactly as before, modulo some very small loss
of precision. Most of the damage could be contained within KVM, if
you're willing to accept the constraint that these MSRs cannot be
accessed within an NMI handler (on Intel CPUs), but then you have to
swap the guest and host values every VM-entry/VM-exit. This approach
increases both the performance overhead (for which our budget is
"none") and the loss of precision over the current approach. Given the
amount of whining on this list over writing just one MSR on every
VM-entry/VM-exit (yes, IA32_SPEC_CTRL, I'm looking at you), I didn't
think it would be very popular to add two. And, to be honest, I
remembered that rate-limited *reads* of the "turbostat" MSRs were too
expensive, but I had forgotten that the real culprit there was the
egregiously slow MSR_C6_CORE_RESIDENCY.

I do recall the hullabaloo regarding KVM's usurpation of IA32_TSC_AUX,
an affront that went unnoticed until the advent of RDPID. Honestly,
that's where I expected pushback on this series. Initially, I tried to
keep the changes outwith KVM to the minimum possible, replacing only
explicit reads of APERF or MPERF with the new accessor functions. I
wasn't going to touch the /dev/cpu/*/msr/* interface. After all, none
of the other KVM userspace return MSRs do anything special there. But,
then I discovered that turbostat on the host uses that interface, and
I really wanted that tool to continue to work as expected. So, the
rdmsr crosscalls picked up an ugly wart. Frankly, that was the
specific patch that I expected to unleash vitriol. As an aside, why
does turbostat have to use that interface for its own independent
reads of these MSRs, when the kernel is already reading them every
scheduler tick?!? Sure, for tickless kernels, maybe, but I digress.

Wherever the context-switching happens, I contend that there is no
"clean" virtualization of APERF. If it comes down to just a question
of VM-entry/VM-exit or vcpu_load()/vcpu_put(), we can collect some
performance numbers and try to come to a consensus, but if you're
fundamentally opposed to virtualizing APERF, because it's messy, then
I don't see any point in pursuing this further.

Thanks,

--jim

