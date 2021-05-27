Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4F8393851
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 23:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbhE0Vpu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 17:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbhE0Vpk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 17:45:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71340C061761;
        Thu, 27 May 2021 14:44:05 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e17so2279999lfb.2;
        Thu, 27 May 2021 14:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+VpkeiCREzCB6f6A6h2ui2qcNPLr5jeX29c4cdIlp8=;
        b=SpeUd26EXkNhQRusU3huZ0xPKo00zuhrBfvkeJeacqB8L2LDtRbhKNq9qtObLP1+Gs
         yi5OSZQ1siqo4kkfrg4mByS0MJG6KogA4cItN88ocvuLYL7p3JPD1HoM5VCbAaGVjQHY
         vHbMPtDZsKqAji87ebMK8jnBEoB8zcL2PxTB6Y3WbJWuuhEP24uLnUIzKuDW1GGfJV6e
         dRebHhJsQ6nNL1996ba+LPvlI0xdPXMC9B+eus+CXT5Qavg+EeG6NAqezxkqIdfwZWM6
         l1OLVu8ckX4EugadjC5s1KFrxrBRZ/X4epAUkG3BWHrpGN1+IrxxQjIMY9NJ5+LDD5GY
         y2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+VpkeiCREzCB6f6A6h2ui2qcNPLr5jeX29c4cdIlp8=;
        b=XtFeESONBQ8SKlOEydnKf5QJvmMukLd6xjqwHLF5ahIARQ+HraTANfo6XPjf0Y8n07
         2DQm2kSkqjvwxQc3a+fS3HXz4zL8xisA1SA9m4b9LMvbvYqPnczRj/IOPa5oQU/BuZhZ
         z5mfLQ8fVKavBRTA7HqPYsKHat1selrBV4JWPMIPpPUNCyFLqEKZaDA7PPQHhHGyfa5F
         hHDkcMT5RdNE9hJRI3160hXls5oXmZPXznWxCDMHv3fc7aPqGk4JP5phylGh4MI+kBRB
         CjnqX4xniwy1aIn8FKTr+TtCguHHqoaaxLkrIMiQGkqgr83jr5F4I8wTvqHbXkKjShHK
         SD+g==
X-Gm-Message-State: AOAM5314A9oowpjN/EQPT8DSeegQLIY5lQiuwO0yfgoYxBn2gqfyPcWt
        zNtZ2DzVcNWbLQPcDfv+sDQ=
X-Google-Smtp-Source: ABdhPJz6zfxQbW4HdnXKWO3QpwBBFeBgukn3bd5CPT74y1jBvNJCXxpEVn2ggHZ4rJvv2MybHuklcw==
X-Received: by 2002:a05:6512:1318:: with SMTP id x24mr3510785lfu.53.1622151843843;
        Thu, 27 May 2021 14:44:03 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id v11sm298153lfr.44.2021.05.27.14.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:44:03 -0700 (PDT)
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
Subject: [PATCH v4 13/14] soc/tegra: pmc: Add driver state syncing
Date:   Fri, 28 May 2021 00:43:16 +0300
Message-Id: <20210527214317.31014-14-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527214317.31014-1-digetx@gmail.com>
References: <20210527214317.31014-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add driver state syncing that is invoked once all PMC consumers are
attached and ready. The consumers are the power domain clients.
The synchronization callback is invoked once all client drivers are
probed, the driver core handles this for us. This callback informs
PMC driver that all voltage votes are initialized by each PD client
and it's safe to begin voltage scaling of the core power domain.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 23 +++++++++++++++++++++++
 include/soc/tegra/pmc.h |  7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 62f0f928658d..e8e5636f01f8 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -429,6 +429,8 @@ struct tegra_pmc {
 	struct irq_chip irq;
 
 	struct notifier_block clk_nb;
+
+	bool core_domain_state_synced;
 };
 
 static struct tegra_pmc *pmc = &(struct tegra_pmc) {
@@ -1303,6 +1305,11 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 	return err;
 }
 
+bool tegra_pmc_core_domain_state_synced(void)
+{
+	return pmc->core_domain_state_synced;
+}
+
 static int
 tegra_pmc_core_pd_set_performance_state(struct generic_pm_domain *genpd,
 					unsigned int level)
@@ -3792,6 +3799,21 @@ static const struct of_device_id tegra_pmc_match[] = {
 	{ }
 };
 
+static void tegra_pmc_sync_state(struct device *dev)
+{
+	int err;
+
+	pmc->core_domain_state_synced = true;
+
+	/* this is a no-op if core regulator isn't used */
+	mutex_lock(&pmc->powergates_lock);
+	err = dev_pm_opp_sync_regulators(dev);
+	mutex_unlock(&pmc->powergates_lock);
+
+	if (err)
+		dev_err(dev, "failed to sync regulators: %d\n", err);
+}
+
 static struct platform_driver tegra_pmc_driver = {
 	.driver = {
 		.name = "tegra-pmc",
@@ -3800,6 +3822,7 @@ static struct platform_driver tegra_pmc_driver = {
 #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
 		.pm = &tegra_pmc_pm_ops,
 #endif
+		.sync_state = tegra_pmc_sync_state,
 	},
 	.probe = tegra_pmc_probe,
 };
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index 361cb64246f7..d186bccd125d 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -171,6 +171,8 @@ int tegra_io_rail_power_off(unsigned int id);
 void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
 void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode);
 
+bool tegra_pmc_core_domain_state_synced(void);
+
 #else
 static inline int tegra_powergate_power_on(unsigned int id)
 {
@@ -227,6 +229,11 @@ static inline void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 {
 }
 
+static inline bool tegra_pmc_core_domain_state_synced(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_SOC_TEGRA_PMC */
 
 #if defined(CONFIG_SOC_TEGRA_PMC) && defined(CONFIG_PM_SLEEP)
-- 
2.30.2

