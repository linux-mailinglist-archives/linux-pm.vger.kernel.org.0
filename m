Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6469033813C
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 00:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCKXPg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 18:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhCKXPb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 18:15:31 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDA9C061574;
        Thu, 11 Mar 2021 15:15:30 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j2so3761130wrx.9;
        Thu, 11 Mar 2021 15:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/cs0cNSjfmc/2lc6bUnEBoVh2012qFAEKZG9xKVF14o=;
        b=M/Z84Nww0TQawWyCb54acxMQofcEEkcoP+oYWhytiFpTcUW3S/bmVrAE7TlIS6ds+m
         2ZmhZAwO5hey9UMtKgjPFlD6tl/nhmx3goDjgPuiw7bgAAC/OPUmIj0x70CeHmTSi84V
         Ee8gFZuP7jBW8B/dbczyNUU2yL2i6ieEVFreGlIPuDVXhFt5UrFdodvgI066tTsmImhF
         00wq1D54ZOyPlQpymnOUbmGiO4DpAuRSyNaAtLq1oG+x8E/hXCHNWJBN6saTk259l1yZ
         i8F+YoHJqYfUHdO8LxIKCbNtbwKExanLUYuwlLLvH/ojPsqfszSukQBUw7EBqPZ+BGSW
         gzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/cs0cNSjfmc/2lc6bUnEBoVh2012qFAEKZG9xKVF14o=;
        b=POlkj0M0IqjIlnDwHA4rXbMyUpi58sgLa3zroV7LqwMs8pAmmf900LhnRbwaxAg3kp
         MgaGfD3OunSKRFQxL6NQq44NpDnjFPyfRSK+37XiWdKtE2N33P1FrClGhewrmrGstlTG
         6jDRxbgHTHAjbvZml6HZlDlqEn3NskPpW2+fZDFo1dfSkhpaw/L2GI4llCzDfhsZ5Nwg
         z0hXVQjmsva4Wqyv4VDOUUvtg5TETrQoQGOh5WvfWK5u+QXIip2oAX8tItKqXe1Jyojl
         IPARGu6pjx+nVBI8jsCNY3+R4HBukn1vzC8rM+065q+duAROZ3/QCMYzTmqnbdtfTa4D
         sBWQ==
X-Gm-Message-State: AOAM5338Bpdwg3x3r71NbnMlEvDFeYCefXX0bgCVa9bREDRYfyXQ/rHN
        4rOafWQ7id2CBhvFsVmI/Ecmjfh3p24=
X-Google-Smtp-Source: ABdhPJwqhHjaNF60uJGOenxW5a5MwPDquiEd1b/c1WdZ6vqabTRkjAF+OkpaLTun8PG9HkYmIBiaHA==
X-Received: by 2002:a5d:4341:: with SMTP id u1mr11187812wrr.88.1615504529619;
        Thu, 11 Mar 2021 15:15:29 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id j203sm263918wmj.40.2021.03.11.15.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 15:15:29 -0800 (PST)
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
Subject: [PATCH v3 5/6] soc/tegra: regulators: Support Core domain state syncing
Date:   Fri, 12 Mar 2021 02:12:07 +0300
Message-Id: <20210311231208.18180-6-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311231208.18180-1-digetx@gmail.com>
References: <20210311231208.18180-1-digetx@gmail.com>
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
2.29.2

