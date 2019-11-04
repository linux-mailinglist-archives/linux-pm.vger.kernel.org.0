Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78CDAEDDAE
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 12:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfKDL2y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 06:28:54 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63005 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKDL2y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 06:28:54 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 0f4bedc1c9d8da7c; Mon, 4 Nov 2019 12:28:51 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cai@lca.pw
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix Invalid EPB setting
Date:   Mon, 04 Nov 2019 12:28:51 +0100
Message-ID: <5038220.5Ruqr03OBg@kreacher>
In-Reply-To: <20191031192620.23482-1-srinivas.pandruvada@linux.intel.com>
References: <20191031192620.23482-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, October 31, 2019 8:26:20 PM CET Srinivas Pandruvada wrote:
> The max value of EPB can be only be 0x0F. Setting more than that results
> in "unchecked MSR access error". During CPU offline via cpufreq stop_cpu()
> callback, this error condition is triggered in the function
> intel_pstate_hwp_force_min_perf().
> 
> Instead, EPB corresponding to preference to maximize energy saving (0x0F),
> can be set. But this will conflict with the save/restore done in
> arch/x86/kernel/cpu/intel_epb.c. Based on the test, if 0x0F is set in the
> function intel_pstate_hwp_force_min_perf(), this gets restored during next
> CPU online operation. This is not desired.
> 
> Hence don't set EPB in the offline path in this driver and let the
> processing in intel_epb.c handle EPB.
> 
> Fixes: af3b7379e2d70 ("cpufreq: intel_pstate: Force HWP min perf before offline")
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: 5.0+ <stable@vger.kernel.org> # 5.0+
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 53a51c169451..8ab31702cf6a 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -847,11 +847,9 @@ static void intel_pstate_hwp_force_min_perf(int cpu)
>  	value |= HWP_MAX_PERF(min_perf);
>  	value |= HWP_MIN_PERF(min_perf);
>  
> -	/* Set EPP/EPB to min */
> +	/* Set EPP to min */
>  	if (boot_cpu_has(X86_FEATURE_HWP_EPP))
>  		value |= HWP_ENERGY_PERF_PREFERENCE(HWP_EPP_POWERSAVE);
> -	else
> -		intel_pstate_set_epb(cpu, HWP_EPP_BALANCE_POWERSAVE);
>  
>  	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
>  }
> 

Applying as a fix for 5.4, thanks!




