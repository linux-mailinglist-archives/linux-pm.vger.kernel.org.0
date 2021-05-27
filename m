Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91DE39399D
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 01:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbhE0X4O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 19:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbhE0X4F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 19:56:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D401C061763;
        Thu, 27 May 2021 16:54:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w33so2629225lfu.7;
        Thu, 27 May 2021 16:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRjE9GrdNwqNM0RZjj5ET9YAbdAVTqOUbODt0FYhk9w=;
        b=rX/ZIVZQLHYVTCjrOngMSK7RGxplAjzMzM+fgVD+VULrFO+lN/uVrNB82/toq+PihP
         XRIA8TF0SLBTDSpm9m3T9hrtRiz643DSYh6ePj3HFbm5LBTEj+dNUL6XL9y9pUt6NGuJ
         57avwh/8G24pxsUVQSTfHWrMjgrdihCwlsBW7tXc4/Y/lf95fMmrSXhD9IwzqtgFT67T
         H9bzUmWJ2HsxQDJoR2Ul0UyNxHceN8TX4O/cpvLZBUMJGq2gir0DtjDJZ6KJgs68xoZn
         zbHnjdmpMtJ/kxVIHEAT3l3akUPTtWsFfA1HqgACIbnVI9Du7nZNXccfXm6iJO8bLeZ4
         9aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRjE9GrdNwqNM0RZjj5ET9YAbdAVTqOUbODt0FYhk9w=;
        b=HkKGDOwLa91wPNpDuxBTXxixINnYnqHHfoMOcaapFp/GTRPHRex58hC7V5hxaQ2XEE
         2XdpP0cJYDRQTDXyODJOnLkdvxAVhskgrOA4FmfDqi+3f98GiQ32ztuCAK6zzBFJVPNw
         Dl9FF9Lq9vYPOjO8UCX3xJ7JsJyqHyV2Uy7F/IQEy4ltreY89hgv2tCynofm/lxRZJsR
         jEjLx+ISquw7Iwnvx7SZ6HSXruqc+ygZUIdHz2P0h8Iy+1tcwOs4H+nsImvvsPv6qxg+
         xwSFn88CxpVWFsaJFUoij9vobAs17rMTOtnLTbN+X63bdgm+wZLGVHK5Y/0qJFnxKygH
         mmAQ==
X-Gm-Message-State: AOAM53111X4CMWNlP51w2lK+GQ+xcjpQ7mCMcNGvEtfxmB4QCvteEw6O
        JTkixgoqQxcPQRO/xmsuIys=
X-Google-Smtp-Source: ABdhPJxt/NwASdmX7EoYFUuibNqXixobhVLRwb7XjQWy8U3Ed60sHLL/pctvLWu/qW/9A6Hn/GD3aQ==
X-Received: by 2002:ac2:5edb:: with SMTP id d27mr3990935lfq.181.1622159665695;
        Thu, 27 May 2021 16:54:25 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id t129sm319000lff.109.2021.05.27.16.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 16:54:25 -0700 (PDT)
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
Subject: [PATCH v5 08/14] memory: tegra: Enable compile testing for all drivers
Date:   Fri, 28 May 2021 02:54:07 +0300
Message-Id: <20210527235413.23120-9-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527235413.23120-1-digetx@gmail.com>
References: <20210527235413.23120-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable compile testing for all Tegra memory drivers.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/Kconfig | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
index a70967a56e52..71bba2345bce 100644
--- a/drivers/memory/tegra/Kconfig
+++ b/drivers/memory/tegra/Kconfig
@@ -2,16 +2,18 @@
 config TEGRA_MC
 	bool "NVIDIA Tegra Memory Controller support"
 	default y
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || (COMPILE_TEST && COMMON_CLK)
 	select INTERCONNECT
 	help
 	  This driver supports the Memory Controller (MC) hardware found on
 	  NVIDIA Tegra SoCs.
 
+if TEGRA_MC
+
 config TEGRA20_EMC
 	tristate "NVIDIA Tegra20 External Memory Controller driver"
 	default y
-	depends on TEGRA_MC && ARCH_TEGRA_2x_SOC
+	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select PM_DEVFREQ
 	help
@@ -23,7 +25,7 @@ config TEGRA20_EMC
 config TEGRA30_EMC
 	tristate "NVIDIA Tegra30 External Memory Controller driver"
 	default y
-	depends on TEGRA_MC && ARCH_TEGRA_3x_SOC
+	depends on ARCH_TEGRA_3x_SOC || COMPILE_TEST
 	select PM_OPP
 	help
 	  This driver is for the External Memory Controller (EMC) found on
@@ -34,8 +36,8 @@ config TEGRA30_EMC
 config TEGRA124_EMC
 	tristate "NVIDIA Tegra124 External Memory Controller driver"
 	default y
-	depends on TEGRA_MC && ARCH_TEGRA_124_SOC
-	select TEGRA124_CLK_EMC
+	depends on ARCH_TEGRA_124_SOC || COMPILE_TEST
+	select TEGRA124_CLK_EMC if ARCH_TEGRA
 	select PM_OPP
 	help
 	  This driver is for the External Memory Controller (EMC) found on
@@ -49,10 +51,12 @@ config TEGRA210_EMC_TABLE
 
 config TEGRA210_EMC
 	tristate "NVIDIA Tegra210 External Memory Controller driver"
-	depends on TEGRA_MC && ARCH_TEGRA_210_SOC
+	depends on ARCH_TEGRA_210_SOC || COMPILE_TEST
 	select TEGRA210_EMC_TABLE
 	help
 	  This driver is for the External Memory Controller (EMC) found on
 	  Tegra210 chips. The EMC controls the external DRAM on the board.
 	  This driver is required to change memory timings / clock rate for
 	  external memory.
+
+endif
-- 
2.30.2

