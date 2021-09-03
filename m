Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742FB3FFC2C
	for <lists+linux-pm@lfdr.de>; Fri,  3 Sep 2021 10:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348388AbhICIkj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 04:40:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59624 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348384AbhICIki (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 04:40:38 -0400
X-UUID: 5ea3d511595442a6aa666ecce0ce417d-20210903
X-UUID: 5ea3d511595442a6aa666ecce0ce417d-20210903
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 746758546; Fri, 03 Sep 2021 16:39:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Sep 2021 16:39:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Sep 2021 16:39:30 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v15 2/3] cpufreq: Add of_perf_domain_get_sharing_cpumask
Date:   Fri, 3 Sep 2021 16:39:23 +0800
Message-ID: <1630658364-6192-3-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1630658364-6192-1-git-send-email-hector.yuan@mediatek.com>
References: <1630658364-6192-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Hector.Yuan" <hector.yuan@mediatek.com>

Add of_perf_domain_get_sharing_cpumask function to group cpu
to specific performance domain.

Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
---
 include/linux/cpufreq.h |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9fd7194..0246144 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -13,6 +13,8 @@
 #include <linux/completion.h>
 #include <linux/kobject.h>
 #include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pm_qos.h>
 #include <linux/spinlock.h>
 #include <linux/sysfs.h>
@@ -995,6 +997,43 @@ static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy
 
 	return count;
 }
+
+static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_name,
+						     const char *cell_name, struct cpumask *cpumask)
+{
+	struct device_node *cpu_np;
+	struct of_phandle_args args;
+	int target_idx;
+	int cpu, ret;
+
+	cpu_np = of_cpu_device_node_get(pcpu);
+	of_parse_phandle_with_args(cpu_np, list_name,
+				   cell_name, 0, &args);
+	of_node_put(cpu_np);
+	target_idx = args.args[0];
+
+	for_each_possible_cpu(cpu) {
+		if (cpu == pcpu)
+			continue;
+
+		cpu_np = of_cpu_device_node_get(cpu);
+		if (!cpu_np)
+			continue;
+
+		ret = of_parse_phandle_with_args(cpu_np, list_name,
+						 cell_name, 0,
+						 &args);
+
+		of_node_put(cpu_np);
+		if (ret < 0)
+			continue;
+
+		if (target_idx == args.args[0])
+			cpumask_set_cpu(cpu, cpumask);
+	}
+
+	return target_idx;
+}
 #else
 static inline int cpufreq_boost_trigger_state(int state)
 {
@@ -1014,6 +1053,12 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
 {
 	return false;
 }
+
+static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_name,
+						     const char *cell_name, struct cpumask *cpumask)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
@@ -1035,7 +1080,6 @@ void arch_set_freq_scale(const struct cpumask *cpus,
 {
 }
 #endif
-
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
1.7.9.5

