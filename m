Return-Path: <linux-pm+bounces-33697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D6AB41C21
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 12:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA3E5E4E6A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB422F28F2;
	Wed,  3 Sep 2025 10:43:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824DE2F1FE1;
	Wed,  3 Sep 2025 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896214; cv=none; b=j6usoTCBtSFC4B3N5gZ0PkcX/VHMxFD3gEeZqgFrojYE1hBBZ1JXoj2xGjqDcmoN0FOHDOEPvOcnRM0DOzSYL6vkk6LGKT1e2i9+vJZRMlru4hl+jjUOJT20qnMvIzC+WYmX6S+/eCSzh50I0drp+giZ85PVZgGdk3VVokwikkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896214; c=relaxed/simple;
	bh=0xgXK32LwH4jKgL1saEp2OIZ8OaGhKzMMdKC166g8RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+Fzk+y2NxkEcjVDNb0SukIwzfryVbOn3pla0coRgVduklBpAyrmhEqVR/XNauC0ntXhxMDPJNgw5yX0DPcOkR4n/O5D7/fKuqOhmNrildKJLp1IIH8tJqfX60moc/+8Q5jaNLoS64UfGudCidtjuYBgpIrJryEbxc6jvRoid0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0E321688;
	Wed,  3 Sep 2025 03:43:24 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DDAD3F6A8;
	Wed,  3 Sep 2025 03:43:28 -0700 (PDT)
Date: Wed, 3 Sep 2025 11:43:09 +0100
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
Message-ID: <aLgbvWYeCr5l1MF6@e133380.arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
 <20250821172408.2101870-3-yeoreum.yun@arm.com>
 <aLW4A3rTcJvA0c+j@e133380.arm.com>
 <aLXmCJOuxCHVXEYx@e129823.arm.com>
 <aLbJeQf9LKXFTxzS@e133380.arm.com>
 <aLbPjmy/ZYSd+wzA@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLbPjmy/ZYSd+wzA@e129823.arm.com>

Hi,

On Tue, Sep 02, 2025 at 12:05:50PM +0100, Yeoreum Yun wrote:
> Hi Dave,
> 
> [...]
> 
> > > > > diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> > > > > index 36e2d26b54f5..ac12f1b4f8e2 100644
> > > > > --- a/arch/arm64/kernel/hyp-stub.S
> > > > > +++ b/arch/arm64/kernel/hyp-stub.S
> > > > > @@ -144,7 +144,17 @@ SYM_CODE_START_LOCAL(__finalise_el2)
> > > > >
> > > > >  .Lskip_indirection:
> > > > >  .Lskip_tcr2:
> > > > > +	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
> > > > > +	ubfx	x1, x1, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> > > > > +	cbz	x1, .Lskip_sctlr2
> > > > > +	mrs_s	x1, SYS_SCTLR2_EL12
> > > > > +	msr_s	SYS_SCTLR2_EL1, x1
> > > > >
> > > > > +	// clean SCTLR2_EL1
> > > > > +	mov_q	x1, INIT_SCTLR2_EL1
> > > > > +	msr_s	SYS_SCTLR2_EL12, x1
> > > >
> > > > I'm still not sure why we need to do this.  The code doesn't seem to
> > > > clean up by the EL1 value of any other register -- or have I missed
> > > > something?
> > > >
> > > > We have already switched to EL2, via the HVC call that jumped to
> > > > __finalise_el2.  We won't run at EL1 again unless KVM starts a guest --
> > > > but in that case, it's KVM's responsibility to set up the EL1 registers
> > > > before handing control to the guest.
> > > >
> > > > In any case, is SCTLR2_EL1 ever set to anything except INIT_SCTLR2_EL1
> > > > before we get here?

[...]

> When I look at init_el2(), it returns to EL1 via:
> 
>   mov x0, #INIT_PSTATE_EL1
>   msr spsr_el2, x0
>   ...
>   eret
> 
> In other words, from init_kernel_el() through finalise_el2(),
> all system-register accesses are made at EL1 (i.e., SYS_REG_EL1).
> During this period, it appears that only SCTLR_EL1 is modified,
> so the code only needs to care about the accessed register — SCTLR_EL1.
> 
> That’s why SCTLR_EL1 is reinitialised at the end of finalise_el2().
> Otherwise, the MMU bit might remain enabled, which could cause errors later
> when launching a VM under VHE.
> 
> However, the idea behind this patch is to initialise SCTLR2_ELx
> the same way as SCTLR_ELx.
> I’m not sure whether SCTLR2_ELx is modified during this period.
> If it is (now or in the future),
> it should be cleared/reinitialised just like SCTLR_EL1.
> 
> This patch is based on the assumption that there may be modifications to
> SCTLR2_ELx during this period. So it isn’t about other system registers;
> it’s about the register actually used during this period.
> 
> Am I missing anything?
> 
> Thanks!
> 
> --
> Sincerely,
> Yeoreum Yun

I think I missed the SCTLR_EL1 reset in the idmap code after the
enter_vhe label.

Actually, I'm not sure whether there is any architectural reason for
setting SCTLR_EL1 to INIT_SCTLR_EL1_MMU_OFF here.  "for good measure"
suggests that it felt like a good idea but there was no known reason
for it.  The commit message for the original patch doesn't offer an
explanation -- maybe Marc can remember.

This might be a defence against speculative translation table walks
using the EL1&0 regime (but the architecture says [RNRJPP]: "If an
implementation is executing at EL3 or EL2, the PE is not permitted to
use the registers associated with the EL1&0 translation regime to
speculatively access memory or translation tables.")  So it shouldn't
really matter, but in case buggy CPUs don't implement this rule
properly it may be a good idea to turn the stage1 MMU off just in case.

Since it's there, though, it probably does make sense to reinitialise
SCTLR2_EL1 at the same time -- but can you move this so that it is next
to the SCTLR_EL1 reinitialisation?  Otherwise, the purpose of
reinitialising SCTLR2_EL1 is unclear.  It really should come under the
same "for good measure" justification as the SCTLR_EL1 reset.


However, I don't think this has anything to do with putting things into
a clean state for VMs.  KVM defines the reset state for all the _EL1
regs explicitly -- failing to do that would be a bug in KVM.

(See arch/arm64/kvm/sys_regs.c : sys_reg_descs[], kvm_reset_sys_regs().)

Cheers
---Dave

