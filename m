Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CB6675BC3
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jan 2023 18:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjATRlF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Jan 2023 12:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjATRlF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jan 2023 12:41:05 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D179456494
        for <linux-pm@vger.kernel.org>; Fri, 20 Jan 2023 09:41:03 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id mp20so15771656ejc.7
        for <linux-pm@vger.kernel.org>; Fri, 20 Jan 2023 09:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MB41ZujG7/9rd+TE8qPmR8WJ95sfEfHaPebIse7/w4Q=;
        b=SH/lxL9wFQqD9gdUv3Yw6aTlbz/PjC+WOpJ6K+Bbw6Go5aiEvoIvFbl9mf+NqxbPGH
         FA5JUvM+B7T3eswOw+32cmnQziJJyO2XNCrxppw5dzreFskmkNUm6um2PVHWD3bBci7k
         Ku/nFNMgny8ySZaYx+2bQ9V0r2h3dCd7lMKTbYgm7tNZ3J5uG8p7/6aBNcFGASlNKRuN
         wnD2AKDFjVpfWhyzNesEd/mAV84lLY0mb5HEARLRWIQkmKVW3oKypVM7Gn+UJ9Q+jzRM
         gyIEwGZBJWB5qQ1iCkzH7r/rdf0pHFTstPJ0Zx6FCPZ5OLEdqyJnZPJIme78+SA7Khw5
         i9Lw==
X-Gm-Message-State: AFqh2kpzKg2VMJNgd95GvCXWan1Xw567lzL/ix1JDJDmF1LiodpYFr7T
        VE+kLuC90XG1voB8Da6ofPRYAwnvtbWwXyzypN0=
X-Google-Smtp-Source: AMrXdXs+PH6YXsCsw5sBYyaGHQuN+VbfXom4HAmMCRTBcMEWp07RlaWUFDSWB9U2tpfBfCaAAUpr+RPQMhfMF8c/7rc=
X-Received: by 2002:a17:906:1684:b0:871:9c0:1ef5 with SMTP id
 s4-20020a170906168400b0087109c01ef5mr2154119ejd.500.1674236462427; Fri, 20
 Jan 2023 09:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20230120091528.142625-1-dedekind1@gmail.com>
In-Reply-To: <20230120091528.142625-1-dedekind1@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 18:40:51 +0100
Message-ID: <CAJZ5v0hO1JjM+3Z3V_wQjTagGPrnQfA+N3p8ZmBuf+97=Mk+YQ@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: add Emerald Rapids Xeon support
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>
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

On Fri, Jan 20, 2023 at 10:15 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> Emerald Rapids (EMR) is the next Intel Xeon processor after Sapphire Rapids
> (SPR). EMR C-states are the same as SPR C-states, and we expect that EMR
> C-state characteristics (latency and target residency) will be the same as in
> SPR. Therefore, this patch adds EMR support by using SPR C-states table.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index cfeb24d40d37..bb3d10099ba4 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1430,6 +1430,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &idle_cpu_adl_l),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,         &idle_cpu_adl_n),
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &idle_cpu_spr),
> +       X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,     &idle_cpu_spr),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,        &idle_cpu_knl),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &idle_cpu_knl),
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,       &idle_cpu_bxt),
> @@ -1862,6 +1863,7 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
>                 skx_idle_state_table_update();
>                 break;
>         case INTEL_FAM6_SAPPHIRERAPIDS_X:
> +       case INTEL_FAM6_EMERALDRAPIDS_X:
>                 spr_idle_state_table_update();
>                 break;
>         case INTEL_FAM6_ALDERLAKE:
> --

Applied as 6.3 material, thanks!
