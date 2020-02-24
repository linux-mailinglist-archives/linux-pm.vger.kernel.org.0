Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F412916B460
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 23:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgBXWna (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 17:43:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37796 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgBXWmq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 17:42:46 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so8066602lfc.4;
        Mon, 24 Feb 2020 14:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nIyuKZWIZi/B5cTCqrl8qdcGjW5k6PQ+Dl+Q52lH0cU=;
        b=ZUTA5YiaSxFRz/5GiZEXH/fQSYJ4U2Jo6OWoRZPQJkXeYfdyL+r8Ew6o53y0NQ/ZGK
         Nz+Oyvehtg4/Uatv6UzpCjsz7TZmiRyNtQHwk0azTaot2laWe6Z4ztqHVwJmItabhN0f
         2kRiH7Dh0vYafg103a+y2yIM+K8vLm8QBlHT/6BnTUiTK31R0NV1BxGc536JFrnVCNKD
         LiLaCCjoc0wiTyweav6Da70DvsXPsTXLqcR2TB/UvcO7Agrm9ktw5Ia9MIIV8aXmVJM/
         Ie/Golg8SjWkvlqL2943fyg6f6GkhdHudpls1CCbWTbgUqZH3/Ni/I1Oy2A7CXkLBmFn
         N/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nIyuKZWIZi/B5cTCqrl8qdcGjW5k6PQ+Dl+Q52lH0cU=;
        b=YYI5ipb71oAPHdabXG6GiLcPivsv9Quj+G/wN7cQtuFueYzQefNdmo8CDUCqir6FjI
         lk7HM7QQyO9inZm2OcTfnKkozwppcO+p+jgODo10x0gNab8QGZorSEFa6nyGuZE9qvWs
         BHAt6dJK4oKmhf1owCMH83ems4fye9HyWb/Sv4hceIEXRUb+76spQNfeck6+CHAKgKY1
         Y5z0mkR0/Dt3NdzWBUqLJq6SfbM092hZeqCj6CZSOtvZgKz1KueHUNDkX63mcd0xlV0t
         ThDKD/BDZacM9VCjdK8lqrof+jRK0qp40W6nh87XQv99h7q3/3apqFT3OuuhTfJFw7mv
         57Xg==
X-Gm-Message-State: APjAAAWGv01mbc2QTROSSgK+t4L5g7F80GEox3EUJxe0zgwz495UvgRB
        7FdJYDi1LkQ6MJ2p0okIpjM=
X-Google-Smtp-Source: APXvYqxbRCCCBd7E8CLBaxTr5AOAUU2DoPJi/QOJmaBGNtS4agc/HYfYHKD6U70SRjhPTej+W9K7dQ==
X-Received: by 2002:ac2:4467:: with SMTP id y7mr6150265lfl.167.1582584163658;
        Mon, 24 Feb 2020 14:42:43 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j7sm6264833lfh.25.2020.02.24.14.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:42:43 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 09/17] arm: tegra20: cpuidle: Handle case where secondary CPU hangs on entering LP2
Date:   Tue, 25 Feb 2020 01:40:49 +0300
Message-Id: <20200224224057.21877-10-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200224224057.21877-1-digetx@gmail.com>
References: <20200224224057.21877-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is possible that something may go wrong with the secondary CPU, in that
case it is much nicer to get a dump of the flow-controller state before
hanging machine.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 51 +++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index a5b7d4e68f43..40566da25c6c 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -14,6 +14,7 @@
 #include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 
@@ -82,14 +83,60 @@ static inline void tegra20_wake_cpu1_from_reset(void)
 }
 #endif
 
+static void tegra20_report_cpus_state(void)
+{
+	unsigned long cpu, lcpu, csr;
+
+	for_each_cpu(lcpu, cpu_possible_mask) {
+		cpu = cpu_logical_map(lcpu);
+		csr = flowctrl_read_cpu_csr(cpu);
+
+		pr_err("cpu%lu: online=%d flowctrl_csr=0x%08lx\n",
+		       cpu, cpu_online(lcpu), csr);
+	}
+}
+
+static int tegra20_wait_for_secondary_cpu_parking(void)
+{
+	unsigned int retries = 3;
+
+	while (retries--) {
+		unsigned int delay_us = 10;
+		unsigned int timeout_us = 500 * 1000 / delay_us;
+
+		/*
+		 * The primary CPU0 core shall wait for the secondaries
+		 * shutdown in order to power-off CPU's cluster safely.
+		 * The timeout value depends on the current CPU frequency,
+		 * it takes about 40-150us  in average and over 1000us in
+		 * a worst case scenario.
+		 */
+		do {
+			if (tegra_cpu_rail_off_ready())
+				return 0;
+
+			udelay(delay_us);
+
+		} while (timeout_us--);
+
+		pr_err("secondary CPU taking too long to park\n");
+
+		tegra20_report_cpus_state();
+	}
+
+	pr_err("timed out waiting secondaries to park\n");
+
+	return -ETIMEDOUT;
+}
+
 static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
 					   struct cpuidle_driver *drv,
 					   int index)
 {
 	bool ret;
 
-	while (!tegra_cpu_rail_off_ready())
-		cpu_relax();
+	if (tegra20_wait_for_secondary_cpu_parking())
+		return false;
 
 	ret = !tegra_pm_enter_lp2();
 
-- 
2.24.0

