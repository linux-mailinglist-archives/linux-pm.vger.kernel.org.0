Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC9443501
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 19:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhKBSEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 14:04:30 -0400
Received: from foss.arm.com ([217.140.110.172]:41138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhKBSEa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Nov 2021 14:04:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE1B511B3;
        Tue,  2 Nov 2021 11:01:54 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.28.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7EEDF3F7B4;
        Tue,  2 Nov 2021 11:01:53 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rafael@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/2] Documentation: power: Add description about new callback for EM registration
Date:   Tue,  2 Nov 2021 18:01:43 +0000
Message-Id: <20211102180144.1647-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Model (EM) registration for CPUs should now be done using
a dedicated callback added recently into CPUFreq framework and drivers.

Commit c17495b01b72 ("cpufreq: Add callback to register with energy model")

The callback guaranties that the EM registration is called at the right
time during driver setup. To avoid mistakes update the documentation
to align with the existing code implementation.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst | 31 ++++++++++++++--------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index 8a2788afe89b..7af0e1760962 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -138,6 +138,10 @@ or in Section 2.4
 3. Example driver
 -----------------
 
+The CPUFreq framework supports dedicated callback for registering
+the EM for a given CPU(s) 'policy' object: cpufreq_driver::register_em().
+That callback has to be implemented properly for a given driver,
+because the framework would call it at the right time during setup.
 This section provides a simple example of a CPUFreq driver registering a
 performance domain in the Energy Model framework using the (fake) 'foo'
 protocol. The driver implements an est_power() function to be provided to the
@@ -167,25 +171,22 @@ EM framework::
   20		return 0;
   21	}
   22
-  23	static int foo_cpufreq_init(struct cpufreq_policy *policy)
+  23	static void foo_cpufreq_register_em(struct cpufreq_policy *policy)
   24	{
   25		struct em_data_callback em_cb = EM_DATA_CB(est_power);
   26		struct device *cpu_dev;
-  27		int nr_opp, ret;
+  27		int nr_opp;
   28
   29		cpu_dev = get_cpu_device(cpumask_first(policy->cpus));
   30
-  31     	/* Do the actual CPUFreq init work ... */
-  32     	ret = do_foo_cpufreq_init(policy);
-  33     	if (ret)
-  34     		return ret;
-  35
-  36     	/* Find the number of OPPs for this policy */
-  37     	nr_opp = foo_get_nr_opp(policy);
+  31     	/* Find the number of OPPs for this policy */
+  32     	nr_opp = foo_get_nr_opp(policy);
+  33
+  34     	/* And register the new performance domain */
+  35     	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus,
+  36					    true);
+  37	}
   38
-  39     	/* And register the new performance domain */
-  40     	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus,
-  41					    true);
-  42
-  43	        return 0;
-  44	}
+  39	static struct cpufreq_driver foo_cpufreq_driver = {
+  40		.register_em = foo_cpufreq_register_em,
+  41	};
-- 
2.17.1

