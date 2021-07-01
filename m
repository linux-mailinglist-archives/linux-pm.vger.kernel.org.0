Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F533B9948
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhGAXbc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbhGAXbX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F58C0613E2;
        Thu,  1 Jul 2021 16:28:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bq39so2194432lfb.12;
        Thu, 01 Jul 2021 16:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KyIQJzt+L239PH+/PBuXpVCTrsrorBZHkbrJ2DC11Bs=;
        b=TgVzx5ofQ3LVrFUHA5V/lEj3SJBgybNh5lgvl1R7otz5TtkSFPnH2T6s8y0pwcGQn8
         kwlQQbb1oNQKEqSBtVtpoj+2SZ3UTWLce8yir66nMvMijPOGA70PbIXadTWwae5tkdHs
         wvpMier7k6/4trtTdsLdamqlaemS/akmt0uYG/zxmOIcruK7+nOItGFxfRPmRuuq9tKM
         E0LPbOtVwG0Ulf861spkGo2nY7bxC+4hS30wyrVRac5BMVR9psWf1PFq1qV46ilv4D8A
         b/eeNS0Fec02eOoT73qNT0yhOQKlOae4ge6VpPH1sexnjXQiu1gQ8iyzABs0mgkdI0VG
         v/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KyIQJzt+L239PH+/PBuXpVCTrsrorBZHkbrJ2DC11Bs=;
        b=qLXr0bEOCR7teyoB/j9BKK62IDGj5cjxyN6rnYitXn7AyvTwKpiIOi4JdgD9aBiiu5
         9Z0G+kPmXxy1GxEaQ/E/YIkMwwHuZxi7CccC3dkVKfHwinOBLtwwS0FKVSeycrG1WrKY
         WuiRbWXOoAUC0IMnJkePgl1fszs6B8xH1ZeW+GQi80MP9/UwGxsWZRu3F+G2GN1fnFND
         dQvYJ34hxnC3uNoYzlHkiXW8PNNispLnZWMrGqRPh6gh0N/enHlvG4DWvDH1DYA0yO9r
         drMBZ+X0OPLtt6c4Ht77wQFchyEHV7Ecg7Kvo58oIr9oNrwuOxL7cg7eI1oYNNVK8w6E
         pQEQ==
X-Gm-Message-State: AOAM531+P4HhaAcD/pYK4O/kXdNpc8RBEApUPIgMrf8gUwS4RFHnap1F
        0Usk1OT+8+TrDmfdpxdXAPM=
X-Google-Smtp-Source: ABdhPJzPP9t2Y46nyFTK4GJmvb7XkpigqoSIFUU5exwiWUCuPdPcqZww0u55aQ3Bzs3plH5Vb0gr9g==
X-Received: by 2002:ac2:4ed9:: with SMTP id p25mr1484210lfr.576.1625182127344;
        Thu, 01 Jul 2021 16:28:47 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 29/37] memory: tegra30-emc: Add minimal runtime PM support
Date:   Fri,  2 Jul 2021 02:27:20 +0300
Message-Id: <20210701232728.23591-30-digetx@gmail.com>
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
 drivers/memory/tegra/tegra30-emc.c | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 7e21a852f2e1..5a311feb5c20 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -24,6 +24,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
 #include <linux/types.h>
@@ -1519,6 +1520,32 @@ static int tegra_emc_init_clk(struct tegra_emc *emc)
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
@@ -1571,6 +1598,10 @@ static int tegra_emc_probe(struct platform_device *pdev)
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

