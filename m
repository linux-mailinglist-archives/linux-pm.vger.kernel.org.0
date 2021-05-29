Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41B2394D71
	for <lists+linux-pm@lfdr.de>; Sat, 29 May 2021 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhE2RMY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 May 2021 13:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhE2RMW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 May 2021 13:12:22 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8961C061760;
        Sat, 29 May 2021 10:10:44 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a4so2487018ljq.9;
        Sat, 29 May 2021 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W4XYgA9FTIuq7IUiliTgLv6U+XMmEN4JcS1gayFO6x4=;
        b=XvFneu1s3zOzJ2zvgKrnCS/2o15YzpsE9THHygjk/h4/8KY7IY4R9dGp3cKlJOX1Ta
         s06++HzTW7zh8avWtXoWOlrl4EWkjsSCQZB4BTOkBStJml0QQcJCLv9bh/J1QDI3Tva8
         vGgau5lP9RrlxTE0vYkAyxJnt79sgCMFnzA2MefK+m9oNOYvO/yqqb8NU1ui42ueWxd6
         MPL32zZHljANYSmd8tGc0pvO9zZUlQXmNaDfQIzhVUE14kiHhbbJ5TK86PBKRdy1qiJv
         C/lrbotvqTyMzGF001GVRO3Jvnc1eyB4+4el0FnvJa8q2QkWo5oOPDVzAqJIiRabqv8x
         EKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W4XYgA9FTIuq7IUiliTgLv6U+XMmEN4JcS1gayFO6x4=;
        b=sLI2CvkjHfujnHBdS1ieJO5S4V61sIE19zIfctefouG1GH1GEcGTWyfZ4IV345vLnt
         T/oAmFdnD2jH/XnKtpmcqedyjLlZjx6nq2CUqNlSi2XeFT94yI51TiUZOD6sk6qObuhj
         aIksaFa0mfC18f7xBqJzkfb3JBkxLgQIMLmu+u/YTfzkSTu+DJ9EDd1bjfOBC4w3X8Bv
         v0HhJaqo4YGzVA/3b7D+ZT94SDRGt0On9dnK+BFgrEblweMBYCDqIPn3ZazIGNrYAnPz
         33+nzKQ+BKPAACyHdE38Hf1WPBa34ROpK3UdcfwfwOY3+gjDACY2AFtRqjtdMeLngaxe
         NyBA==
X-Gm-Message-State: AOAM531XEjotptN7NSN6W4ugSC1fQEO5uDR3W864eJ0QD27zSPZTGwyt
        eT3JOklaAf+D1wrIEvy3wwY=
X-Google-Smtp-Source: ABdhPJxgEV2rUFHFb4TdOCCxjdNYeijvSRdoUv9yxuJRp6v111XjPjS73BQ/IurSe8xT58MaqGVLyw==
X-Received: by 2002:a2e:8710:: with SMTP id m16mr7570850lji.165.1622308243100;
        Sat, 29 May 2021 10:10:43 -0700 (PDT)
Received: from localhost.localdomain (46-138-84-89.dynamic.spd-mgts.ru. [46.138.84.89])
        by smtp.gmail.com with ESMTPSA id h12sm901715ljh.130.2021.05.29.10.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 10:10:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 5/7] ARM: tegra_defconfig: Enable CONFIG_TEGRA30_TSENSOR
Date:   Sat, 29 May 2021 20:09:53 +0300
Message-Id: <20210529170955.32574-6-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210529170955.32574-1-digetx@gmail.com>
References: <20210529170955.32574-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable NVIDIA Tegra30 SoC thermal sensor driver in tegra_defconfig.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 3d8d8af9524d..63e7f3261e6d 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -169,6 +169,7 @@ CONFIG_THERMAL_STATISTICS=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
 CONFIG_TEGRA_SOCTHERM=m
+CONFIG_TEGRA30_TSENSOR=m
 CONFIG_WATCHDOG=y
 CONFIG_MAX77620_WATCHDOG=y
 CONFIG_TEGRA_WATCHDOG=y
-- 
2.30.2

