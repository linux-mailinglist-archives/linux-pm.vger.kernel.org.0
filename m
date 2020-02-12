Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 090A315B550
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgBLXwV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:52:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41706 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgBLXwV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:52:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so4430162ljc.8;
        Wed, 12 Feb 2020 15:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P85n51a0RBVxAMi5sGqF85UkwlVfbar5qjBQfMRzeKU=;
        b=nzXaT4dzfAgiQKy5Hd01UJteDiS1LiO7zNzf0SP6B1ymnqFrRD+onbnr/tlEelgJnF
         KSjIzyT+VZdHXQW2TJmLdmBvehq/n8uI/AcBZbMIWU1g9Q1EyjwxdLiRZVUPF8TMfRbO
         XTDnQn6SIKamTeQ8TX/iCxWRfB/cToDnwc0lW3QhJz5+fXV5ASHx9p7r4h7mmXhOJpBe
         ip4YvamK0p/7Qd94jmzhRHPSFD0s1Xuo43nxcDha4O/kX9deQ9tPYtDR/f6bvvSYGHbw
         NnQf67ozJ/NDV5LciDfg7h8+m81fuGi51EXMDF2R13hfiAq5w6kEYS9nYWP6bVJdBo4l
         z5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P85n51a0RBVxAMi5sGqF85UkwlVfbar5qjBQfMRzeKU=;
        b=Du2uPIdt8+fNDochtKD/koDinDH3j1U+Zw8wvSori+LCPqtaPcMsLTZLYgSGBv3kbs
         Ws8GZAIBFp4R+MmVESGjW2reJhF09gh+KYcVWUeuXdUGRTsf0vR7HGkjidQAV2tE6Dw8
         ZYFFWFz2qT59oucszzxmeIU6RhFtvZdunbKvndxpghsY0Vd7tKhWrvGiyo1hGVai57g8
         SWuMTvYR2m687gg2b4NEspkJBFxUjEYRxMgRYCprLJkvTCSrbsDfedIpYv+wjXBCbDQl
         DegMy/jkk+73nqg6FcEHM0Ob3nufGCDMr5AN4Gvk/HrgQDzhH5LAFL4GMls2dIbExo+X
         yCVA==
X-Gm-Message-State: APjAAAUT4wZx8ewRcEKiOk2CVn1ra/Z8udxxBjXB4AyeMY3wGYsZOYOb
        RF+rUy3MCRyFawUJBUrmU4E=
X-Google-Smtp-Source: APXvYqxgblEqBB3WbawetVv2cbtsEoQAAzyB3qrCoBRbEFe6d/63ODv2PlksKH1ZVsTov/Ki+wIb5w==
X-Received: by 2002:a2e:b0f5:: with SMTP id h21mr9619821ljl.9.1581551538778;
        Wed, 12 Feb 2020 15:52:18 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d5sm251686lfb.20.2020.02.12.15.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:52:18 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 09/17] arm: tegra20: cpuidle: Handle case where secondary CPU hangs on entering LP2
Date:   Thu, 13 Feb 2020 02:51:26 +0300
Message-Id: <20200212235134.12638-10-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212235134.12638-1-digetx@gmail.com>
References: <20200212235134.12638-1-digetx@gmail.com>
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
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 47 +++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 9672c619f4bc..bcc158b72e67 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -83,14 +83,57 @@ static inline void tegra20_wake_cpu1_from_reset(void)
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

