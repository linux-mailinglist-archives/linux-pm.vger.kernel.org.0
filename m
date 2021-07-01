Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D1A3B9937
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhGAXbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbhGAXbU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:20 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8A1C0613DE;
        Thu,  1 Jul 2021 16:28:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n14so14801948lfu.8;
        Thu, 01 Jul 2021 16:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5l5f0is9u8p1YOutfW3/4Tk5nzIbh3I6LHK9UWYmaqU=;
        b=TTVM3OM3oMaz9g3oVmDiJ2bFBOYv5Z9UYTFrgP9U1UAP1ysLfNlRZdmM1romBC6mdb
         ESxxVOkc81YA/4jggBDn/gj+wlTw03XmlVfzar2NF3ilsRmy60B3ixfyAd+oRYlSBMuR
         6FkXdtFI/DH02UVz64HWF5f7/L1yZALwJbK5ThBvAnOVLg6jKetpQg9EpwBI4NdJ6zAM
         DgwYU0cn8so3ojrYHg4ti38COJ/iD3FUcT+RJjuzgGDbuXizfdJ6V1qq7SDPLIgFXh9n
         uHsOl6yo9qnQc5Gjcz9gbQpOiLEuN+KP82vDeHPwcxY0Nobfj7Zy22/yThU/d3BYnDJP
         2jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5l5f0is9u8p1YOutfW3/4Tk5nzIbh3I6LHK9UWYmaqU=;
        b=bTP1dTTzx9sUtRKj2BJhzqRWsvdU06YcbfVVjATgvB4V/Vvs2YQIxuN0VxUJAbzaWR
         2bLBRTyNj5ipCY/wNUwD6woVFo6vtScfyTSjVuU37Sp+f6svFGfn6DUHwaWabwxn61tu
         mSqSnQwxUzIoXbANVKm1gFGYY917KMbDMkBKaly1i1XoBKdburaNpvbdl8LTsxd/BIde
         AKqiIp5CxMt33GNJWA8CYxrZjKkNIQCk5kHgfL7ZZv0lImAhk+/h4JCkLx7pArbJTSE0
         rQLf1ZQcVm7gkE/nKQ3k6ubkXVsC48uVgMFXjCZbX1HAZbiZWXJMUaPTzjtKsxzrl1/O
         6wUQ==
X-Gm-Message-State: AOAM5326vc0PzdSc1qpmOVJcp45R/C7RrU6cGdSGdLe3RnpPpUopoA20
        xH2x1g3m3hWxwJn8/6xykc8=
X-Google-Smtp-Source: ABdhPJwgBmJOR2Tl/hFel9T9bT+8EJaXn4yXgOik1Z5ZnmPvHpd6cfqlH74sHYLE19w0RyqXyIbYiQ==
X-Received: by 2002:a19:408c:: with SMTP id n134mr1483404lfa.329.1625182126169;
        Thu, 01 Jul 2021 16:28:46 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 27/37] spi: tegra20-slink: Add OPP support
Date:   Fri,  2 Jul 2021 02:27:18 +0300
Message-Id: <20210701232728.23591-28-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The SPI on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now SPI driver must use OPP
API for driving the controller's clock rate because OPP API takes care
of reconfiguring the domain's performance state in accordance to the
rate. Add OPP support to the driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/spi/spi-tegra20-slink.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index cbf0b4a0820a..87b850e45863 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -18,12 +18,15 @@
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
 
+#include <soc/tegra/common.h>
+
 #define SLINK_COMMAND			0x000
 #define SLINK_BIT_LENGTH(x)		(((x) & 0x1f) << 0)
 #define SLINK_WORD_SIZE(x)		(((x) & 0x1f) << 5)
@@ -683,7 +686,7 @@ static int tegra_slink_start_transfer_one(struct spi_device *spi,
 	bits_per_word = t->bits_per_word;
 	speed = t->speed_hz;
 	if (speed != tspi->cur_speed) {
-		clk_set_rate(tspi->clk, speed * 4);
+		dev_pm_opp_set_rate(tspi->dev, speed * 4);
 		tspi->cur_speed = speed;
 	}
 
@@ -1054,6 +1057,10 @@ static int tegra_slink_probe(struct platform_device *pdev)
 		goto exit_free_master;
 	}
 
+	ret = devm_tegra_core_dev_init_opp_table_simple(&pdev->dev);
+	if (ret)
+		return ret;
+
 	/* disabled clock may cause interrupt storm upon request */
 	tspi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(tspi->clk)) {
-- 
2.30.2

