Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 149A8F820F
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 22:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKKVQg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 16:16:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40810 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfKKVQf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 16:16:35 -0500
Received: by mail-lf1-f66.google.com with SMTP id j26so3900366lfh.7;
        Mon, 11 Nov 2019 13:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dz3WKDPiIUb4/FxW8Zr/Vd4hYvS9IVQYUuzS70hcV3w=;
        b=YmOmNIyxk6fa3FR+bJBtOC8Sjz16iQyf23gob9eQKEjcYDlgLd2YUCE/Y95UqUEAKZ
         seRr5d3RpFQc7dwqiqjMXd7HezMVtyXELRI87ZWjcxUlIVxUK/FLbB6WAMs0GCOcEKV8
         epORhQt+89f+VqPvWSX96LhbJhQUlf8DNQCiCVrXdTIyFdhk93nmYNxiM/9lpJc2hnCl
         htHWD5jPGgNiGWf2sbYyuPYPnEFXPUNeEVw+7bW/ef/bBANkU5HYENFG4BJG7si3dmQs
         XQTIKNGhBpkLrKTmvbLzX3KEPcTFsVqRdZtiUcWndcUTTbOmIrZRFnoSP3W4ksrDogxW
         XRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dz3WKDPiIUb4/FxW8Zr/Vd4hYvS9IVQYUuzS70hcV3w=;
        b=Er3zcbiTc9Hmz610A4hAK0cIWYmDacS9e6BgfaMmcOgKPsSx6cM6fMydYyCPLNlzMm
         UT+lBoz9ghBhfoV8A7sZRbDxE0UxynCYopGfatXjEMWp4YzPJa4fNUmXYhRbxejKbBl1
         3CAVvJOEK7sfygE3+YsOixSdr2PSQoVH9tN1S1VnbKhjohI1GzHajCwnDPRyiMO7srGF
         SSVdVzgdbFYqrPIIJTh8Tf0Aw5VULnHBs9DhN1XkEFCvwic5iTILlHX+phbsf2ny9s1D
         /gDsTB5NdeGJoA5sQ6UptbbBSm+RZGgw9QTGbOsxBcdzGXnri+zyV7J4GKZWMPxZ/OQJ
         g+FA==
X-Gm-Message-State: APjAAAWalkIk0pfTJg6vkeCZmjSlWOpU74zik2fw9wh8yiS8/d4cip6+
        aw5O5i7MCk6FMi1h4ur81BY=
X-Google-Smtp-Source: APXvYqxSn9kLZp80cUq8VEkHOhdk48YoinPcj/EHX/2hsxmF+/NPkNi3Hr/1LeSwaGFYylfNRrQ9sw==
X-Received: by 2002:a19:3f07:: with SMTP id m7mr13675193lfa.136.1573506993477;
        Mon, 11 Nov 2019 13:16:33 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id n19sm7913150lfl.85.2019.11.11.13.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:16:33 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 09/17] arm: tegra20: cpuidle: Handle case where secondary CPU hangs on entering LP2
Date:   Tue, 12 Nov 2019 00:15:48 +0300
Message-Id: <20191111211556.20723-10-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111211556.20723-1-digetx@gmail.com>
References: <20191111211556.20723-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is possible that something may go wrong with the secondary CPU, in that
case it is much nicer to get a dump of the flow-controller state before
hanging machine.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 46 +++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 77702dd42479..bc5873e92af5 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -83,14 +83,56 @@ static inline void tegra20_wake_cpu1_from_reset(void)
 }
 #endif
 
+static void tegra20_report_cpus_state(void)
+{
+	unsigned int cpu, lcpu;
+
+	pr_err("secondary CPU taking too long to park\n");
+
+	for_each_cpu(lcpu, cpu_possible_mask) {
+		cpu = cpu_logical_map(lcpu);
+
+		pr_err("cpu%u: online=%d flowctrl_csr=0x%08x\n",
+		       cpu, cpu_online(lcpu), flowctrl_read_cpu_csr(cpu));
+	}
+}
+
+static int tegra20_wait_for_secondary_cpu_parking(void)
+{
+	unsigned int retries = 3;
+
+	while (retries--) {
+		ktime_t timeout = ktime_add_ms(ktime_get(), 500);
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
+		} while (ktime_before(ktime_get(), timeout));
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
2.23.0

