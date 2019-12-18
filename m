Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD1112543C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 22:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLRVGv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 16:06:51 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33010 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfLRVGv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 16:06:51 -0500
Received: by mail-lf1-f68.google.com with SMTP id n25so2744502lfl.0;
        Wed, 18 Dec 2019 13:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hib42aIHxrfB6sXFxEWLAXejr3s2jsMxqrnHovG8wow=;
        b=Q486js/hrANA53FWo18EGWBKHcSHx5GJbmndmZcaKAopl8fAbACSPx0PsM/8YZ/vyt
         DIcRsWxv8QzaFRBhKch3s64K86M6uyUnNmk+mleRbkMNWnO0Xn5flXXufv3arGz2NuCp
         p6NEjKyUvrf0FzNK608XJ6JR5jeIDu5WObrkwC/KsqAFcuZGTAKgo0MCvmSvZV96z0HI
         BxQutDORcJFFRS5NTw+1RUFoAsDWXjUJDiBbRZTOUoHstJO31l4PtguTLqXewN+4DZDJ
         +HCywzcR/fWpb+R0d+KEjSxgi6ZBtJEGbekA8nuAmk+re3n/AQw91kCAH+p/H4DWvNt6
         iqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hib42aIHxrfB6sXFxEWLAXejr3s2jsMxqrnHovG8wow=;
        b=d5r8m7p0MA+Zv3tohzmZ339P8zcRSs5sUGkgjgahq8vTzNuIp4K6TbbCRlMTrT2raQ
         F49q9va3W62U75kpXvhTfSb5juT5rJlhzqbmlLxqFQ+HAibFENLkIPqa0TuIf46pBeQy
         YgFuiuf5DIpEh4gAMHdDGKFcb2dN5xsYEr9I+AmyyK3XOI8JdWUapySWXa1F+aUiUzsz
         kl69S6hGHyD5rWtrIzgc2ro4CZsfVVCfzf7CRk691Dn7VjkaKzJQezKFDvLEqBOG++MA
         duLlbhhazpHGYaUcRr7X2T4Dej9bLQ2ckvsUBnuGIhXgTk2hAP9RpZ4tdi+v49K7/PRx
         XAXQ==
X-Gm-Message-State: APjAAAV4yP9B54z9GbxD/78ShJvC+UCoGRvom3cCanRQ71PS3qh9czKI
        j88tnW0hTWQPRLC9X2p9FQc=
X-Google-Smtp-Source: APXvYqy4sH6ZfMpy5YcNHCvoNmhdpQPpQUkjgd6MHNnEdy4LjgUJhEqk+3eGFJMo9b7cXkf2iqTuxQ==
X-Received: by 2002:ac2:44a3:: with SMTP id c3mr3081101lfm.1.1576703209268;
        Wed, 18 Dec 2019 13:06:49 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r15sm1754648ljk.3.2019.12.18.13.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:06:48 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 09/17] arm: tegra20: cpuidle: Handle case where secondary CPU hangs on entering LP2
Date:   Thu, 19 Dec 2019 00:04:55 +0300
Message-Id: <20191218210503.6689-10-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218210503.6689-1-digetx@gmail.com>
References: <20191218210503.6689-1-digetx@gmail.com>
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

