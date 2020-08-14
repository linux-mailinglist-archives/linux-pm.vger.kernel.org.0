Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33222441E4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHNAHJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgHNAHH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:07 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA325C061757;
        Thu, 13 Aug 2020 17:07:06 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i10so8121675ljn.2;
        Thu, 13 Aug 2020 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AzqqsKlTIsKI+WxT+RXsQygXtSVSAqLrYwZmJLTNE94=;
        b=DnpQAdbhKIQvhGCJUiMtzMLFsEUCVFYhDtyao0O8CmRNuiU8bgqOEqx20RaCLZROe+
         pWNi/QlnMELpem+aW1gE2k5UAuHvyhQiH3II3NwlscixFJlAehP5xK913dQiLT5Iorab
         8Q/zVOccqKYZF57qdynjJXyH/bxaz5fTQhOwF+yKvVIkh46Z3FYRSaDLVG1VjAA79NRJ
         XTy40YEbsHZjpoHajJJc5dF0x6ZLi5xNa8dsJw3pT4+PQ1eg2yueLpZ5ASL44fYWnc4q
         h83f7bcmG4fft+0l2STGANN5VZzXUAP/lkjOjI/7NJgpcq6JIM0x/z4bp2JGYyEUepyt
         CQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AzqqsKlTIsKI+WxT+RXsQygXtSVSAqLrYwZmJLTNE94=;
        b=fJvbr0PAPqJTSbMrEaMkS36FbxdGWiD5/6CnjlQWh9cjyCgVC7cPckNESCvV6ll/Ch
         hVG9o+/2tuU1jL7hAjfeh/EkYNcamDmpwDWjebjKJn4CLiLIT/CxRBrDu5dchuDW4AQB
         V6JWOlgR/VAmX2qB68jIfZyZVIJonzJo7jxm3zjYfEGyoEHLqPPl8VAneaqB7PfqCJSX
         hl5JPURKtACQc2tFbXLDV+nLUf+bgkKvocj1jiB0bB5IPBdq2bdVRvxTdFe4LGxc0Y3+
         pJMCwwzF8LTNer08ECkSuWiJ8uR7H3nSKiGApg0SKKOog+TBVyJrEOaovG37TsEM+fEs
         5Cww==
X-Gm-Message-State: AOAM533t9bDZPyt1KLNE03JK0U7qovZINwhDQUKb7gK+vFxFqJvfASGX
        rfbN+oZGkuPp4ifuTliMOAI=
X-Google-Smtp-Source: ABdhPJzjuZl+OgyrslWSF80X9s+m6CSaS1bXPxfLfgeKRWPgF2w9Ngkp8C82e1mbxQc8a6Oy46OLDw==
X-Received: by 2002:a2e:a370:: with SMTP id i16mr125608ljn.22.1597363625363;
        Thu, 13 Aug 2020 17:07:05 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:04 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 04/36] memory: tegra20-emc: Make driver modular
Date:   Fri, 14 Aug 2020 03:05:49 +0300
Message-Id: <20200814000621.8415-5-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
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
index 9f0a96bf9ccc..7e0e1ef87763 100644
--- a/drivers/memory/tegra/Kconfig
+++ b/drivers/memory/tegra/Kconfig
@@ -8,7 +8,7 @@ config TEGRA_MC
 	  NVIDIA Tegra SoCs.
 
 config TEGRA20_EMC
-	bool "NVIDIA Tegra20 External Memory Controller driver"
+	tristate "NVIDIA Tegra20 External Memory Controller driver"
 	default y
 	depends on ARCH_TEGRA_2x_SOC
 	help
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 83ca46345aba..5aa3a1da2975 100644
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

