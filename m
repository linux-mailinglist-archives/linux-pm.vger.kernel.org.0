Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0750F1C98E3
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 20:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgEGSKZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 14:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728164AbgEGSKZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 14:10:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B8EC05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 11:10:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o134so7984954yba.18
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qiBNYuTTBahvA+prfWDH1NCGtPHc0+6kWQqaJheSr88=;
        b=ZAAAK0RCn7VnQh7zNRyMzcuefNSDFgTTf3/rCXZumrD/Gcltiy2N6K4zbxsWye8Xdb
         P8K5kvNyfByELwYSMW6BCQO93ulDr4bOkQZ51MXDaZwvYw3l6z+2b0XrJNFcnK3Yxkwe
         48I6b37i9u/azMO/P1Xft++v9nPPBc0s9UHUebr2ady8fKubuzuQv+RPUaTS5CuLGSUp
         sz8+AgVIZUg+LCU5Ht4EhdSgZX4bAMyrCKKkhLb3ZKVoHwUnuV75cr+4Mqxi/FWne+TY
         Jb6nuGDS7zi3Z4N40FF3IWs2u/bmjFpwp6/iWFB+D7XqSy63HymEPP6pIgFhSdNSZFPJ
         YhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qiBNYuTTBahvA+prfWDH1NCGtPHc0+6kWQqaJheSr88=;
        b=Retrtp8CFFSl7LJ540vOZOAIKaP8Qu0F4uoHyQIxjHd/eYvLLABMBDJtmoC44woABX
         zTkkpJzrRd+9DP4S+SAVCsaFA8JT7WNQd/cuSiEthKYqq/LJstZEMU0wPq8XlpE3N43D
         SZ5vUni4WfjNCFJvdrvdBGBiQ0zlvgL7E4jZmlloRDCiOZNpkYstfBI/l8O+k6AmHZJu
         nJOtyM1fXmpXl7zsob6dcU7ZPVgF3T0KIHADWXXSsEOwlTcd6ampuViVPpCV7a2GBnsi
         p7SdbnJbsxahdBHVHH7thfP2x+fDGB38Q5w0gq6I4XbpXE5BIz7XfHX5ZbuhhwRSNaS5
         7xjw==
X-Gm-Message-State: AGi0PuaQL3tn20DxjvF6x/+gPpiVH4QoHz4a+Hjdobbk4ouzeayigGos
        77xiZ9hJs0Vt5eHpp81kYemh3ktr+98R
X-Google-Smtp-Source: APiQypJ/t7O00c63w8CU/xSa4LGGxInSc6L4NyofnFjO6B4PNa2CJpc6zN2McrHb5oLO2nY20W1EIk9Oapa5
X-Received: by 2002:a5b:48c:: with SMTP id n12mr24758635ybp.133.1588875023827;
 Thu, 07 May 2020 11:10:23 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:02 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-5-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 04/14] sched: cpufreq: Move sched_cpufreq_governor_change()
From:   Quentin Perret <qperret@google.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CPUFreq calls into sched_cpufreq_governor_change() when switching
governors, which triggers a sched domain rebuild when entering or
exiting schedutil.

Move the function to sched/cpufreq.c to prepare the ground for the
modularization of schedutil.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/cpufreq.c           | 33 ++++++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c | 33 --------------------------------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 7c2fe50fd76d..82f2dda61a55 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -75,3 +75,36 @@ bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy)
 		(policy->dvfs_possible_from_any_cpu &&
 		 rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data)));
 }
+
+#ifdef CONFIG_ENERGY_MODEL
+extern bool sched_energy_update;
+extern struct mutex sched_energy_mutex;
+
+static void rebuild_sd_workfn(struct work_struct *work)
+{
+	mutex_lock(&sched_energy_mutex);
+	sched_energy_update = true;
+	rebuild_sched_domains();
+	sched_energy_update = false;
+	mutex_unlock(&sched_energy_mutex);
+}
+static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
+
+/*
+ * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
+ * on governor changes to make sure the scheduler knows about it.
+ */
+void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
+				  struct cpufreq_governor *old_gov)
+{
+	if ((old_gov && old_gov->want_eas) || policy->governor->want_eas) {
+		/*
+		 * When called from the cpufreq_register_driver() path, the
+		 * cpu_hotplug_lock is already held, so use a work item to
+		 * avoid nested locking in rebuild_sched_domains().
+		 */
+		schedule_work(&rebuild_sd_work);
+	}
+
+}
+#endif
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index c5e5045f7c81..33e67c48f668 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -905,36 +905,3 @@ static int __init sugov_register(void)
 	return cpufreq_register_governor(&schedutil_gov);
 }
 core_initcall(sugov_register);
-
-#ifdef CONFIG_ENERGY_MODEL
-extern bool sched_energy_update;
-extern struct mutex sched_energy_mutex;
-
-static void rebuild_sd_workfn(struct work_struct *work)
-{
-	mutex_lock(&sched_energy_mutex);
-	sched_energy_update = true;
-	rebuild_sched_domains();
-	sched_energy_update = false;
-	mutex_unlock(&sched_energy_mutex);
-}
-static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
-
-/*
- * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
- * on governor changes to make sure the scheduler knows about it.
- */
-void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
-				  struct cpufreq_governor *old_gov)
-{
-	if ((old_gov && old_gov->want_eas) || policy->governor->want_eas) {
-		/*
-		 * When called from the cpufreq_register_driver() path, the
-		 * cpu_hotplug_lock is already held, so use a work item to
-		 * avoid nested locking in rebuild_sched_domains().
-		 */
-		schedule_work(&rebuild_sd_work);
-	}
-
-}
-#endif
-- 
2.26.2.526.g744177e7f7-goog

