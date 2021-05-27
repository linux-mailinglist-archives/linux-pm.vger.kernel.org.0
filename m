Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D11393789
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 22:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbhE0Utv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 16:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbhE0Uto (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 16:49:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24005C061574;
        Thu, 27 May 2021 13:48:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id v8so2024781lft.8;
        Thu, 27 May 2021 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/XloZr9g5QG7Kr7vGUXvbAzz/oLdVnd2/AZAYA2fZnk=;
        b=isvuWBE8tQb4r5dTtU6bTmJ4cslDHH4ej3H6wxBMbzlRfnQ7ew8oF7so5B+3ewoWh5
         Sa8oZObiwxsl5rrs/7CXNlqbHKsfmsQBHrL1yCW15GKnE/Ziz9L4aoZ0fz0dlUq5PtbU
         S+ZN9Hx8m2ZiManlQTe+ox3zpI/egtEhRJt0qkNV7S//duR+dNbvQ8VSXHStqRvif3jG
         p2CrcOiWOHO8pM63tlUXWCKM+DTq2+qF5EosMUc4zy5jci2rTzD81vDOJH4s9MlvB/0s
         FTJdN5oKkR0iwAR3ECPuRcWCytcvANwYDloiyowmEXn7InmNyn6uT9SHRFp4fOeLTAtw
         hmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XloZr9g5QG7Kr7vGUXvbAzz/oLdVnd2/AZAYA2fZnk=;
        b=XeEgFRiRXz6NHBu/WaP1f63EdwY3gLl76chPsELOaBBLjjbiLstg3TpontULvPLl/Z
         O8hs382eUXnF6/UBuTfspZXljCgJxOo/5ZHGvsAO/U2tv8PWvn5wkg3NbBf1uTQj/qca
         14yb7sI3I5PcddrrWbvI6UBLzgOV0YAUr2MAA81CijiTjKW2Yf/xBTfJKlriApbHBNlg
         bx9POKx+ptPAf+t00rzNxymi+auXzuuDPLwFxrxYWP/18NCPcgMdooafW9Ujd2yjZ0bK
         OQ9muONRKx7ZXm3vsLjqHKhRNSgFybeSc6Ij+u3s66cYHlyA3Vpyhwb7nMZ6/vzu7ODb
         zCgA==
X-Gm-Message-State: AOAM532VdyFCxU04KeZXOd5Ou3pWq0je1HadpMiL1pTpHKfHDqBp1ZJI
        a/pGcefDokGdXK32scjdE5M=
X-Google-Smtp-Source: ABdhPJzQfLMqiwv4ZE0yGTSA3wruNbYSTX6oXJ5XMkH2/Ju8jnuWcMiJ87HZPuzSjD2llqJ/AjJ6tQ==
X-Received: by 2002:a05:6512:468:: with SMTP id x8mr3462294lfd.519.1622148488491;
        Thu, 27 May 2021 13:48:08 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id 10sm347297ljq.39.2021.05.27.13.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:48:08 -0700 (PDT)
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
Subject: [PATCH v3 13/14] soc/tegra: pmc: Add driver state syncing
Date:   Thu, 27 May 2021 23:47:41 +0300
Message-Id: <20210527204742.10379-14-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527204742.10379-1-digetx@gmail.com>
References: <20210527204742.10379-1-digetx@gmail.com>
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
 include/soc/tegra/pmc.h |  6 ++++++
 2 files changed, 29 insertions(+)

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
index 361cb64246f7..3d0b8694b2d9 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -231,11 +231,17 @@ static inline void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 
 #if defined(CONFIG_SOC_TEGRA_PMC) && defined(CONFIG_PM_SLEEP)
 enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
+bool tegra_pmc_core_domain_state_synced(void);
 #else
 static inline enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void)
 {
 	return TEGRA_SUSPEND_NONE;
 }
+
+static inline bool tegra_pmc_core_domain_state_synced(void)
+{
+	return false;
+}
 #endif
 
 #endif /* __SOC_TEGRA_PMC_H__ */
-- 
2.30.2

