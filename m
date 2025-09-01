Return-Path: <linux-pm+bounces-33573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5882BB3EA88
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 17:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E57484AC0
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 15:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9465E32A82F;
	Mon,  1 Sep 2025 15:13:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A9A32A82C;
	Mon,  1 Sep 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739614; cv=none; b=DVXmC+nkbqQTwVru9a1KaVLXYVvBHQP4jf0QmjopoxQBfdpSJx4fp117GYPQ1Fozg37DtgbqbcWjBHIL5NkdlNtzGQ7R95TNUtK0wyL3raEEvjJQxGV9HUPSvUYIAOlT1kLHmoHINTtD8GQ3YFusd5weiQA1cM+mt6zoYmtvqpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739614; c=relaxed/simple;
	bh=T/RAEzoBRkli0OidqH8/F4ZUiWPJufg9WZ3CV/HQrVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmF1F2Fu9XDZldIkKdrBlZh+ydYzdI3y5ABkm6uw6uvoius3Hdl9W7cVsByFyoGOKBDbI76XUjIRBjs/nW8jZl6SKZe1jP7JsvBuFDJhmydAyxI9rATylPuFLUa+dhrk93WKOuekMCN+eNNNuCPUMFgCI15VB8BV2QcWHo/X/1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26719175A;
	Mon,  1 Sep 2025 08:13:24 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 847B83F6A8;
	Mon,  1 Sep 2025 08:13:28 -0700 (PDT)
Date: Mon, 1 Sep 2025 16:13:25 +0100
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
Subject: Re: [PATCH v4 4/5] arm64: initialise SCTLR2_EL1 at cpu_soft_restart()
Message-ID: <aLW4FTcqommWSIej@e133380.arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
 <20250821172408.2101870-5-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821172408.2101870-5-yeoreum.yun@arm.com>

Hi,

On Thu, Aug 21, 2025 at 06:24:07PM +0100, Yeoreum Yun wrote:
> Explicitly initialize the SCTLR2_ELx register before launching
> a new kernel via kexec() to avoid leaving SCTLR2_ELx with an
> arbitrary value when the new kernel runs.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/kernel/cpu-reset.S      | 4 ++++
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S | 3 +++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
> index c87445dde674..c8888891dc8d 100644
> --- a/arch/arm64/kernel/cpu-reset.S
> +++ b/arch/arm64/kernel/cpu-reset.S
> @@ -37,6 +37,10 @@ SYM_TYPED_FUNC_START(cpu_soft_restart)
>  	 * regime if HCR_EL2.E2H == 1
>  	 */
>  	msr	sctlr_el1, x12
> +
> +	mov_q	x12, INIT_SCTLR2_EL1
> +	set_sctlr2_elx	1, x12, x8
> +

Nit: does it matter whether we reset SCTLR2 before SCTLR?

I can't find a convincing architectural reason why they need to be
reset in a particular order, but it looks a bit strange that the
cpu_soft_restart and __kvm_handle_stub_hvc versions of this reset the
registers in the opposite order...

>  	isb
>  
>  	cbz	x0, 1f				// el2_switch?
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> index aada42522e7b..cc569656fe35 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> @@ -255,6 +255,9 @@ SYM_CODE_START(__kvm_handle_stub_hvc)
>  	mov	x0, xzr
>  reset:
>  	/* Reset kvm back to the hyp stub. */
> +	mov_q 	x5, INIT_SCTLR2_EL2
> +	set_sctlr2_elx	2, x5, x4
> +
>  	mov_q	x5, INIT_SCTLR_EL2_MMU_OFF
>  	pre_disable_mmu_workaround
>  	msr	sctlr_el2, x5

Otherwise, I guess this is fine.

Cheers
---Dave

