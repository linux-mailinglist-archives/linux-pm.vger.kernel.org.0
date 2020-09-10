Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDAB2642C0
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 11:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbgIJJsX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 05:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728631AbgIJJsS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Sep 2020 05:48:18 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4594B20809
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 09:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599731295;
        bh=dFdpzN8R3/0L5C1z+O+yYoyeeBr6SXw7STXIpsE91Uo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z7qktH0cdkLx9iUQ4RwAZ+BKyskuEZN95ddEnUSE2393sIDJr9Pf6rLBmTVACooWy
         5jzP8x53e0fvFKcVU92zweqpxfu4ZXaXaczdYG/mBVONYACJ26QDHe8poCYQaPWTIV
         d8ygDpvti3jY0eqiS5Xip5rc9yZy+Vkol7acnCXE=
Received: by mail-vs1-f41.google.com with SMTP id c127so3057704vsc.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 02:48:15 -0700 (PDT)
X-Gm-Message-State: AOAM530kms1VcQKOYkig6Y9quM6cz3EotW6usy9Zy82mo9D9XNyXfBUr
        clOZWjjwd+MuSXZ2EaMYi+IVFoOF/UAH24Gx4bxQ2Q==
X-Google-Smtp-Source: ABdhPJx6xs0TODSf2PZijE4oVXaxOzbfBSkrQZEO5LPfrAlBmUeQ0VAf3xaTb6jIRDV4OPzWv/iNYwrc3KLbwVn9cXM=
X-Received: by 2002:a67:df06:: with SMTP id s6mr906947vsk.17.1599731294062;
 Thu, 10 Sep 2020 02:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200707171457.31540-1-daniel.lezcano@linaro.org>
In-Reply-To: <20200707171457.31540-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Thu, 10 Sep 2020 15:18:03 +0530
X-Gmail-Original-Message-ID: <CAHLCerPq_f3t=cgS0MXvWuRvPaBrAs2dZEyeNSOyZ3OXHgHNeg@mail.gmail.com>
Message-ID: <CAHLCerPq_f3t=cgS0MXvWuRvPaBrAs2dZEyeNSOyZ3OXHgHNeg@mail.gmail.com>
Subject: Re: [PATCH RFC] powercap/drivers/energy_model: protocode: Add
 powercap energy model based
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000854c0505aef2772c"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--000000000000854c0505aef2772c
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

On Tue, Jul 7, 2020 at 10:45 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On the embedded world, the complexity of the SoC leads to an
> increasing number of hotspots which need to be monitored and mitigated
> as a whole in order to prevent the temperature to go above the
> normative and legally stated 'skin temperature'.
>
> Another aspect is to sustain the performance for a given power budget,
> for example virtual reality where the user can feel dizziness if the
> GPU performance is capped while a big CPU is processing something
> else. Or reduce the battery charging because the dissipated power is
> too high compared with the power consumed by other devices.
>
> Nowadays, the current thermal daemons are abusing the thermal
> framework cooling device state to force a specific and arbitraty state

typo: arbitrary

> without taking care of the governor decisions. Given the closed loop
> of some governors that can confuse the logic or directly enter in
> a decision conflict.
>
> As the number of cooling device support is limited today to the CPU
> and the GPU, the thermal daemons have little control on the power
> dissipation of the system. The out of tree solutions are hacking
> around here and there in the drivers, in the frameworks to have
> control on the devices.
>
> The recent introduction of the energy model allows to get power
> information related to a gpu or a cpu device with a limited support.
>
> Thanks of the current work of Lukasz Luba:
>
>        https://lkml.org/lkml/2020/5/27/406
>
> The energy model is now being improved to be generic and extended to
> all devices, so giving the opportunity to SoC vendor to define the
> device energy model.
>
> On the other side, the powercap infrastructure is a perfect fit to define
> power constraints in a hierarchical way.
>
> The proposal is to use the powercap framework with the energy model in
> order to create a hierarchy of constraints the SoC vendor is able to
> define and assign a power budget on some nodes to cap the power.
>
> Example of constraints hierarchy:
>
> Soc
>   |
>   |-- gpu
>   |
>   `-- package
>         |
>         |-- perfdomain0
>         |         |
>         |         |-- cpu0
>         |         |
>         |         |-- cpu1
>         |         |
>         |         |-- cpu2
>         |         |
>         |         `-- cpu3
>         |
>         `-- perfdomain1
>                   |
>                   |-- cpu4
>                   |
>                   `-- cpu5
>
> The leaves of the tree are the real devices, the intermediate nodes
> are virtual, aggregating the children constraints and power

Consider rephrasing as: aggregating the constraints and power
characteristics of their children.

> characteristics.
>
> For example: cpu[0-3] have 179mW max, 'perfdomain0' has 716mW max,
> cpu[4-5] have 1130mw max each, 'perfordomain1' has 2260mW. It results
> 'package' has 2260 + 716 = 2976mW max.
>
> Each node have a weight on a 2^10 basis, in order to reflect the

Consider rephrasing as: node has a weight on a scale of 0 to 1024

> percentage of power distribution of the children's node. This
> percentage is used to dispatch the power limit to the children.
>
> For example: package has 2976mW max, the weigths for the children are:

typo: weights

>
>   perfdomain0: (716 * 1024) / 2976 = 246
>   perfdomain1: (2260 * 1024) / 2976 = 778
>
> If we want to apply a power limit constraint of 1500mW at the package
> level, the power limit will be distributed along the children as:
>
>   perfdomain0: (1500 * 246) / 1024 = 360mW
>   perfdomain1: (1500 * 778) / 1024 = 1140mW
>
> This simple approach allows to do a fair distribution of the power
> limit but it will be replaced by a more complex mechanism where the
> power limit will be dynamically adjusted depending on the power
> consumption of the different devices. This is an algorithm with auto
> power balancing with unused power. When an allocated power budget is
> not used by a device, the siblings can share this free power until the
> device needs more power.
>
> The algorithm was presented during the ELC:
>
> https://ossna2020.sched.com/event/c3Wf/ideas-for-finer-grained-control-over-your-heat-budget-amit-kucheria-daniel-lezcano-linaro
>
> Given the complexity of the code, it sounds reasonable to provide a
> first stone of the edifice allowing at least the thermal daemons to
> stop abusing the thermal framework where the primary goal is to
> protect the silicone, not cap the power.

typo: silicon

>
> However, one question remains: how do we describe the hierarchy?


> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/Kconfig       |   8 +
>  drivers/powercap/Makefile      |   1 +
>  drivers/powercap/powercap_em.c | 485 +++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h     |   1 +
>  4 files changed, 495 insertions(+)
>  create mode 100644 drivers/powercap/powercap_em.c
>
> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
> index ebc4d4578339..57f2e9f31560 100644
> --- a/drivers/powercap/Kconfig
> +++ b/drivers/powercap/Kconfig
> @@ -43,4 +43,12 @@ config IDLE_INJECT
>           CPUs for power capping. Idle period can be injected
>           synchronously on a set of specified CPUs or alternatively
>           on a per CPU basis.
> +
> +config POWERCAP_EM
> +        bool "Energy model based power capping"
> +       depends on ENERGY_MODEL
> +       default y

Don't make it default ;-)

> +       help
> +         This enables support for the power capping using the energy
> +         model and the associated per device performance state.
>  endif
> diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
> index 7255c94ec61c..d9fa1255a499 100644
> --- a/drivers/powercap/Makefile
> +++ b/drivers/powercap/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_POWERCAP) += powercap_sys.o
> +obj-$(CONFIG_POWERCAP_EM) += powercap_em.o
>  obj-$(CONFIG_INTEL_RAPL_CORE) += intel_rapl_common.o
>  obj-$(CONFIG_INTEL_RAPL) += intel_rapl_msr.o
>  obj-$(CONFIG_IDLE_INJECT) += idle_inject.o
> diff --git a/drivers/powercap/powercap_em.c b/drivers/powercap/powercap_em.c
> new file mode 100644
> index 000000000000..a5252d32c4e9
> --- /dev/null
> +++ b/drivers/powercap/powercap_em.c
> @@ -0,0 +1,485 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2020 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/cpumask.h>
> +#include <linux/cpufreq.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/device.h>
> +#include <linux/energy_model.h>
> +#include <linux/hrtimer.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pm_qos.h>
> +#include <linux/powercap.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/sysfs.h>
> +#include <linux/units.h>
> +
> +struct powercap_em {
> +       struct powercap_zone zone;
> +       struct powercap_em *parent;
> +       struct list_head sibling;
> +       struct list_head children;
> +       struct freq_qos_request qos_req;
> +       spinlock_t lock;
> +       bool mode;
> +       u64 power_limit;
> +       u64 power_max;
> +       u64 power_min;
> +       int weight;
> +       int cpu;
> +};
> +
> +static const char *constraint_name[] = {
> +       "Performance capping",
> +};
> +
> +static struct powercap_control_type *pct;
> +static struct powercap_em *pc_soc;
> +static struct powercap_em *pc_package;
> +
> +struct powercap_em *to_powercap_em(struct powercap_zone *zone)
> +{
> +       return container_of(zone, struct powercap_em, zone);
> +}
> +
> +/*
> + * Browse the powercap nodes of the tree and rebalance their
> + * weigths. This function is called when a node is inserted or
> + * deleted.
> + */
> +static void powercap_em_rebalance_weight(struct powercap_em *pcem)
> +{
> +       struct powercap_em *child;
> +
> +       spin_lock(&pcem->lock);
> +       list_for_each_entry(child, &pcem->children, sibling) {
> +
> +               child->weight = (child->power_max * 1024) / pcem->power_max;
> +
> +               powercap_em_rebalance_weight(child);
> +       }
> +       spin_unlock(&pcem->lock);
> +}
> +
> +/*
> + * Initialize the energy model powercap zone by calling the underlying
> + * powercap register function followed by the specific allocations.
> + */
> +static struct powercap_em *
> +powercap_em_register(struct powercap_control_type *control_type,
> +                    const char *name,
> +                    struct powercap_em *parent,
> +                    const struct powercap_zone_ops *ops,
> +                    int nr_constraints,
> +                    const struct powercap_zone_constraint_ops *const_ops)
> +{
> +       struct powercap_em *pcem;
> +       struct powercap_zone *pcz;
> +
> +       pcem = kzalloc(sizeof(*pcem), GFP_KERNEL);
> +       if (!pcem)
> +               return NULL;
> +
> +       INIT_LIST_HEAD(&pcem->children);
> +       INIT_LIST_HEAD(&pcem->sibling);
> +       spin_lock_init(&pcem->lock);
> +
> +       pcz = powercap_register_zone(&pcem->zone, control_type, name,
> +                                    parent ? &parent->zone : NULL,
> +                                    ops, nr_constraints, const_ops);
> +       if (IS_ERR(pcz)) {
> +               kfree(pcem);
> +               return NULL;
> +       }
> +
> +       /*
> +        * The root node does not have a parent
> +        */
> +       if (parent) {
> +               spin_lock(&parent->lock);
> +               list_add_tail(&pcem->sibling, &parent->children);
> +               spin_unlock(&parent->lock);
> +               pcem->parent = parent;
> +       }
> +
> +       return pcem;
> +}
> +

Move this function closer to where it is called?

> +/*
> + * When a new powercap zone is inserted, propagate its power numbers
> + * to the parents.
> + */
> +static int powercap_em_set_power_range(struct powercap_em *pcem,
> +                                      struct em_perf_domain *em)
> +{
> +       struct powercap_em *parent = pcem->parent;
> +       int nr_cpus = cpumask_weight(to_cpumask(em->cpus));
> +
> +       if (pcem->power_min || pcem->power_max)
> +               return -EINVAL;
> +
> +       pcem->power_min = em->table[0].power;
> +       pcem->power_min *= MICROWATT_PER_MILLIWATT;

This is undefined.

> +       pcem->power_min *= nr_cpus;
> +
> +       pcem->power_max = em->table[em->nr_cap_states - 1].power;

s/nr_cap_states/nr_perf_states as per changes done by Lukasz.


> +       pcem->power_max *= MICROWATT_PER_MILLIWATT;
> +       pcem->power_max *= nr_cpus;
> +
> +       while (parent) {
> +               spin_lock(&parent->lock);
> +               parent->power_min += pcem->power_min;
> +               parent->power_max += pcem->power_max;
> +               spin_unlock(&parent->lock);
> +               parent = parent->parent;
> +       }
> +
> +       return 0;
> +}
> +
> +static int get_max_power_range_uw(struct powercap_zone *pcz, u64 *max_power_uw)
> +{
> +       struct powercap_em *pcem = to_powercap_em(pcz);
> +
> +       spin_lock(&pcem->lock);
> +       *max_power_uw = pcem->power_max;
> +       spin_unlock(&pcem->lock);
> +
> +       return 0;
> +}
> +
> +static int get_pd_power_uw(struct powercap_zone *pcz, u64 *power_uw)
> +{
> +       struct powercap_em *pcem = to_powercap_em(pcz);
> +       struct em_perf_domain *pd;
> +       unsigned long freq;
> +       int i, nr_cpus;
> +
> +       freq = cpufreq_quick_get(pcem->cpu);
> +       pd = em_cpu_get(pcem->cpu);
> +       nr_cpus = cpumask_weight(to_cpumask(pd->cpus));
> +
> +       for (i = 0; i < pd->nr_cap_states; i++) {
> +
> +               if (pd->table[i].frequency < freq)
> +                       continue;
> +
> +               *power_uw = pd->table[i].power *
> +                       MICROWATT_PER_MILLIWATT * nr_cpus;
> +
> +               return 0;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int get_children_power_uw(struct powercap_zone *pcz, u64 *power_uw)
> +{
> +       struct powercap_em *pcem = to_powercap_em(pcz);
> +       struct powercap_em *child;
> +       u64 power;
> +       int ret = 0;
> +
> +       *power_uw = 0;
> +
> +       spin_lock(&pcem->lock);
> +       list_for_each_entry(child, &pcem->children, sibling) {
> +               ret = child->zone.ops->get_power_uw(&child->zone, &power);
> +               if (ret)
> +                       break;
> +               *power_uw += power;
> +       }
> +       spin_unlock(&pcem->lock);
> +
> +       return ret;
> +}
> +
> +static int set_domain_enable(struct powercap_zone *pcz, bool mode)
> +{
> +       struct powercap_em *pcem = to_powercap_em(pcz);
> +       struct cpufreq_policy *policy;
> +       struct em_perf_domain *pd;
> +       int ret;
> +
> +       if (mode) {
> +               policy = cpufreq_cpu_get(pcem->cpu);
> +               if (!policy)
> +                       return -EINVAL;
> +
> +               pd = em_cpu_get(pcem->cpu);
> +               if (!pd)
> +                       return -EINVAL;
> +
> +               ret = freq_qos_add_request(&policy->constraints,
> +                                          &pcem->qos_req, FREQ_QOS_MAX,
> +                                          pd->table[pd->nr_cap_states - 1].frequency);
> +               if (ret)
> +                       return ret;
> +
> +       } else {
> +               freq_qos_remove_request(&pcem->qos_req);
> +       }
> +
> +       pcem->mode = mode;
> +
> +       powercap_em_rebalance_weight(pc_soc);
> +
> +       return 0;
> +}
> +
> +static int get_domain_enable(struct powercap_zone *pcz, bool *mode)
> +{
> +       struct powercap_em *pcem = to_powercap_em(pcz);
> +
> +       *mode = pcem->mode;
> +
> +       return 0;
> +}
> +
> +static int release_zone(struct powercap_zone *pcz)
> +{
> +       struct powercap_em *pcem = to_powercap_em(pcz);
> +
> +       if (!list_empty(&pcem->children))
> +               return -EBUSY;
> +
> +       freq_qos_remove_request(&pcem->qos_req);
> +       list_del(&pcem->sibling);
> +       kfree(pcem);
> +       powercap_em_rebalance_weight(pc_soc);
> +
> +       return 0;
> +}
> +
> +/*
> + * Set the power limit on the nodes, the power limit is distributed
> + * given the weight of the children.
> + */
> +static int set_children_power_limit(struct powercap_zone *pcz, int cid,
> +                                   u64 power_limit)
> +{
> +       struct powercap_em *pcem = to_powercap_em(pcz);
> +       struct powercap_em *child;
> +       u64 power;
> +       int ret = 0;
> +
> +       /*
> +        * Don't allow values outside of the power range previously
> +        * set when initiliazing the powercap energy model zone
> +        */
> +       pcem->power_limit = clamp_val(power_limit,
> +                                     pcem->power_min,
> +                                     pcem->power_max);
> +
> +       spin_lock(&pcem->lock);
> +       list_for_each_entry(child, &pcem->children, sibling) {
> +
> +               power = (pcem->power_limit * child->weight) / 1024;
> +
> +               ret = child->zone.constraints->ops->set_power_limit_uw(
> +                       &child->zone, cid, power);
> +               if (ret)
> +                       break;
> +       }
> +       spin_unlock(&pcem->lock);
> +
> +
> +       return ret;
> +}
> +
> +static int get_children_power_limit(struct powercap_zone *pcz, int cid, u64 *data)
> +{
> +       struct powercap_em *pcem = to_powercap_em(pcz);
> +       struct powercap_em *child;
> +       u64 power;
> +       int ret = 0;
> +
> +       *data = 0;
> +
> +       spin_lock(&pcem->lock);
> +       list_for_each_entry(child, &pcem->children, sibling) {
> +               ret = child->zone.constraints->ops->get_power_limit_uw(
> +                       &child->zone, cid, &power);
> +               if (ret)
> +                       break;
> +               *data += power;
> +       }
> +       spin_unlock(&pcem->lock);
> +
> +       return ret;
> +}
> +
> +static const char *get_constraint_name(struct powercap_zone *pcz, int cid)
> +{
> +       return constraint_name[cid];
> +}
> +
> +static int set_pd_power_limit(struct powercap_zone *pcz, int cid,
> +                              u64 power_limit)
> +{
> +       struct powercap_em *pcem = to_powercap_em(pcz);
> +       struct em_perf_domain *pd;
> +       unsigned long frequency;
> +       int i, nr_cpus;
> +
> +       spin_lock(&pcem->lock);
> +
> +       power_limit = clamp_val(power_limit, pcem->power_min, pcem->power_max);
> +
> +       pd = em_cpu_get(pcem->cpu);
> +
> +       nr_cpus = cpumask_weight(to_cpumask(pd->cpus));
> +
> +       for (i = 0, frequency = pd->table[0].frequency; i < pd->nr_cap_states; i++) {
> +
> +               u64 power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
> +
> +               if ((power * nr_cpus) > power_limit)
> +                       break;
> +
> +               frequency = pd->table[i].frequency;
> +       }
> +
> +       freq_qos_update_request(&pcem->qos_req, frequency);
> +
> +       pcem->power_limit = power_limit;
> +
> +       spin_unlock(&pcem->lock);
> +
> +       return 0;
> +}
> +
> +static int get_pd_power_limit(struct powercap_zone *pcz, int cid, u64 *data)
> +{
> +       struct powercap_em *pcem = to_powercap_em(pcz);
> +
> +       spin_lock(&pcem->lock);
> +       *data = pcem->power_limit ? pcem->power_limit : pcem->power_max;
> +       spin_unlock(&pcem->lock);
> +
> +       return 0;
> +}
> +
> +static int set_time_window(struct powercap_zone *pcz, int cid, u64 window)
> +{
> +       return -ENOSYS;
> +}
> +
> +
> +static int get_time_window(struct powercap_zone *pcz, int cid, u64 *data)
> +{
> +       *data = 0;
> +
> +       return 0;
> +}
> +
> +static int get_max_power_uw(struct powercap_zone *pcz, int id, u64 *data)
> +{
> +       return get_max_power_range_uw(pcz, data);
> +}
> +
> +static const struct powercap_zone_constraint_ops constraint_ops = {
> +       .set_power_limit_uw = set_children_power_limit,
> +       .get_power_limit_uw = get_children_power_limit,
> +       .set_time_window_us = set_time_window,
> +       .get_time_window_us = get_time_window,
> +       .get_max_power_uw = get_max_power_uw,
> +       .get_name = get_constraint_name,
> +};
> +
> +static const struct powercap_zone_constraint_ops pd_constraint_ops = {
> +       .set_power_limit_uw = set_pd_power_limit,
> +       .get_power_limit_uw = get_pd_power_limit,
> +       .set_time_window_us = set_time_window,
> +       .get_time_window_us = get_time_window,
> +       .get_max_power_uw = get_max_power_uw,
> +       .get_name = get_constraint_name,
> +};
> +
> +static const struct powercap_zone_ops zone_ops = {
> +       .get_max_power_range_uw = get_max_power_range_uw,
> +       .get_power_uw = get_children_power_uw,
> +       .set_enable = set_domain_enable,
> +       .get_enable = get_domain_enable,
> +       .release = release_zone,
> +};
> +
> +static const struct powercap_zone_ops pd_zone_ops = {
> +       .get_max_power_range_uw = get_max_power_range_uw,
> +       .get_power_uw = get_pd_power_uw,
> +       .set_enable = set_domain_enable,
> +       .get_enable = get_domain_enable,
> +       .release = release_zone,
> +};
> +
> +static int cpuhp_powercap_em_online(unsigned int cpu)
> +{
> +        struct powercap_em *pcem;

Bad spacing

> +       struct cpufreq_policy *policy;
> +       struct em_perf_domain *pd;
> +       char name[CPUFREQ_NAME_LEN];
> +       int ret;
> +
> +       policy = cpufreq_cpu_get(cpu);
> +
> +       if (!policy || cpumask_first(policy->related_cpus) != cpu)
> +               return 0;
> +
> +       pd = em_cpu_get(cpu);
> +       if (!pd)
> +               return -EINVAL;
> +
> +       sprintf(name, "policy%d", cpu);
> +
> +       pcem = powercap_em_register(pct, name, pc_package,
> +                                   &pd_zone_ops, 1, &pd_constraint_ops);
> +       if (!pcem)
> +               return -EINVAL;
> +
> +       ret = powercap_em_set_power_range(pcem, pd);
> +       if (ret)
> +               return ret;
> +
> +       pcem->cpu = cpu;
> +
> +       ret = freq_qos_add_request(&policy->constraints,
> +                                  &pcem->qos_req, FREQ_QOS_MAX,
> +                                  pd->table[pd->nr_cap_states - 1].frequency);
> +
> +       powercap_em_rebalance_weight(pc_soc);
> +
> +       return ret;
> +}
> +
> +static int __init powercap_em_init(void)
> +{
> +       pct = powercap_register_control_type(NULL, "energy_model", NULL);
> +       if (!pct) {
> +               pr_err("Failed to register control type\n");
> +               return -EINVAL;

Return PTR_ERR(pct) here since powercap_register_control_type returns
at least three types of errors.

> +       }
> +
> +       pc_soc = powercap_em_register(pct, "soc", NULL,

Please consider moving powercap_em_register() just above this function.

> +                                     &zone_ops, 1, &constraint_ops);
> +       if (!pc_soc)
> +               return -EINVAL;
> +
> +       pc_package = powercap_em_register(pct, "package", pc_soc,
> +                                         &zone_ops, 1, &constraint_ops);

Will the soc and package hierarchy eventually be dynamically read from
devicetree or similar and these hardcoded registration removed?

For the rest of the devices, IMO, it makes sense to use the genpd
hierarchy to reflect the powercap hierarchy. I whipped up the
following patch to show how it might be achieved. What needs to be
done is to now reflect the parent-child/sibling relationships of genpd
into powercap. Initially I thought we'd need to additional DT
properties in the genpd bindings but I think we might be able to read
the device-specific energy model data directly to populate the
powercap constraints.

Thundercomm_Dragonboard_845c /
 $ ll /sys/class/powercap/
total 0
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model ->
../../devices/virtual/powercap/energy_model
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:0
-> ../../devices/virtual/powercap/energy_model/energy_model:0
lrwxrwxrwx    1 root     root           0 Jan  1 00:00
energy_model:0:0 ->
../../devices/virtual/powercap/energy_model/energy_model:0/energy_model:0:0
lrwxrwxrwx    1 root     root           0 Jan  1 00:00
energy_model:0:0:0 ->
../../devices/virtual/powercap/energy_model/energy_model:0/energy_model:0:0/energy_model:0:0:0
lrwxrwxrwx    1 root     root           0 Jan  1 00:00
energy_model:0:0:1 ->
../../devices/virtual/powercap/energy_model/energy_model:0/energy_model:0:0/energy_model:0:0:1
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:1
-> ../../devices/virtual/powercap/energy_model/energy_model:1
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:10
-> ../../devices/virtual/powercap/energy_model/energy_model:10
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:11
-> ../../devices/virtual/powercap/energy_model/energy_model:11
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:12
-> ../../devices/virtual/powercap/energy_model/energy_model:12
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:13
-> ../../devices/virtual/powercap/energy_model/energy_model:13
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:14
-> ../../devices/virtual/powercap/energy_model/energy_model:14
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:15
-> ../../devices/virtual/powercap/energy_model/energy_model:15
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:16
-> ../../devices/virtual/powercap/energy_model/energy_model:16
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:17
-> ../../devices/virtual/powercap/energy_model/energy_model:17
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:18
-> ../../devices/virtual/powercap/energy_model/energy_model:18
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:19
-> ../../devices/virtual/powercap/energy_model/energy_model:19
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:1a
-> ../../devices/virtual/powercap/energy_model/energy_model:1a
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:1b
-> ../../devices/virtual/powercap/energy_model/energy_model:1b
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:1c
-> ../../devices/virtual/powercap/energy_model/energy_model:1c
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:1d
-> ../../devices/virtual/powercap/energy_model/energy_model:1d
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:1e
-> ../../devices/virtual/powercap/energy_model/energy_model:1e
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:1f
-> ../../devices/virtual/powercap/energy_model/energy_model:1f
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:2
-> ../../devices/virtual/powercap/energy_model/energy_model:2
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:20
-> ../../devices/virtual/powercap/energy_model/energy_model:20
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:21
-> ../../devices/virtual/powercap/energy_model/energy_model:21
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:22
-> ../../devices/virtual/powercap/energy_model/energy_model:22
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:3
-> ../../devices/virtual/powercap/energy_model/energy_model:3
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:4
-> ../../devices/virtual/powercap/energy_model/energy_model:4
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:5
-> ../../devices/virtual/powercap/energy_model/energy_model:5
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:6
-> ../../devices/virtual/powercap/energy_model/energy_model:6
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:7
-> ../../devices/virtual/powercap/energy_model/energy_model:7
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:8
-> ../../devices/virtual/powercap/energy_model/energy_model:8
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:9
-> ../../devices/virtual/powercap/energy_model/energy_model:9
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:a
-> ../../devices/virtual/powercap/energy_model/energy_model:a
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:b
-> ../../devices/virtual/powercap/energy_model/energy_model:b
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:c
-> ../../devices/virtual/powercap/energy_model/energy_model:c
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:d
-> ../../devices/virtual/powercap/energy_model/energy_model:d
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:e
-> ../../devices/virtual/powercap/energy_model/energy_model:e
lrwxrwxrwx    1 root     root           0 Jan  1 00:00 energy_model:f
-> ../../devices/virtual/powercap/energy_model/energy_model:f


Let me know what you think.

Regards,
Amit


> +       if (!pc_package)
> +               return -EINVAL;
> +
> +       return cpuhp_setup_state(CPUHP_AP_POWERCAP_EM_ONLINE,
> +                                "powercap_em:online",
> +                                cpuhp_powercap_em_online, NULL);
> +}
> +late_initcall(powercap_em_init);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 191772d4a4d7..09fe4e1b430e 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -189,6 +189,7 @@ enum cpuhp_state {
>         CPUHP_AP_ONLINE_DYN_END         = CPUHP_AP_ONLINE_DYN + 30,
>         CPUHP_AP_X86_HPET_ONLINE,
>         CPUHP_AP_X86_KVM_CLK_ONLINE,
> +       CPUHP_AP_POWERCAP_EM_ONLINE,
>         CPUHP_AP_ACTIVE,
>         CPUHP_ONLINE,
>  };
> --
> 2.17.1
>

--000000000000854c0505aef2772c
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-powercap_em-automatic-registration-of-powercap-em-zo.patch"
Content-Disposition: attachment; 
	filename="0001-powercap_em-automatic-registration-of-powercap-em-zo.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kewmka360>
X-Attachment-Id: f_kewmka360

RnJvbSBlZjUxM2FmNGFmM2NhNmFkNjY0MTU1ZTZmNDkwOGNmNzIwZDZhZmI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8ZWY1MTNhZjRhZjNjYTZhZDY2NDE1NWU2ZjQ5MDhj
ZjcyMGQ2YWZiNi4xNTk5NzMwOTA0LmdpdC5hbWl0a0BrZXJuZWwub3JnPgpGcm9tOiBBbWl0IEt1
Y2hlcmlhIDxhbWl0a0BrZXJuZWwub3JnPgpEYXRlOiBUaHUsIDEwIFNlcCAyMDIwIDE1OjAyOjIx
ICswNTMwClN1YmplY3Q6IFtQQVRDSF0gcG93ZXJjYXBfZW06IGF1dG9tYXRpYyByZWdpc3RyYXRp
b24gb2YgcG93ZXJjYXAgZW0gem9uZXMKIGJhc2VkIG9uIGdlbnBkCgpnZW5wZCBhbHJlYWR5IGNh
cHR1cmVzIHRoZSBwaHlzaWNhbCBhbmQgdmlydHVhbCBoaWVyYXJjaHkgb2YgaG93IGJsb2Nrcwpp
biBhbiBTb0MgYXJlIHBvd2VyZWQgYW5kIHRoZWlyIHZhcmlvdXMgZGVwZW5kZW5jaWVzLiBVc2Ug
dGhhdCB0bwpjcmVhdGUgYW4gZXF1aXZhbGVudCBwb3dlcmNhcCBoaWVyYXJjaHkuCgpGSVhNRTog
VGhpcyBpcyBwcm9vZi1vZi1jb25jZXB0IHRoYXQgZG9lc24ndCB0YWtlIGluIHRvIGFjY291bnQg
Y2hpbGQKYW5kIHNpYmxpbmcgcmVsYXRpb25zaGlwcyBpbiBnZW5wZC4gQ3VycmVudGx5LCBhbGwg
cG93ZXJjYXAgem9uZXMgYXJlCmNyZWF0ZWQgYXQgdGhlIHJvb3QgbGV2ZWwuIFRoaXMgbmVlZHMg
dG8gYmUgZml4ZWQuCgpGSVhNRSAjMjogVGhlIGVuZXJneSBjb3N0aW5nIGZvciBkZXZpY2VzIGNv
dWxkIGJlIGxvb2tlZCB1cCBmcm9tIHRoZQplbmVyZ3kgbW9kZWwgZHVyaW5nIGluaXQgdG8gZmls
bCB1cCB0aGUgY29uc3RyYWludCB0YWJsZS4KCkZJWE1FICMzOiBSZXZpc2l0IGlmIHRoZXJlIGlz
IGEgbmVlZCBmb3IgYSBzZXBhcmF0ZSBwcm9wZXJ0eSBpbnNpZGUKZ2VucGQgRFQgYmluZGluZ3Mg
dG8gcG93ZXJjYXAuCgpTaWduZWQtb2ZmLWJ5OiBBbWl0IEt1Y2hlcmlhIDxhbWl0a0BrZXJuZWwu
b3JnPgotLS0KIGRyaXZlcnMvYmFzZS9wb3dlci9kb21haW4uYyAgICB8ICA0ICsrLS0KIGRyaXZl
cnMvcG93ZXJjYXAvcG93ZXJjYXBfZW0uYyB8IDE5ICsrKysrKysrKysrKysrKysrKysKIGluY2x1
ZGUvbGludXgvcG93ZXJjYXAuaCAgICAgICB8ICAzICsrKwogMyBmaWxlcyBjaGFuZ2VkLCAyNCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9w
b3dlci9kb21haW4uYyBiL2RyaXZlcnMvYmFzZS9wb3dlci9kb21haW4uYwppbmRleCAyY2I1ZTA0
Y2Y4NmNkLi5mODFhN2M0MDYwYjY1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2Jhc2UvcG93ZXIvZG9t
YWluLmMKKysrIGIvZHJpdmVycy9iYXNlL3Bvd2VyL2RvbWFpbi5jCkBAIC0zOCw4ICszOCw4IEBA
CiAJX19yZXQ7CQkJCQkJCVwKIH0pCiAKLXN0YXRpYyBMSVNUX0hFQUQoZ3BkX2xpc3QpOwotc3Rh
dGljIERFRklORV9NVVRFWChncGRfbGlzdF9sb2NrKTsKK0xJU1RfSEVBRChncGRfbGlzdCk7CitE
RUZJTkVfTVVURVgoZ3BkX2xpc3RfbG9jayk7CiAKIHN0cnVjdCBnZW5wZF9sb2NrX29wcyB7CiAJ
dm9pZCAoKmxvY2spKHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQpOwpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wb3dlcmNhcC9wb3dlcmNhcF9lbS5jIGIvZHJpdmVycy9wb3dlcmNhcC9wb3dl
cmNhcF9lbS5jCmluZGV4IDcyNWQ2MDQzMzBjNzAuLmM2MTZmN2YzYmNlMDggMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvcG93ZXJjYXAvcG93ZXJjYXBfZW0uYworKysgYi9kcml2ZXJzL3Bvd2VyY2FwL3Bv
d2VyY2FwX2VtLmMKQEAgLTE4LDYgKzE4LDcgQEAKICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CiAj
aW5jbHVkZSA8bGludXgva2VybmVsLmg+CiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5j
bHVkZSA8bGludXgvcG1fZG9tYWluLmg+CiAjaW5jbHVkZSA8bGludXgvcG1fcW9zLmg+CiAjaW5j
bHVkZSA8bGludXgvcG93ZXJjYXAuaD4KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CkBAIC00NjQs
NiArNDY1LDkgQEAgc3RhdGljIGludCBjcHVocF9wb3dlcmNhcF9lbV9vbmxpbmUodW5zaWduZWQg
aW50IGNwdSkKIAogc3RhdGljIGludCBfX2luaXQgcG93ZXJjYXBfZW1faW5pdCh2b2lkKQogewor
CXN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQ7CisJc3RydWN0IHBvd2VyY2FwX2VtICpw
Y19kZXY7CisKIAlwY3QgPSBwb3dlcmNhcF9yZWdpc3Rlcl9jb250cm9sX3R5cGUoTlVMTCwgImVu
ZXJneV9tb2RlbCIsIE5VTEwpOwogCWlmICghcGN0KSB7CiAJCXByX2VycigiRmFpbGVkIHRvIHJl
Z2lzdGVyIGNvbnRyb2wgdHlwZVxuIik7CkBAIC00ODAsNiArNDg0LDIxIEBAIHN0YXRpYyBpbnQg
X19pbml0IHBvd2VyY2FwX2VtX2luaXQodm9pZCkKIAlpZiAoIXBjX3BhY2thZ2UpCiAJCXJldHVy
biAtRUlOVkFMOwogCisJbXV0ZXhfbG9jaygmZ3BkX2xpc3RfbG9jayk7CisKKwlsaXN0X2Zvcl9l
YWNoX2VudHJ5KGdlbnBkLCAmZ3BkX2xpc3QsIGdwZF9saXN0X25vZGUpIHsKKwkJZGV2X2Vycigm
Z2VucGQtPmRldiwgInJlZ2lzdGVyaW5nIHBvd2VyY2FwIGVtIHpvbmUiKTsKKwkJcGNfZGV2ID0g
cG93ZXJjYXBfZW1fcmVnaXN0ZXIocGN0LCBkZXZfbmFtZSgmZ2VucGQtPmRldiksIE5VTEwsCisJ
CQkJCSAgICAgICZ6b25lX29wcywgMSwgJmNvbnN0cmFpbnRfb3BzKTsKKworCQlpZiAoIXBjX2Rl
dikgeworCQkJZGV2X2VycigmZ2VucGQtPmRldiwgImVycm9yIHJlZ2lzdGVyaW5nIHBvd2VyY2Fw
IGVtIHpvbmUiKTsKKwkJfQorCX0KKworCW11dGV4X3VubG9jaygmZ3BkX2xpc3RfbG9jayk7CisK
KwogCXJldHVybiBjcHVocF9zZXR1cF9zdGF0ZShDUFVIUF9BUF9QT1dFUkNBUF9FTV9PTkxJTkUs
CiAJCQkJICJwb3dlcmNhcF9lbTpvbmxpbmUiLAogCQkJCSBjcHVocF9wb3dlcmNhcF9lbV9vbmxp
bmUsIE5VTEwpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wb3dlcmNhcC5oIGIvaW5jbHVk
ZS9saW51eC9wb3dlcmNhcC5oCmluZGV4IGJhYmYxMDI2MTc0NGYuLjk0M2RkYzEwOGQ2NjMgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvcG93ZXJjYXAuaAorKysgYi9pbmNsdWRlL2xpbnV4L3Bv
d2VyY2FwLmgKQEAgLTIwLDYgKzIwLDkgQEAgc3RydWN0IHBvd2VyY2FwX2NvbnRyb2xfdHlwZTsK
IHN0cnVjdCBwb3dlcmNhcF96b25lOwogc3RydWN0IHBvd2VyY2FwX3pvbmVfY29uc3RyYWludDsK
IAorZXh0ZXJuIHN0cnVjdCBsaXN0X2hlYWQgZ3BkX2xpc3Q7CitleHRlcm4gc3RydWN0IG11dGV4
IGdwZF9saXN0X2xvY2s7CisKIC8qKgogICogc3RydWN0IHBvd2VyY2FwX2NvbnRyb2xfdHlwZV9v
cHMgLSBEZWZpbmUgY29udHJvbCB0eXBlIGNhbGxiYWNrcwogICogQHNldF9lbmFibGU6CQlFbmFi
bGUvRGlzYWJsZSB3aG9sZSBjb250cm9sIHR5cGUuCi0tIAoyLjI1LjEKCg==
--000000000000854c0505aef2772c--
