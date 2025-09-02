Return-Path: <linux-pm+bounces-33628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE7DB3FCD6
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 12:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E398D173FF7
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9F12ECD2A;
	Tue,  2 Sep 2025 10:40:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A16028466E;
	Tue,  2 Sep 2025 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809613; cv=none; b=T29Qx65+sEYtO2AWAog9dR0+mGS8upY9XXgA+GG+rf63K7MlTNggBajlYoOK9nOoASLiYI5pauVXzsKT8t0tGApbyVgjA9Er6RnVbPoie0Qae6OApRuXjBuPUIAaZ6cFfjc7Y2D7cGHNYUqCs9AV6RC4Tw8XPYYj+JOlXIXbH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809613; c=relaxed/simple;
	bh=pWlV0hVI8MLJpH5NEq4FarqF5cViZIgU9Fel9EHeJ+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3IUMuuh5Jy/W1n3+4aIkgM5e8BGzh880yB/Td/SaGUsGW87h+CfywNhAFGd05QVCvCidZYCotN939X7w27AdAnDiZFY/nYQwh2Qxm8HfSNThbnlpVxdQiVBbxhQ2BKTLO20dMFiQbK/xcRYNrymPXKut+aufcggFOlkkrSJVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50DA226BE;
	Tue,  2 Sep 2025 03:40:02 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8F813F6A8;
	Tue,  2 Sep 2025 03:40:06 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:39:53 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ahmed.genidi@arm.com, kevin.brodsky@arm.com,
	scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	maz@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 2/5] arm64: initialise SCTLR2_ELx register at boot time
Message-ID: <aLbJeQf9LKXFTxzS@e133380.arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
 <20250821172408.2101870-3-yeoreum.yun@arm.com>
 <aLW4A3rTcJvA0c+j@e133380.arm.com>
 <aLXmCJOuxCHVXEYx@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLXmCJOuxCHVXEYx@e129823.arm.com>

Hi,

On Mon, Sep 01, 2025 at 07:29:28PM +0100, Yeoreum Yun wrote:
> Hi Dave,
> 
> > On Thu, Aug 21, 2025 at 06:24:05PM +0100, Yeoreum Yun wrote:
> > > The value of the SCTLR2_ELx register is UNKNOWN after reset.
> > > If the firmware initializes these registers properly, no additional
> > > initialization is required.
> > > However, in cases where they are not initialized correctly,
> > > initialize the SCTLR2_ELx registers during CPU/vCPU boot
> > > to prevent unexpected system behavior caused by invalid values.
> > >
> > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > ---
> >
> > [...]
> >
> > > diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> > > index 23be85d93348..c25c2aed5125 100644
> > > --- a/arch/arm64/include/asm/assembler.h
> > > +++ b/arch/arm64/include/asm/assembler.h
> > > @@ -738,6 +738,21 @@ alternative_endif

[...]

> > > +/* Set SCTLR2_ELx to the @reg value. */
> > > +.macro set_sctlr2_elx, el, reg, tmp
> > > +	mrs_s	\tmp, SYS_ID_AA64MMFR3_EL1
> > > +	ubfx	\tmp, \tmp, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> > > +	cbz	\tmp, .Lskip_sctlr2_\@
> > > +	.if	\el == 2
> > > +	msr_s	SYS_SCTLR2_EL2, \reg
> > > +	.elseif	\el == 12
> > > +	msr_s	SYS_SCTLR2_EL12, \reg
> > > +	.else
> > > +	msr_s	SYS_SCTLR2_EL1, \reg
> > > +	.endif
> > > +.Lskip_sctlr2_\@:
> > > +.endm

[...]

> > If might be a good idea to migrate other macros that use an "el"
> > argument to do something similar -- although that probably doesn't
> > belong in this series.
> >
> > The assembler seems to have no ".elseifc" directive, so you'll need
> > separate nested .ifc blocks:
> >
> > 	.ifc	\el,2
> > 	msr_s	SYS_SCTLR2_EL2, \reg
> > 	.else
> > 	.ifc	\el,12
> > 	msr_s	SYS_SCTLR2_EL12, \reg
> > 	.else
> > 	.ifc	\el,1
> > 	msr_s	SYS_SCTLR2_EL1, \reg
> > 	.else
> > 	.error	"Bad EL \"\el\" in set_sctlr2_elx"
> > 	.endif
> > 	.endif
> > 	.endif
> >
> > (Note, I've not tested this approach.  If you can think of a better
> > way, please feel free to suggest.)
> 
> Thanks for your suggestion. Let me test and check about this idea could
> be applied in other macro too :D
> (But as you mention, I'll apply this for SCTLR2 in other patchset).

Ack, let me know how it goes.

It is probably not worth doing this if the changes become complicated,
though.

[...]

> > > diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> > > index 36e2d26b54f5..ac12f1b4f8e2 100644
> > > --- a/arch/arm64/kernel/hyp-stub.S
> > > +++ b/arch/arm64/kernel/hyp-stub.S
> > > @@ -144,7 +144,17 @@ SYM_CODE_START_LOCAL(__finalise_el2)
> > >
> > >  .Lskip_indirection:
> > >  .Lskip_tcr2:
> > > +	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
> > > +	ubfx	x1, x1, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> > > +	cbz	x1, .Lskip_sctlr2
> > > +	mrs_s	x1, SYS_SCTLR2_EL12
> > > +	msr_s	SYS_SCTLR2_EL1, x1
> > >
> > > +	// clean SCTLR2_EL1
> > > +	mov_q	x1, INIT_SCTLR2_EL1
> > > +	msr_s	SYS_SCTLR2_EL12, x1
> >
> > I'm still not sure why we need to do this.  The code doesn't seem to
> > clean up by the EL1 value of any other register -- or have I missed
> > something?
> >
> > We have already switched to EL2, via the HVC call that jumped to
> > __finalise_el2.  We won't run at EL1 again unless KVM starts a guest --
> > but in that case, it's KVM's responsibility to set up the EL1 registers
> > before handing control to the guest.
> >
> > In any case, is SCTLR2_EL1 ever set to anything except INIT_SCTLR2_EL1
> > before we get here?
> 
> Regardless of VHE and nVHE, between init_kernel_el() and finalise_el2()
> the kernel modifies SCTLR_EL1/SCTLR2_EL1 (since el level in this period
> is EL1).
> and at the end of finalise_el2(), kernel switches to el2 and
> if VHE, it writes the SCTLR_EL1/SCTLR2_EL1 to SCTLR_EL2/SCTLR2_EL2 and
> initialize the SCTLR_EL1/SCTLR2_EL1.
> 
> Although there is no code to modify SCTLR2_EL1 between this period,
> as SCTLR1_ELx, I initialize the SCTLR2_EL1 as init value for the future
> usage.

I think that we don't need to ensure that all sysregs are cleanly
initialised; only those that can affect execution in some way need to
be initialised.

Once we are running at EL2 with VHE, we don't switch back to EL1, so
the _EL1 control registers don't affect execution any more.


If we did have to clean up the _EL1 registers, then this code would
need to clean up all the other regs too, but I can't see clean-up for
anything other than SCTLR2_EL1 here.  Is there some cleanup code
elsewhere that I have missed?

Cheers
---Dave

