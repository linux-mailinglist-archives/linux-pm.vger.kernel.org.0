Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D32941DB
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 20:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408937AbgJTSFK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 14:05:10 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:60344 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732754AbgJTSFK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Oct 2020 14:05:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603217109; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=REiWRbqb5w7gH7cls1Og+mMVltAyJSA8n85lHc2qN1U=; b=Vu1rLpRmxRKK00SK7p4bnkXGcXWuDtffw5iZ+zCWezkFUhd+mzrypTdqWh1R1QCpYe1gjsLO
 C2a8zAw4jhP3uv17BPlU6wn+z6AbxmDNE9aAzL/IB9HX40peaBxsOMdnUB++70tmC33yUoLw
 g7Gf6xSAlUsiCCMXQzgvqZzIDWg=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f8f26b00764f13b008d5e93 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 20 Oct 2020 18:04:32
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 41405C433F1; Tue, 20 Oct 2020 18:04:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 360BAC433FF;
        Tue, 20 Oct 2020 18:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 360BAC433FF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v4 2/2] PM / Domains: use device's next wakeup to determine domain idle state
Date:   Tue, 20 Oct 2020 12:04:13 -0600
Message-Id: <20201020180413.32225-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020180413.32225-1-ilina@codeaurora.org>
References: <20201020180413.32225-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, a PM domain's idle state is determined based on whether the
QoS requirements are met. This may not save power, if the idle state
residency requirements are not met.

CPU PM domains use the next timer wakeup for the CPUs in the domain to
determine the sleep duration of the domain. This is compared with the
idle state residencies to determine the optimal idle state. For other PM
domains, determining the sleep length is not that straight forward. But
if the device's next_event is available, we can use that to determine
the sleep duration of the PM domain.

Let's update the domain governor logic to check for idle state residency
based on the next wakeup of devices as well as QoS constraints.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
Changes in v4:
	- Update to use next_wakeup from struct generic_pm_domain_data.
Changes in v3:
	- None
Changes in v2:
	- Fix state_idx type to hold negative value.
	- Update commit text.
---
 drivers/base/power/domain_governor.c | 84 ++++++++++++++++++++++++++--
 include/linux/pm_domain.h            |  1 +
 2 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 490ed7deb99a..092927b60dc0 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -117,6 +117,49 @@ static bool default_suspend_ok(struct device *dev)
 	return td->cached_suspend_ok;
 }
 
+static void update_domain_next_wakeup(struct generic_pm_domain *genpd, ktime_t now)
+{
+	ktime_t domain_wakeup = KTIME_MAX;
+	ktime_t next_wakeup;
+	struct pm_domain_data *pdd;
+	struct gpd_link *link;
+
+	/* Find the earliest wakeup for all devices in the domain */
+	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		next_wakeup = to_gpd_data(pdd)->next_wakeup;
+		if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
+			if (ktime_before(next_wakeup, domain_wakeup))
+				domain_wakeup = next_wakeup;
+	}
+
+	/* Then find the earliest wakeup of from all the child domains */
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
+	s64 idle_time_ns, min_sleep_ns;
+	ktime_t domain_wakeup = genpd->next_wakeup;
+
+	min_sleep_ns = genpd->states[state].power_off_latency_ns +
+		       genpd->states[state].power_on_latency_ns +
+		       genpd->states[state].residency_ns;
+
+	idle_time_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
+	if (idle_time_ns < min_sleep_ns)
+		return false;
+
+	return true;
+}
+
 static bool __default_power_down_ok(struct dev_pm_domain *pd,
 				     unsigned int state)
 {
@@ -210,6 +253,33 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 {
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct gpd_link *link;
+	int state_idx;
+	ktime_t now = ktime_get();
+
+	/*
+	 * Find the next wakeup from devices that can determine their own wakeup
+	 * to find when the domain would wakeup and do it for every device down
+	 * the hierarchy. It is not worth while to sleep if the state's residency
+	 * cannot be met.
+	 */
+	update_domain_next_wakeup(genpd, now);
+	state_idx = genpd->state_count - 1;
+	if (genpd->next_wakeup != KTIME_MAX) {
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
 
 	if (!genpd->max_off_time_changed) {
 		genpd->state_idx = genpd->cached_power_down_state_idx;
@@ -228,17 +298,21 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
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
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index e00c77b1efd8..205b750a2e56 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -130,6 +130,7 @@ struct generic_pm_domain {
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

