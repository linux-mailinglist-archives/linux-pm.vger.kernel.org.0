Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8E20AAF6
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 05:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgFZDv6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 23:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgFZDv5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 23:51:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14F7C08C5C1
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 20:51:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e9so4365221pgo.9
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 20:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bDEuNi6VcWGVZVG3Ao7I2ar+mftbkIzW0ZQYBhMw7zM=;
        b=wcvPUDCYNg0VoRCPuSICiKnZcq2vobgSOlnfY8Z3efK+1eAEzvDJSGHyQpRUWfyvxC
         XzwvY7fSDagVhRnGyduvbpsXjslT9EPFXb0dS2FSJeFHFgzkj6JRunX7PXgQQ7/jpS7T
         uc6ABXV22lRh8uMuIx8ib0HN0MnTXN7S9P+/Qh+cI1owcBtVhpbVp5UqvsvLHDbD3Vrj
         uw7IFMf5CdC7qXEj+vope0cFkOC3U8gEbqZpzzZojl4+Z48HSjSVn9ryZGuoS1Fs8oeO
         RBeuQgqdvhpjHYVi9V+WAXYEYlHm4IOXHnsXDX2ovJzacZ1Oc5IZQn2m+qKgeOkG/ZmA
         15vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bDEuNi6VcWGVZVG3Ao7I2ar+mftbkIzW0ZQYBhMw7zM=;
        b=g/XzGiaVsvFiW/l2ORmktlAcsPEPPhYHpi94cJoNwAwyP5wPXMCiaA6C8BdkFqypTm
         o/M50LxuMAdeWQp121fSgcIRbEXTvGMIDUElOYVvVU4VMxuaSOS6vHbRBE80zjFO0SNZ
         4/5PxovSPa2I1a3mh6CK3zob5GAPBn7NnsbbXtC1Y480eVsTu5PgsJd5luD82uulePVJ
         z5i2Zasx2seqIz8DeHIzEBpYZ6dHL7IzbVboXkO/1k3nUM0DID/I031SYtuYhIfrwtNg
         ocBpmBNpR69/BbUjQiOjl+d4okgdW8lOweupJU8cQgESCXITq+Msq5cJbWqzebQ/tZdh
         eJmw==
X-Gm-Message-State: AOAM533z8TF3AgxDe8Q89cY3HFJraXDwr2gmjoGID6ovYfzrRxm0QUP/
        WbCT0FdkNk9RlFewzzg8lxtoQDn2ue8=
X-Google-Smtp-Source: ABdhPJyBSNZeRfEB61G0+HghLvkgTEmfZ8d/AT4P7cecCx+9cvBEU4r+vShOWis1m8oKqQMSGSyQBA==
X-Received: by 2002:a63:495c:: with SMTP id y28mr1020538pgk.30.1593143516459;
        Thu, 25 Jun 2020 20:51:56 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id iq19sm9467176pjb.48.2020.06.25.20.51.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 20:51:55 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc:     linux-pm@vger.kernel.org, kernel-team@android.com,
        tkjos@google.com, adharmap@codeaurora.org,
        Quentin Perret <qperret@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] cpufreq: Register governors at core_initcall
Date:   Fri, 26 Jun 2020 09:21:43 +0530
Message-Id: <088d0d017f1fe57edef0f50b2cfaeb785b6908df.1593143118.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1593143118.git.viresh.kumar@linaro.org>
References: <cover.1593143118.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Quentin Perret <qperret@google.com>

Currently, most CPUFreq governors are registered at core_initcall time
when used as default, and module_init otherwise. In preparation for
letting users specify the default governor on the kernel command line,
change all of them to use core_initcall unconditionally, as is already
the case for schedutil and performance. This will enable us to assume
builtin governors have been registered before the builtin CPUFreq
drivers probe.

And since all governors now have similar init/exit patterns, introduce
two new macros cpufreq_governor_{init,exit}() to factorize the code.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
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
2.25.0.rc1.19.g042ed3e048af

