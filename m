Return-Path: <linux-pm+bounces-33570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE05B3E819
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 17:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EDE3A7096
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 15:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D83338F5F;
	Mon,  1 Sep 2025 15:01:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52B330E839;
	Mon,  1 Sep 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738905; cv=none; b=WbGzstPAaOtLUxnLg0zSuLru2iuYeAJ0QyZ9crJVg4+1ZAjSLVXpXs1BzukbC+u/gvklISPhemzZKJQzh+4Z9FPJAcyn1rOP2wIk3MCbwuqtwFyfiMQK8w/kZfMzTjFQ174lk/h10wfMmB2di0MYUdGqCrZ9N326vdKTw5wv5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738905; c=relaxed/simple;
	bh=sKIHQaF4uEzrA4VpXBz7JVyj9mqvjOrJ0LV/LJ7YQ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WC14lxlml3nMStXDvbQqM2mB5bL0GoEL0siFrIr1km/+D9Cx+42W+/hlEEAJqddgIRxjlLssoLokpHf2PnCBCB3F1oe/F9D/NMg3WCcViv4T3o1+Qik2Dgy90zHGO0qLxyf4rxHj6enBF4prbqDepsxyO7x8DAPmPV2HVeLVREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCCCC16A3;
	Mon,  1 Sep 2025 08:01:32 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D4CF3F6A8;
	Mon,  1 Sep 2025 08:01:37 -0700 (PDT)
Date: Mon, 1 Sep 2025 16:01:34 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ahmed.genidi@arm.com, kevin.brodsky@arm.com,
	scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v3 4/5] arm64: initialise SCTLR2_EL1 at cpu_soft_restart()
Message-ID: <aLW1Thh3Xscw1O3U@e133380.arm.com>
References: <20250813120118.3953541-1-yeoreum.yun@arm.com>
 <20250813120118.3953541-5-yeoreum.yun@arm.com>
 <aKXlnZ8HXHBZMj4T@e133380.arm.com>
 <aKYGsqCTRXwnb6Gw@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKYGsqCTRXwnb6Gw@e129823.arm.com>

Hi,

On Wed, Aug 20, 2025 at 06:32:34PM +0100, Yeoreum Yun wrote:
> Hi Dave,
> 
> > On Wed, Aug 13, 2025 at 01:01:17PM +0100, Yeoreum Yun wrote:
> > > SCTLR2_EL1 register is optional starting from ARMv8.8/ARMv9.3,
> > > and becomes mandatory from ARMv8.9/ARMv9.4
> > > and serveral architectural feature are controled by bits in
> > > these registers.
> > >
> > > Before, launching new kernel via kexec, initialise SCTLR2_EL1 explicitly.
> > >
> > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > ---
> > >  arch/arm64/kernel/cpu-reset.S | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
> > > index c87445dde674..123564af345b 100644
> > > --- a/arch/arm64/kernel/cpu-reset.S
> > > +++ b/arch/arm64/kernel/cpu-reset.S
> > > @@ -37,6 +37,12 @@ SYM_TYPED_FUNC_START(cpu_soft_restart)
> > >  	 * regime if HCR_EL2.E2H == 1
> > >  	 */
> > >  	msr	sctlr_el1, x12
> > > +
> > > +alternative_if ARM64_HAS_SCTLR2
> > > +	mov_q	x12, INIT_SCTLR2_EL1
> > > +	msr_s	SYS_SCTLR2_EL1, x12
> > > +alternative_else_nop_endif
> > > +
> >
> > It would be better to do this based on the ID regs.
> >
> > Although the previous kernel _shouldn't_ have used SCTLR2 if the
> > capability ARM64_HAS_SCTLR2 did not get enabled, it would be better to
> > enforce a clean state here for the new kernel.
> >
> > If so, maybe one of the macros that you already defined can be used
> > here?  (But it's also fine to open-code it.)
> 
> But cpu_soft_restart() can be called before capability is enabled?
> I think this function is called after "capability" setup,
> Was it good to use alternative than check the ID register?

What I meant is that we should reset SCTLR2_EL1 here even if the
ARM64_HAS_SCTLR2 capability is not set.

The cpu_soft_restart() code has responsibilities similar to those of a
bootloader.  We want to put the CPU into a known state, irrespective of
how the current kernel has been using the CPU.

For one thing, we come through this path when booting a crash kernel if
the current kernel panicked.  So we should avoid making too many
assumptions about anything being in a sensible state here.

(Your rewrite of this in v4 looks fine.)

> > >  	isb
> > >
> > >  	cbz	x0, 1f				// el2_switch?
> >
> > [...]
> >
> > In the case where the el2_switch argument in non-zero, don't we also
> > need to do something to reinitialise SCTLR2_EL2 after switching back
> > to EL2, in the HVC_SOFT_RESTART handler?
> >
> > Maybe I missed something.
> 
> No. I'm missing to init in NVHE's HVC_SOFT_RESTART handler to clear SCTLR2_EL2.
> 
> Thanks!

I'll take a look at this in v4.

Cheers
---Dave

