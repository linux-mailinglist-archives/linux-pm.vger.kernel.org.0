Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA6396B5A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 04:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhFACf3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 22:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbhFACfV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:35:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BEAC061343;
        Mon, 31 May 2021 19:33:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f30so19427845lfj.1;
        Mon, 31 May 2021 19:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ifCod93ETyGPmmfLtl3IBeFp9blcjqCRjZs9HqcoCbk=;
        b=jyWfwXev/lZr0BiRPXplt+43PVtK73nJHD4RK3QplVGHJt7wRk5BBkq/GbajXzqRSA
         f4HvfIL1GJJg0hdSGbOnX1wQum0RnJDz/8h8pFcAO90VJfC092xvIQAg9t9e8GR3PFTW
         GoEopy9gP0YbOCHE2VhjTaeHWg9W4zcu/xJjc1KFCl2bun60yyw5A8vzLFhBUMhGsRPU
         jln4hITZlO5dwnUbhE4+6SpUbUROqqqtRkdmjTRWxsKeY0Nvoh4PQLXAfednAPl1lhbg
         XkY9hAjDIPeA5VbSx1ZvBkQ4WCBZSHiWl20sAInsvSJZfVA9uVrcnNPl8SfeCFnTwPQ5
         wQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ifCod93ETyGPmmfLtl3IBeFp9blcjqCRjZs9HqcoCbk=;
        b=AKv+Lkq3PxYHYTTZwkfHcSKsoRYjDg25YelmM5HyLctnf41+JhXv1z4xSLzSY6/++U
         l74BuQRMl43n1Vmj7VE/NbokM2sKal9vKC9IxLggOCx9I6pXMSyAgt9Tnze8APixFYLc
         5mBKKdK1ma0Yop9qldz070+jJ0QjTJ8lU8X2qnqnQlII9b2vsebGKPKsdo7jmF6cbPxn
         PIac5AFKrMxgtUnRNyl01GvYOMM3JeJCaHk0ty9JEHBq0x60xUDV9j4qCVmlIjlUGeQB
         NJzZS48B1UjKLyTTyhAWut7B2NF9sb7tifG4a+4S2MqAEoSLAERJQEXfj+pd3aO4+fLw
         tdWQ==
X-Gm-Message-State: AOAM53086+i5v6Ldq235ChBMeMsBXhmawsmqurVc5GCIckghVQAEq3gQ
        vquz8UqQ8deztMRj0OuN50g=
X-Google-Smtp-Source: ABdhPJz797kSm4ba5dOMfQhPy170sdGXAh6lnUBCQf3af4Xp/7RnHC1Uhkxp2TQNM6HLEO54uuMtVw==
X-Received: by 2002:ac2:5979:: with SMTP id h25mr16622013lfp.497.1622514817489;
        Mon, 31 May 2021 19:33:37 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id l21sm107848lfc.28.2021.05.31.19.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:33:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?q?Nikola=20Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v6 14/14] soc/tegra: regulators: Support core domain state syncing
Date:   Tue,  1 Jun 2021 05:31:19 +0300
Message-Id: <20210601023119.22044-15-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601023119.22044-1-digetx@gmail.com>
References: <20210601023119.22044-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The core voltage shall not drop until state of core domain is synced,
i.e. all device drivers that use core domain are loaded and ready.

Support core domain state syncing. The core domain driver invokes the
core-regulator voltage syncing once the state of domain is synced, at
this point the core voltage is allowed to go lower than the level left
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
index 3479be5ee494..b8ce9fd0650d 100644
--- a/drivers/soc/tegra/regulators-tegra20.c
+++ b/drivers/soc/tegra/regulators-tegra20.c
@@ -17,6 +17,8 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 
+#include <soc/tegra/pmc.h>
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
+	if (tegra_pmc_core_domain_state_synced() && !tegra->sys_reboot_mode) {
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
index 18fe53d0a870..e74bbc9c7859 100644
--- a/drivers/soc/tegra/regulators-tegra30.c
+++ b/drivers/soc/tegra/regulators-tegra30.c
@@ -18,6 +18,7 @@
 #include <linux/regulator/machine.h>
 
 #include <soc/tegra/fuse.h>
+#include <soc/tegra/pmc.h>
 
 struct tegra_regulator_coupler {
 	struct regulator_coupler coupler;
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
+	if (tegra_pmc_core_domain_state_synced() && !tegra->sys_reboot_mode) {
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

