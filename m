Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89568399DE0
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 11:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFCJgu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 05:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFCJgu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 05:36:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138F5C06174A
        for <linux-pm@vger.kernel.org>; Thu,  3 Jun 2021 02:34:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f11so7825861lfq.4
        for <linux-pm@vger.kernel.org>; Thu, 03 Jun 2021 02:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nq0h2Rai/tpUtSdSLeC5esAyt1vXtkpXm4C0UDmlQDU=;
        b=hvMBLrYHCWMkWfU02Uc00BYq14sjtXmNCStD4dBtsXGCWBEjBBlJ9efW5N1AKdpqP7
         qrJnw+wWMzym/dBQYz45G2EhMvy/qWPkOd0m1PVBGC1NSzC2zxptrE01rJ1oJMSx3+nR
         ynDBRJO3tF4ZGcO7EWiBJUrx/5yloKy28jlr91fFiFglRRVejNwXUBgGhYWx6+i8ao3t
         qI/5ZevLBZwv7jGf9yxW/MJ0wLcoReVVlDUNbJWNCpxwb478Sb/fCg93UmihIUKSNe6D
         GfXjjW9ftXQfcPuz0+XRQJeqK+HNi6BZlMMF9jy5IWfTZurZ5d+GNelIO0vMeiP5Gs6K
         1YRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nq0h2Rai/tpUtSdSLeC5esAyt1vXtkpXm4C0UDmlQDU=;
        b=fwGpCE6Dz54VgKY11wKHrdB8/WALpWBoV9v4g4hxiQ7SS6v00oemSrPfkKO5S9Nya8
         AM3DUV0qKtYVRMMKsuV5FM1QhKjS/G7MnyaMsDwJitWy2klEZm5GhfzE3+KMQ6uGckYz
         Y9RzzLE8hFHAog+5jIWulKNqBQsK3JLbciRAtm59Peph/aCL8nF+EXqSkbfn15jqB993
         b5kjnAwJMzoOmJz0q4FbkemFAO4cYt0910vQqIEQb6zxbyZz9PoDnHbX8/IjniDF3nY2
         /NDjwecUZJDk5Co51DKz8Pl/10YbbzRdm8fBNMsReQ76v+xwp6Sy1h8PiNjqTFr1q+bU
         3Lsw==
X-Gm-Message-State: AOAM531rISiK3SQ0206/IFLFXqRd9fnvZEvY6AvB08aHIby9J30d/i0E
        fq/HqvsFTHHwKvSdWvMhyBWloWIYOB+0fPYs
X-Google-Smtp-Source: ABdhPJxpFSsYKrqvgqC4Q7kRSbSGZehZRwk2RDVpSloOM744iqlLBfS8I/728O1G7Wf6U2RfB4aqgQ==
X-Received: by 2002:a19:484d:: with SMTP id v74mr17856139lfa.396.1622712890381;
        Thu, 03 Jun 2021 02:34:50 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id q4sm263373lfc.172.2021.06.03.02.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 02:34:49 -0700 (PDT)
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
Subject: [PATCH v2 3/4] PM: domains: Drop/restore performance state votes for devices at runtime PM
Date:   Thu,  3 Jun 2021 11:34:37 +0200
Message-Id: <20210603093438.138705-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210603093438.138705-1-ulf.hansson@linaro.org>
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
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

Changes in v2:
	- Rebased.
	- A few minor cosmetic changes.
	- Deal with the error path in genpd_runtime_resume().

---
 drivers/base/power/domain.c | 27 +++++++++++++++++++++++++--
 include/linux/pm_domain.h   |  1 +
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ef25a5b18587..e5d97174c254 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -400,6 +400,23 @@ static int genpd_set_performance_state(struct device *dev, unsigned int state)
 	return ret;
 }
 
+static int genpd_drop_performance_state(struct device *dev)
+{
+	unsigned int prev_state = dev_gpd_data(dev)->performance_state;
+
+	if (!genpd_set_performance_state(dev, 0))
+		return prev_state;
+
+	return 0;
+}
+
+static void genpd_restore_performance_state(struct device *dev,
+					    unsigned int state)
+{
+	if (state)
+		genpd_set_performance_state(dev, state);
+}
+
 /**
  * dev_pm_genpd_set_performance_state- Set performance state of device's power
  * domain.
@@ -842,7 +859,8 @@ static int genpd_runtime_suspend(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	bool (*suspend_ok)(struct device *__dev);
-	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
+	struct gpd_timing_data *td = &gpd_data->td;
 	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
@@ -899,6 +917,7 @@ static int genpd_runtime_suspend(struct device *dev)
 		return 0;
 
 	genpd_lock(genpd);
+	gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 	genpd_power_off(genpd, true, 0);
 	genpd_unlock(genpd);
 
@@ -916,7 +935,8 @@ static int genpd_runtime_suspend(struct device *dev)
 static int genpd_runtime_resume(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
-	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
+	struct gpd_timing_data *td = &gpd_data->td;
 	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
@@ -940,6 +960,8 @@ static int genpd_runtime_resume(struct device *dev)
 
 	genpd_lock(genpd);
 	ret = genpd_power_on(genpd, 0);
+	if (!ret)
+		genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
 	genpd_unlock(genpd);
 
 	if (ret)
@@ -978,6 +1000,7 @@ static int genpd_runtime_resume(struct device *dev)
 err_poweroff:
 	if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
 		genpd_lock(genpd);
+		gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 		genpd_power_off(genpd, true, 0);
 		genpd_unlock(genpd);
 	}
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index dfcfbcecc34b..21a0577305ef 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -198,6 +198,7 @@ struct generic_pm_domain_data {
 	struct notifier_block *power_nb;
 	int cpu;
 	unsigned int performance_state;
+	unsigned int rpm_pstate;
 	ktime_t	next_wakeup;
 	void *data;
 };
-- 
2.25.1

