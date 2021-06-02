Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82337398608
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 12:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhFBKOT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 06:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhFBKOT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 06:14:19 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE2CC061574
        for <linux-pm@vger.kernel.org>; Wed,  2 Jun 2021 03:12:35 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e11so1849462ljn.13
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0PrEdqIlPYceQIvyi2h1VFOj+MhO3lHQ6Qic3TwKKo=;
        b=EKjLMkzjNM5QGZZKAD4GkhTXZVGHf1OP7Nrl6TRvTAVse+F7+u9GF2TiD674xJhTFH
         7L0niNMYpu7RF17IZF0iW0vkyzAAEtdj/RO5oV3gAWO+HjU22L4sXVMcHvjKC14gRiGD
         jsDabqkAp19sUFwQWKFZgB6LoEGS+PiO13sACnS59dGHV7OK3qIgj6bHu+Jo+RJrX1ri
         sftgT/pWXlmtVx9QqxPJkJpfJKU1sF3bqLVqXeHSzncWTDBpnpoVZJeGhKuW5/+Hs0gQ
         5CJvHdza4iOu+DKpTHLJWSKJ6HpjiyWCdlUKfOpZJ+d8ylSzqu4XfBGUEKa/K03viRaO
         djKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0PrEdqIlPYceQIvyi2h1VFOj+MhO3lHQ6Qic3TwKKo=;
        b=BlDQl2Vgu0zuPt7atvfvrqVmzF79Ft6MJ+X2H/Sd4GYuD6yutr0O4/SONSXoHuM1mi
         Vf4tgOCZYV1v4JxPydfYJl93CadFgV1bMzRPDLep+LhD084kBVcFfI/8MomFiaDJ0kgF
         VulOfu+6YQhaKCprlvB7m6rhDHuZHob82EBXyeFVVxVvhF5Pz8Hp3NScMoBTxY7/Vv/u
         2GK4d67tt0PgPIdh9U5yuUdMmmJnO3zwZiIOkHoN9QGruJs+4KGlFExjBPJjD3VhTK5r
         vlQSUGP+9MmyrP3XX0Mbn1Bn4ycjjJKRi7l+utAXj3NF5V3ltD/HYSQjU7QHnsqy53ck
         OtaQ==
X-Gm-Message-State: AOAM5304ogHNBvqiR87Ljl5P16JYjno3ePIqphPonAELFs/Im+KXxJ/L
        s3rmMWY4v8knUXOhdF1dAWJ/ag==
X-Google-Smtp-Source: ABdhPJyvYiEkPGa6Y6AXlYz/GT2pKU67zMM7rOxx5eSGTfjkkvNFuKoqZs0Td+mGvfPkiPvwGnNaUw==
X-Received: by 2002:a2e:b0c8:: with SMTP id g8mr6076534ljl.453.1622628754305;
        Wed, 02 Jun 2021 03:12:34 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id y35sm1948938lfa.122.2021.06.02.03.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:12:33 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PM: domains: Drop/restore performance state votes for devices at system PM
Date:   Wed,  2 Jun 2021 12:12:15 +0200
Message-Id: <20210602101215.78094-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602101215.78094-1-ulf.hansson@linaro.org>
References: <20210602101215.78094-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Recent changes in genpd drops and restore performance state votes for
devices during runtime PM.

For the similar reasons, but to avoid the same kind of boilerplate code in
device PM callbacks for system sleep in subsystems/drivers, let's drop and
restore performance states votes in genpd for the attached devices during
system sleep.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 14 ++++++++++++++
 include/linux/pm_domain.h   |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 81b9d4652b90..8487f1690deb 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1162,6 +1162,7 @@ static int genpd_prepare(struct device *dev)
  */
 static int genpd_finish_suspend(struct device *dev, bool poweroff)
 {
+	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
 	struct generic_pm_domain *genpd;
 	int ret = 0;
 
@@ -1192,6 +1193,7 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
 	}
 
 	genpd_lock(genpd);
+	gpd_data->pm_saved_pstate = genpd_drop_performance_state(dev);
 	genpd->suspended_count++;
 	genpd_sync_power_off(genpd, true, 0);
 	genpd_unlock(genpd);
@@ -1221,6 +1223,7 @@ static int genpd_suspend_noirq(struct device *dev)
  */
 static int genpd_resume_noirq(struct device *dev)
 {
+	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
 	struct generic_pm_domain *genpd;
 	int ret;
 
@@ -1236,6 +1239,8 @@ static int genpd_resume_noirq(struct device *dev)
 	genpd_lock(genpd);
 	genpd_sync_power_on(genpd, true, 0);
 	genpd->suspended_count--;
+	if (gpd_data->pm_saved_pstate)
+		genpd_set_performance_state(dev, gpd_data->pm_saved_pstate);
 	genpd_unlock(genpd);
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
@@ -1331,6 +1336,7 @@ static int genpd_poweroff_noirq(struct device *dev)
  */
 static int genpd_restore_noirq(struct device *dev)
 {
+	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
 	struct generic_pm_domain *genpd;
 	int ret = 0;
 
@@ -1355,6 +1361,8 @@ static int genpd_restore_noirq(struct device *dev)
 	}
 
 	genpd_sync_power_on(genpd, true, 0);
+	if (gpd_data->pm_saved_pstate)
+		genpd_set_performance_state(dev, gpd_data->pm_saved_pstate);
 	genpd_unlock(genpd);
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
@@ -1400,23 +1408,29 @@ static void genpd_complete(struct device *dev)
 static void genpd_switch_state(struct device *dev, bool suspend)
 {
 	struct generic_pm_domain *genpd;
+	struct generic_pm_domain_data *gpd_data;
 	bool use_lock;
 
 	genpd = dev_to_genpd_safe(dev);
 	if (!genpd)
 		return;
 
+	gpd_data = dev_gpd_data(dev);
+
 	use_lock = genpd_is_irq_safe(genpd);
 
 	if (use_lock)
 		genpd_lock(genpd);
 
 	if (suspend) {
+		gpd_data->pm_saved_pstate = genpd_drop_performance_state(dev);
 		genpd->suspended_count++;
 		genpd_sync_power_off(genpd, use_lock, 0);
 	} else {
 		genpd_sync_power_on(genpd, use_lock, 0);
 		genpd->suspended_count--;
+		if(gpd_data->pm_saved_pstate)
+			genpd_set_performance_state(dev, gpd_data->pm_saved_pstate);
 	}
 
 	if (use_lock)
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index c3d6c15788a3..3eb215ac8adf 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -199,6 +199,7 @@ struct generic_pm_domain_data {
 	int cpu;
 	unsigned int performance_state;
 	unsigned int rpm_saved_pstate;
+	unsigned int pm_saved_pstate;
 	ktime_t	next_wakeup;
 	void *data;
 };
-- 
2.25.1

