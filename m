Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646963CCADC
	for <lists+linux-pm@lfdr.de>; Sun, 18 Jul 2021 23:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhGRVbH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Jul 2021 17:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhGRVbG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Jul 2021 17:31:06 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B20C061764;
        Sun, 18 Jul 2021 14:28:07 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id d17so2897620ljq.12;
        Sun, 18 Jul 2021 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tMyH5mYRtff0c/S0OdvmMRx/giOjZ5YO7NbCgFXE6qU=;
        b=QX9pvz2HhICPsgAtVQ4i4nImjxafpG2eaLSblo+oWouIaK3LAVXI49os1PpoEQHdwi
         y15vYm4S/9bFV1vkgdFWgpjKC2Vor+v/wbAxJJAJdRsQGdXV3OU9xcMbEDzh5tfLNXQO
         OxdQ6ctXtBrYj47WvbktKjUf1Wzt9ckvHv0iVcBhfVlZCN7yIw4021fFnxSUYnkn8FZp
         IQPm9WhGwSgkOGpVDs4emK8WQYWOmQnqFrsuRZm+8D38giNgPs6kZjJbW72eCDXIrbSy
         XbqXYifcucwMf6f7Ayy7s/PB+cIK1TELIOIWzAJqMnjnuoR96oAPvGRaruah2H4jMyo5
         EPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tMyH5mYRtff0c/S0OdvmMRx/giOjZ5YO7NbCgFXE6qU=;
        b=rEVVKD8+efSBMZZxQ9rM2giEMQxxLfvJPEKClFQX3b92kW7IX9XyfKex1tqaBHsF98
         5G9zRchu/B4cn9RNZ5FPkQf9+mUNgGIYH+NbYhA7eWzUpbxuOjzLLiTsD9DF07PI6x4d
         Ec+k21MegQAv0q1RV41VgcxVPHct7GovGHxpRqSBqCv7W3noKfPaI4wJbAP3trgfm/Px
         BYE0xD6+y16rHhImzPA1FUPG1VkPgb9Ywvl/67QA2LwqUx7TPAnp2pX7b/VOfCyXX1bo
         88kFYeF/bt6E7F1uSsDdbasVawVNbPFCfEaYXY3p0e0APJnQWVssW4De3N9xXRPMvqsR
         ZOEw==
X-Gm-Message-State: AOAM532cfx0to9/vDi5a4UUONIfUnROOBO2/Y0pHrsrJD8WX7vuRbh6G
        uuWvIS4z0Am3fXTalWrsMoQ=
X-Google-Smtp-Source: ABdhPJxBWUDGZXhFxf+tjOmTXv+fBX5QSlobYLQT1ZEOgi2Dx2XvArZlU/MgG4FvErY8VtwBligTug==
X-Received: by 2002:a2e:7a18:: with SMTP id v24mr6828818ljc.420.1626643686301;
        Sun, 18 Jul 2021 14:28:06 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-53.dynamic.spd-mgts.ru. [46.138.17.53])
        by smtp.gmail.com with ESMTPSA id c10sm1229062lfv.10.2021.07.18.14.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 14:28:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] soc/tegra: pmc: Prevent racing with cpuilde driver
Date:   Mon, 19 Jul 2021 00:27:05 +0300
Message-Id: <20210718212706.21659-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210718212706.21659-1-digetx@gmail.com>
References: <20210718212706.21659-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Both PMC and cpuidle drivers are probed at the same init level and
cpuidle depends on the PMC suspend mode. Add new default suspend mode
that indicates whether PMC driver has been probed and reset the mode in
a case of deferred probe of the PMC driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c    |  2 +-
 arch/arm/mach-tegra/pm.h    |  6 ------
 arch/arm/mach-tegra/tegra.c |  2 --
 drivers/soc/tegra/pmc.c     | 14 +++++++++++++-
 include/soc/tegra/pm.h      |  6 ++++++
 5 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 6452ebf68d40..b21f51b8e19e 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -403,7 +403,7 @@ static const struct platform_suspend_ops tegra_suspend_ops = {
 	.enter		= tegra_suspend_enter,
 };
 
-void __init tegra_init_suspend(void)
+void tegra_pm_init_suspend(void)
 {
 	enum tegra_suspend_mode mode = tegra_pmc_get_suspend_mode();
 
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 81525f5f4a44..e63f96de2825 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -25,10 +25,4 @@ void tegra30_sleep_core_init(void);
 
 extern void (*tegra_tear_down_cpu)(void);
 
-#ifdef CONFIG_PM_SLEEP
-void tegra_init_suspend(void);
-#else
-static inline void tegra_init_suspend(void) {}
-#endif
-
 #endif /* _MACH_TEGRA_PM_H_ */
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index c011359bcdb4..ab5008f35803 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -84,8 +84,6 @@ static void __init tegra_dt_init(void)
 
 static void __init tegra_dt_init_late(void)
 {
-	tegra_init_suspend();
-
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
 	    of_machine_is_compatible("compal,paz00"))
 		tegra_paz00_wifikill_init();
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index ea62f84d1c8b..50091c4ec948 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -436,7 +436,7 @@ struct tegra_pmc {
 
 static struct tegra_pmc *pmc = &(struct tegra_pmc) {
 	.base = NULL,
-	.suspend_mode = TEGRA_SUSPEND_NONE,
+	.suspend_mode = TEGRA_SUSPEND_NOT_READY,
 };
 
 static inline struct tegra_powergate *
@@ -1812,6 +1812,7 @@ static int tegra_pmc_parse_dt(struct tegra_pmc *pmc, struct device_node *np)
 	u32 value, values[2];
 
 	if (of_property_read_u32(np, "nvidia,suspend-mode", &value)) {
+		pmc->suspend_mode = TEGRA_SUSPEND_NONE;
 	} else {
 		switch (value) {
 		case 0:
@@ -2785,6 +2786,11 @@ static int tegra_pmc_regmap_init(struct tegra_pmc *pmc)
 	return 0;
 }
 
+static void tegra_pmc_reset_suspend_mode(void *data)
+{
+	pmc->suspend_mode = TEGRA_SUSPEND_NOT_READY;
+}
+
 static int tegra_pmc_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
@@ -2803,6 +2809,11 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
+	err = devm_add_action_or_reset(&pdev->dev, tegra_pmc_reset_suspend_mode,
+				       NULL);
+	if (err)
+		return err;
+
 	/* take over the memory region from the early initialization */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
@@ -2909,6 +2920,7 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 
 	tegra_pmc_clock_register(pmc, pdev->dev.of_node);
 	platform_set_drvdata(pdev, pmc);
+	tegra_pm_init_suspend();
 
 	return 0;
 
diff --git a/include/soc/tegra/pm.h b/include/soc/tegra/pm.h
index 08477d7bfab9..433878927026 100644
--- a/include/soc/tegra/pm.h
+++ b/include/soc/tegra/pm.h
@@ -14,6 +14,7 @@ enum tegra_suspend_mode {
 	TEGRA_SUSPEND_LP1, /* CPU voltage off, DRAM self-refresh */
 	TEGRA_SUSPEND_LP0, /* CPU + core voltage off, DRAM self-refresh */
 	TEGRA_MAX_SUSPEND_MODE,
+	TEGRA_SUSPEND_NOT_READY,
 };
 
 #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
@@ -28,6 +29,7 @@ void tegra_pm_clear_cpu_in_lp2(void);
 void tegra_pm_set_cpu_in_lp2(void);
 int tegra_pm_enter_lp2(void);
 int tegra_pm_park_secondary_cpu(unsigned long cpu);
+void tegra_pm_init_suspend(void);
 #else
 static inline enum tegra_suspend_mode
 tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode)
@@ -61,6 +63,10 @@ static inline int tegra_pm_park_secondary_cpu(unsigned long cpu)
 {
 	return -ENOTSUPP;
 }
+
+static inline void tegra_pm_init_suspend(void)
+{
+}
 #endif /* CONFIG_PM_SLEEP */
 
 #endif /* __SOC_TEGRA_PM_H__ */
-- 
2.32.0

