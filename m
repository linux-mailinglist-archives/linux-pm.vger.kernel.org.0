Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6482B2FD496
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 16:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733197AbhATPxX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 10:53:23 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:50685 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391171AbhATPwD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 10:52:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611157903; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=dMLbNJEGXzoM679Q50OxCv2q5Q2UInHzraIg7p9pWgs=; b=TJ0icM1M50zBvxMxgVvAafTWvY+JHSzr717hVP5MfpTuUCflpQrVJZRSXQWAsHssX56UAcWc
 D3fRrl5+23HZA6AZzgOeQXNxEpfBr6N3i2ZsmEMdpeEwomnwIqeTiNHoSeBqrXZ6TCbrODTA
 6n9d2Nh7aWFiUbDor++TbxLvn08=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6008515a2c36b2106d706e1e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Jan 2021 15:50:50
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5B3ADC43461; Wed, 20 Jan 2021 15:50:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A261C433CA;
        Wed, 20 Jan 2021 15:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A261C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     ulf.hansson@linaro.org, rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v9 2/2] PM / Domains: use device's next wakeup to determine domain idle state
Date:   Wed, 20 Jan 2021 08:50:42 -0700
Message-Id: <20210120155042.28975-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210120155042.28975-1-ilina@codeaurora.org>
References: <20210120155042.28975-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, a PM domain's idle state is determined based on whether the
QoS requirements are met. However, even entering an idle state may waste
power if the minimum residency requirements aren't fulfilled.

CPU PM domains use the next timer wakeup for the CPUs in the domain to
determine the sleep duration of the domain. This is compared with the
idle state residencies to determine the optimal idle state. For other PM
domains, determining the sleep length is not that straight forward. But
if the device's next_event is available, we can use that to determine
the sleep duration of the PM domain.

Let's update the domain governor logic to check for idle state residency
based on the next wakeup of devices as well as QoS constraints. But
since, not all domains may contain devices capable of specifying the
next wakeup, let's enable this additional check only if specified by the
domain's flags when initializing the domain.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes in v9:
	- None.
Changes in v8:
	- Whitespace fixes and added reviewed-by tag
Changes in v7:
	- Define GENPD_FLAG_MIN_RESIDENCY and check for min residency
	  only if the flag is set.
	- Update commit text.
Changes in v6:
	- Do not include power_on_latency_ns for next_wakeup
	  determination.
	- Re-organize code to avoid multiple ktime_get() reads.
	- Check genpd flag if next_wakeup is useful for the domain.
	- Document why we ignore stale data
Changes in v5:
	- Minor code changes suggested by Rafel
Changes in v4:
	- Update to use next_wakeup from struct generic_pm_domain_data.
Changes in v3:
	- None
Changes in v2:
	- Fix state_idx type to hold negative value.
	- Update commit text.
---
 drivers/base/power/domain_governor.c | 102 ++++++++++++++++++++++++---
 include/linux/pm_domain.h            |   6 ++
 2 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 490ed7deb99a..c6c218758f0b 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -117,6 +117,55 @@ static bool default_suspend_ok(struct device *dev)
 	return td->cached_suspend_ok;
 }
 
+static void update_domain_next_wakeup(struct generic_pm_domain *genpd, ktime_t now)
+{
+	ktime_t domain_wakeup = KTIME_MAX;
+	ktime_t next_wakeup;
+	struct pm_domain_data *pdd;
+	struct gpd_link *link;
+
+	if (!(genpd->flags & GENPD_FLAG_MIN_RESIDENCY))
+		return;
+
+	/*
+	 * Devices that have a predictable wakeup pattern, may specify
+	 * their next wakeup. Let's find the next wakeup from all the
+	 * devices attached to this domain and from all the sub-domains.
+	 * It is possible that component's a next wakeup may have become
+	 * stale when we read that here. We will ignore to ensure the domain
+	 * is able to enter its optimal idle state.
+	 */
+	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		next_wakeup = to_gpd_data(pdd)->next_wakeup;
+		if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
+			if (ktime_before(next_wakeup, domain_wakeup))
+				domain_wakeup = next_wakeup;
+	}
+
+	list_for_each_entry(link, &genpd->parent_links, parent_node) {
+		next_wakeup = link->child->next_wakeup;
+		if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
+			if (ktime_before(next_wakeup, domain_wakeup))
+				domain_wakeup = next_wakeup;
+	}
+
+	genpd->next_wakeup = domain_wakeup;
+}
+
+static bool next_wakeup_allows_state(struct generic_pm_domain *genpd,
+				     unsigned int state, ktime_t now)
+{
+	ktime_t domain_wakeup = genpd->next_wakeup;
+	s64 idle_time_ns, min_sleep_ns;
+
+	min_sleep_ns = genpd->states[state].power_off_latency_ns +
+		       genpd->states[state].residency_ns;
+
+	idle_time_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
+
+	return idle_time_ns >= min_sleep_ns;
+}
+
 static bool __default_power_down_ok(struct dev_pm_domain *pd,
 				     unsigned int state)
 {
@@ -201,16 +250,41 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
 }
 
 /**
- * default_power_down_ok - Default generic PM domain power off governor routine.
+ * _default_power_down_ok - Default generic PM domain power off governor routine.
  * @pd: PM domain to check.
  *
  * This routine must be executed under the PM domain's lock.
  */
-static bool default_power_down_ok(struct dev_pm_domain *pd)
+static bool _default_power_down_ok(struct dev_pm_domain *pd, ktime_t now)
 {
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	int state_idx = genpd->state_count - 1;
 	struct gpd_link *link;
 
+	/*
+	 * Find the next wakeup from devices that can determine their own wakeup
+	 * to find when the domain would wakeup and do it for every device down
+	 * the hierarchy. It is not worth while to sleep if the state's residency
+	 * cannot be met.
+	 */
+	update_domain_next_wakeup(genpd, now);
+	if ((genpd->flags & GENPD_FLAG_MIN_RESIDENCY) && (genpd->next_wakeup != KTIME_MAX)) {
+		/* Let's find out the deepest domain idle state, the devices prefer */
+		while (state_idx >= 0) {
+			if (next_wakeup_allows_state(genpd, state_idx, now)) {
+				genpd->max_off_time_changed = true;
+				break;
+			}
+			state_idx--;
+		}
+
+		if (state_idx < 0) {
+			state_idx = 0;
+			genpd->cached_power_down_ok = false;
+			goto done;
+		}
+	}
+
 	if (!genpd->max_off_time_changed) {
 		genpd->state_idx = genpd->cached_power_down_state_idx;
 		return genpd->cached_power_down_ok;
@@ -228,21 +302,30 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	genpd->max_off_time_ns = -1;
 	genpd->max_off_time_changed = false;
 	genpd->cached_power_down_ok = true;
-	genpd->state_idx = genpd->state_count - 1;
 
-	/* Find a state to power down to, starting from the deepest. */
-	while (!__default_power_down_ok(pd, genpd->state_idx)) {
-		if (genpd->state_idx == 0) {
+	/*
+	 * Find a state to power down to, starting from the state
+	 * determined by the next wakeup.
+	 */
+	while (!__default_power_down_ok(pd, state_idx)) {
+		if (state_idx == 0) {
 			genpd->cached_power_down_ok = false;
 			break;
 		}
-		genpd->state_idx--;
+		state_idx--;
 	}
 
+done:
+	genpd->state_idx = state_idx;
 	genpd->cached_power_down_state_idx = genpd->state_idx;
 	return genpd->cached_power_down_ok;
 }
 
+static bool default_power_down_ok(struct dev_pm_domain *pd)
+{
+	return _default_power_down_ok(pd, ktime_get());
+}
+
 static bool always_on_power_down_ok(struct dev_pm_domain *domain)
 {
 	return false;
@@ -254,11 +337,12 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct cpuidle_device *dev;
 	ktime_t domain_wakeup, next_hrtimer;
+	ktime_t now = ktime_get();
 	s64 idle_duration_ns;
 	int cpu, i;
 
 	/* Validate dev PM QoS constraints. */
-	if (!default_power_down_ok(pd))
+	if (!_default_power_down_ok(pd, now))
 		return false;
 
 	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
@@ -280,7 +364,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	}
 
 	/* The minimum idle duration is from now - until the next wakeup. */
-	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, ktime_get()));
+	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
 	if (idle_duration_ns <= 0)
 		return false;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 735583c0bc6d..dfcfbcecc34b 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -56,6 +56,10 @@
  *
  * GENPD_FLAG_RPM_ALWAYS_ON:	Instructs genpd to always keep the PM domain
  *				powered on except for system suspend.
+ *
+ * GENPD_FLAG_MIN_RESIDENCY:	Enable the genpd governor to consider its
+ *				components' next wakeup when determining the
+ *				optimal idle state.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -63,6 +67,7 @@
 #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
 #define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
 #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
+#define GENPD_FLAG_MIN_RESIDENCY (1U << 6)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
@@ -130,6 +135,7 @@ struct generic_pm_domain {
 				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
+	ktime_t next_wakeup;	/* Maintained by the domain governor */
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
 	bool cached_power_down_state_idx;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

