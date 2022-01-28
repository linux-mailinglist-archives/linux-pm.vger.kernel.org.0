Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4637949FE29
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jan 2022 17:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350146AbiA1QgU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 11:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350184AbiA1QgO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 11:36:14 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051A5C06174E
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 08:36:13 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o30-20020a05600c511e00b0034f4c3186f4so8567595wms.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 08:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPK1edLyJrRFFEyWcyiec8UXIbfSrQa/ueeEQUG7KDE=;
        b=kGyi6U92aemfBrqx1MsrnIRNqE7tjyN/FjHGf3cWg0qVpija+ScUg7R0y4UcYPKTNp
         951ssI+FVMlGXDMnic+lGaP3MkOzqgWaH/OpX51uT5hyuXMrOFYczWKdOpPzOI4NwYa0
         a6Vbvd3iak8eWOy0K9bzJ1J+oWZ0QHPidFbtpH+T7qK8s5ELyAbyIzr1rz5m/QXOEdjw
         +KjCUeGMptQyuguDUmthx/oHvCuGNvTYpX1Hk7h5Z0q5JAZpD0OmeMSbfLMjov/Z9eor
         6hkcjuPjk6i4eG9yVNPkWQ3ZeC2sAefj+8q/gpeiZDwuuFvz9jhJOMyaSb3RjDIt78Sb
         5NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPK1edLyJrRFFEyWcyiec8UXIbfSrQa/ueeEQUG7KDE=;
        b=Dka8QGKv42IZhN8Fbz3viGLtszr/pZTb7g6+7wNt/f00BXlaV8IZFnQKCXOzcwFRhW
         MGrVECvWsIXQIwt6ViyPSzHG5NHAKWS5lez6Mi7MfD9LjZ6oJ4pm18l0reEcFneGWHmR
         7rL+JYRfXCaCp7Mwee1NV9wEeUaboCHXBCh9LGSd3enLKk7I3U0ahZe8H8yahfLE1PLP
         KDcpghXDZ9aojvACeDbOm+61rvYNN6yRM8ZRn8TKRLiQPdNTvRkU/wfw3R/8FIo3wYwN
         AvH881eYQR3YgTG52eCNFu/lEAhMC5WcBY+vM2VwRDLQB1OWCOCmEC5l42QODIRHEunX
         Gu+Q==
X-Gm-Message-State: AOAM530E6vwOx1qAVUNoj4HP5l9hT1qHOFC/CxSo2qBE33VEjudAOvYm
        bLsVXgtnlKgWw8mozkr83f999g==
X-Google-Smtp-Source: ABdhPJwvHeyXNhi7RFJ2QaYYMJS7UntYm6hj8Gz+56fUrsZ0y8xZzXk0LaGrhKsbyFh5guhz8dFOIw==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr8205368wmh.169.1643387771424;
        Fri, 28 Jan 2022 08:36:11 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:f39:b962:8b8e:9851])
        by smtp.gmail.com with ESMTPSA id m6sm5734745wrw.54.2022.01.28.08.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:36:10 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, robh@kernel.org, lukasz.luba@arm.com,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v8 3/5] powercap/drivers/dtpm: Add CPU DT initialization support
Date:   Fri, 28 Jan 2022 17:35:35 +0100
Message-Id: <20220128163537.212248-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128163537.212248-1-daniel.lezcano@linaro.org>
References: <20220128163537.212248-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Based on the previous DT changes in the core code, use the 'setup'
callback to initialize the CPU DTPM backend.

Code is reorganized to stick to the DTPM table description. No
functional changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/powercap/dtpm_cpu.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 5763e0ce2af5..eed5ad688d46 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -21,6 +21,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/dtpm.h>
 #include <linux/energy_model.h>
+#include <linux/of.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/units.h>
@@ -176,6 +177,17 @@ static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
 }
 
 static int cpuhp_dtpm_cpu_online(unsigned int cpu)
+{
+	struct dtpm_cpu *dtpm_cpu;
+
+	dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
+	if (dtpm_cpu)
+		return dtpm_update_power(&dtpm_cpu->dtpm);
+
+	return 0;
+}
+
+static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 {
 	struct dtpm_cpu *dtpm_cpu;
 	struct cpufreq_policy *policy;
@@ -183,6 +195,10 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	char name[CPUFREQ_NAME_LEN];
 	int ret = -ENOMEM;
 
+	dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
+	if (dtpm_cpu)
+		return 0;
+
 	policy = cpufreq_cpu_get(cpu);
 	if (!policy)
 		return 0;
@@ -191,10 +207,6 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	if (!pd)
 		return -EINVAL;
 
-	dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
-	if (dtpm_cpu)
-		return dtpm_update_power(&dtpm_cpu->dtpm);
-
 	dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
 	if (!dtpm_cpu)
 		return -ENOMEM;
@@ -207,7 +219,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 
 	snprintf(name, sizeof(name), "cpu%d-cpufreq", dtpm_cpu->cpu);
 
-	ret = dtpm_register(name, &dtpm_cpu->dtpm, NULL);
+	ret = dtpm_register(name, &dtpm_cpu->dtpm, parent);
 	if (ret)
 		goto out_kfree_dtpm_cpu;
 
@@ -231,7 +243,18 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	return ret;
 }
 
-static int __init dtpm_cpu_init(void)
+static int dtpm_cpu_setup(struct dtpm *dtpm, struct device_node *np)
+{
+	int cpu;
+
+	cpu = of_cpu_node_to_id(np);
+	if (cpu < 0)
+		return 0;
+
+	return __dtpm_cpu_setup(cpu, dtpm);
+}
+
+static int dtpm_cpu_init(void)
 {
 	int ret;
 
@@ -272,4 +295,5 @@ static int __init dtpm_cpu_init(void)
 struct dtpm_subsys_ops dtpm_cpu_ops = {
 	.name = KBUILD_MODNAME,
 	.init = dtpm_cpu_init,
+	.setup = dtpm_cpu_setup,
 };
-- 
2.25.1

