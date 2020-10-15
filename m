Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52D128F93E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 21:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgJOTKP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 15:10:15 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:28416 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728819AbgJOTKP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Oct 2020 15:10:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602789014; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=UPhL/Nm/bGPlTyHewg0ifW1DgwYgU7wia6oRTLPZE4E=; b=hgiBV/bIsYQ8LdbK5z+E5YzbPcPTnxD04P+G8gLwKxF7FM4l6qCsqtE3GT7Ma0gdIFMj9VSa
 Jj2PiUQnn7RJ2ObCZ3Ow6s4rSxHoqSbM91mDn7JhPhFkknE6OH19zNib7PITm4O6A2OGHNpr
 ifu9oQLn2lOZvo/2VmXMzP5jL9E=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f889e940764f13b0094d05b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Oct 2020 19:10:12
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 45F86C433FF; Thu, 15 Oct 2020 19:10:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A9BEC433CB;
        Thu, 15 Oct 2020 19:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A9BEC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v2 2/2] PM / Domains: use device's next wakeup to determine domain idle state
Date:   Thu, 15 Oct 2020 13:10:03 -0600
Message-Id: <20201015191003.1413-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015191003.1413-1-ilina@codeaurora.org>
References: <20201015191003.1413-1-ilina@codeaurora.org>
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
Changes in v2:
	- Fix state_idx type to hold negative value.
	- Update commit text.
---
 drivers/base/power/domain_governor.c | 83 ++++++++++++++++++++++++++--
 include/linux/pm_domain.h            |  1 +
 2 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 490ed7deb99a..2383421290f2 100644
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
+		next_wakeup = READ_ONCE(pdd->dev->power.next_event);
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
@@ -228,17 +298,20 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	genpd->max_off_time_ns = -1;
 	genpd->max_off_time_changed = false;
 	genpd->cached_power_down_ok = true;
-	genpd->state_idx = genpd->state_count - 1;
 
-	/* Find a state to power down to, starting from the deepest. */
-	while (!__default_power_down_ok(pd, genpd->state_idx)) {
-		if (genpd->state_idx == 0) {
+	/* Find a state to power down to, starting from the state
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
index ee11502a575b..9ea6f666967b 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -119,6 +119,7 @@ struct generic_pm_domain {
 				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
+	ktime_t next_wakeup;
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
 	bool cached_power_down_state_idx;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

