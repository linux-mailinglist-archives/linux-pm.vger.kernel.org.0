Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF080DCC6
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 09:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfD2HYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 03:24:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33479 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfD2HYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 03:24:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id h5so4899103pfo.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 00:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EIIJLhAFCZQq0dnycb/pG8Aeyu7w+W2KsYDQ22amdpc=;
        b=RkyNnkD6b5O/wXFiudD845tzjN4PkowhqN+hY3W1YKjiXUIXttI7WfkK+g7gLdHD8w
         MxQ2Ab5XtY7YGdv6aHENo665u5YFk4GMZ9Uwg65yHICn5ZuSN9rHfjM93vMdMhr5pEBU
         ofgSu/d/nC/31Oluny1llmtG4af0itqOJp5vRLhaYS9uDYdeHao0r+japQEyxzOy5Sv1
         Qho5epAdHYMprgTe6UXbM+yeWl6M7NPNSB8NWI11jOixlp0bxyMriayEVfz9nVH3jY1b
         fRpoCzurCKyG9ykJEm8tan3C+gAg4S1Qqzjd2kUlSBcfVsEfHv8sjksjIX2CH1X0AmXp
         6eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EIIJLhAFCZQq0dnycb/pG8Aeyu7w+W2KsYDQ22amdpc=;
        b=LJvd6MAWlpn2tdGWtmO/OAM7Wxgho8t8EfvxRhEfJS1AtZLz9CJZIPi8Y2FTHjy0uz
         UsiFb2dWWKnxrD1cpYxxdIm6Mh5lp9qxJzOBr8OZLPy9lZu/Hc2Z8fT5BItP2F9TPzgP
         uAfIwJQi02sm/Wc8fxnAU2AYSfSb4W6qhMEADIPtQHsN6vbAVMkHovR1ZozjJimR2u+8
         +p0d7s91HsCoJTLNHVR1gVmEsMD4xqEfeZCXUohw/wQDWNVmNkPKmkG/6BgfYvMPwtw2
         8B0iCxuKhqj0CIhlShlAsM8EljY8cBBqgoZPilh6s5AKGVYAimFNVQFCYuWBbVRpbDec
         9fYw==
X-Gm-Message-State: APjAAAVXtrEG+OJ6p+WJddYBtht57KF62sKqsh4bQHM8trYm20xKNGmE
        vGGuCbuIyiSsxuJm2JDnmM4=
X-Google-Smtp-Source: APXvYqxoYJRKfp+4nBIyxclNtCzV853l5P0bwr+jybYaXtUUkPSaiY6++WuZJh9U8rL24ahqCLwi5Q==
X-Received: by 2002:a65:4341:: with SMTP id k1mr56216224pgq.88.1556522675570;
        Mon, 29 Apr 2019 00:24:35 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id k186sm55954711pfc.137.2019.04.29.00.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 00:24:34 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     viresh.kumar@linaro.org, rjw@rjwysocki.net,
        rafael.j.wysocki@intel.com
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH v3] cpufreq: Don't find governor for setpolicy drivers in cpufreq_init_policy()
Date:   Mon, 29 Apr 2019 15:24:18 +0800
Message-Id: <20190429072418.7860-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

In cpufreq_init_policy() we will check if there's last_governor for target
and setpolicy type. However last_governor is set only if has_target() is
true in cpufreq_offline(). That means find last_governor for setpolicy
type is pointless. Also new_policy.governor will not be used if ->setpolicy
callback is set in cpufreq_set_policy().

Moreover, there's duplicate ->setpolicy check in using default policy path.
Let's add a new helper function to avoid it. Also update a little comment.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v2: fix ->setplicy typo.
v3:
  - let cpufreq_parse_governor() only handle !set_policy.
  - fix using {} in the if block.
  - change helper function name.
  - update comment, commit message.

 drivers/cpufreq/cpufreq.c | 116 ++++++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 51 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0322cce..ce8a01d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -578,50 +578,52 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
 	return NULL;
 }
 
+static int cpufreq_parse_policy(char *str_governor,
+				struct cpufreq_policy *policy)
+{
+	if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
+		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
+		return 0;
+	}
+	if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
+		policy->policy = CPUFREQ_POLICY_POWERSAVE;
+		return 0;
+	}
+	return -EINVAL;
+}
+
 /**
- * cpufreq_parse_governor - parse a governor string
+ * cpufreq_parse_governor - parse a governor string only for !setpolicy
  */
 static int cpufreq_parse_governor(char *str_governor,
 				  struct cpufreq_policy *policy)
 {
-	if (cpufreq_driver->setpolicy) {
-		if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
-			policy->policy = CPUFREQ_POLICY_PERFORMANCE;
-			return 0;
-		}
-
-		if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
-			policy->policy = CPUFREQ_POLICY_POWERSAVE;
-			return 0;
-		}
-	} else {
-		struct cpufreq_governor *t;
+	struct cpufreq_governor *t;
 
-		mutex_lock(&cpufreq_governor_mutex);
+	mutex_lock(&cpufreq_governor_mutex);
 
-		t = find_governor(str_governor);
-		if (!t) {
-			int ret;
+	t = find_governor(str_governor);
+	if (!t) {
+		int ret;
 
-			mutex_unlock(&cpufreq_governor_mutex);
+		mutex_unlock(&cpufreq_governor_mutex);
 
-			ret = request_module("cpufreq_%s", str_governor);
-			if (ret)
-				return -EINVAL;
+		ret = request_module("cpufreq_%s", str_governor);
+		if (ret)
+			return -EINVAL;
 
-			mutex_lock(&cpufreq_governor_mutex);
+		mutex_lock(&cpufreq_governor_mutex);
 
-			t = find_governor(str_governor);
-		}
-		if (t && !try_module_get(t->owner))
-			t = NULL;
+		t = find_governor(str_governor);
+	}
+	if (t && !try_module_get(t->owner))
+		t = NULL;
 
-		mutex_unlock(&cpufreq_governor_mutex);
+	mutex_unlock(&cpufreq_governor_mutex);
 
-		if (t) {
-			policy->governor = t;
-			return 0;
-		}
+	if (t) {
+		policy->governor = t;
+		return 0;
 	}
 
 	return -EINVAL;
@@ -746,8 +748,13 @@ static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
 	if (ret != 1)
 		return -EINVAL;
 
-	if (cpufreq_parse_governor(str_governor, &new_policy))
-		return -EINVAL;
+	if (cpufreq_driver->setpolicy) {
+		if (cpufreq_parse_policy(str_governor, &new_policy))
+			return -EINVAL;
+	} else {
+		if (cpufreq_parse_governor(str_governor, &new_policy))
+			return -EINVAL;
+	}
 
 	ret = cpufreq_set_policy(policy, &new_policy);
 
@@ -1020,32 +1027,39 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
 
 static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
-	struct cpufreq_governor *gov = NULL;
+	struct cpufreq_governor *gov = NULL, *def_gov = NULL;
 	struct cpufreq_policy new_policy;
 
 	memcpy(&new_policy, policy, sizeof(*policy));
 
-	/* Update governor of new_policy to the governor used before hotplug */
-	gov = find_governor(policy->last_governor);
-	if (gov) {
-		pr_debug("Restoring governor %s for cpu %d\n",
+	def_gov = cpufreq_default_governor();
+
+	if (has_target()) {
+		/*
+		 * Update governor of new_policy to the governor used before
+		 * hotplug
+		 */
+		gov = find_governor(policy->last_governor);
+		if (gov) {
+			pr_debug("Restoring governor %s for cpu %d\n",
 				policy->governor->name, policy->cpu);
+		} else {
+			if (!def_gov)
+				return -ENODATA;
+			gov = def_gov;
+		}
+		new_policy.governor = gov;
 	} else {
-		gov = cpufreq_default_governor();
-		if (!gov)
-			return -ENODATA;
-	}
-
-	new_policy.governor = gov;
-
-	/* Use the default policy if there is no last_policy. */
-	if (cpufreq_driver->setpolicy) {
-		if (policy->last_policy)
+		/* Use the default policy if there is no last_policy. */
+		if (policy->last_policy) {
 			new_policy.policy = policy->last_policy;
-		else
-			cpufreq_parse_governor(gov->name, &new_policy);
+		} else {
+			if (!def_gov)
+				return -ENODATA;
+			cpufreq_parse_policy(def_gov->name, &new_policy);
+		}
 	}
-	/* set default policy */
+
 	return cpufreq_set_policy(policy, &new_policy);
 }
 
-- 
1.9.1

