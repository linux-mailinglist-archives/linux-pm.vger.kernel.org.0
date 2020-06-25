Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D9120A29B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403935AbgFYQHN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 12:07:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:61022 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403863AbgFYQHN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jun 2020 12:07:13 -0400
IronPort-SDR: 3y01CxYocPZSZONBa1ofuDmzYcniEbmlllue9k6WDSv6VbmwWWqg/oe26xeuud6HvSKqAmZn1K
 PFcX0af/p87Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="132387047"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="132387047"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 09:07:12 -0700
IronPort-SDR: xpz6+p70VGZkhi2xMA93stFrzA/pGpHCzxxb2Rflw6zVVT0ZHMZ6DDdZHgFMRCAQbJj2/KQdRf
 UiIrcjrANsNw==
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="279854953"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 09:07:12 -0700
Message-ID: <f23b11bbf8bf01194404aefd53bdf67fef3bcba8.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] cpufreq: intel_pstate: Allow enable/disable energy
 efficiency
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org
Date:   Thu, 25 Jun 2020 09:06:39 -0700
In-Reply-To: <000001d64b01$45aceea0$d106cbe0$@net>
References: <20200623051233.1419218-1-srinivas.pandruvada@linux.intel.com>
         <001e01d64976$616de950$2449bbf0$@net> <000001d64b01$45aceea0$d106cbe0$@net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Doug,

On Thu, 2020-06-25 at 07:59 -0700, Doug Smythies wrote:
> Hi Srinivas,
> 
> I saw your V3.
> I do not understand your reluctance to use
> 
> arch/x86/include/asm/msr-index.h

I don't have reluctance. That was the guidance from x86 core
maintainers years back. But may have changed. So checking again.

"
Unless the BIT is used in more than one places, it should stay local by
not adding to msr_indes.h.
"

It can be moved to msr_index.h once turbostat start using this.
Len can comment on it when that will happen.

> 
> 
[..]

> > > So, add an additional attribute "energy_efficiency_enable" under
> > > /sys/devices/system/cpu/intel_pstate/ for these CPU models. This
> > > allows
> > > to read and write bit 19 ("Disable Energy Efficiency
> > > Optimization") in
> > > the MSR IA32_POWER_CTL.
> > > 
> > > This attribute is present in both HWP and non-HWP mode as this
> > > has an
> > > effect in both modes. Refer to Intel Software Developer's manual
> > > for
> > > details. The scope of this bit is package wide.
> > 
> > I do and always have. However these manuals are 1000's of pages,
> > are updated often, and it can be difficult to find the correct page
> > for the correct processor. So it is great that, in general, the
> > same
> > mnemonics are used in the code as the manuals.
There is no mnemonic for bits like EE in SDM. The MSR name matches SDM.


> > 
> > > Suggested-by: Len Brown <lenb@kernel.org>
> > > Signed-off-by: Srinivas Pandruvada <
> > > srinivas.pandruvada@linux.intel.com>
> > > ---
> > >  Documentation/admin-guide/pm/intel_pstate.rst |  7 +++
> > >  drivers/cpufreq/intel_pstate.c                | 49
> > > ++++++++++++++++++-
> > >  2 files changed, 54 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/pm/intel_pstate.rst
> > > b/Documentation/admin-
> > > guide/pm/intel_pstate.rst
> > > index 39d80bc29ccd..939bfdc53f4f 100644
> > > --- a/Documentation/admin-guide/pm/intel_pstate.rst
> > > +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> > > @@ -431,6 +431,13 @@ argument is passed to the kernel in the
> > > command line.
> > >  	supported in the current configuration, writes to this
> > > attribute will
> > >  	fail with an appropriate error.
> > > 
> > > +``energy_efficiency_enable``
> > > +	This attribute is only present on platforms, which has CPUs
> > > matching
> > > +	Kaby Lake desktop CPU model. By default "energy_efficiency" is
> > > disabled
> > 
> > So, why not mention Coffee Lake also, as you did above?
> 
> And I still think you need to add "Coffee Lake" here also.
We can add.

Thanks,
Srinivas

> 
> > > +	on these CPU models in HWP mode by this driver. Enabling energy
> > > +	efficiency may limit maximum operating frequency in both HWP
> > > and non
> > > +	HWP mode.
> > > +
> > >  Interpretation of Policy Attributes
> > >  -----------------------------------
> > > 
> > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > b/drivers/cpufreq/intel_pstate.c
> > > index 8e23a698ce04..1cf6d06f2314 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -1218,6 +1218,44 @@ static ssize_t
> > > store_hwp_dynamic_boost(struct kobject *a,
> > >  	return count;
> > >  }
> > > 
> > > +#define MSR_IA32_POWER_CTL_BIT_EE	19
> > 
> > (same comment as the other day, for another patch) In my opinion
> > and for
> > consistency, this bit should be defined in
> > 
> > arch/x86/include/asm/msr-index.h
> > 
> > like so (I defined the other bits also):
> > 
> > diff --git a/arch/x86/include/asm/msr-index.h
> > b/arch/x86/include/asm/msr-index.h
> > index e8370e64a155..1a6084067f18 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -255,6 +255,12 @@
> > 
> >  #define MSR_IA32_POWER_CTL             0x000001fc
> > 
> > +/* POWER_CTL bits (some are model specific): */
> > +
> > +#define POWER_CTL_C1E                  1
> > +#define POWER_CTL_EEO                  19
> > +#define POWER_CTL_RHO                  20
> > +
> >  #define MSR_IA32_MC0_CTL               0x00000400
> >  #define MSR_IA32_MC0_STATUS            0x00000401
> >  #define MSR_IA32_MC0_ADDR              0x00000402
> > 
> > There is another almost identical file at:
> > 
> > tools/arch/x86/include/asm/msr-index.h
> > 
> > and I am not sure which one is the master, but
> > the former contains stuff that the later does not.
> > 
> > I have defined the bits names in a consistent way
> > as observed elsewhere in the file. i.e. drop the
> > "MSR_IA32_" prefix and add the bit.
> > 
> > Now, tying this back to my earlier comment about the
> > manuals:
> > The file "tools/arch/x86/include/asm/msr-index.h"
> > is an excellent gateway reference for those
> > 1000's of pages of software reference manuals.
> > 
> > As a user that uses them all the time, but typically
> > only digs deep into those manuals once every year or
> > two, I find tremendous value added via the msr-index.h
> > file.
> > 
> > > +
> > > +static ssize_t show_energy_efficiency_enable(struct kobject
> > > *kobj,
> > > +					     struct kobj_attribute
> > > *attr,
> > > +					     char *buf)
> > > +{
> > > +	u64 power_ctl;
> > > +	int enable;
> > > +
> > > +	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
> > > +	enable = (power_ctl & BIT(MSR_IA32_POWER_CTL_BIT_EE)) >>
> > > MSR_IA32_POWER_CTL_BIT_EE;
> > > +	return sprintf(buf, "%d\n", !enable);
> > > +}
> > > +
> > > +static ssize_t store_energy_efficiency_enable(struct kobject *a,
> > > +					      struct kobj_attribute *b,
> > > +					      const char *buf, size_t
> > > count)
> > > +{
> > > +	u64 power_ctl;
> > > +	u32 input;
> > > +	int ret;
> > > +
> > > +	ret = kstrtouint(buf, 10, &input);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	mutex_lock(&intel_pstate_driver_lock);
> > > +	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
> > > +	if (input)
> > > +		power_ctl &= ~BIT(MSR_IA32_POWER_CTL_BIT_EE);
> > > +	else
> > > +		power_ctl |= BIT(MSR_IA32_POWER_CTL_BIT_EE);
> > > +	wrmsrl(MSR_IA32_POWER_CTL, power_ctl);
> > > +	mutex_unlock(&intel_pstate_driver_lock);
> > > +
> > > +	return count;
> > > +}
> > > +
> > >  show_one(max_perf_pct, max_perf_pct);
> > >  show_one(min_perf_pct, min_perf_pct);
> > > 
> > > @@ -1228,6 +1266,7 @@ define_one_global_rw(min_perf_pct);
> > >  define_one_global_ro(turbo_pct);
> > >  define_one_global_ro(num_pstates);
> > >  define_one_global_rw(hwp_dynamic_boost);
> > > +define_one_global_rw(energy_efficiency_enable);
> > > 
> > >  static struct attribute *intel_pstate_attributes[] = {
> > >  	&status.attr,
> > > @@ -1241,6 +1280,8 @@ static const struct attribute_group
> > > intel_pstate_attr_group = {
> > >  	.attrs = intel_pstate_attributes,
> > >  };
> > > 
> > > +static const struct x86_cpu_id
> > > intel_pstate_cpu_ee_disable_ids[];
> > > +
> > >  static void __init intel_pstate_sysfs_expose_params(void)
> > >  {
> > >  	struct kobject *intel_pstate_kobject;
> > > @@ -1273,6 +1314,12 @@ static void __init
> > > intel_pstate_sysfs_expose_params(void)
> > >  				       &hwp_dynamic_boost.attr);
> > >  		WARN_ON(rc);
> > >  	}
> > > +
> > > +	if (x86_match_cpu(intel_pstate_cpu_ee_disable_ids)) {
> > > +		rc = sysfs_create_file(intel_pstate_kobject,
> > > +				       &energy_efficiency_enable.attr);
> > > +		WARN_ON(rc);
> > > +	}
> > >  }
> > >  /************************** sysfs end ************************/
> > > 
> > > @@ -1288,8 +1335,6 @@ static void intel_pstate_hwp_enable(struct
> > > cpudata *cpudata)
> > >  		cpudata->epp_default = intel_pstate_get_epp(cpudata,
> > > 0);
> > >  }
> > > 
> > > -#define MSR_IA32_POWER_CTL_BIT_EE	19
> > > -
> > >  /* Disable energy efficiency optimization */
> > >  static void intel_pstate_disable_ee(int cpu)
> > >  {
> > > --
> > > 2.25.4
> 
> 

