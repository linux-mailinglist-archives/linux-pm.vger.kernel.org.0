Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707516C317
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 00:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfGQWYC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 18:24:02 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56668 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729981AbfGQWYB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 18:24:01 -0400
Received: by mail-pl1-f201.google.com with SMTP id o6so12760467plk.23
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 15:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JiAbZiQnbypR/LQybLeRQSTrO5YSwCRzRThmbb4fRO4=;
        b=RxtfqxJJQCxHBT9Iiw0njIWJClOh8QwW25XIFpBmKbrv2XIyKvW5AcTQUfvMwG0+mo
         rSfFbo1IJO6m4VClRpz3n+Z46BHDsBNJH7T9FRlcdliia/Zd7uekHwT/nnOzVfcW2lhg
         /cDhYTmQRC66zI8ZQeewrUixTAHTS71GvYo30xB+ZEJT1SQNTyPgyHizjeyGnZDnWTAM
         J8zJDCgWwIXKAWIfuge54XUabefVdcWElHSU/jxjwwrtEy6YJhGyPV+CykMBO8yTKnhh
         EG3AjIPnV7MCrq9pWQoeVadiPeen0VwUyAyGr4F+Eyb/uu9J+ZZG0mRnoRZNEPM1Lclk
         nrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JiAbZiQnbypR/LQybLeRQSTrO5YSwCRzRThmbb4fRO4=;
        b=VzxRpVfLZCQv1xJANQAaXwa/9C3STlNWG+M64x0P0rkyck9Xxwkv/I+nI32Tf0ca8d
         UsKAtLo+nMkHNVME5wUKurYgxX051fQOSz3d/xiYFmll7cRLXFaHHHOggC01tDoQ/1i0
         O806mS6vvAGxzfkvXu+q5W6AwDlT24cCQ8zkiXONwjpcsLUCfqH/z08eB+He4jYAeSrJ
         ZuYabIYrCKpBnCdrEm//gqmN9/0/z3PDpUTJjjhtA96HB+WJUyq+BNHIQsE254P1prLr
         +QBLUB8bZTC2wTUfN6sr/rU0xG9cWbTwy6F1bu0X8jMMqMvNS/OeF5pPcWYA0R9mkLeO
         bKbQ==
X-Gm-Message-State: APjAAAWlBZeLM7+el/NxVGt2VZhDf3iiFJh5k3g/s2J2WQPaHTE7Zhij
        cDMYg2y5edM8M70NEFrj0hNY7h1AHW3Zd5k=
X-Google-Smtp-Source: APXvYqzkmV2/dNoDj5VZu6rSEzqoc8mWaBfmF+nBWnlSTgiXQA+nqeoaREf7O5pqaS6PzjWwwpt3iyc4KPkSWz8=
X-Received: by 2002:a63:fb14:: with SMTP id o20mr32641083pgh.136.1563402240173;
 Wed, 17 Jul 2019 15:24:00 -0700 (PDT)
Date:   Wed, 17 Jul 2019 15:23:38 -0700
In-Reply-To: <20190717222340.137578-1-saravanak@google.com>
Message-Id: <20190717222340.137578-4-saravanak@google.com>
Mime-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v3 3/5] OPP: Improve require-opps linking
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
 drivers/opp/core.c | 32 +++++++++++-----
 drivers/opp/of.c   | 91 ++++++++++++++++++++++------------------------
 drivers/opp/opp.h  |  5 +++
 3 files changed, 71 insertions(+), 57 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 72c055a3f6b7..cafe6ec05d6c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -706,8 +706,11 @@ static int _set_required_opps(struct device *dev,
 	if (!required_opp_tables)
 		return 0;
 
+	_of_lazy_link_required_tables(opp_table);
+
 	/* Single genpd case */
-	if (!genpd_virt_devs && required_opp_tables[0]->is_genpd) {
+	if (!genpd_virt_devs && required_opp_tables[0]
+			     && required_opp_tables[0]->is_genpd) {
 		pstate = likely(opp) ? opp->required_opps[0]->pstate : 0;
 		ret = dev_pm_genpd_set_performance_state(dev, pstate);
 		if (ret) {
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
@@ -1907,8 +1915,11 @@ struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
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
 
@@ -1971,6 +1982,8 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
 	if (!src_table->required_opp_count)
 		return pstate;
 
+	_of_lazy_link_required_tables(src_table);
+
 	for (i = 0; i < src_table->required_opp_count; i++) {
 		if (src_table->required_opp_tables[i]->np == dst_table->np)
 			break;
@@ -1986,15 +1999,16 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
 
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
index ff88eaf66b56..4e527245fd59 100644
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
@@ -176,35 +176,57 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
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
 
-	for (i = 0; i < count; i++) {
-		required_np = of_parse_required_opp(np, i);
-		if (!required_np)
-			goto free_required_tables;
+void _of_lazy_link_required_tables(struct opp_table *src)
+{
+	struct dev_pm_opp *src_opp, *tmp_opp;
+	struct opp_table *req_table;
+	struct device_node *req_np;
+	int i;
 
-		required_opp_tables[i] = _find_table_of_opp_np(required_np);
-		of_node_put(required_np);
+	mutex_lock(&src->lock);
 
-		if (IS_ERR(required_opp_tables[i]))
-			goto free_required_tables;
-	}
+	if (list_empty(&src->opp_list))
+		goto out;
 
-	goto put_np;
+	src_opp = list_first_entry(&src->opp_list, struct dev_pm_opp, node);
 
-free_required_tables:
-	_opp_table_free_required_tables(opp_table);
-put_np:
-	of_node_put(np);
+	for (i = 0; i < src->required_opp_count; i++) {
+		if (src->required_opp_tables[i])
+			continue;
+
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
+	}
+
+out:
+	mutex_unlock(&src->lock);
 }
 
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
@@ -267,7 +289,7 @@ void _of_opp_free_required_opps(struct opp_table *opp_table,
 
 	for (i = 0; i < opp_table->required_opp_count; i++) {
 		if (!required_opps[i])
-			break;
+			continue;
 
 		/* Put the reference back */
 		dev_pm_opp_put(required_opps[i]);
@@ -282,9 +304,7 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 				       struct dev_pm_opp *opp)
 {
 	struct dev_pm_opp **required_opps;
-	struct opp_table *required_table;
-	struct device_node *np;
-	int i, ret, count = opp_table->required_opp_count;
+	int count = opp_table->required_opp_count;
 
 	if (!count)
 		return 0;
@@ -295,32 +315,7 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 
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
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 01a500e2c40a..5b074eb7da07 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -225,12 +225,17 @@ void _of_clear_opp_table(struct opp_table *opp_table);
 struct opp_table *_managed_opp(struct device *dev, int index);
 void _of_opp_free_required_opps(struct opp_table *opp_table,
 				struct dev_pm_opp *opp);
+void _of_lazy_link_required_tables(struct opp_table *src);
 #else
 static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
 static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
 static inline struct opp_table *_managed_opp(struct device *dev, int index) { return NULL; }
 static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
 					      struct dev_pm_opp *opp) {}
+void bool _of_lazy_link_required_tables(struct opp_table *src)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.22.0.510.g264f2c817a-goog

