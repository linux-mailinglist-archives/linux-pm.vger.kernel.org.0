Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA3746530F
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 17:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbhLAQqB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 11:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351506AbhLAQpr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 11:45:47 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FF4C061763
        for <linux-pm@vger.kernel.org>; Wed,  1 Dec 2021 08:42:07 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d24so53747953wra.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Dec 2021 08:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JXIYabK6ZewRD4vP7R+kD9rZl3/XxOM5JXs9rSVNxs0=;
        b=vw0JVd5y8wu1Jom3pVIs4aR0AIkOBoRl4ZyuxeWSHC22H9wbOYsXqf/HZ48U0MG6Ab
         r7QoTplk96JO/XpDSkK3+PMiDbR0q6EeTvU8baAbDB/HoPv/2Qfy0/sQV3MCKrBMUFWv
         sySaPM56q+7Dv7jaj+1Ph9vcpPdVN+N/96H0WYYqW3zs4tjYAppdkv0jLJa9F/kDMvM/
         v7s9zH503ba0Q/yXPD2b0golaGLTwuyt9Wtj8bTX7FXbOpYoo9c+DbD7dnAHBvZ2MLNG
         a9Rl7lqLDEI3QJGy2kiE5FlhjlLyEuXcW/T+GE/1z6Y0+0inVdq4/Y6EFvf98EbtRGcp
         A10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JXIYabK6ZewRD4vP7R+kD9rZl3/XxOM5JXs9rSVNxs0=;
        b=xfhUbnqAq+LWMkS1JyJ4W3g48ZgJ0TEK6Gql/WQNuTJWoJYR56CndzKFqnDU0SuaNA
         q/OtyLEFH8htgpC2KMNZDtXAPfCHxvnFKhzNWkN6KoSl/PAq6FLXAy4ZN19MAqRN3/kI
         zryZtKqfkLUEy312qOBRi7vpHFPW/qeiwp0ygFcYOZx6k+M2ZlYkUMXlcEu2PTBpbCzH
         nYagzMvd6V6vichv9yOAktiRGdDSjq1TJA7whBjYFTJ/Mlxo86HcBJwDv4Wib81g3NCD
         zySCbEgPC+Tco3HKo++XRwf7Hr2tsRVWMiGe5ihehbJbZ706hqK9i/AwWqkpvP09KtjS
         tUDA==
X-Gm-Message-State: AOAM53259pSjIEYZmrpnY4E5qlSvMJMTGax6IaI1Tccjt7zRoC7STpkB
        VmJyht6THs6+rhX6zFzmTw2TBg==
X-Google-Smtp-Source: ABdhPJzAwiJRj3MQk6b48MnprU5u3nSh2vpmzSf1Q4wVU0M+t/T8JgexpG2AjM0DPF8D/j0GRGICdg==
X-Received: by 2002:a5d:53cb:: with SMTP id a11mr8301611wrw.357.1638376926169;
        Wed, 01 Dec 2021 08:42:06 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:72d0:52a1:d4ea:f564])
        by smtp.gmail.com with ESMTPSA id v8sm255547wrd.84.2021.12.01.08.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:42:05 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, robh@kernel.org
Cc:     arnd@linaro.org, heiko@sntech.de, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 4/5] powercap/drivers/dtpm: Add CPU DT initialization support
Date:   Wed,  1 Dec 2021 17:38:53 +0100
Message-Id: <20211201163856.41419-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201163856.41419-1-daniel.lezcano@linaro.org>
References: <20211201163856.41419-1-daniel.lezcano@linaro.org>
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

