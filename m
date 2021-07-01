Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C898A3B9964
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhGAXcq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhGAXbX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:23 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53158C0613E1;
        Thu,  1 Jul 2021 16:28:48 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id p24so10843305ljj.1;
        Thu, 01 Jul 2021 16:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZAIS0SxnjcMuhoOHE6hmlJInxQtsi1U4QiR0A4EtGs=;
        b=VDH/xQrOx8/VXYTmDKtz/RwrYnmxlkGDB8QetPfkn8ROIpRAI4mkfpuoSWRNuRF7M+
         LWxCDvv7yQTES2Og4gS+1qRhFuAHDPNu+eBN2dIwuWkCOYdnF/DOEmthQaEGcoI7/tSu
         I5Nt4uFDZWPefDKTQgMpBWmBTNyg9LYLD3UvLRp0sJ8AitzbLVQCNM8IzipvCMrC8436
         rSEvW5ltGIHknE7fyy0kEjt9EU7q/EHPQc364W8DmVUQ7EX4fh651NoqqakdBEda0t0Z
         yfZXHRfctv2oMuKZbKlR59wwkB+Oqn4oTSwHchOaqMoFaVso3nf+A9n/cIl6pFiyWMW2
         Yrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZAIS0SxnjcMuhoOHE6hmlJInxQtsi1U4QiR0A4EtGs=;
        b=cn25HhPepGfW15+fNW2g5/jV+v3c8fPJNHFTQP5CQoUZLtP0L1DYz5MSoCelPX+G60
         5lhxeiwgJiXa6Ld1qFtMa6vAUGeo52f1SnKK5nFKWlyvuwcO8OgPe0OJFjY90KdbMuDd
         3bLvTN+X+Otp6/qdb8uBLogphVu1if7hNl4jw/Ff3jr+BvyfvtASKiILWPWfattYYqgh
         pR6azIaiF/JGk7zxb0kDIW+5/AJngVjFD7x4iM5ry0K/3YNEc7YDP0mPmWROGYbrkNem
         v06NLgBXLd9RMdqkuUqoxQYnRH9C2NsxNdh73EO2VtJcUpkwaaYMrEqfnr05QDjM1JHc
         sINg==
X-Gm-Message-State: AOAM532oT8xnMo2z+0t8V34Y+XF3sbqZdcJ4snLz9XIzRL9aeABsdTK7
        zXOwR9iCTRAbnav6jK5CgkApu4dtolU=
X-Google-Smtp-Source: ABdhPJwjfo5zamLKqBGiCvOaPQPrabDEj0zUuu2P4xuLHmcJTf0BQxmrotP+DEcvj7o1ZCyw5kljnQ==
X-Received: by 2002:a05:651c:178b:: with SMTP id bn11mr1466038ljb.43.1625182126752;
        Thu, 01 Jul 2021 16:28:46 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 28/37] memory: tegra20-emc: Add minimal runtime PM support
Date:   Fri,  2 Jul 2021 02:27:19 +0300
Message-Id: <20210701232728.23591-29-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

EMC is always enabled, mark it as enabled. This makes the OPP and GENPD
API usage more consistent since otherwise we're changing performance state
of a power domain for the device that doesn't support power management.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index c3462dbc8c22..22087009fa0c 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
 #include <linux/types.h>
@@ -1028,6 +1029,32 @@ static int tegra_emc_devfreq_init(struct tegra_emc *emc)
 	return 0;
 }
 
+static void devm_tegra_emc_disable_runtime_pm(void *dev)
+{
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+}
+
+static int tegra_emc_init_pm(struct tegra_emc *emc)
+{
+	int err;
+
+	pm_runtime_enable(emc->dev);
+	err = pm_runtime_resume_and_get(emc->dev);
+	if (err) {
+		pm_runtime_disable(emc->dev);
+		return err;
+	}
+
+	err = devm_add_action_or_reset(emc->dev,
+				       devm_tegra_emc_disable_runtime_pm,
+				       emc->dev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct tegra_core_opp_params opp_params = {};
@@ -1076,6 +1103,10 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = tegra_emc_init_pm(emc);
+	if (err)
+		return err;
+
 	opp_params.init_state = true;
 
 	err = devm_tegra_core_dev_init_opp_table(&pdev->dev, &opp_params);
-- 
2.30.2

