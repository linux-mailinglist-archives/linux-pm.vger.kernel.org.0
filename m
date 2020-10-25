Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACECD2983F6
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419319AbgJYWS0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419312AbgJYWSY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:24 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F79C0613CE;
        Sun, 25 Oct 2020 15:18:24 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l28so9412270lfp.10;
        Sun, 25 Oct 2020 15:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EUjUPaHt1SM/rbNjaaosf0keIlgfJghzEnTIAKmBLW0=;
        b=baiADdmvC1n8u5S9oCySw/VOnvKHAup04huGK6DB3va3DHCRhu+NENJU3rhUDVz+ll
         T/qKn26rjsp5r0Iqv/TGa4vW59bwm79iIZf1hbnyn7jYwZq3zJU75KYPwq5JiUKyijxw
         C1XePTRy95fzAgYXjTrMXN2RKA7UDf19PVBKV377UEEcYAGP6eQRQHyJuImfaSM74ZZ9
         WOvI14zDyJ9XqwQuHUoM6TG6jxDX3xmiZmV+aK1Dk3ooarr+JggfzJ+2NBdfFUmwH0Co
         1LiBfRQAIobPZw6ngIwtItpMQBZBS7Zc0gXaSQsgxW3PClq64RdKpC7HWH48Nh13S645
         SNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUjUPaHt1SM/rbNjaaosf0keIlgfJghzEnTIAKmBLW0=;
        b=pQcuajQN59eXqrZgw15HlBugkuAtxcJItF3tXnI1RerBpfoKwnBny82wT+kGRNF5mI
         jzs3vZ2qmTgJo50aYbV9vN8QZZP1g9blnLvEOxzx4yYJH94OtTU++AggstCiHSZrUeJe
         r6FL6Ap2kmpebhIhDH/UirtbQ/PsBH4Jp2i6psOkJUksbZsiiPIev6Dz7g/nlU9m/ws4
         Q9hAe6L6zrB1fq5U1eIQyqtysfMvnmGF4W5Q+HVy3/jFwp6ioZegtlpOv6TRdKtIsx5F
         G60jkoMUZ++8s0f23j8sH/IDjVcKaOxgBu0uNbkbKTL06K6kyS7lqTl/x87pPTZL0Fii
         SIqg==
X-Gm-Message-State: AOAM532RDiXYp5TfW+ZZKceaOAc3nnKdNFh0ZcW603fCufyjAI+0HKP9
        YI1oWs02ckTe73Voa4nT+n4W68GO5yA=
X-Google-Smtp-Source: ABdhPJxth3ZWnKpchePBQUQe8A+OZsbsAJLioxg4K82Z79/f8b9W7z7GR5YS5NNWo3d7POb4I9QdKQ==
X-Received: by 2002:a05:6512:20ca:: with SMTP id u10mr3869843lfr.247.1603664302677;
        Sun, 25 Oct 2020 15:18:22 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:22 -0700 (PDT)
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
Subject: [PATCH v6 30/52] memory: tegra20-emc: Make driver modular
Date:   Mon, 26 Oct 2020 01:17:13 +0300
Message-Id: <20201025221735.3062-31-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds modularization support to the Tegra20 EMC driver. Driver
now can be compiled as a loadable kernel module.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/Kconfig       |  2 +-
 drivers/memory/tegra/tegra20-emc.c | 17 ++++++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
index b38e5255effe..ff426747cd7d 100644
--- a/drivers/memory/tegra/Kconfig
+++ b/drivers/memory/tegra/Kconfig
@@ -9,7 +9,7 @@ config TEGRA_MC
 	  NVIDIA Tegra SoCs.
 
 config TEGRA20_EMC
-	bool "NVIDIA Tegra20 External Memory Controller driver"
+	tristate "NVIDIA Tegra20 External Memory Controller driver"
 	default y
 	depends on ARCH_TEGRA_2x_SOC
 	help
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 027f46287dbf..0baa6590adea 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -724,6 +724,13 @@ static int tegra_emc_probe(struct platform_device *pdev)
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
@@ -736,6 +743,7 @@ static const struct of_device_id tegra_emc_of_match[] = {
 	{ .compatible = "nvidia,tegra20-emc", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, tegra_emc_of_match);
 
 static struct platform_driver tegra_emc_driver = {
 	.probe = tegra_emc_probe,
@@ -745,9 +753,8 @@ static struct platform_driver tegra_emc_driver = {
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
+MODULE_DESCRIPTION("NVIDIA Tegra20 EMC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

