Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A13B50BA5C
	for <lists+linux-pm@lfdr.de>; Fri, 22 Apr 2022 16:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448607AbiDVOnu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Apr 2022 10:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448788AbiDVOnt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2022 10:43:49 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C6D5BE68
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2022 07:40:53 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2ef4a241cc5so87571477b3.2
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2022 07:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OlSK0GM7NNVVMzyxoMPAM462t1fSPrlLvFDxyrh1E8Q=;
        b=ivCJoqXK4raAusldXNSO1niJkl7rjI8aNcHz8HXNQdrhcd/54F775IeH5g4wdw+6MO
         Lutepis1k20ThlLUeCxiyZJjSPFOlHNtT6ZF2gT02h+O/9obdPjmilasuovccxIMs6yk
         wBSttGBefzTBW9yZzNKKKxpeh+w+YHl6KQvXM1okpAx07jBO8RptDhns/71RcuknqK+5
         T5rdB54qfXlmmjwvZwVaLUkUXQ1iIGxOm7F2m8Xci3BcZLLm4qeGree3bIzZr0TYHdEM
         9Rgvd8wT705L7V99N1KEpOSGRJYWvYax2fKy46OtObHYTguEcjtNW0n1RDcjnIzf0m8i
         Lr+w==
X-Gm-Message-State: AOAM531Wmv3gSU1JEsZFcykvBW80hmcNPhJd2KjBo72+SlmmCng+Snba
        UyBSEHEHLL/0Uns0qP/3GvO7JnkElewqVHJY4gtR5WxF
X-Google-Smtp-Source: ABdhPJwyLgtKdeTbZdheVfyPRiVvoVUYXS6oSIgBajn+CxUe1ofqgfQ+adUc3nVY3o2vr2ygbmr59ZDNuOwKGYag20o=
X-Received: by 2002:a81:4b8e:0:b0:2ef:5240:69fc with SMTP id
 y136-20020a814b8e000000b002ef524069fcmr5107548ywa.19.1650638452519; Fri, 22
 Apr 2022 07:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220421150736.94717-1-rui.zhang@intel.com>
In-Reply-To: <20220421150736.94717-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Apr 2022 16:40:41 +0200
Message-ID: <CAJZ5v0hopS-96rcQLP9Oj3mAzf8bbnAk-5svMYHqrOROtnGTeg@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: add support for RaptorLake
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Thu, Apr 21, 2022 at 9:12 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Add intel_rapl support for the RaptorLake platform.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 07611a00b78f..83da499dd6ec 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1107,6 +1107,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,          &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,           &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &rapl_defaults_core),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,          &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &rapl_defaults_spr_server),
>         X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,           &rapl_defaults_core),
>
> --

Applied as 5.19 material, thanks!
