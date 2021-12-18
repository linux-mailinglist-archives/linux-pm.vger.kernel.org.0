Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EEC479AE6
	for <lists+linux-pm@lfdr.de>; Sat, 18 Dec 2021 14:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhLRNAh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Dec 2021 08:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbhLRNAh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Dec 2021 08:00:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790A3C061574
        for <linux-pm@vger.kernel.org>; Sat, 18 Dec 2021 05:00:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so3286810wmb.0
        for <linux-pm@vger.kernel.org>; Sat, 18 Dec 2021 05:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hik1Ew47qtvoaoQPBwSqmP9iF+Hk1zIVyb0fsefpwXU=;
        b=GzFN4UefBx0laykv6Zwg7pEq1+EAUbsyKbx6AVLTNdAHslCUEN3tBeGnzJroWjsmhh
         qUhWsji2g2tm27/NZyIG51JJQCSBJ0CqCa2+JQdMd0uAy9Otvl9FhnMoZ7HkiJcG76f4
         gu+C+z+i7GqiYsF6KLSuEYxAihpkIC5damwHnVjUHG4EmVj/IFXBSyA2SipJy6vy8lET
         9MXfTrIni9eKR2PMHrNeDMNmHnei5TtzQhtKnfeWSUm+ibx80VYY/M6Ez5dgWCKPA/wB
         uuOV0HRD44DO/ctS2Mg1EiJ/l0koYw+STrXylmet58LA6sEtqUfFHRN6Q8W8tGdSwn16
         uUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hik1Ew47qtvoaoQPBwSqmP9iF+Hk1zIVyb0fsefpwXU=;
        b=rscC1vS7U3UGWqJl6epWekms/Lx10aYxzQKfilZVIJPCkbhfMsgv/aN+8Y464mapB3
         k78i8JgUj2zvjoCh7yRIvH3pJdndClQCyWzfY29ptsD1GdKTawO6j91d8KFjxZTKMaFO
         E+nUpF02ducpnXZ1Rgmf1CQWV1rJC/0KI9lGe9xoddJVy268vIsa05uh7QO7CK/aGYri
         1K100dxb2kjtU10vagYm3vBg3cZc+I6lpxiydGN/LZ5q0Zr4dETyQfErxk3z0Y845p1U
         SvkCC8QMmS90LglrRRLCqNE5cg3pB9JHxvR+gGZEHOhQBtssVIrH5FFPWarabVetEm0i
         YqHQ==
X-Gm-Message-State: AOAM531uaWEsQfSrlzbv7V5yKRj2C/I+hND7tJtsIqhzmzGvNT9lqjQe
        XrW4dZQPFCFfE3ezwA7dyFcQFQ==
X-Google-Smtp-Source: ABdhPJwByO/pO1dDzzwFGphL1YqsL1H2rh9fyawiwIX/hNuHVwXE2pcVQ3eqQc71yMLx0PPnvdfuOA==
X-Received: by 2002:a05:600c:1f05:: with SMTP id bd5mr6638452wmb.171.1639832435001;
        Sat, 18 Dec 2021 05:00:35 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:1f0f:c9b8:ee5c:5c2f])
        by smtp.gmail.com with ESMTPSA id j16sm1465785wms.12.2021.12.18.05.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 05:00:34 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     lukasz.luba@arm.com, robh@kernel.org, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v5 3/6] powercap/drivers/dtpm: Add CPU DT initialization support
Date:   Sat, 18 Dec 2021 14:00:11 +0100
Message-Id: <20211218130014.4037640-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
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
 drivers/powercap/dtpm_cpu.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 6bffb44c75aa..ca605911523b 100644
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
 
@@ -269,4 +292,4 @@ static int __init dtpm_cpu_init(void)
 	return 0;
 }
 
-DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init, NULL);
+DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init, dtpm_cpu_setup);
-- 
2.25.1

