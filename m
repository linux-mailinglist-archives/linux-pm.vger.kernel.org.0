Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F206750B935
	for <lists+linux-pm@lfdr.de>; Fri, 22 Apr 2022 15:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiDVN4w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Apr 2022 09:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390301AbiDVN4v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2022 09:56:51 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195145A0B1
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2022 06:53:58 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id b26so8966826ybj.13
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2022 06:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+wKXF1C1z3cNPqY2+JZ1orMB4GMwwxbP+dG+zGKcbY=;
        b=mS2PXPE5KEl2hIkbO2N5h/YzN1jUhC4hJDLSHhUZkQEQUUG8LVXEDZUXHYbXLghjDZ
         GktTb0Ad+OSeYbB37HCFaS1dfbkIqd8O/0CRU8Td3QWHMT73T3u0kbw0uTOMqcHA78Wm
         6NwrKkSca6I0iWO7v9ECao5BVQQ2kGDDrC2HO2E8cbPk5XQ5R1lTGKuSKrm4jmhLKFd4
         +rulqbbDWZRw9Azd3NAYfZ3xmnjF58F8tB3ktAhr5YkZ8QV/LmvruGxkF5JZpitr/G73
         CLpaOXz6/k9ots6UKMPV91cIjDSyeunrk+YPqFfuZYZ1HTGbFA5nlLTEHSpuKt39BSKa
         LZYw==
X-Gm-Message-State: AOAM531z9jmT/7KL+p8hWFW3WSqHHI/B6ncSwjnxqUxO84VQYRzbVBzI
        /oM5h1RLLLFdDG6sctYhskgMQlllvAa031K70S4=
X-Google-Smtp-Source: ABdhPJzBrB+8Y55d9IhEpAwsjhDu1DgguwDzrGZG3ivbp+5CDpPWTosgrtTam3/BFlyJYsErYk7pMYzq7/y9lPK/rgA=
X-Received: by 2002:a25:e792:0:b0:645:7ddb:b5eb with SMTP id
 e140-20020a25e792000000b006457ddbb5ebmr4482038ybh.482.1650635637350; Fri, 22
 Apr 2022 06:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220415093951.2677170-1-rui.zhang@intel.com>
In-Reply-To: <20220415093951.2677170-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Apr 2022 15:53:46 +0200
Message-ID: <CAJZ5v0jEFX-iv=NagN0MxYWEOGWjP5qbgPh=PL9wg5dUKDQiaQ@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: add AlderLake support
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 15, 2022 at 11:40 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Similar to SPR, the C1 and C1E states on ADL are mutually exclusive.
> Only one of them can be enabled at one time.
> But contrast to SPR, which usually has a strong latency requirement as a
> Xeon processor, C1E is preferred on ADL from the power' perspective of
> view.
>
> This patch adds both C1 and C1E states in the custom table, and
> 1. enables the "C1E promotion" bit in 'MSR_IA32_POWER_CTL' and mark C1
>    with the "CPUIDLE_FLAG_UNUSABLE" flag, thus C1 is not available by
>    default from both hardware and software.
> 2. adds support for "preferred_cstates" module parameter, so that user
>    can choose C1 instead of C1E by booting with
>    "intel_idle.preferred_cstates=2".
>
> Plus, separate custom cstate tables are introduced for the ADL mobile and
> desktop processors, because of the latency differences between these two
> processors, especially in PC10.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied as 5.19 material with some edits in the chamgelog, thanks!

> ---
>  drivers/idle/intel_idle.c | 137 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index b7640cfe0020..f738d08dc961 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -759,6 +759,106 @@ static struct cpuidle_state icx_cstates[] __initdata = {
>                 .enter = NULL }
>  };
>
> +/*
> + * On AlderLake C1 has to be disabled if C1E is enabled, and vice versa.
> + * C1E is enabled only if "C1E promotion" bit is set in MSR_IA32_POWER_CTL.
> + * But in this case there is effectively no C1, because C1 requests are
> + * promoted to C1E. If the "C1E promotion" bit is cleared, then both C1
> + * and C1E requests end up with C1, so there is effectively no C1E.
> + *
> + * By default we enable C1E and disable C1 by marking it with
> + * 'CPUIDLE_FLAG_UNUSABLE'.
> + */
> +static struct cpuidle_state adl_cstates[] __initdata = {
> +       {
> +               .name = "C1",
> +               .desc = "MWAIT 0x00",
> +               .flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_UNUSABLE,
> +               .exit_latency = 1,
> +               .target_residency = 1,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .name = "C1E",
> +               .desc = "MWAIT 0x01",
> +               .flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
> +               .exit_latency = 2,
> +               .target_residency = 4,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .name = "C6",
> +               .desc = "MWAIT 0x20",
> +               .flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency = 220,
> +               .target_residency = 600,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .name = "C8",
> +               .desc = "MWAIT 0x40",
> +               .flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency = 280,
> +               .target_residency = 800,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .name = "C10",
> +               .desc = "MWAIT 0x60",
> +               .flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency = 680,
> +               .target_residency = 2000,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .enter = NULL }
> +};
> +
> +static struct cpuidle_state adl_l_cstates[] __initdata = {
> +       {
> +               .name = "C1",
> +               .desc = "MWAIT 0x00",
> +               .flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_UNUSABLE,
> +               .exit_latency = 1,
> +               .target_residency = 1,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .name = "C1E",
> +               .desc = "MWAIT 0x01",
> +               .flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
> +               .exit_latency = 2,
> +               .target_residency = 4,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .name = "C6",
> +               .desc = "MWAIT 0x20",
> +               .flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency = 170,
> +               .target_residency = 500,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .name = "C8",
> +               .desc = "MWAIT 0x40",
> +               .flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency = 200,
> +               .target_residency = 600,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .name = "C10",
> +               .desc = "MWAIT 0x60",
> +               .flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency = 230,
> +               .target_residency = 700,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .enter = NULL }
> +};
> +
>  /*
>   * On Sapphire Rapids Xeon C1 has to be disabled if C1E is enabled, and vice
>   * versa. On SPR C1E is enabled only if "C1E promotion" bit is set in
> @@ -1142,6 +1242,14 @@ static const struct idle_cpu idle_cpu_icx __initconst = {
>         .use_acpi = true,
>  };
>
> +static const struct idle_cpu idle_cpu_adl __initconst = {
> +       .state_table = adl_cstates,
> +};
> +
> +static const struct idle_cpu idle_cpu_adl_l __initconst = {
> +       .state_table = adl_l_cstates,
> +};
> +
>  static const struct idle_cpu idle_cpu_spr __initconst = {
>         .state_table = spr_cstates,
>         .disable_promotion_to_c1e = true,
> @@ -1210,6 +1318,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,           &idle_cpu_skx),
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           &idle_cpu_icx),
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,           &idle_cpu_icx),
> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,           &idle_cpu_adl),
> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &idle_cpu_adl_l),
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &idle_cpu_spr),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,        &idle_cpu_knl),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &idle_cpu_knl),
> @@ -1570,6 +1680,29 @@ static void __init skx_idle_state_table_update(void)
>         }
>  }
>
> +/**
> + * adl_idle_state_table_update - Adjust AlderLake idle states table.
> + */
> +static void __init adl_idle_state_table_update(void)
> +{
> +       /* Check if user prefers C1 over C1E. */
> +       if (preferred_states_mask & BIT(1)) {
> +               if (preferred_states_mask & BIT(2))
> +                       /* Both can't be enabled, stick to the defaults. */
> +                       goto end;
> +
> +               cpuidle_state_table[0].flags &= ~CPUIDLE_FLAG_UNUSABLE;
> +               cpuidle_state_table[1].flags |= CPUIDLE_FLAG_UNUSABLE;
> +
> +               /* Disable C1E by clearing the "C1E promotion" bit. */
> +               disable_promotion_to_c1e = true;
> +               return;
> +       }
> +end:
> +       /* Make sure C1E is enabled by default */
> +       c1e_promotion_enable();
> +}
> +
>  /**
>   * spr_idle_state_table_update - Adjust Sapphire Rapids idle states table.
>   */
> @@ -1642,6 +1775,10 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
>         case INTEL_FAM6_SAPPHIRERAPIDS_X:
>                 spr_idle_state_table_update();
>                 break;
> +       case INTEL_FAM6_ALDERLAKE:
> +       case INTEL_FAM6_ALDERLAKE_L:
> +               adl_idle_state_table_update();
> +               break;
>         }
>
>         for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
> --
> 2.17.1
>
