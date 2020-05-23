Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB91DF364
	for <lists+linux-pm@lfdr.de>; Sat, 23 May 2020 02:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbgEWAEc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 20:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbgEWAEb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 20:04:31 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C2BC061A0E
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 17:04:30 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w3so6966516qkb.6
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 17:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I4oTDZ0SG8/GIH3rBRxYfT2nbMLHgnXLkHQH9l1K6YU=;
        b=bnZAzu4NWL2RpGBJiOTgnhW2jCEDO4kCGJ8mnreKdfAoKaC6WrSt42wURXU5i9UsLZ
         JePMyKjwSe0VE+6ugiGdNhyAk6t3JEbONSsQnk8WV5YClGpOQscl37m6GaGlSMYOpjmE
         o1WA3n9doz1R2c1XlzFmgtgN0I/uucEzSuZAMc+5zIPrDdc5kHRH5/NMQ875Kkh3r7rm
         Ab/GaftOEy8+NPcLZmXMt4+FumMitEyQirGh7Bz8wInF0WudbHW2d4WhfTBIdHMci6dI
         n+1NvCJt/F1XfAbbh6emJmp5Y4DALy8yQn2r6MV/9rhtusFCvCC/x813HTRpawUkuRJD
         j/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I4oTDZ0SG8/GIH3rBRxYfT2nbMLHgnXLkHQH9l1K6YU=;
        b=jjH4Va2NA+MEBWBxfo7s/rxjTd5SiEO8vACWgELFVqwtKxqz/Wskq2694ztPvAUsqr
         QYBGLL+Xfs76rtc2e+oEZBX8pVF+oTuhDOXE2UopLFY4+OwJFadHX3Bto16cjhcbQ+La
         GoEeVG5m6QdGNY0+bEkJZxB8MDYwzVYzlyOvvABrXK6rO7TpTC3EjUrTQQ4VW2vCGDF2
         NlKudNz3KxGpk561LkCCVyHuXALzmBCGIt+zIPiw+mzd5msAgdbgItKscUWxZV3cFDeW
         5qaouzFbtvdszB174Jy0fVF0t7b464KahgVLcyG2cZNzgsbRf5d/HMdmwT+D1qW1yKuR
         1msg==
X-Gm-Message-State: AOAM530qH+O7SO1e5D/IIxRY0z3g3q7v0VuMGO5E8KTl57x9F81lZ/kZ
        hObtmDTDeF23QDz+3wsUubooTA==
X-Google-Smtp-Source: ABdhPJxk4y5tFBnPUt8Aakl8oASL5WWPAyiiWNLr5TzmF97UdynfPSDexe6tFTK2lFpjJr7zmfgj5Q==
X-Received: by 2002:a37:bc7:: with SMTP id 190mr17264764qkl.286.1590192269906;
        Fri, 22 May 2020 17:04:29 -0700 (PDT)
Received: from Qians-MacBook-Air.local (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k20sm8395865qkk.30.2020.05.22.17.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 17:04:29 -0700 (PDT)
Date:   Fri, 22 May 2020 20:04:27 -0400
From:   Qian Cai <cai@lca.pw>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 3/9] intel_idle: Relocate definitions of cpuidle callbacks
Message-ID: <20200523000427.GF1337@Qians-MacBook-Air.local>
References: <2960689.qre192dJKD@kreacher>
 <2912140.PDVJEUYNKe@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2912140.PDVJEUYNKe@kreacher>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 11:00:26PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Move the definitions of intel_idle() and intel_idle_s2idle() before
> the definitions of cpuidle_state structures referring to them to
> avoid having to use additional declarations of them (and drop those
> declarations).
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/idle/intel_idle.c | 154 ++++++++++++++++++++++------------------------
>  1 file changed, 75 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 5adc058c705d..e0332d567735 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
[]
> +/**
> + * intel_idle - Ask the processor to enter the given idle state.
> + * @dev: cpuidle device of the target CPU.
> + * @drv: cpuidle driver (assumed to point to intel_idle_driver).
> + * @index: Target idle state index.
> + *
> + * Use the MWAIT instruction to notify the processor that the CPU represented by
> + * @dev is idle and it can try to enter the idle state corresponding to @index.
> + *
> + * If the local APIC timer is not known to be reliable in the target idle state,
> + * enable one-shot tick broadcasting for the target CPU before executing MWAIT.
> + *
> + * Optionally call leave_mm() for the target CPU upfront to avoid wakeups due to
> + * flushing user TLBs.
> + *
> + * Must be called under local_irq_disable().
> + */
> +static __cpuidle int intel_idle(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	struct cpuidle_state *state = &drv->states[index];
> +	unsigned long eax = flg2MWAIT(state->flags);
> +	unsigned long ecx = 1; /* break on interrupt flag */
> +	bool uninitialized_var(tick);

This will generate an UBSAN warning because Clang could poison all
uninitialized stack variables to 0xAA due to CONFIG_INIT_STACK_ALL=y, so one
issue is that,

bool uninitialized_var(x);

would always broken on Clang like this,

[   92.140611] UBSAN: invalid-load in drivers/idle/intel_idle.c:135:7
[   92.143111] load of value 170 is not a valid value for type 'bool' (aka '_Bool')
[   92.145657] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-rc6-next-20200522+ #3
[   92.147424] Hardware name: HP ProLiant BL660c Gen9, BIOS I38 10/17/2018
[   92.149869] Call Trace:
[   92.149869]  dump_stack+0x10b/0x17f
[   92.149869]  __ubsan_handle_load_invalid_value+0xd2/0x110
[   92.149869]  intel_idle+0x54/0xf0
[   92.156202]  cpuidle_enter_state+0x120/0x4f0
[   92.156202]  cpuidle_enter+0x5b/0xa0
[   92.156202]  call_cpuidle+0x25/0x50
[   92.156202]  do_idle+0x1eb/0x2c0
[   92.156202]  cpu_startup_entry+0x25/0x30
[   92.156202]  rest_init+0x26f/0x280
[   92.156202]  arch_call_rest_init+0x17/0x1e
[   92.156202]  start_kernel+0x598/0x633
[   92.156202]  x86_64_start_reservations+0x24/0x26
[   92.156202]  x86_64_start_kernel+0x116/0x1c1
[   92.156202]  secondary_startup_64+0xb6/0xc0

However, I am wondering if it is correct to let "tick" uninitialized to begin
with. If this condition is true,

!static_cpu_has(X86_FEATURE_ARAT) && lapic_timer_always_reliable

Then, we could in the final branch to use the uninitialized value.

if (!static_cpu_has(X86_FEATURE_ARAT) && tick)

Isn't that possible?

> +	int cpu = smp_processor_id();
> +
> +	/*
> +	 * leave_mm() to avoid costly and often unnecessary wakeups
> +	 * for flushing the user TLB's associated with the active mm.
> +	 */
> +	if (state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
> +		leave_mm(cpu);
> +
> +	if (!static_cpu_has(X86_FEATURE_ARAT) && !lapic_timer_always_reliable) {
> +		/*
> +		 * Switch over to one-shot tick broadcast if the target C-state
> +		 * is deeper than C1.
> +		 */
> +		if ((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK) {
> +			tick = true;
> +			tick_broadcast_enter();
> +		} else {
> +			tick = false;
> +		}
> +	}
> +
> +	mwait_idle_with_hints(eax, ecx);
> +
> +	if (!static_cpu_has(X86_FEATURE_ARAT) && tick)
> +		tick_broadcast_exit();
> +
> +	return index;
> +}
