Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4130F468E0C
	for <lists+linux-pm@lfdr.de>; Mon,  6 Dec 2021 00:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241076AbhLEXUH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Dec 2021 18:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241080AbhLEXT6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Dec 2021 18:19:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A028C061A83
        for <linux-pm@vger.kernel.org>; Sun,  5 Dec 2021 15:16:30 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id o13so18565378wrs.12
        for <linux-pm@vger.kernel.org>; Sun, 05 Dec 2021 15:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JXIYabK6ZewRD4vP7R+kD9rZl3/XxOM5JXs9rSVNxs0=;
        b=BZ4TwD3SxJxsGh/FbEWbY/LJSI4250dSPguJNiIK4bcmeJxGvLC1J9w9IouTGYbE9n
         R+PvOndM1fHZGB3QIkRQXWXpQA2/vJ9TaXbuHYF3vLNb2gDVFCiLmJc9xM1eQPUH6bS4
         5hPH3/MjatRpEHY/FDflFSx3apdrPdBuK+KsmhGV1cm1AzL2MONv73LF5jp+ObiiVUHD
         /BZS/MZN68qMshOjNZQL4EsNNHdSTIHeGkJqGyM3xaKuI/gkI0hLKDVAA+0w/yhZzak1
         IY5REFVgNmv9ri6RhdAX+0kfwDvUhe39smhQI1ifJWOt76RgrpRkVNtWeElpa5BNXVRx
         tOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JXIYabK6ZewRD4vP7R+kD9rZl3/XxOM5JXs9rSVNxs0=;
        b=4ERITKjsjpuSjr+taneMXgCfhwXT0VRi6Y408GqdeR4o3nNpqEMJpVD37Zz4SQHEtd
         LZDiDGTZVr/7WEOr2eTAhGZ2aPR1H5bD98tAs7gNZoRWYkeB7v3jFPHDl76/CzE//BPP
         +9LZVOA8WqxLs7vcQ2LFa4pM0MxBUWUOa+Rh60BMHxfhVpQKj+bC3EBRDIfKaTdrCgQw
         UNKF6xX3H2f9I/S/59vGgS9rH+DIS1bWgcg/rFkkUR6wRYUNUJogRpp+KnLTGK5i99fe
         jtynikQkoQ/SjYxne8xvdylYSXNIlPQCVCHiXFJls60cHNKVmromJ5Cpti9Wq2aFEPzD
         xgOQ==
X-Gm-Message-State: AOAM531H3nQM4l+nYHNMmIStk6eT48gud4xQRpYLnyd1bIiU7iIIK9Rh
        WVfJhcJVlCcgeWlP/gKdNi9gPg==
X-Google-Smtp-Source: ABdhPJzh6F/xXYdvKwGvpNmMucAAjEo9HmPzyZaEcasoGHS4tUxnfI5U5yON3hmWWFfY6xiA0kfI0Q==
X-Received: by 2002:a05:6000:181:: with SMTP id p1mr39407367wrx.292.1638746188571;
        Sun, 05 Dec 2021 15:16:28 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:1cec:4235:bb04:b944])
        by smtp.gmail.com with ESMTPSA id c10sm10715312wrb.81.2021.12.05.15.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 15:16:28 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, robh@kernel.org
Cc:     arnd@linaro.org, heiko@sntech.de, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 4/5] powercap/drivers/dtpm: Add CPU DT initialization support
Date:   Mon,  6 Dec 2021 00:15:56 +0100
Message-Id: <20211205231558.779698-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205231558.779698-1-daniel.lezcano@linaro.org>
References: <20211205231558.779698-1-daniel.lezcano@linaro.org>
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
---
 drivers/powercap/dtpm_cpu.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 6bffb44c75aa..64cec0770803 100644
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
 
@@ -231,6 +243,17 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	return ret;
 }
 
+static int __init dtpm_cpu_setup(struct dtpm *dtpm, struct device_node *np)
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
 static int __init dtpm_cpu_init(void)
 {
 	int ret;
@@ -269,4 +292,4 @@ static int __init dtpm_cpu_init(void)
 	return 0;
 }
 
-DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init, NULL);
+DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init, dtpm_cpu_setup);
-- 
2.25.1

