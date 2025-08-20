Return-Path: <linux-pm+bounces-32721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77759B2E0E4
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 17:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5007C601447
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 15:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40D2BEC31;
	Wed, 20 Aug 2025 15:11:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E1F182D2;
	Wed, 20 Aug 2025 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702695; cv=none; b=KESd5lJERLf7TpaQzls2YTZs6BpxLufus9N1vurvX6+HaQNYeh2xwDvQCHwzFfMsz1BcqKFTt4trOiSAXlIsGbNCP8E1uFtf76vy+0EC+igwHq8p6v5oTfC3H9sXxA0sgTH5ns/tBYjB7WaDRl48/1GNnKtaMaAOOmpA+fkSlPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702695; c=relaxed/simple;
	bh=VO9xsHFrbCLcnL58Q9qnzWr6MpdRTRLszsyRW06VVfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsD7aMt9GEzNWqqS9x4P2pQD5iwpmoK/iArhSmua7Y6pQOkN/HAs5BUzD4taRpYEzRWLR8WhQgCx0G2nLpIUrKrsvQkaFQF79iAeUigb+TL1Cd5CSDS0+3CRv3AYex1bYpT1koKOtaqIMXtc6J2oVjRV/vu9NJ1mYi1Ivdeqm0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63D991D31;
	Wed, 20 Aug 2025 08:11:24 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9CFA3F738;
	Wed, 20 Aug 2025 08:11:28 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:11:25 +0100
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
Message-ID: <aKXlnZ8HXHBZMj4T@e133380.arm.com>
References: <20250813120118.3953541-1-yeoreum.yun@arm.com>
 <20250813120118.3953541-5-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813120118.3953541-5-yeoreum.yun@arm.com>

Hi,

On Wed, Aug 13, 2025 at 01:01:17PM +0100, Yeoreum Yun wrote:
> SCTLR2_EL1 register is optional starting from ARMv8.8/ARMv9.3,
> and becomes mandatory from ARMv8.9/ARMv9.4
> and serveral architectural feature are controled by bits in
> these registers.
> 
> Before, launching new kernel via kexec, initialise SCTLR2_EL1 explicitly.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/kernel/cpu-reset.S | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
> index c87445dde674..123564af345b 100644
> --- a/arch/arm64/kernel/cpu-reset.S
> +++ b/arch/arm64/kernel/cpu-reset.S
> @@ -37,6 +37,12 @@ SYM_TYPED_FUNC_START(cpu_soft_restart)
>  	 * regime if HCR_EL2.E2H == 1
>  	 */
>  	msr	sctlr_el1, x12
> +
> +alternative_if ARM64_HAS_SCTLR2
> +	mov_q	x12, INIT_SCTLR2_EL1
> +	msr_s	SYS_SCTLR2_EL1, x12
> +alternative_else_nop_endif
> +

It would be better to do this based on the ID regs.

Although the previous kernel _shouldn't_ have used SCTLR2 if the
capability ARM64_HAS_SCTLR2 did not get enabled, it would be better to
enforce a clean state here for the new kernel.

If so, maybe one of the macros that you already defined can be used
here?  (But it's also fine to open-code it.)

>  	isb
>  
>  	cbz	x0, 1f				// el2_switch?

[...]

In the case where the el2_switch argument in non-zero, don't we also
need to do something to reinitialise SCTLR2_EL2 after switching back
to EL2, in the HVC_SOFT_RESTART handler?

Maybe I missed something.

Cheers
---Dave

