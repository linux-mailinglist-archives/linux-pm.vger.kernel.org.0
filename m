Return-Path: <linux-pm+bounces-40414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D77E5D0113B
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 06:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC8C030049FC
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 05:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DBA2E8B8F;
	Thu,  8 Jan 2026 05:26:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E992D2DC762;
	Thu,  8 Jan 2026 05:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767849967; cv=none; b=XhIKrUFjaeO9bID+z3yQhU0+7tR4W3CoehRpHcleA8HrC1m0QkoRnRPtjb4ZHFBQ56owtiQEq/nBm0CtN/iNviiKNlT5EDPJGvIbaTY+jns152F4bjsa3tP2zz+yeWnKSlXcJdXPAH/9GgYwySk8MkfVarERnr7XqXehAWWSuOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767849967; c=relaxed/simple;
	bh=yQ8dOP1njGAQjodtQBLAOGpZ5EFxynpIfbjJZpxxevY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imTgxs1Xa98YOBL9JBrslAbYYQxfUqkqYr0wDmMW59XpztT+ae8h/1viVQpQZ8arx/HHv80aI2McPFmu9FmfxD+f/3vUwqPwy0N8oHz4LG32jp+XrK0nFD57hcHqUgA3tzAe3ZDcc+LU4JRkLqgKhrQ5RiZzSy6sURqIXn4aqHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F8EF497;
	Wed,  7 Jan 2026 21:25:46 -0800 (PST)
Received: from [10.163.83.134] (unknown [10.163.83.134])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A5F83F6A8;
	Wed,  7 Jan 2026 21:25:48 -0800 (PST)
Message-ID: <bcb570b2-1adf-43f5-9ef2-063cc7687046@arm.com>
Date: Thu, 8 Jan 2026 10:55:46 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: fix cleared E0POE bit after
 cpu_suspend()/resume()
To: Yeoreum Yun <yeoreum.yun@arm.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: rafael@kernel.org, pavel@kernel.org, catalin.marinas@arm.com,
 will@kernel.org, ryan.roberts@arm.com, yang@os.amperecomputing.com,
 joey.gouly@arm.com, kevin.brodsky@arm.com, stable@vger.kernel.org
References: <20260107162115.3292205-1-yeoreum.yun@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20260107162115.3292205-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/01/26 9:51 PM, Yeoreum Yun wrote:
> TCR2_ELx.E0POE is set during smp_init().
> However, this bit is not reprogrammed when the CPU enters suspension and
> later resumes via cpu_resume(), as __cpu_setup() does not re-enable E0POE
> and there is no save/restore logic for the TCR2_ELx system register.
> 
> As a result, the E0POE feature no longer works after cpu_resume().
> 
> To address this, save and restore TCR2_EL1 in the cpu_suspend()/cpu_resume()
> path, rather than adding related logic to __cpu_setup(), taking into account
> possible future extensions of the TCR2_ELx feature.
> 
> Cc: stable@vger.kernel.org
> Fixes: bf83dae90fbc ("arm64: enable the Permission Overlay Extension for EL0")
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
> 
> Patch History
> ==============
> from v1 to v2:
>   - following @Kevin Brodsky suggestion.
>   - https://lore.kernel.org/all/20260105200707.2071169-1-yeoreum.yun@arm.com/
> 
> NOTE:
>   This patch based on v6.19-rc4
> ---
>  arch/arm64/include/asm/suspend.h | 2 +-
>  arch/arm64/mm/proc.S             | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
> index e65f33edf9d6..e9ce68d50ba4 100644
> --- a/arch/arm64/include/asm/suspend.h
> +++ b/arch/arm64/include/asm/suspend.h
> @@ -2,7 +2,7 @@
>  #ifndef __ASM_SUSPEND_H
>  #define __ASM_SUSPEND_H
> 
> -#define NR_CTX_REGS 13
> +#define NR_CTX_REGS 14
>  #define NR_CALLEE_SAVED_REGS 12
> 
>  /*
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 01e868116448..5d907ce3b6d3 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -110,6 +110,10 @@ SYM_FUNC_START(cpu_do_suspend)
>  	 * call stack.
>  	 */
>  	str	x18, [x0, #96]
> +alternative_if ARM64_HAS_TCR2
> +	mrs	x2, REG_TCR2_EL1
> +	str	x2, [x0, #104]
> +alternative_else_nop_endif
>  	ret
>  SYM_FUNC_END(cpu_do_suspend)
> 
> @@ -144,6 +148,10 @@ SYM_FUNC_START(cpu_do_resume)
>  	msr	tcr_el1, x8
>  	msr	vbar_el1, x9
>  	msr	mdscr_el1, x10
> +alternative_if ARM64_HAS_TCR2
> +	ldr	x2, [x0, #104]
> +	msr	REG_TCR2_EL1, x2
> +alternative_else_nop_endif
> 
>  	msr	sctlr_el1, x12
>  	set_this_cpu_offset x13
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>


