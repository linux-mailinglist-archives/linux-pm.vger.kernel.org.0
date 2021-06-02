Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD54398605
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 12:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhFBKOS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 06:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhFBKOR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 06:14:17 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3E8C061756
        for <linux-pm@vger.kernel.org>; Wed,  2 Jun 2021 03:12:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b18so2472769lfv.11
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 03:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KSQ/Hhdv/geuNZerNpw5PmMWOOCJZ7RFgPSp5JORONg=;
        b=IkG/6epNfEkZ1qT7vpb6Doka0wPZaljxQ/pa1Fi76aylVEMGZMdt0S46sfAP/7fNVM
         V81JWsEqBwjvDpbeGGqraXSw/dwEsUw3/rjoj+KWLwupUC9PYRuvScCpSJgCS5d38BeW
         eiaOvhiUuVhWtRpyTBcc/pKklqAJ01CqW8wxMWIjEHN9yh589IHdSmSzFsT5Iz9dvS3v
         I9BHqGMi32JjknuHwpUTdnvKbshxSx4xcl0QPfWnxmb2vYMi9DsIe5HAbMZvIZXb6k54
         yuvcIir/0Di6lDsdfebIF/pphyfwC4IGrTbteJReNWa3kK5ks6VFyXkXHOEhsrvImyPW
         iV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KSQ/Hhdv/geuNZerNpw5PmMWOOCJZ7RFgPSp5JORONg=;
        b=BIlr5vJ2Lm3SEi6m8E8+c4eb8yQxzTN5KD3YyYdwYlXvl+38VJXzmfGdXRDTfrU4bX
         hlUpDO/wSoeciYs6bp51csqpzzf5ehvWb+zRxSkeuy0BuoCU/6w0GBEX29J3/OxFTFCJ
         mdqJQKM7UVPjMpRPxPq0iwrXfmFE5/EquRnUOQEpgM+bnPQZH7LZKJKjs1odG9q+CXoN
         rxR54e0N7geNfbiVR1n3KeODDgp1Gq8ceoo7YskISh/54cBWay0nA1Zs2aq4xTw5g27X
         hv0y5vUYlBLG2NSh6raxUgM7oFnf6Pi2AnABl9Fe+pIDmmCLEgfh14vGjj0XhNHBcmQB
         PNyw==
X-Gm-Message-State: AOAM533b7yQGcYTBN9T6mUarrnweFlzr7Zltd13LIOZ9O+IN45lYsD3Z
        IR0sze9AAaXmjvIiT2m4ZpHSJA==
X-Google-Smtp-Source: ABdhPJx2vFqeoY4uP0jDdYZn95EyK+JpOwpNLIysagQIHxDH0hKmm4tvud9jfcRlkruXAxUZYhrZvg==
X-Received: by 2002:ac2:5237:: with SMTP id i23mr4873494lfl.22.1622628752661;
        Wed, 02 Jun 2021 03:12:32 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id y35sm1948938lfa.122.2021.06.02.03.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:12:31 -0700 (PDT)
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
Subject: [PATCH 2/3] PM: domains: Drop/restore performance state votes for devices at runtime PM
Date:   Wed,  2 Jun 2021 12:12:14 +0200
Message-Id: <20210602101215.78094-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602101215.78094-1-ulf.hansson@linaro.org>
References: <20210602101215.78094-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A subsystem/driver that need to manage OPPs for its device, should
typically drop its vote for the OPP when the device becomes runtime
suspended. In this way, the corresponding aggregation of the performance
state votes that is managed in genpd for the attached PM domain, may find
that the aggregated vote can be decreased. Hence, it may allow genpd to set
the lower performance state for the PM domain, thus avoiding to waste
energy.

To accomplish this, typically a subsystem/driver would need to call
dev_pm_opp_set_rate|opp() for its device from its ->runtime_suspend()
callback, to drop the vote for the OPP. Accordingly, it needs another call
to dev_pm_opp_set_rate|opp() to restore the vote for the OPP from its
->runtime_resume() callback.

To avoid boilerplate code in subsystems/driver to deal with these things,
let's instead manage this internally in genpd.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 21 +++++++++++++++++++--
 include/linux/pm_domain.h   |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a3b6e751f366..81b9d4652b90 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -397,6 +397,18 @@ static int genpd_set_performance_state(struct device *dev, unsigned int state)
 	return ret;
 }
 
+static int genpd_drop_performance_state(struct device *dev)
+{
+	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
+	unsigned int prev_state;
+
+	prev_state = gpd_data->performance_state;
+	if (prev_state && !genpd_set_performance_state(dev, 0))
+		return prev_state;
+
+	return 0;
+}
+
 /**
  * dev_pm_genpd_set_performance_state- Set performance state of device's power
  * domain.
@@ -839,7 +851,8 @@ static int genpd_runtime_suspend(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	bool (*suspend_ok)(struct device *__dev);
-	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
+	struct gpd_timing_data *td = &gpd_data->td;
 	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
@@ -896,6 +909,7 @@ static int genpd_runtime_suspend(struct device *dev)
 		return 0;
 
 	genpd_lock(genpd);
+	gpd_data->rpm_saved_pstate = genpd_drop_performance_state(dev);
 	genpd_power_off(genpd, true, 0);
 	genpd_unlock(genpd);
 
@@ -913,7 +927,8 @@ static int genpd_runtime_suspend(struct device *dev)
 static int genpd_runtime_resume(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
-	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
+	struct gpd_timing_data *td = &gpd_data->td;
 	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
@@ -937,6 +952,8 @@ static int genpd_runtime_resume(struct device *dev)
 
 	genpd_lock(genpd);
 	ret = genpd_power_on(genpd, 0);
+	if (!ret && gpd_data->rpm_saved_pstate)
+		genpd_set_performance_state(dev, gpd_data->rpm_saved_pstate);
 	genpd_unlock(genpd);
 
 	if (ret)
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index dfcfbcecc34b..c3d6c15788a3 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -198,6 +198,7 @@ struct generic_pm_domain_data {
 	struct notifier_block *power_nb;
 	int cpu;
 	unsigned int performance_state;
+	unsigned int rpm_saved_pstate;
 	ktime_t	next_wakeup;
 	void *data;
 };
-- 
2.25.1

