Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456822AE5BC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 02:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbgKKBRt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 20:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732692AbgKKBPW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 20:15:22 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C9FC0613D1;
        Tue, 10 Nov 2020 17:15:22 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so518232wml.5;
        Tue, 10 Nov 2020 17:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sD7fDvHXiFm4cObgHl+AP6M6ck+IL5n1B/jSpmdDcPc=;
        b=RbTk3q7RRknepGH85+194oMbJV9LgjnL3ciRibGPuNbAijPEkMeaoXu6Q8x+3QGOYn
         wGeB4uh+kvLlmnP6btaQxproSvbqDdomplczcs+6JfHcW9zanRk0I6IWgIO20GS63tNU
         z7IbYjCdEgVsFiIt4guwH8mQEAk9mzN0JdCxRv5shFtyeJ0WyHswjsbhXZhq7U4cfXgK
         +BTaiEDpHXiOpOeYi3U2EWWeSnR0HNovG+uDTFKrMwCiBfgZ7UHlaUJnZu6KCw9eS4yd
         fJAfUkjNrJTQVRp3EM4NA241LWEXA6X948lxnilQwY/lIdDC7IqxA7FTEqB/z9b3TXM+
         4wEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sD7fDvHXiFm4cObgHl+AP6M6ck+IL5n1B/jSpmdDcPc=;
        b=ChsmLjSRAr0U1GwvKHbymMAgzSieW+lUfhhW5BkXwarrZTUscqvsY3rbaPHMT1bodJ
         rvgn1BR0DpRdhdSCnM+5OlQrzVBUEWg0DdDI5l1cOuxrwgnf3klsO+3Chhlwa3N4ZkY8
         H9/ZOlrjfu1Cv8x+GTLfJtJFdcAGX99uC3WE/ZTOrFEafeeqqM0Pwuc8HsHd0+RssUK5
         jG12RPmdLlfT+tlO3/7NcilOZQ4TuxqWWsvAmvFJKFzFuQHQOev2q0oUOClbSas56X5O
         8NtHGOqLTbVylv61IPW4CQwzGjQJFpoO8dwhnIlpRLMhiIR73q6jVSzHISvEc9IkyijZ
         ZqMw==
X-Gm-Message-State: AOAM5318fFtIEVcDd27N5cM5jeKeZJdwQuD1JkXtJ1YYVjCGIQnfokNh
        CoezFrAH0m8NlO9xRNNA0XQ=
X-Google-Smtp-Source: ABdhPJzNduKCx2DAGT1kO0vBmCfERMYx7fsFrNi6wBTY2U9wsA00dOl7NAFy7l9BVNsyp+sLa6cJiQ==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr913973wmc.172.1605057320997;
        Tue, 10 Nov 2020 17:15:20 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id g131sm564329wma.35.2020.11.10.17.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:15:20 -0800 (PST)
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v8 07/26] memory: tegra30-emc: Make driver modular
Date:   Wed, 11 Nov 2020 04:14:37 +0300
Message-Id: <20201111011456.7875-8-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111011456.7875-1-digetx@gmail.com>
References: <20201111011456.7875-1-digetx@gmail.com>
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
index 8cc1ec5be443..2a4a16bcf91c 100644
--- a/drivers/memory/tegra/Kconfig
+++ b/drivers/memory/tegra/Kconfig
@@ -21,7 +21,7 @@ config TEGRA20_EMC
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
2.29.2

