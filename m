Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6373FA650
	for <lists+linux-pm@lfdr.de>; Sat, 28 Aug 2021 17:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhH1PCQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Aug 2021 11:02:16 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:58326 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229911AbhH1PCO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Aug 2021 11:02:14 -0400
X-UUID: c09bd4759c3e4f208db091893519ae32-20210828
X-UUID: c09bd4759c3e4f208db091893519ae32-20210828
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 773976302; Sat, 28 Aug 2021 23:01:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 28 Aug 2021 23:01:17 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 28 Aug 2021 23:01:17 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v14 2/3] cpufreq: Add of_perf_domain_get_sharing_cpumask
Date:   Sat, 28 Aug 2021 23:01:11 +0800
Message-ID: <1630162872-25452-3-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1630162872-25452-1-git-send-email-hector.yuan@mediatek.com>
References: <1630162872-25452-1-git-send-email-hector.yuan@mediatek.com>
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
 include/linux/cpufreq.h |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9fd7194..4916d70 100644
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
@@ -1036,6 +1038,43 @@ void arch_set_freq_scale(const struct cpumask *cpus,
 }
 #endif
 
+#ifdef CONFIG_CPU_FREQ
+static inline int of_perf_domain_get_sharing_cpumask(int index, const char *list_name,
+						     const char *cell_name,
+						     struct cpumask *cpumask)
+{
+	struct device_node *cpu_np;
+	struct of_phandle_args args;
+	int cpu, ret;
+
+	for_each_possible_cpu(cpu) {
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
+		if (index == args.args[0])
+			cpumask_set_cpu(cpu, cpumask);
+	}
+
+	return 0;
+}
+#else
+static inline int of_perf_domain_get_sharing_cpumask(int index, const char *list_name,
+						     const char *cell_name,
+						     struct cpumask *cpumask)
+{
+	return 0;
+}
+#endif
+
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
1.7.9.5

