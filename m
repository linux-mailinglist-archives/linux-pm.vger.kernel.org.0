Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EB93CBB41
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 19:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGPRh0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 13:37:26 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:36683 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhGPRhZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jul 2021 13:37:25 -0400
Received: by mail-ot1-f52.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10657996otl.3;
        Fri, 16 Jul 2021 10:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aN0V4F1Aj9SwjsmpapzhlvC9T2mVION7Ql9AGvw7OH8=;
        b=nYT59yw8a+e7C5dDHA/R544J/GiZH4hIqGbCX7B391Ys4kKi8LoE5Wyq8TgZtG+n3e
         ElHpKhNC7HeB7cx7fd/MO3Lya4/hsarQMCEIFTDU7H5JiKGpwLzpv47t4BJGkHb7oZfv
         +gkhydKL3zI3UntJNq7XB/TsTwtwaH5nPXCZsn9J22k6Vbh/zEa2YjthLcAxsv5Dstnt
         wCoka2e+rttL2z8E1WAe1MrgUdy/dVkxhYyTNCwCR0AoLDY6jpl0ade1VEh1wyz3/Vss
         /rWi4kf8WPJCTCYQZcJROf8XYxwRkTCaE6H7oWly2KMM+iqlvyM/tINtW3HWrLExKxk9
         fMSA==
X-Gm-Message-State: AOAM531MUI2kpIluk2S46OkIap+W/U7honDZSuOncKAp4Ew5DoVjt2mc
        NFefi7o5JZmFqiq3dPrgB8/EzuvypoXMm4cCx0g=
X-Google-Smtp-Source: ABdhPJxYhr3UbEFNFNp0jq2DWF5u0Fy6cb6G1PeobySFQ/O8TzZz6mnn2K1WPSYZMUixPlbXy8MjvYZqIplKNlKf5W0=
X-Received: by 2002:a05:6830:9a:: with SMTP id a26mr1902433oto.260.1626456870386;
 Fri, 16 Jul 2021 10:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210710130313.5072-1-chang.seok.bae@intel.com> <20210710130313.5072-26-chang.seok.bae@intel.com>
In-Reply-To: <20210710130313.5072-26-chang.seok.bae@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Jul 2021 19:34:19 +0200
Message-ID: <CAJZ5v0he2O=AAuravL8pppzBd+OTd=oGWH2Sv1JFhDfqET160A@mail.gmail.com>
Subject: Re: [PATCH v7 25/26] intel_idle/amx: Add SPR support with XTILEDATA capability
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, thiago.macieira@intel.com,
        jing2.liu@intel.com, "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jul 10, 2021 at 3:09 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> Add a custom Sapphire Rapids (SPR) C-state table to intel_idle driver. The
> parameters in this table are preferred over those supplied by ACPI.
>
> SPR supports AMX, and so this custom table uses idle entry points that know
> how to initialize AMX TMM state, if necessary.
>
> This guarantees that AMX TMM state will never be the cause of hardware
> C-state demotion from C6 to C1E. Under some conditions this may result in
> improved power savings, and thus higher available turbo frequency budget.
>
> [ Based on patch by Artem Bityutskiy <artem.bityutskiy@linux.intel.com>. ]
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
> Changes from v6:
> * Update the changelog and function description. (Rafael J. Wysocki)
>
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
> index e6c543b5ee1d..00f331b64131 100644
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

The parens should not be present here.

With this fixed:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> + *
> + * Leaving state in the dirty TILE registers may prevent the processor from
> + * entering lower-power idle states. Use TILERELEASE to initialize the
> + * state. Destroying fpregs state is safe after the fpstate update.
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
> + * Ensure TILE registers in INIT-state before using intel_idle() to
> + * enter the idle state.
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
> + * Ensure TILE registers in INIT-state before using intel_idle_s2idle() to
> + * enter the idle state.
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
> 2.17.1
>
