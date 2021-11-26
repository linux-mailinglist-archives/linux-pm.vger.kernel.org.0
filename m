Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913B845E7D1
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 07:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358755AbhKZG2e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 01:28:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:37939 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244228AbhKZG0d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Nov 2021 01:26:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="321850750"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="321850750"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 22:23:21 -0800
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="458080324"
Received: from spaul5-mobl1.gar.corp.intel.com ([10.213.66.246])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 22:23:15 -0800
Message-ID: <db11c70c0e04cfa5f3c0fb6d49543e9f1971f3d4.camel@linux.intel.com>
Subject: Re: [PATCH 7/7] thermal: intel: hfi: Notify user space for HFI
 events
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 25 Nov 2021 22:23:12 -0800
In-Reply-To: <CAJZ5v0j=+QSwmwVg8chcTchPAXdbt2h1g=4+tMbLpDxstfRq6A@mail.gmail.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
         <20211106013312.26698-8-ricardo.neri-calderon@linux.intel.com>
         <CAJZ5v0j=+QSwmwVg8chcTchPAXdbt2h1g=4+tMbLpDxstfRq6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2021-11-24 at 16:18 +0100, Rafael J. Wysocki wrote:
> On Sat, Nov 6, 2021 at 2:34 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> > 
> > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > 
> > When the hardware issues an HFI event, relay a notification to user
> > space.
> > This allows user space to respond by reading performance and
> > efficiency of
> > each CPU and take appropriate action.
> > 
> > For example, when performance and efficiency of a CPU is 0, user
> > space can
> > either offline the CPU or inject idle. Also, if user space notices
> > a
> > downward trend in performance, it may proactively adjust power
> > limits to
> > avoid future situations in which performance drops to 0.
> > 
> > To avoid excessive notifications, the rate is limited by one HZ per
> > event.
> > To limit netlink message size, parameters for only 16 CPUs at max
> > are sent
> > in one message. If there are more than 16 CPUs, issue as many
> > messages as
> > needed to notify the status of all CPUs.
> > 
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: Srinivas Pandruvada < 
> > srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/thermal/intel/Kconfig     |  1 +
> >  drivers/thermal/intel/intel_hfi.c | 55
> > ++++++++++++++++++++++++++++++-
> >  2 files changed, 55 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/intel/Kconfig
> > b/drivers/thermal/intel/Kconfig
> > index d4c6bdcacddb..b6a1f777b8e7 100644
> > --- a/drivers/thermal/intel/Kconfig
> > +++ b/drivers/thermal/intel/Kconfig
> > @@ -104,6 +104,7 @@ config INTEL_HFI
> >         bool "Intel Hardware Feedback Interface"
> >         depends on CPU_SUP_INTEL
> >         depends on SCHED_MC && X86_THERMAL_VECTOR
> > +       select THERMAL_NETLINK
> >         help
> >           Select this option to enable the Hardware Feedback
> > Interface. If
> >           selected, hardware provides guidance to the operating
> > system on
> > diff --git a/drivers/thermal/intel/intel_hfi.c
> > b/drivers/thermal/intel/intel_hfi.c
> > index 1df24b39f2e6..c669a037704e 100644
> > --- a/drivers/thermal/intel/intel_hfi.c
> > +++ b/drivers/thermal/intel/intel_hfi.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/io.h>
> >  #include <linux/slab.h>
> > 
> > +#include "../thermal_core.h"
> >  #include "intel_hfi.h"
> > 
> >  #define THERM_STATUS_CLEAR_PKG_MASK (BIT(1) | BIT(3) | BIT(5) |
> > BIT(7) | \
> > @@ -124,6 +125,58 @@ static struct hfi_features hfi_features;
> >  static DEFINE_MUTEX(hfi_lock);
> > 
> >  #define HFI_UPDATE_INTERVAL    HZ
> > +#define HFI_MAX_THERM_NOTIFY_COUNT     16
> > +
> > +static int get_one_hfi_cap(struct hfi_instance *hfi_instance, int
> > cpu,
> > +                          struct hfi_cpu_data *hfi_caps)
> > +{
> > +       struct hfi_cpu_data *caps;
> > +       unsigned long flags;
> > +       s16 index;
> > +
> > +       index = per_cpu(hfi_cpu_info, cpu).index;
> > +       if (index < 0)
> > +               return -EINVAL;
> 
> When does this happen?
Highly unlikely. This can happen if somehow CPUID_HFI_LEAF is
programmed negative for a CPU, which shouldn't happen.

> 
> Can the index become negative after this check?
No. This is programmed only one time during online CPU and never
changed after that. If this is in hfi_instance->cpus, then the leaf is
already read.

> 
> Could this check be done in the caller (so this function could be a
> void one)?
Can be done.

Thanks,
Srinivas

> 
> > +
> > +       /* Find the capabilities of @cpu */
> > +       raw_spin_lock_irqsave(&hfi_instance->event_lock, flags);
> > +       caps = hfi_instance->data + index *
> > hfi_features.cpu_stride;
> > +       memcpy(hfi_caps, caps, sizeof(*hfi_caps));
> > +       raw_spin_unlock_irqrestore(&hfi_instance->event_lock,
> > flags);
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Call update_capabilities() when there are changes in the HFI
> > table.
> > + */
> > +static void update_capabilities(struct hfi_instance *hfi_instance)
> > +{
> > +       struct cpu_capability cpu_caps[HFI_MAX_THERM_NOTIFY_COUNT];
> > +       int i = 0, cpu;
> > +
> > +       for_each_cpu(cpu, hfi_instance->cpus) {
> > +               struct hfi_cpu_data caps;
> > +               int ret;
> > +
> > +               ret = get_one_hfi_cap(hfi_instance, cpu, &caps);
> > +               if (ret)
> > +                       continue;
> > +
> > +               cpu_caps[i].cpu = cpu;
> > +               cpu_caps[i].perf = caps.perf_cap;
> > +               cpu_caps[i].eff = caps.ee_cap;
> > +               ++i;
> > +               if (i >= HFI_MAX_THERM_NOTIFY_COUNT) {
> > +                      
> > thermal_genl_cpu_capability_event(HFI_MAX_THERM_NOTIFY_COUNT,
> > +                                                        
> > cpu_caps);
> > +                       i = 0;
> > +               }
> > +       }
> > +
> > +       if (i)
> > +               thermal_genl_cpu_capability_event(i, cpu_caps);
> > +}
> > 
> >  static void hfi_update_work_fn(struct work_struct *work)
> >  {
> > @@ -134,7 +187,7 @@ static void hfi_update_work_fn(struct
> > work_struct *work)
> >         if (!hfi_instance)
> >                 return;
> > 
> > -       /* TODO: Consume update here. */
> > +       update_capabilities(hfi_instance);
> >  }
> > 
> >  void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
> > --
> > 2.17.1
> > 


