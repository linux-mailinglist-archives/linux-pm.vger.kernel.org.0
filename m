Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCD8393782
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 22:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbhE0Uts (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 16:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbhE0Utj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 16:49:39 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD01C061574;
        Thu, 27 May 2021 13:48:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 131so2589804ljj.3;
        Thu, 27 May 2021 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRjE9GrdNwqNM0RZjj5ET9YAbdAVTqOUbODt0FYhk9w=;
        b=uHd+rf/sXV179Vp4dFHGFGojkUiRIuuzgDbP0HRJGRhiI+4MmlvuzYd4GtqItt2NMy
         SJSAJDSq4zC23XErSSRgY5vAlu2358aW/vhJb15/Hsixs3vlTv2mAZe6XxEXpqodj05w
         S/sLhGSIZYoCrTENPCaruK0Mq2s/O86E+VrqYK4rL8IJAPTsG0PS+YkNPYNjydgg9Nju
         bHQlnQ8CmZeSPdZnwS2l2QjbfRg6V0lYgQNF1LjjwqrqhUT+LhRg06W6pEnNTXIH4H+F
         BSdll5qHkr85BAwWgChGJXkoYymQgmdvQ5WNWHsW+ubJthEreDmWZCTb0tf++pzpjr7q
         F6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRjE9GrdNwqNM0RZjj5ET9YAbdAVTqOUbODt0FYhk9w=;
        b=XbdADIJGvmv2BBSwjaqvpCtepSvITgcZvqPeUPo6m65MHBIcbq8KGpcOsiT8OGtJQD
         fmeUWD3/b98r6d6gdYvPb+Q/Ecrj1mDAIsRdtPDHqPhcbdVGGOpxioXA88JMdN1uRQgO
         UsOUel5TfJcUcuCfyItw9XvkYZN+0x4c/Sj1v+uk/LFYcape9hyvQm/bBny2zD6jMSGJ
         4qQSMsIkl6N5BGBInZfFEggvY50WA4fxFLE9wEUW0B5KdXaHPrLSrcxBG8dPXvkCaGP8
         05sNoZXnGKAbZe6zYhJzToegLJOcfd3UdHNKdVrY6lkCLGJnziEMWJrv5LAfkKIhY33M
         rdlA==
X-Gm-Message-State: AOAM531NXjqMRq2pm7kz8tgjp7YO6R+VOAP5bdItCtHC5KTmpliFxO9+
        Z+LXAWdBYRpkoljCVz3Y3wA=
X-Google-Smtp-Source: ABdhPJxRWNM7CQmXXEzjfx6OqKbUFUiuz1NT6iXFUqtChlWkyWeBo+w/0mgPWC5YDzr/1WPDdPFFiw==
X-Received: by 2002:a05:651c:102f:: with SMTP id w15mr3848141ljm.367.1622148482863;
        Thu, 27 May 2021 13:48:02 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id 10sm347297ljq.39.2021.05.27.13.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:48:02 -0700 (PDT)
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
Subject: [PATCH v3 08/14] memory: tegra: Enable compile testing for all drivers
Date:   Thu, 27 May 2021 23:47:36 +0300
Message-Id: <20210527204742.10379-9-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527204742.10379-1-digetx@gmail.com>
References: <20210527204742.10379-1-digetx@gmail.com>
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

