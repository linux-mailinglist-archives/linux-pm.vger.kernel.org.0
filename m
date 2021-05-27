Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E50D3939C0
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 01:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbhE0X4l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 19:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbhE0X4T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 19:56:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D1BC06134B;
        Thu, 27 May 2021 16:54:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j10so2586856lfb.12;
        Thu, 27 May 2021 16:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ifCod93ETyGPmmfLtl3IBeFp9blcjqCRjZs9HqcoCbk=;
        b=pgFyoNE1WYSeqE7ADCYsMnp+NnKcH9AKaGBAAom5WwFyyhiCjlFACT6wYJtVXD5Jvj
         FnZrn9g5T/ZGcf0Egy0ZyqupoojZnsPNQ6ozwDqTjz2hEs+tbXjA+c21Fl2httGQ+QbC
         40bYXfWZYH+88aWNhkwNI0MRRzqTXoufjRo2EvN+6M0D3rfuu4kZj9PXpaKZ+FtYIHbA
         bwOtN18uRwHoOI4tEiHcjpfP439227LPqtmEL78pOr6Eie7jf7RvNP4YaJs6PeUMTa3u
         gTLdHdyzQmiSqtH9LyTQKTLODClUGRu6dKwD3HJEoX+i+0d7WXtc0KzfxjLqmY5S5ijb
         4qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ifCod93ETyGPmmfLtl3IBeFp9blcjqCRjZs9HqcoCbk=;
        b=LuvtO9rU38q4ZBzPHvnzkEjpMNZuKk59QfPNCdsx0syj5D7yTl0CUCAfstHjCGyY34
         X/E6x0ebjAozR9D+DJtlZCXM87A+NEj5KfjEcn/fmZHelnXHbq861w3AOJ+5a3elNspr
         XgYLf2UjjANZnHamTJqFI4pZe3uDkIu93JBm0L4bLAlWGWXo/eEhQgwheKua9v4pIMLz
         HmTPpTPVgiiJa5LWjFrVQ/EhI0v98OtT9PBinb/c/SFdYzM9JEptwzsVE4VqrVm1UP9b
         p43+HYIZVahBIymXK3gPPjOt/+QgyjH/ztt58OU9Jh7EAGh0HnaZ1x6ESoVHIK4qirv8
         YQWg==
X-Gm-Message-State: AOAM530shZJxad9n2TbFS4Eb4d+QYbGEilmX7Quzr38CMPdfakTJoXtF
        zaQI9L1N48GLdPo5l4hAvM1bBYKXeqA=
X-Google-Smtp-Source: ABdhPJxs8C+O+vfEMywmf/8ZLpCFz9xYLjJCuToxfF5Z0tOwDAYApBBsGcRj2u+VW4GRfm2CcPeAQQ==
X-Received: by 2002:a19:f717:: with SMTP id z23mr3819731lfe.267.1622159671485;
        Thu, 27 May 2021 16:54:31 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id t129sm319000lff.109.2021.05.27.16.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 16:54:31 -0700 (PDT)
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
Subject: [PATCH v5 14/14] soc/tegra: regulators: Support core domain state syncing
Date:   Fri, 28 May 2021 02:54:13 +0300
Message-Id: <20210527235413.23120-15-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527235413.23120-1-digetx@gmail.com>
References: <20210527235413.23120-1-digetx@gmail.com>
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

