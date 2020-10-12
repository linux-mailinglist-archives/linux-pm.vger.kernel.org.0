Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5969E28C4D3
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 00:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390051AbgJLWei (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 18:34:38 -0400
Received: from z5.mailgun.us ([104.130.96.5]:41500 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390273AbgJLWeh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Oct 2020 18:34:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602542076; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=XKpGBpZzmWhm7bXNsIqJEj46Bl1p8p5AhOlTFIJPcJ8=; b=RIoXMIHD/6S7kjElmvfgQDyX0TfMZgggLvqJ3fYkgk1qOMNWbIY4z6nGxGIHIMOcZtQQnMAE
 E6/3ZBjGahcGAljcqkMaP2MwZhKo8YlnmoNwj9SfKdoLvfBAZdo44j8Dc3YUqneXDPoytMDG
 HRDY3TYIFX2aTiaq4eiXy9z14ss=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f84d9fb3711fec7b1a221d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 12 Oct 2020 22:34:35
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 276BCC433F1; Mon, 12 Oct 2020 22:34:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8C77C433FF;
        Mon, 12 Oct 2020 22:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8C77C433FF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH 2/2] PM / Domains: use device's next wakeup to determine domain idle state
Date:   Mon, 12 Oct 2020 16:34:00 -0600
Message-Id: <20201012223400.23609-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012223400.23609-1-ilina@codeaurora.org>
References: <20201012223400.23609-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/base/power/domain_governor.c | 83 ++++++++++++++++++++++++++--
 include/linux/pm_domain.h            |  1 +
 2 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 490ed7deb99a..77b4928aa389 100644
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

