Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4911645C879
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 16:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhKXPWQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 10:22:16 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41523 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhKXPWH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 10:22:07 -0500
Received: by mail-oi1-f176.google.com with SMTP id u74so5975402oie.8;
        Wed, 24 Nov 2021 07:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qit6Jz3QILsxBlB+d8BX6t8kVpsrltoBM47rPBs0iwg=;
        b=jqpwwcupMl4wU2i/chzpntzERHIhpo35ThsU6ueiMNQgOEI/voKMqcRLaIQaJ8vGO1
         34DM2HLZ29i7QJ+aD77mffiPARdUs2AnmMo/MfUZ/nwauL2qg1dv6/qa655+syfx3VA2
         0kceWk+bEZ5QUerURcTCwisxJG2/qgKD9ugYka2EuCGgvtJYIyw5QAmYXrGEPtbKcL3k
         5gxa2v8oxsm5t+um4oxijwmM1lia4UZPgccusOWoV1zW/psz+1TOiYsNdJH2amsqdC81
         jai0VWSntiuMmBmm36OU1dekDoFqOgKGbFziQlRSQcq0LhyD5tfp2B9zILv+jff1tVi4
         t2VQ==
X-Gm-Message-State: AOAM532YAv2uuGg+aFIiEbVb/AaS0cxO0k7lFrzsKpX0ahVBrpMPJxV3
        p4fKhRmM0as2s5qReiql/VAk6agzq+KlL9nkQQg=
X-Google-Smtp-Source: ABdhPJxdQdCi4KvNdCX8SyvD94y9jIrYCmEDY9JM3repE7/DqtYebiGktELH63vCPHj5sYg+5V1GH0DuCoZIyBS7Qpo=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr6829761oiw.154.1637767137290;
 Wed, 24 Nov 2021 07:18:57 -0800 (PST)
MIME-Version: 1.0
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com> <20211106013312.26698-8-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20211106013312.26698-8-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Nov 2021 16:18:46 +0100
Message-ID: <CAJZ5v0j=+QSwmwVg8chcTchPAXdbt2h1g=4+tMbLpDxstfRq6A@mail.gmail.com>
Subject: Re: [PATCH 7/7] thermal: intel: hfi: Notify user space for HFI events
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Nov 6, 2021 at 2:34 AM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> When the hardware issues an HFI event, relay a notification to user space.
> This allows user space to respond by reading performance and efficiency of
> each CPU and take appropriate action.
>
> For example, when performance and efficiency of a CPU is 0, user space can
> either offline the CPU or inject idle. Also, if user space notices a
> downward trend in performance, it may proactively adjust power limits to
> avoid future situations in which performance drops to 0.
>
> To avoid excessive notifications, the rate is limited by one HZ per event.
> To limit netlink message size, parameters for only 16 CPUs at max are sent
> in one message. If there are more than 16 CPUs, issue as many messages as
> needed to notify the status of all CPUs.
>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/thermal/intel/Kconfig     |  1 +
>  drivers/thermal/intel/intel_hfi.c | 55 ++++++++++++++++++++++++++++++-
>  2 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> index d4c6bdcacddb..b6a1f777b8e7 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -104,6 +104,7 @@ config INTEL_HFI
>         bool "Intel Hardware Feedback Interface"
>         depends on CPU_SUP_INTEL
>         depends on SCHED_MC && X86_THERMAL_VECTOR
> +       select THERMAL_NETLINK
>         help
>           Select this option to enable the Hardware Feedback Interface. If
>           selected, hardware provides guidance to the operating system on
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 1df24b39f2e6..c669a037704e 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -24,6 +24,7 @@
>  #include <linux/io.h>
>  #include <linux/slab.h>
>
> +#include "../thermal_core.h"
>  #include "intel_hfi.h"
>
>  #define THERM_STATUS_CLEAR_PKG_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | \
> @@ -124,6 +125,58 @@ static struct hfi_features hfi_features;
>  static DEFINE_MUTEX(hfi_lock);
>
>  #define HFI_UPDATE_INTERVAL    HZ
> +#define HFI_MAX_THERM_NOTIFY_COUNT     16
> +
> +static int get_one_hfi_cap(struct hfi_instance *hfi_instance, int cpu,
> +                          struct hfi_cpu_data *hfi_caps)
> +{
> +       struct hfi_cpu_data *caps;
> +       unsigned long flags;
> +       s16 index;
> +
> +       index = per_cpu(hfi_cpu_info, cpu).index;
> +       if (index < 0)
> +               return -EINVAL;

When does this happen?

Can the index become negative after this check?

Could this check be done in the caller (so this function could be a void one)?

> +
> +       /* Find the capabilities of @cpu */
> +       raw_spin_lock_irqsave(&hfi_instance->event_lock, flags);
> +       caps = hfi_instance->data + index * hfi_features.cpu_stride;
> +       memcpy(hfi_caps, caps, sizeof(*hfi_caps));
> +       raw_spin_unlock_irqrestore(&hfi_instance->event_lock, flags);
> +
> +       return 0;
> +}
> +
> +/*
> + * Call update_capabilities() when there are changes in the HFI table.
> + */
> +static void update_capabilities(struct hfi_instance *hfi_instance)
> +{
> +       struct cpu_capability cpu_caps[HFI_MAX_THERM_NOTIFY_COUNT];
> +       int i = 0, cpu;
> +
> +       for_each_cpu(cpu, hfi_instance->cpus) {
> +               struct hfi_cpu_data caps;
> +               int ret;
> +
> +               ret = get_one_hfi_cap(hfi_instance, cpu, &caps);
> +               if (ret)
> +                       continue;
> +
> +               cpu_caps[i].cpu = cpu;
> +               cpu_caps[i].perf = caps.perf_cap;
> +               cpu_caps[i].eff = caps.ee_cap;
> +               ++i;
> +               if (i >= HFI_MAX_THERM_NOTIFY_COUNT) {
> +                       thermal_genl_cpu_capability_event(HFI_MAX_THERM_NOTIFY_COUNT,
> +                                                         cpu_caps);
> +                       i = 0;
> +               }
> +       }
> +
> +       if (i)
> +               thermal_genl_cpu_capability_event(i, cpu_caps);
> +}
>
>  static void hfi_update_work_fn(struct work_struct *work)
>  {
> @@ -134,7 +187,7 @@ static void hfi_update_work_fn(struct work_struct *work)
>         if (!hfi_instance)
>                 return;
>
> -       /* TODO: Consume update here. */
> +       update_capabilities(hfi_instance);
>  }
>
>  void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
> --
> 2.17.1
>
