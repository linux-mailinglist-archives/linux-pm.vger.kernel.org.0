Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32E528B616
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 15:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgJLNWx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 09:22:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:30218 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbgJLNWx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Oct 2020 09:22:53 -0400
IronPort-SDR: U5Z2K33Ih0PM74he7Ky+t7/wEmjAZQHAyWywPcXF+1K0R5RsKpkXGGY5wXJVy4Uk9Pne9eZG/2
 Q7Le+qW5ZyNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="145058659"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="145058659"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 06:22:52 -0700
IronPort-SDR: 2u0JEWs5FttLeBkwYWr9XNFVFwfNSatW82ERDKeFWGFp8Ybww0hJBw21NO4MgojtMj7UfJAiVj
 DclbRii/7rvg==
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="529954737"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 06:22:52 -0700
Message-ID: <ae351673692472b5ff5a482debc2de9060ffdd5e.camel@linux.intel.com>
Subject: Re: [RFC][PATCH] cpufreq: intel_pstate: Delete intel_pstate sysfs
 if failed to register the driver
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Chen Yu <yu.c.chen@intel.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Oct 2020 06:22:40 -0700
In-Reply-To: <20201009033038.23157-1-yu.c.chen@intel.com>
References: <20201009033038.23157-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-10-09 at 11:30 +0800, Chen Yu wrote:
> There is a corner case that if the intel_pstate driver failed to be
> registered(might be due to invalid MSR access) 
Do you have logs why it is not loaded? On supported platforms MSRs
should be invalid.
It may be a case when we are trying to bring up pre-production systems
where some instability in MSRs on certain CPUs. 

But the patch is correct. We can't have invalid folder when
intel_pstate is not used. 

> and with the acpi_cpufreq
> loaded, the intel_pstate sysfs might still be created, which makes
> the
> user confusing(turbostat for example):
> 
> grep . /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
> acpi-cpufreq
> 
> grep . /sys/devices/system/cpu/intel_pstate/*
> /sys/devices/system/cpu/intel_pstate/max_perf_pct:0
> /sys/devices/system/cpu/intel_pstate/min_perf_pct:0
> grep: /sys/devices/system/cpu/intel_pstate/no_turbo: Resource
> temporarily unavailable
> grep: /sys/devices/system/cpu/intel_pstate/num_pstates: Resource
> temporarily unavailable
> /sys/devices/system/cpu/intel_pstate/status:off
> grep: /sys/devices/system/cpu/intel_pstate/turbo_pct: Resource
> temporarily unavailable
> 
> The existing of intel_pstate sysfs does not mean that the
> intel_pstate driver
> has been successfully loaded(for example, echo off to status), but
> the
> intel_pstate sysfs should not co-exist when acpi-cpufreq is also
> present.
> Fix this issue by deleting the intel_pstate sysfs if the driver
> failed
> to be loaded during bootup.
> 
> Reported-by: Wendy Wang <wendy.wang@intel.com>
> Suggested-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com


> --->
>  drivers/cpufreq/intel_pstate.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 9a515c460a00..8c5f9680de83 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1420,6 +1420,26 @@ static void __init
> intel_pstate_sysfs_expose_params(void)
>  	}
>  }
>  
> +static void __init intel_pstate_sysfs_clean(void)
> +{
> +	if (!intel_pstate_kobject)
> +		return;
> +
> +	sysfs_remove_group(intel_pstate_kobject,
> &intel_pstate_attr_group);
> +
> +	if (per_cpu_limits)
> +		goto release_kobj;
> +
> +	sysfs_remove_file(intel_pstate_kobject, &max_perf_pct.attr);
> +	sysfs_remove_file(intel_pstate_kobject, &min_perf_pct.attr);
> +
> +	if (x86_match_cpu(intel_pstate_cpu_ee_disable_ids))
> +		sysfs_remove_file(intel_pstate_kobject,
> &energy_efficiency.attr);
> +
> +release_kobj:
> +	kobject_put(intel_pstate_kobject);
> +}
> +
>  static void intel_pstate_sysfs_expose_hwp_dynamic_boost(void)
>  {
>  	int rc;
> @@ -3063,8 +3083,10 @@ static int __init intel_pstate_init(void)
>  	mutex_lock(&intel_pstate_driver_lock);
>  	rc = intel_pstate_register_driver(default_driver);
>  	mutex_unlock(&intel_pstate_driver_lock);
> -	if (rc)
> +	if (rc) {
> +		intel_pstate_sysfs_clean();
>  		return rc;
> +	}
>  
>  	if (hwp_active) {
>  		const struct x86_cpu_id *id;

