Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2409DC050
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 10:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632966AbfJRIwZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 04:52:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40821 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632963AbfJRIwY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 04:52:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id e13so2986433pga.7
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2019 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pOGwcMchIXdaRlZBtyBhTrAkf1RWijM6eAT3n0JAvC8=;
        b=W0/ZDYASOJLvNqpxJwakFyLljNCg9m3gU0qus8PbZv80d4MBYV61s6YgkTZ2o092HT
         l6Hox1rxqw02mP0hkE4dmTIBOWuWzQnun3CAx8iQoBX+ieOgLqXuGkwjkkOBDHTp5Ej+
         bSnCeOZpuByrGXv865yvZBGp5e3L4VUeAZx+58RmXzR2DvP9GDKFU1ygQ9w2uMVTfPcz
         smHMCtUiUzR34xEfz0yeFzUvh94kWKg6jMr4+OVdRPZ10fXTx3dQH2GQTaOGk6Ngx4Uk
         IMX2iqAmFPlLvk2rQBvqd8zGqL8L0dUK+Ga6BJIMHRfiL0VXN79mrWTRE45HPF/mmQAF
         dwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=pOGwcMchIXdaRlZBtyBhTrAkf1RWijM6eAT3n0JAvC8=;
        b=sXwd6Uz9z9alJi7+BKnqV7smGboXUuiWlfpcL5xS60SSA8oYMBKJNVUFHUpmaBvJk0
         CLaMxAJf2FfUxVPRUE7u84JM4oedEwjr7nEmx2XpKEdItmIqySvGSF/vm4aUpvN8S/8N
         td2VHPUt9rr+ANlI+EEW0hcJGb9CNCV5qN2yQE3VrY68pZfR4KhTPv8oHn6lUGgZVOUr
         tlPgglzdPd/YfKRzXwdOuGh8hblk/vPfiAYWcz5DSempxKF8hXYjosHjIu4CpKuWL4St
         /l0ZuN2qQD5S/28gXmBCkcLLcq4i1QCI3v+N6irFUmY/+YDTbrsK60c16cbzQgfKRFOS
         AzLg==
X-Gm-Message-State: APjAAAVeEj5KE9A9aFhtY7NJjBfHSZexCgNwVNGIMhPzAANT89Xg19+2
        xTM35n3DeIBySBfMa3lCsXblPUDJeT5Eyw==
X-Google-Smtp-Source: APXvYqwoQ5ESE21BX6wAak+ChcC8b4+hgljou3Np9qGufEF8scYDPgxmkBTLTmXkiWYDrLsXbM03IA==
X-Received: by 2002:a17:90a:bd8e:: with SMTP id z14mr9466041pjr.40.1571388743507;
        Fri, 18 Oct 2019 01:52:23 -0700 (PDT)
Received: from localhost ([49.248.178.134])
        by smtp.gmail.com with ESMTPSA id c34sm5688183pgb.35.2019.10.18.01.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Oct 2019 01:52:23 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v4 3/6] cpufreq: Initialise the governors in core_initcall
Date:   Fri, 18 Oct 2019 14:22:00 +0530
Message-Id: <aa02366951fb174077a945761a7cda03d08acab5.1571387352.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571387352.git.amit.kucheria@linaro.org>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571387352.git.amit.kucheria@linaro.org>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Initialise the cpufreq governors earlier to allow for earlier
performance control during the boot process.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 2 +-
 drivers/cpufreq/cpufreq_ondemand.c     | 2 +-
 drivers/cpufreq/cpufreq_performance.c  | 2 +-
 drivers/cpufreq/cpufreq_powersave.c    | 2 +-
 drivers/cpufreq/cpufreq_userspace.c    | 2 +-
 kernel/sched/cpufreq_schedutil.c       | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index b66e81c06a575..737ff3b9c2c09 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -346,7 +346,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return CPU_FREQ_GOV_CONSERVATIVE;
 }
 
-fs_initcall(cpufreq_gov_dbs_init);
+core_initcall(cpufreq_gov_dbs_init);
 #else
 module_init(cpufreq_gov_dbs_init);
 #endif
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index dced033875bf8..82a4d37ddecb3 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -483,7 +483,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return CPU_FREQ_GOV_ONDEMAND;
 }
 
-fs_initcall(cpufreq_gov_dbs_init);
+core_initcall(cpufreq_gov_dbs_init);
 #else
 module_init(cpufreq_gov_dbs_init);
 #endif
diff --git a/drivers/cpufreq/cpufreq_performance.c b/drivers/cpufreq/cpufreq_performance.c
index aaa04dfcacd9d..def9afe0f5b86 100644
--- a/drivers/cpufreq/cpufreq_performance.c
+++ b/drivers/cpufreq/cpufreq_performance.c
@@ -50,5 +50,5 @@ MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq policy governor 'performance'");
 MODULE_LICENSE("GPL");
 
-fs_initcall(cpufreq_gov_performance_init);
+core_initcall(cpufreq_gov_performance_init);
 module_exit(cpufreq_gov_performance_exit);
diff --git a/drivers/cpufreq/cpufreq_powersave.c b/drivers/cpufreq/cpufreq_powersave.c
index c143dc237d878..1ae66019eb835 100644
--- a/drivers/cpufreq/cpufreq_powersave.c
+++ b/drivers/cpufreq/cpufreq_powersave.c
@@ -43,7 +43,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return &cpufreq_gov_powersave;
 }
 
-fs_initcall(cpufreq_gov_powersave_init);
+core_initcall(cpufreq_gov_powersave_init);
 #else
 module_init(cpufreq_gov_powersave_init);
 #endif
diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index cbd81c58cb8f0..b43e7cd502c58 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -147,7 +147,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return &cpufreq_gov_userspace;
 }
 
-fs_initcall(cpufreq_gov_userspace_init);
+core_initcall(cpufreq_gov_userspace_init);
 #else
 module_init(cpufreq_gov_userspace_init);
 #endif
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 86800b4d5453f..322ca8860f548 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -915,7 +915,7 @@ static int __init sugov_register(void)
 {
 	return cpufreq_register_governor(&schedutil_gov);
 }
-fs_initcall(sugov_register);
+core_initcall(sugov_register);
 
 #ifdef CONFIG_ENERGY_MODEL
 extern bool sched_energy_update;
-- 
2.17.1

