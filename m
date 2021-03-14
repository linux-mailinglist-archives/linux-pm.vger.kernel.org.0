Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31BD33A6E8
	for <lists+linux-pm@lfdr.de>; Sun, 14 Mar 2021 17:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhCNQso (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 12:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbhCNQsX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Mar 2021 12:48:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AA4C061762;
        Sun, 14 Mar 2021 09:48:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u10so1954802lju.7;
        Sun, 14 Mar 2021 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xTy/GGIajonMXWHNfg36F6Qqn70V++vkwVcOw97d2UU=;
        b=BZm8eLcBtnj4MvvHDtN4D4zJFzo2/6jN03XxTUSlF+PH7VTGnBAxge2qBOh9q++Ho7
         OhUfZPP2PL+dDW4jJR1dU+sLntaGFW4GRWUoXFJ3wHiSQ+JtnvCggpW9VEEW4FhY92u+
         uTydHf8Tr3x3CFAB4mMzHyj9R58nx0A4WpGp08DT16MqqpQwdedOynfQslCrBW2QsIou
         QlVyVygs6SRSek1IQLgbz7C+EGwJBLzwHhJchDtV8nf8nxSkHpYLrw+xFN/d1UUaPzXz
         WdYiIJFyVZjxSmkMkixZPPV94WkO/AYB4LXJez1I/dPvXOl/3cqwueURtnFaGx+7uPux
         0OJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xTy/GGIajonMXWHNfg36F6Qqn70V++vkwVcOw97d2UU=;
        b=qYLzXLGpabeJBLtDYSKooWVRMiNjZlmgQ1/CVF0jWZgoJKG54ZayYEJ+oBbW0srT3R
         hDGkQDXIsd+YwYaHXURtFtioRnJB1c/blzqcsJjd/iMpAbQ3daq00ZwQttIO1IX+1ErL
         tqEwuDKt42m3a+Vo2JhF3HHtm3VLAgZp//0Os7n3eCMwzS7OKf7wrKB/cV/nsT445kce
         H6b1ERxK4Edmt0JKlR6IwEiD2rtvMq3PNMHee8imR0x5UgzKwqI8FZnoRDbwPvhIDVs0
         k0V/J8YPFqEmmbpngV3X0Vy43/QWzEpLFpwE42SGXp+D0zIYDl0IJvhMcb9NfUahBJx5
         qsbQ==
X-Gm-Message-State: AOAM532bK76A2hLfKEAmXok059d1rMhq9Cp6RtG4bPEAbroHM5RoeWnc
        PzPyUaS878p8kJO62c9bfx4=
X-Google-Smtp-Source: ABdhPJyXGIaxf5KHupbB9RxT9BIx5x4y3LJvN8aJzVCzaHF2SATwMFT9rsjyClIytVxf9oKAXrenYQ==
X-Received: by 2002:a2e:b8c3:: with SMTP id s3mr8065429ljp.264.1615740501572;
        Sun, 14 Mar 2021 09:48:21 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id a3sm2387993lfr.55.2021.03.14.09.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:48:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Fertser <fercerpav@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] soc/tegra: regulators: Support Core domain state syncing
Date:   Sun, 14 Mar 2021 19:48:09 +0300
Message-Id: <20210314164810.26317-6-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314164810.26317-1-digetx@gmail.com>
References: <20210314164810.26317-1-digetx@gmail.com>
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
index 367a71a3cd10..e2c11d442591 100644
--- a/drivers/soc/tegra/regulators-tegra20.c
+++ b/drivers/soc/tegra/regulators-tegra20.c
@@ -16,6 +16,8 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 
+#include <soc/tegra/common.h>
+
 struct tegra_regulator_coupler {
 	struct regulator_coupler coupler;
 	struct regulator_dev *core_rdev;
@@ -38,6 +40,21 @@ static int tegra20_core_limit(struct tegra_regulator_coupler *tegra,
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
+	if (tegra_soc_core_domain_state_synced()) {
+		pr_info_once("voltage state synced\n");
+		return 0;
+	}
+
 	if (tegra->core_min_uV > 0)
 		return tegra->core_min_uV;
 
@@ -58,7 +75,7 @@ static int tegra20_core_limit(struct tegra_regulator_coupler *tegra,
 	 */
 	tegra->core_min_uV = core_max_uV;
 
-	pr_info("core minimum voltage limited to %duV\n", tegra->core_min_uV);
+	pr_info("core voltage initialized to %duV\n", tegra->core_min_uV);
 
 	return tegra->core_min_uV;
 }
diff --git a/drivers/soc/tegra/regulators-tegra30.c b/drivers/soc/tegra/regulators-tegra30.c
index 0e776b20f625..42d675b79fa3 100644
--- a/drivers/soc/tegra/regulators-tegra30.c
+++ b/drivers/soc/tegra/regulators-tegra30.c
@@ -16,6 +16,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 
+#include <soc/tegra/common.h>
 #include <soc/tegra/fuse.h>
 
 struct tegra_regulator_coupler {
@@ -39,6 +40,21 @@ static int tegra30_core_limit(struct tegra_regulator_coupler *tegra,
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
+	if (tegra_soc_core_domain_state_synced()) {
+		pr_info_once("voltage state synced\n");
+		return 0;
+	}
+
 	if (tegra->core_min_uV > 0)
 		return tegra->core_min_uV;
 
@@ -59,7 +75,7 @@ static int tegra30_core_limit(struct tegra_regulator_coupler *tegra,
 	 */
 	tegra->core_min_uV = core_max_uV;
 
-	pr_info("core minimum voltage limited to %duV\n", tegra->core_min_uV);
+	pr_info("core voltage initialized to %duV\n", tegra->core_min_uV);
 
 	return tegra->core_min_uV;
 }
-- 
2.30.2

