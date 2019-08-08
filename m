Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B953E86707
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 18:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbfHHQZm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 12:25:42 -0400
Received: from cmta19.telus.net ([209.171.16.92]:60060 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732302AbfHHQZm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 12:25:42 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id vlENhdR2EeRl4vlEOhCyXi; Thu, 08 Aug 2019 10:25:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1565281538; bh=iK4UKCvDHqpSwe+rfBK+FC79zxpMt9mKSlV4L95XRnk=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=F/hYqVye9U+IbE44P09jEWMwGHVpqkYbOfobY+Tx1aIvjS0rCpllzSwv5eVOzgxi/
         ktNJxnyQ5pmZP/2LHt5I9Z+qfg14larhkxWaR8eCHjRBQOxcoR/3/3ewhd6bEKLjVX
         u8jjk7sRxhHu599dSdscwOm4e0VTdpAvPwsDyCv8YplUyxOhJqwL45JX5G1qd8MFnS
         aDnk1wSCRxJoaJ1V09Vzd85irJ+bme/UWJQSL5QBPTA2gnxEzPBG5tdIsJYC2qxb4f
         Gdbovdxrgworslj0ZanqPZj+MuzV8nLcngWEIEOKWoXY+bpe/V0uZpMy+FgalguD1A
         WMwPdvgC1plaQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=KqozJleN c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=aatUQebYAAAA:8 a=KKAkSRfTAAAA:8 a=njUrAqMqMSlWPpeZ23EA:9
 a=CjuIK1q_8ugA:10 a=7715FyvI7WU-l6oqrZBK:22 a=cvBusfyB2V15izCimMoJ:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Viresh Kumar'" <viresh.kumar@linaro.org>
Cc:     <linux-pm@vger.kernel.org>,
        "'Vincent Guittot'" <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        "'Rafael Wysocki'" <rjw@rjwysocki.net>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Len Brown'" <lenb@kernel.org>
References: <70fce19e43bb825c3b2546e1211d262a59ae7378.1565161495.git.viresh.kumar@linaro.org> <e789eceae3f32a66fff923daeb85b33b88f21fe1.1565161495.git.viresh.kumar@linaro.org>
In-Reply-To: <e789eceae3f32a66fff923daeb85b33b88f21fe1.1565161495.git.viresh.kumar@linaro.org>
Subject: RE: [PATCH V4 2/2] cpufreq: intel_pstate: Implement QoS supported freq constraints
Date:   Thu, 8 Aug 2019 09:25:34 -0700
Message-ID: <000601d54e05$e93d0130$bbb70390$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdVM7pmWc4rh8UNSQyCOnfPw6N1TAABC7Rhg
X-CMAE-Envelope: MS4wfG0/YUiyU9WDGRvqr1mxaRddPtjtx+CuFy/s5KY+IhAHex4Cgd3MjaFBxiPJBlXUhRig9ptoonMbmCkvcj9TajrAq0GGKF+CeOaZonn57EonfYnw0Zly
 P8YL8wJKjRYBQcr9f3U+2ygbRPPdaDzTz5vZakPnZpJQEuA6EHE/GTjbC/sZaWUNavIsuYzLo3QcuuOPdzt6dqi+lo/QhvVDKJGqmQPg+LUDlC57oNDnlgoE
 8M3PXpNlX+vwGQ3fVW0L5xLiz9PklGbXmzSuWv/RyKT215WBXqTl61L/MjxRM3IB+BjJJX8Y1uabjpQwcP0392BEAbqWMWOgx2PjqQPR5CN7QKV+kygXE3ip
 97mu82plaRyET/3NT0/r0Lk0mPaMbSHEs+69Gj7PrwxXS7JRNUI=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.08.07 00:06 Viresh Kumar wrote:

Thanks for your work on this.

> Intel pstate driver exposes min_perf_pct and max_perf_pct sysfs files,
> which can be used to force a limit on the min/max P state of the driver.
> Though these files eventually control the min/max frequencies that the
> CPUs will run at, they don't make a change to policy->min/max values.
>
> When the values of these files are changed (in passive mode of the
> driver), it leads to calling ->limits() callback of the cpufreq
> governors, like schedutil. On a call to it the governors shall
> forcefully update the frequency to come within the limits. Since the
> limits, i.e.  policy->min/max, aren't updated by the driver, the
> governors fails to get the target freq within limit and sometimes aborts
> the update believing that the frequency is already set to the target
> value.
>
> This patch implements the QoS supported frequency constraints to update
> policy->min/max values whenever min_perf_pct or max_perf_pct files are
> updated. This is only done for the passive mode as of now, as the driver
> is already working fine in active mode.
>
> Fixes: ecd288429126 ("cpufreq: schedutil: Don't set next_freq to UINT_MAX")
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Tested by: Doug Smythies <dsmythies@telus.net>
Thermald seems to now be working O.K. for all the governors.

I do note that if one sets
/sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
It seems to override subsequent attempts via
/sys/devices/system/cpu/intel_pstate/max_perf_pct.
Myself, I find this confusing.

So the question becomes which one is the "master"?

Example:

# for file in /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq; do echo "2200000" > $file; done
# cat /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
2200000
2200000
2200000
2200000
2200000
2200000
2200000
2200000
root@s15:/home/doug/temp# cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
... (Note: 50% = 1900000)
root@s15:/home/doug/temp# cat /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
1900000
1900000
1900000
1900000
1900000
1900000
1900000
1900000
root@s15:/home/doug/temp# echo 100 > /sys/devices/system/cpu/intel_pstate/max_perf_pct
... (Note: 50% = 3800000, and my expectation is 3.8 GHz below)
root@s15:/home/doug/temp# cat /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
2200000
2200000
2200000
2200000
2200000
2200000
2200000
2200000

Similarly for the minimum side of things:

root@s15:/home/doug/temp# for file in /sys/devices/system/cpu/cpufreq/policy*/scaling_min_freq; do echo "3200000" > $file; done
root@s15:/home/doug/temp# cat /sys/devices/system/cpu/cpufreq/policy*/scaling_min_freq
3200000
3200000
3200000
3200000
3200000
3200000
3200000
3200000
root@s15:/home/doug/temp# echo 42 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
root@s15:/home/doug/temp# cat /sys/devices/system/cpu/intel_pstate/min_perf_pct
42   ... (note 42% = 1600000 = processor minimum, and that is my expectation below.)
root@s15:/home/doug/temp# cat /sys/devices/system/cpu/cpufreq/policy*/scaling_min_freq
3200000
3200000
3200000
3200000
3200000
3200000
3200000
3200000

I thought these minimum anomalies would cause problems for thermald, but
for whatever reason, it seems to work properly.

> ---
> V3->V4:
> - Reimplemented the solution using QoS constraints instead of
>   resolve_freq() callback.
>
> drivers/cpufreq/intel_pstate.c | 120 +++++++++++++++++++++++++++++++--
> 1 file changed, 116 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index cc27d4c59dca..e9fbd6c36822 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -24,6 +24,7 @@
>  #include <linux/fs.h>
>  #include <linux/acpi.h>
>  #include <linux/vmalloc.h>
> +#include <linux/pm_qos.h>
>  #include <trace/events/power.h>
>  
>  #include <asm/div64.h>
> @@ -1085,6 +1086,47 @@ static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
>  	return count;
>  }
>  
> +static struct cpufreq_driver intel_pstate;
> +
> +static void update_qos_request(enum dev_pm_qos_req_type type)
> +{
> +	int max_state, turbo_max, freq, i, perf_pct;
> +	struct dev_pm_qos_request *req;
> +	struct cpufreq_policy *policy;
> +
> +	for_each_possible_cpu(i) {
> +		struct cpudata *cpu = all_cpu_data[i];
> +
> +		policy = cpufreq_cpu_get(i);
> +		if (!policy)
> +			continue;
> +
> +		req = policy->driver_data;
> +		cpufreq_cpu_put(policy);
> +
> +		if (!req)
> +			continue;
> +
> +		if (hwp_active)
> +			intel_pstate_get_hwp_max(i, &turbo_max, &max_state);
> +		else
> +			turbo_max = cpu->pstate.turbo_pstate;
> +
> +		if (type == DEV_PM_QOS_MIN_FREQUENCY) {

Is it O.K. to assume if the passed op code is
not DEV_PM_QOS_MIN_FREQUENCY
then it must have been
DEV_PM_QOS_MAX_FREQUENCY
?

It is within this patch, but what about in future?

> +			perf_pct = global.min_perf_pct;
> +		} else {
> +			req++;
> +			perf_pct = global.max_perf_pct;
> +		}
> +
> +		freq = DIV_ROUND_UP(turbo_max * perf_pct, 100);
> +		freq *= cpu->pstate.scaling;
> +
> +		if (dev_pm_qos_update_request(req, freq))
> +			pr_warn("Failed to update freq constraint: CPU%d\n", i);

I get many of these messages (4520 so far, always in groups of 8 (I have 8 CPUs)),
and have yet to figure out exactly why. It seems to actually be working fine.

> +	}
> +}
> +
>  static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attribute *b,
>  				  const char *buf, size_t count)
>  {
> @@ -1108,7 +1150,10 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attribute *b,
>  
>  	mutex_unlock(&intel_pstate_limits_lock);
>  
> -	intel_pstate_update_policies();
> +	if (intel_pstate_driver == &intel_pstate)
> +		intel_pstate_update_policies();
> +	else
> +		update_qos_request(DEV_PM_QOS_MAX_FREQUENCY);
>  
>  	mutex_unlock(&intel_pstate_driver_lock);
>  
> @@ -1139,7 +1184,10 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct kobj_attribute *b,
>  
>  	mutex_unlock(&intel_pstate_limits_lock);
>  
> -	intel_pstate_update_policies();
> +	if (intel_pstate_driver == &intel_pstate)
> +		intel_pstate_update_policies();
> +	else
> +		update_qos_request(DEV_PM_QOS_MIN_FREQUENCY);
>  
>  	mutex_unlock(&intel_pstate_driver_lock);
>  
> @@ -2332,8 +2380,16 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
>  
>  static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
> -	int ret = __intel_pstate_cpu_init(policy);
> +	int max_state, turbo_max, min_freq, max_freq, ret;
> +	struct dev_pm_qos_request *req;
> +	struct cpudata *cpu;
> +	struct device *dev;
> +
> +	dev = get_cpu_device(policy->cpu);
> +	if (!dev)
> +		return -ENODEV;
>  
> +	ret = __intel_pstate_cpu_init(policy);
>  	if (ret)
>  		return ret;
>  
> @@ -2342,7 +2398,63 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
>  	policy->cur = policy->cpuinfo.min_freq;
>  
> +	req = kcalloc(2, sizeof(*req), GFP_KERNEL);
> +	if (!req) {
> +		ret = -ENOMEM;
> +		goto pstate_exit;
> +	}
> +
> +	cpu = all_cpu_data[policy->cpu];
> +
> +	if (hwp_active)
> +		intel_pstate_get_hwp_max(policy->cpu, &turbo_max, &max_state);
> +	else
> +		turbo_max = cpu->pstate.turbo_pstate;
> +
> +	min_freq = DIV_ROUND_UP(turbo_max * global.min_perf_pct, 100);
> +	min_freq *= cpu->pstate.scaling;
> +	max_freq = DIV_ROUND_UP(turbo_max * global.max_perf_pct, 100);
> +	max_freq *= cpu->pstate.scaling;
> +
> +	ret = dev_pm_qos_add_request(dev, req, DEV_PM_QOS_MIN_FREQUENCY,
> +				     min_freq);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
> +		goto free_req;
> +	}
> +
> +	ret = dev_pm_qos_add_request(dev, req + 1, DEV_PM_QOS_MAX_FREQUENCY,
> +				     max_freq);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to add max-freq constraint (%d)\n", ret);
> +		goto remove_min_req;
> +	}
> +
> +	policy->driver_data = req;
> +
>  	return 0;
> +
> +remove_min_req:
> +	dev_pm_qos_remove_request(req);
> +free_req:
> +	kfree(req);
> +pstate_exit:
> +	intel_pstate_exit_perf_limits(policy);
> +
> +	return ret;
> +}
> +
> +static int intel_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	struct dev_pm_qos_request *req;
> +
> +	req = policy->driver_data;
> +
> +	dev_pm_qos_remove_request(req + 1);
> +	dev_pm_qos_remove_request(req);
> +	kfree(req);
> +
> +	return intel_pstate_cpu_exit(policy);
>  }
>  
>  static struct cpufreq_driver intel_cpufreq = {
> @@ -2351,7 +2463,7 @@ static struct cpufreq_driver intel_cpufreq = {
>  	.target		= intel_cpufreq_target,
>  	.fast_switch	= intel_cpufreq_fast_switch,
>  	.init		= intel_cpufreq_cpu_init,
> -	.exit		= intel_pstate_cpu_exit,
> +	.exit		= intel_cpufreq_cpu_exit,
>  	.stop_cpu	= intel_cpufreq_stop_cpu,
>  	.update_limits	= intel_pstate_update_limits,
>  	.name		= "intel_cpufreq",
> -- 
> 2.21.0.rc0.269.g1a574e7a288b


