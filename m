Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE62318B1AD
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 11:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCSKpv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 06:45:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50753 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgCSKpv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 06:45:51 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 805a210eedc396b3; Thu, 19 Mar 2020 11:45:50 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 04/10] Revert "cpufreq: intel_pstate: Drop ->update_util from pstate_funcs"
Date:   Thu, 19 Mar 2020 11:45:49 +0100
Message-ID: <1617795.m7tDuoAjBp@kreacher>
In-Reply-To: <20200310214203.26459-5-currojerez@riseup.net>
References: <20200310214203.26459-1-currojerez@riseup.net> <20200310214203.26459-5-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, March 10, 2020 10:41:57 PM CET Francisco Jerez wrote:
> This reverts commit c4f3f70cacba2fa19545389a12d09b606d2ad1cf.  A
> future commit will introduce a new update_util implementation, so the
> pstate_funcs table entry is going to be useful.

This basically means that you want to introduce a new scaling algorithm.

In my view that needs to be exposed via scaling_governor so users can
switch over between this and the existing ones (powersave and performance).

That would require the cpufreq core to be updated somewhat to recognize
an additional CPUFREQ_POLICY_ value, but that should be perfectly doable.

And ->

> Signed-off-by: Francisco Jerez <currojerez@riseup.net>
> ---
>  drivers/cpufreq/intel_pstate.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 7fa869004cf0..8cb5bf419b40 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -277,6 +277,7 @@ static struct cpudata **all_cpu_data;
>   * @get_scaling:	Callback to get frequency scaling factor
>   * @get_val:		Callback to convert P state to actual MSR write value
>   * @get_vid:		Callback to get VID data for Atom platforms
> + * @update_util:	Active mode utilization update callback.
>   *
>   * Core and Atom CPU models have different way to get P State limits. This
>   * structure is used to store those callbacks.
> @@ -290,6 +291,8 @@ struct pstate_funcs {
>  	int (*get_aperf_mperf_shift)(void);
>  	u64 (*get_val)(struct cpudata*, int pstate);
>  	void (*get_vid)(struct cpudata *);
> +	void (*update_util)(struct update_util_data *data, u64 time,
> +			    unsigned int flags);
>  };
>  
>  static struct pstate_funcs pstate_funcs __read_mostly;
> @@ -1877,6 +1880,7 @@ static struct pstate_funcs core_funcs = {
>  	.get_turbo = core_get_turbo_pstate,
>  	.get_scaling = core_get_scaling,
>  	.get_val = core_get_val,
> +	.update_util = intel_pstate_update_util,
>  };
>  
>  static const struct pstate_funcs silvermont_funcs = {
> @@ -1887,6 +1891,7 @@ static const struct pstate_funcs silvermont_funcs = {
>  	.get_val = atom_get_val,
>  	.get_scaling = silvermont_get_scaling,
>  	.get_vid = atom_get_vid,
> +	.update_util = intel_pstate_update_util,
>  };
>  
>  static const struct pstate_funcs airmont_funcs = {
> @@ -1897,6 +1902,7 @@ static const struct pstate_funcs airmont_funcs = {
>  	.get_val = atom_get_val,
>  	.get_scaling = airmont_get_scaling,
>  	.get_vid = atom_get_vid,
> +	.update_util = intel_pstate_update_util,
>  };
>  
>  static const struct pstate_funcs knl_funcs = {
> @@ -1907,6 +1913,7 @@ static const struct pstate_funcs knl_funcs = {
>  	.get_aperf_mperf_shift = knl_get_aperf_mperf_shift,
>  	.get_scaling = core_get_scaling,
>  	.get_val = core_get_val,
> +	.update_util = intel_pstate_update_util,
>  };
>  
>  #define ICPU(model, policy) \
> @@ -2013,9 +2020,7 @@ static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
>  	/* Prevent intel_pstate_update_util() from using stale data. */
>  	cpu->sample.time = 0;
>  	cpufreq_add_update_util_hook(cpu_num, &cpu->update_util,
> -				     (hwp_active ?
> -				      intel_pstate_update_util_hwp :
> -				      intel_pstate_update_util));

-> it should be possible to extend this code to install an update_util matching
the scaling algo chosen by the user.

> +				     pstate_funcs.update_util);
>  	cpu->update_util_set = true;
>  }
>  
> @@ -2584,6 +2589,7 @@ static void __init copy_cpu_funcs(struct pstate_funcs *funcs)
>  	pstate_funcs.get_scaling = funcs->get_scaling;
>  	pstate_funcs.get_val   = funcs->get_val;
>  	pstate_funcs.get_vid   = funcs->get_vid;
> +	pstate_funcs.update_util = funcs->update_util;
>  	pstate_funcs.get_aperf_mperf_shift = funcs->get_aperf_mperf_shift;
>  }
>  
> @@ -2750,8 +2756,11 @@ static int __init intel_pstate_init(void)
>  	id = x86_match_cpu(hwp_support_ids);
>  	if (id) {
>  		copy_cpu_funcs(&core_funcs);
> -		if (!no_hwp) {
> +		if (no_hwp) {
> +			pstate_funcs.update_util = intel_pstate_update_util;
> +		} else {
>  			hwp_active++;
> +			pstate_funcs.update_util = intel_pstate_update_util_hwp;
>  			hwp_mode_bdw = id->driver_data;
>  			intel_pstate.attr = hwp_cpufreq_attrs;
>  			goto hwp_cpu_matched;
> 




