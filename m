Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C6D4C5B1
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 05:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbfFTDGg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 23:06:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43963 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbfFTDGf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 23:06:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so744130plb.10
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 20:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e2RYmyEcM16uV8QAfPAD1VnbVzdNHH04eTPp0y1GpdE=;
        b=DZpCjpoaZQW45P9CeX3cDnXJU8tmgG817TlOWAKnWM3+mxcgfgm3MwAPNIg9q4WlvV
         mxtLg3/edOddOGSsNdFJOoqaFkOTbcpVBLqWc2jSUjY4oQRgpg6KvzAKnEV+JWGRuC73
         OZ3oZSW5R8KBELMniexMbEYBACrBKo+9LhUcWFjJh9QdgMU9LnxJEAW8jFyse4XNhwdQ
         puK1HEQGkiyJ2onBQOeVMyTJniUw2w0lHWkbNeg5lHXSm+NdCw64T8mBHyJME0v1l889
         DgFB1MSOoZ0JINkcsQMd7q1v31Qw6rjZ3u6h1O3/JhzIXaDbFFaoRiX+Ddv995jaznf2
         CONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2RYmyEcM16uV8QAfPAD1VnbVzdNHH04eTPp0y1GpdE=;
        b=EsmnVOge4xNX3P57cJMeyqDF+8oOZL7aVVH/oAKjzmJng9bXepINDLP4bGC48izuE7
         7i5d4Wz3JjZ9paf0YVkkKCCK5gKIRVdD33KPt/8CWNea3ceLXJey5Gjm2BUDWFLlSHCH
         zBl0nS7BKd4dF/NavDiNlrgQZuwyOZRbchyOCNWJNBjC2P4DtiXYJ8HcAYzjwTYVBK3X
         2KgxTQjD63JXRdMQ8Wl2BG1Wun6+cj3Up0S6GH4mbilKh7B6FHQ8YYBFek4Le1WRbEn5
         0j8FMyag40vxAxICrGJCOXQu9wk56rz8Sx0PgXxZeDdGxSncK9+6Ogupzxl3CKEbXOjJ
         hjAQ==
X-Gm-Message-State: APjAAAUdBR3HzTmph4nq2cGlLl6n6Jv16OrtaS9LCy/QMsa9umcKNf2g
        9c06cXM0WyQms1N7k1GWtXIXWQ==
X-Google-Smtp-Source: APXvYqw3FncPDprKfdEYf7q4+OqbC8vh5kSAFntM0Xso4RIi81R/M+KB2gM8MIZO7WfCN0JX8cQd/A==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37mr123268486plb.150.1560999995255;
        Wed, 19 Jun 2019 20:06:35 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id b135sm19459543pfb.44.2019.06.19.20.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 20:06:34 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/5] cpufreq: Avoid calling cpufreq_verify_current_freq() from handle_update()
Date:   Thu, 20 Jun 2019 08:35:50 +0530
Message-Id: <ea598384a9ba18e20b598863ce339a55093be5f6.1560999838.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560999838.git.viresh.kumar@linaro.org>
References: <cover.1560999838.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On some occasions cpufreq_verify_current_freq() schedules a work whose
callback is handle_update(), which further calls cpufreq_update_policy()
which may end up calling cpufreq_verify_current_freq() again.

On the other hand, when cpufreq_update_policy() is called from
handle_update(), the pointer to the cpufreq policy is already available
but we still call cpufreq_cpu_acquire() to get it in
cpufreq_update_policy(), which should be avoided as well.

Fix both the issues by creating another helper
reeval_frequency_limits().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4556a53fc764..0a73de7aae54 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1115,13 +1115,25 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 	return ret;
 }
 
+static void reeval_frequency_limits(struct cpufreq_policy *policy)
+{
+	struct cpufreq_policy new_policy = *policy;
+
+	pr_debug("updating policy for CPU %u\n", policy->cpu);
+
+	new_policy.min = policy->user_policy.min;
+	new_policy.max = policy->user_policy.max;
+
+	cpufreq_set_policy(policy, &new_policy);
+}
+
 static void handle_update(struct work_struct *work)
 {
 	struct cpufreq_policy *policy =
 		container_of(work, struct cpufreq_policy, update);
-	unsigned int cpu = policy->cpu;
-	pr_debug("handle_update for cpu %u called\n", cpu);
-	cpufreq_update_policy(cpu);
+
+	pr_debug("handle_update for cpu %u called\n", policy->cpu);
+	reeval_frequency_limits(policy);
 }
 
 static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
@@ -2378,7 +2390,6 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 void cpufreq_update_policy(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
-	struct cpufreq_policy new_policy;
 
 	if (!policy)
 		return;
@@ -2391,12 +2402,7 @@ void cpufreq_update_policy(unsigned int cpu)
 	    (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
 		goto unlock;
 
-	pr_debug("updating policy for CPU %u\n", cpu);
-	memcpy(&new_policy, policy, sizeof(*policy));
-	new_policy.min = policy->user_policy.min;
-	new_policy.max = policy->user_policy.max;
-
-	cpufreq_set_policy(policy, &new_policy);
+	reeval_frequency_limits(policy);
 
 unlock:
 	cpufreq_cpu_release(policy);
-- 
2.21.0.rc0.269.g1a574e7a288b

