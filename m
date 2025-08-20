Return-Path: <linux-pm+bounces-32722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D67ECB2E0DF
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 17:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80746188BD0F
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBA03218D6;
	Wed, 20 Aug 2025 15:11:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF82182D2;
	Wed, 20 Aug 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702707; cv=none; b=DQ4J8rzpwZsa3RhtxOdoLWi2eB/k31oGb0hL/k1PdH3YBNCbTeOiStRhQTc3QRTWyWsMH+GAT8JePl9vtJET/3J2FMZ9+ILLKanuk50OXFcKV4PWjmNGToPCuIYDN4TZXeoxiXD3FP6xxiy6dP9LNV9QYkvjLJIy0wA3NTmaubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702707; c=relaxed/simple;
	bh=FY133bXSAwJ+fLoRMi5RT8ETm2vZ9cJqP4tpL6la7+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDSJ7IHkdoDHu8jAfOFcY0XNc6CC4yF6SotrIN6NrjKqz4K7n9D2gcZW52Grk7+a+XW66xGuuH2kWIXE/kLtg1lHVU0YJEnUHLQTuSshqlTjIZDoc1zH9s+DjtCzsSpLkvs/NrtyzxphUMz7NfOPJywET5XnfcJbgVbL7p2nXfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 511A41D31;
	Wed, 20 Aug 2025 08:11:37 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9F0B3F738;
	Wed, 20 Aug 2025 08:11:41 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:11:38 +0100
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
Subject: Re: [PATCH v3 5/5] arm64: make the per-task SCTLR2_EL1
Message-ID: <aKXlqsnLyTL6lsh5@e133380.arm.com>
References: <20250813120118.3953541-1-yeoreum.yun@arm.com>
 <20250813120118.3953541-6-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813120118.3953541-6-yeoreum.yun@arm.com>

Hi,

On Wed, Aug 13, 2025 at 01:01:18PM +0100, Yeoreum Yun wrote:
> SCTLR2_EL1 register is optional starting from ARMv8.8/ARMv9.3,
> and becomes mandatory from ARMv8.9/ARMv9.4
> and serveral architectural feature are controled by bits in
> these registers and some of bits could be configurable per task
> not globally -- i.e) FEAT_CPA2 related field and etc.
> 
> For future usage of these fields, make the per-task SCTLR2_EL1.

It is worth pointing out the impact of this: for platforms without
FEAT_SCTLR2 support, there is no functional change and minimal
performance overhead.

> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/include/asm/processor.h | 5 +++++
>  arch/arm64/kernel/process.c        | 9 +++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 61d62bfd5a7b..2c962816de70 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -184,6 +184,7 @@ struct thread_struct {
>  	u64			mte_ctrl;
>  #endif
>  	u64			sctlr_user;
> +	u64			sctlr2_user;
>  	u64			svcr;
>  	u64			tpidr2_el0;
>  	u64			por_el0;
> @@ -258,6 +259,9 @@ static inline void task_set_sve_vl_onexec(struct task_struct *task,
>  	(SCTLR_ELx_ENIA | SCTLR_ELx_ENIB | SCTLR_ELx_ENDA | SCTLR_ELx_ENDB |   \
>  	 SCTLR_EL1_TCF0_MASK)
>  
> +#define SCTLR2_USER_MASK	\
> +	(SCTLR2_EL1_EnPACM0 | SCTLR2_EL1_CPTA0 | SCTLR2_EL1_CPTM0)
> +

The kernel doesn't know about any of these features, yet.

It's probably better to make this 0 for this patch series, and add bits
to this mask only when they are needed / used.

>  static inline void arch_thread_struct_whitelist(unsigned long *offset,
>  						unsigned long *size)
>  {
> @@ -370,6 +374,7 @@ struct task_struct;
>  unsigned long __get_wchan(struct task_struct *p);
>  
>  void update_sctlr_el1(u64 sctlr);
> +void update_sctlr2_el1(u64 sctlr2);

Is this function used outside process.c yet?  If not, you can drop this
declaration and [... below ...]
>  
>  /* Thread switching */
>  extern struct task_struct *cpu_switch_to(struct task_struct *prev,
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 96482a1412c6..9191180c4875 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -698,6 +698,11 @@ void update_sctlr_el1(u64 sctlr)
>  	isb();
>  }
>  
> +void update_sctlr2_el1(u64 sctlr2)

[...] make the function static here.


> +{
> +	sysreg_clear_set_s(SYS_SCTLR2_EL1, SCTLR2_USER_MASK, sctlr2);
> +}
> +
>  /*
>   * Thread switching.
>   */
> @@ -737,6 +742,10 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	if (prev->thread.sctlr_user != next->thread.sctlr_user)
>  		update_sctlr_el1(next->thread.sctlr_user);
>  
> +	if (alternative_has_cap_unlikely(ARM64_HAS_SCTLR2) &&
> +	    prev->thread.sctlr2_user != next->thread.sctlr2_user)
> +		update_sctlr2_el1(next->thread.sctlr2_user);
> +
>  	/* the actual thread switch */
>  	last = cpu_switch_to(prev, next);

[...]

Otherwise, I guess this looks OK.

Cheers
---Dave

