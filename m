Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A271E399DDE
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 11:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFCJgj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 05:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhFCJgi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 05:36:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0AAC06175F
        for <linux-pm@vger.kernel.org>; Thu,  3 Jun 2021 02:34:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n12so836352lft.10
        for <linux-pm@vger.kernel.org>; Thu, 03 Jun 2021 02:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Eupuj1h7Dw7kPQa+fb7IRdjjpTjghXD/2FhQTKixNA=;
        b=hcQbwMN5/aI9WJKYvwHHz/GG3QksGXbdsVkkESP4IrK/59OH/YfL+BT1qQEz4yOYJF
         pM1eUjngP4f4YU9m6RKyRwmxLYNcMSTeVU3SWwPHCt3N0LELKL5kkYTqppQ/kuIS8OwI
         5H3DLjClqpVU3XzggiO0evKdjKd3oBVRn93YwIJJ/mDs+kRAts5iD33T4SUrMblAEOgT
         uNvU1jPYQnA7TYp0Z9lCCo7UYSFkAM2m1yLGB/bkE7qpbae4RwbQ0q59A0KCTjonfvBG
         /jr0QhgiI2imH57Xmr/4wALgz0lRX0s2e+aAJBcTBg+cm9HerJmp6K+aFYrttViuL7Zm
         ha1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Eupuj1h7Dw7kPQa+fb7IRdjjpTjghXD/2FhQTKixNA=;
        b=sJ4AIu1S13QMt4U+YIKTkzLZCjjTOZP56TfAzRz9+INngFmOqLtyWBtjjEygkZ7EsG
         +mohvHZkDllsipGVZ8C3Wa3u41Ae1DX54NtVipnTA/adsF0+Oge7wjbBVNYX1JmIquhg
         Q23veTO/RHpM7h1U7R+CHe1HtZDwB5wChY/YnzYyHLpXCmSBio9XNlrC4ew2SuTHS70P
         FfBXMqtRdVjH7pT/Rwosw7YSQhV3gacRJNf7m4WWl6fZOEU3bzcdheLyHHKAuszd6oYv
         icBGszAwPzu0MbAagUZc/6vmJoQR58iVAgibYfMFjIdpC85qaEDlS5IwxXtNei8Q5b+q
         I9kg==
X-Gm-Message-State: AOAM533l4j0ir/H4vhN95DY2RdX5st1iiIw9c9FnFQ0Fp7Ak9dIFFtIM
        VIqvrCHi52cWc1sdHbam4QmuLQ==
X-Google-Smtp-Source: ABdhPJzfFepIAELPykTVo92DbsNR/ePHrcAl9pHysFlUDtDOoxKp4oHrS5nShW8i+ND8w/C6Am15zw==
X-Received: by 2002:a05:6512:696:: with SMTP id t22mr26277864lfe.581.1622712892227;
        Thu, 03 Jun 2021 02:34:52 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id q4sm263373lfc.172.2021.06.03.02.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 02:34:51 -0700 (PDT)
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
Subject: [PATCH v2 4/4] PM: domains: Drop/restore performance state votes for devices at system PM
Date:   Thu,  3 Jun 2021 11:34:38 +0200
Message-Id: <20210603093438.138705-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210603093438.138705-1-ulf.hansson@linaro.org>
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
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

Changes in v2:
	- Rebased.
	- A few cosmetic changes.

---
 drivers/base/power/domain.c | 9 +++++++++
 include/linux/pm_domain.h   | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e5d97174c254..a33e5b341f3f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1171,6 +1171,7 @@ static int genpd_prepare(struct device *dev)
  */
 static int genpd_finish_suspend(struct device *dev, bool poweroff)
 {
+	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
 	struct generic_pm_domain *genpd;
 	int ret = 0;
 
@@ -1201,6 +1202,7 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
 	}
 
 	genpd_lock(genpd);
+	gpd_data->pm_pstate = genpd_drop_performance_state(dev);
 	genpd->suspended_count++;
 	genpd_sync_power_off(genpd, true, 0);
 	genpd_unlock(genpd);
@@ -1245,6 +1247,7 @@ static int genpd_resume_noirq(struct device *dev)
 	genpd_lock(genpd);
 	genpd_sync_power_on(genpd, true, 0);
 	genpd->suspended_count--;
+	genpd_restore_performance_state(dev, dev_gpd_data(dev)->pm_pstate);
 	genpd_unlock(genpd);
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
@@ -1364,6 +1367,7 @@ static int genpd_restore_noirq(struct device *dev)
 	}
 
 	genpd_sync_power_on(genpd, true, 0);
+	genpd_restore_performance_state(dev, dev_gpd_data(dev)->pm_pstate);
 	genpd_unlock(genpd);
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
@@ -1409,23 +1413,28 @@ static void genpd_complete(struct device *dev)
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
+		gpd_data->pm_pstate = genpd_drop_performance_state(dev);
 		genpd->suspended_count++;
 		genpd_sync_power_off(genpd, use_lock, 0);
 	} else {
 		genpd_sync_power_on(genpd, use_lock, 0);
 		genpd->suspended_count--;
+		genpd_restore_performance_state(dev, gpd_data->pm_pstate);
 	}
 
 	if (use_lock)
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 21a0577305ef..f6e9dc28621c 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -199,6 +199,7 @@ struct generic_pm_domain_data {
 	int cpu;
 	unsigned int performance_state;
 	unsigned int rpm_pstate;
+	unsigned int pm_pstate;
 	ktime_t	next_wakeup;
 	void *data;
 };
-- 
2.25.1

