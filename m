Return-Path: <linux-pm+bounces-40387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5979CFF4F2
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 19:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5679300FA11
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68D33612EA;
	Wed,  7 Jan 2026 16:54:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5FB359718;
	Wed,  7 Jan 2026 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804869; cv=none; b=Jefjha1NjnsT6JVOfDoLiBvWqXN0jsUmQ+LGNruN9gNpiUH2YYdLx6zW10eMhHGvGg2232xc/CdfgcYa4KyqpQ2brFxBpIztML5PISLs17X3FXRIR6ZBTyyBYq0bsgHsGdwLcChvZfpxB7x0dDw2uOmisLYvrTHkVmyZ+b9PlTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804869; c=relaxed/simple;
	bh=ytOH4rPaPYZtl6XKeTgWh8ZjUPJ51XZhSmtYTjSD9e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAi5QXWHk+UYtjqnfnzKBOiormYOoGvtX6qRaQhmAgKhqPK4VJNsl9Puav8ToUqo6dgOK/xtSPvLtUjk5DTakB4wmK1ZhqVPL0QFFomc6S/uv0CpaNJ68X7kYSM17VZBKJURKgi3TzWDRJu1LerFYR/qmLdhq2sZgtpwEAX077I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45325497;
	Wed,  7 Jan 2026 08:54:08 -0800 (PST)
Received: from [10.57.46.202] (unknown [10.57.46.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B76E33F6A8;
	Wed,  7 Jan 2026 08:54:11 -0800 (PST)
Message-ID: <846e1998-b508-4433-9db6-3a52ff23552f@arm.com>
Date: Wed, 7 Jan 2026 17:54:09 +0100
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
 will@kernel.org, anshuman.khandual@arm.com, ryan.roberts@arm.com,
 yang@os.amperecomputing.com, joey.gouly@arm.com, stable@vger.kernel.org
References: <20260107162115.3292205-1-yeoreum.yun@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260107162115.3292205-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/01/2026 17:21, Yeoreum Yun wrote:
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

Maybe this could be pushed further down cpu_do_resume, next to DISR_EL1
maybe (since it's also conditional)? Otherwise the diff LGTM:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

- Kevin

>  	msr	sctlr_el1, x12
>  	set_this_cpu_offset x13
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

