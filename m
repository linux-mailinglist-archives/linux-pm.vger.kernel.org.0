Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7C0276F52
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 13:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgIXLGR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 07:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgIXLGQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 07:06:16 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EDDC0613D3
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 04:06:16 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c2so2333916ljj.12
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 04:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rLopvQrJpLUDqmj8LU9atUffkZGt0vm6zsb0hp7AK58=;
        b=wvcRRsSvhqV6/9Q6s7YiZ+xs12EtQc5ccJUikKs3Qu4pVZqzgGRQ4eRGNt3NyG4jZS
         vz2iWC8lkiFCM0Kb/P+XhVsxQTCJNTZ0tEVw5eGWvJZG6IvzU1BOfH9Twnj6HprWuz1n
         t8vqUn2XuKlu2hYk0V5YEpT9MuEznOXCNfdx5Yfg6zUrjFXKxJ3BZe3z0VKO2k2MsNrL
         cvD0ksN/Ldr8fnidbDytW6HYMCIjNlHUvCUlsJ0XoFVytbCe8/cE1PSCfxsM78isRuic
         9+C9kBeTglf981ThomRSgdEk8kL18qVvyEQWMf6BwJ4h2AC+BiIvZg5mW4InypZY3d5Y
         tlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLopvQrJpLUDqmj8LU9atUffkZGt0vm6zsb0hp7AK58=;
        b=mz+TvXYVOJtXnFx2GL4vfZ14+xwKYEfJgEkoCNyyIWteLaSdzceEdHQCWVQpq+xOXn
         Cxf55frcM3Kl4STVdELylN3d3/2YYBQ+LVeFbufNV3b+t/FuJxvQsyRkqkUQ3v9ZfGsO
         09BE8BsNoZ8W/ZWMPh3KIt2etmiBH7zRX8WVTIAb3VpE6RgLN7tuD+qpdc4IXzOwy+um
         KEfxFgZuT0iwxjpc3VxvuSNXjZWpS84X3MHQkOlSTqoL/yv4ibhcr7GR2v1e7P8Boxoh
         I+nW76GojrCez//2reNZBn/aqO1aEobbaE+wPbrXeqzPOfk8MnYY0wH6d/mjzJTZ1/a8
         qVGg==
X-Gm-Message-State: AOAM532wU+/cQ0gFHD6kJrKGY0f4cuT+/cJsSHmdtRs0Wxbgp8wazfK0
        p9S9NZPYrZu0/UjRpzWQTPgf4w==
X-Google-Smtp-Source: ABdhPJxXyCts6JOnHefb+CB97QTvaVZVj9HjBW9bsIXEL3WVQlR11HP3SjW8xg9SLfHQFjDh9Asd9A==
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr144247ljp.314.1600945574405;
        Thu, 24 Sep 2020 04:06:14 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-169.NA.cust.bahnhof.se. [155.4.133.169])
        by smtp.gmail.com with ESMTPSA id w4sm1762393lfr.139.2020.09.24.04.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 04:06:13 -0700 (PDT)
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
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] PM / Domains: Rename power state enums for genpd
Date:   Thu, 24 Sep 2020 13:04:47 +0200
Message-Id: <20200924110449.329523-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924110449.329523-1-ulf.hansson@linaro.org>
References: <20200924110449.329523-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To clarify the code a bit, let's rename GPD_STATE_ACTIVE into
GENPD_STATE_ON and GPD_STATE_POWER_OFF to GENPD_STATE_OFF.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- None.

---
 drivers/base/power/domain.c | 33 ++++++++++++++++-----------------
 include/linux/pm_domain.h   |  4 ++--
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2cb5e04cf86c..23aa2feced77 100644
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
@@ -1007,8 +1007,7 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 	}
 
 	_genpd_power_on(genpd, false);
-
-	genpd->status = GPD_STATE_ACTIVE;
+	genpd->status = GENPD_STATE_ON;
 }
 
 /**
@@ -1287,7 +1286,7 @@ static int genpd_restore_noirq(struct device *dev)
 		 * so make it appear as powered off to genpd_sync_power_on(),
 		 * so that it tries to power it on in case it was really off.
 		 */
-		genpd->status = GPD_STATE_POWER_OFF;
+		genpd->status = GENPD_STATE_OFF;
 
 	genpd_sync_power_on(genpd, true, 0);
 	genpd_unlock(genpd);
@@ -1777,7 +1776,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
-	genpd->status = is_off ? GPD_STATE_POWER_OFF : GPD_STATE_ACTIVE;
+	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
 	genpd->device_count = 0;
 	genpd->max_off_time_ns = -1;
 	genpd->max_off_time_changed = true;
@@ -2802,8 +2801,8 @@ static int genpd_summary_one(struct seq_file *s,
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
@@ -2881,8 +2880,8 @@ static int summary_show(struct seq_file *s, void *data)
 static int status_show(struct seq_file *s, void *data)
 {
 	static const char * const status_lookup[] = {
-		[GPD_STATE_ACTIVE] = "on",
-		[GPD_STATE_POWER_OFF] = "off"
+		[GENPD_STATE_ON] = "on",
+		[GENPD_STATE_OFF] = "off"
 	};
 
 	struct generic_pm_domain *genpd = s->private;
@@ -2895,7 +2894,7 @@ static int status_show(struct seq_file *s, void *data)
 	if (WARN_ON_ONCE(genpd->status >= ARRAY_SIZE(status_lookup)))
 		goto exit;
 
-	if (genpd->status == GPD_STATE_POWER_OFF)
+	if (genpd->status == GENPD_STATE_OFF)
 		seq_printf(s, "%s-%u\n", status_lookup[genpd->status],
 			genpd->state_idx);
 	else
@@ -2938,7 +2937,7 @@ static int idle_states_show(struct seq_file *s, void *data)
 		ktime_t delta = 0;
 		s64 msecs;
 
-		if ((genpd->status == GPD_STATE_POWER_OFF) &&
+		if ((genpd->status == GENPD_STATE_OFF) &&
 				(genpd->state_idx == i))
 			delta = ktime_sub(ktime_get(), genpd->accounting_time);
 
@@ -2961,7 +2960,7 @@ static int active_time_show(struct seq_file *s, void *data)
 	if (ret)
 		return -ERESTARTSYS;
 
-	if (genpd->status == GPD_STATE_ACTIVE)
+	if (genpd->status == GENPD_STATE_ON)
 		delta = ktime_sub(ktime_get(), genpd->accounting_time);
 
 	seq_printf(s, "%lld ms\n", ktime_to_ms(
@@ -2984,7 +2983,7 @@ static int total_idle_time_show(struct seq_file *s, void *data)
 
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

