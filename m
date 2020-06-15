Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C344D1F9DE6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 18:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgFOQ4C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 12:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730845AbgFOQ4B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 12:56:01 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18702C061A0E
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 09:56:00 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r15so13536881qvv.5
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 09:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tDQFi4ZHxh9vtnpbPSsjcR+LoGQ1LokocF+pM/GR4Bk=;
        b=rHn/fd4UkThPN/x61DWk55yRtFel5H5Eeo44K7j4+LGbZ+H4TTKl+8XZHEQKScEVka
         dS55nUIlFC7ljtypjcBJPXfxKuRzAV7AD6jFMDOMvpcRUGfJ/ZHvdz8iVrjpmEOb3zpK
         zDk5MsmjjBsKCtvft9rGPKCgR1JIkD+8LDXuSFZTJF03nyYwzBfX5Vzs7njSsNnJnEAR
         vhLNxqwloQ2HOWz26ggH01cmKhD/2PVuPU/gJh/4oxvDLUBgyELZyxNzAPKjGBQQZrPA
         CP8jipp0mjVm8B7Q6Q7yZ1i1jWPxfqmkzcNFdZ5qYM4zVUskmIhtxfIT7DbfOkR4DoPq
         M9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tDQFi4ZHxh9vtnpbPSsjcR+LoGQ1LokocF+pM/GR4Bk=;
        b=QqNuZClscxyUZOUq6k/eUeSDR7RwMovd8YiYHZwIHx/pE2OLwrAScwT0Am6WHvS4hg
         N/cMosdKWbDdgc/ZyEnOBjRpBK4FPxaFG+28OVnmJYJ3Vqcs953LDEaEL8Uh7kYn3txr
         QxhWSK84ZaCbdcaD7beWW7y80Vkc5OL6Chh70fup54A3x5WlT6YiG1xt812l3+vZxqN4
         kImvgEDS2JbYasEBif8fl4WH4Z6cABBXN8phVCr3opwrdpe0MBwYL62KddNqDgqSJT71
         lq7Yqy8LnQFn/WDQdFrBAtTNLGOTBALK8YA7vIl3P8MO17Sba4mAcBnoNXRN4A1VKTEB
         5z1A==
X-Gm-Message-State: AOAM533NWmSKIdqLe6FoayCvfQofU2xSAvYC1UaPdH4UGQkSFtwQupaz
        6gBPXGpBpvpI0CweYvsrPir6hwXhGtIw
X-Google-Smtp-Source: ABdhPJyTg60oc50voCne+24gpefHGFy8rfKNSLsmruE2K2/yt6kuEsq0FQcH5GRJCHhbfmONq1iOeZdHuTLD
X-Received: by 2002:ad4:4368:: with SMTP id u8mr25337625qvt.227.1592240159226;
 Mon, 15 Jun 2020 09:55:59 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:55:53 +0100
In-Reply-To: <20200615165554.228063-1-qperret@google.com>
Message-Id: <20200615165554.228063-2-qperret@google.com>
Mime-Version: 1.0
References: <20200615165554.228063-1-qperret@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 1/2] cpufreq: Register governors at core_initcall
From:   Quentin Perret <qperret@google.com>
To:     rjw@rjwysocki.net, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        qperret@google.com, tkjos@google.com, adharmap@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, most CPUFreq governors are registered at core_initcall time
when used as default, and module_init otherwise. In preparation for
letting users specify the default governor on the kernel command line,
change all of them to use core_initcall unconditionally, as is already
the case for schedutil and performance. This will enable us to assume
builtin governors have been registered before the builtin CPUFreq
drivers probe.

And since all governors now have similar init/exit patterns, introduce
two new macros cpufreq_governor_{init,exit}() to factorize the code.

Signed-off-by: Quentin Perret <qperret@google.com>
---
Note: I couldn't boot-test the change to spudemand, by lack of hardware.
But I can confirm cell_defconfig compiles just fine.
---
 .../platforms/cell/cpufreq_spudemand.c        | 26 ++-----------------
 drivers/cpufreq/cpufreq_conservative.c        | 22 ++++------------
 drivers/cpufreq/cpufreq_ondemand.c            | 24 +++++------------
 drivers/cpufreq/cpufreq_performance.c         | 14 ++--------
 drivers/cpufreq/cpufreq_powersave.c           | 18 +++----------
 drivers/cpufreq/cpufreq_userspace.c           | 18 +++----------
 include/linux/cpufreq.h                       | 14 ++++++++++
 kernel/sched/cpufreq_schedutil.c              |  6 +----
 8 files changed, 36 insertions(+), 106 deletions(-)

diff --git a/arch/powerpc/platforms/cell/cpufreq_spudemand.c b/arch/powerpc/platforms/cell/cpufreq_spudemand.c
index 55b31eadb3c8..ca7849e113d7 100644
--- a/arch/powerpc/platforms/cell/cpufreq_spudemand.c
+++ b/arch/powerpc/platforms/cell/cpufreq_spudemand.c
@@ -126,30 +126,8 @@ static struct cpufreq_governor spu_governor = {
 	.stop = spu_gov_stop,
 	.owner = THIS_MODULE,
 };
-
-/*
- * module init and destoy
- */
-
-static int __init spu_gov_init(void)
-{
-	int ret;
-
-	ret = cpufreq_register_governor(&spu_governor);
-	if (ret)
-		printk(KERN_ERR "registration of governor failed\n");
-	return ret;
-}
-
-static void __exit spu_gov_exit(void)
-{
-	cpufreq_unregister_governor(&spu_governor);
-}
-
-
-module_init(spu_gov_init);
-module_exit(spu_gov_exit);
+cpufreq_governor_init(spu_governor);
+cpufreq_governor_exit(spu_governor);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Christian Krafft <krafft@de.ibm.com>");
-
diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 737ff3b9c2c0..aa39ff31ec9f 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -322,17 +322,7 @@ static struct dbs_governor cs_governor = {
 	.start = cs_start,
 };
 
-#define CPU_FREQ_GOV_CONSERVATIVE	(&cs_governor.gov)
-
-static int __init cpufreq_gov_dbs_init(void)
-{
-	return cpufreq_register_governor(CPU_FREQ_GOV_CONSERVATIVE);
-}
-
-static void __exit cpufreq_gov_dbs_exit(void)
-{
-	cpufreq_unregister_governor(CPU_FREQ_GOV_CONSERVATIVE);
-}
+#define CPU_FREQ_GOV_CONSERVATIVE	(cs_governor.gov)
 
 MODULE_AUTHOR("Alexander Clouter <alex@digriz.org.uk>");
 MODULE_DESCRIPTION("'cpufreq_conservative' - A dynamic cpufreq governor for "
@@ -343,11 +333,9 @@ MODULE_LICENSE("GPL");
 #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
 struct cpufreq_governor *cpufreq_default_governor(void)
 {
-	return CPU_FREQ_GOV_CONSERVATIVE;
+	return &CPU_FREQ_GOV_CONSERVATIVE;
 }
-
-core_initcall(cpufreq_gov_dbs_init);
-#else
-module_init(cpufreq_gov_dbs_init);
 #endif
-module_exit(cpufreq_gov_dbs_exit);
+
+cpufreq_governor_init(CPU_FREQ_GOV_CONSERVATIVE);
+cpufreq_governor_exit(CPU_FREQ_GOV_CONSERVATIVE);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 82a4d37ddecb..ac361a8b1d3b 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -408,7 +408,7 @@ static struct dbs_governor od_dbs_gov = {
 	.start = od_start,
 };
 
-#define CPU_FREQ_GOV_ONDEMAND	(&od_dbs_gov.gov)
+#define CPU_FREQ_GOV_ONDEMAND	(od_dbs_gov.gov)
 
 static void od_set_powersave_bias(unsigned int powersave_bias)
 {
@@ -429,7 +429,7 @@ static void od_set_powersave_bias(unsigned int powersave_bias)
 			continue;
 
 		policy = cpufreq_cpu_get_raw(cpu);
-		if (!policy || policy->governor != CPU_FREQ_GOV_ONDEMAND)
+		if (!policy || policy->governor != &CPU_FREQ_GOV_ONDEMAND)
 			continue;
 
 		policy_dbs = policy->governor_data;
@@ -461,16 +461,6 @@ void od_unregister_powersave_bias_handler(void)
 }
 EXPORT_SYMBOL_GPL(od_unregister_powersave_bias_handler);
 
-static int __init cpufreq_gov_dbs_init(void)
-{
-	return cpufreq_register_governor(CPU_FREQ_GOV_ONDEMAND);
-}
-
-static void __exit cpufreq_gov_dbs_exit(void)
-{
-	cpufreq_unregister_governor(CPU_FREQ_GOV_ONDEMAND);
-}
-
 MODULE_AUTHOR("Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>");
 MODULE_AUTHOR("Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>");
 MODULE_DESCRIPTION("'cpufreq_ondemand' - A dynamic cpufreq governor for "
@@ -480,11 +470,9 @@ MODULE_LICENSE("GPL");
 #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
 struct cpufreq_governor *cpufreq_default_governor(void)
 {
-	return CPU_FREQ_GOV_ONDEMAND;
+	return &CPU_FREQ_GOV_ONDEMAND;
 }
-
-core_initcall(cpufreq_gov_dbs_init);
-#else
-module_init(cpufreq_gov_dbs_init);
 #endif
-module_exit(cpufreq_gov_dbs_exit);
+
+cpufreq_governor_init(CPU_FREQ_GOV_ONDEMAND);
+cpufreq_governor_exit(CPU_FREQ_GOV_ONDEMAND);
diff --git a/drivers/cpufreq/cpufreq_performance.c b/drivers/cpufreq/cpufreq_performance.c
index def9afe0f5b8..71c1d9aba772 100644
--- a/drivers/cpufreq/cpufreq_performance.c
+++ b/drivers/cpufreq/cpufreq_performance.c
@@ -23,16 +23,6 @@ static struct cpufreq_governor cpufreq_gov_performance = {
 	.limits		= cpufreq_gov_performance_limits,
 };
 
-static int __init cpufreq_gov_performance_init(void)
-{
-	return cpufreq_register_governor(&cpufreq_gov_performance);
-}
-
-static void __exit cpufreq_gov_performance_exit(void)
-{
-	cpufreq_unregister_governor(&cpufreq_gov_performance);
-}
-
 #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
 struct cpufreq_governor *cpufreq_default_governor(void)
 {
@@ -50,5 +40,5 @@ MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq policy governor 'performance'");
 MODULE_LICENSE("GPL");
 
-core_initcall(cpufreq_gov_performance_init);
-module_exit(cpufreq_gov_performance_exit);
+cpufreq_governor_init(cpufreq_gov_performance);
+cpufreq_governor_exit(cpufreq_gov_performance);
diff --git a/drivers/cpufreq/cpufreq_powersave.c b/drivers/cpufreq/cpufreq_powersave.c
index 1ae66019eb83..7749522355b5 100644
--- a/drivers/cpufreq/cpufreq_powersave.c
+++ b/drivers/cpufreq/cpufreq_powersave.c
@@ -23,16 +23,6 @@ static struct cpufreq_governor cpufreq_gov_powersave = {
 	.owner		= THIS_MODULE,
 };
 
-static int __init cpufreq_gov_powersave_init(void)
-{
-	return cpufreq_register_governor(&cpufreq_gov_powersave);
-}
-
-static void __exit cpufreq_gov_powersave_exit(void)
-{
-	cpufreq_unregister_governor(&cpufreq_gov_powersave);
-}
-
 MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq policy governor 'powersave'");
 MODULE_LICENSE("GPL");
@@ -42,9 +32,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 {
 	return &cpufreq_gov_powersave;
 }
-
-core_initcall(cpufreq_gov_powersave_init);
-#else
-module_init(cpufreq_gov_powersave_init);
 #endif
-module_exit(cpufreq_gov_powersave_exit);
+
+cpufreq_governor_init(cpufreq_gov_powersave);
+cpufreq_governor_exit(cpufreq_gov_powersave);
diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index b43e7cd502c5..50a4d7846580 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -126,16 +126,6 @@ static struct cpufreq_governor cpufreq_gov_userspace = {
 	.owner		= THIS_MODULE,
 };
 
-static int __init cpufreq_gov_userspace_init(void)
-{
-	return cpufreq_register_governor(&cpufreq_gov_userspace);
-}
-
-static void __exit cpufreq_gov_userspace_exit(void)
-{
-	cpufreq_unregister_governor(&cpufreq_gov_userspace);
-}
-
 MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>, "
 		"Russell King <rmk@arm.linux.org.uk>");
 MODULE_DESCRIPTION("CPUfreq policy governor 'userspace'");
@@ -146,9 +136,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 {
 	return &cpufreq_gov_userspace;
 }
-
-core_initcall(cpufreq_gov_userspace_init);
-#else
-module_init(cpufreq_gov_userspace_init);
 #endif
-module_exit(cpufreq_gov_userspace_exit);
+
+cpufreq_governor_init(cpufreq_gov_userspace);
+cpufreq_governor_exit(cpufreq_gov_userspace);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 3494f6763597..e62b022cb07e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -577,6 +577,20 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy);
 int cpufreq_register_governor(struct cpufreq_governor *governor);
 void cpufreq_unregister_governor(struct cpufreq_governor *governor);
 
+#define cpufreq_governor_init(__governor)			\
+static int __init __governor##_init(void)			\
+{								\
+	return cpufreq_register_governor(&__governor);	\
+}								\
+core_initcall(__governor##_init)
+
+#define cpufreq_governor_exit(__governor)			\
+static void __exit __governor##_exit(void)			\
+{								\
+	return cpufreq_unregister_governor(&__governor);	\
+}								\
+module_exit(__governor##_exit)
+
 struct cpufreq_governor *cpufreq_default_governor(void);
 struct cpufreq_governor *cpufreq_fallback_governor(void);
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7fbaee24c824..402a09af9f43 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -909,11 +909,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 }
 #endif
 
-static int __init sugov_register(void)
-{
-	return cpufreq_register_governor(&schedutil_gov);
-}
-core_initcall(sugov_register);
+cpufreq_governor_init(schedutil_gov);
 
 #ifdef CONFIG_ENERGY_MODEL
 extern bool sched_energy_update;
-- 
2.27.0.290.gba653c62da-goog

