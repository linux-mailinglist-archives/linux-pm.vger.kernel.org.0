Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DDD2F9632
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 00:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbhAQXTR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 18:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbhAQXTP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 18:19:15 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04B7C061573;
        Sun, 17 Jan 2021 15:18:34 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id a12so21454498lfl.6;
        Sun, 17 Jan 2021 15:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sq4yZQdAteM9zcWr1ItP1nFqtCn3ipB5YcMTpKk0NwE=;
        b=hwPu9DDF1x6++8kqaee1IpHkqnC4ie4htJy/fuew9Jkk1M94f3hwZTcvM6OWhqFRJW
         n8+QWcnKs8xi3JMMBy+MSDIMRHg/d3xLLRshkzKEdxSmRuhNccSCVx15y7VRoQ9/2CEh
         yj9OmpzVhDSk4EKuTQpd+JWKaaOsSYqFh4N/YCvc6AYg5YSUcZuN3i5B+iF/3bdBheo+
         Ojpeb/+cQ9e6XCsCEGWtio+3F7/kyxAScjubXGwQKVLmaLlvonwLwMOSxAX0jR767JH6
         V42O5KOrHxEUNIv8fjJSKVWT5Zj/Uv8mhTpBOcUprQVuuhPz/3ynilX0SiFpJEKUN0z1
         TkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sq4yZQdAteM9zcWr1ItP1nFqtCn3ipB5YcMTpKk0NwE=;
        b=iP1mfEHzJWS62BAnSZpK9ov+XwjjezK4wWAXYixHfDvWAoZ91TfvEvoQ3U3QVcDB3V
         EZ0wRjH3jBvycKEjKoEbHEgSQBUkz4Hs59kjXWeIsTNSFtHQBA1mN0QlcXsUOf++Aqpf
         BOewbjJUqvdUxqGUQ1W2GAq6SmaWCNRGanjfvDMx7oI69TNpneF5xU+WzLiDFNLluaJU
         keN2twmat1WMwaxD/zyuShFfBjD5UAIIHGThWWIIBsL7p3LCcAutqYxnb6r4n9N+5P2n
         ooqCyUZLXdxIgdBKxuwnF+LtRmoROMPQfajwCVeE9V3009AvdoRGTYUdHew0Wx6liaTf
         FDbQ==
X-Gm-Message-State: AOAM532gy/VwZaXAdgm4eKtqc7FsDkSSpuPdDbLsAMt2HTkXaMsC70Wu
        PJC10SoxE6u/2kGsrmn/BiQ=
X-Google-Smtp-Source: ABdhPJz3dpZSgPb/NFdl0tvBy1tbfKxDf6ewKkexLSmU8ZGnKcHdkfWGKJ5FVaQkDgnl6NT9kbOb0Q==
X-Received: by 2002:a19:ac0c:: with SMTP id g12mr10494423lfc.51.1610925512080;
        Sun, 17 Jan 2021 15:18:32 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id d6sm1697226lfl.175.2021.01.17.15.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 15:18:31 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J . Wysocki " <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] cpufreq: tegra20: Use resource-managed API
Date:   Mon, 18 Jan 2021 02:18:25 +0300
Message-Id: <20210117231825.28256-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Switch cpufreq-tegra20 driver to use resource-managed API.
This removes the need to get opp_table pointer using
dev_pm_opp_get_opp_table() in order to release OPP table that
was requested by dev_pm_opp_set_supported_hw(), making the code
a bit more straightforward.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 45 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 8c893043953e..e8db3d75be25 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -32,6 +32,16 @@ static bool cpu0_node_has_opp_v2_prop(void)
 	return ret;
 }
 
+static void tegra20_cpufreq_put_supported_hw(void *opp_table)
+{
+	dev_pm_opp_put_supported_hw(opp_table);
+}
+
+static void tegra20_cpufreq_dt_unregister(void *cpufreq_dt)
+{
+	platform_device_unregister(cpufreq_dt);
+}
+
 static int tegra20_cpufreq_probe(struct platform_device *pdev)
 {
 	struct platform_device *cpufreq_dt;
@@ -68,42 +78,31 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = devm_add_action_or_reset(&pdev->dev,
+				       tegra20_cpufreq_put_supported_hw,
+				       opp_table);
+	if (err)
+		return err;
+
 	cpufreq_dt = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 	err = PTR_ERR_OR_ZERO(cpufreq_dt);
 	if (err) {
 		dev_err(&pdev->dev,
 			"failed to create cpufreq-dt device: %d\n", err);
-		goto err_put_supported_hw;
+		return err;
 	}
 
-	platform_set_drvdata(pdev, cpufreq_dt);
-
-	return 0;
-
-err_put_supported_hw:
-	dev_pm_opp_put_supported_hw(opp_table);
-
-	return err;
-}
-
-static int tegra20_cpufreq_remove(struct platform_device *pdev)
-{
-	struct platform_device *cpufreq_dt;
-	struct opp_table *opp_table;
-
-	cpufreq_dt = platform_get_drvdata(pdev);
-	platform_device_unregister(cpufreq_dt);
-
-	opp_table = dev_pm_opp_get_opp_table(get_cpu_device(0));
-	dev_pm_opp_put_supported_hw(opp_table);
-	dev_pm_opp_put_opp_table(opp_table);
+	err = devm_add_action_or_reset(&pdev->dev,
+				       tegra20_cpufreq_dt_unregister,
+				       cpufreq_dt);
+	if (err)
+		return err;
 
 	return 0;
 }
 
 static struct platform_driver tegra20_cpufreq_driver = {
 	.probe		= tegra20_cpufreq_probe,
-	.remove		= tegra20_cpufreq_remove,
 	.driver		= {
 		.name	= "tegra20-cpufreq",
 	},
-- 
2.29.2

