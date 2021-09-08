Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B74940326A
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 03:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346910AbhIHBzZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 21:55:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:6401 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346901AbhIHBzZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Sep 2021 21:55:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="200564784"
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="200564784"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 18:54:12 -0700
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="430444463"
Received: from sbhowmik-mobl.gar.corp.intel.com ([10.215.126.139])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 18:54:09 -0700
Message-ID: <7fa77e2239dd87004319a799dbea39988b718233.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Process HWP Guaranteed
 change notification
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     xry111@mengyan1223.wang, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 07 Sep 2021 18:54:05 -0700
In-Reply-To: <00450b0a9efbfde513ea8b445d31657ce5ac2f37.camel@mengyan1223.wang>
References: <20210820024006.2347720-1-srinivas.pandruvada@linux.intel.com>
         <20210820024006.2347720-2-srinivas.pandruvada@linux.intel.com>
         <00450b0a9efbfde513ea8b445d31657ce5ac2f37.camel@mengyan1223.wang>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Wang,

I think this is Lenovo system. The FW sends some interrupts prematurely
before driver is ready,

There is a fix available but We have decided to revert the commit.

Please try the patch attached here.
https://bugzilla.kernel.org/show_bug.cgi?id=214329

Thanks,
Srinivas

On Wed, 2021-09-08 at 02:13 +0800, Xi Ruoyao wrote:
> Hi Srinivas,
> 
> Sorry for distrubing, but the mainline kernel panics on my system
> during
> boot. By reverting this commit the problem seems fixed.
> 
> I don't have kdump set up on the system, so I could only took a photo
> containing (a part of :( ) panic message.  The system is a laptop with
> Core i7-1065G7.  My kernel config is also attached.
> 
> Not sure if there is something wrong in this commit, or there is a
> firmware bug from the vendor of my laptop.  In the latter case, can we
> have something in kernel config or cmdline to disable HWP as a
> workaround?
> 
> On Thu, 2021-08-19 at 19:40 -0700, Srinivas Pandruvada wrote:
> > It is possible that HWP guaranteed ratio is changed in response to
> > change in power and thermal limits. For example when Intel Speed
> > Select
> > performance profile is changed or there is change in TDP, hardware
> > can
> > send notifications. It is possible that the guaranteed ratio is
> > increased. This creates an issue when turbo is disabled, as the old
> > limits set in MSR_HWP_REQUEST are still lower and hardware will clip
> > to older limits.
> > 
> > This change enables HWP interrupt and process HWP interrupts. When
> > guaranteed is changed, calls cpufreq_update_policy() so that driver
> > callbacks are called to update to new HWP limits. This callback
> > is called from a delayed workqueue of 10ms to avoid frequent updates.
> > 
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 39
> > ++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index bb4549959b11..0fd2375c1f1e 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -32,6 +32,7 @@
> >  #include <asm/cpu_device_id.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/intel-family.h>
> > +#include "../drivers/thermal/intel/thermal_interrupt.h"
> >  
> >  #define INTEL_PSTATE_SAMPLING_INTERVAL (10 * NSEC_PER_MSEC)
> >  
> > @@ -219,6 +220,7 @@ struct global_params {
> >   * @sched_flags:       Store scheduler flags for possible cross CPU
> > update
> >   * @hwp_boost_min:     Last HWP boosted min performance
> >   * @suspended:         Whether or not the driver has been suspended.
> > + * @hwp_notify_work:   workqueue for HWP notifications.
> >   *
> >   * This structure stores per CPU instance data for all CPUs.
> >   */
> > @@ -257,6 +259,7 @@ struct cpudata {
> >         unsigned int sched_flags;
> >         u32 hwp_boost_min;
> >         bool suspended;
> > +       struct delayed_work hwp_notify_work;
> >  };
> >  
> >  static struct cpudata **all_cpu_data;
> > @@ -1625,6 +1628,40 @@ static void
> > intel_pstate_sysfs_hide_hwp_dynamic_boost(void)
> >  
> >  /************************** sysfs end ************************/
> >  
> > +static void intel_pstate_notify_work(struct work_struct *work)
> > +{
> > +       mutex_lock(&intel_pstate_driver_lock);
> > +       cpufreq_update_policy(smp_processor_id());
> > +       wrmsrl(MSR_HWP_STATUS, 0);
> > +       mutex_unlock(&intel_pstate_driver_lock);
> > +}
> > +
> > +void notify_hwp_interrupt(void)
> > +{
> > +       unsigned int this_cpu = smp_processor_id();
> > +       struct cpudata *cpudata;
> > +       u64 value;
> > +
> > +       if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
> > +               return;
> > +
> > +       rdmsrl(MSR_HWP_STATUS, value);
> > +       if (!(value & 0x01))
> > +               return;
> > +
> > +       cpudata = all_cpu_data[this_cpu];
> > +       schedule_delayed_work_on(this_cpu, &cpudata->hwp_notify_work,
> > msecs_to_jiffies(10));
> > +}
> > +
> > +static void intel_pstate_enable_hwp_interrupt(struct cpudata
> > *cpudata)
> > +{
> > +       /* Enable HWP notification interrupt for guaranteed
> > performance change */
> > +       if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
> > +               INIT_DELAYED_WORK(&cpudata->hwp_notify_work,
> > intel_pstate_notify_work);
> > +               wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);
> > +       }
> > +}
> > +
> >  static void intel_pstate_hwp_enable(struct cpudata *cpudata)
> >  {
> >         /* First disable HWP notification interrupt as we don't
> > process them */
> > @@ -1634,6 +1671,8 @@ static void intel_pstate_hwp_enable(struct
> > cpudata *cpudata)
> >         wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
> >         if (cpudata->epp_default == -EINVAL)
> >                 cpudata->epp_default = intel_pstate_get_epp(cpudata,
> > 0);
> > +
> > +       intel_pstate_enable_hwp_interrupt(cpudata);
> >  }
> >  
> >  static int atom_get_min_pstate(void)
> 


