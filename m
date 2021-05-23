Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D898338DDE5
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 01:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhEWXPf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 May 2021 19:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbhEWXP3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 May 2021 19:15:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D024FC06134F;
        Sun, 23 May 2021 16:14:00 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j10so37950765lfb.12;
        Sun, 23 May 2021 16:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P0VQM2p2Qvcqr/423qIqrFQYLHKWMV28vrZtWoeSfF8=;
        b=LcqdBmO0sz+xKmjTPTOudVOZkXZAAgo5YomP9q5NNmRLZD2b5MBWsGyIFI/3YCom1G
         fAh9GJ/oIooi4tsUgSC8sUztmZtGKpkwJodcPWwUQpVf9J2O2ARfhJ6ntw0BB3sgOGju
         q0Q6JFZ9W1IlSkrzWBhc8x6StVUWWFsi664dc4wukyYVK3thCyfZJF3xVV12xiAdBdrW
         xgs6jF5M6BC6349ixEYY8TLuh8hAJW6FwwXVUL4neCoj/E+iaSZA1p878lG+sJyb+Vul
         3QXgSA8OuHJTIQEHbzd1uQRSiE9Bqs+SMxa/NH/7aNxNcwnCXjrsiZ/CzzPDBnlSi+XK
         xUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P0VQM2p2Qvcqr/423qIqrFQYLHKWMV28vrZtWoeSfF8=;
        b=I2pUxUg6iZUhqpSY5RBR0koPSxlCdsfSiXSuQUKwB1oso549QwyizeDQqZpTuQ8tK5
         +wg4Nn3k4k+Z5Xtf9mIbd3Grmpc0GyeSuLs/4ly7T7KCad+9l0kv3Jn4DI+QvRrSvEYG
         6qyPbpfDQp5LnCFTwRb9cy8f0VlBZyq4fQXdVdhQD2r3+o1cKAyGkzHqcQuXrPu6BRzy
         wDsDlE0AWKAs0g/WJ+3WGF+7OC3nJFnQF9kDmFGg/E1h9o3Uz6HDaXmbor1m2RI/NvRv
         w7F1gpW4/aCH9KK7VLCi06XnrfVznhDLUTgY8IwvZvW3WJxjqezysl9/mgeLqlKEF0jO
         SacA==
X-Gm-Message-State: AOAM5330et50Ml3sFfLTXKIYRjOv3sVPD7n+pbwDg200PK6DJPx17m9r
        CJ6f95ATFSQ4a2alWaYBWqgxg35BDEs=
X-Google-Smtp-Source: ABdhPJz2i6iQc5gvi3W4R3a3prykZI9EXcEcJepHEWaY4U7LyTLclDEGweDeLzebeAMkoVCJLSDjTg==
X-Received: by 2002:ac2:4e69:: with SMTP id y9mr8713857lfs.593.1621811639246;
        Sun, 23 May 2021 16:13:59 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.gmail.com with ESMTPSA id p7sm1268619lfr.184.2021.05.23.16.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 16:13:59 -0700 (PDT)
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
Subject: [PATCH v2 14/14] soc/tegra: regulators: Support core domain state syncing
Date:   Mon, 24 May 2021 02:13:35 +0300
Message-Id: <20210523231335.8238-15-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210523231335.8238-1-digetx@gmail.com>
References: <20210523231335.8238-1-digetx@gmail.com>
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
index 35335c6a20b8..f79835640005 100644
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

