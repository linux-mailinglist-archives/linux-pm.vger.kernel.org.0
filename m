Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62FB72CD77
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 20:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbjFLSGM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 12 Jun 2023 14:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjFLSGL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 14:06:11 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA1EE64
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 11:06:10 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9786c0cbfdcso91337666b.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 11:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686593168; x=1689185168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJ1c1rI+qR4VZGbrkoa9cGAXIoE0PF7cvyRtAcMAbXg=;
        b=k3gu6Ot/CFVC/dJ5Kp55/cv5QA2smNl0Z9jQLiM96mMK0qXvMj2YsJa+lXqr0RmvQJ
         TIBMLFwKc6DfzHWkWSBCQ0mz6y9qvWXZyvk0tWJQVjuElxjUtUnKEOX6xsEP0NK/yooL
         pI5f0Bd8HFqyuiZ/ZdN8k9jecxYaYLOt7rsTWOib2UugG4+wvD3LznAmRRwuCiRzvSHm
         nvCKPSi4n8cEC8uWZmbw19M2rKfr4d/twmVg/H+Hfcqy36eIeHZVgpqT6IPqyMtStpIk
         nb5ZX5ezxvF2lV0nBoXEltRIWUs174HdFyskmNIOYCWKv2LoIb2AjOpt7pDBVJgOJcXX
         ijCg==
X-Gm-Message-State: AC+VfDwKyVeKL6WGlQSF+dnfBWfKhqrTNxw86Vlv3DzuOrPoXP/qcP9o
        fXm6OylHFwKv8rTVjCkEkWfPJfTs+kaMmQN/4/0=
X-Google-Smtp-Source: ACHHUZ4h7yIPPwCwqUFTGS9BL3kkBVx/Q02MXMe8Iot0JbuzsYUieIhSd5Mo6ff6npxOKkgZyL65Tuj5AhYeM3NAOBI=
X-Received: by 2002:a17:906:7a41:b0:974:5de8:b5ce with SMTP id
 i1-20020a1709067a4100b009745de8b5cemr8338396ejo.2.1686593168443; Mon, 12 Jun
 2023 11:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230605154716.840930-1-arjan@linux.intel.com> <20230605154716.840930-4-arjan@linux.intel.com>
In-Reply-To: <20230605154716.840930-4-arjan@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 20:05:57 +0200
Message-ID: <CAJZ5v0hzyxEqvGUNAnk42qR-qeXc9+cD-HyTGF5mm=n65cTDbQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] intel_idle: Add support for using intel_idle in a VM
 guest using just hlt
To:     arjan@linux.intel.com
Cc:     linux-pm@vger.kernel.org, artem.bityutskiy@linux.intel.com,
        rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 5, 2023 at 5:47 PM <arjan@linux.intel.com> wrote:
>
> From: Arjan van de Ven <arjan@linux.intel.com>
>
> In a typical VM guest, the mwait instruction is not available, leaving only the
> 'hlt' instruction (which causes a VMEXIT to the host).
>
> So for this common case, intel_idle will detect the lack of mwait, and fail
> to initialize (after which another idle method would step in which will
> just use hlt always).
>
> Other (non-common) cases exist; the table below shows the before/after for these:
>
> +------------+--------------------------+-------------------------+
> | Hypervisor | Idle method before patch | Idle method after patch |
> | exposes    |                          |                         |
> +============+==========================+=========================+
> | nothing    | default_idle fallback    | intel_idle VM table     |
> | (common)   | (straight "hlt")         |                         |
> +------------+--------------------------+-------------------------+
> | mwait      | intel_idle mwait table   | intel_idle mwait table  |
> +------------+--------------------------+-------------------------+
> | ACPI       | ACPI C1 state ("hlt")    | intel_idle VM table     |
> +------------+--------------------------+-------------------------+
>
> By providing capability to do this with the intel_idle driver, we can
> do better than the fallback or ACPI table methods. While this current change
> only gets us to the existing behavior, later patches in this series
> will add new capabilities such as optimized TLB flushing.
>
> In order to do this, a simplified version of the initialization function
> for VM guests is created, and this will be called if the CPU is recognized,
> but mwait is not supported, and we're in a VM guest.
>
> One thing to note is that the max latency (and break even) of this C1 state
> is higher than the typical bare metal C1 state. Because hlt causes a vmexit,
> and the cost of vmexit + hypervisor overhead + vmenter is typically in the
> order of upto 5 microseconds... even if the hypervisor does not actually
> goes into a hardware power saving state.
>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 125 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 124 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 256c2d42e350..d2518cf36ab4 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -199,6 +199,43 @@ static __cpuidle int intel_idle_xstate(struct cpuidle_device *dev,
>         return __intel_idle(dev, drv, index);
>  }
>
> +static __always_inline int __intel_idle_hlt(struct cpuidle_device *dev,
> +                                       struct cpuidle_driver *drv, int index)
> +{
> +       raw_safe_halt();
> +       raw_local_irq_disable();
> +       return index;
> +}
> +
> +/**
> + * intel_idle_hlt - Ask the processor to enter the given idle state using hlt.
> + * @dev: cpuidle device of the target CPU.
> + * @drv: cpuidle driver (assumed to point to intel_idle_driver).
> + * @index: Target idle state index.
> + *
> + * Use the HLT instruction to notify the processor that the CPU represented by
> + * @dev is idle and it can try to enter the idle state corresponding to @index.
> + *
> + * Must be called under local_irq_disable().
> + */
> +static __cpuidle int intel_idle_hlt(struct cpuidle_device *dev,
> +                               struct cpuidle_driver *drv, int index)
> +{
> +       return __intel_idle_hlt(dev, drv, index);
> +}
> +
> +static __cpuidle int intel_idle_hlt_irq_on(struct cpuidle_device *dev,
> +                                   struct cpuidle_driver *drv, int index)
> +{
> +       int ret;
> +
> +       raw_local_irq_enable();
> +       ret = __intel_idle_hlt(dev, drv, index);
> +       raw_local_irq_disable();
> +
> +       return ret;
> +}
> +
>  /**
>   * intel_idle_s2idle - Ask the processor to enter the given idle state.
>   * @dev: cpuidle device of the target CPU.
> @@ -1242,6 +1279,18 @@ static struct cpuidle_state snr_cstates[] __initdata = {
>                 .enter = NULL }
>  };
>
> +static struct cpuidle_state vmguest_cstates[] __initdata = {
> +       {
> +               .name = "C1",
> +               .desc = "HLT",
> +               .flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_IRQ_ENABLE,
> +               .exit_latency = 5,
> +               .target_residency = 10,
> +               .enter = &intel_idle_hlt, },
> +       {
> +               .enter = NULL }
> +};
> +
>  static const struct idle_cpu idle_cpu_nehalem __initconst = {
>         .state_table = nehalem_cstates,
>         .auto_demotion_disable_flags = NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEMOTE,
> @@ -1841,6 +1890,16 @@ static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
>
>  static void state_update_enter_method(struct cpuidle_state *state, int cstate)
>  {
> +       if (state->enter == intel_idle_hlt) {
> +               if (force_irq_on) {
> +                       pr_info("forced intel_idle_irq for state %d\n", cstate);
> +                       state->enter = intel_idle_hlt_irq_on;
> +               }
> +               return;
> +       }
> +       if (state->enter == intel_idle_hlt_irq_on)
> +               return; /* no update scenarios */
> +
>         if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
>                 /*
>                  * Combining with XSTATE with IBRS or IRQ_ENABLE flags
> @@ -1874,6 +1933,29 @@ static void state_update_enter_method(struct cpuidle_state *state, int cstate)
>         }
>  }
>
> +/*
> + * For mwait based states, we want to verify the cpuid data to see if the state
> + * is actually supported by this specific CPU.
> + * For non-mwait based states, this check should be skipped.
> + */
> +static bool should_verify_mwait(struct cpuidle_state *state)
> +{
> +       if (state->enter == intel_idle_irq)
> +               return true;
> +       if (state->enter == intel_idle)
> +               return true;
> +       if (state->enter == intel_idle_ibrs)
> +               return true;
> +       if (state->enter == intel_idle_xstate)
> +               return true;

Since true is returned by default below, why are the above checks
necessary (or even useful for that matter)?

> +       if (state->enter == intel_idle_hlt)
> +               return false;
> +       if (state->enter == intel_idle_hlt_irq_on)
> +               return false;
> +
> +       return true;
> +}
> +
>  static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
>  {
>         int cstate;
> @@ -1922,7 +2004,7 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
>                 }
>
>                 mwait_hint = flg2MWAIT(cpuidle_state_table[cstate].flags);
> -               if (!intel_idle_verify_cstate(mwait_hint))
> +               if (should_verify_mwait(&cpuidle_state_table[cstate]) && !intel_idle_verify_cstate(mwait_hint))
>                         continue;
>
>                 /* Structure copy. */
> @@ -2056,6 +2138,45 @@ static void __init intel_idle_cpuidle_devices_uninit(void)
>                 cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_devices, i));
>  }
>
> +static int __init intel_idle_vminit(const struct x86_cpu_id *id)
> +{
> +       int retval;
> +
> +       cpuidle_state_table = vmguest_cstates;
> +
> +       icpu = (const struct idle_cpu *)id->driver_data;
> +
> +       pr_debug("v" INTEL_IDLE_VERSION " model 0x%X\n",
> +                boot_cpu_data.x86_model);
> +
> +       intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
> +       if (!intel_idle_cpuidle_devices)
> +               return -ENOMEM;
> +
> +       intel_idle_cpuidle_driver_init(&intel_idle_driver);
> +
> +       retval = cpuidle_register_driver(&intel_idle_driver);
> +       if (retval) {
> +               struct cpuidle_driver *drv = cpuidle_get_driver();
> +               printk(KERN_DEBUG pr_fmt("intel_idle yielding to %s\n"),
> +                      drv ? drv->name : "none");
> +               goto init_driver_fail;
> +       }
> +
> +       retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
> +                                  intel_idle_cpu_online, NULL);
> +       if (retval < 0)
> +               goto hp_setup_fail;
> +
> +       return 0;
> +hp_setup_fail:
> +       intel_idle_cpuidle_devices_uninit();
> +       cpuidle_unregister_driver(&intel_idle_driver);
> +init_driver_fail:
> +       free_percpu(intel_idle_cpuidle_devices);
> +       return retval;
> +}
> +
>  static int __init intel_idle_init(void)
>  {
>         const struct x86_cpu_id *id;
> @@ -2074,6 +2195,8 @@ static int __init intel_idle_init(void)
>         id = x86_match_cpu(intel_idle_ids);
>         if (id) {
>                 if (!boot_cpu_has(X86_FEATURE_MWAIT)) {
> +                       if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +                               return intel_idle_vminit(id);
>                         pr_debug("Please enable MWAIT in BIOS SETUP\n");
>                         return -ENODEV;
>                 }
> --
> 2.40.1
>
