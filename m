Return-Path: <linux-pm+bounces-33572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 575BCB3E9F0
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 17:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A35B4E2DF2
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 15:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A87320A33;
	Mon,  1 Sep 2025 15:13:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED988320A22;
	Mon,  1 Sep 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739598; cv=none; b=eNAdDq79zAHMXo1Ry46RvHw92cUaMTGCiwNYCusWLBnzk1t/ckbR5jJ3zNo0C6fvZ13stsnmqncc17Jwm4UvfAgGzopr4RG7fSDsylYXAS+FwNwqRmlWetFhRz8rb2EbdWJRBF9/x17lm8yjE3FwWSz669O3b+f9/1nFMN4kCC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739598; c=relaxed/simple;
	bh=qREE9DY6AeaqxRM1Wkl3pRC/CG0ewqa3Bq3lWt63IXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTVDfBleGd4fRoLu/SlDnTGv6CNpDrxOZ3xCqBTWfoK8jdiKWimbahd5JHqPwduxmA5lpVNSZXaZ8vcUJdhNDkNj+AnMlrrctMYmeyogGEu4nyjdJILF6LJQjx0BFkICrp/JWPkJRXjgvsbeBEbOdPEz4Cj2HiBmBA84QuTzAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9EC916A3;
	Mon,  1 Sep 2025 08:13:05 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33B8D3F6A8;
	Mon,  1 Sep 2025 08:13:10 -0700 (PDT)
Date: Mon, 1 Sep 2025 16:13:07 +0100
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
Message-ID: <aLW4A3rTcJvA0c+j@e133380.arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
 <20250821172408.2101870-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821172408.2101870-3-yeoreum.yun@arm.com>

Hi,

On Thu, Aug 21, 2025 at 06:24:05PM +0100, Yeoreum Yun wrote:
> The value of the SCTLR2_ELx register is UNKNOWN after reset.
> If the firmware initializes these registers properly, no additional
> initialization is required.
> However, in cases where they are not initialized correctly,
> initialize the SCTLR2_ELx registers during CPU/vCPU boot
> to prevent unexpected system behavior caused by invalid values.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---

[...]

> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 23be85d93348..c25c2aed5125 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -738,6 +738,21 @@ alternative_endif
>  	set_sctlr sctlr_el2, \reg
>  .endm
>  
> +/* Set SCTLR2_ELx to the @reg value. */
> +.macro set_sctlr2_elx, el, reg, tmp
> +	mrs_s	\tmp, SYS_ID_AA64MMFR3_EL1
> +	ubfx	\tmp, \tmp, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> +	cbz	\tmp, .Lskip_sctlr2_\@
> +	.if	\el == 2
> +	msr_s	SYS_SCTLR2_EL2, \reg
> +	.elseif	\el == 12
> +	msr_s	SYS_SCTLR2_EL12, \reg
> +	.else
> +	msr_s	SYS_SCTLR2_EL1, \reg
> +	.endif
> +.Lskip_sctlr2_\@:
> +.endm
> +

You were right that just doing

	msr_s	SYS_SCTLR_\el, \reg

here doesn't work.  It looks like we rely on the C preprocessor to
expand the SYS_FOO_REG names to numeric sysreg encodings.  By the time
the assembler macros are expanded, it is too late to construct sysreg
names -- the C preprocessor only runs once, before the assembler.

So, your code here looks reasonable.

But, it will still silently do the wrong thing if \el is empty or
garbage, so it is probably worth adding an error check:

	.else
	.error "Bad EL \"\el\" in set_sctlr2_elx"
	.endif


Also, looking at all this again, the "1", "2" and "12" suffixes are not
really numbers: SYS_REG_EL02 would definitely not be the same thing as
SYS_REG_EL2 (although there is no _EL02 version of this particular
register).

So, can you use .ifc to do a string comparison instead?

If might be a good idea to migrate other macros that use an "el"
argument to do something similar -- although that probably doesn't
belong in this series.

The assembler seems to have no ".elseifc" directive, so you'll need
separate nested .ifc blocks:

	.ifc	\el,2
	msr_s	SYS_SCTLR2_EL2, \reg
	.else
	.ifc	\el,12
	msr_s	SYS_SCTLR2_EL12, \reg
	.else
	.ifc	\el,1
	msr_s	SYS_SCTLR2_EL1, \reg
	.else
	.error	"Bad EL \"\el\" in set_sctlr2_elx"
	.endif
	.endif
	.endif

(Note, I've not tested this approach.  If you can think of a better
way, please feel free to suggest.)

[...]

> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index 36e2d26b54f5..ac12f1b4f8e2 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -144,7 +144,17 @@ SYM_CODE_START_LOCAL(__finalise_el2)
>  
>  .Lskip_indirection:
>  .Lskip_tcr2:
> +	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
> +	ubfx	x1, x1, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> +	cbz	x1, .Lskip_sctlr2
> +	mrs_s	x1, SYS_SCTLR2_EL12
> +	msr_s	SYS_SCTLR2_EL1, x1
>  
> +	// clean SCTLR2_EL1
> +	mov_q	x1, INIT_SCTLR2_EL1
> +	msr_s	SYS_SCTLR2_EL12, x1

I'm still not sure why we need to do this.  The code doesn't seem to
clean up by the EL1 value of any other register -- or have I missed
something?

We have already switched to EL2, via the HVC call that jumped to
__finalise_el2.  We won't run at EL1 again unless KVM starts a guest --
but in that case, it's KVM's responsibility to set up the EL1 registers
before handing control to the guest.

In any case, is SCTLR2_EL1 ever set to anything except INIT_SCTLR2_EL1
before we get here?

[...]

Cheers
---Dave

