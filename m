Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86A53939B9
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 01:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbhE0X43 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 19:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbhE0X4N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 19:56:13 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D71CC061348;
        Thu, 27 May 2021 16:54:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id t17so3019575ljd.9;
        Thu, 27 May 2021 16:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+VpkeiCREzCB6f6A6h2ui2qcNPLr5jeX29c4cdIlp8=;
        b=e9u9g9seOi/wrRmc6mYy3h528SIigcwCWIe0Ao88vLUO/jIt0XmLJeSyP2S86pSsTN
         FYi+ZjQpwh+qSm+zGlQ05wzheXiME1pDLSe9pW/lzhiAPJCO3tPQpffbyIYK7b5EmrGR
         39VDjOFTUyGF3FQAyQTIesJnrxyDHpR16UDrpErAywoAZHVOxbMR3oadMR91DhFXR9vz
         qAq7t0oOsjlx6x++Q8sN8FiKJ7FA8tuxUWkRHpD64K9YhVtzIPfRMFy8aXbozL87BRIt
         hxGu/6GR43QFrv0QB74CC9GiDbdJ5wkTvmCerZrLQTVIWsL6qYHD3KVGfVr/XHl6oATH
         slFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+VpkeiCREzCB6f6A6h2ui2qcNPLr5jeX29c4cdIlp8=;
        b=WuzuICdhCDoEvxolZalBONqbtwC3T0VDro/TkZxjl6xo6h7eA3/cD4jPCCoTukJt7a
         u9wWlUupLUVSGf6HPAzgYOYy2JdR0I0XC4dHlSNZVirSTZoz1eyuWQHwRUMjHculEIvg
         Ua+0upFs9hVuwG0+RbY/W1SHzhzkPkvevFmqk19gWENVmOuYZFtZLSxfdHPbvDJrNW1j
         MeHGNB8uJCZL2BiN1ENP7092irL0Ug4n5s4F63GWg0nUBiZTKqetfGqLI+KNjoPgLXqR
         i4FMKAUyXFx3Q/Sb+FSXwdgdSpGYK9WyShfJcRt/a31NgU88qeMqAECA7qblLBkr/G51
         fgWQ==
X-Gm-Message-State: AOAM532oLxEJOHYkazujdxVZjE16FqW/ElCunVFo4dIWWYhwQ6By6Tjc
        GrLkHQKbXEadlgOd3MXGJFw=
X-Google-Smtp-Source: ABdhPJynn4XV+Lq7XUgWno6QtcpNKw+Rboj4nWddT3cLvXtKF2JccgyLegLZBxKabOTT3AnRJedkBw==
X-Received: by 2002:a2e:591:: with SMTP id 139mr4494201ljf.207.1622159670516;
        Thu, 27 May 2021 16:54:30 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id t129sm319000lff.109.2021.05.27.16.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 16:54:30 -0700 (PDT)
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
Subject: [PATCH v5 13/14] soc/tegra: pmc: Add driver state syncing
Date:   Fri, 28 May 2021 02:54:12 +0300
Message-Id: <20210527235413.23120-14-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527235413.23120-1-digetx@gmail.com>
References: <20210527235413.23120-1-digetx@gmail.com>
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

