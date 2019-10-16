Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3751DD9234
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 15:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393496AbfJPNQk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 09:16:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34705 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfJPNQk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 09:16:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id r22so17489965lfm.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 06:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8we2EpM0rjQuTwVatnTr1F948OBhtLCctpwujUnCJVM=;
        b=pJBfryhnKfTGvUXCpWb3vmCki72rWDgutvYQXZnfk3eOjMW2CFbW03pxcnkfug+2CP
         ORQNEmsxeCfx2aE4oKtvpa7NHMDioVAc3RyB+q4ugBabIibwgUkPEo6bx+4P8UcdAKRC
         Apam9W8X0hB5jNv3Apdm0WsQn54+Q/xCagrQHevdV/DsAP+W6exfTsXMT9BvynwnuYzL
         3fVDQiO+xKRC5yMgsghf467iEBOqKYRwexehdQ0fdqyszBgB5UrScMguSUVSPVX3zTdn
         UnVVRtyORs1Ic8T2Jqh4HK9fR4EWatygNZgrpv849qJ8dOTJSDSIQ8pFSJPp0tV9y5bc
         sPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8we2EpM0rjQuTwVatnTr1F948OBhtLCctpwujUnCJVM=;
        b=nOZjLog8wX1YJahPxsZLheSnZe9v8qt3LJz69Vvo26bO4yCtEzFghZEL7R/g0ESXRm
         KVILEhUEd5nuVDRP507zXJ0+900BzVU2E5fKc3GvwpwjC2F8c995LNdLhRSUWKCYrfjX
         p5m29pd8hfIAHfFhtp7gzGKObv8D90iAKJgfLrD7AhfWRGXlQHc5jHGJ1Gyq8IotJEEU
         Vo+KCPJZM89gPel7iJNHHsSyk0ZISMhptDg9ZJF3BMJjrCXi5hY10r6o8gdzJ6wtk4y3
         172jnqOzEd+M+AmQtbCwGso0ofzbVRjKZQOIcFNOqj1zU8d+p3As28cIOHwdHgvtcrF0
         mQ+A==
X-Gm-Message-State: APjAAAWZrdotNbIp7DW9BYw3sg2+rGvdlrdajC5sa+RNZ3CSVHZUTZ9v
        jbCZ3h/hhyxLhu7bDX11P0UAyg==
X-Google-Smtp-Source: APXvYqz+eigY33Bwc9nKZAvdwkxNqFh2HT/skQhZ4tcXvDcDSziBF8sO2BGnhugFqk0IY2gfwd8qkQ==
X-Received: by 2002:a19:4f0e:: with SMTP id d14mr24211346lfb.177.1571231798276;
        Wed, 16 Oct 2019 06:16:38 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id i6sm6044417lfo.83.2019.10.16.06.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 06:16:37 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>
Subject: [PATCH 3/3] mmc: tmio: Avoid boilerplate code in ->runtime_suspend()
Date:   Wed, 16 Oct 2019 15:16:34 +0200
Message-Id: <20191016131634.15881-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rather than checking the 'runtime_synced' flag each time the
->runtime_suspend() callback is invoked, let's convert into using
dev_pm_domain_start() during ->probe() and drop the corresponding
boilerplate code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc.h      |  1 -
 drivers/mmc/host/tmio_mmc_core.c | 10 ++++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 2f0b092d6dcc..c5ba13fae399 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -163,7 +163,6 @@ struct tmio_mmc_host {
 	unsigned long		last_req_ts;
 	struct mutex		ios_lock;	/* protect set_ios() context */
 	bool			native_hotplug;
-	bool			runtime_synced;
 	bool			sdio_irq_enabled;
 
 	/* Mandatory callback */
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 9b6e1001e77c..86b591100f16 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -39,6 +39,7 @@
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
@@ -1248,10 +1249,12 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	/* See if we also get DMA */
 	tmio_mmc_request_dma(_host, pdata);
 
+	dev_pm_domain_start(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
 
 	ret = mmc_add_host(mmc);
 	if (ret)
@@ -1333,11 +1336,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 
-	if (!host->runtime_synced) {
-		host->runtime_synced = true;
-		return 0;
-	}
-
 	tmio_mmc_clk_enable(host);
 	tmio_mmc_hw_reset(host->mmc);
 
-- 
2.17.1

