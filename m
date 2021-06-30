Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878593B82B9
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 15:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhF3NOP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 09:14:15 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:41900 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbhF3NOM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 09:14:12 -0400
Received: by mail-oi1-f173.google.com with SMTP id t80so2960544oie.8;
        Wed, 30 Jun 2021 06:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gfuRluoromfET1e03HVVJ5VXuxUog7gz06YrJAltQ8=;
        b=J+g1EqB3LZM83mb6ZPJs1zl4bYyQNEaKbo8iPoY8KlwpjWHKlCFCLNb8oc3MvNRx77
         Pr07pb3YgNEhA+0Embb+vXZdBc0LXaMdCUSMeHynm3XbSs44+917D0CFvCfv8PWc+gIC
         zryaJhf4Q3tGC6ClSOooFTzgyzK4axpfxlSAE/u2M3g1Z+qCshRCz0qijoyWhp8+onUx
         1AEsiH2txpLULrPCslu1SIgeRf1tnG2BDAobHwz9A4sv6MnJ3iWPAdV9JSwEwVJ1UuHy
         9uU+gE9JHtAjfFq4eZ2zgLLk3ywjixYtMVUIi9sYHyGT0GmLvMAYIVZFvW1HVtAhTnnn
         o9IQ==
X-Gm-Message-State: AOAM5334YD3+io5daXVDJFHwVyp66V0bKbI52jFqwg8bIa54FB5YRTqG
        Zhub4cFUEpI2XLVgcb94R0Mrd3vjbST4Cbpjeec=
X-Google-Smtp-Source: ABdhPJw7IX3cgpJ7DCDo4orh1wVhRqWYVvW1zG2Txc4v0vOzFZAw0Q6D25EpqA0RZ2u1Rr0VrioFFQRc8PAsYGsMGFU=
X-Received: by 2002:a05:6808:15a6:: with SMTP id t38mr3048229oiw.157.1625058702849;
 Wed, 30 Jun 2021 06:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210630060226.24652-1-chang.seok.bae@intel.com> <20210630060226.24652-26-chang.seok.bae@intel.com>
In-Reply-To: <20210630060226.24652-26-chang.seok.bae@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jun 2021 15:11:31 +0200
Message-ID: <CAJZ5v0jn6pnwOj0tYO35kNj+WN5Htwc5gzA6GJdQDK+A3g4BLA@mail.gmail.com>
Subject: Re: [PATCH v6 25/26] intel_idle/amx: Clear the AMX state before
 entering idle
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, jing2.liu@intel.com,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 30, 2021 at 8:08 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> When AMX is enabled, initialize AMX state before going idle.
>
> This assures that the kernel will only request idle states with clean AMX
> state. In the case of the C6 idle state, this may allow the hardware to get
> to a deeper power saving condition.

At least the changelog needs to be improved, because the patch adds a
table of idle states for SPR, which is not mentioned here.

Also this is an optimization which is only done for SPR C6 in order to
increase the likelihood of entering this state in case the tile
registers are dirty when it is requested.

> [ Based on patch by Artem Bityutskiy <artem.bityutskiy@linux.intel.com>. ]
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
> Changes from v5:
> * Moved the code to intel_idle. (Peter Zijlstra)
> * Fixed to deactivate fpregs. (Andy Lutomirski and Dave Hansen)
> * Updated the code comment. (Dave Hansen)
>
> Changes from v4:
> * Added as a new patch. (Thomas Gleixner)
> ---
>  arch/x86/include/asm/special_insns.h |  6 +++
>  drivers/idle/intel_idle.c            | 79 ++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
>
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index f3fbb84ff8a7..fada1bb82c7b 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -294,6 +294,12 @@ static inline int enqcmds(void __iomem *dst, const void *src)
>         return 0;
>  }
>
> +static inline void tile_release(void)
> +{
> +       /* Instruction opcode for TILERELEASE; supported in binutils >= 2.36. */
> +       asm volatile(".byte 0xc4, 0xe2, 0x78, 0x49, 0xc0");
> +}
> +
>  #endif /* __KERNEL__ */
>
>  #endif /* _ASM_X86_SPECIAL_INSNS_H */
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index ec1b9d306ba6..a77c6d7a10e5 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -54,6 +54,8 @@
>  #include <asm/intel-family.h>
>  #include <asm/mwait.h>
>  #include <asm/msr.h>
> +#include <asm/fpu/internal.h>
> +#include <asm/special_insns.h>
>
>  #define INTEL_IDLE_VERSION "0.5.1"
>
> @@ -155,6 +157,55 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
>         return 0;
>  }
>
> +/**
> + * idle_tile() - Initialize TILE registers in INIT-state
> + *
> + * Leaving state in the dirty TILE registers may prevent the processor from
> + * entering lower-power idle states. Use TILERELEASE to initialize the
> + * state. Destroying fpregs state is safe after the fpstate update.
> + *
> + * Returns:    None

This is redundant for a void function.

> + */
> +static inline void idle_tile(void)
> +{
> +       if (boot_cpu_has(X86_FEATURE_XGETBV1) && (xgetbv(1) & XFEATURE_MASK_XTILE)) {
> +               tile_release();
> +               fpregs_deactivate(&current->thread.fpu);
> +       }
> +}
> +
> +/**
> + * intel_idle_tile - Ask the processor to enter the given idle state.
> + * @dev: cpuidle device of the target CPU.
> + * @drv: cpuidle driver (assumed to point to intel_idle_driver).
> + * @index: Target idle state index.
> + *
> + * Ensure TILE registers in INIT-state.

This is not the only thing done by the function.

> + */
> +static __cpuidle int intel_idle_tile(struct cpuidle_device *dev,
> +                                    struct cpuidle_driver *drv, int index)
> +{
> +       idle_tile();
> +
> +       return intel_idle(dev, drv, index);
> +}
> +
> +/**
> + * intel_idle_s2idle_tile - Ask the processor to enter the given idle state.
> + * @dev: cpuidle device of the target CPU.
> + * @drv: cpuidle driver (assumed to point to intel_idle_driver).
> + * @index: Target idle state index.
> + *
> + * Ensure TILE registers in INIT-state.

Same here.

> + */
> +static __cpuidle int intel_idle_s2idle_tile(struct cpuidle_device *dev,
> +                                           struct cpuidle_driver *drv, int index)
> +{
> +       idle_tile();
> +
> +       return intel_idle_s2idle(dev, drv, index);
> +}
> +
>  /*
>   * States are indexed by the cstate number,
>   * which is also the index into the MWAIT hint array.
> @@ -752,6 +803,27 @@ static struct cpuidle_state icx_cstates[] __initdata = {
>                 .enter = NULL }
>  };
>
> +static struct cpuidle_state spr_cstates[] __initdata = {
> +       {
> +               .name = "C1",
> +               .desc = "MWAIT 0x00",
> +               .flags = MWAIT2flg(0x00),
> +               .exit_latency = 1,
> +               .target_residency = 1,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .name = "C6",
> +               .desc = "MWAIT 0x20",
> +               .flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency = 128,
> +               .target_residency = 384,
> +               .enter = &intel_idle_tile,
> +               .enter_s2idle = intel_idle_s2idle_tile, },
> +       {
> +               .enter = NULL }
> +};
> +
>  static struct cpuidle_state atom_cstates[] __initdata = {
>         {
>                 .name = "C1E",
> @@ -1095,6 +1167,12 @@ static const struct idle_cpu idle_cpu_icx __initconst = {
>         .use_acpi = true,
>  };
>
> +static const struct idle_cpu idle_cpu_spr __initconst = {
> +       .state_table = spr_cstates,
> +       .disable_promotion_to_c1e = true,
> +       .use_acpi = true,
> +};
> +
>  static const struct idle_cpu idle_cpu_avn __initconst = {
>         .state_table = avn_cstates,
>         .disable_promotion_to_c1e = true,
> @@ -1157,6 +1235,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,           &idle_cpu_skx),
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           &idle_cpu_icx),
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,           &idle_cpu_icx),
> +       X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &idle_cpu_spr),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,        &idle_cpu_knl),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &idle_cpu_knl),
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,       &idle_cpu_bxt),
> --
