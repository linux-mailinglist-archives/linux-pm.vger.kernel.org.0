Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C450A4045A1
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 08:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhIIGed (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 02:34:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:55353 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhIIGec (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 02:34:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="207930752"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="207930752"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 23:33:23 -0700
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="693882541"
Received: from jax-mobl.gar.corp.intel.com ([10.213.103.124])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 23:33:20 -0700
Message-ID: <223a72d91cfda9b13230e4f8cd6a29f853535277.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Override parameters if HWP
 forced by BIOS
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Doug Smythies <doug.smythies@gmail.com>, rafael@kernel.org,
        len.brown@intel.com
Cc:     dsmythies@telus.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Wed, 08 Sep 2021 23:33:17 -0700
In-Reply-To: <20210909034802.1708-1-dsmythies@telus.net>
References: <20210909034802.1708-1-dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2021-09-08 at 20:48 -0700, Doug Smythies wrote:
> If HWP has been already been enabled by BIOS, it may be
> necessary to override some kernel command line parameters.
> Once it has been enabled it requires a reset to be disabled.
> 
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>  drivers/cpufreq/intel_pstate.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index bb4549959b11..073bae5d4498 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3267,7 +3267,7 @@ static int __init intel_pstate_init(void)
>                  */
>                 if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) ||
>                     intel_pstate_hwp_is_enabled()) {
> -                       hwp_active++;
> +                       hwp_active = 1;
Why this change?

>                         hwp_mode_bdw = id->driver_data;
>                         intel_pstate.attr = hwp_cpufreq_attrs;
>                         intel_cpufreq.attr = hwp_cpufreq_attrs;
> @@ -3347,17 +3347,27 @@ device_initcall(intel_pstate_init);
>  
>  static int __init intel_pstate_setup(char *str)
>  {
> +       /*
> +        * If BIOS is forcing HWP, then parameter
> +        * overrides might be needed. Only print
> +        * the message once, and regardless of
> +        * any overrides.
> +        */
> +       if(!hwp_active 
This part of code is from early_param, Is it possible that 
hwp_active is not 0?

> && boot_cpu_has(X86_FEATURE_HWP))
> +               if(intel_pstate_hwp_is_enabled()){
> +                       pr_info("HWP enabled by BIOS\n");
> +                       hwp_active = 1;
> +               }
>         if (!str)
>                 return -EINVAL;
>  
> -       if (!strcmp(str, "disable"))
> +       if (!strcmp(str, "disable") && !hwp_active)
>                 no_load = 1; 
> -       else if (!strcmp(str, "active"))
> +       if (!strcmp(str, "active"))
>                 default_driver = &intel_pstate;
> -       else if (!strcmp(str, "passive"))
> +       if (!strcmp(str, "passive"))
>                 default_driver = &intel_cpufreq;

Why "else if" changed to "if" ?


Thanks,
Srinivas

> -
> -       if (!strcmp(str, "no_hwp")) {
> +       if (!strcmp(str, "no_hwp") && !hwp_active) {
>                 pr_info("HWP disabled\n");
>                 no_hwp = 1;
>         }


