Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851994936B0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jan 2022 09:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352744AbiASI6R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jan 2022 03:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352748AbiASI6M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jan 2022 03:58:12 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE95BC061401
        for <linux-pm@vger.kernel.org>; Wed, 19 Jan 2022 00:58:04 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id h206-20020a1c21d7000000b0034d95625e1fso4675071wmh.4
        for <linux-pm@vger.kernel.org>; Wed, 19 Jan 2022 00:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPK1edLyJrRFFEyWcyiec8UXIbfSrQa/ueeEQUG7KDE=;
        b=RxId/LPPz8XHSLlm0CocGEDr7QDKa56PiTrMOew8Dr7TEhxk3sQtbBjbTTP0BUbLlA
         hEnsQGVFflOZKZ85Pg2Lv3T7ciazoFV+eRZWdXHcbuvRWrYZe2xg3RTKN7AresVLPN5j
         kTCixJsmCYlYtWndRvSh8/jnLCKuahOVY3Yi8YpLfSUEzRtIwz+CaBAkyBHnYIBEyxUH
         +GGTTyjmWdOu+Q3eHYPZE2JjFYfX7R+wPQ9+6J2l/XNgRHXpbeRiacWlwGQSC1W1BBVG
         +Db+xNxOohg8Gr4cq6nlFG4Xcq1DTp1oTgR0OPzPpxcgT6Ff+EwR2on34Cq8Tch6PoLn
         9ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPK1edLyJrRFFEyWcyiec8UXIbfSrQa/ueeEQUG7KDE=;
        b=s3qo950SaZpaOgYmYRJnqWfB2m7EbTsyx3psCbSyxAjf3gdJyyy4wy1pmSN+Fn9pcG
         W4z49OvbDteu0zNM+lGRLkkfdtiqkhVO6k+6usSPI/IhqjezQGeLovwOoH+GKZRmpz2+
         YW5MpmRZ9aSQc19VQA3P/YEN+GGS2KWM/m+X9Z7O76Gp1j6I6bm+EQJcEP1fa5aRhZ9R
         207FJlPHLAIOrxH/4jTYwdcpuyNyHGKSTxSPy8D+eL0FMegq6f6/g0qYxaAmp+dzvizA
         s6elA3kixIPgFLuMmHWTV7QA3P0ftWsNp5r/v1vB6HTvD23uB2dsdM47FzVHABze8UFT
         L3Tg==
X-Gm-Message-State: AOAM53282vEE8Q9TyuDGsb7E3AYOYdoKrKu2jFEHf7DJ6Ii2Fwypk8nj
        TFca7kG5SvZE2BLAVB7EmKVXJw==
X-Google-Smtp-Source: ABdhPJwa3WcUUIUWowlFaLyWigMFvCU2p+CzSmV1jvvN9oTJzeLMzRF7JJk4scahGRcFbHBoAGI2Vw==
X-Received: by 2002:a7b:c747:: with SMTP id w7mr1242660wmk.150.1642582683431;
        Wed, 19 Jan 2022 00:58:03 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:ef34:de48:dc4e:ad87])
        by smtp.gmail.com with ESMTPSA id 10sm4491454wmc.44.2022.01.19.00.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 00:58:02 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     robh@kernel.org, lukasz.luba@arm.com, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v6 3/5] powercap/drivers/dtpm: Add CPU DT initialization support
Date:   Wed, 19 Jan 2022 09:57:17 +0100
Message-Id: <20220119085719.1357874-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119085719.1357874-1-daniel.lezcano@linaro.org>
References: <20220119085719.1357874-1-daniel.lezcano@linaro.org>
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

