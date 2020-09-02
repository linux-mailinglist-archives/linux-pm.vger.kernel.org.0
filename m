Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FCA25B745
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 01:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgIBX1F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 19:27:05 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:35991 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbgIBX1D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 19:27:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599089222; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=34yRl6SFaHTyY3yXT+BcH3cX7lVCd0YuybGYSb/eyPw=; b=iXiYlrCGSJH2n0Q0HSi6yHWW8qsqiz8iCiac5iG/YTRhG2Mldg032Ucl10FntBL+PSdiYcD/
 t6dt3j3+CFSnb+vMDlb8rMbG4mUJg2zb2jZTqr9YEQLgaorNWnHdLHAWmvAMxG0iOo64DEUn
 O+gvTPuLmlXjnf2uK+EOgYNGQ74=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f502a3b73afa3417eb8cc80 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 23:26:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 49EC4C433A1; Wed,  2 Sep 2020 23:26:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A748C43391;
        Wed,  2 Sep 2020 23:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A748C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [RFC PATCH 2/2] PM / Domains: use device's next wakeup to determine domain idle state
Date:   Wed,  2 Sep 2020 17:25:46 -0600
Message-Id: <20200902232546.31240-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902232546.31240-1-ilina@codeaurora.org>
References: <20200902232546.31240-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If the device's next event is known, determine if it is worthwhile
entering a domain idle state. To find the next wakeup, traverse a domain
for all child devices and find out the earliest wakeup value. A parent
domain's next wakeup is the earliest of all its child devices and
domains. The next wakeup is specified by devices in the domains before
they devices are suspended.

Update the domain governor logic to determine if it is worthwhile to
enter an idle state based on the next wakeup for the domain along with
other existing constraints.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/base/power/domain_governor.c | 87 ++++++++++++++++++++++++++--
 include/linux/pm_domain.h            |  1 +
 2 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 490ed7deb99a..a71d7281e9c1 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -117,6 +117,56 @@ static bool default_suspend_ok(struct device *dev)
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
+		if (pdd->dev->power.next_event != KTIME_MAX &&
+		    !ktime_before(pdd->dev->power.next_event, now)) {
+			next_wakeup = READ_ONCE(pdd->dev->power.next_event);
+			if (ktime_before(next_wakeup, domain_wakeup))
+				domain_wakeup = next_wakeup;
+		}
+	}
+
+	/* Then find the earliest wakeup of from all the child domains */
+	list_for_each_entry(link, &genpd->parent_links, parent_node) {
+		struct generic_pm_domain *sd = link->child;
+
+		next_wakeup = sd->next_wakeup;
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
+	if (domain_wakeup == KTIME_MAX)
+		return true;
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
@@ -210,6 +260,29 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 {
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct gpd_link *link;
+	unsigned int state_idx;
+	ktime_t now = ktime_get();
+
+	/*
+	 * Find the next wakeup from devices that can determine their own wakeup
+	 * to find when the domain would wakeup and do it for every device down
+	 * the hierarchy. It is not worth while to sleep if the state's residency
+	 * cannot be met.
+	 */
+	update_domain_next_wakeup(genpd, now);
+
+	/* Let's find out what domain idle state, the devices prefer */
+	genpd->state_idx = state_idx = genpd->state_count - 1;
+	while (!next_wakeup_allows_state(genpd, state_idx, now)) {
+		if (!state_idx) {
+			genpd->cached_power_down_ok = false;
+			return false;
+		}
+		state_idx--;
+	}
+
+	genpd->max_off_time_changed =
+		(state_idx == genpd->cached_power_down_state_idx);
 
 	if (!genpd->max_off_time_changed) {
 		genpd->state_idx = genpd->cached_power_down_state_idx;
@@ -228,18 +301,20 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
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
 
-	genpd->cached_power_down_state_idx = genpd->state_idx;
+	genpd->state_idx = state_idx;
+	genpd->cached_power_down_state_idx = state_idx;
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

