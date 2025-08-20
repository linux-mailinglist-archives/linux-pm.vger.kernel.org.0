Return-Path: <linux-pm+bounces-32719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CA1B2E0D3
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 17:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D91B1888C35
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01A122256B;
	Wed, 20 Aug 2025 15:11:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E336A221FCD;
	Wed, 20 Aug 2025 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702668; cv=none; b=sk1jGV/3cFTsvZLL7t1cwmGdUMZ2FMD6+q3rYFMbO76YoRVjFRpcySVxnz2dtzYm1qbecPoNWOA5ojUw8/+TRgMbF8ndtJIsEziIphlBm1SjsnCupyqGg8PVBwygo7eTuerX4/SRGnqNQ6TUbi5ZGxVO/k8N5/6CEnwg0t+m6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702668; c=relaxed/simple;
	bh=2+45k/eayJk78EiBZf98Swzm7j75+IgBunkFoeNOH1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0Gx8uqLMiT4RRe3wfQvBZ/sFXIIuNb+sEEqo8xf2Hfa8/YBGIa8GG8nydkVO6aHKOfDk1WoeU03CFBmjUuk4xnhRG9XwC7iULY+CcuDyHm2aG+UM8kwxTbLmU97DEKZnbIS3GRHOgtVMGTQVwnQpBp7XPagZge4JEKxaRqxSDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E36E1D31;
	Wed, 20 Aug 2025 08:10:58 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96D5C3F738;
	Wed, 20 Aug 2025 08:11:02 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:10:59 +0100
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
Subject: Re: [PATCH v3 2/5] arm64: initialise SCTLR2_ELx register at boot time
Message-ID: <aKXlg1IMYUd7kQDv@e133380.arm.com>
References: <20250813120118.3953541-1-yeoreum.yun@arm.com>
 <20250813120118.3953541-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813120118.3953541-3-yeoreum.yun@arm.com>

Hi,

On Wed, Aug 13, 2025 at 01:01:15PM +0100, Yeoreum Yun wrote:
> SCTLR2_ELx register is optional starting from ARMv8.8/ARMv9.3,
> and becomes mandatory from ARMv8.9/ARMv9.4
> and serveral architectural feature are controled by bits in
> these registers.
> 
> These register's value is UNKNOWN when it was reset
> It wasn't need to be initialised if firmware initilises these registers
> properly.
> But for the case not initialised properly, initialise SCTLR2_ELx
> registers at bootin cpu/vcpu so that
> unexpected system behavior couldn't happen for
> improper SCTLR2_ELx value.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---

Please note significant changes under the tearoff line or in the cover
letter.

(Merging the __kvm_host_psci_cpu_entry() changes into this patch is a
significant change.)

>  arch/arm64/include/asm/assembler.h   | 22 ++++++++++++++++++++++
>  arch/arm64/include/asm/el2_setup.h   |  6 ++++++
>  arch/arm64/include/asm/sysreg.h      |  5 +++++
>  arch/arm64/kernel/head.S             |  5 +++++
>  arch/arm64/kernel/hyp-stub.S         | 10 ++++++++++
>  arch/arm64/kvm/hyp/nvhe/psci-relay.c |  3 +++
>  6 files changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 23be85d93348..eef169c105f0 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -738,6 +738,28 @@ alternative_endif
>  	set_sctlr sctlr_el2, \reg
>  .endm
> 
> +	/*
> +	 * Set SCTLR2_ELx to the @reg value.
> +	 */

One-line comment preferred:

	/* Set SCTLR2_ELx to the @reg value. */

(when the comment is short enough to fit).


Nit: can you follow the same indentation pattern as the "set_sctlr"
macros that appear above?

(I know, cond_yield etc. do things differently.  But the sctlr
accessors feel like they should belong together and look similar (as
far as possible).)


> +	.macro __set_sctlr2_elx, el, reg, tmp
> +	mrs_s	\tmp, SYS_ID_AA64MMFR3_EL1
> +	ubfx	\tmp, \tmp, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> +	cbz	\tmp, .Lskip_sctlr2_\@
> +	.if	\el == 2
> +	msr_s	SYS_SCTLR_EL2, \reg

Er, should this be SYS_SCTLR2_EL2 ?!

To make the code more readable at the call site, would it make sense
to have:

	msr_s	SYS_SCTLR2_\el, \reg

...?

This would mean that you can get rid of the lengthy .if...else, and the
assembler will report an error if the el argument is junk or missing.
(The argument would need to have an explicit EL prefix at the call
site.)

(At the moment, the code silently uses SCTLR(2)_EL1 when the el
argument is junk, which is not ideal.  Where it is easy to detect
stupid errors by the caller at build time, we should try to do it.)

> +	.elseif	\el == 12
> +	msr_s	SYS_SCTLR_EL12, \reg
> +	.else
> +	msr_s	SYS_SCTLR_EL1, \reg
> +	.endif
> +.Lskip_sctlr2_\@:
> +	.endm
> +
> +	.macro set_sctlr2_elx, el, reg, tmp
> +	__set_sctlr2_elx	\el, \reg, \tmp
> +	isb
> +	.endm
> +

Maybe we don't need two macros here?

__set_sctlr2_elx seems only to be used in one place.

The isb is needed when setting SCTLR2_ELx for the current EL, but 
the code at the call site knows whether this is the case.  It is
hard for the macro to know, and it feels overcomplicated to
explicitly check CurrentEL here.

I think it may be better to open-code the isb in the places where it
matters, including inside the __init_sctlr2_el2 macro.  (Compare with
the other __init_foo macros here.)

>  	/*
>  	 * Check whether asm code should yield as soon as it is able. This is
>  	 * the case if we are currently running in task context, and the
> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> index d755b4d46d77..c03cabd45fcf 100644
> --- a/arch/arm64/include/asm/el2_setup.h
> +++ b/arch/arm64/include/asm/el2_setup.h
> @@ -48,6 +48,11 @@
>  	isb
>  .endm
> 
> +.macro __init_sctlr2_el2
> +	mov_q	x0, INIT_SCTLR2_EL2
> +	set_sctlr2_elx	2, x0, x1
> +.endm
> +
>  .macro __init_el2_hcrx
>  	mrs	x0, id_aa64mmfr1_el1
>  	ubfx	x0, x0, #ID_AA64MMFR1_EL1_HCX_SHIFT, #4
> @@ -411,6 +416,7 @@
>   */
>  .macro init_el2_state
>  	__init_el2_sctlr
> +	__init_sctlr2_el2
>  	__init_el2_hcrx
>  	__init_el2_timers
>  	__init_el2_debug
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index d5b5f2ae1afa..0431b357b87b 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -868,6 +868,8 @@
>  #define INIT_SCTLR_EL2_MMU_OFF \
>  	(SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
> 
> +#define INIT_SCTLR2_EL2			UL(0)
> +
>  /* SCTLR_EL1 specific flags. */
>  #ifdef CONFIG_CPU_BIG_ENDIAN
>  #define ENDIAN_SET_EL1		(SCTLR_EL1_E0E | SCTLR_ELx_EE)
> @@ -888,6 +890,8 @@
>  	 SCTLR_EL1_LSMAOE | SCTLR_EL1_nTLSMD | SCTLR_EL1_EIS   | \
>  	 SCTLR_EL1_TSCXT  | SCTLR_EL1_EOS)
> 
> +#define INIT_SCTLR2_EL1			UL(0)
> +
>  /* MAIR_ELx memory attributes (used by Linux) */
>  #define MAIR_ATTR_DEVICE_nGnRnE		UL(0x00)
>  #define MAIR_ATTR_DEVICE_nGnRE		UL(0x04)
> @@ -1164,6 +1168,7 @@
>  	msr	hcr_el2, \reg
>  #endif
>  	.endm
> +
>  #else
> 
>  #include <linux/bitfield.h>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index ca04b338cb0d..c41015675eae 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -276,6 +276,8 @@ SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
>  	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
>  	pre_disable_mmu_workaround
>  	msr	sctlr_el1, x0
> +	mov_q	x0, INIT_SCTLR2_EL1
> +	__set_sctlr2_elx	1, x0, x1
>  	isb
>  	mov_q	x0, INIT_PSTATE_EL1
>  	msr	spsr_el1, x0
> @@ -308,6 +310,7 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
>  	isb
> 
>  	mov_q	x1, INIT_SCTLR_EL1_MMU_OFF
> +	mov_q	x2, INIT_SCTLR2_EL1
> 
>  	mrs	x0, hcr_el2
>  	and	x0, x0, #HCR_E2H
> @@ -315,11 +318,13 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
> 
>  	/* Set a sane SCTLR_EL1, the VHE way */
>  	msr_s	SYS_SCTLR_EL12, x1
> +	__set_sctlr2_elx	12, x2, x0
>  	mov	x2, #BOOT_CPU_FLAG_E2H
>  	b	3f
> 
>  2:
>  	msr	sctlr_el1, x1
> +	__set_sctlr2_elx	1, x2, x0
>  	mov	x2, xzr
>  3:
>  	mov	x0, #INIT_PSTATE_EL1
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

Is this code only applicable to the VHE case?  (I think this is
probably true, but it's not completely obvious just from the context in
this patch...)

Anyway, the pattern in this function is to transfer the "same EL"
controls over from the kernel into EL2, which is what the block above
does.


The next bit of code looks strange, though.

If we have committed to running the kernel at EL2, why does the code
reinitialise SCTLR2_EL1 here:

> +	// clean SCTLR2_EL1
> +	mov_q	x1, INIT_SCTLR2_EL1
> +	msr_s	SYS_SCTLR2_EL12, x1
> +
> +.Lskip_sctlr2:
>  	isb
> 
>  	// Hack the exception return to stay at EL2
> diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> index c3e196fb8b18..4ed4b7fa57c2 100644
> --- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> +++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> @@ -4,6 +4,7 @@
>   * Author: David Brazdil <dbrazdil@google.com>
>   */
> 
> +#include <asm/alternative.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_hyp.h>
>  #include <asm/kvm_mmu.h>
> @@ -219,6 +220,8 @@ asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
>  		release_boot_args(boot_args);
> 
>  	write_sysreg_el1(INIT_SCTLR_EL1_MMU_OFF, SYS_SCTLR);
> +	if (alternative_has_cap_unlikely(ARM64_HAS_SCTLR2))
> +		write_sysreg_el1(INIT_SCTLR2_EL1, SYS_SCTLR2);

Maybe drop the "unlikely" in this case?

Compared with context switch, this is a slow path -- so keeping the
code as simple as possible is desirable so long as the overall effect
on performance is not significant.

(It works either way, though.)

Cheers
---Dave

