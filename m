Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E733F033
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 08:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbfD3GGA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 02:06:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42998 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfD3GGA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 02:06:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id w25so6527848pfi.9
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 23:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GZEZL45z1EneTJKMne8G+2VaQt/iYLS/+0G8W8SgwA=;
        b=g1UkNI9HZ3eV0p45YahOS9+ozXvXEG/XOI+qxrQP7BDHedk3ssYgfZu4wm37//Qw2P
         vQCydwhrTxWnoe/ILvIJuX3AZmCXDrnT3DbUKZS0dqYFCiMuk6mAP0AL1CRjCpQO00eE
         sVLXGWTo1OkYsFvxNbOB/bW/vkluQtD2RROrEnL88Xf+lFo9qR6xDOZx+kMtRE2v71ni
         fQsmCGgim3CkL9kZTorq158S49AK1miLbh0rbRXAkLNYf+qBz/PxLhY1djI7DybufPju
         7wfbyCHXLIa9czmj4GuLj0gkhjby3ANkTud/fy4XMftphsHj7rz8pawEt/m4gIwUWBWg
         cnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GZEZL45z1EneTJKMne8G+2VaQt/iYLS/+0G8W8SgwA=;
        b=LQDJlazzR54L0hqzJ6xVvzbVmyNtDHtmCJGHs6j446s+b4FFEYsFIbtAfB6Z/WSPpa
         uGQ2Sv2W3WfRxdyO1kZY7Gt731evvBwqI6R085QdUwKlyRFS5/C2yJYIhqQjygarPYS+
         ybZnyJHSgXayWRd3SSiS+yYCTPQqKxx6hRyKL11tUlMfuluOBzThtaFDaeqp2TZLEomB
         Lr3S/DsXq/YFzt+voVwSqWXTiI4Pl/aq5PKmkZHm2wI4jS2PKL5FlRtmnxYaT0fCptYc
         b8zpPavHn010jQr2N8nAJmlC/kDSH7rT0wjMEtd9ZAIYXLlsalGkL8TrsmeAfXEk7MF9
         JAPg==
X-Gm-Message-State: APjAAAVOnT9wh31gHNchN5xSKO0Vus5XF8NtnNoKnuMIPQTzBzmmvXq6
        1nFiE+OZxnj9+eVUeui4xWeFEg==
X-Google-Smtp-Source: APXvYqyGqcu2hA1l46r04AtEHmouG7U+ZeSu4Cv0iZlmk5AIyTEuQFUqaMnePDi/joRNeYkhkI/8rw==
X-Received: by 2002:aa7:8b83:: with SMTP id r3mr37251817pfd.248.1556604359608;
        Mon, 29 Apr 2019 23:05:59 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id w38sm22369464pgk.90.2019.04.29.23.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 23:05:58 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tobin@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Fix kobject memleak
Date:   Tue, 30 Apr 2019 11:35:52 +0530
Message-Id: <815f7c7cea02e05c90d5bf678ea8717f01cc9f63.1556604312.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the error return path from kobject_init_and_add() is not
followed by a call to kobject_put() - which means we are leaking the
kobject.

Fix it by adding a call to kobject_put() in the error path of
kobject_init_and_add().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Tobin fixed this for schedutil already.

 drivers/cpufreq/cpufreq.c          | 1 +
 drivers/cpufreq/cpufreq_governor.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e10922709d13..bbf79544d0ad 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1098,6 +1098,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 				   cpufreq_global_kobject, "policy%u", cpu);
 	if (ret) {
 		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
+		kobject_put(&policy->kobj);
 		goto err_free_real_cpus;
 	}
 
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index ffa9adeaba31..9d1d9bf02710 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -459,6 +459,8 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	/* Failure, so roll back. */
 	pr_err("initialization failed (dbs_data kobject init error %d)\n", ret);
 
+	kobject_put(&dbs_data->attr_set.kobj);
+
 	policy->governor_data = NULL;
 
 	if (!have_governor_per_policy())
-- 
2.21.0.rc0.269.g1a574e7a288b

