Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA66255452
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 08:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgH1GI5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 02:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgH1GI1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 02:08:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A68C061264
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 23:08:27 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t11so1426723plr.5
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 23:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1O4RY3xhuvkoEFzZpCQj6200V2Vqk24TL8ijKSG6Muc=;
        b=YHxrgc08UC1m38a1Dl9/EMqZvlm1VnCvNkcD5izm8rqm0YvG045fdqTeSSWU3zP84e
         BcHHK7aom3QnCZXtUYQLKNwtzO8Ep+4tdG162+rjOVRMJzAe9ar/ApD7pQMI2nyLOMUH
         VHxAUkL2Zi7UuCJwfo7ZzxrnFHu1NDpn9oVgClh9Tx+29Pdty6EV9otz6UhKGUR891SW
         wkvRExXAFgi7fFHZQNrEqAV0/zj9YKpaYfC9Dhuk56XSCOmiDcaepwAo98fzbxuDipUH
         6vj1UnT8LoXRzXROKT2eUIwLnX1yD4R4GhACqleeeiYO5gST/E+Tw2Aaja92+f/5DDMD
         pKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1O4RY3xhuvkoEFzZpCQj6200V2Vqk24TL8ijKSG6Muc=;
        b=l+wSRg8MckVad+0VSkRIo68gF3UgtddWszZZeJteVBRf/4206IO9FYRfVcCoJ6rVsr
         udl2qJ4wGnMw6o1Jb4F7Xlg6QprT0Q1HPtj54OeD8fmM2GAKkKuNhGybVP1hVmSC980f
         BfoMmzKSHt75Mz8M8UGCakfaZ4kvfoMtBgBRw5p7s5o0sirb1RcTFmYwIIVmcH0Ygvzt
         sC9L0LURqCNWZayhGSOlD0/CFDfr0UArGXWET6qfGUN1cvb9xExqVakxIYuIML2+bT1m
         u5YU+QIRaRvPhtEJyrdhXKQtAmh1zqn222P3EW8n2vtvlAoL0Cqz2zyNwxwV64FKs6ng
         GWHg==
X-Gm-Message-State: AOAM5326dKkPuculX/DyIBKp+q96diCGosogFG/XghjYXGhx6Ex+nsDM
        mXx6icVgtpaXRWDwX7q3EAEOsg==
X-Google-Smtp-Source: ABdhPJzzOn4s+bHlp/tecgCMbtWwHe8wbvcQ++dsCXro+voefVp33ciwr2Rsvu03Ia3822LnjIRAVw==
X-Received: by 2002:a17:902:76c3:: with SMTP id j3mr73551plt.227.1598594906914;
        Thu, 27 Aug 2020 23:08:26 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id d76sm169607pfd.63.2020.08.27.23.08.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 23:08:26 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/8] mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Fri, 28 Aug 2020 11:37:49 +0530
Message-Id: <1d7c97524b9e1fbc60271d9c246c5461ca8a106c.1598594714.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1598594714.git.viresh.kumar@linaro.org>
References: <cover.1598594714.git.viresh.kumar@linaro.org>
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
V2:
- Compare with -ENODEV only for failures.
- Create new label to put clkname.
---
 drivers/mmc/host/sdhci-msm.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 5a33389037cd..f7beaec6412e 100644
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
@@ -2285,11 +2284,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(&pdev->dev);
-	if (!ret) {
-		msm_host->has_opp_table = true;
-	} else if (ret != -ENODEV) {
+	if (ret && ret != -ENODEV) {
 		dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
-		goto opp_cleanup;
+		goto opp_put_clkname;
 	}
 
 	/* Vote for maximum clock rate for maximum performance */
@@ -2453,8 +2450,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
 				   msm_host->bulk_clks);
 opp_cleanup:
-	if (msm_host->has_opp_table)
-		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
+opp_put_clkname:
 	dev_pm_opp_put_clkname(msm_host->opp_table);
 bus_clk_disable:
 	if (!IS_ERR(msm_host->bus_clk))
@@ -2474,8 +2471,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, dead);
 
-	if (msm_host->has_opp_table)
-		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
 	dev_pm_opp_put_clkname(msm_host->opp_table);
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.25.0.rc1.19.g042ed3e048af

