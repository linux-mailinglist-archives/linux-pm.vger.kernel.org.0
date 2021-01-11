Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC772F10E0
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 12:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbhAKLM7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 06:12:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:49836 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbhAKLM7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Jan 2021 06:12:59 -0500
IronPort-SDR: UT4t2gbYd+bzgmE0+ozHgXlXzYfNGK5HGsZOBteM2ZswE6OvjtzpfVpYFbrkGI7/C/2R3v18tN
 IHcZFMLNmJFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="175265217"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="175265217"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 03:11:11 -0800
IronPort-SDR: 9PcpfJcInE5757IqGJ9eeWzQh5eSTfsETODmj/Wo4QxbpmrLMR//xlqZ3GHCyMzWfv1wZ84S3X
 89lg3ebf8wkA==
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="399763025"
Received: from kbrownfi-mobl2.amr.corp.intel.com ([10.212.201.85])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 03:11:06 -0800
Message-ID: <7a7de1fedb49489fddf7eac791149f546adccad1.camel@linux.intel.com>
Subject: Re: [PATCH 2/2][v2] cpufreq: intel_pstate: Get percpu max freq via
 HWP MSR register if available
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Chen Yu <yu.c.chen@intel.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
Date:   Mon, 11 Jan 2021 03:11:02 -0800
In-Reply-To: <0ca097c7bbf58415b1df150ea50cb37579f8f8ab.1610338353.git.yu.c.chen@intel.com>
References: <cover.1610338353.git.yu.c.chen@intel.com>
         <0ca097c7bbf58415b1df150ea50cb37579f8f8ab.1610338353.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-01-11 at 15:43 +0800, Chen Yu wrote:
> Currently when turbo is disabled(either by BIOS or by the user), the
> intel_pstate
> driver reads the max frequency from the package-wide
> MSR_PLATFORM_INFO(0xce) register.
> However on asymmetric platforms it is possible in theory that small
> and big core with
> HWP enabled might have different max cpu frequency
max non-turbo frequency (although code call max_freq).

Thanks,
Srinivas

> , because the MSR_HWP_CAPABILITIES
> is percpu scope according to Intel Software Developer Manual.
> 
> The turbo max freq is already percpu basis in current code, thus make
> similar change
> to the max non-turbo frequency as well.
> 
> Reported-by: Wendy Wang <wendy.wang@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2: per Srinivas' suggestion, avoid duplicated assignment of
> max_pstate.
> --
>  drivers/cpufreq/intel_pstate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index bd3dd1be73ba..f2d18991d969 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1725,11 +1725,9 @@ static void
> intel_pstate_max_within_limits(struct cpudata *cpu)
>  static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>  {
>         cpu->pstate.min_pstate = pstate_funcs.get_min();
> -       cpu->pstate.max_pstate = pstate_funcs.get_max();
>         cpu->pstate.max_pstate_physical =
> pstate_funcs.get_max_physical();
>         cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
>         cpu->pstate.scaling = pstate_funcs.get_scaling();
> -       cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu-
> >pstate.scaling;
>  
>         if (hwp_active && !hwp_mode_bdw) {
>                 unsigned int phy_max, current_max, guar_state;
> @@ -1737,8 +1735,12 @@ static void
> intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>                 intel_pstate_get_hwp_max(cpu, &phy_max, &current_max,
> &guar_state);
>                 cpu->pstate.turbo_freq = phy_max * cpu-
> >pstate.scaling;
>                 cpu->pstate.turbo_pstate = phy_max;
> +               cpu->pstate.max_pstate = guar_state;
> +               cpu->pstate.max_freq = guar_state * cpu-
> >pstate.scaling;
>         } else {
>                 cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate *
> cpu->pstate.scaling;
> +               cpu->pstate.max_pstate = pstate_funcs.get_max();
> +               cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu-
> >pstate.scaling;
>         }
>  
>         if (pstate_funcs.get_aperf_mperf_shift)


