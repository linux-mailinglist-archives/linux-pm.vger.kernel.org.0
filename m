Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49828711C1
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 08:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbfGWGOZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 02:14:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34440 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731481AbfGWGOZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 02:14:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so20196426plt.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 23:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nSry5tHM9RfBOmIKpr9LmoQMa70G9y55/xkG15xZ4dM=;
        b=acOECtFzXcNr8wH91jVpU+QCAxg4f02keJtwJpfZ71lbvRGloj62uIAu74gaAy0Bo0
         S51fFMkXeSB0ABaR8PMZ7u9iHNj7/Jxegy3RYT5dfp4kHfGC4FhBI2jZYsu6PiDQRssw
         jhswXrVHzcxqk5BriDTnks0Nsemh2eF6IPFFso9iPH4hdvv6SJQ0JoeKrgOoXctaclcD
         7oExmNPhSNYCLwoj9Ku6ftzNhW7eyqdJfhCnrHfFVT2jqHYxT5Roj5+jvEvWAO9+9k58
         RvPxHt+csJ4SL0bHacKFmdRa2jFNzLobeo29CPPIlpdnqM3GCqJba/1uH61dfhtylHsQ
         pu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nSry5tHM9RfBOmIKpr9LmoQMa70G9y55/xkG15xZ4dM=;
        b=FGNle2/fk0t2c+dwEuXDEIoCh+kB2IWZvDeuV4yQDlxOSh470/2/6ORsJgPWeTFL8G
         wLWKuT0JX5pL7nfZnnyvukzjZTAW/9YSOl1AT4pxz6oNwwdygJfeFUl+VZxiC6v9KTOX
         VyU3NFZpdC2AJbB9faG1P5aH5FN2FQ2Du6QeLGj7ZTNImSwrkM9qQbbiXHOSVf9F13oL
         GgQ04z96uQfqnQi3ZLWJzWsgQMcnc5UHaerv8vwgPBlo93afa92JRY80/rxY8JCF6sgb
         78DdiMF/jIYCj6kYnZffSnk/x+lS7qYpFbSjEX2TUfD2iowGEbmKTVT/6dgfPXJbkd5B
         REvg==
X-Gm-Message-State: APjAAAV972yF7BUZhMISZRlXc8dfmJp/fG5I2mNMCYCpO3kKzmZImiqC
        vqNltMLfH1CTX0V/tl6tfjp7ym8LTls=
X-Google-Smtp-Source: APXvYqyFSL4Ua4WRS4fM0C+hsgD4WHVzH/qYHJ7W9Np+1dVPjMabaI19L/MGrJjv4iAi3n7UC7CgFA==
X-Received: by 2002:a17:902:b702:: with SMTP id d2mr81525584pls.259.1563862464605;
        Mon, 22 Jul 2019 23:14:24 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id a3sm38023673pfl.145.2019.07.22.23.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 23:14:24 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 01/10] cpufreq: Add policy create/remove notifiers
Date:   Tue, 23 Jul 2019 11:44:01 +0530
Message-Id: <1b93721f076ec9006b99c92e8a7045d01630cf4b.1563862014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563862014.git.viresh.kumar@linaro.org>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit f9f41e3ef99ac9d4e91b07634362e393fb929aad.

We have a new use case for policy create/remove notifiers (for
allocating/freeing QoS requests per policy), lets add them back.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 15 ++++++++++++++-
 include/linux/cpufreq.h   |  2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8dda62367816..c13dcb59b30c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1266,7 +1266,17 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 				   DEV_PM_QOS_MAX_FREQUENCY);
 	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
 				   DEV_PM_QOS_MIN_FREQUENCY);
-	dev_pm_qos_remove_request(policy->max_freq_req);
+
+	if (policy->max_freq_req) {
+		/*
+		 * CPUFREQ_CREATE_POLICY notification is sent only after
+		 * successfully adding max_freq_req request.
+		 */
+		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+					     CPUFREQ_REMOVE_POLICY, policy);
+		dev_pm_qos_remove_request(policy->max_freq_req);
+	}
+
 	dev_pm_qos_remove_request(policy->min_freq_req);
 	kfree(policy->min_freq_req);
 
@@ -1391,6 +1401,9 @@ static int cpufreq_online(unsigned int cpu)
 				ret);
 			goto out_destroy_policy;
 		}
+
+		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+				CPUFREQ_CREATE_POLICY, policy);
 	}
 
 	if (cpufreq_driver->get && has_target()) {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 536a049d7ecc..afc10384a681 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -458,6 +458,8 @@ static inline void cpufreq_resume(void) {}
 /* Policy Notifiers  */
 #define CPUFREQ_ADJUST			(0)
 #define CPUFREQ_NOTIFY			(1)
+#define CPUFREQ_CREATE_POLICY		(2)
+#define CPUFREQ_REMOVE_POLICY		(3)
 
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list);
-- 
2.21.0.rc0.269.g1a574e7a288b

