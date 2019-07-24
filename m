Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E193723DE
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 03:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfGXBmi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 21:42:38 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:55365 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbfGXBmh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 21:42:37 -0400
Received: by mail-pf1-f202.google.com with SMTP id i26so27374878pfo.22
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 18:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SEZs2jCYZVWtwNC2TIXQwixIlhahYNp/FR94S5BAgLI=;
        b=GLzeC8O2RxI0vi+5KBEE/tj5Pt9sRQLtQpwXGEaiVTr3ksjh9xyVh0hkvPXlX6ghHD
         LY892stmN/RwLry2XliiTDP72x05E9GeA7Ekd3YRz9qyOx0Gj6EiRMt/r6eHhMHkLTRu
         HDePkjuNqOMo5HK82ePKcn0UjaUkTiXcDKXBgSCENMQ/scKEF6fRWfWYCgcfxSNVAyMb
         4+8VwxE2OxutYYs68sJliGL+ZnwiMBa0ObCoTY6mqSxwTRxpds2dXSicjJTGSzm8tO8e
         jv6nGP+acXMj1JE1h7mjBkFPr2KTds0aAduOscYxCANeN5e0A0FwVbod6jWFJM/FuaMd
         yniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SEZs2jCYZVWtwNC2TIXQwixIlhahYNp/FR94S5BAgLI=;
        b=c2QQgKWXR73yB15jJakvRxdfraQc95AodX57DuUQ5IRzSHfMGOWEQQbYrs5OZYouBu
         yGXUMPIeen5gbelb+gIDmH7NnY/iwm4HBJF9y3hqEL0Q8IiGPtk/6KPdqHHGIe/wBvLB
         sr/t6nkjOv+XUFmrDGoz0NyXcmDprgl9Sgl58DPy/exf2UjYa6syNs29LP0OZTyENVhG
         g8G2frLeNAk173BOuv9nv8OWfYL6pTFhMruxC/+12ikO2zmKI/Ct/alb8X3++a3Oz3wX
         v3mvaPCJArm3rUxTexvAHWhD5Qv5q2FHpd07lJLHJ3QVPAy1jQNGxgHu4U25CxQosooi
         h5nw==
X-Gm-Message-State: APjAAAUkdXP+HwNdhh8YYZfy2A3X4yZqopjjkBAaE1uCtuY8+nq3gk8x
        tPGEwUwQWEL/9NajuXtxknqbAQGAHivFpNQ=
X-Google-Smtp-Source: APXvYqx4miufCPfOh/OX7LGdgKZNTHriSMVQIat7T8l+We+el8Wt8FvO5jww/CDSgEBmVa0tGfpT+475WuM2aMU=
X-Received: by 2002:a63:20a:: with SMTP id 10mr78418083pgc.226.1563932555775;
 Tue, 23 Jul 2019 18:42:35 -0700 (PDT)
Date:   Tue, 23 Jul 2019 18:42:19 -0700
In-Reply-To: <20190724014222.110767-1-saravanak@google.com>
Message-Id: <20190724014222.110767-4-saravanak@google.com>
Mime-Version: 1.0
References: <20190724014222.110767-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 3/5] OPP: Improve required-opps linking
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, the linking of required-opps fails silently if the
destination OPP table hasn't been added before the source OPP table is
added. This puts an unnecessary requirement that the destination table
be added before the source table is added.

In reality, the destination table is needed only when we try to
translate from source OPP to destination OPP. So, instead of
completely failing, retry linking the tables when the translation is
attempted.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/core.c |  30 ++++++++++----
 drivers/opp/of.c   | 101 ++++++++++++++++++++++++---------------------
 drivers/opp/opp.h  |   5 +++
 3 files changed, 80 insertions(+), 56 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 5460b7da110e..01c71d145ec7 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -706,6 +706,9 @@ static int _set_required_opps(struct device *dev,
 	if (!required_opp_tables)
 		return 0;
 
+	if (!_of_lazy_link_required_tables(opp_table))
+		return -EPROBE_DEFER;
+
 	/* Single genpd case */
 	if (!genpd_virt_devs && required_opp_tables[0]->is_genpd) {
 		pstate = likely(opp) ? opp->required_opps[0]->pstate : 0;
@@ -726,11 +729,16 @@ static int _set_required_opps(struct device *dev,
 	mutex_lock(&opp_table->genpd_virt_dev_lock);
 
 	for (i = 0; i < opp_table->required_opp_count; i++) {
-		pstate = likely(opp) ? opp->required_opps[i]->pstate : 0;
-
 		if (!genpd_virt_devs[i])
 			continue;
 
+		if (!opp->required_opps[i]) {
+			ret = -ENODEV;
+			break;
+		}
+
+		pstate = likely(opp) ? opp->required_opps[i]->pstate : 0;
+
 		ret = dev_pm_genpd_set_performance_state(genpd_virt_devs[i], pstate);
 		if (ret) {
 			dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
@@ -1906,8 +1914,11 @@ struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
 	if (!src_table || !dst_table || !src_opp)
 		return NULL;
 
+	_of_lazy_link_required_tables(src_table);
+
 	for (i = 0; i < src_table->required_opp_count; i++) {
-		if (src_table->required_opp_tables[i]->np == dst_table->np)
+		if (src_table->required_opp_tables[i]
+		    && src_table->required_opp_tables[i]->np == dst_table->np)
 			break;
 	}
 
@@ -1970,6 +1981,8 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
 	if (!src_table->required_opp_count)
 		return pstate;
 
+	_of_lazy_link_required_tables(src_table);
+
 	for (i = 0; i < src_table->required_opp_count; i++) {
 		if (src_table->required_opp_tables[i]->np == dst_table->np)
 			break;
@@ -1985,15 +1998,16 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
 
 	list_for_each_entry(opp, &src_table->opp_list, node) {
 		if (opp->pstate == pstate) {
-			dest_pstate = opp->required_opps[i]->pstate;
-			goto unlock;
+			if (opp->required_opps[i])
+				dest_pstate = opp->required_opps[i]->pstate;
+			break;
 		}
 	}
 
-	pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
-	       dst_table);
+	if (dest_pstate < 0)
+		pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__,
+		       src_table, dst_table);
 
-unlock:
 	mutex_unlock(&src_table->lock);
 
 	return dest_pstate;
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index ff88eaf66b56..1f2860b2d6e5 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -145,7 +145,7 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
 
 	for (i = 0; i < opp_table->required_opp_count; i++) {
 		if (IS_ERR_OR_NULL(required_opp_tables[i]))
-			break;
+			continue;
 
 		dev_pm_opp_put_opp_table(required_opp_tables[i]);
 	}
@@ -165,8 +165,8 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 					     struct device_node *opp_np)
 {
 	struct opp_table **required_opp_tables;
-	struct device_node *required_np, *np;
-	int count, i;
+	struct device_node *np;
+	int count;
 
 	/* Traversing the first OPP node is all we need */
 	np = of_get_next_available_child(opp_np, NULL);
@@ -176,35 +176,65 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	}
 
 	count = of_count_phandle_with_args(np, "required-opps", NULL);
+	of_node_put(np);
 	if (!count)
-		goto put_np;
+		return;
 
 	required_opp_tables = kcalloc(count, sizeof(*required_opp_tables),
 				      GFP_KERNEL);
 	if (!required_opp_tables)
-		goto put_np;
+		return;
 
 	opp_table->required_opp_tables = required_opp_tables;
 	opp_table->required_opp_count = count;
+}
+
+/*
+ * Try to link all required tables and return true if all of them have been
+ * linked. Otherwise, return false.
+ */
+bool _of_lazy_link_required_tables(struct opp_table *src)
+{
+	struct dev_pm_opp *src_opp, *tmp_opp;
+	struct opp_table *req_table;
+	struct device_node *req_np;
+	int i, num_linked = 0;
 
-	for (i = 0; i < count; i++) {
-		required_np = of_parse_required_opp(np, i);
-		if (!required_np)
-			goto free_required_tables;
+	mutex_lock(&src->lock);
 
-		required_opp_tables[i] = _find_table_of_opp_np(required_np);
-		of_node_put(required_np);
+	if (list_empty(&src->opp_list))
+		goto out;
 
-		if (IS_ERR(required_opp_tables[i]))
-			goto free_required_tables;
-	}
+	src_opp = list_first_entry(&src->opp_list, struct dev_pm_opp, node);
 
-	goto put_np;
+	for (i = 0; i < src->required_opp_count; i++) {
+		if (src->required_opp_tables[i]) {
+			num_linked++;
+			continue;
+		}
 
-free_required_tables:
-	_opp_table_free_required_tables(opp_table);
-put_np:
-	of_node_put(np);
+		req_np = of_parse_required_opp(src_opp->np, i);
+		if (!req_np)
+			continue;
+
+		req_table = _find_table_of_opp_np(req_np);
+		of_node_put(req_np);
+		if (!req_table)
+			continue;
+
+		src->required_opp_tables[i] = req_table;
+		list_for_each_entry(tmp_opp, &src->opp_list, node) {
+			req_np = of_parse_required_opp(tmp_opp->np, i);
+			tmp_opp->required_opps[i] = _find_opp_of_np(req_table,
+								    req_np);
+			of_node_put(req_np);
+		}
+		num_linked++;
+	}
+
+out:
+	mutex_unlock(&src->lock);
+	return num_linked == src->required_opp_count;
 }
 
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
@@ -267,7 +297,7 @@ void _of_opp_free_required_opps(struct opp_table *opp_table,
 
 	for (i = 0; i < opp_table->required_opp_count; i++) {
 		if (!required_opps[i])
-			break;
+			continue;
 
 		/* Put the reference back */
 		dev_pm_opp_put(required_opps[i]);
@@ -282,9 +312,7 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 				       struct dev_pm_opp *opp)
 {
 	struct dev_pm_opp **required_opps;
-	struct opp_table *required_table;
-	struct device_node *np;
-	int i, ret, count = opp_table->required_opp_count;
+	int count = opp_table->required_opp_count;
 
 	if (!count)
 		return 0;
@@ -295,32 +323,7 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 
 	opp->required_opps = required_opps;
 
-	for (i = 0; i < count; i++) {
-		required_table = opp_table->required_opp_tables[i];
-
-		np = of_parse_required_opp(opp->np, i);
-		if (unlikely(!np)) {
-			ret = -ENODEV;
-			goto free_required_opps;
-		}
-
-		required_opps[i] = _find_opp_of_np(required_table, np);
-		of_node_put(np);
-
-		if (!required_opps[i]) {
-			pr_err("%s: Unable to find required OPP node: %pOF (%d)\n",
-			       __func__, opp->np, i);
-			ret = -ENODEV;
-			goto free_required_opps;
-		}
-	}
-
 	return 0;
-
-free_required_opps:
-	_of_opp_free_required_opps(opp_table, opp);
-
-	return ret;
 }
 
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
@@ -687,6 +690,8 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	if (pstate_count)
 		opp_table->genpd_performance_state = true;
 
+	_of_lazy_link_required_tables(opp_table);
+
 	opp_table->parsed_static_opps = true;
 
 	return 0;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 01a500e2c40a..77e8394fd0fe 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -223,12 +223,17 @@ void _put_opp_list_kref(struct opp_table *opp_table);
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index);
 void _of_clear_opp_table(struct opp_table *opp_table);
 struct opp_table *_managed_opp(struct device *dev, int index);
+bool _of_lazy_link_required_tables(struct opp_table *src);
 void _of_opp_free_required_opps(struct opp_table *opp_table,
 				struct dev_pm_opp *opp);
 #else
 static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
 static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
 static inline struct opp_table *_managed_opp(struct device *dev, int index) { return NULL; }
+bool _of_lazy_link_required_tables(struct opp_table *src)
+{
+	return true;
+}
 static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
 					      struct dev_pm_opp *opp) {}
 #endif
-- 
2.22.0.709.g102302147b-goog

