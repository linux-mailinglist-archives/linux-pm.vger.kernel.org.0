Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA373670D4
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 19:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbhDURCj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 13:02:39 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:39534 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbhDURCi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 13:02:38 -0400
Received: by mail-ot1-f49.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso34798696otv.6;
        Wed, 21 Apr 2021 10:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isMV/0Ztq3m+cwX8Y1FmhR9QizcZtauxZc7jOFA07iQ=;
        b=bgCp+/ymyeZ9gbyUBfLN9J4N5TQczNNccg+tL0VgYQfUnwxvBQ2C6iQdkviZwosJMA
         K5rX9kTBw28XYaPgR9L+aMu0nnEuWSPFnQtzleELo0wFWzjdHVD9Re9Lw4MuOp+MJTQv
         bGpurATA05sr5/5qNFE8GSg5+OfA1JSApK9p0U39x1LREbpXLFf9jAOnUiQalUTVppDM
         Z0dJb3kL0LJbP4JJ+b9lWhuqSufapXsOhptj3OZoubQLNifVQwuWkP+cBAhLwxXLXnsO
         /FOvHGJZ59mLaDi3J5smpuflmIfPidLMnmksrZGpL75ruw36fW5q3rfbvvskW5SmZ0gI
         KKrg==
X-Gm-Message-State: AOAM531sKY36IoWLJSNguEeVRa1b49wGqdSc2s1POQNX8P4/Jxhjg7CM
        vU1ZRWFVpzNAL48ZTW0UuzcwmyFXWmjXIFMwBsX2/WhW
X-Google-Smtp-Source: ABdhPJzwjVywIKpK9HBI2ZFAhU/IpOqdkjYQWu180Z4uP6SKCX4M6+H+WkHU9g/AbzdQvGK+CBxFHa4E/lReVndL2kQ=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr23499174otb.260.1619024523402;
 Wed, 21 Apr 2021 10:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210419215707.10290-1-amonakov@ispras.ru>
In-Reply-To: <20210419215707.10290-1-amonakov@ispras.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Apr 2021 19:01:52 +0200
Message-ID: <CAJZ5v0jDY3Ttz0_MecqSrvUFitU0B6d2nFEOi8QZNO=8iDAg=A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Kconfig: fix documentation links
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 20, 2021 at 12:03 AM Alexander Monakov <amonakov@ispras.ru> wrote:
>
> User documentation for cpufreq governors and drivers has been moved to
> admin-guide; adjust references from Kconfig entries accordingly.
>
> Remove references from undocumented cpufreq drivers, as well as the
> 'userspace' cpufreq governor, for which no additional details are
> provided in the admin-guide text.
>
> Fixes: 2a0e49279850 ("cpufreq: User/admin documentation update and consolidation")
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Rafael Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/cpufreq/Kconfig | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 85de313ddec2..c3038cdc6865 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -13,7 +13,8 @@ config CPU_FREQ
>           clock speed, you need to either enable a dynamic cpufreq governor
>           (see below) after boot, or use a userspace tool.
>
> -         For details, take a look at <file:Documentation/cpu-freq>.
> +         For details, take a look at
> +         <file:Documentation/admin-guide/pm/cpufreq.rst>.
>
>           If in doubt, say N.
>
> @@ -140,8 +141,6 @@ config CPU_FREQ_GOV_USERSPACE
>           To compile this driver as a module, choose M here: the
>           module will be called cpufreq_userspace.
>
> -         For details, take a look at <file:Documentation/cpu-freq/>.
> -
>           If in doubt, say Y.
>
>  config CPU_FREQ_GOV_ONDEMAND
> @@ -158,7 +157,8 @@ config CPU_FREQ_GOV_ONDEMAND
>           To compile this driver as a module, choose M here: the
>           module will be called cpufreq_ondemand.
>
> -         For details, take a look at linux/Documentation/cpu-freq.
> +         For details, take a look at
> +         <file:Documentation/admin-guide/pm/cpufreq.rst>.
>
>           If in doubt, say N.
>
> @@ -182,7 +182,8 @@ config CPU_FREQ_GOV_CONSERVATIVE
>           To compile this driver as a module, choose M here: the
>           module will be called cpufreq_conservative.
>
> -         For details, take a look at linux/Documentation/cpu-freq.
> +         For details, take a look at
> +         <file:Documentation/admin-guide/pm/cpufreq.rst>.
>
>           If in doubt, say N.
>
> @@ -246,8 +247,6 @@ config IA64_ACPI_CPUFREQ
>         This driver adds a CPUFreq driver which utilizes the ACPI
>         Processor Performance States.
>
> -       For details, take a look at <file:Documentation/cpu-freq/>.
> -
>         If in doubt, say N.
>  endif
>
> @@ -271,8 +270,6 @@ config LOONGSON2_CPUFREQ
>
>           Loongson2F and it's successors support this feature.
>
> -         For details, take a look at <file:Documentation/cpu-freq/>.
> -
>           If in doubt, say N.
>
>  config LOONGSON1_CPUFREQ
> @@ -282,8 +279,6 @@ config LOONGSON1_CPUFREQ
>           This option adds a CPUFreq driver for loongson1 processors which
>           support software configurable cpu frequency.
>
> -         For details, take a look at <file:Documentation/cpu-freq/>.
> -
>           If in doubt, say N.
>  endif
>
> @@ -293,8 +288,6 @@ config SPARC_US3_CPUFREQ
>         help
>           This adds the CPUFreq driver for UltraSPARC-III processors.
>
> -         For details, take a look at <file:Documentation/cpu-freq>.
> -
>           If in doubt, say N.
>
>  config SPARC_US2E_CPUFREQ
> @@ -302,8 +295,6 @@ config SPARC_US2E_CPUFREQ
>         help
>           This adds the CPUFreq driver for UltraSPARC-IIe processors.
>
> -         For details, take a look at <file:Documentation/cpu-freq>.
> -
>           If in doubt, say N.
>  endif
>
> @@ -318,8 +309,6 @@ config SH_CPU_FREQ
>           will also generate a notice in the boot log before disabling
>           itself if the CPU in question is not capable of rate rounding.
>
> -         For details, take a look at <file:Documentation/cpu-freq>.
> -
>           If unsure, say N.
>  endif
>
> --

Applied as 5.13 material, thanks!
