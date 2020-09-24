Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC14276DEC
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 11:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgIXJxI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 05:53:08 -0400
Received: from foss.arm.com ([217.140.110.172]:40446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgIXJxI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 05:53:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DED27113E;
        Thu, 24 Sep 2020 02:53:07 -0700 (PDT)
Received: from ubuntu.arm.com (unknown [10.57.15.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E876C3F73B;
        Thu, 24 Sep 2020 02:53:05 -0700 (PDT)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, daniel.lezcano@linaro.org
Cc:     morten.rasmussen@arm.com, chris.redpath@arm.com,
        nicola.mazzucato@arm.com
Subject: [PATCH v2 2/2] [RFC] CPUFreq: Add support for cpu-perf-dependencies
Date:   Thu, 24 Sep 2020 10:53:47 +0100
Message-Id: <20200924095347.32148-3-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200924095347.32148-1-nicola.mazzucato@arm.com>
References: <20200924095347.32148-1-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I am seeking some feedback/comments on the following approach.

Intro:
Info of performance depency for cpus will be beneficial for systems
where f/w description of the CPU performance control domain is different
from the clock domain, e.g. per-CPU control with multiple CPUs sharing
clock, and kernel OSPM s/w components need to take CPU performance
dependency into account.
Essentially these s/w components will have to be provided with
this information from dt and this RFC is presenting a possible way
to do so.

Little details about implementation are given, as this RFC aims to
present the overall approach.

Proposal:
The cpufreq framework currently assumes that a policy covers a group of
CPUs that are controlled together. The energy model and thermal
frameworks assume that the policy cpumask describes performance
dependency relation. This assumption is no longer generally valid, so we
need a way to represent both control and performance relation in cpufreq.

The proposal is to have one cpufreq_policy instance per control domain,
and have a new cpumask 'dependent_cpus' to the policy to represent the
CPU performance dependencies.

The main reason for a new cpumaks is that although 'related_cpus'
could be (or could have been) used for such purpose, its meaning has
changed over time. Initially it was designed specifically for this
purpose[1], but eventually it has changed to online + offline cpus when
sw coordination in use [2,3].

There is also a 'shared_type' field in cpufreq_policy which provides
info about coordination type (NONE, SW_ANY, SW_ALL, HW). Currently it's in
use only for ACPI but I assume it can be used to indicate the coordination
type even out of ACPI itself. Currently there is no use of TYPE_HW.

Provided that the cpufreq driver will populate dependent_cpus and
set shared_type, the s/w components that rely on such description (we
focus on energy-model and cpufreq_cooling for now) will always be provided
with the correct information, when picking the new cpumask.

Proposed changes (at high level)(4):

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

3) drivers/firmware/arm_scmi/perf.c: Parse dt for `cpu-performance-dependencies`

   * Parse dt for `cpu-performance-dependencies` optional node

   * Store internally performance dependencies

   * Add api to get depedent_cpus if required

4) drivers/cpufreq/scmi-cpufreq: Register EM device with the proper cpumask

   * Check for performance dependencies and get dependent_cpus

   * Set policy->shared_type accordingly

   * Provide to EM the correct performance dependencies information
   <snippet>
static int scmi_cpufreq_init(struct cpufreq_policy *policy)
        policy->fast_switch_possible =
                handle->perf_ops->fast_switch_possible(handle, cpu_dev);

-       em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus);
+       /*
+        * EM needs accurate information about clk boundaries, thus provide the
+        * correct cpumask.
+        */
+       if (handle->perf_ops->has_perf_deps(handle))
+               em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb,
+                                       policy->dependent_cpus);
+       else
+               em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb,
+                                           policy->cpus);
   </snippet>

Any other suggestions are welcome.

Thanks
Nicola

[1] 'commit e8628dd06d66 ("[CPUFREQ] expose cpufreq coordination requirements regardless of coordination mechanism")'
[2] 'commit 951fc5f45836 ("cpufreq: Update Documentation for cpus and related_cpus")'
[3] 'commit f4fd3797848a ("acpi-cpufreq: Add new sysfs attribute freqdomain_cpus")'
-- 
2.27.0

