Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FF5396B53
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 04:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhFACf1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 22:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhFACfS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:35:18 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B540C061763;
        Mon, 31 May 2021 19:33:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s25so17146033ljo.11;
        Mon, 31 May 2021 19:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ewFLW/MzKxFtpSzZGRbhqT8/VbyB9Nt0WEtAAwMoHIw=;
        b=OOEbrRgUSgeljaM0Uef0s8S7HbxDGwZKXS1SdD7meM5odr0WIuSJKvv7IUE2bu6eaz
         p5wtFAZu8NI+uHuJVPlkujwneYuBBs8/CIFW+sFN5C0Tq8h1B4h8CLNaQ+wv0qlJDji0
         UTsRNRth1Be+Sv7/6T+ddKDSBJoMArwtcedaMAlL9/TnxhhnPUoVEsbymgpZR2Om8orc
         GwwMoL1NrEKthI4bKpybwhvR5DIT6IcgZjLEMCX126HQ6enRRXXGsMUWCHicEgblYpP6
         vr7hLlTzQ1zeVOvT79fXAg84qM8B+z16HSXzzrmbw50H4aBjr2GYDY4dvRZ3PABxC5Tz
         EOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ewFLW/MzKxFtpSzZGRbhqT8/VbyB9Nt0WEtAAwMoHIw=;
        b=VFOIbtAJw1hRsZfD+KnK+uez9ywaMfJrdUEC4LBSupTE78ydNGkUwQOtcdC0qcir76
         D5hOCj3uKbQaV/nj5T4FHffUVnE5jwi5uvVh3KC81G3J08Li3IuzDQnW9lQ9h7zaFI7n
         1XQ8uLQBuT3b+VNxs5G+nwkFKNyvq1u9KOScHAk99i2nKVZeV2BcNqrCD2tjzhC3na0n
         xjV3mQQ6tkGUhpmdK8E/kZhSb0MhapouKnmRBu2XD2JL390cOZpozVVOKK9+IKolJnIu
         FkkQkvodquWBq+X8V1IC3vP8LHBLrtO8hJdDX81vAV53wu8U6bKqK5QTbeolmWx7dRSA
         4L3g==
X-Gm-Message-State: AOAM5325J/MXIo9hOe9Og9PfVEkVjx3NYs30F2r4DhnqQ2fVvpTU2FSq
        gIniiBtUnLSZ0tBGoHk1YZQ=
X-Google-Smtp-Source: ABdhPJy0FSGR9as+UOokBVZTg9t8KVxt7u8YU/TZg8joMbuXdJBlU+5IjL4UsDO0mAi4/rQ8qVrZMg==
X-Received: by 2002:a2e:97ca:: with SMTP id m10mr18637546ljj.205.1622514816466;
        Mon, 31 May 2021 19:33:36 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id l21sm107848lfc.28.2021.05.31.19.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:33:36 -0700 (PDT)
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
Subject: [PATCH v6 13/14] soc/tegra: pmc: Add driver state syncing
Date:   Tue,  1 Jun 2021 05:31:18 +0300
Message-Id: <20210601023119.22044-14-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601023119.22044-1-digetx@gmail.com>
References: <20210601023119.22044-1-digetx@gmail.com>
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
index 7e07910b9b88..d8eee285fd58 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -429,6 +429,8 @@ struct tegra_pmc {
 	struct irq_chip irq;
 
 	struct notifier_block clk_nb;
+
+	bool core_domain_state_synced;
 };
 
 static struct tegra_pmc *pmc = &(struct tegra_pmc) {
@@ -1298,6 +1300,11 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
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
@@ -3787,6 +3794,21 @@ static const struct of_device_id tegra_pmc_match[] = {
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
@@ -3795,6 +3817,7 @@ static struct platform_driver tegra_pmc_driver = {
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

