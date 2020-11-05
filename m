Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14312A7F43
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 13:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgKEM4x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 07:56:53 -0500
Received: from foss.arm.com ([217.140.110.172]:60050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730826AbgKEM4w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 07:56:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67B5D142F;
        Thu,  5 Nov 2020 04:56:52 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 333D33F719;
        Thu,  5 Nov 2020 04:56:51 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH 7/8] cppc_cpufreq: expose information on frequency domains
Date:   Thu,  5 Nov 2020 12:55:23 +0000
Message-Id: <20201105125524.4409-8-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105125524.4409-1-ionela.voinescu@arm.com>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the existing sysfs attribute "freqdomain_cpus" to expose
information to userspace about CPUs in the same frequency domain.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |  3 ++-
 drivers/cpufreq/cppc_cpufreq.c                     | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 1a04ca8162ad..0eee30b27ab6 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -264,7 +264,8 @@ Description:	Discover CPUs in the same CPU frequency coordination domain
 		attribute is useful for user space DVFS controllers to get better
 		power/performance results for platforms using acpi-cpufreq.
 
-		This file is only present if the acpi-cpufreq driver is in use.
+		This file is only present if the acpi-cpufreq or the cppc-cpufreq
+		drivers are in use.
 
 
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 60ac7f8049b5..b4edeeb57d04 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -483,6 +483,19 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
+static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+
+	return cpufreq_show_cpus(cpu_data->domain->shared_cpu_map, buf);
+}
+cpufreq_freq_attr_ro(freqdomain_cpus);
+
+static struct freq_attr *cppc_cpufreq_attr[] = {
+	&freqdomain_cpus,
+	NULL,
+};
+
 static struct cpufreq_driver cppc_cpufreq_driver = {
 	.flags = CPUFREQ_CONST_LOOPS,
 	.verify = cppc_verify_policy,
@@ -491,6 +504,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.init = cppc_cpufreq_cpu_init,
 	.stop_cpu = cppc_cpufreq_stop_cpu,
 	.set_boost = cppc_cpufreq_set_boost,
+	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
 };
 
-- 
2.17.1

