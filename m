Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF52409AAC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 19:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbhIMR3W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 13:29:22 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:44030 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbhIMR3O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Sep 2021 13:29:14 -0400
Received: by mail-oi1-f170.google.com with SMTP id w19so15013707oik.10;
        Mon, 13 Sep 2021 10:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdKSajtGE1WLdR1EN0XVNqkFzr63oghr/1GUZ5MQ9jU=;
        b=WdhH25xgQSSCgQVurnR6FYISzqPuxlYoLOQu2CIZe0zrBk3oeZOJbfaZfbs9xf1hXH
         4+d24q4BjZgyNE/GW38zPYh0Fj0Yh+HB6XNHr0u/g6E85Ks6FXKAxJ2ANVATcd8l4Kgg
         PEXUoV/4mrqAWqZq1p7oTBg9TfHtu/lndcMAojv0Jenz97L+fCQam7x4R7n6vsmYYVnN
         RcY1qdZNfOK4tDr4MMWCM7RAx9HL12EdSXMQJ46du3zyUlzi8TAc1jhq2PdNzqPJSOow
         63VV7In36LdsWzST7NQXHm/a5+cpIftnFgY1qQXg/nmhttotkVZ2SOo0Ufrev9x7clWp
         PPpw==
X-Gm-Message-State: AOAM533eHz5c1bWdHIz2VhJPY2CMOsJbAPhu9NzecH5DmLbmtDpGbVrA
        8EowRij85PQWSJ++NCM6Pvnwwn8zXBk51Sq/W48=
X-Google-Smtp-Source: ABdhPJwCVw3Fu91YqcoFNhErZVn6L/bKGxexNKukCG+Ecu6T8MRCWnvEdZbFs2c3COaeJ2K53Y+eExfkfXZmYKYMfbQ=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr8277763ois.69.1631554077926;
 Mon, 13 Sep 2021 10:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210912185029.5704-1-dsmythies@telus.net>
In-Reply-To: <20210912185029.5704-1-dsmythies@telus.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Sep 2021 19:27:47 +0200
Message-ID: <CAJZ5v0g-fVO8_DGYtSF7e-VYc2Qzu60Ak0VK_f4x-V7dbO=+Eg@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Override parameters if HWP
 forced by BIOS
To:     Doug Smythies <doug.smythies@gmail.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 12, 2021 at 8:51 PM Doug Smythies <doug.smythies@gmail.com> wrote:
>
> If HWP has been already been enabled by BIOS, it may be
> necessary to override some kernel command line parameters.
> Once it has been enabled it requires a reset to be disabled.
>
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>  drivers/cpufreq/intel_pstate.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 1097f826ad70..8c176b7dae41 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3205,11 +3205,15 @@ static int __init intel_pstate_init(void)
>         if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
>                 return -ENODEV;
>
> -       if (no_load)
> -               return -ENODEV;
> -
>         id = x86_match_cpu(hwp_support_ids);
>         if (id) {
> +               bool hwp_forced = intel_pstate_hwp_is_enabled();
> +
> +               if (hwp_forced)
> +                       pr_info("HWP enabled by BIOS\n");
> +               else if (no_load)
> +                       return -ENODEV;
> +
>                 copy_cpu_funcs(&core_funcs);
>                 /*
>                  * Avoid enabling HWP for processors without EPP support,
> @@ -3219,8 +3223,7 @@ static int __init intel_pstate_init(void)
>                  * If HWP is enabled already, though, there is no choice but to
>                  * deal with it.
>                  */
> -               if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) ||
> -                   intel_pstate_hwp_is_enabled()) {
> +               if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) || hwp_forced) {
>                         hwp_active++;
>                         hwp_mode_bdw = id->driver_data;
>                         intel_pstate.attr = hwp_cpufreq_attrs;
> @@ -3235,7 +3238,11 @@ static int __init intel_pstate_init(void)
>
>                         goto hwp_cpu_matched;
>                 }
> +               pr_info("HWP not enabled\n");
>         } else {
> +               if (no_load)
> +                       return -ENODEV;
> +
>                 id = x86_match_cpu(intel_pstate_cpu_ids);
>                 if (!id) {
>                         pr_info("CPU model not supported\n");
> @@ -3314,10 +3321,9 @@ static int __init intel_pstate_setup(char *str)
>         else if (!strcmp(str, "passive"))
>                 default_driver = &intel_cpufreq;
>
> -       if (!strcmp(str, "no_hwp")) {
> -               pr_info("HWP disabled\n");
> +       if (!strcmp(str, "no_hwp"))
>                 no_hwp = 1;
> -       }
> +
>         if (!strcmp(str, "force"))
>                 force_load = 1;
>         if (!strcmp(str, "hwp_only"))
> --

Applied as 5.15-rc material, thanks!
