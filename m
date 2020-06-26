Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E78B20AEC5
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 11:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgFZJMK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 05:12:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:48042 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgFZJMJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Jun 2020 05:12:09 -0400
IronPort-SDR: h8j71x7kOJIlek4t+ELMXfOeJE7/CQ7EStk4+MomaloZC8QifADgSih9CKtU87BZM2apjLzr7V
 eG4U49D1WMAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="206764587"
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="206764587"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 02:12:08 -0700
IronPort-SDR: 6JI1Y+OUl0Mv4tevFg34eQwL8z5VY5MRahJcc5e5veIPJbS0AD3r0sZuwgmu1wVHs49GHySfU0
 QgIH+fTy9u8Q==
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="311360439"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.133.102])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 02:12:08 -0700
Message-ID: <d273532c9d32f0f88ebab37dd820f601ab0a37a3.camel@linux.intel.com>
Subject: Re: [UPDATE][PATCH v3 1/2] cpufreq: intel_pstate: Allow
 enable/disable energy efficiency
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        dsmythies@telus.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Fri, 26 Jun 2020 02:12:08 -0700
In-Reply-To: <20200626084903.GA27151@zn.tnic>
References: <20200625224931.1468150-1-srinivas.pandruvada@linux.intel.com>
         <20200626084903.GA27151@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-06-26 at 10:49 +0200, Borislav Petkov wrote:
> On Thu, Jun 25, 2020 at 03:49:31PM -0700, Srinivas Pandruvada wrote:
> > By default intel_pstate driver disables energy efficiency by
> > setting
> > MSR_IA32_POWER_CTL bit 19 for Kaby Lake desktop CPU model in HWP
> > mode.
> > This CPU model is also shared by Coffee Lake desktop CPUs. This
> > allows
> > these systems to reach maximum possible frequency. But this adds
> > power
> > penalty, which some customers don't want. They want some way to
> > enable/
> > disable dynamically.
> > 
> > So, add an additional attribute "energy_efficiency_enable" under
> > /sys/devices/system/cpu/intel_pstate/ for these CPU models. This
> > allows
> > to read and write bit 19 ("Disable Energy Efficiency Optimization")
> > in
> > the MSR IA32_POWER_CTL.
> 
> 

[...]

> > +``energy_efficiency_enable``
> > +	This attribute is only present on platforms, which has CPUs
> > matching
> 
> 						which have
> 
Thanks, I will fix that.

> > +	Kaby Lake or Coffee Lake desktop CPU model. By default
> > +	"energy_efficiency" is disabled on these CPU models in HWP mode
> > by this
> > +	driver. Enabling energy efficiency may limit maximum operating
> > +	frequency in both HWP and non HWP mode. In non HWP mode, this
> > attribute
> > +	has an effect in turbo range only. But in HWP mode, this
> > attribute also
> > +	has an effect in non turbo range.
> 
> Those last two sentences could be simplified - read strange.
I will try to address this.

[...]

> > @@ -254,6 +254,7 @@
> >  #define MSR_PEBS_FRONTEND		0x000003f7
> >  
> >  #define MSR_IA32_POWER_CTL		0x000001fc
> > +#define MSR_IA32_POWER_CTL_BIT_EE	19
> 
> Sort that MSR in - I know, the rest is not sorted either but we can
> start somewhere. So pls put it...
> 
I will.

> #define MSR_LBR_SELECT                  0x000001c8
> #define MSR_LBR_TOS                     0x000001c9
> 
> <--- here.
> 
> 

[...]

> > +
> > +	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
> > +	enable = (power_ctl & BIT(MSR_IA32_POWER_CTL_BIT_EE)) >>
> > MSR_IA32_POWER_CTL_BIT_EE;
> 
> So you can simplify to:
> 
> 	enable = !!(power_ctl & BIT(MSR_IA32_POWER_CTL_BIT_EE));
> 
> methinks.
> 
Better.

> > +	return sprintf(buf, "%d\n", !enable);
> 
> If this bit is called
> 
> 	"Disable Energy Efficiency Optimization"
> 
> why do you call your function and sysfs file "enable"? This is making
> it
> more confusing.
> 
> Why don't you call it simply: "energy_efficiency" and have it
> intuitive:
> 
> 1 - enabled
> 0 - disabled
> 
I think your suggestion is good. The one other attributes under this
directory has similar style. I will get rid of "_enable".

> ?
> 
> > +static ssize_t store_energy_efficiency_enable(struct kobject *a,
> > +					      struct kobj_attribute *b,
> > +					      const char *buf, size_t
> > count)
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
> 
> This is too lax - it will be enabled for any !0 value. Please accept
> only 0 and 1.
> 
OK.


Thanks for the review.


- Srinivas


