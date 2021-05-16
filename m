Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC4338220E
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 01:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhEPXUF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 16 May 2021 19:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbhEPXUD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 May 2021 19:20:03 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C1BC06174A;
        Sun, 16 May 2021 16:18:48 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id f12so5037342ljp.2;
        Sun, 16 May 2021 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7MoZWTsxYKP8N9EirOoHEansF2VtNbae2U8YrYCZA4c=;
        b=iaoYRhSTpxSkFjdqgqwLNNzNFHGKoKXx/73uarAltaBJMtCNuST+Waboo/iU28Kj98
         eo8M42CfHM4wXT5yZokau30HK2iGLHjqrg74zuKxmIawjslauvYvnSgigYQjqfZJHhm7
         chH6mj+Duju2Co2YsNzVQAd00dWzchjU53Vr9m95aVNEc5QN+wK5AeRDU8SS/fjkRd4G
         Y3oPXdj2izpEIlFvYiwANXFFOhxBNjtLq8nlkNhs6TYz736rEk5NtS+st7i0ETFSzPlg
         xfVq+lUR4ZNc1+2sEzN1m9e0d4q262ZjRg26yTpH3sd0z821EnlSMN4rcxeQunzhzx0H
         93HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7MoZWTsxYKP8N9EirOoHEansF2VtNbae2U8YrYCZA4c=;
        b=fjcXhmKIIda+VZ01bh4SLaW4Q22GNHECdwqJjnONTwYksymcIXJLxvcZF/UclYFXop
         r0wPv2zMRS9DxtRTHm7SfdLSzxnSZpx+7evg1DQE2f5gb2QwX/salpdamjzUwrELtn7F
         ce/qef7qHPh6ElDCBIq9J8RYTQuyF0yJ16WFFeB+EBU2QSg+2l6jX7TBgekoSzua4BF5
         lxo0pIg/7zKCwAAq50V5ttmTjDsaelz9zK2Lv6IHiYo6uXKoRZsDt649Qd+oaImMRcaB
         UyToJYpawv4PmcNsfQ/BZWpllUC5iRDPyry3IfR6h3d4mQiJXsPTEn0KDdlXL1gRP0VR
         UJdA==
X-Gm-Message-State: AOAM530OnG3qXHCQGnKIp0e6qU/DyL71wC8hkOYEurIF2WdeLmiva7fy
        DDorZUt+gDTRef9fV657rGA=
X-Google-Smtp-Source: ABdhPJylT9tSaccxDKrhswPj+S60woA/EpQSkV77Ut1zJhJKZnG3lbyFYNmoGj4+Ha5S7cufQU8OzQ==
X-Received: by 2002:a2e:8708:: with SMTP id m8mr12229869lji.383.1621207126849;
        Sun, 16 May 2021 16:18:46 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id p6sm406478lfr.163.2021.05.16.16.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 16:18:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v5 3/3] soc/tegra: regulators: Support Core domain state syncing
Date:   Mon, 17 May 2021 02:17:55 +0300
Message-Id: <20210516231755.24193-4-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210516231755.24193-1-digetx@gmail.com>
References: <20210516231755.24193-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The core voltage shall not drop until state of Core domain is synced,
i.e. all device drivers that use Core domain are loaded and ready.

Support Core domain state syncing. The Core domain driver invokes the
core-regulator voltage syncing once the state of domain is synced, at
this point the Core voltage is allowed to go lower than the level left
after bootloader.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/regulators-tegra20.c | 19 ++++++++++++++++++-
 drivers/soc/tegra/regulators-tegra30.c | 18 +++++++++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/regulators-tegra20.c b/drivers/soc/tegra/regulators-tegra20.c
index 3479be5ee494..81787ae3d03e 100644
--- a/drivers/soc/tegra/regulators-tegra20.c
+++ b/drivers/soc/tegra/regulators-tegra20.c
@@ -17,6 +17,8 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 
+#include <soc/tegra/common.h>
+
 struct tegra_regulator_coupler {
 	struct regulator_coupler coupler;
 	struct regulator_dev *core_rdev;
@@ -42,6 +44,21 @@ static int tegra20_core_limit(struct tegra_regulator_coupler *tegra,
 	int core_cur_uV;
 	int err;
 
+	/*
+	 * Tegra20 SoC has critical DVFS-capable devices that are
+	 * permanently-active or active at a boot time, like EMC
+	 * (DRAM controller) or Display controller for example.
+	 *
+	 * The voltage of a CORE SoC power domain shall not be dropped below
+	 * a minimum level, which is determined by device's clock rate.
+	 * This means that we can't fully allow CORE voltage scaling until
+	 * the state of all DVFS-critical CORE devices is synced.
+	 */
+	if (tegra_soc_core_domain_state_synced() && !tegra->sys_reboot_mode) {
+		pr_info_once("voltage state synced\n");
+		return 0;
+	}
+
 	if (tegra->core_min_uV > 0)
 		return tegra->core_min_uV;
 
@@ -62,7 +79,7 @@ static int tegra20_core_limit(struct tegra_regulator_coupler *tegra,
 	 */
 	tegra->core_min_uV = core_max_uV;
 
-	pr_info("core minimum voltage limited to %duV\n", tegra->core_min_uV);
+	pr_info("core voltage initialized to %duV\n", tegra->core_min_uV);
 
 	return tegra->core_min_uV;
 }
diff --git a/drivers/soc/tegra/regulators-tegra30.c b/drivers/soc/tegra/regulators-tegra30.c
index 6e4f3d9e7be1..e0203f78b396 100644
--- a/drivers/soc/tegra/regulators-tegra30.c
+++ b/drivers/soc/tegra/regulators-tegra30.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 
+#include <soc/tegra/common.h>
 #include <soc/tegra/fuse.h>
 
 struct tegra_regulator_coupler {
@@ -43,6 +44,21 @@ static int tegra30_core_limit(struct tegra_regulator_coupler *tegra,
 	int core_cur_uV;
 	int err;
 
+	/*
+	 * Tegra30 SoC has critical DVFS-capable devices that are
+	 * permanently-active or active at a boot time, like EMC
+	 * (DRAM controller) or Display controller for example.
+	 *
+	 * The voltage of a CORE SoC power domain shall not be dropped below
+	 * a minimum level, which is determined by device's clock rate.
+	 * This means that we can't fully allow CORE voltage scaling until
+	 * the state of all DVFS-critical CORE devices is synced.
+	 */
+	if (tegra_soc_core_domain_state_synced() && !tegra->sys_reboot_mode) {
+		pr_info_once("voltage state synced\n");
+		return 0;
+	}
+
 	if (tegra->core_min_uV > 0)
 		return tegra->core_min_uV;
 
@@ -63,7 +79,7 @@ static int tegra30_core_limit(struct tegra_regulator_coupler *tegra,
 	 */
 	tegra->core_min_uV = core_max_uV;
 
-	pr_info("core minimum voltage limited to %duV\n", tegra->core_min_uV);
+	pr_info("core voltage initialized to %duV\n", tegra->core_min_uV);
 
 	return tegra->core_min_uV;
 }
-- 
2.30.2

