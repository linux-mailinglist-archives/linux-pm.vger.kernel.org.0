Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0A949718A
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jan 2022 13:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiAWMtw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jan 2022 07:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiAWMtv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jan 2022 07:49:51 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1486C06173B
        for <linux-pm@vger.kernel.org>; Sun, 23 Jan 2022 04:49:50 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id i1so3329209pla.0
        for <linux-pm@vger.kernel.org>; Sun, 23 Jan 2022 04:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZgfLmTvcNymeOaECAKvKLM5rkHMPHjnlAJ/ZmgbR67g=;
        b=agotq3Dm1aJCWZRoU/wqetBDEaStIHd6PE6U1cKn+g6Mt6H05YIIEjU5YY6KKu3AX6
         B7HX8al5bpepWqRuzQQQGDNxCHF5f24gUpnGQ1LJNG3pqg9pwGbV34iavzh9FJqWQGJq
         riv2cr4e3QyLkjeoI+FTgQkzTAy43YehS/60DjREsrlqtsvEuaeNB8elU0WmH4Dz+F6X
         TPjMDKXXU/Pw/EV/Ci8zhLu60yxGq4guvl9TYouYO1tTsZzVLzjk+dwdQcSlF1LzZCgf
         jS6SJYmxW7cUEG4I+z7BCrtjhqNYVM0ckB/8q1TmnZHoPdLRYZ4dbIamEbgdEebS/tI3
         4H9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgfLmTvcNymeOaECAKvKLM5rkHMPHjnlAJ/ZmgbR67g=;
        b=Un/bg4SPlp233NzzUbzDotWzWV2JxjQABnSopf+jsY8XmKFId0j3iqSw8PX8lfUK8E
         JnxvZBctMpgxPuoBbrhjUL/pbCkFfuB43KDBtWE2sFhAgsHsE1la7GgIntyihg3cVTQP
         xClXwj/6/JLX6/zq74nQxyuS/IvDLEOJSREmalUVzy2G5N7QqWTb1DphPj/FgV++S5un
         DzdjmY/1vbuO9zwiLdrM5f3JbYRKQVZel6A9tgaeA6Dq5+hlE3640Mrhr0HYsgckxTfl
         CO5bDOCnTBZngDEwAS1JEZiWrK1Kb+pnfKoXqHgXK9RBBn0JRh4Lr5d7uxX5601Iqbjj
         YCqg==
X-Gm-Message-State: AOAM531EHRG0zmRF5dKdasBxDOiAWfTqRSVNKAVbkEN65OA2Jl2s+Sl9
        8FX0nq5+7SrPLV3KFnoZw379D1VQJqptsA==
X-Google-Smtp-Source: ABdhPJzZm0ni/lsAD6vCs4gZkYbiGbMdQKoDpP9fYxwoR8I9kDmyo5qiL6kA9U+GTd/pUWxJEzYwsg==
X-Received: by 2002:a17:90a:3f8b:: with SMTP id m11mr8840456pjc.176.1642942190276;
        Sun, 23 Jan 2022 04:49:50 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-123.windriver.com. [147.11.105.123])
        by smtp.gmail.com with ESMTPSA id om6sm9765972pjb.24.2022.01.23.04.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 04:49:50 -0800 (PST)
From:   Kevin Hao <haokexin@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] cpufreq: governor: Use kobject release() method to free dbs_data
Date:   Sun, 23 Jan 2022 20:45:08 +0800
Message-Id: <20220123124508.463305-3-haokexin@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220123124508.463305-1-haokexin@gmail.com>
References: <20220123124508.463305-1-haokexin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The struct dbs_data embeds a struct gov_attr_set and
the struct gov_attr_set embeds a kobject. Since every kobject must have
a release() method and we can't use kfree() to free it directly,
so introduce cpufreq_dbs_data_release() to release the dbs_data via
the kobject::release() method. This fixes the calltrace like below:
  ODEBUG: free active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x34
  WARNING: CPU: 12 PID: 810 at lib/debugobjects.c:505 debug_print_object+0xb8/0x100
  Modules linked in:
  CPU: 12 PID: 810 Comm: sh Not tainted 5.16.0-next-20220120-yocto-standard+ #536
  Hardware name: Marvell OcteonTX CN96XX board (DT)
  pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : debug_print_object+0xb8/0x100
  lr : debug_print_object+0xb8/0x100
  sp : ffff80001dfcf9a0
  x29: ffff80001dfcf9a0 x28: 0000000000000001 x27: ffff0001464f0000
  x26: 0000000000000000 x25: ffff8000090e3f00 x24: ffff80000af60210
  x23: ffff8000094dfb78 x22: ffff8000090e3f00 x21: ffff0001080b7118
  x20: ffff80000aeb2430 x19: ffff800009e8f5e0 x18: 0000000000000000
  x17: 0000000000000002 x16: 00004d62e58be040 x15: 013590470523aff8
  x14: ffff8000090e1828 x13: 0000000001359047 x12: 00000000f5257d14
  x11: 0000000000040591 x10: 0000000066c1ffea x9 : ffff8000080d15e0
  x8 : ffff80000a1765a8 x7 : 0000000000000000 x6 : 0000000000000001
  x5 : ffff800009e8c000 x4 : ffff800009e8c760 x3 : 0000000000000000
  x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0001474ed040
  Call trace:
   debug_print_object+0xb8/0x100
   __debug_check_no_obj_freed+0x1d0/0x25c
   debug_check_no_obj_freed+0x24/0xa0
   kfree+0x11c/0x440
   cpufreq_dbs_governor_exit+0xa8/0xac
   cpufreq_exit_governor+0x44/0x90
   cpufreq_set_policy+0x29c/0x570
   store_scaling_governor+0x110/0x154
   store+0xb0/0xe0
   sysfs_kf_write+0x58/0x84
   kernfs_fop_write_iter+0x12c/0x1c0
   new_sync_write+0xf0/0x18c
   vfs_write+0x1cc/0x220
   ksys_write+0x74/0x100
   __arm64_sys_write+0x28/0x3c
   invoke_syscall.constprop.0+0x58/0xf0
   do_el0_svc+0x70/0x170
   el0_svc+0x54/0x190
   el0t_64_sync_handler+0xa4/0x130
   el0t_64_sync+0x1a0/0x1a4
  irq event stamp: 189006
  hardirqs last  enabled at (189005): [<ffff8000080849d0>] finish_task_switch.isra.0+0xe0/0x2c0
  hardirqs last disabled at (189006): [<ffff8000090667a4>] el1_dbg+0x24/0xa0
  softirqs last  enabled at (188966): [<ffff8000080106d0>] __do_softirq+0x4b0/0x6a0
  softirqs last disabled at (188957): [<ffff80000804a618>] __irq_exit_rcu+0x108/0x1a4

Fixes: c4435630361d ("cpufreq: governor: New sysfs show/store callbacks for governor tunables")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/cpufreq/cpufreq_governor.c | 20 +++++++++++++-------
 drivers/cpufreq/cpufreq_governor.h |  1 +
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 63f7c219062b..55c80319d268 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -388,6 +388,15 @@ static void free_policy_dbs_info(struct policy_dbs_info *policy_dbs,
 	gov->free(policy_dbs);
 }
 
+static void cpufreq_dbs_data_release(struct kobject *kobj)
+{
+	struct dbs_data *dbs_data = to_dbs_data(to_gov_attr_set(kobj));
+	struct dbs_governor *gov = dbs_data->gov;
+
+	gov->exit(dbs_data);
+	kfree(dbs_data);
+}
+
 int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
@@ -425,6 +434,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 		goto free_policy_dbs_info;
 	}
 
+	dbs_data->gov = gov;
 	gov_attr_set_init(&dbs_data->attr_set, &policy_dbs->list);
 
 	ret = gov->init(dbs_data);
@@ -447,6 +457,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	policy->governor_data = policy_dbs;
 
 	gov->kobj_type.sysfs_ops = &governor_sysfs_ops;
+	gov->kobj_type.release = cpufreq_dbs_data_release;
 	ret = kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->kobj_type,
 				   get_governor_parent_kobj(policy),
 				   "%s", gov->gov.name);
@@ -488,13 +499,8 @@ void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy)
 
 	policy->governor_data = NULL;
 
-	if (!count) {
-		if (!have_governor_per_policy())
-			gov->gdbs_data = NULL;
-
-		gov->exit(dbs_data);
-		kfree(dbs_data);
-	}
+	if (!count && !have_governor_per_policy())
+		gov->gdbs_data = NULL;
 
 	free_policy_dbs_info(policy_dbs, gov);
 
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index bab8e6140377..a6de26318abb 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -37,6 +37,7 @@ enum {OD_NORMAL_SAMPLE, OD_SUB_SAMPLE};
 /* Governor demand based switching data (per-policy or global). */
 struct dbs_data {
 	struct gov_attr_set attr_set;
+	struct dbs_governor *gov;
 	void *tuners;
 	unsigned int ignore_nice_load;
 	unsigned int sampling_rate;
-- 
2.31.1

