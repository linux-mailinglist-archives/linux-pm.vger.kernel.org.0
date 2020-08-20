Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C624B6F1
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 12:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbgHTKpJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 06:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731897AbgHTKoh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 06:44:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531AFC06134C
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 03:44:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h12so934753pgm.7
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/LOsg+FK0HYq6IcD/yEuwtjKnkS0z9yASmI3zpx6q2A=;
        b=JeiAOvt7RXm1vLlwduO6b/sWDGxWDZBlfXvUhtmlKqevYviiO5iuW0Dq4Y+IBeBu23
         cToB2QPrKFqj/in4w4UJJbI46NRbCYY0NBi26HQdPui2dHUY4uvZZdxkdqn5mWHnhAn3
         c4B0UBjRc/mRQJAE/EdSdu30LFedIxlAZSf1wfl0JaHFiB2I9UlGODYczefrXKJzKfe2
         7KR6WT4os/o4nI3hewxkOGLjKmws6rfhkf673cbRFsP0xCkGsq94Z87OmSmOu6NB12wl
         12gbw2p43q6l4BGM7DbjVf3r/cuyh3l8rJ+mH0f99CygvhowobayxBJxapUZTQa/z1P3
         puEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/LOsg+FK0HYq6IcD/yEuwtjKnkS0z9yASmI3zpx6q2A=;
        b=Njxb1OXZIcKG8VhgSjEtETKRZH4avU/JlOxfRUwy0V5biYezmCKVfl2IQyZ1OnYYew
         ir6P4pVW3ySRZkmEbLVdIIKNI3nKDVVkzD9XJDjaFU38RX8aSyhiaCRLZxIYISSiBYpb
         uIffTkLuDiFdg5xux1tFpxTOCmBoCTdFK2hLdJ2kmU+Z0PXhogR3k+Dg1TDQJgUBnEH3
         t3IVPD7t5GlG5OQ+Uqv/yOa37qnuCT+swcMLkWdfrZ3B+hSHhiv9y+fufVDU2ZKdK/Ib
         qeg8nfjWWtrV37YdbOj2AAn5NswVzJmR9y6/0IRXBXttM8BEqyfR8mnAZVxYqGVq4RuH
         Csqg==
X-Gm-Message-State: AOAM530QMnqFpnlljCz8mahB1YaVHytSXhZxu54C71rC7dp8Va7jpA/a
        QNniCg14o4HLLpCJzwHHKjVk6g==
X-Google-Smtp-Source: ABdhPJxQ37vwqiE2TisIUI4YCtqlIfqP8UXKGaNDP1xRz0ENxnu5+SGMhjjDvkZTEOTpKsWzJL8QIg==
X-Received: by 2002:a63:7981:: with SMTP id u123mr1865493pgc.29.1597920267833;
        Thu, 20 Aug 2020 03:44:27 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id 20sm2109640pgz.20.2020.08.20.03.44.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:44:27 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Thu, 20 Aug 2020 16:13:53 +0530
Message-Id: <e88128c48349723636b7c35e95289b50b27e235a.1597919647.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1597919647.git.viresh.kumar@linaro.org>
References: <cover.1597919647.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
find the OPP table with error -ENODEV (i.e. OPP table not present for
the device). And we can call dev_pm_opp_of_remove_table()
unconditionally here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 5a33389037cd..b7e47107a31a 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -263,7 +263,6 @@ struct sdhci_msm_host {
 	unsigned long clk_rate;
 	struct mmc_host *mmc;
 	struct opp_table *opp_table;
-	bool has_opp_table;
 	bool use_14lpp_dll_reset;
 	bool tuning_done;
 	bool calibration_done;
@@ -2285,9 +2284,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(&pdev->dev);
-	if (!ret) {
-		msm_host->has_opp_table = true;
-	} else if (ret != -ENODEV) {
+	if (ret != -ENODEV) {
 		dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
 		goto opp_cleanup;
 	}
@@ -2453,8 +2450,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
 				   msm_host->bulk_clks);
 opp_cleanup:
-	if (msm_host->has_opp_table)
-		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
 	dev_pm_opp_put_clkname(msm_host->opp_table);
 bus_clk_disable:
 	if (!IS_ERR(msm_host->bus_clk))
@@ -2474,8 +2470,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, dead);
 
-	if (msm_host->has_opp_table)
-		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
 	dev_pm_opp_put_clkname(msm_host->opp_table);
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.25.0.rc1.19.g042ed3e048af

