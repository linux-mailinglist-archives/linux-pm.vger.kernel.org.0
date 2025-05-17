Return-Path: <linux-pm+bounces-27266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1219BABABE0
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 20:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39153AE607
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 18:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1238C20B81B;
	Sat, 17 May 2025 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWswzSPb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2619E96A;
	Sat, 17 May 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747507171; cv=none; b=jHaSfpCXtMlKAykRBnCrGU3F91MzG15867CJyfCBOM2/McAVr7cLP63QoCWdrJAEagifUXtoqNULGrHZX8A9QdPlM9vEuLEMonkCnjo1QRtDhmIvx9oqTtIYLxbPtzLO8Oh3yHDuSRcT8EHx6zHHQcpWiUWGGhnhz+o+sgle8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747507171; c=relaxed/simple;
	bh=tPXhhzR/j7fCwmXIxHh6aPeFNgazjQ0Ggl/HRl/Fdpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX/EQRuGWk/Yoq1G5GJQIUHn0pMpA2bWJtl939XGnh+hJSbaaWt3bLkumif7+FZNoTcrWCEw88LZBjXcWPNSBEWmP/HZABDWxGvqJSM+bJ9rfYtB8WDTtDNHoI90cD5sweLh5T8B4QbH7O87QLvhBlT2mqLpCgbOgO3jr8y8S8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWswzSPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0154C4CEE3;
	Sat, 17 May 2025 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747507170;
	bh=tPXhhzR/j7fCwmXIxHh6aPeFNgazjQ0Ggl/HRl/Fdpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWswzSPbNIcH4Nt8K6sHwM1CQ4VT2vN7MDEKXMRHnNNpRNIwz0Lb07yUT0LFOmYgc
	 Ogex2J6pYkZqVvtnbcwbMNLMxsf1jCv9DgaIzBDAkV5Tnu1LnsGHUp2eYoPh+2n3Z4
	 s8cJtFgb+GxwEZ6hiOWa0FSKJDxv+5DgMI8h+FbFZXzNPDuYsmW5QTAgyLZ58/V7ww
	 G6RycMcQ4pOUx8p76FXjQ0xOJFcBXQv3QIIQ/DBsCqLAKY+tZoA7zqjSpYy0kDlgyE
	 K7Ym0YOWN0xGeQ1Oqz3xao3r+D+5r005zWU6lX7+RYAKqWjUjcLb8ok/4bhxUO/VTG
	 gUjlkahfKfX2w==
Date: Sat, 17 May 2025 11:39:19 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ayush Jain <Ayush.Jain3@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 3/3] x86/fpu: Don't support kernel-mode FPU when
 irqs_disabled()
Message-ID: <20250517183919.GC1239@sol>
References: <20250516231858.27899-1-ebiggers@kernel.org>
 <20250516231858.27899-4-ebiggers@kernel.org>
 <aCg2DSYp0nakwX3l@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCg2DSYp0nakwX3l@gmail.com>

On Sat, May 17, 2025 at 09:09:01AM +0200, Ingo Molnar wrote:
> 
> * Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Make irq_fpu_usable() return false when irqs_disabled().  That makes the
> > irqs_disabled() checks in kernel_fpu_begin_mask() and kernel_fpu_end()
> > unnecessary, so also remove those.
> > 
> > Rationale:
> > 
> > - There's no known use case for kernel-mode FPU when irqs_disabled().
> 
> Except EFI?

Yes, I remembered that just after sending this...  And EFI does want the ldmxcsr
and fninit, which makes it like actual kernel-mode FPU.  That implies we at
least need to disable BH (and preemption) if it wasn't already disabled.  But if
hardirqs may or may not be disabled already, that means we either need to
conditionally use local_bh_disable()/enable (or preempt_enable()/disable on
PREEMPT_RT) as the current code does, or use local_irq_save()/restore.

If we did the latter, then all EFI calls would run with hardirqs disabled.  It
looks like hardirqs are currently intentionally disabled before some of the EFI
calls, but not all of them.  I'm not sure what the logic is there, and whether
it would be okay to just always disable them.

> 
> >   arm64 and riscv already disallow kernel-mode FPU when irqs_disabled().
> >   __save_processor_state() previously did expect kernel_fpu_begin() and
> >   kernel_fpu_end() to work when irqs_disabled(), but this was a
> >   different use case and not actual kernel-mode FPU use.
> > 
> > - This is more efficient, since one call to irqs_disabled() replaces two
> >   irqs_disabled() and one in_hardirq().
> 
> This is noise compared to the overhead of saving/restoring vector CPU 
> context ...

In practice most calls to kernel_fpu_begin() don't actually do the
save_fpregs_to_fpstate(), since either TIF_NEED_FPU_LOAD is already set or it's
a kthread.  So, the overhead from the other parts like the EFLAGS checks and
ldmxcsr are measurable, especially when processing small amounts of data.

> > - This fixes irq_fpu_usable() to correctly return false during CPU
> >   initialization.  Incorrectly returning true caused the SHA-256 library
> >   code, which is called when loading AMD microcode, to take a
> >   SIMD-optimized code path too early, causing a crash.  By correctly
> >   returning false from irq_fpu_usable(), the generic SHA-256 code
> >   correctly gets used instead.  (Note: SIMD-optimized SHA-256 doesn't
> >   get enabled until subsys_initcall, but CPU hotplug can happen later.)
> 
> Alternatively we could set in_kernel_fpu during CPU bootstrap, and 
> clear it once we know the FPU is usable? This is only a relatively 
> short early boot period, with no scheduling, right?

Yes, if there isn't agreement on this approach we can do that instead.  Say:

- Replace in_kernel_fpu with kernel_fpu_supported, with the opposite meaning
  (so that the initial value of false means "unsupported")
- fpu__init_cpu() sets it to true
- cpu_disable_common() sets it to false


