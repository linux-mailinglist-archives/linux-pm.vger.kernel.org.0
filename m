Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B9F48D216
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jan 2022 06:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiAMFuY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jan 2022 00:50:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:49980 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229764AbiAMFuX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Jan 2022 00:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642053023; x=1673589023;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5GpldVg/pogJ3OD2r58bImlRjUuAeXS4vjw0Lmmtj90=;
  b=DOo+lMVaqEOcCPyZzvHLMWYBjJJDx39UIGG2D0YzlCqxIgKacj6tbyo5
   VGcbRLJghdyqhXBNK36yBgBk+WIRgi8iEZC8NIY4L4chXRAEZpChvUI2H
   lbp4iKk3sb67bSh0Njozubd+OrLBWQMFJRTnUrMTegeRco7UHTPqnndGl
   +SnxdosyTpBznQLItJlATocRQBiuXteUI9ow08uIaU/6uNW7llF+6giXM
   97JOqD4GqKteKkTpXadZVtiBV0yPVLCF7fgaUYiCco1pP5cLwFM71jaZB
   /dmRW2aK8UZhvRQr/0ec1b9s9HrlJ8RdNVbxE4ObfZvzBCIt5rZEMUSGI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="268288076"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="268288076"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 21:50:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="623744601"
Received: from mjjanin-mobl1.amr.corp.intel.com ([10.209.25.129])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 21:50:22 -0800
Message-ID: <90262b7d330c48503c5b16d5e455eac91243ccf0.camel@linux.intel.com>
Subject: Re: [PATCH v4 7/7] thermal: intel: hfi: Notify user space for HFI
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
        Lukasz Luba <lukasz.luba@arm.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Jan 2022 21:50:21 -0800
In-Reply-To: <a41853fdaee888761ac2a34708118991b70cb904.camel@linux.intel.com>
References: <20220108034743.31277-1-ricardo.neri-calderon@linux.intel.com>
         <20220108034743.31277-8-ricardo.neri-calderon@linux.intel.com>
         <CAJZ5v0h5-xsYCfs=c+wE4tWrcmvkdbgrc+fnwytSghwuAWnu0A@mail.gmail.com>
         <a41853fdaee888761ac2a34708118991b70cb904.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2022-01-12 at 15:54 -0800, Srinivas Pandruvada wrote:
> On Wed, 2022-01-12 at 20:53 +0100, Rafael J. Wysocki wrote:
> > On Sat, Jan 8, 2022 at 4:46 AM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > 
> > > When the hardware issues an HFI event, relay a notification to
> > > user
> > > space.
> > > This allows user space to respond by reading performance and
> > > efficiency of
> > > each CPU and take appropriate action.
> > > 
> > > For example, when performance and efficiency of a CPU is 0, user
> > > space can
> > > either offline the CPU or inject idle. Also, if user space
> > > notices
> > > a
> > > downward trend in performance, it may proactively adjust power
> > > limits to
> > > avoid future situations in which performance drops to 0.
> > > 
> > > To avoid excessive notifications, the rate is limited by one HZ
> > > per
> > > event.
> > > To limit the netlink message size, parameters for only 16 CPUs at
> > > max are
> > > sent in one message. If there are more than 16 CPUs, issue as
> > > many
> > > messages
> > > as needed to notify the status of all CPUs.
> > > 
> > > In the HFI specification, both performance and efficiency
> > > capabilities are
> > > set in the [0, 255] range. The existing implementations of HFI
> > > hardware
> > > do not scale the maximum values to 255. Since userspace cares
> > > about
> > > capability values that are either 0 or show a downward/upward
> > > trend, this
> > > fact does not matter much. Relative changes in capabilities are
> > > enough. To
> > > comply with the thermal netlink ABI, scale both performance and
> > > efficiency
> > > capabilities to the [0, 1023] interval.
> > > 
> > > Cc: Andi Kleen <ak@linux.intel.com>
> > > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > > Reviewed-by: Len Brown <len.brown@intel.com>
> > > Signed-off-by: Srinivas Pandruvada <
> > > srinivas.pandruvada@linux.intel.com>
> > > ---
> > > Changes since v3:
> > >   * None
> > > 
> > > Changes since v2:
> > >   * None
> > > 
> > > Changes since v1:
> > >   * Made get_one_hfi_cap() return void. Removed unnecessary
> > > checks.
> > >     (Rafael)
> > >   * Replaced raw_spin_[un]lock_irq[restore|save]() with raw_spin_
> > >     [un]lock_irq() in get_one_hfi_cap(). This function is only
> > > called from
> > >     a workqueue and there is no need to save and restore irq
> > > flags.
> > >   * Scaled performance and energy efficiency values to a [0,
> > > 1023]
> > > interval
> > >     when reporting values to user space via thermal netlink
> > > notifications.
> > >     (Lucasz).
> > >   * Reworded commit message to comment on the scaling of HFI
> > > capabilities
> > >     to comply with the proposed thermal netlink ABI.
> > > ---
> > >  drivers/thermal/intel/Kconfig     |  1 +
> > >  drivers/thermal/intel/intel_hfi.c | 57
> > > ++++++++++++++++++++++++++++++-
> > >  2 files changed, 57 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/thermal/intel/Kconfig
> > > b/drivers/thermal/intel/Kconfig
> > > index e9d2925227d4..6cf3fe36a4ae 100644
> > > --- a/drivers/thermal/intel/Kconfig
> > > +++ b/drivers/thermal/intel/Kconfig
> > > @@ -104,6 +104,7 @@ config INTEL_HFI_THERMAL
> > >         bool "Intel Hardware Feedback Interface"
> > >         depends on CPU_SUP_INTEL
> > >         depends on X86_THERMAL_VECTOR
> > > +       select THERMAL_NETLINK
> > >         help
> > >           Select this option to enable the Hardware Feedback
> > > Interface. If
> > >           selected, hardware provides guidance to the operating
> > > system on
> > > diff --git a/drivers/thermal/intel/intel_hfi.c
> > > b/drivers/thermal/intel/intel_hfi.c
> > > index 1a08c58f26f6..9fd66f176948 100644
> > > --- a/drivers/thermal/intel/intel_hfi.c
> > > +++ b/drivers/thermal/intel/intel_hfi.c
> > > @@ -40,6 +40,7 @@
> > > 
> > >  #include <asm/msr.h>
> > > 
> > > +#include "../thermal_core.h"
> > >  #include "intel_hfi.h"
> > > 
> > >  #define THERM_STATUS_CLEAR_PKG_MASK (BIT(1) | BIT(3) | BIT(5) |
> > > BIT(7) | \
> > > @@ -162,6 +163,60 @@ static struct hfi_features hfi_features;
> > >  static DEFINE_MUTEX(hfi_instance_lock);
> > > 
> > >  #define HFI_UPDATE_INTERVAL    HZ
> > > +#define HFI_MAX_THERM_NOTIFY_COUNT     16
> > > +
> > > +static void get_one_hfi_cap(struct hfi_instance *hfi_instance,
> > > s16
> > > index,
> > > +                           struct hfi_cpu_data *hfi_caps)
> > > +{
> > > +       struct hfi_cpu_data *caps;
> > > +
> > > +       /* Find the capabilities of @cpu */
> > > +       raw_spin_lock_irq(&hfi_instance->table_lock);
> > > +       caps = hfi_instance->data + index *
> > > hfi_features.cpu_stride;
> > > +       memcpy(hfi_caps, caps, sizeof(*hfi_caps));
> > > +       raw_spin_unlock_irq(&hfi_instance->table_lock);
> > > +}
> > > +
> > > +/*
> > > + * Call update_capabilities() when there are changes in the HFI
> > > table.
> > > + */
> > > +static void update_capabilities(struct hfi_instance
> > > *hfi_instance)
> > > +{
> > > +       struct cpu_capability
> > > cpu_caps[HFI_MAX_THERM_NOTIFY_COUNT];
> > > +       int i = 0, cpu;
> > > +
> > 
> > Wouldn't it be better to hold hfi_instance_lock for the duration of
> > this loop?

diff --git a/drivers/thermal/intel/intel_hfi.c
b/drivers/thermal/intel/intel_hfi.c
index 77e54f2b2455..a386a3462738 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -392,45 +392,74 @@ static void get_one_hfi_cap(struct hfi_instance
*hfi_instance, s16 index,
        raw_spin_unlock_irq(&hfi_instance->table_lock);
 }
 
-/*
- * Call update_capabilities() when there are changes in the HFI table.
- */
-static void update_capabilities(struct hfi_instance *hfi_instance)
+static void get_hfi_caps(struct hfi_instance *hfi_instance, int
*count, struct cpu_capability **cpu_caps)
 {
-       struct cpu_capability cpu_caps[HFI_MAX_THERM_NOTIFY_COUNT];
-       int i = 0, cpu;
+       struct cpu_capability *_cpu_caps;
+       int _count, cpu, i = 0;
+
+       *count = 0;
+
+       raw_spin_lock_irq(&hfi_instance->table_lock);
+       _count = cpumask_weight(hfi_instance->cpus);
+       if (!_count)
+               goto unlock;
+
+       _cpu_caps = kcalloc(_count, sizeof(*_cpu_caps), GFP_ATOMIC);
+       if (!_cpu_caps)
+               goto unlock;
 
        for_each_cpu(cpu, hfi_instance->cpus) {
-               struct hfi_cpu_data caps;
+               struct hfi_cpu_data *caps;
                s16 index;
 
-               /*
-                * We know index is valid because this CPU is present
-                * in this instance.
-                */
                index = per_cpu(hfi_cpu_info, cpu).index;
-
-               get_one_hfi_cap(hfi_instance, index, &caps, 0);
-
-               cpu_caps[i].cpu = cpu;
+               caps = hfi_instance->data + index *
hfi_features.cpu_stride;
+               _cpu_caps[i].cpu = cpu;
 
                /*
                 * Scale performance and energy efficiency to
                 * the [0, 1023] interval that thermal netlink uses.
                 */
-               cpu_caps[i].performance = caps.perf_cap << 2;
-               cpu_caps[i].efficiency = caps.ee_cap << 2;
+               _cpu_caps[i].performance = caps->perf_cap << 2;
+               _cpu_caps[i].efficiency = caps->ee_cap << 2;
+
                ++i;
+               if (i >= _count)
+                       break;
+       }
+       *count = i;
+       *cpu_caps = _cpu_caps;
 
-               if (i >= HFI_MAX_THERM_NOTIFY_COUNT) {
-                       thermal_genl_cpu_capability_event(HFI_MAX_THERM
_NOTIFY_COUNT,
-                                                         cpu_caps);
-                       i = 0;
-               }
+unlock:
+       raw_spin_unlock_irq(&hfi_instance->table_lock);
+}
+
+/*
+ * Call update_capabilities() when there are changes in the HFI table.
+ */
+static void update_capabilities(struct hfi_instance *hfi_instance)
+{
+       struct cpu_capability *cpu_caps;
+       int i, j = 0, count;
+
+       get_hfi_caps(hfi_instance, &count, &cpu_caps);
+       if (!count)
+               return;
+
+       if (count < HFI_MAX_THERM_NOTIFY_COUNT)
+               goto last_cmd;
+
+       for (i = 0; i < count; i += HFI_MAX_THERM_NOTIFY_COUNT) {
+               thermal_genl_cpu_capability_event(HFI_MAX_THERM_NOTIFY_
COUNT, &cpu_caps[i]);
+               j = i;
        }
 
-       if (i)
-               thermal_genl_cpu_capability_event(i, cpu_caps);
+       count = i - count;
+last_cmd:
+       if (count)
+               thermal_genl_cpu_capability_event(count, &cpu_caps[j]);
+
+       kfree(cpu_caps);
 }

> As you expressed concern with more CPUs per package in future +
> netlink
> processing the interrupts will be disabled for longer time.
> 
> But this can be optimized to have
> void get_one_hfi_cap(struct hfi_instance *hfi_instance, s16 index,
> struct hfi_cpu_data *hfi_caps)
> with something like
> void get_hfi_caps(struct hfi_instance *hfi_instance, s16 *cpu_count,
> struct hfi_cpu_data **hfi_caps)

something like this:

diff --git a/drivers/thermal/intel/intel_hfi.c
b/drivers/thermal/intel/intel_hfi.c
index 77e54f2b2455..a386a3462738 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -392,45 +392,74 @@ static void get_one_hfi_cap(struct hfi_instance
*hfi_instance, s16 index,
        raw_spin_unlock_irq(&hfi_instance->table_lock);
 }
 
-/*
- * Call update_capabilities() when there are changes in the HFI table.
- */
-static void update_capabilities(struct hfi_instance *hfi_instance)
+static void get_hfi_caps(struct hfi_instance *hfi_instance, int
*count, struct cpu_capability **cpu_caps)
 {
-       struct cpu_capability cpu_caps[HFI_MAX_THERM_NOTIFY_COUNT];
-       int i = 0, cpu;
+       struct cpu_capability *_cpu_caps;
+       int _count, cpu, i = 0;
+
+       *count = 0;
+
+       raw_spin_lock_irq(&hfi_instance->table_lock);
+       _count = cpumask_weight(hfi_instance->cpus);
+       if (!_count)
+               goto unlock;
+
+       _cpu_caps = kcalloc(_count, sizeof(*_cpu_caps), GFP_ATOMIC);
+       if (!_cpu_caps)
+               goto unlock;
 
        for_each_cpu(cpu, hfi_instance->cpus) {
-               struct hfi_cpu_data caps;
+               struct hfi_cpu_data *caps;
                s16 index;
 
-               /*
-                * We know index is valid because this CPU is present
-                * in this instance.
-                */
                index = per_cpu(hfi_cpu_info, cpu).index;
-
-               get_one_hfi_cap(hfi_instance, index, &caps, 0);
-
-               cpu_caps[i].cpu = cpu;
+               caps = hfi_instance->data + index *
hfi_features.cpu_stride;
+               _cpu_caps[i].cpu = cpu;
 
                /*
                 * Scale performance and energy efficiency to
                 * the [0, 1023] interval that thermal netlink uses.
                 */
-               cpu_caps[i].performance = caps.perf_cap << 2;
-               cpu_caps[i].efficiency = caps.ee_cap << 2;
+               _cpu_caps[i].performance = caps->perf_cap << 2;
+               _cpu_caps[i].efficiency = caps->ee_cap << 2;
+
                ++i;
+               if (i >= _count)
+                       break;
+       }
+       *count = i;
+       *cpu_caps = _cpu_caps;
 
-               if (i >= HFI_MAX_THERM_NOTIFY_COUNT) {
-                       thermal_genl_cpu_capability_event(HFI_MAX_THERM
_NOTIFY_COUNT,
-                                                         cpu_caps);
-                       i = 0;
-               }
+unlock:
+       raw_spin_unlock_irq(&hfi_instance->table_lock);
+}
+
+/*
+ * Call update_capabilities() when there are changes in the HFI table.
+ */
+static void update_capabilities(struct hfi_instance *hfi_instance)
+{
+       struct cpu_capability *cpu_caps;
+       int i, j = 0, count;
+
+       get_hfi_caps(hfi_instance, &count, &cpu_caps);
+       if (!count)
+               return;
+
+       if (count < HFI_MAX_THERM_NOTIFY_COUNT)
+               goto last_cmd;
+
+       for (i = 0; i < count; i += HFI_MAX_THERM_NOTIFY_COUNT) {
+               thermal_genl_cpu_capability_event(HFI_MAX_THERM_NOTIFY_
COUNT, &cpu_caps[i]);
+               j = i;
        }
 
-       if (i)
-               thermal_genl_cpu_capability_event(i, cpu_caps);
+       count = i - count;
+last_cmd:
+       if (count)
+               thermal_genl_cpu_capability_event(count, &cpu_caps[j]);
+
+       kfree(cpu_caps);
 }

> and take one lock for all
> HFI_MAX_THERM_NOTIFY_COUNT CPUs.
> 
> Then keep thermal_genl_cpu_capability_event outside.
> This ends up in calling thermal_genl_send_event() which has a long
> call
> chain to netlink_broadcast() to format and broadcast message.
> 
> Thanks,
> Srinivas
> 
> > Surely, CPU offline or online during it can be confusing.
> > 
> > > +       for_each_cpu(cpu, hfi_instance->cpus) {
> > > +               struct hfi_cpu_data caps;
> > > +               s16 index;
> > > +
> > > +               /*
> > > +                * We know index is valid because this CPU is
> > > present
> > > +                * in this instance.
> > > +                */
> > > +               index = per_cpu(hfi_cpu_info, cpu).index;
> > > +
> > > +               get_one_hfi_cap(hfi_instance, index, &caps);
> > > +
> > > +               cpu_caps[i].cpu = cpu;
> > > +
> > > +               /*
> > > +                * Scale performance and energy efficiency to
> > > +                * the [0, 1023] interval that thermal netlink
> > > uses.
> > > +                */
> > > +               cpu_caps[i].performance = caps.perf_cap << 2;
> > > +               cpu_caps[i].efficiency = caps.ee_cap << 2;
> > > +               ++i;
> > > +
> > > +               if (i >= HFI_MAX_THERM_NOTIFY_COUNT) {
> > > +                       thermal_genl_cpu_capability_event(HFI_MAX
> > > _T
> > > HERM_NOTIFY_COUNT,
> > > +                                                         cpu_cap
> > > s)
> > > ;
> > > +                       i = 0;
> > > +               }
> > > +       }
> > > +
> > > +       if (i)
> > > +               thermal_genl_cpu_capability_event(i, cpu_caps);
> > > +}
> > > 
> > >  static void hfi_update_work_fn(struct work_struct *work)
> > >  {
> > > @@ -172,7 +227,7 @@ static void hfi_update_work_fn(struct
> > > work_struct *work)
> > >         if (!hfi_instance)
> > >                 return;
> > > 
> > > -       /* TODO: Consume update here. */
> > > +       update_capabilities(hfi_instance);
> > >  }
> > > 
> > >  void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
> > > --
> > > 2.17.1
> > > 

