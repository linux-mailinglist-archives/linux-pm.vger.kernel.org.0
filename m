Return-Path: <linux-pm+bounces-18915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC6C9EB2AC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 15:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29E0188CE0A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 14:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9741AAA28;
	Tue, 10 Dec 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wfq0ijbv"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DDE1AA1D4;
	Tue, 10 Dec 2024 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839421; cv=none; b=h3kKYnqNwZ+sbuDK7LepUdspwnW5NN7Hmq4IYcP9siMUqzYJjWXkQ1o1N1ugcFb6POdqK8URAhzyNglRjDS9X0FI3ifLNnxMZEoJyruXaG/8XPO0+55dTsRoqW839DtUkObmImy0QutLVbFjROeNMo+RJj2AFXPecYxeWzzmNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839421; c=relaxed/simple;
	bh=zTG4fHjEg4bJ3Q2xilmwlvZI7iL0vb3vM0NlpL34wL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sm98Yi9kPersJlGXE62MRHcKUcBbQzN1k27iqlTGxi2IGkvFd4CqSC1WQPxLIK6wshv9scIHA4thx1ScLFs9xXBfnrWOEpyquRpo7dJeuCtyFcE7urL098q5ot2pF+M4Tp3X6LoxHHwdDkglluNnbmTMd5NgrQwnBESNGF57Hw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wfq0ijbv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NyxUnnh8zTea5sHO0VySORIF1YgvOpupsnfvvjozSBg=; b=Wfq0ijbvY1Tc9H4xKq/T+ie90W
	ZtP7X9ap3/YutKDn7zuYK1iL+DyLRTNxtvZm9KCR99RlUGJdDa2CObnnOcqlc3bmp0qnrbd69GNo4
	atTxTdNOhMUzG0tgtXBd/KeHd8GNsR7i/m8dEE2sP7AuPgpqGrKaeZ1QZABENMTXDbUibrC6GE8fs
	0r+t4K6ztNURypWsEhjtjjVR5wtFJI9101qzdE/uZdt/HIDyBdxhAeHFIzs+JZdYmGMYHii5txSe0
	EdBlmtaLcaliEI4U6u9eAgFaaOhjCDVQk4a6vADkcqq/ZywQGwKH5I0k9g1lRiQfsQPG+6ZZU2xHy
	x49k4gUQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tL0pg-00000003gya-3R1x;
	Tue, 10 Dec 2024 14:03:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0C80330035F; Tue, 10 Dec 2024 15:03:24 +0100 (CET)
Date: Tue, 10 Dec 2024 15:03:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 2/5] cpuidle: Introduce CPUIDLE_FLAG_MWAIT
Message-ID: <20241210140324.GR35539@noisy.programming.kicks-ass.net>
References: <20241206130408.18690-1-frederic@kernel.org>
 <20241206130408.18690-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206130408.18690-3-frederic@kernel.org>

On Fri, Dec 06, 2024 at 02:04:05PM +0100, Frederic Weisbecker wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Provide a way to tell the cpuidle core about states monitoring
> TIF_NEED_RESCHED on the hardware level, monitor/mwait users being the
> only examples in use.
> 
> This will allow cpuidle core to manage TIF_NR_POLLING on behalf of all
> kinds of TIF_NEED_RESCHED watching states while keeping a necessary
> distinction for the governors between software loops polling on
> TIF_NEED_RESCHED and hardware monitored writes to thread flags.
> 
> [fweisbec: _ Initialize flag from acpi_processor_setup_cstates() instead
>              of acpi_processor_setup_lpi_states(), as the latter seem to
>              be about arm64...
>            _ Rename CPUIDLE_FLAG_NO_IPI to CPUIDLE_FLAG_MWAIT]
> 
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  drivers/acpi/processor_idle.c | 3 +++
>  drivers/idle/intel_idle.c     | 5 ++++-
>  include/linux/cpuidle.h       | 1 +
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 698897b29de2..66cb5536d91e 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -806,6 +806,9 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
>  		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2)
>  			drv->safe_state_index = count;
>  
> +		if (cx->entry_method == ACPI_CSTATE_FFH)
> +			state->flags |= CPUIDLE_FLAG_MWAIT;
> +
>  		/*
>  		 * Halt-induced C1 is not good for ->enter_s2idle, because it
>  		 * re-enables interrupts on exit.  Moreover, C1 is generally not
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index ac4d8faa3886..d52723fbeb04 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1787,7 +1787,8 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
>  		if (cx->type > ACPI_STATE_C1)
>  			state->target_residency *= 3;
>  
> -		state->flags = MWAIT2flg(cx->address);
> +		state->flags = MWAIT2flg(cx->address) | CPUIDLE_FLAG_MWAIT;
> +
>  		if (cx->type > ACPI_STATE_C2)
>  			state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
>  
> @@ -2072,6 +2073,8 @@ static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
>  
>  static void state_update_enter_method(struct cpuidle_state *state, int cstate)
>  {
> +	state->flags |= CPUIDLE_FLAG_MWAIT;
> +
>  	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
>  		/*
>  		 * Combining with XSTATE with IBRS or IRQ_ENABLE flags
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index a9ee4fe55dcf..b8084617aa27 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -85,6 +85,7 @@ struct cpuidle_state {
>  #define CPUIDLE_FLAG_OFF		BIT(4) /* disable this state by default */
>  #define CPUIDLE_FLAG_TLB_FLUSHED	BIT(5) /* idle-state flushes TLBs */
>  #define CPUIDLE_FLAG_RCU_IDLE		BIT(6) /* idle-state takes care of RCU */
> +#define CPUIDLE_FLAG_MWAIT		BIT(7) /* hardware need_resched() monitoring */
>  
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;
> -- 
> 2.46.0
> 

