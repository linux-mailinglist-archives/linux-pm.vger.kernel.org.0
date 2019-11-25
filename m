Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D82108CFA
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 12:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfKYL2u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 06:28:50 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36933 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbfKYL2R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 06:28:17 -0500
Received: by mail-pj1-f68.google.com with SMTP id bb19so2920027pjb.4
        for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2019 03:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sFmCj9/uzGLY6INEDkLf3+QiN1goQxEIkBKgvdFPbOU=;
        b=v1SwdDuNjxX3EV4fB5vOHpcOyjl8/uJlWYjAxCtUbSz6r2h84x4wBmtZL+MTP3FV+2
         1+VaumgzdiWBiWmbuwZ1c+eZM0Vd5a9+miwbwqKIwh3cjXAQwIXAOM9KljcQ70wvOO82
         91lwUnF+eqKzwZFZp4ZssRApFu7dbASQNZV+Wf9cL15rmryUMc9ZM0dApMMmvWlzCxA9
         upgDkuAR7GQZh/D/UnXhXEmFDaqG1ebg4+hr9dKE3boySqww/whE2iR95MwgOz4bgcZV
         aXM4wDVOCWQdnGgadUnR6DvCJ/9i6aAh4ULK/a8ePHH5uQfcm6W/dWPut9L1SG1I1UOX
         N5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sFmCj9/uzGLY6INEDkLf3+QiN1goQxEIkBKgvdFPbOU=;
        b=kAABrgKtuieLXwdYDiARZnzQQfa/ZU9DIaPOOIAeYlrK2RWFAP2saztCpwbO7v8+Ch
         lZbgMQnxR8ABqxBu4CKunUReTNLIoj9SsZbcZYl7ucn4qheOOPf58T7OvB0HiEh1EaMw
         0s4iTyyyfgBha20wcnFm5gKvrKV72MH0Eg3aqOweB9EztGHXGbtIwUJazarfMswApGvk
         kGUzsR6ZugjE2lpQ7jfHF4UpZmNLVAmpaDO93bvAGMH0rCpesAPJX/0p5fgpnDyLDO5a
         2DCCFkTiI89Gyolo6gQViYxiF3s4uuCV0ZimG7YGZnToaHG8y9NV4pfMI5b3RhwpNelW
         6Slg==
X-Gm-Message-State: APjAAAWCuV4Wj3RLu1wl2aCckVyySXR40Ynh+E9V4358AKXtVjUCP4m/
        lJFTHnrkkPVnlw+26sx+Kdw3og==
X-Google-Smtp-Source: APXvYqzZG6nBhEjm/3ibDlIztFLyo8Cm2NhOZkir4N3toqPSQuNVBIIgF7xZz3cLIRpzHD8WdRKHfw==
X-Received: by 2002:a17:90a:8a0c:: with SMTP id w12mr18156504pjn.61.1574681296374;
        Mon, 25 Nov 2019 03:28:16 -0800 (PST)
Received: from localhost ([122.172.119.235])
        by smtp.gmail.com with ESMTPSA id r16sm8180641pgl.77.2019.11.25.03.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 03:28:14 -0800 (PST)
Date:   Mon, 25 Nov 2019 16:58:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
Message-ID: <20191125112812.26jk5hsdwqfnofc2@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-4-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717222340.137578-4-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-07-19, 15:23, Saravana Kannan wrote:
> Currently, the linking of required-opps fails silently if the
> destination OPP table hasn't been added before the source OPP table is
> added. This puts an unnecessary requirement that the destination table
> be added before the source table is added.

Here is my version of lazy-linking. Please give it a try. I have tested it by
faking hardware, it would be better if it gets tested properly in some platform.

--
viresh

-------------------------8<-------------------------
From 8df083ca64d82ff57f778689271cc1be75aa99c4 Mon Sep 17 00:00:00 2001
Message-Id: <8df083ca64d82ff57f778689271cc1be75aa99c4.1574681211.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 25 Nov 2019 13:57:58 +0530
Subject: [PATCH] opp: Allow lazy-linking of required-opps

The OPP core currently requires the required opp tables to be available
before the dependent OPP table is added, as it needs to create links
from the dependent OPP table to the required ones. This may not be
convenient to all the platforms though, as this requires strict ordering
of probing of drivers.

This patch allows lazy-linking of the required-opps. The OPP tables for
which the required-opp-tables aren't available at the time of their
initialization, are added to a special list of OPP tables:
pending_opp_tables. Later on, whenever a new OPP table is registered
with the OPP core, we check if it is required by an OPP table in the
pending list; if yes, then we complete the linking then and there.

An OPP table is marked unusable until the time all its required-opp
tables are available. And if lazy-linking fails for an OPP table, the
OPP core disables all of its OPPs to make sure no one can use them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  13 ++++++
 drivers/opp/of.c   | 113 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/opp/opp.h  |   4 +-
 3 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ba43e6a3dc0a..cafd468443a6 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -27,6 +27,10 @@
  * various states of availability.
  */
 LIST_HEAD(opp_tables);
+
+/* The root of the list of opp-tables that aren't fully initialized yet */
+LIST_HEAD(pending_opp_tables);
+
 /* Lock to allow exclusive modification to the device and opp lists */
 DEFINE_MUTEX(opp_table_lock);
 
@@ -754,6 +758,10 @@ static int _set_required_opps(struct device *dev,
 	if (!required_opp_tables)
 		return 0;
 
+	/* required-opps not fully initialized yet */
+	if (!list_empty(&opp_table->pending))
+		return -EBUSY;
+
 	/* Single genpd case */
 	if (!genpd_virt_devs) {
 		pstate = likely(opp) ? opp->required_opps[0]->pstate : 0;
@@ -964,6 +972,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	mutex_init(&opp_table->lock);
 	mutex_init(&opp_table->genpd_virt_dev_lock);
 	INIT_LIST_HEAD(&opp_table->dev_list);
+	INIT_LIST_HEAD(&opp_table->pending);
 
 	/* Mark regulator count uninitialized */
 	opp_table->regulator_count = -1;
@@ -1946,6 +1955,10 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
 	if (!pstate)
 		return 0;
 
+	/* required-opps not fully initialized yet */
+	if (!list_empty(&src_table->pending))
+		return -EBUSY;
+
 	/*
 	 * Normally the src_table will have the "required_opps" property set to
 	 * point to one of the OPPs in the dst_table, but in some cases the
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 9cd8f0adacae..a17bb47c39a5 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -143,7 +143,7 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
 
 	for (i = 0; i < opp_table->required_opp_count; i++) {
 		if (IS_ERR_OR_NULL(required_opp_tables[i]))
-			break;
+			continue;
 
 		dev_pm_opp_put_opp_table(required_opp_tables[i]);
 	}
@@ -152,6 +152,7 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
 
 	opp_table->required_opp_count = 0;
 	opp_table->required_opp_tables = NULL;
+	list_del(&opp_table->pending);
 }
 
 /*
@@ -164,6 +165,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 {
 	struct opp_table **required_opp_tables;
 	struct device_node *required_np, *np;
+	bool pending = false;
 	int count, i;
 
 	/* Traversing the first OPP node is all we need */
@@ -193,8 +195,10 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 		required_opp_tables[i] = _find_table_of_opp_np(required_np);
 		of_node_put(required_np);
 
-		if (IS_ERR(required_opp_tables[i]))
-			goto free_required_tables;
+		if (IS_ERR(required_opp_tables[i])) {
+			pending = true;
+			continue;
+		}
 
 		/*
 		 * We only support genpd's OPPs in the "required-opps" for now,
@@ -208,6 +212,10 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 		}
 	}
 
+	/* Let's do the linking later on */
+	if (pending)
+		list_add(&opp_table->pending, &pending_opp_tables);
+
 	goto put_np;
 
 free_required_tables:
@@ -276,7 +284,7 @@ void _of_opp_free_required_opps(struct opp_table *opp_table,
 
 	for (i = 0; i < opp_table->required_opp_count; i++) {
 		if (!required_opps[i])
-			break;
+			continue;
 
 		/* Put the reference back */
 		dev_pm_opp_put(required_opps[i]);
@@ -307,6 +315,10 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 	for (i = 0; i < count; i++) {
 		required_table = opp_table->required_opp_tables[i];
 
+		/* Required table not added yet, we will link later */
+		if (IS_ERR_OR_NULL(required_table))
+			continue;
+
 		np = of_parse_required_opp(opp->np, i);
 		if (unlikely(!np)) {
 			ret = -ENODEV;
@@ -332,6 +344,97 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 	return ret;
 }
 
+static int lazy_link_required_opps(struct opp_table *opp_table,
+				   struct opp_table *required_opp_table,
+				   int index)
+{
+	struct device_node *required_np;
+	struct dev_pm_opp *opp;
+
+	list_for_each_entry(opp, &opp_table->opp_list, node) {
+		required_np = of_parse_required_opp(opp->np, index);
+		if (unlikely(!required_np))
+			return -ENODEV;
+
+		opp->required_opps[index] = _find_opp_of_np(required_opp_table, required_np);
+		of_node_put(required_np);
+
+		if (!opp->required_opps[index]) {
+			pr_err("%s: Unable to find required OPP node: %pOF (%d)\n",
+					__func__, opp->np, index);
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+static void lazy_link_required_opp_table(struct opp_table *required_opp_table)
+{
+	struct opp_table *opp_table, *temp, **required_opp_tables;
+	struct device_node *required_np, *opp_np, *required_table_np;
+	int i, ret;
+
+	/*
+	 * We only support genpd's OPPs in the "required-opps" for now,
+	 * as we don't know much about other cases.
+	 */
+	if (!required_opp_table->is_genpd)
+		return;
+
+	mutex_lock(&opp_table_lock);
+
+	list_for_each_entry_safe(opp_table, temp, &pending_opp_tables, pending) {
+		bool pending = false;
+
+		/* opp_np can't be invalid here */
+		opp_np = of_get_next_available_child(opp_table->np, NULL);
+
+		for (i = 0; i < opp_table->required_opp_count; i++) {
+			required_opp_tables = opp_table->required_opp_tables;
+
+			if (!IS_ERR_OR_NULL(required_opp_tables[i]))
+				continue;
+
+			/* required_np can't be invalid here */
+			required_np = of_parse_required_opp(opp_np, i);
+			required_table_np = of_get_parent(required_np);
+
+			of_node_put(required_table_np);
+			of_node_put(required_np);
+
+			if (required_table_np != required_opp_table->np) {
+				pending = true;
+				continue;
+			}
+
+			required_opp_tables[i] = required_opp_table;
+			_get_opp_table_kref(required_opp_table);
+
+			/* Link OPPs now */
+			ret = lazy_link_required_opps(opp_table, required_opp_table, i);
+			if (ret) {
+				struct dev_pm_opp *opp;
+
+				/* Mark OPPs unusable on error */
+				list_for_each_entry(opp, &opp_table->opp_list, node)
+					opp->available = false;
+				break;
+			}
+		}
+
+		of_node_put(opp_np);
+
+		/* All required opp-tables found, remove from pending list */
+		if (!pending) {
+			list_del(&opp_table->pending);
+			INIT_LIST_HEAD(&opp_table->pending);
+		}
+	}
+
+	mutex_unlock(&opp_table_lock);
+}
+
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 			      struct device_node *np)
 {
@@ -702,6 +805,8 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	if (pstate_count)
 		opp_table->genpd_performance_state = true;
 
+	lazy_link_required_opp_table(opp_table);
+
 	return 0;
 
 remove_static_opp:
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index d14e27102730..1acbea35d58e 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -25,7 +25,7 @@ struct regulator;
 /* Lock to allow exclusive modification to the device and opp lists */
 extern struct mutex opp_table_lock;
 
-extern struct list_head opp_tables;
+extern struct list_head opp_tables, pending_opp_tables;
 
 /*
  * Internal data structure organization with the OPP layer library is as
@@ -160,7 +160,7 @@ enum opp_table_access {
  * meant for book keeping and private to OPP library.
  */
 struct opp_table {
-	struct list_head node;
+	struct list_head node, pending;
 
 	struct blocking_notifier_head head;
 	struct list_head dev_list;
-- 
2.21.0.rc0.269.g1a574e7a288b

