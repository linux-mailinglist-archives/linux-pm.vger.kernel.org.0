Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDA8380D24
	for <lists+linux-pm@lfdr.de>; Fri, 14 May 2021 17:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhENPct (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 May 2021 11:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbhENPcs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 May 2021 11:32:48 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCE0C061574
        for <linux-pm@vger.kernel.org>; Fri, 14 May 2021 08:31:37 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id c16so125345ilo.1
        for <linux-pm@vger.kernel.org>; Fri, 14 May 2021 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4qjl7DpmdiFL4QHuRO1KjC+QpNDLedNMiNr4q9jrz0=;
        b=OhD6TMKqRSENg6OUQOjbehTQCTNC+vWJ7P16mpJZEXosYwIOLK3pcVdrcan7ZhunWP
         6PxVVxwg/vmkvOhdb4BFO3d7GTRhiWRn9zrX5wyADGviAATpZ31/N8NZY4bKSBrZ4VFG
         0cdv520++VcV961qawAkNjSO+CobYw8nfdy5k+eETWcpztk9FrdKPQuYIQ2DQH3qfGSa
         XbqqJZ6kHJKte4UnmQ8ZL0rTDCK3ueMsgD0KNBnEoHDW1IqkuAb7s7iWUHP2JkQG17pM
         pdiIb65aKEWwXvQNE4EhZ2goLu7my2179FFY1omFtB9KihLu0e2qFG96mC4QbbvIoDN0
         CjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4qjl7DpmdiFL4QHuRO1KjC+QpNDLedNMiNr4q9jrz0=;
        b=BtZBdSF87OsZCCSqcXY8jlqQ9/AGBNea3Axa9cau8d96NCRmQycb5L2+qfzUBwXZMe
         4Fn+Ew9ch+AEeY32JBGz96IAr/zmuu8hv5zQVY94igt+SX2YSv+qW32TmyIqxzK2vNdv
         129Es/X/W7wYUTbZ3hcuLcDeumRyXroTRsCWVonKTzouNM7U0qC+6u7bBvLN3jQ72w/8
         C4bTIw/cqLaZrpaBpTZds8GRo+dAKONcsZFaFer5TWzeMHqCGKJ2p1UZ3RtK0tNOQtSs
         qy/J9Iji+Txkh9tcrcrKak/npETZs6dLFI+Jn4eok2sD6LJmrpc3Ski52KVDK6Zfwyj0
         pWWw==
X-Gm-Message-State: AOAM533VpS8aXLqbyHag0h+XhS2vypPmCqWa2e9ACyqx3zaBHmP1kZ6l
        3a7sBKPenAtNVV1q8mqTNd8pGWkMkJP/xMTlQjTpUQ==
X-Google-Smtp-Source: ABdhPJxW4THASuTUhaFDmufMv6BK/LiEvabejzLV7tBRek2jdQ6mhBk/vp5nMAK+0vbEq6UWDIkb7dVC6sEPK787iB8=
X-Received: by 2002:a05:6e02:54a:: with SMTP id i10mr3088214ils.252.1621006296613;
 Fri, 14 May 2021 08:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com> <20210513132051.31465-1-ggherdovich@suse.cz>
In-Reply-To: <20210513132051.31465-1-ggherdovich@suse.cz>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Fri, 14 May 2021 08:31:25 -0700
Message-ID: <CAAYoRsUcyFsFWDE=r+aMgDBa6hcgXgtE2jJ_NHas5e4TdgiBTg@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Add Icelake servers support in
 no-HWP mode
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

Can I on-board to this patch or do you want me to submit another?
I want to add COMETLAKE (tested), as below:

... Doug

On Thu, May 13, 2021 at 6:21 AM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> Users may disable HWP in firmware, in which case intel_pstate wouldn't load
> unless the CPU model is explicitly supported.
>
> Add ICELAKE_X to the list of CPUs that can register intel_pstate while not
> advertising the HWP capability. Without this change, an ICELAKE_X in no-HWP
> mode could only use the acpi_cpufreq frequency scaling driver.
>
> See also commit d8de7a44e11f ("cpufreq: intel_pstate: Add Skylake servers
> support").
>
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> ---
> This replaces https://lore.kernel.org/lkml/20210513075930.22657-1-ggherdovich@suse.cz
>
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index f0401064d7aa..28c9733e0dce 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2087,6 +2087,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
>         X86_MATCH(ATOM_GOLDMONT,        core_funcs),
>         X86_MATCH(ATOM_GOLDMONT_PLUS,   core_funcs),
>         X86_MATCH(SKYLAKE_X,            core_funcs),
> +       X86_MATCH(ICELAKE_X,            core_funcs),
   +       X86_MATCH(COMETLAKE,          core_funcs),
>         {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
> --
> 2.26.2
>
