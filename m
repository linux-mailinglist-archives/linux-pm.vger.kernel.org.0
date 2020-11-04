Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D992A6AB1
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbgKDQwM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731623AbgKDQuL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:50:11 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9BAC061A4A;
        Wed,  4 Nov 2020 08:50:11 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l28so27979777lfp.10;
        Wed, 04 Nov 2020 08:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xT24YybZ9ESCUzYgdGCxIPBX3gyhxeGvxD42woUTjp4=;
        b=tnVjUemha3ft441R6cHZarZDnvpO3jI+yLR26WM4VdGva6bOHWI1NSLO+Zp3h/iOr3
         uE9svPHNVMKaQoLP/0ekpVZ0tKKI9Hw0dSaImzIqUCcrRzDbn9VUmanH6I0TzpBBxstZ
         WtckXa9nAXWgwhVlOsECB5/M90E7JkP8MTobICLfHGcQd9aa3qOWJhYoJwIaZ+1u+SLg
         eaVbg9YBU3pgbUQQCdgaUpULNa1ujdp4tQX2uPEeM4ricWugMwxgfaIUJ4uy+LbNvGtx
         BdUFMFJ3NuP+QGTgxgGunCYHimKMyL3jlIG/pyqj/2hfVmhghKjLoj/eWumXn7E6O5Bx
         IWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xT24YybZ9ESCUzYgdGCxIPBX3gyhxeGvxD42woUTjp4=;
        b=jBldAqmr/eV6Lqwd/WjtbxJPkgvuT0puub6DtYpbd7bS//dLducF7Y1hSAEEUBDze1
         lEIwoJuB/NSRZbzGmAvo69YvHkOo1f0W7iOOtvdN0PK8ZmNl/BnbCITMcU5kdVAiMmxS
         wMFYrch148isyZ305ZUmzYGFEvq41eRJ3n2Y+mfNyivkfni+AKVo9NxkC2sqw0Zbf6LG
         9gOZz90ajdTA8prv4ZbPTjaWdn2kXXMjTmPDWsXe9lxYwKkw4gCVobDjoXFrC1NaU0BU
         Z9t82SWz1saYS8F0dP/KASfnjq5QLkxdWQAL9TW1GrbVWqzixP8wOgoAQeXCxMI51ZzV
         45TQ==
X-Gm-Message-State: AOAM530mcG5mfhZIVBxR76J0jmNQoLzWHd1dirZHfIC0BxItZR9OD8fq
        qrf8mP23JWeJTCD/sR0yjBY=
X-Google-Smtp-Source: ABdhPJzBVgcu5tqRSkCoQPWfnMYlkh8Bf1SUYRqiEau5NByTFy2W61uGqqDNsNINaJKset+Q4hRvdg==
X-Received: by 2002:a19:3fd6:: with SMTP id m205mr9540980lfa.1.1604508609726;
        Wed, 04 Nov 2020 08:50:09 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:50:09 -0800 (PST)
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
Subject: [PATCH v7 33/47] memory: tegra20-emc: Make driver modular
Date:   Wed,  4 Nov 2020 19:49:09 +0300
Message-Id: <20201104164923.21238-34-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add modularization support to the Tegra20 EMC driver, which now can be
compiled as a loadable kernel module.

Acked-by: Thierry Reding <treding@nvidia.com>
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
index c9fe58a724ee..88619e3ec435 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -721,6 +721,13 @@ static int tegra_emc_probe(struct platform_device *pdev)
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
@@ -733,6 +740,7 @@ static const struct of_device_id tegra_emc_of_match[] = {
 	{ .compatible = "nvidia,tegra20-emc", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, tegra_emc_of_match);
 
 static struct platform_driver tegra_emc_driver = {
 	.probe = tegra_emc_probe,
@@ -742,9 +750,8 @@ static struct platform_driver tegra_emc_driver = {
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

