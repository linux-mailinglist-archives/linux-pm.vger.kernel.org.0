Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3782F323D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 14:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbhALNxm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 08:53:42 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:43307 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbhALNxl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 08:53:41 -0500
Received: by mail-ot1-f43.google.com with SMTP id q25so2265016otn.10;
        Tue, 12 Jan 2021 05:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Uv3tHz4SVDQ8ChUOK2jqRxCBNv/7IX85UqJB4CJwco=;
        b=R5FOtwxQS2aZioOK9x350fo1IjWDBgeWLUtY5Z0ZIUB0Bs7QvsMj/Xgw6MYgDEyc5G
         guM4D5U/n9gwgD+OR+dqzcGINfn8BX2AE5L2rvL5G+G0/4EmASE+LW0CE8SNz5vycgVg
         xnZhcU8zHLkxxGI0AgoE155XDTVlxtOi9r2My4RExTFXYZMXPVX0weZ9e18CAFvFWaSi
         PJCHmHdR6G+IaGo6pLF+DAETT/hGLZ6VGeUygK8Us7pRGuwGCaTXuFyt83PNn84Q6B4r
         h5XjKV/5FRO8rZrA5h4JIaPqiT4oSuhOcgpT7csxMyOUInnuO23usQf/E9+d2HbISelW
         VjfA==
X-Gm-Message-State: AOAM531kLxVfmZmwA1En4gUdmNQXJTQ1uRhg4OhWWCWg+/aQWMVCoD+T
        Mrx3x4ngFipyf4azxk00CdfWQN12LONG0rdxAoE=
X-Google-Smtp-Source: ABdhPJw8z6PmPcN4jbSqyN/xmXo4Xqs1o5eZdsLVM8HqAMwOmnWm41qyyZPPCklrikWgkDtdJUMOZvfHD8134QhgGDM=
X-Received: by 2002:a9d:7191:: with SMTP id o17mr2837075otj.321.1610459581014;
 Tue, 12 Jan 2021 05:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20210112052127.4557-1-yu.c.chen@intel.com>
In-Reply-To: <20210112052127.4557-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jan 2021 14:52:50 +0100
Message-ID: <CAJZ5v0i5jdp6YcpvVuLyxGePRAsFPUPL6=iQC7PEFSzjNRUJLw@mail.gmail.com>
Subject: Re: [PATCH][v3] cpufreq: intel_pstate: Get percpu max freq via HWP
 MSR register if available
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 12, 2021 at 6:19 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Currently when turbo is disabled(either by BIOS or by the user), the
> intel_pstate driver reads the max non-turbo frequency from the package-wide
> MSR_PLATFORM_INFO(0xce) register. However on asymmetric platforms it is
> possible in theory that small and big core with HWP enabled might have
> different max non-turbo cpu frequency, because the MSR_HWP_CAPABILITIES
> is percpu scope according to Intel Software Developer Manual.
>
> The turbo max freq is already percpu basis in current code, thus make
> similar change to the max non-turbo frequency as well.
>
> Reported-by: Wendy Wang <wendy.wang@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2: Per Srinivas' suggestion, avoid duplicated assignment of max_pstate.
> v3: Per Rafael's suggestion, do not add new argument in intel_pstate_get_hwp_max()
>     to avoid redundant local vars.
>     Per Srinivas' suggestion, refined the commit log to reflect the 'non-turbo'
>     max frequency.

Looks good now, thanks!

Is it needed in -stable and if so, which -stable series should it go into?

> --
>  drivers/cpufreq/intel_pstate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index eaf32ef7a030..99e180f644c3 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1724,11 +1724,9 @@ static void intel_pstate_max_within_limits(struct cpudata *cpu)
>  static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>  {
>         cpu->pstate.min_pstate = pstate_funcs.get_min();
> -       cpu->pstate.max_pstate = pstate_funcs.get_max();
>         cpu->pstate.max_pstate_physical = pstate_funcs.get_max_physical();
>         cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
>         cpu->pstate.scaling = pstate_funcs.get_scaling();
> -       cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
>
>         if (hwp_active && !hwp_mode_bdw) {
>                 unsigned int phy_max, current_max;
> @@ -1736,9 +1734,12 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>                 intel_pstate_get_hwp_max(cpu, &phy_max, &current_max);
>                 cpu->pstate.turbo_freq = phy_max * cpu->pstate.scaling;
>                 cpu->pstate.turbo_pstate = phy_max;
> +               cpu->pstate.max_pstate = HWP_GUARANTEED_PERF(READ_ONCE(cpu->hwp_cap_cached));
>         } else {
>                 cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
> +               cpu->pstate.max_pstate = pstate_funcs.get_max();
>         }
> +       cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
>
>         if (pstate_funcs.get_aperf_mperf_shift)
>                 cpu->aperf_mperf_shift = pstate_funcs.get_aperf_mperf_shift();
> --
> 2.17.1
>
