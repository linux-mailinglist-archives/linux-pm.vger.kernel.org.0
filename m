Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD7320A16F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 16:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405705AbgFYO7w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 10:59:52 -0400
Received: from cmta20.telus.net ([209.171.16.93]:39721 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405668AbgFYO7v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jun 2020 10:59:51 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id oTLvjwPVKdVYHoTLwj2ekf; Thu, 25 Jun 2020 08:59:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1593097189; bh=kS9SsCkpMQlg1AsMMTel+GfCED0qlRbxQoBGflR0IL8=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=gN9XWNpzAFBoQNiOO3iDqpAgcxZtNuiXNNQNJrP4t5piXhgWa8WwTs5pRlAqEfB8E
         DRuwY5rLDzyGMVhFfExznXSPdCfP1OtocnwEzkBfUuEn2VPG7h/uQv1bQb7V5cMqMN
         NpGmXFhAArjP6YQQ75cZXyxCeHjh//xxUrQztED4z00urJ/OM0IkXuzIfTMWnwI4AT
         6drnuxpn3oai2c/zVC8AV/SZz21KGVDbJfsdsVu7MvPflH58T3D0EAuUjecqsrzwfj
         dKEGG63i3wF7GTy3gAhScSlBWp0oDLS5jFt+lJurFWnWvFLJVmRkKM1poSDxopoZ72
         TQSE02NLMUVOg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=Y5CGTSWN c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=LdXAM8slQLsqPH6iZRoA:9 a=IbikBSuLa7uY77AY:21
 a=ZZ5pfjUoPr37BiCZ:21 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
Cc:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>, <lenb@kernel.org>
References: <20200623051233.1419218-1-srinivas.pandruvada@linux.intel.com> <001e01d64976$616de950$2449bbf0$@net>
In-Reply-To: <001e01d64976$616de950$2449bbf0$@net>
Subject: RE: [PATCH 1/2] cpufreq: intel_pstate: Allow enable/disable energy efficiency
Date:   Thu, 25 Jun 2020 07:59:46 -0700
Message-ID: <000001d64b01$45aceea0$d106cbe0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZJHPAX2aqri8LLTYWzgCMOCZFopAATGg2QAGTxH5A=
X-CMAE-Envelope: MS4wfNWS11jb4W/IX66r4CSAlgJklVXFs3SWdRTxY+GLmncRQ769HC8/rCumYmR9/RVPChoGzsAUXXxxab79CgPsR+Q/xUIgrpg0ZYW9pJVno1yKuaia5yud
 WMlUjQjRpkxuEJX9LXOkdkJDhRlwwwMJQM+5wVPEV5lZBi8GmH09DEMWNfge2iXyOBPo6fOHpYNLIF1CT6pEZ/4UWvWldTDWM8l49zqNTXZicAfE0Z0hRnaK
 SWulSAIQDLfPkNcv3KY25MeMOKIo11mcT3Bdl0fAXJRKjCQE7cujQXqEfpIhrRf6GdzBlv11Mkso1cnmsnLlDHaMAuNP3wNSnArZ73UKkjr7OLaPnvHyc5M6
 Ws55Cs6A
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas,

I saw your V3.
I do not understand your reluctance to use

arch/x86/include/asm/msr-index.h

as the place to define anything MSR related.
Please explain.

One more comment about 1/3 of the way down below.

... Doug

On 2020.06.23 08:53 Doug Smythies wrote:
> On 2020.06.22 22:13 Srinivas Pandruvada wrote:
> 
> > By default intel_pstate driver disables energy efficiency by setting
> > MSR_IA32_POWER_CTL bit 19 for Kaby Lake desktop CPU model in HWP mode.
> > This CPU model is also shared by Coffee Lake desktop CPUs. This allows
> > these systems to reach maximum possible frequency. But this adds power
> > penalty, which some customers don't want. They want some way to enable/
> > disable dynamically.
> >
> > So, add an additional attribute "energy_efficiency_enable" under
> > /sys/devices/system/cpu/intel_pstate/ for these CPU models. This allows
> > to read and write bit 19 ("Disable Energy Efficiency Optimization") in
> > the MSR IA32_POWER_CTL.
> >
> > This attribute is present in both HWP and non-HWP mode as this has an
> > effect in both modes. Refer to Intel Software Developer's manual for
> > details. The scope of this bit is package wide.
> 
> I do and always have. However these manuals are 1000's of pages,
> are updated often, and it can be difficult to find the correct page
> for the correct processor. So it is great that, in general, the same
> mnemonics are used in the code as the manuals.
> 
> >
> > Suggested-by: Len Brown <lenb@kernel.org>
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> >  Documentation/admin-guide/pm/intel_pstate.rst |  7 +++
> >  drivers/cpufreq/intel_pstate.c                | 49 ++++++++++++++++++-
> >  2 files changed, 54 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-
> > guide/pm/intel_pstate.rst
> > index 39d80bc29ccd..939bfdc53f4f 100644
> > --- a/Documentation/admin-guide/pm/intel_pstate.rst
> > +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> > @@ -431,6 +431,13 @@ argument is passed to the kernel in the command line.
> >  	supported in the current configuration, writes to this attribute will
> >  	fail with an appropriate error.
> >
> > +``energy_efficiency_enable``
> > +	This attribute is only present on platforms, which has CPUs matching
> > +	Kaby Lake desktop CPU model. By default "energy_efficiency" is disabled
> 
> So, why not mention Coffee Lake also, as you did above?

And I still think you need to add "Coffee Lake" here also.

> 
> > +	on these CPU models in HWP mode by this driver. Enabling energy
> > +	efficiency may limit maximum operating frequency in both HWP and non
> > +	HWP mode.
> > +
> >  Interpretation of Policy Attributes
> >  -----------------------------------
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index 8e23a698ce04..1cf6d06f2314 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -1218,6 +1218,44 @@ static ssize_t store_hwp_dynamic_boost(struct kobject *a,
> >  	return count;
> >  }
> >
> > +#define MSR_IA32_POWER_CTL_BIT_EE	19
> 
> (same comment as the other day, for another patch) In my opinion and for
> consistency, this bit should be defined in
> 
> arch/x86/include/asm/msr-index.h
> 
> like so (I defined the other bits also):
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index e8370e64a155..1a6084067f18 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -255,6 +255,12 @@
> 
>  #define MSR_IA32_POWER_CTL             0x000001fc
> 
> +/* POWER_CTL bits (some are model specific): */
> +
> +#define POWER_CTL_C1E                  1
> +#define POWER_CTL_EEO                  19
> +#define POWER_CTL_RHO                  20
> +
>  #define MSR_IA32_MC0_CTL               0x00000400
>  #define MSR_IA32_MC0_STATUS            0x00000401
>  #define MSR_IA32_MC0_ADDR              0x00000402
> 
> There is another almost identical file at:
> 
> tools/arch/x86/include/asm/msr-index.h
> 
> and I am not sure which one is the master, but
> the former contains stuff that the later does not.
> 
> I have defined the bits names in a consistent way
> as observed elsewhere in the file. i.e. drop the
> "MSR_IA32_" prefix and add the bit.
> 
> Now, tying this back to my earlier comment about the
> manuals:
> The file "tools/arch/x86/include/asm/msr-index.h"
> is an excellent gateway reference for those
> 1000's of pages of software reference manuals.
> 
> As a user that uses them all the time, but typically
> only digs deep into those manuals once every year or
> two, I find tremendous value added via the msr-index.h
> file.
> 
> > +
> > +static ssize_t show_energy_efficiency_enable(struct kobject *kobj,
> > +					     struct kobj_attribute *attr,
> > +					     char *buf)
> > +{
> > +	u64 power_ctl;
> > +	int enable;
> > +
> > +	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
> > +	enable = (power_ctl & BIT(MSR_IA32_POWER_CTL_BIT_EE)) >> MSR_IA32_POWER_CTL_BIT_EE;
> > +	return sprintf(buf, "%d\n", !enable);
> > +}
> > +
> > +static ssize_t store_energy_efficiency_enable(struct kobject *a,
> > +					      struct kobj_attribute *b,
> > +					      const char *buf, size_t count)
> > +{
> > +	u64 power_ctl;
> > +	u32 input;
> > +	int ret;
> > +
> > +	ret = kstrtouint(buf, 10, &input);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_lock(&intel_pstate_driver_lock);
> > +	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
> > +	if (input)
> > +		power_ctl &= ~BIT(MSR_IA32_POWER_CTL_BIT_EE);
> > +	else
> > +		power_ctl |= BIT(MSR_IA32_POWER_CTL_BIT_EE);
> > +	wrmsrl(MSR_IA32_POWER_CTL, power_ctl);
> > +	mutex_unlock(&intel_pstate_driver_lock);
> > +
> > +	return count;
> > +}
> > +
> >  show_one(max_perf_pct, max_perf_pct);
> >  show_one(min_perf_pct, min_perf_pct);
> >
> > @@ -1228,6 +1266,7 @@ define_one_global_rw(min_perf_pct);
> >  define_one_global_ro(turbo_pct);
> >  define_one_global_ro(num_pstates);
> >  define_one_global_rw(hwp_dynamic_boost);
> > +define_one_global_rw(energy_efficiency_enable);
> >
> >  static struct attribute *intel_pstate_attributes[] = {
> >  	&status.attr,
> > @@ -1241,6 +1280,8 @@ static const struct attribute_group intel_pstate_attr_group = {
> >  	.attrs = intel_pstate_attributes,
> >  };
> >
> > +static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[];
> > +
> >  static void __init intel_pstate_sysfs_expose_params(void)
> >  {
> >  	struct kobject *intel_pstate_kobject;
> > @@ -1273,6 +1314,12 @@ static void __init intel_pstate_sysfs_expose_params(void)
> >  				       &hwp_dynamic_boost.attr);
> >  		WARN_ON(rc);
> >  	}
> > +
> > +	if (x86_match_cpu(intel_pstate_cpu_ee_disable_ids)) {
> > +		rc = sysfs_create_file(intel_pstate_kobject,
> > +				       &energy_efficiency_enable.attr);
> > +		WARN_ON(rc);
> > +	}
> >  }
> >  /************************** sysfs end ************************/
> >
> > @@ -1288,8 +1335,6 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
> >  		cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
> >  }
> >
> > -#define MSR_IA32_POWER_CTL_BIT_EE	19
> > -
> >  /* Disable energy efficiency optimization */
> >  static void intel_pstate_disable_ee(int cpu)
> >  {
> > --
> > 2.25.4


