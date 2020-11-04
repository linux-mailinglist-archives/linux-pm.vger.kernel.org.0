Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34F62A6A61
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgKDQuS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731664AbgKDQuR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:50:17 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372CDC0613D3;
        Wed,  4 Nov 2020 08:50:17 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id p15so23746046ljj.8;
        Wed, 04 Nov 2020 08:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rgi+XhUR0z96Rn3qewMTA7hO6Avu0FjffhBJqRZONd8=;
        b=eblmypJFyQJ2ZmnAQXDVYzIfTcgWZpSEDPPBDJhpHcajzNuoN1OljoGc3Tf9n9FzZT
         nX5bGr4ROZoQRFV2uHzErMGUL9vEFUCQ1eY5uzuNWQcVC5eLEEeyUj/wDk2NjRIe0pEP
         zv3/yl7cCmleK4tLV7vPZUBhxfDS6ytosavKOKf5zZ8j/Zw6dZf9NFzKM4wN3kkkL88g
         4N7I/PPNLQSC78Y4Z/KP4sYByZFnB5WfzQXwJbe98IPK7194JPdylHdU6Intjdkb+6od
         U2o/YCxA/ZR4HANV4O0ZvUzb2PxV+B+CF4Qo50AURAiezeT9y2m0vRgTi4wgkRVgLSeI
         q2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rgi+XhUR0z96Rn3qewMTA7hO6Avu0FjffhBJqRZONd8=;
        b=AZNUjFpATG5SJkqMISZOwvtZBZaViwZOfTuJPPIwwDSkqflT3hnjDpwL1EnXBU0ww0
         WC2sEhpGTdTHr2u6MxOdYX4dH1pIa4TcdFu+FKiYzJhC+wjHtlSG2Kc+Jt4U/K5f+ssY
         pJ17ffkncPc1YPYuLBySuIghmelBkEM9wcvrPbW1/VsuGnfmvNjvh23wnYkNl3eCQ03L
         haf7JuL/6KBZ/cb5no3VYflnBB+fOhV7v6/M6HuYXdvkA/ZOITUsIiFRVkuD666O5+Ep
         s5Z6w1rELPb7CII4eK69kPl46Jw8Yd+Vb1qYgEqsjsypA6v3X/nHd9o4/nDPf/8p+iZn
         YFFQ==
X-Gm-Message-State: AOAM531i1rbmOqgzYFcCe5zd01W/5jYXrXJPO+CA4cCH3/+3rRICGqbG
        Lt37ts/J/hAJPoYHagqJ7sk=
X-Google-Smtp-Source: ABdhPJyFMsotfbn43p3mdj6tXK15eT+RmyhuGbAD+Ubsb+LV71BrigRuYtuvHdFFxKDITvUOzOf/7A==
X-Received: by 2002:a2e:320a:: with SMTP id y10mr8068831ljy.393.1604508615721;
        Wed, 04 Nov 2020 08:50:15 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:50:15 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 38/47] memory: tegra30-emc: Make driver modular
Date:   Wed,  4 Nov 2020 19:49:14 +0300
Message-Id: <20201104164923.21238-39-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add modularization support to the Tegra30 EMC driver, which now can be
compiled as a loadable kernel module.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/Kconfig       |  2 +-
 drivers/memory/tegra/mc.c          |  3 +++
 drivers/memory/tegra/tegra30-emc.c | 17 ++++++++++++-----
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
index 76e9a3b10839..6779a2201fe4 100644
--- a/drivers/memory/tegra/Kconfig
+++ b/drivers/memory/tegra/Kconfig
@@ -22,7 +22,7 @@ config TEGRA20_EMC
 	  external memory.
 
 config TEGRA30_EMC
-	bool "NVIDIA Tegra30 External Memory Controller driver"
+	tristate "NVIDIA Tegra30 External Memory Controller driver"
 	default y
 	depends on TEGRA_MC && ARCH_TEGRA_3x_SOC
 	help
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index a7e6a8e4c95a..44064de962c2 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -6,6 +6,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -346,6 +347,7 @@ int tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(tegra_mc_write_emem_configuration);
 
 unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc)
 {
@@ -357,6 +359,7 @@ unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc)
 
 	return dram_count;
 }
+EXPORT_SYMBOL_GPL(tegra_mc_get_emem_device_count);
 
 static int load_one_timing(struct tegra_mc *mc,
 			   struct tegra_mc_timing *timing,
diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 1be28e28ec34..d0926088360a 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1330,6 +1330,13 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, emc);
 	tegra_emc_debugfs_init(emc);
 
+	/*
+	 * Don't allow the kernel module to be unloaded. Unloading adds some
+	 * extra complexity which doesn't really worth the effort in a case of
+	 * this driver.
+	 */
+	try_module_get(THIS_MODULE);
+
 	return 0;
 
 unset_cb:
@@ -1380,6 +1387,7 @@ static const struct of_device_id tegra_emc_of_match[] = {
 	{ .compatible = "nvidia,tegra30-emc", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, tegra_emc_of_match);
 
 static struct platform_driver tegra_emc_driver = {
 	.probe = tegra_emc_probe,
@@ -1390,9 +1398,8 @@ static struct platform_driver tegra_emc_driver = {
 		.suppress_bind_attrs = true,
 	},
 };
+module_platform_driver(tegra_emc_driver);
 
-static int __init tegra_emc_init(void)
-{
-	return platform_driver_register(&tegra_emc_driver);
-}
-subsys_initcall(tegra_emc_init);
+MODULE_AUTHOR("Dmitry Osipenko <digetx@gmail.com>");
+MODULE_DESCRIPTION("NVIDIA Tegra30 EMC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

