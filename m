Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD14CDD03
	for <lists+linux-pm@lfdr.de>; Fri,  4 Mar 2022 19:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiCDS5J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Mar 2022 13:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiCDS5H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2022 13:57:07 -0500
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2771D6CBB
        for <linux-pm@vger.kernel.org>; Fri,  4 Mar 2022 10:56:19 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2db569555d6so101606637b3.12
        for <linux-pm@vger.kernel.org>; Fri, 04 Mar 2022 10:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HroceGyxULGyyCTtB40n1LusXNqdIYI2l3DTw0dUUsM=;
        b=ng1W1mLatRBqlUbY6oX0vFNSTedzznpdMpB1qstZ5POA4PssWMyEEXuPdBjYlD3PGt
         Cbv6NVvve3moRDaQngjSXVIKvWt1C7t2/1Bm5JGQcbV2skeSIQpbfClqyNZSvpo1aNk8
         Id7tdvviAnkA22prjLE5AUSxqhJZqfUWIW/SWP5zNeqeORsfFwCmF4r9PKJEBRqDVFx7
         si9bB3bipZCSXxq1c3cLcStMFlj2vT/1kd3ss3bHQyC+KXW9Ugw4bZOBhuOSdSwfm6Mk
         f+z9TbcQwHB2FYjAvxD3Lx42zSwJgB3iwcQSU3Sj56aBujl1al9RRhOEx9q57LwhBD4u
         id7A==
X-Gm-Message-State: AOAM532pD/EfHZL2g8QOMqoIRcW1C0d6fZcth+W3lNuYliXru8Z51MR8
        S1NWZb7Xhgs4yC8mbFqa7zBUKYFjpVU0U+bJnCA=
X-Google-Smtp-Source: ABdhPJwKx1iyR+xkMKnMvT651MaW6eCRoDmpZiJp8PcPxcj734ECrpKiO94uWWpH0tETYSE9FsYwsLjpEzpdWf8PlhU=
X-Received: by 2002:a81:1cd8:0:b0:2d6:b74b:5b55 with SMTP id
 c207-20020a811cd8000000b002d6b74b5b55mr41495093ywc.149.1646420178603; Fri, 04
 Mar 2022 10:56:18 -0800 (PST)
MIME-Version: 1.0
References: <20220302081600.1751716-1-dedekind1@gmail.com>
In-Reply-To: <20220302081600.1751716-1-dedekind1@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Mar 2022 19:56:07 +0100
Message-ID: <CAJZ5v0i8xd5KjwXOLKwkKMvZ0k-Nmqh8BEiZYtzmjRv9rWx=6A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] intel_idle: add SPR support
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 2, 2022 at 9:16 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> Add Sapphire Rapids Xeon support.
>
> Up until very recently, the C1 and C1E C-states were independent, but this
> has changed in some new chips, including Sapphire Rapids Xeon (SPR). In these
> chips the C1 and C1E states cannot be enabled at the same time. The "C1E
> promotion" bit in 'MSR_IA32_POWER_CTL' also has its semantics changed a bit.
>
> Here are the C1, C1E, and "C1E promotion" bit rules on Xeons before SPR.
>
> 1. If C1E promotion bit is disabled.
>    a. C1  requests end up with C1  C-state.
>    b. C1E requests end up with C1E C-state.
> 2. If C1E promotion bit is enabled.
>    a. C1  requests end up with C1E C-state.
>    b. C1E requests end up with C1E C-state.
>
> Here are the C1, C1E, and "C1E promotion" bit rules on Sapphire Rapids Xeon.
> 1. If C1E promotion bit is disabled.
>    a. C1  requests end up with C1 C-state.
>    b. C1E requests end up with C1 C-state.
> 2. If C1E promotion bit is enabled.
>    a. C1  requests end up with C1E C-state.
>    b. C1E requests end up with C1E C-state.
>
> Before SPR Xeon, the 'intel_idle' driver was disabling C1E promotion and was
> exposing C1 and C1E as independent C-states. But on SPR, C1 and C1E cannot be
> enabled at the same time.
>
> This patch adds both C1 and C1E states. However, C1E is marked as with the
> "CPUIDLE_FLAG_UNUSABLE" flag, which means that in won't be registered by
> default. The C1E promotion bit will be cleared, which means that by default
> only C1 and C6 will be registered on SPR.
>
> The next patch will add an option for enabling C1E and disabling C1 on SPR.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 47 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 0b66e25c0e2d..1c7c25909e54 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -761,6 +761,46 @@ static struct cpuidle_state icx_cstates[] __initdata = {
>                 .enter = NULL }
>  };
>
> +/*
> + * On Sapphire Rapids Xeon C1 has to be disabled if C1E is enabled, and vice
> + * versa. On SPR C1E is enabled only if "C1E promotion" bit is set in
> + * MSR_IA32_POWER_CTL. But in this case there effectively no C1, because C1
> + * requests are promoted to C1E. If the "C1E promotion" bit is cleared, then
> + * both C1 and C1E requests end up with C1, so there is effectively no C1E.
> + *
> + * By default we enable C1 and disable C1E by marking it with
> + * 'CPUIDLE_FLAG_UNUSABLE'.
> + */
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
> +               .name = "C1E",
> +               .desc = "MWAIT 0x01",
> +               .flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE | \
> +                                          CPUIDLE_FLAG_UNUSABLE,
> +               .exit_latency = 2,
> +               .target_residency = 4,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .name = "C6",
> +               .desc = "MWAIT 0x20",
> +               .flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency = 290,
> +               .target_residency = 800,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .enter = NULL }
> +};
> +
>  static struct cpuidle_state atom_cstates[] __initdata = {
>         {
>                 .name = "C1E",
> @@ -1104,6 +1144,12 @@ static const struct idle_cpu idle_cpu_icx __initconst = {
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
> @@ -1166,6 +1212,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,           &idle_cpu_skx),
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           &idle_cpu_icx),
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,           &idle_cpu_icx),
> +       X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &idle_cpu_spr),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,        &idle_cpu_knl),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &idle_cpu_knl),
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,       &idle_cpu_bxt),
> --

Applied as 5.18 material along with the rest of the series.

Thanks!
