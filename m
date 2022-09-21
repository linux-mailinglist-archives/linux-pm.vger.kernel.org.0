Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA585E4F88
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 20:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiIUSgD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 14:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiIUSgA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 14:36:00 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EB8A346B
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 11:35:53 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id y2so4747987qtv.5
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 11:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1aLrfQPrCM99iAn4d4HOtatr6375HpQfIn6b8RN5r4Y=;
        b=69FLkIbS+dzvm3pmrJJ9/eqOIaY2mFe2d4CHPAwlDd6AjePSiA06FMohyDBAENrB3R
         nq1XobrvI/WMMecNOM6m5yaN49vyB1Xh2G5H+C/tPtb1LvWlnlQm60v6K4cL3aC3Ay3E
         EzQ3WDVr1uaR7k68P2jSSJk07UY5q60M4EQ7+4C6mTgzeS8RSd5zbkwfHuBGJ5tKI92L
         MP0knjYrqqUu/az0AZEqgqOSm5tq8y5G2TlwWwmtojdWU9Jd40RJG23dainlRbAkWu0x
         iS4H4VyDg2eXGcg1odwI20uJY4CiN1kKOp9Dbe5IVsaOHE8ej32JAPHSo3PZDC4jOu20
         CGqQ==
X-Gm-Message-State: ACrzQf1hqoCzC4AEOzOlWNzJFgcYPlGVMQKyI3mFlZN0UJ7ESPmJJ5sb
        IkZlvpTKhtAVQP1nqoyJiDHJfGSwZ4wrXRWhqNlo57ph
X-Google-Smtp-Source: AMsMyM5WzbAErhXFqTOQ4JJW3yXU92vwOxAZVfm2Lgmua71A2ABNAgA6IwX9smectq/qEQpQZPJB6CWdcMpldaJ0pq8=
X-Received: by 2002:a05:622a:1181:b0:35b:b57d:fb14 with SMTP id
 m1-20020a05622a118100b0035bb57dfb14mr24464928qtk.605.1663785352346; Wed, 21
 Sep 2022 11:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220920125848.32635-1-rui.zhang@intel.com>
In-Reply-To: <20220920125848.32635-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Sep 2022 20:35:41 +0200
Message-ID: <CAJZ5v0hEHx=yBdefx7UvtjsHWbOBbBTb_7AQ6UQ5Ec+PtGnORQ@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add AlderLake-N support
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>, vinay.kumar@intel.com,
        baieswara.reddy.sagili@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 20, 2022 at 2:56 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Similar to ther other AlderLake platforms, the C1 and C1E states on
> ADL-N are mutually exclusive. Only one of them can be enabled at a time.
> C1E is preferred on ADL-N for better energy efficiency.
>
> C6S is also supported on this platform. Its latency is far bigger than
> C6, but really close to C8 (PC8), thus it is not exposed as a separate
> state.
>
> Suggested-by: Baieswara Reddy Sagili <baieswara.reddy.sagili@intel.com>
> Suggested-by: Vinay Kumar <vinay.kumar@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/idle/intel_idle.c | 51 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 3e101719689a..8d56b06ddca4 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -928,6 +928,51 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
>                 .enter = NULL }
>  };
>
> +static struct cpuidle_state adl_n_cstates[] __initdata = {
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
> +               .exit_latency = 195,
> +               .target_residency = 585,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .name = "C8",
> +               .desc = "MWAIT 0x40",
> +               .flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency = 260,
> +               .target_residency = 1040,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .name = "C10",
> +               .desc = "MWAIT 0x60",
> +               .flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency = 660,
> +               .target_residency = 1980,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .enter = NULL }
> +};
> +
>  static struct cpuidle_state spr_cstates[] __initdata = {
>         {
>                 .name = "C1",
> @@ -1309,6 +1354,10 @@ static const struct idle_cpu idle_cpu_adl_l __initconst = {
>         .state_table = adl_l_cstates,
>  };
>
> +static const struct idle_cpu idle_cpu_adl_n __initconst = {
> +       .state_table = adl_n_cstates,
> +};
> +
>  static const struct idle_cpu idle_cpu_spr __initconst = {
>         .state_table = spr_cstates,
>         .disable_promotion_to_c1e = true,
> @@ -1379,6 +1428,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,           &idle_cpu_icx),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,           &idle_cpu_adl),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &idle_cpu_adl_l),
> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,         &idle_cpu_adl_n),
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &idle_cpu_spr),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,        &idle_cpu_knl),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &idle_cpu_knl),
> @@ -1816,6 +1866,7 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
>                 break;
>         case INTEL_FAM6_ALDERLAKE:
>         case INTEL_FAM6_ALDERLAKE_L:
> +       case INTEL_FAM6_ALDERLAKE_N:
>                 adl_idle_state_table_update();
>                 break;
>         }
> --

Applied (with some minor changelog edits) as 6.1 material, thanks!
