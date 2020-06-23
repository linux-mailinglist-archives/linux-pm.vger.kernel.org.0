Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9839120565C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 17:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbgFWPxI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 11:53:08 -0400
Received: from cmta19.telus.net ([209.171.16.92]:55520 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732981AbgFWPxH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jun 2020 11:53:07 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id nlEMjsYeMFblknlEOjcGYd; Tue, 23 Jun 2020 09:53:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1592927585; bh=nlfqUqrnDt8mw74udY2oJ06tBa7QryRseE54RE1eYiY=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=ZU4PvE1EewXnf2KEOVQxomqVu++0D04kdmyF/1q75VhqMzbUkTNp53pfMjnUL2O+t
         sB+FEMtLF3AQpFezL2uPf7mVUQsdZQqS94v6Vs6nNJ6uKq4trnauyOW7IJ1zp9H/HY
         vqfrLbGczwjLA/Ah8WDb3yoCHZyFWSE3OZdVB7/lFNKZOrAqmn4EVaiKjTAPaCi2F9
         bzinU2j1EGgaYuijamJOmOpEhNaDoFM8kIsNqdbM3NjB+iz9lLKhXCXdsUC+8SwGKE
         dlYoVEkZ0fvKbjeMpSU3RwrMhFd+VhxsMlhZhDh440lueVoAfprkkHFA6Eh3vymVYk
         QTzSvHMY1rtbg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=BNTNU2YG c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=asNcfZ7KW6wfmf0wXiAA:9 a=UhRXDiYojVoVNxzP:21
 a=lKfM9UDmurNOeIvW:21 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        <lenb@kernel.org>
Cc:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>
References: <20200623051233.1419218-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200623051233.1419218-1-srinivas.pandruvada@linux.intel.com>
Subject: RE: [PATCH 1/2] cpufreq: intel_pstate: Allow enable/disable energy efficiency
Date:   Tue, 23 Jun 2020 08:53:01 -0700
Message-ID: <001e01d64976$616de950$2449bbf0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdZJHPAX2aqri8LLTYWzgCMOCZFopAATGg2Q
Content-Language: en-ca
X-CMAE-Envelope: MS4wfGxRbxc6ov9093k7Z4lmJwMEuZRl/DIZzQhCjSiQVmnDmfx2W1io7hDRCFDrl7opjNKUrskmIZX3z9LYswOJwP9uYeLWXJRWJT6JA6Prw1PBaQftCnhg
 UI446xSo9rLoy/7WNH0WDchYy0gmF9rOL4kxEopmRfpgwy5jNhONMI4z9zTn+htg9EwgV1kF0WfNqCtuJ4eunMyzeTvoBLLa6yQhyYCMClNjjp7IWMEJEU19
 PcKxIdFVOIkwq1ALQvshDmBLXIFMnJYKSx/ViCWAsfaTdGhkF58ykPSQHmJoIv4iwJX6DmO5hJrHrKO4/6HO0DodrIghRBfBuZHAZJpnppl3bK0IEliXgJk+
 guIQ5ljA
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.06.22 22:13 Srinivas Pandruvada wrote:

> By default intel_pstate driver disables energy efficiency by setting
> MSR_IA32_POWER_CTL bit 19 for Kaby Lake desktop CPU model in HWP mode.
> This CPU model is also shared by Coffee Lake desktop CPUs. This allows
> these systems to reach maximum possible frequency. But this adds power
> penalty, which some customers don't want. They want some way to enable/
> disable dynamically.
> 
> So, add an additional attribute "energy_efficiency_enable" under
> /sys/devices/system/cpu/intel_pstate/ for these CPU models. This allows
> to read and write bit 19 ("Disable Energy Efficiency Optimization") in
> the MSR IA32_POWER_CTL.
> 
> This attribute is present in both HWP and non-HWP mode as this has an
> effect in both modes. Refer to Intel Software Developer's manual for
> details. The scope of this bit is package wide.

I do and always have. However these manuals are 1000's of pages,
are updated often, and it can be difficult to find the correct page
for the correct processor. So it is great that, in general, the same
mnemonics are used in the code as the manuals.

> 
> Suggested-by: Len Brown <lenb@kernel.org>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/admin-guide/pm/intel_pstate.rst |  7 +++
>  drivers/cpufreq/intel_pstate.c                | 49 ++++++++++++++++++-
>  2 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-
> guide/pm/intel_pstate.rst
> index 39d80bc29ccd..939bfdc53f4f 100644
> --- a/Documentation/admin-guide/pm/intel_pstate.rst
> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -431,6 +431,13 @@ argument is passed to the kernel in the command line.
>  	supported in the current configuration, writes to this attribute will
>  	fail with an appropriate error.
> 
> +``energy_efficiency_enable``
> +	This attribute is only present on platforms, which has CPUs matching
> +	Kaby Lake desktop CPU model. By default "energy_efficiency" is disabled

So, why not mention Coffee Lake also, as you did above?

> +	on these CPU models in HWP mode by this driver. Enabling energy
> +	efficiency may limit maximum operating frequency in both HWP and non
> +	HWP mode.
> +
>  Interpretation of Policy Attributes
>  -----------------------------------
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 8e23a698ce04..1cf6d06f2314 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1218,6 +1218,44 @@ static ssize_t store_hwp_dynamic_boost(struct kobject *a,
>  	return count;
>  }
> 
> +#define MSR_IA32_POWER_CTL_BIT_EE	19

(same comment as the other day, for another patch) In my opinion and for
consistency, this bit should be defined in

arch/x86/include/asm/msr-index.h

like so (I defined the other bits also):

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e8370e64a155..1a6084067f18 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -255,6 +255,12 @@

 #define MSR_IA32_POWER_CTL             0x000001fc

+/* POWER_CTL bits (some are model specific): */
+
+#define POWER_CTL_C1E                  1
+#define POWER_CTL_EEO                  19
+#define POWER_CTL_RHO                  20
+
 #define MSR_IA32_MC0_CTL               0x00000400
 #define MSR_IA32_MC0_STATUS            0x00000401
 #define MSR_IA32_MC0_ADDR              0x00000402

There is another almost identical file at:

tools/arch/x86/include/asm/msr-index.h

and I am not sure which one is the master, but
the former contains stuff that the later does not.

I have defined the bits names in a consistent way
as observed elsewhere in the file. i.e. drop the
"MSR_IA32_" prefix and add the bit.

Now, tying this back to my earlier comment about the
manuals:
The file "tools/arch/x86/include/asm/msr-index.h"
is an excellent gateway reference for those
1000's of pages of software reference manuals.

As a user that uses them all the time, but typically
only digs deep into those manuals once every year or
two, I find tremendous value added via the msr-index.h
file.

> +
> +static ssize_t show_energy_efficiency_enable(struct kobject *kobj,
> +					     struct kobj_attribute *attr,
> +					     char *buf)
> +{
> +	u64 power_ctl;
> +	int enable;
> +
> +	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
> +	enable = (power_ctl & BIT(MSR_IA32_POWER_CTL_BIT_EE)) >> MSR_IA32_POWER_CTL_BIT_EE;
> +	return sprintf(buf, "%d\n", !enable);
> +}
> +
> +static ssize_t store_energy_efficiency_enable(struct kobject *a,
> +					      struct kobj_attribute *b,
> +					      const char *buf, size_t count)
> +{
> +	u64 power_ctl;
> +	u32 input;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &input);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&intel_pstate_driver_lock);
> +	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
> +	if (input)
> +		power_ctl &= ~BIT(MSR_IA32_POWER_CTL_BIT_EE);
> +	else
> +		power_ctl |= BIT(MSR_IA32_POWER_CTL_BIT_EE);
> +	wrmsrl(MSR_IA32_POWER_CTL, power_ctl);
> +	mutex_unlock(&intel_pstate_driver_lock);
> +
> +	return count;
> +}
> +
>  show_one(max_perf_pct, max_perf_pct);
>  show_one(min_perf_pct, min_perf_pct);
> 
> @@ -1228,6 +1266,7 @@ define_one_global_rw(min_perf_pct);
>  define_one_global_ro(turbo_pct);
>  define_one_global_ro(num_pstates);
>  define_one_global_rw(hwp_dynamic_boost);
> +define_one_global_rw(energy_efficiency_enable);
> 
>  static struct attribute *intel_pstate_attributes[] = {
>  	&status.attr,
> @@ -1241,6 +1280,8 @@ static const struct attribute_group intel_pstate_attr_group = {
>  	.attrs = intel_pstate_attributes,
>  };
> 
> +static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[];
> +
>  static void __init intel_pstate_sysfs_expose_params(void)
>  {
>  	struct kobject *intel_pstate_kobject;
> @@ -1273,6 +1314,12 @@ static void __init intel_pstate_sysfs_expose_params(void)
>  				       &hwp_dynamic_boost.attr);
>  		WARN_ON(rc);
>  	}
> +
> +	if (x86_match_cpu(intel_pstate_cpu_ee_disable_ids)) {
> +		rc = sysfs_create_file(intel_pstate_kobject,
> +				       &energy_efficiency_enable.attr);
> +		WARN_ON(rc);
> +	}
>  }
>  /************************** sysfs end ************************/
> 
> @@ -1288,8 +1335,6 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
>  		cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
>  }
> 
> -#define MSR_IA32_POWER_CTL_BIT_EE	19
> -
>  /* Disable energy efficiency optimization */
>  static void intel_pstate_disable_ee(int cpu)
>  {
> --
> 2.25.4


