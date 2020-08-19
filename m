Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E24249A9A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 12:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgHSKli (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 06:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgHSKl1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 06:41:27 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BC6C061344
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 03:41:26 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m22so24792657ljj.5
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 03:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KZ6+UHIbVBHDAWxAlM3ATUhUkPp750TK89JntGb8KGk=;
        b=eqHxl6sgWAC7D+BQpSMtUxV0B7StzvgVfcDyTEA08E6mtrZB5/LfbrXlTT2vvCLyUb
         fish0uKFHQKEENO9VwlCA7jhMcyySws72fxlUqqtcbVt6tkWrF/2ngREysTpwzU5EyHe
         uxJHcmLtFlviFx3w5A489rwULsNuGwABe34RCJRBXiJUDAxMHDhtctkQS9IzVoIx0ZuT
         7GvpW6ODn619eV2y+08qOheaYpxFPZ1rIHwqEIHaaQARH/d/mETMjut5ZXK7q8neSM8r
         sCw+ZaAdpkCNVqo2qwJK17kE3TtOxkty4/eqwJmXsfVBto5W0w5ZZ021aWMYRxJAFcSu
         +Yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZ6+UHIbVBHDAWxAlM3ATUhUkPp750TK89JntGb8KGk=;
        b=Xmd9wAFcpsnaA/8aIT/zIxXjOlAvGn34ydwbpB4zJsKVBDVUwI7OEWSHBrKbN5CNWJ
         y8b44mcQVWx3QNaZOynLCgNvtb/C+fNqbAfjNlSIQGqKZjTMnypMfaFeg4xVtRxROjAC
         5PE5rkwq7Gr1eiCH3z+tooNMY7mbM0t+xK5x1g5gf8DDpmhdMtEcGw7I06q0xuodxnbs
         zXm2CnIhAYLs0OCB9IGkiEYrq++CosST06ITAlLmYPef18PixNakIJTD0h3U+7Sj9IwA
         dLYvDSmeWJ/KL9ET8sYqvn7Y811UgAC6h1itEA3Dqjdiz3rm1Akufb54cKsmqcOkMa+7
         Spqw==
X-Gm-Message-State: AOAM533Q47Mx3BewfXUcKmPlETCsv5hqnl3Qql+PmRfI0jEcW/Ex6d0r
        lM8QV2U7gaLZbl40ZapYKx9kEQ==
X-Google-Smtp-Source: ABdhPJxlSNzQXvCTCZGYjwTP2UKOt/Xj4UpdpG5DKosqqiXBiTTdOnhx0Q72Y0Z1Da5Z0IHl63f5AA==
X-Received: by 2002:a2e:3312:: with SMTP id d18mr11415054ljc.222.1597833684915;
        Wed, 19 Aug 2020 03:41:24 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id y13sm6534822ljd.19.2020.08.19.03.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 03:41:23 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PM / Domains: Rename power state enums for genpd
Date:   Wed, 19 Aug 2020 12:40:55 +0200
Message-Id: <20200819104057.318230-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819104057.318230-1-ulf.hansson@linaro.org>
References: <20200819104057.318230-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To clarify the code a bit, let's rename GPD_STATE_ACTIVE into
GENPD_STATE_ON and GPD_STATE_POWER_OFF to GENPD_STATE_OFF.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 32 ++++++++++++++++----------------
 include/linux/pm_domain.h   |  4 ++--
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2cb5e04cf86c..2ea99032b658 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -123,7 +123,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_lock_interruptible(p)	p->lock_ops->lock_interruptible(p)
 #define genpd_unlock(p)			p->lock_ops->unlock(p)
 
-#define genpd_status_on(genpd)		(genpd->status == GPD_STATE_ACTIVE)
+#define genpd_status_on(genpd)		(genpd->status == GENPD_STATE_ON)
 #define genpd_is_irq_safe(genpd)	(genpd->flags & GENPD_FLAG_IRQ_SAFE)
 #define genpd_is_always_on(genpd)	(genpd->flags & GENPD_FLAG_ALWAYS_ON)
 #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
@@ -222,7 +222,7 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
 	 * out of off and so update the idle time and vice
 	 * versa.
 	 */
-	if (genpd->status == GPD_STATE_ACTIVE) {
+	if (genpd->status == GENPD_STATE_ON) {
 		int state_idx = genpd->state_idx;
 
 		genpd->states[state_idx].idle_time =
@@ -563,7 +563,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 			return ret;
 	}
 
-	genpd->status = GPD_STATE_POWER_OFF;
+	genpd->status = GENPD_STATE_OFF;
 	genpd_update_accounting(genpd);
 
 	list_for_each_entry(link, &genpd->child_links, child_node) {
@@ -616,7 +616,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 	if (ret)
 		goto err;
 
-	genpd->status = GPD_STATE_ACTIVE;
+	genpd->status = GENPD_STATE_ON;
 	genpd_update_accounting(genpd);
 
 	return 0;
@@ -961,7 +961,7 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 	if (_genpd_power_off(genpd, false))
 		return;
 
-	genpd->status = GPD_STATE_POWER_OFF;
+	genpd->status = GENPD_STATE_OFF;
 
 	list_for_each_entry(link, &genpd->child_links, child_node) {
 		genpd_sd_counter_dec(link->parent);
@@ -1008,7 +1008,7 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 
 	_genpd_power_on(genpd, false);
 
-	genpd->status = GPD_STATE_ACTIVE;
+	genpd->status = GENPD_STATE_ON;
 }
 
 /**
@@ -1287,7 +1287,7 @@ static int genpd_restore_noirq(struct device *dev)
 		 * so make it appear as powered off to genpd_sync_power_on(),
 		 * so that it tries to power it on in case it was really off.
 		 */
-		genpd->status = GPD_STATE_POWER_OFF;
+		genpd->status = GENPD_STATE_OFF;
 
 	genpd_sync_power_on(genpd, true, 0);
 	genpd_unlock(genpd);
@@ -1777,7 +1777,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
-	genpd->status = is_off ? GPD_STATE_POWER_OFF : GPD_STATE_ACTIVE;
+	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
 	genpd->device_count = 0;
 	genpd->max_off_time_ns = -1;
 	genpd->max_off_time_changed = true;
@@ -2802,8 +2802,8 @@ static int genpd_summary_one(struct seq_file *s,
 			struct generic_pm_domain *genpd)
 {
 	static const char * const status_lookup[] = {
-		[GPD_STATE_ACTIVE] = "on",
-		[GPD_STATE_POWER_OFF] = "off"
+		[GENPD_STATE_ON] = "on",
+		[GENPD_STATE_OFF] = "off"
 	};
 	struct pm_domain_data *pm_data;
 	const char *kobj_path;
@@ -2881,8 +2881,8 @@ static int summary_show(struct seq_file *s, void *data)
 static int status_show(struct seq_file *s, void *data)
 {
 	static const char * const status_lookup[] = {
-		[GPD_STATE_ACTIVE] = "on",
-		[GPD_STATE_POWER_OFF] = "off"
+		[GENPD_STATE_ON] = "on",
+		[GENPD_STATE_OFF] = "off"
 	};
 
 	struct generic_pm_domain *genpd = s->private;
@@ -2895,7 +2895,7 @@ static int status_show(struct seq_file *s, void *data)
 	if (WARN_ON_ONCE(genpd->status >= ARRAY_SIZE(status_lookup)))
 		goto exit;
 
-	if (genpd->status == GPD_STATE_POWER_OFF)
+	if (genpd->status == GENPD_STATE_OFF)
 		seq_printf(s, "%s-%u\n", status_lookup[genpd->status],
 			genpd->state_idx);
 	else
@@ -2938,7 +2938,7 @@ static int idle_states_show(struct seq_file *s, void *data)
 		ktime_t delta = 0;
 		s64 msecs;
 
-		if ((genpd->status == GPD_STATE_POWER_OFF) &&
+		if ((genpd->status == GENPD_STATE_OFF) &&
 				(genpd->state_idx == i))
 			delta = ktime_sub(ktime_get(), genpd->accounting_time);
 
@@ -2961,7 +2961,7 @@ static int active_time_show(struct seq_file *s, void *data)
 	if (ret)
 		return -ERESTARTSYS;
 
-	if (genpd->status == GPD_STATE_ACTIVE)
+	if (genpd->status == GENPD_STATE_ON)
 		delta = ktime_sub(ktime_get(), genpd->accounting_time);
 
 	seq_printf(s, "%lld ms\n", ktime_to_ms(
@@ -2984,7 +2984,7 @@ static int total_idle_time_show(struct seq_file *s, void *data)
 
 	for (i = 0; i < genpd->state_count; i++) {
 
-		if ((genpd->status == GPD_STATE_POWER_OFF) &&
+		if ((genpd->status == GENPD_STATE_OFF) &&
 				(genpd->state_idx == i))
 			delta = ktime_sub(ktime_get(), genpd->accounting_time);
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ee11502a575b..66f3c5d64d81 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -64,8 +64,8 @@
 #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
 
 enum gpd_status {
-	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
-	GPD_STATE_POWER_OFF,	/* PM domain is off */
+	GENPD_STATE_ON = 0,	/* PM domain is on */
+	GENPD_STATE_OFF,	/* PM domain is off */
 };
 
 struct dev_power_governor {
-- 
2.25.1

