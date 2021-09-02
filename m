Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F74D3FEBEE
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 12:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhIBKRj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 06:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbhIBKRj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 06:17:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C75C061575
        for <linux-pm@vger.kernel.org>; Thu,  2 Sep 2021 03:16:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h16so262038lfk.10
        for <linux-pm@vger.kernel.org>; Thu, 02 Sep 2021 03:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TywneFOHqk/q2lDRXrfDY/E+kQPlWfGyGjEe/NIEHS0=;
        b=M8h86JEIQRSZsTCGeR6pJ1N/QzA6dqeytHrr1+dBQeZWjNPOTfftT1ZYil39lLRzuI
         /+Mky0RdvsbyLL56yPCl536D0WeL6Ge+/lZDCk/exQAWqKxd9H+o0c01eHWWwglrUpRP
         T6rYxeocRQZ2uxuTa8X72ndaRdn68a92qloDdxFsAlvY20Bty0tO/O4xi8qRis2n3Uyj
         xn7vV44D7K9e9DDVNFJGpwAFpNChcqJ05ELDkXzVr7LS4MsxrnJlysoa9m4Jne+TX+2S
         n+rhCEQYf762oGA3FnjWzLpElbBMOKWMDCywomJ+uxGYYqNIm+KR9x2U1gRDD2z1NdW6
         QERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TywneFOHqk/q2lDRXrfDY/E+kQPlWfGyGjEe/NIEHS0=;
        b=FEYpE1kyYiRstsa4ZZpMNtf9mmMasp9rg7zSSFGiplo8SCyP37ux3U4ADaf7MoeXJU
         b/ogknW/dzCrbPbVwRpulnAOY7fJn6mKdDQP/A/IcfMZn4pg8w8PZ5gcNTJukoX4adpU
         A/FQj6n8VP/hVIaqhJ+N7BEpRVBc5SRT1tbVo08ah9DxU4Ra/zBRWvHwjOrbjlvgrM83
         J/JhXFaY3L6mAdb3I9jLY4gZLR+WZ8PIe7wigNY7IBb6XLH0N1qGxidkoMHdKhOUo0wH
         y2e1kI1WJ+rywTt3DHmVOKzkzGTDHxMUvTij+mDU0DM6QcQvAb5tyXjME/isYgoxBsIk
         Mwkw==
X-Gm-Message-State: AOAM532qOifrzHNqZ9k5cV6aC1hDZqw/4pqezQ7ResH/Ai9SWEOsNSLi
        ajfCdlSKsPDjOpZU3PquAG+f3w==
X-Google-Smtp-Source: ABdhPJz03CxOy2DhzYQaRQsDsXZhX9SfdHEpc+fmAhDjGziDxiaA2v5/+BLy2btECx3VnNmdVU+HUQ==
X-Received: by 2002:a05:6512:3091:: with SMTP id z17mr1987212lfd.418.1630577799097;
        Thu, 02 Sep 2021 03:16:39 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id s4sm155897lfd.53.2021.09.02.03.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 03:16:38 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] PM: domains: Drop the performance state vote for a device at detach
Date:   Thu,  2 Sep 2021 12:16:32 +0200
Message-Id: <20210902101634.827187-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902101634.827187-1-ulf.hansson@linaro.org>
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When a device is detached from its genpd, genpd loses track of the device,
including its performance state vote that may have been requested for it.

Rather than relying on the consumer driver to drop the performance state
vote for its device, let's do it internally in genpd when the device is
getting detached. In this way, we makes sure that the aggregation of the
votes in genpd becomes correct.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 9 ++-------
 include/linux/pm_domain.h   | 1 -
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5db704f02e71..278e040f607f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1665,6 +1665,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 		goto out;
 	}
 
+	genpd_set_performance_state(dev, 0);
+
 	genpd->device_count--;
 	genpd->max_off_time_changed = true;
 
@@ -2604,12 +2606,6 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
 	dev_dbg(dev, "removing from PM domain %s\n", pd->name);
 
-	/* Drop the default performance state */
-	if (dev_gpd_data(dev)->default_pstate) {
-		dev_pm_genpd_set_performance_state(dev, 0);
-		dev_gpd_data(dev)->default_pstate = 0;
-	}
-
 	for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
 		ret = genpd_remove_device(pd, dev);
 		if (ret != -EAGAIN)
@@ -2702,7 +2698,6 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 		ret = dev_pm_genpd_set_performance_state(dev, pstate);
 		if (ret)
 			goto err;
-		dev_gpd_data(dev)->default_pstate = pstate;
 	}
 	return 1;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 67017c9390c8..21a0577305ef 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -198,7 +198,6 @@ struct generic_pm_domain_data {
 	struct notifier_block *power_nb;
 	int cpu;
 	unsigned int performance_state;
-	unsigned int default_pstate;
 	unsigned int rpm_pstate;
 	ktime_t	next_wakeup;
 	void *data;
-- 
2.25.1

