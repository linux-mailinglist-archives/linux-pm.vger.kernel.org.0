Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D0038BA41
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 01:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhETXKZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 19:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhETXKQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 May 2021 19:10:16 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8ACC061763;
        Thu, 20 May 2021 16:08:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w15so21770755ljo.10;
        Thu, 20 May 2021 16:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r18WGOYqB7cDcwIrdUZr3c1RtFay90XOWzRkXpzbpZ0=;
        b=kReZqq3TXkPaKnKM975AvfpkDJnQj1GfYVVP52VSnlgykMU5AgD7hicNxaX6UTHj5I
         IOjZ8/7jDCaBCiT5pD5uc7+5ulqJs020y5drqrAy9qHGsxcDi5dJYc6mU/lPAMrb1Aq2
         /1cLGWC+jVL6AQTy0hP3UGUscy55xVmQH9EJMPaNDbPvL5ktcEYJtQGm+YtB31o2ZRPm
         kRra+eghLCI2Fw91fAC6GnuTk+8bVGOF56YtYFFzoSR4vs0Ot6sPl9Mmdhqd+Oqq3mee
         cOr7G7Zdoqoqbg48x1s3MqD/Ocv8qT53nedF94XCHdEsE6hfNzXE6sMT2lw6AmoNnkne
         8TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r18WGOYqB7cDcwIrdUZr3c1RtFay90XOWzRkXpzbpZ0=;
        b=FEfOGLAKbNpHOmSdLK/7Xb7aNx07EZ/7ndB+zzSaUdtBKFbSTFK3obcsbUGvr+SE35
         Asd1kgOImH3A9bCqCIvRTPllGsqvnSkFg+yISIClZFIIl/wQhXS7IFsrsJeBwfe3/ppE
         5zvomG0LtcSs+wdMYabawAIuAWULs1uAUe/XWsI9Q9WrTutpST3yzM/peNK5UgtXk4z5
         4316qy0KL0523anh9GNyZdtGMd7ukKJCFZmbQoKpEm2VaBU3ysknGVad++Lr9LyiXg4P
         4f73o5ju/UfeOmSApaDEHVdq5scB/oKaBwtoq1crl7GbVsCNQVV75fbTXHHaXseqGIso
         Rprg==
X-Gm-Message-State: AOAM533kOK+p/8PCkms9IWQIfpGq1yGXsnj02S45WFcGNav+9BtGaM1b
        IjGNLEpFWh7HrfmoXtALxH4=
X-Google-Smtp-Source: ABdhPJy/cKgMCrnCONNJ8Nkz6EEFUfKHyuZjMVBO2ev1m+omQ/33+E6Mrpgkq9iflL3pXTCSb6m4Cw==
X-Received: by 2002:a2e:2d11:: with SMTP id t17mr4582035ljt.56.1621552132132;
        Thu, 20 May 2021 16:08:52 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-76.dynamic.spd-mgts.ru. [109.252.193.76])
        by smtp.gmail.com with ESMTPSA id 4sm427821lfr.175.2021.05.20.16.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:08:51 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 13/13] soc/tegra: regulators: Support core domain state syncing
Date:   Fri, 21 May 2021 02:07:51 +0300
Message-Id: <20210520230751.26848-14-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520230751.26848-1-digetx@gmail.com>
References: <20210520230751.26848-1-digetx@gmail.com>
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

