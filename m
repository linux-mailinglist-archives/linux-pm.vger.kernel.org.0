Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B296A24E447
	for <lists+linux-pm@lfdr.de>; Sat, 22 Aug 2020 02:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHVArW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 20:47:22 -0400
Received: from cmta17.telus.net ([209.171.16.90]:35744 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgHVArW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Aug 2020 20:47:22 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 9HgikQMyfYgvr9HgkkWUBK; Fri, 21 Aug 2020 18:47:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1598057239; bh=hlUDJ5ST80f1AO5TYhBYs0t+5xKCeLNh/7y2T2AZj0w=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=qOoQsQplcE6kJSLMMslU4TWXJbJmcItDui+L4GH8serM9Jd4Ynm1wjO43TGY2I7gp
         bMrMEYdYsKeOGOA46qI7RS/i7PyFrv2K4624jEPzuH0fVY5jHpjp4frGYvn32KA8eS
         OLOlioltj279BuC3LhiatoNVt1cKXEfMFCbJEPecFi7hN+EILCIWOjjUyP4qgfKAom
         gpWWPz363WgvuRXZZ5lXrI34PBN/cX7vAIaZXAaFlHScs0S+ED5lbu3tLXR5y2a+Yc
         QBWnq3BmtCO+ekqVUs6PbvQqNsxzD+7uWUoHx0MIvj5gZ5RJ+F/iD4S4qitln1i0cr
         yTcB0/+tjLzAw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=MIQeZ/Rl c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8
 a=gBtYq6a83Dkie4k6gS8A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <2283366.Lr8yYYnyev@kreacher> <1879185.C8Vd3vmt8n@kreacher>
In-Reply-To: <1879185.C8Vd3vmt8n@kreacher>
Subject: RE: [PATCH 3/4] cpufreq: intel_pstate: Add ->offline and ->online callbacks
Date:   Fri, 21 Aug 2020 17:47:16 -0700
Message-ID: <000501d6781d$c953def0$5bfb9cd0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdZ3EG3XorcUUxNqQrCUgF1ZBLd4VgA+ob2A
Content-Language: en-ca
X-CMAE-Envelope: MS4wfEAxiWoQus0jeBhvVzXaq5194q+rvRIu5j+0oBE1fS/5T4o+yHrvxzSTwtCeLocK61RrsGwdG2Vt6sWWDDaCsO1uvj55607SJHZQ7sLqp5vIW8FN6IBj
 Hzm8ZuEgLZif3TLCeU0rr6DZ52pd7JCiJyho9vmNxv5oc0qGsSrjPpHeDMaYzcm9epz50USJmpouG/RLQuT+bsXNdu5gsgijfxNd1fApGwiKPdgtJEErQA5+
 4Z+QkaPATdAMX7Z6BbeXn27WIMdRSyfWRwcxQzyVtI+iBn+xVrOP9quEsBL45yg4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Just annoying typo type feedback.

On 2020.08.20 09:38 Rafael J. Wysocki wrote:

> 
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Add ->offline and ->online driver callbacksto to do the cleanup

"to to" and suggest this:

Add ->offline and ->online driver callbacks to cleanup

> before taking a CPU offline and to restore its working configuration
> when it goes back online, respectively, to avoid invoking the ->init
> callback on every CPU online which is quite a bit of unnecessary
> overhead.
> 
> Define ->offline and ->online so that they can be used in the
> passive as well as in the active mode and because ->offline will

  passive mode

> do the majority of ->stop_cpu work, the passive mode does not
> need that callback any more, so drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 38 ++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 3d18934fa975..aca0587b176f 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2297,28 +2297,51 @@ static int intel_pstate_verify_policy(struct cpufreq_policy_data *policy)
>  	return 0;
>  }
> 
> -static void intel_cpufreq_stop_cpu(struct cpufreq_policy *policy)
> +static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
>  {
> +	pr_debug("CPU %d going offline\n", policy->cpu);
> +
> +	intel_pstate_exit_perf_limits(policy);
> +
> +	/*
> +	 * If the CPU is an SMT thread and it goes offline with the performance
> +	 * settings different from the minimum, it will prevent its sibling
> +	 * from getting to lower performance levels, so force the minimum
> +	 * performance on CPU offline to prevent that form happening.

form/from

> +	 */
>  	if (hwp_active)
>  		intel_pstate_hwp_force_min_perf(policy->cpu);
>  	else
>  		intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
> +
> +	return 0;
> +}
> +
> +static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
> +{
> +	pr_debug("CPU %d going online\n", policy->cpu);
> +
> +	intel_pstate_init_acpi_perf_limits(policy);
> +
> +	if (hwp_active)
> +		wrmsrl_on_cpu(policy->cpu, MSR_HWP_REQUEST,
> +			      all_cpu_data[policy->cpu]->hwp_req_cached);
> +
> +	return 0;
>  }
> 
>  static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
>  {
> -	pr_debug("CPU %d exiting\n", policy->cpu);
> +	pr_debug("CPU %d stopping\n", policy->cpu);
> 
>  	intel_pstate_clear_update_util_hook(policy->cpu);
>  	if (hwp_active)
>  		intel_pstate_hwp_save_state(policy);
> -
> -	intel_cpufreq_stop_cpu(policy);
>  }
> 
>  static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
>  {
> -	intel_pstate_exit_perf_limits(policy);
> +	pr_debug("CPU %d exiting\n", policy->cpu);
> 
>  	policy->fast_switch_possible = false;
> 
> @@ -2398,6 +2421,8 @@ static struct cpufreq_driver intel_pstate = {
>  	.init		= intel_pstate_cpu_init,
>  	.exit		= intel_pstate_cpu_exit,
>  	.stop_cpu	= intel_pstate_stop_cpu,
> +	.offline	= intel_pstate_cpu_offline,
> +	.online		= intel_pstate_cpu_online,
>  	.update_limits	= intel_pstate_update_limits,
>  	.name		= "intel_pstate",
>  };
> @@ -2652,7 +2677,8 @@ static struct cpufreq_driver intel_cpufreq = {
>  	.fast_switch	= intel_cpufreq_fast_switch,
>  	.init		= intel_cpufreq_cpu_init,
>  	.exit		= intel_cpufreq_cpu_exit,
> -	.stop_cpu	= intel_cpufreq_stop_cpu,
> +	.offline	= intel_pstate_cpu_offline,
> +	.online		= intel_pstate_cpu_online,
>  	.update_limits	= intel_pstate_update_limits,
>  	.name		= "intel_cpufreq",
>  };
> --
> 2.26.2
> 
> 


