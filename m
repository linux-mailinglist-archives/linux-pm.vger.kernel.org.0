Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3842077A6
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 17:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404312AbgFXPh3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 11:37:29 -0400
Received: from cmta18.telus.net ([209.171.16.91]:49492 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404227AbgFXPh3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Jun 2020 11:37:29 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id o7Slj5nCeVEJfo7Smj968y; Wed, 24 Jun 2020 09:37:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1593013046; bh=N5OvPS/plyYwPuIRTa5mkRMdDHNrRdYNQkLpzl4qxRs=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=WsVRtPOvY2c7BhYAhqUAN66mNh4u4vsHOwBH4JKoRjwmCv3FN2TouGwGE18Is/BlJ
         P/U0Gx5RJ7/civjvo1XXzVG+LjiS7VxdmfeK37+Egnw/CgZKFXeVfYSL8rK+f8z5Ks
         ODUFOYH2xapLDZZdR0GCQqVoMmiNNSRcO+ZrfjH9SXOWyfTDT8Yxjy5Vg4QPmBVgzw
         w2plHxV8mY1SZx5NFvzSllZgQ089UGZ1Pr7obLLIQrcJIg7k9nRIuCIShbmxR/Xpiv
         rHt904cC244WlrEvVNu4iLAf+ZobXllVUsvMuiX5QNnRANWPS+5WlDWwhM+GJQW+lG
         OU9gCe4nVGLyA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=KIck82No c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=WqHLvHYKatxRRy49I8QA:9 a=ii97s5VPTvE60e2D:21
 a=cH5xMffNoIaqFseu:21 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
Cc:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>, <lenb@kernel.org>
References: <20200623182705.1425539-1-srinivas.pandruvada@linux.intel.com> <20200623182705.1425539-3-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200623182705.1425539-3-srinivas.pandruvada@linux.intel.com>
Subject: RE: [PATCH v2 2/2] cpufreq: intel_pstate: Allow raw energy performance preference value
Date:   Wed, 24 Jun 2020 08:37:23 -0700
Message-ID: <000701d64a3d$5c442a80$14cc7f80$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZJi/haL7yCxd/nTzOTMdxAxvyH/wAN5/vg
X-CMAE-Envelope: MS4wfA9NqOVM7iem59NrXWVSiC4ReXnBzxAyB+RqVYqyuv9H9k4eJLUxBfVqDY8QJ8Ac/RwiSElbxOvQ4YYQ3s+qyyaQmw+juePnwkqO4i3BjWJSk5/cPOub
 VVDKyAA6rYZcbb5dzcfthj9zCn/pJMQkMdLdIt+GBk7iUMeC3sL4PRkiX7JVrpsgMxIL9WijBhNdZjmujeDF8EsxHrlnqP3mMzIeyXu4RmsREJAIBzKDn4AN
 bOQ5uOWpAaeYj9EsSvNUkNqXQTtAEQL2TM9BRIjuP+oOBKHr+BvzyGRH5tD90Rtg7Grax2IKg5YPuKKedilaA4TyjZXR7ly5SwOQls2gqRtUWFStMtyTlTIv
 wHSwtPd3
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas,

I have immediate need for this. I have been using a tool
I wrote myself for this which I can now retire.
(it wasn't very good anyway).
Yours remembers for each governor, and is way better.
Thanks.

On 2020.06.23 11:27 Srinivas Pandruvada wrote:

> Currently using attribute "energy_performance_preference", user space can
> write one of the four per-defined preference string. These preference
> strings gets mapped to a hard-coded Energy-Performance Preference (EPP) or
> Energy-Performance Bias (EPB) knob.
> 
> These four values supposed to cover broad spectrum of use cases, but they
> are not uniformly distributed in the range.

Suggest:

These four values are supposed to cover broad spectrum of use cases, but
are not uniformly distributed in the range.

> There are number of cases,
> where this is not enough. For example:
> 
> Suppose user wants more performance when connected to AC. Instead of using
> default "balance performance", the "performance" setting can be used. This
> changes EPP value from 0x80 to 0x00. But setting EPP to 0, results in
> electrical and thermal issues on some platforms.

> This results in CPU to do
> aggressive throttling, which causes drop in performance.

Suggest:

This results in aggressive throttling, which causes a drop in performance.

And:

Tough.
I consider "performance mode" as sacrosanct, and have always
expected these to behave identically and at max CPU freq:

intel_pstate no-hwp / performance
intel_cpufreq no-hwp / performance  (a.k.a. passive)
acpi_cpufreq / performance
intel_pstate hwp / performance
intel_cpufreq hwp / performance (in future)

as was always the case on my i7-2600K (no hwp) based computer
and is not the case on my i5-9600K (hwp capable) computer.

> But some value
> between 0x80 and 0x00 results in better performance. But that value can't
> be fixed as the power curve is not linear. In some cases just changing EPP
> from 0x80 to 0x75 is enough to get significant performance gain.
> 
> Similarly on battery EPP 0x80 can be very aggressive in power consumption.
> But picking up the next choice "balance power" results in too much loss
> of performance, which cause bad user experience in use case like "Google
> Hangout". It was observed that some value between these two EPP is
> optimal.
> 
> This change allows fine grain EPP tuning for platform like Chromebooks.
> Here based on the product and use cases, different EPP values can be set.
> This change is similar to the change done for:
> /sys/devices/system/cpu/cpu*/power/energy_perf_bias
> where user has choice to write a predefined string or raw value.
> 
> The change itself is trivial. When user preference doesn't match
> predefined string preferences and value is an unsigned integer and in
> range, use that value for EPP. When the EPP feature is not prsent
                                                             ^^^^^^
s/prsent/present

> writing raw value is not supported.
> 
> Suggested-by: Len Brown <lenb@kernel.org>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/admin-guide/pm/intel_pstate.rst |  6 ++-
>  drivers/cpufreq/intel_pstate.c                | 50 +++++++++++++++----
>  2 files changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-
> guide/pm/intel_pstate.rst
> index 939bfdc53f4f..5e209926e0ed 100644
> --- a/Documentation/admin-guide/pm/intel_pstate.rst
> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -561,7 +561,11 @@ somewhere between the two extremes:
>  Strings written to the ``energy_performance_preference`` attribute are
>  internally translated to integer values written to the processor's
>  Energy-Performance Preference (EPP) knob (if supported) or its
> -Energy-Performance Bias (EPB) knob.
> +Energy-Performance Bias (EPB) knob. It is also possible to write a positive
> +integer value between 0 to 255, if the EPP feature is present. If the EPP
> +feature is not present, writing integer value to this attribute is not
> +supported. In this case, user can use
> + "/sys/devices/system/cpu/cpu*/power/energy_perf_bias" interface.
> 
>  [Note that tasks may by migrated from one CPU to another by the scheduler's
>  load-balancing algorithm and if different energy vs performance hints are
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 1cf6d06f2314..d8f195c7a428 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -602,11 +602,12 @@ static const unsigned int epp_values[] = {
>  	HWP_EPP_POWERSAVE
>  };
> 
> -static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data)
> +static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data, int *raw_epp)
>  {
>  	s16 epp;
>  	int index = -EINVAL;
> 
> +	*raw_epp = 0;
>  	epp = intel_pstate_get_epp(cpu_data, 0);
>  	if (epp < 0)
>  		return epp;
> @@ -614,12 +615,14 @@ static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data)
>  	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
>  		if (epp == HWP_EPP_PERFORMANCE)
>  			return 1;
> -		if (epp <= HWP_EPP_BALANCE_PERFORMANCE)
> +		if (epp == HWP_EPP_BALANCE_PERFORMANCE)
>  			return 2;
> -		if (epp <= HWP_EPP_BALANCE_POWERSAVE)
> +		if (epp == HWP_EPP_BALANCE_POWERSAVE)
>  			return 3;
> -		else
> +		if (epp == HWP_EPP_POWERSAVE)
>  			return 4;
> +		*raw_epp = epp;
> +		return 0;
>  	} else if (boot_cpu_has(X86_FEATURE_EPB)) {
>  		/*
>  		 * Range:
> @@ -638,7 +641,8 @@ static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data)
>  }
> 
>  static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
> -					      int pref_index)
> +					      int pref_index, bool use_raw,
> +					      u32 raw_epp)
>  {
>  	int epp = -EINVAL;
>  	int ret;
> @@ -657,6 +661,16 @@ static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
> 
>  		value &= ~GENMASK_ULL(31, 24);
> 
> +		if (use_raw) {
> +			if (raw_epp > 255) {
> +				ret = -EINVAL;
> +				goto return_pref;
> +			}
> +			value |= (u64)raw_epp << 24;
> +			ret = wrmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, value);
> +			goto return_pref;
> +		}
> +
>  		if (epp == -EINVAL)
>  			epp = epp_values[pref_index - 1];
> 
> @@ -694,6 +708,8 @@ static ssize_t store_energy_performance_preference(
>  {
>  	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
>  	char str_preference[21];
> +	bool raw = false;
> +	u32 epp;
>  	int ret;
> 
>  	ret = sscanf(buf, "%20s", str_preference);
> @@ -701,10 +717,21 @@ static ssize_t store_energy_performance_preference(
>  		return -EINVAL;
> 
>  	ret = match_string(energy_perf_strings, -1, str_preference);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (!boot_cpu_has(X86_FEATURE_HWP_EPP))
> +			return ret;
> +
> +		ret = kstrtouint(buf, 10, &epp);
> +		if (ret)
> +			return ret;
> +
> +		raw = true;
> +	}
> +
> +	ret = intel_pstate_set_energy_pref_index(cpu_data, ret, raw, epp);
> +	if (ret)
>  		return ret;
> 
> -	intel_pstate_set_energy_pref_index(cpu_data, ret);
>  	return count;
>  }
> 
> @@ -712,13 +739,16 @@ static ssize_t show_energy_performance_preference(
>  				struct cpufreq_policy *policy, char *buf)
>  {
>  	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
> -	int preference;
> +	int preference, raw_epp;
> 
> -	preference = intel_pstate_get_energy_pref_index(cpu_data);
> +	preference = intel_pstate_get_energy_pref_index(cpu_data, &raw_epp);
>  	if (preference < 0)
>  		return preference;
> 
> -	return  sprintf(buf, "%s\n", energy_perf_strings[preference]);
> +	if (raw_epp)
> +		return  sprintf(buf, "%d\n", raw_epp);
> +	else
> +		return  sprintf(buf, "%s\n", energy_perf_strings[preference]);
>  }
> 
>  cpufreq_freq_attr_rw(energy_performance_preference);
> --
> 2.25.4

