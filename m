Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959393E89AE
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 07:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhHKFVc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 01:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhHKFVb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 01:21:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D908FC061765
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 22:21:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g12-20020a17090a7d0cb0290178f80de3d8so2708002pjl.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 22:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+XJ7EP0hOZhzV9mAsci1OAWe7gXCZSWRDHJrS8jiH/Q=;
        b=J7V5OBHZIzvtODbBFS8R213FoHL1S/wrR7vNcmrIda2ffCKudbmAYbJRWN45sQoQky
         1ydBeX4PnO9mAZ8rExgp/9oYqUzmAekXb7pzxnNAVURQ5anovtARCz2QBFrOmYgxgNca
         fCpm37LK2Qo+38rMHY27mRBA9VxZn+cZR4KIGc6lxXdD/A2aSMiAgKcotaqqU+ET+/Cm
         HmsEzzFMhClealnsbaDpj/nQEyk5VN9HKTaYiuNFHsSEtBtbtmgnW7aIAPY6do3FMoIL
         Hq82IszkRdErwWZJGijJTotTJbkjjNkPGPT0uRUKlFBNZ0FjFBFG/OovSWqWDsh9gduX
         kktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+XJ7EP0hOZhzV9mAsci1OAWe7gXCZSWRDHJrS8jiH/Q=;
        b=tuPETqKysxC4+AAMDAxkDwlrtg7zp7Se9SupBTZ5Vv7Ob3n6UaqwExw0sKZJ9feftN
         RIWwfrhN1iK2AdBc+tgmOSGbgX1fHminH+Mu9SJ/xE1vbVwBePAEOnI2HGlGpUA86M8K
         0t8uP+XHYJskhiBWH41Cg+bifUiaQLGUjPXKmaHTOyIiUhpDalgzadniWgpmIYIWeY8X
         TzOV4rYARAh/2XqXmvwo3hPTyoIZKLelElsFubJJ6nDza1eUlvmvLxVialMJ6+bfb7UK
         UrMfW8f5ieftPIDYj1phwWO8nxPZ7vEXgLAOe6Le7Yfu6wMTChD/AX+q+wha0BNcGVOt
         DGSg==
X-Gm-Message-State: AOAM5336ybk8K1FcZ//4xg1p4N0qK0AN2gkM0CMFXsIwrKQQamg/xmDa
        iNdwfParW5n+6u9BHv8JtMPC7A==
X-Google-Smtp-Source: ABdhPJwwqRVqnFH0DCU+u1BbGyrXRZrwxUnWmd0ikZgZlfFytrgZhZgaPk+ea0KpLfB/89mPMHFCHQ==
X-Received: by 2002:a17:902:7144:b029:12b:24ce:a83c with SMTP id u4-20020a1709027144b029012b24cea83cmr10157315plm.54.1628659268440;
        Tue, 10 Aug 2021 22:21:08 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id e35sm5147978pjk.28.2021.08.10.22.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 22:21:08 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: vexpress: Set CPUFREQ_IS_COOLING_DEV flag
Date:   Wed, 11 Aug 2021 10:51:04 +0530
Message-Id: <0efe0c7b1c07591f07a905021f455b033441784f.1628659212.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reuse the cpufreq core's registration of cooling device by setting the
CPUFREQ_IS_COOLING_DEV flag. Set this only if bL switcher isn't enabled.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Sudeep, is this broken ? I wonder why we didn't do it earlier.

 drivers/cpufreq/vexpress-spc-cpufreq.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 28c4c3254337..618b263434ca 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -15,7 +15,6 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
-#include <linux/cpu_cooling.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -47,7 +46,6 @@ static bool bL_switching_enabled;
 #define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
 #define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
 
-static struct thermal_cooling_device *cdev[MAX_CLUSTERS];
 static struct clk *clk[MAX_CLUSTERS];
 static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
 static atomic_t cluster_usage[MAX_CLUSTERS + 1];
@@ -455,11 +453,6 @@ static int ve_spc_cpufreq_exit(struct cpufreq_policy *policy)
 	struct device *cpu_dev;
 	int cur_cluster = cpu_to_cluster(policy->cpu);
 
-	if (cur_cluster < MAX_CLUSTERS) {
-		cpufreq_cooling_unregister(cdev[cur_cluster]);
-		cdev[cur_cluster] = NULL;
-	}
-
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
 		pr_err("%s: failed to get cpu%d device\n", __func__,
@@ -471,17 +464,6 @@ static int ve_spc_cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void ve_spc_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	int cur_cluster = cpu_to_cluster(policy->cpu);
-
-	/* Do not register a cpu_cooling device if we are in IKS mode */
-	if (cur_cluster >= MAX_CLUSTERS)
-		return;
-
-	cdev[cur_cluster] = of_cpufreq_cooling_register(policy);
-}
-
 static struct cpufreq_driver ve_spc_cpufreq_driver = {
 	.name			= "vexpress-spc",
 	.flags			= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
@@ -492,7 +474,6 @@ static struct cpufreq_driver ve_spc_cpufreq_driver = {
 	.get			= ve_spc_cpufreq_get_rate,
 	.init			= ve_spc_cpufreq_init,
 	.exit			= ve_spc_cpufreq_exit,
-	.ready			= ve_spc_cpufreq_ready,
 	.attr			= cpufreq_generic_attr,
 };
 
@@ -552,6 +533,9 @@ static int ve_spc_cpufreq_probe(struct platform_device *pdev)
 	for (i = 0; i < MAX_CLUSTERS; i++)
 		mutex_init(&cluster_lock[i]);
 
+	if (!is_bL_switching_enabled())
+		ve_spc_cpufreq_driver.flags |= CPUFREQ_IS_COOLING_DEV;
+
 	ret = cpufreq_register_driver(&ve_spc_cpufreq_driver);
 	if (ret) {
 		pr_info("%s: Failed registering platform driver: %s, err: %d\n",
-- 
2.31.1.272.g89b43f80a514

