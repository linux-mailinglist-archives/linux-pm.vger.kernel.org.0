Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6CA37F4C9
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 11:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhEMJZv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 05:25:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:15082 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhEMJZu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 May 2021 05:25:50 -0400
IronPort-SDR: QX7SX4+ijqnJUw2IKWrmjOEIewigFDrPwaVE5P1Q7pOTRl8Oj875l12cQpneblec5h/Fk02oJY
 nmcp8xGY22eA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187329059"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187329059"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 02:24:41 -0700
IronPort-SDR: H4Gqj9DacfSzWaR4kJIShugBfyL026qAkKauyCu13dsOPw64JHwCN3v+nhr+bYXOgMgjbDJvOK
 auOJGmQ0aLBA==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="431156491"
Received: from adithyav-mobl.amr.corp.intel.com ([10.212.100.160])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 02:24:37 -0700
Message-ID: <3fdc70c267d40561bed10fc722a8223a0b161200.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Force intel_pstate to load when
 HWP disabled in firmware
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 May 2021 02:24:32 -0700
In-Reply-To: <20210513075930.22657-1-ggherdovich@suse.cz>
References: <20210513075930.22657-1-ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-05-13 at 09:59 +0200, Giovanni Gherdovich wrote:
> On CPUs succeeding SKX, eg. ICELAKE_X, intel_pstate doesn't load
> unless
> CPUID advertises support for the HWP feature. Some OEMs, however, may
> offer
> users the possibility to disable HWP from the BIOS config utility by
> altering the output of CPUID.
Is someone providing a utility? What is the case for broken HWP?

It is possible that some user don't want to use HWP, because there
workloads works better without HWP. But that doesn't mean HWP is
broken.

Thanks,
Srinivas

> 
> Add the command line option "intel_pstate=hwp_broken_firmware" so
> that
> intel_pstate still loads in that case, providing OS-driven frequency
> scaling.
> 
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  Documentation/admin-guide/pm/intel_pstate.rst   | 7 +++++++
>  drivers/cpufreq/intel_pstate.c                  | 7 ++++++-
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index cb89dbdedc46..278ec0718dc9 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1951,6 +1951,13 @@
>                         per_cpu_perf_limits
>                           Allow per-logical-CPU P-State performance
> control limits using
>                           cpufreq sysfs interface
> +                       hwp_broken_firmware
> +                         Register intel_pstate as the scaling driver
> despite the
> +                         hardware-managed P-states (HWP) feature
> being disabled in
> +                         firmware. On CPU models succeeding SKX,
> intel_pstate expects
> +                         HWP to be supported. Some OEMs may use
> firmware that hides the
> +                         feature from the OS. With this option
> intel_pstate will
> +                         load regardless.
>  
>         intremap=       [X86-64, Intel-IOMMU]
>                         on      enable Interrupt Remapping (default)
> diff --git a/Documentation/admin-guide/pm/intel_pstate.rst
> b/Documentation/admin-guide/pm/intel_pstate.rst
> index df29b4f1f219..1e6f139d5b05 100644
> --- a/Documentation/admin-guide/pm/intel_pstate.rst
> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -689,6 +689,13 @@ of them have to be prepended with the
> ``intel_pstate=`` prefix.
>         Use per-logical-CPU P-State limits (see `Coordination of P-
> state
>         Limits`_ for details).
>  
> +``hwp_broken_firmware``
> +       Register ``intel_pstate`` as the scaling driver despite the
> +       hardware-managed P-states (HWP) feature being disabled in
> firmware.
> +
> +       On CPU models succeeding SKX, ``intel_pstate`` expects HWP to
> be
> +       supported. Some OEMs may use firmware that hides the feature
> from the
> +       OS. With this option ``intel_pstate`` will load regardless.
>  
>  Diagnostics and Tuning
>  ======================
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index f0401064d7aa..8635251f86f2 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2856,6 +2856,7 @@ static int intel_pstate_update_status(const
> char *buf, size_t size)
>  static int no_load __initdata;
>  static int no_hwp __initdata;
>  static int hwp_only __initdata;
> +static int hwp_broken_firmware __initdata;
>  static unsigned int force_load __initdata;
>  
>  static int __init intel_pstate_msrs_not_valid(void)
> @@ -3066,7 +3067,7 @@ static int __init intel_pstate_init(void)
>                 }
>         } else {
>                 id = x86_match_cpu(intel_pstate_cpu_ids);
> -               if (!id) {
> +               if (!id && !hwp_broken_firmware) {
>                         pr_info("CPU model not supported\n");
>                         return -ENODEV;
>                 }
> @@ -3149,6 +3150,10 @@ static int __init intel_pstate_setup(char
> *str)
>                 force_load = 1;
>         if (!strcmp(str, "hwp_only"))
>                 hwp_only = 1;
> +       if (!strcmp(str, "hwp_broken_firmware")) {
> +               pr_info("HWP disabled by firmware\n");
> +               hwp_broken_firmware = 1;
> +       }
>         if (!strcmp(str, "per_cpu_perf_limits"))
>                 per_cpu_limits = true;
>  


