Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBA061A4347
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 10:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgDJICS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 04:02:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:57509 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgDJICS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Apr 2020 04:02:18 -0400
IronPort-SDR: Mp22S8sJ9d316LMsSWj1l3JSOwAuDTKrZ3v/B5LWbM1s0IUI+Rm0WqYa7FIddhAvRTiDsrwv8T
 iMBUbJ93yJLw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 01:02:18 -0700
IronPort-SDR: sST6rrBT8HzwRlIAYAQT1J6TBA+Pe0DCMIqxzBHE1tnbZfAMUyAVt8Cv1Q5aiMdcyo3t6OEMzV
 YRZf5p4hiSOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,366,1580803200"; 
   d="scan'208";a="452309889"
Received: from qjbian-mobl.amr.corp.intel.com ([10.255.31.146])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2020 01:02:14 -0700
Message-ID: <2bef9553fcf7ccd7c9811ad1d572af2e5a811917.camel@intel.com>
Subject: Re: [RFC PATCH 5/5] ACPI: processor: do update when maximum cooling
 state changed
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     tiwai@suse.de, viresh.kumar@linaro.org
Date:   Fri, 10 Apr 2020 16:02:13 +0800
In-Reply-To: <5cd80df7-775e-96bd-cec5-b14965de2a67@linaro.org>
References: <20200408041917.2329-1-rui.zhang@intel.com>
         <20200408041917.2329-5-rui.zhang@intel.com>
         <5cd80df7-775e-96bd-cec5-b14965de2a67@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-04-09 at 15:34 +0200, Daniel Lezcano wrote:
> Hi Rui,
> 
> 
> On 08/04/2020 06:19, Zhang Rui wrote:
> > ACPI processor cooling device supports 1 cooling state before
> > cpufreq
> > driver probed, and 4 cooling states after cpufreq driver probed.
> 
> What is this one state ?

One state means its original state and we can not set it to others.

ACPI processor cooling states are combined of p-state cooling states
and a couple of optional t-state cooling states.

Say, if we have a processor device supports 7 throttling states, it
actually supports 8 cooling states with cpufreq driver unprobed, and 11
cooling states with cpufreq driver probed.

> 
> > Thus update the statistics table when the cpufeq driver is
> > probed/unprobed.
> 
> To be honest, the series seems to skirt a problem in the acpi
> processor.
> 
> If there is a new policy, then there is a new cooling device. Why not
> unregister the old one and register the new one ?
> 
Good point.
IMO, the real problem is that do we support dynamic max_cooling_state
or not in the thermal framework.
Previously, I thought we don't have a hard rule of static
max_cooling_state because we always invoke .get_max_state() callback
when we need it. But after a second thought, actually we do have this
limitation. For example, when binding cooling devices to thermal zones,
the upper limit is set based on the return value of .get_max_state() at
the binding time, and we never update the upper limit later.
So this ACPI processor issue is not just about statistics table update
issue, we actually lose some of its cooling states.

Thus, a new max_state means that all the previous setting of the
cooling_device, i.e. all the thermal instances of the cooling device,
needs to get updated.

And to fix this, it's better to
a. unregister and re-register the cooling device as you suggested.
or
b. introduce an API that updates the cooling device entirely instead of
statistics table only.

For either of the above solutions, we'd better to cleanup the code to 
invoke .get_max_state() during registration/max_state_reset phase,
once, and then always use cached value later.
And plus, if we want to follow solution a), it's better to remove
.get_max_state() callback and use an integer instead so that every
driver knows this limitation.
I'd vote for solution a) if there is no soc thermal driver that may
return dynamic max_states.

Do I still miss something?

thanks,
rui
> 
> > This fixes an OOB issue when updating the statistics of the
> > processor
> > cooling device.
> > 
> > Fixes: 8ea229511e06 ("thermal: Add cooling device's statistics in
> > sysfs")
> > Reported-by: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/processor_thermal.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/acpi/processor_thermal.c
> > b/drivers/acpi/processor_thermal.c
> > index 41feb88ee92d..179d1b50ee2b 100644
> > --- a/drivers/acpi/processor_thermal.c
> > +++ b/drivers/acpi/processor_thermal.c
> > @@ -142,6 +142,7 @@ void acpi_thermal_cpufreq_init(struct
> > cpufreq_policy *policy)
> >  		if (ret < 0)
> >  			pr_err("Failed to add freq constraint for CPU%d
> > (%d)\n",
> >  			       cpu, ret);
> > +		thermal_cdev_stats_update_max(pr->cdev);
> >  	}
> >  }
> >  
> > @@ -154,6 +155,7 @@ void acpi_thermal_cpufreq_exit(struct
> > cpufreq_policy *policy)
> >  
> >  		if (pr)
> >  			freq_qos_remove_request(&pr->thermal_req);
> > +		thermal_cdev_stats_update_max(pr->cdev);
> >  	}
> >  }
> >  #else				/* ! CONFIG_CPU_FREQ */
> > 
> 
> 

