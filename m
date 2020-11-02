Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6172A2A4E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 13:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgKBMCH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 07:02:07 -0500
Received: from foss.arm.com ([217.140.110.172]:58602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728696AbgKBMCG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Nov 2020 07:02:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E33631B;
        Mon,  2 Nov 2020 04:02:05 -0800 (PST)
Received: from ubuntu.arm.com (unknown [10.57.53.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4F1303F66E;
        Mon,  2 Nov 2020 04:02:03 -0800 (PST)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org
Cc:     morten.rasmussen@arm.com, chris.redpath@arm.com,
        nicola.mazzucato@arm.com
Subject: [PATCH v3 3/3] [RFC] CPUFreq: Add support for cpu-perf-dependencies
Date:   Mon,  2 Nov 2020 12:01:15 +0000
Message-Id: <20201102120115.29993-4-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201102120115.29993-1-nicola.mazzucato@arm.com>
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

This is a continuation of the previous v2, where we focused mostly on the
dt binding.

I am seeking some feedback/comments on the following two approaches.

Intro:
We have seen that in a system where performance control and hardware
description do not match (i.e. per-cpu), we still need the information of
how the v/f lines are shared among the cpus. We call this information
"performance dependencies".
We got this info through the opp-shared (the previous 2 patches aim for
that).

Problem:
How do we share such info (retrieved from a cpufreq driver) to other
consumers that rely on it? I have two proposals.

First proposal:
Having a new cpumask 'dependent_cpus' to represent the
CPU performance dependencies seems a viable and scalable way.

The main reason for a new cpumaks is that although 'related_cpus'
could be (or could have been) used for such purpose, its meaning has
changed over time [1].

Provided that the cpufreq driver will populate dependent_cpus and set
shared_type accordingly, the s/w components that rely on such description
(we focus on energy-model and cpufreq_cooling for now) will always be
provided with the correct information, when picking the new cpumask.

Proposed changes (at high level)(3):

1) cpufreq: Add new dependent_cpus cpumaks in cpufreq_policy

   * New cpumask addition
   <snippet>
struct cpufreq_policy {
        cpumask_var_t           related_cpus; /* Online + Offline CPUs */
        cpumask_var_t           real_cpus; /* Related and present */

+       /*
+        * CPUs with hardware clk/perf dependencies
+        *
+        * For sw components that rely on h/w info of clk dependencies when hw
+        * coordinates. This cpumask should always reflect the hw dependencies.
+        */
+       cpumask_var_t           dependent_cpus;                 /* all clk-dependent cpus */
+
        unsigned int            shared_type; /* ACPI: ANY or ALL affected CPUs
   </snippet>

   * Fallback mechanism for dependent_cpus. With this, s/w components can
     always pick dependent_cpus regardless the coordination type.
   <snippet>
static int cpufreq_online(unsigned int cpu)

                /* related_cpus should at least include policy->cpus. */
                cpumask_copy(policy->related_cpus, policy->cpus);
+
+               /* dependent_cpus should differ only when hw coordination is in place */
+               if (policy->shared_type != CPUFREQ_SHARED_TYPE_HW)
+                       cpumask_copy(policy->dependent_cpus, policy->cpus);
        }
   </snippet>

   * Add sysfs attribute for dependent_cpus

2) drivers/thermal/cpufreq_cooling: Replace related_cpus with dependent_cpus

3) drivers/cpufreq/scmi-cpufreq: Get perf-dependencies from dev_pm_opp_of_get_sharing_cpus()

   * Call dev_pm_opp_of_get_sharing_cpus()

   * Populate policy->dependent_cpus if possible

   * Set policy->shared_type accordingly

   * Provide to EM the correct performance dependencies information
   <snippet>
-       em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus);
+       /*
+       * EM needs accurate information about perf boundaries, thus provide the
+       * correct cpumask.
+       */
+       if (policy->shared_type == CPUFREQ_SHARED_TYPE_HW)
+               em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb,
+                                           policy->dependent_cpus);
+       else
+               em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb,
+                                           policy->cpus);
   </snippet>

Second proposal:

Another option could be for each driver to store internally the performance
dependencies and let the driver directly provide the correct cpumask for
any consumer.
Whilst this works fine for energy model (see above), it is not the case
(currently) for cpufreq_cooling, thus we would need to add a new interface for
it. That way the driver can call directly the registration function.
This seems to be possible since the CPUFreq core can skip to register
cpufreq_cooling (flag CPUFREQ_IS_COOLING_DEV).

In comparison with the first proposal this one is less scalable since each
driver will have to call the registration functions, while in some cases
the CPUFreq core could do it.

Any comments/preferences?

Many Thanks
Nicola

[1] https://lkml.org/lkml/2020/9/24/399
-- 
2.27.0

