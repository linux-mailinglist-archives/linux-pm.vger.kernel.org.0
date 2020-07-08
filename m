Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9310B219450
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 01:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgGHXcS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 19:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHXcR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 19:32:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A544C08C5C1
        for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2020 16:32:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s26so167400pfm.4
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2020 16:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xYxHA+VH8Pn4IFSJQ98LL4KXo0QVKGxRjggucrpXiwA=;
        b=dAODQjNkvZuWO3UkyEARIDBODdgq0m6FAZg1rg20VWD4HpD6oBJXTWTXIoCWD8Mjq0
         8dd3ilt+mmP/gAZKxwiJbHJc6eWI0IArCn8Kt9e+f/iyXEor7/WXF16UH/F3KWpHJe3g
         Qddmu1teQ1viJxgmxvZ/UaL6jkBwls7spLlc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xYxHA+VH8Pn4IFSJQ98LL4KXo0QVKGxRjggucrpXiwA=;
        b=adTsv5bbzh/z95bcjCTs0N010CwT2hr90MRjCsHbK2xevFsy7GH1GrIDApbZ1DgDRK
         xU5sqawOsw0RSD++6mJEtBjNFdQOltcNH2ibiUggZWNQvN1qxsP2m5S6UHmcZLoC6Yp6
         PQTf6ReaqhwyTczn5nk5z7PviEwr539iTh6MDUq57wRE5ZHDDpN40BYleEDIwTvCkSK5
         hOXH81rWYNpbj8dj3L8tRE0RO+Ttp1fL1wlnkDYWBo8uvp8sMDCeVoBS9kEJGtC+SxHL
         Z5uWvcfwdWpA6ODd36KkX4J83iirs/qOQo8QTN2CktUwLwsUKcaCflp1lY/lUJNvIFZn
         byyg==
X-Gm-Message-State: AOAM532TB+5KQduNQVr8dku/030sCxhrD0T4sLri7itraT7eOGQCA/FE
        XnkpKSuWIpEezgTwY/S9QznqJQ==
X-Google-Smtp-Source: ABdhPJyg9Bljfwnl0+RqwzxRl2Z9i8O+HC7GVN+3KsqhkbY845Sa7GmHjk9fS3PiVHF8ZSkeHJIzfg==
X-Received: by 2002:a63:c509:: with SMTP id f9mr51786048pgd.144.1594251135539;
        Wed, 08 Jul 2020 16:32:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm789275pfp.7.2020.07.08.16.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:32:14 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:32:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] genpd: Fix up terminology with parent/child
Message-ID: <202007081629.0840B4CB78@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The genpd infrastructure uses the terms master/slave, but such uses have
no external exposures (not even in Documentation/driver-api/pm/*) and are
not mandated by nor associated with any external specifications. Change
the language used through-out to parent/child.

There was one possible exception in the debugfs node
"pm_genpd/pm_genpd_summary" but its path has no hits outside of the
kernel itself when performing a code search[1], and it seems even this
single usage has been non-functional since it was introduced due to a
typo in the Python ("apend" instead of correct "append"). Fix the typo
while we're at it.

[1] https://codesearch.debian.net/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: leader/follower -> parent/child (ulf, rafael)
v1: https://lore.kernel.org/lkml/202007080131.3E6D0858@keescook
This is motivated by the recent discussions over coding style:
https://lore.kernel.org/lkml/159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com/
---
 drivers/base/power/domain.c          | 194 +++++++++++++--------------
 drivers/base/power/domain_governor.c |  12 +-
 include/linux/pm_domain.h            |  12 +-
 scripts/gdb/linux/genpd.py           |  12 +-
 4 files changed, 115 insertions(+), 115 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0a01df608849..2cb5e04cf86c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -263,18 +263,18 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
 	/*
 	 * Traverse all sub-domains within the domain. This can be
 	 * done without any additional locking as the link->performance_state
-	 * field is protected by the master genpd->lock, which is already taken.
+	 * field is protected by the parent genpd->lock, which is already taken.
 	 *
 	 * Also note that link->performance_state (subdomain's performance state
-	 * requirement to master domain) is different from
-	 * link->slave->performance_state (current performance state requirement
+	 * requirement to parent domain) is different from
+	 * link->child->performance_state (current performance state requirement
 	 * of the devices/sub-domains of the subdomain) and so can have a
 	 * different value.
 	 *
 	 * Note that we also take vote from powered-off sub-domains into account
 	 * as the same is done for devices right now.
 	 */
-	list_for_each_entry(link, &genpd->master_links, master_node) {
+	list_for_each_entry(link, &genpd->parent_links, parent_node) {
 		if (link->performance_state > state)
 			state = link->performance_state;
 	}
@@ -285,40 +285,40 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
 static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 					unsigned int state, int depth)
 {
-	struct generic_pm_domain *master;
+	struct generic_pm_domain *parent;
 	struct gpd_link *link;
-	int master_state, ret;
+	int parent_state, ret;
 
 	if (state == genpd->performance_state)
 		return 0;
 
-	/* Propagate to masters of genpd */
-	list_for_each_entry(link, &genpd->slave_links, slave_node) {
-		master = link->master;
+	/* Propagate to parents of genpd */
+	list_for_each_entry(link, &genpd->child_links, child_node) {
+		parent = link->parent;
 
-		if (!master->set_performance_state)
+		if (!parent->set_performance_state)
 			continue;
 
-		/* Find master's performance state */
+		/* Find parent's performance state */
 		ret = dev_pm_opp_xlate_performance_state(genpd->opp_table,
-							 master->opp_table,
+							 parent->opp_table,
 							 state);
 		if (unlikely(ret < 0))
 			goto err;
 
-		master_state = ret;
+		parent_state = ret;
 
-		genpd_lock_nested(master, depth + 1);
+		genpd_lock_nested(parent, depth + 1);
 
 		link->prev_performance_state = link->performance_state;
-		link->performance_state = master_state;
-		master_state = _genpd_reeval_performance_state(master,
-						master_state);
-		ret = _genpd_set_performance_state(master, master_state, depth + 1);
+		link->performance_state = parent_state;
+		parent_state = _genpd_reeval_performance_state(parent,
+						parent_state);
+		ret = _genpd_set_performance_state(parent, parent_state, depth + 1);
 		if (ret)
 			link->performance_state = link->prev_performance_state;
 
-		genpd_unlock(master);
+		genpd_unlock(parent);
 
 		if (ret)
 			goto err;
@@ -333,26 +333,26 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 
 err:
 	/* Encountered an error, lets rollback */
-	list_for_each_entry_continue_reverse(link, &genpd->slave_links,
-					     slave_node) {
-		master = link->master;
+	list_for_each_entry_continue_reverse(link, &genpd->child_links,
+					     child_node) {
+		parent = link->parent;
 
-		if (!master->set_performance_state)
+		if (!parent->set_performance_state)
 			continue;
 
-		genpd_lock_nested(master, depth + 1);
+		genpd_lock_nested(parent, depth + 1);
 
-		master_state = link->prev_performance_state;
-		link->performance_state = master_state;
+		parent_state = link->prev_performance_state;
+		link->performance_state = parent_state;
 
-		master_state = _genpd_reeval_performance_state(master,
-						master_state);
-		if (_genpd_set_performance_state(master, master_state, depth + 1)) {
+		parent_state = _genpd_reeval_performance_state(parent,
+						parent_state);
+		if (_genpd_set_performance_state(parent, parent_state, depth + 1)) {
 			pr_err("%s: Failed to roll back to %d performance state\n",
-			       master->name, master_state);
+			       parent->name, parent_state);
 		}
 
-		genpd_unlock(master);
+		genpd_unlock(parent);
 	}
 
 	return ret;
@@ -552,7 +552,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 
 		/*
 		 * If sd_count > 0 at this point, one of the subdomains hasn't
-		 * managed to call genpd_power_on() for the master yet after
+		 * managed to call genpd_power_on() for the parent yet after
 		 * incrementing it.  In that case genpd_power_on() will wait
 		 * for us to drop the lock, so we can call .power_off() and let
 		 * the genpd_power_on() restore power for us (this shouldn't
@@ -566,22 +566,22 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	genpd->status = GPD_STATE_POWER_OFF;
 	genpd_update_accounting(genpd);
 
-	list_for_each_entry(link, &genpd->slave_links, slave_node) {
-		genpd_sd_counter_dec(link->master);
-		genpd_lock_nested(link->master, depth + 1);
-		genpd_power_off(link->master, false, depth + 1);
-		genpd_unlock(link->master);
+	list_for_each_entry(link, &genpd->child_links, child_node) {
+		genpd_sd_counter_dec(link->parent);
+		genpd_lock_nested(link->parent, depth + 1);
+		genpd_power_off(link->parent, false, depth + 1);
+		genpd_unlock(link->parent);
 	}
 
 	return 0;
 }
 
 /**
- * genpd_power_on - Restore power to a given PM domain and its masters.
+ * genpd_power_on - Restore power to a given PM domain and its parents.
  * @genpd: PM domain to power up.
  * @depth: nesting count for lockdep.
  *
- * Restore power to @genpd and all of its masters so that it is possible to
+ * Restore power to @genpd and all of its parents so that it is possible to
  * resume a device belonging to it.
  */
 static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
@@ -594,20 +594,20 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 
 	/*
 	 * The list is guaranteed not to change while the loop below is being
-	 * executed, unless one of the masters' .power_on() callbacks fiddles
+	 * executed, unless one of the parents' .power_on() callbacks fiddles
 	 * with it.
 	 */
-	list_for_each_entry(link, &genpd->slave_links, slave_node) {
-		struct generic_pm_domain *master = link->master;
+	list_for_each_entry(link, &genpd->child_links, child_node) {
+		struct generic_pm_domain *parent = link->parent;
 
-		genpd_sd_counter_inc(master);
+		genpd_sd_counter_inc(parent);
 
-		genpd_lock_nested(master, depth + 1);
-		ret = genpd_power_on(master, depth + 1);
-		genpd_unlock(master);
+		genpd_lock_nested(parent, depth + 1);
+		ret = genpd_power_on(parent, depth + 1);
+		genpd_unlock(parent);
 
 		if (ret) {
-			genpd_sd_counter_dec(master);
+			genpd_sd_counter_dec(parent);
 			goto err;
 		}
 	}
@@ -623,12 +623,12 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 
  err:
 	list_for_each_entry_continue_reverse(link,
-					&genpd->slave_links,
-					slave_node) {
-		genpd_sd_counter_dec(link->master);
-		genpd_lock_nested(link->master, depth + 1);
-		genpd_power_off(link->master, false, depth + 1);
-		genpd_unlock(link->master);
+					&genpd->child_links,
+					child_node) {
+		genpd_sd_counter_dec(link->parent);
+		genpd_lock_nested(link->parent, depth + 1);
+		genpd_power_off(link->parent, false, depth + 1);
+		genpd_unlock(link->parent);
 	}
 
 	return ret;
@@ -932,13 +932,13 @@ late_initcall(genpd_power_off_unused);
 #ifdef CONFIG_PM_SLEEP
 
 /**
- * genpd_sync_power_off - Synchronously power off a PM domain and its masters.
+ * genpd_sync_power_off - Synchronously power off a PM domain and its parents.
  * @genpd: PM domain to power off, if possible.
  * @use_lock: use the lock.
  * @depth: nesting count for lockdep.
  *
  * Check if the given PM domain can be powered off (during system suspend or
- * hibernation) and do that if so.  Also, in that case propagate to its masters.
+ * hibernation) and do that if so.  Also, in that case propagate to its parents.
  *
  * This function is only called in "noirq" and "syscore" stages of system power
  * transitions. The "noirq" callbacks may be executed asynchronously, thus in
@@ -963,21 +963,21 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 
 	genpd->status = GPD_STATE_POWER_OFF;
 
-	list_for_each_entry(link, &genpd->slave_links, slave_node) {
-		genpd_sd_counter_dec(link->master);
+	list_for_each_entry(link, &genpd->child_links, child_node) {
+		genpd_sd_counter_dec(link->parent);
 
 		if (use_lock)
-			genpd_lock_nested(link->master, depth + 1);
+			genpd_lock_nested(link->parent, depth + 1);
 
-		genpd_sync_power_off(link->master, use_lock, depth + 1);
+		genpd_sync_power_off(link->parent, use_lock, depth + 1);
 
 		if (use_lock)
-			genpd_unlock(link->master);
+			genpd_unlock(link->parent);
 	}
 }
 
 /**
- * genpd_sync_power_on - Synchronously power on a PM domain and its masters.
+ * genpd_sync_power_on - Synchronously power on a PM domain and its parents.
  * @genpd: PM domain to power on.
  * @use_lock: use the lock.
  * @depth: nesting count for lockdep.
@@ -994,16 +994,16 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 	if (genpd_status_on(genpd))
 		return;
 
-	list_for_each_entry(link, &genpd->slave_links, slave_node) {
-		genpd_sd_counter_inc(link->master);
+	list_for_each_entry(link, &genpd->child_links, child_node) {
+		genpd_sd_counter_inc(link->parent);
 
 		if (use_lock)
-			genpd_lock_nested(link->master, depth + 1);
+			genpd_lock_nested(link->parent, depth + 1);
 
-		genpd_sync_power_on(link->master, use_lock, depth + 1);
+		genpd_sync_power_on(link->parent, use_lock, depth + 1);
 
 		if (use_lock)
-			genpd_unlock(link->master);
+			genpd_unlock(link->parent);
 	}
 
 	_genpd_power_on(genpd, false);
@@ -1443,12 +1443,12 @@ static void genpd_update_cpumask(struct generic_pm_domain *genpd,
 	if (!genpd_is_cpu_domain(genpd))
 		return;
 
-	list_for_each_entry(link, &genpd->slave_links, slave_node) {
-		struct generic_pm_domain *master = link->master;
+	list_for_each_entry(link, &genpd->child_links, child_node) {
+		struct generic_pm_domain *parent = link->parent;
 
-		genpd_lock_nested(master, depth + 1);
-		genpd_update_cpumask(master, cpu, set, depth + 1);
-		genpd_unlock(master);
+		genpd_lock_nested(parent, depth + 1);
+		genpd_update_cpumask(parent, cpu, set, depth + 1);
+		genpd_unlock(parent);
 	}
 
 	if (set)
@@ -1636,17 +1636,17 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 		goto out;
 	}
 
-	list_for_each_entry(itr, &genpd->master_links, master_node) {
-		if (itr->slave == subdomain && itr->master == genpd) {
+	list_for_each_entry(itr, &genpd->parent_links, parent_node) {
+		if (itr->child == subdomain && itr->parent == genpd) {
 			ret = -EINVAL;
 			goto out;
 		}
 	}
 
-	link->master = genpd;
-	list_add_tail(&link->master_node, &genpd->master_links);
-	link->slave = subdomain;
-	list_add_tail(&link->slave_node, &subdomain->slave_links);
+	link->parent = genpd;
+	list_add_tail(&link->parent_node, &genpd->parent_links);
+	link->child = subdomain;
+	list_add_tail(&link->child_node, &subdomain->child_links);
 	if (genpd_status_on(subdomain))
 		genpd_sd_counter_inc(genpd);
 
@@ -1660,7 +1660,7 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 
 /**
  * pm_genpd_add_subdomain - Add a subdomain to an I/O PM domain.
- * @genpd: Master PM domain to add the subdomain to.
+ * @genpd: Leader PM domain to add the subdomain to.
  * @subdomain: Subdomain to be added.
  */
 int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
@@ -1678,7 +1678,7 @@ EXPORT_SYMBOL_GPL(pm_genpd_add_subdomain);
 
 /**
  * pm_genpd_remove_subdomain - Remove a subdomain from an I/O PM domain.
- * @genpd: Master PM domain to remove the subdomain from.
+ * @genpd: Leader PM domain to remove the subdomain from.
  * @subdomain: Subdomain to be removed.
  */
 int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
@@ -1693,19 +1693,19 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 	genpd_lock(subdomain);
 	genpd_lock_nested(genpd, SINGLE_DEPTH_NESTING);
 
-	if (!list_empty(&subdomain->master_links) || subdomain->device_count) {
+	if (!list_empty(&subdomain->parent_links) || subdomain->device_count) {
 		pr_warn("%s: unable to remove subdomain %s\n",
 			genpd->name, subdomain->name);
 		ret = -EBUSY;
 		goto out;
 	}
 
-	list_for_each_entry_safe(link, l, &genpd->master_links, master_node) {
-		if (link->slave != subdomain)
+	list_for_each_entry_safe(link, l, &genpd->parent_links, parent_node) {
+		if (link->child != subdomain)
 			continue;
 
-		list_del(&link->master_node);
-		list_del(&link->slave_node);
+		list_del(&link->parent_node);
+		list_del(&link->child_node);
 		kfree(link);
 		if (genpd_status_on(subdomain))
 			genpd_sd_counter_dec(genpd);
@@ -1770,8 +1770,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	if (IS_ERR_OR_NULL(genpd))
 		return -EINVAL;
 
-	INIT_LIST_HEAD(&genpd->master_links);
-	INIT_LIST_HEAD(&genpd->slave_links);
+	INIT_LIST_HEAD(&genpd->parent_links);
+	INIT_LIST_HEAD(&genpd->child_links);
 	INIT_LIST_HEAD(&genpd->dev_list);
 	genpd_lock_init(genpd);
 	genpd->gov = gov;
@@ -1848,15 +1848,15 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 		return -EBUSY;
 	}
 
-	if (!list_empty(&genpd->master_links) || genpd->device_count) {
+	if (!list_empty(&genpd->parent_links) || genpd->device_count) {
 		genpd_unlock(genpd);
 		pr_err("%s: unable to remove %s\n", __func__, genpd->name);
 		return -EBUSY;
 	}
 
-	list_for_each_entry_safe(link, l, &genpd->slave_links, slave_node) {
-		list_del(&link->master_node);
-		list_del(&link->slave_node);
+	list_for_each_entry_safe(link, l, &genpd->child_links, child_node) {
+		list_del(&link->parent_node);
+		list_del(&link->child_node);
 		kfree(link);
 	}
 
@@ -2827,12 +2827,12 @@ static int genpd_summary_one(struct seq_file *s,
 
 	/*
 	 * Modifications on the list require holding locks on both
-	 * master and slave, so we are safe.
+	 * parent and child, so we are safe.
 	 * Also genpd->name is immutable.
 	 */
-	list_for_each_entry(link, &genpd->master_links, master_node) {
-		seq_printf(s, "%s", link->slave->name);
-		if (!list_is_last(&link->master_node, &genpd->master_links))
+	list_for_each_entry(link, &genpd->parent_links, parent_node) {
+		seq_printf(s, "%s", link->child->name);
+		if (!list_is_last(&link->parent_node, &genpd->parent_links))
 			seq_puts(s, ", ");
 	}
 
@@ -2860,7 +2860,7 @@ static int summary_show(struct seq_file *s, void *data)
 	struct generic_pm_domain *genpd;
 	int ret = 0;
 
-	seq_puts(s, "domain                          status          slaves\n");
+	seq_puts(s, "domain                          status          children\n");
 	seq_puts(s, "    /device                                             runtime status\n");
 	seq_puts(s, "----------------------------------------------------------------------\n");
 
@@ -2915,8 +2915,8 @@ static int sub_domains_show(struct seq_file *s, void *data)
 	if (ret)
 		return -ERESTARTSYS;
 
-	list_for_each_entry(link, &genpd->master_links, master_node)
-		seq_printf(s, "%s\n", link->slave->name);
+	list_for_each_entry(link, &genpd->parent_links, parent_node)
+		seq_printf(s, "%s\n", link->child->name);
 
 	genpd_unlock(genpd);
 	return ret;
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index daa8c7689f7e..490ed7deb99a 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -135,8 +135,8 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
 	 *
 	 * All subdomains have been powered off already at this point.
 	 */
-	list_for_each_entry(link, &genpd->master_links, master_node) {
-		struct generic_pm_domain *sd = link->slave;
+	list_for_each_entry(link, &genpd->parent_links, parent_node) {
+		struct generic_pm_domain *sd = link->child;
 		s64 sd_max_off_ns = sd->max_off_time_ns;
 
 		if (sd_max_off_ns < 0)
@@ -217,13 +217,13 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	}
 
 	/*
-	 * We have to invalidate the cached results for the masters, so
+	 * We have to invalidate the cached results for the parents, so
 	 * use the observation that default_power_down_ok() is not
-	 * going to be called for any master until this instance
+	 * going to be called for any parent until this instance
 	 * returns.
 	 */
-	list_for_each_entry(link, &genpd->slave_links, slave_node)
-		link->master->max_off_time_changed = true;
+	list_for_each_entry(link, &genpd->child_links, child_node)
+		link->parent->max_off_time_changed = true;
 
 	genpd->max_off_time_ns = -1;
 	genpd->max_off_time_changed = false;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9ec78ee53652..574a1fadb1e5 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -95,8 +95,8 @@ struct generic_pm_domain {
 	struct device dev;
 	struct dev_pm_domain domain;	/* PM domain operations */
 	struct list_head gpd_list_node;	/* Node in the global PM domains list */
-	struct list_head master_links;	/* Links with PM domain as a master */
-	struct list_head slave_links;	/* Links with PM domain as a slave */
+	struct list_head parent_links;	/* Links with PM domain as a parent */
+	struct list_head child_links;/* Links with PM domain as a child */
 	struct list_head dev_list;	/* List of devices */
 	struct dev_power_governor *gov;
 	struct work_struct power_off_work;
@@ -151,10 +151,10 @@ static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
 }
 
 struct gpd_link {
-	struct generic_pm_domain *master;
-	struct list_head master_node;
-	struct generic_pm_domain *slave;
-	struct list_head slave_node;
+	struct generic_pm_domain *parent;
+	struct list_head parent_node;
+	struct generic_pm_domain *child;
+	struct list_head child_node;
 
 	/* Sub-domain's per-master domain performance state */
 	unsigned int performance_state;
diff --git a/scripts/gdb/linux/genpd.py b/scripts/gdb/linux/genpd.py
index 6ca93bd2949e..39cd1abd8559 100644
--- a/scripts/gdb/linux/genpd.py
+++ b/scripts/gdb/linux/genpd.py
@@ -49,17 +49,17 @@ Output is similar to /sys/kernel/debug/pm_genpd/pm_genpd_summary'''
         else:
             status_string = 'off-{}'.format(genpd['state_idx'])
 
-        slave_names = []
+        child_names = []
         for link in list_for_each_entry(
-                genpd['master_links'],
+                genpd['parent_links'],
                 device_link_type.get_type().pointer(),
-                'master_node'):
-            slave_names.apend(link['slave']['name'])
+                'parent_node'):
+            child_names.append(link['child']['name'])
 
         gdb.write('%-30s  %-15s %s\n' % (
                 genpd['name'].string(),
                 status_string,
-                ', '.join(slave_names)))
+                ', '.join(child_names)))
 
         # Print devices in domain
         for pm_data in list_for_each_entry(genpd['dev_list'],
@@ -70,7 +70,7 @@ Output is similar to /sys/kernel/debug/pm_genpd/pm_genpd_summary'''
             gdb.write('    %-50s  %s\n' % (kobj_path, rtpm_status_str(dev)))
 
     def invoke(self, arg, from_tty):
-        gdb.write('domain                          status          slaves\n');
+        gdb.write('domain                          status          children\n');
         gdb.write('    /device                                             runtime status\n');
         gdb.write('----------------------------------------------------------------------\n');
         for genpd in list_for_each_entry(
-- 
2.25.1


-- 
Kees Cook
