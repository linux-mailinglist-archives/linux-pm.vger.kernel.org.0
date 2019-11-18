Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7604E100374
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 12:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfKRLDC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 06:03:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33149 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKRLDB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 06:03:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay6so9609763plb.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2019 03:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VeawawUi5g0FfCTDEqJ5MvcxHdxdB9dBz92ffBaoMAw=;
        b=vE1W3sHhoL/g1XDHkWsw1urllydBJJ1q2dvEuhlzBOxwkuq0i5CwahCJlI06NaoGPo
         iauR3qHs50+aLvD1VkmN1wVJdqN5jAVym9oUICZEuyH2QECT7kYRs+iB+NzGcRv4/cTn
         Kp73sCDSOqHlfzKgQ5CTlwEFVBaLSNwbJVv4mGHK/0lsx+atW/SYJ00TpXP9hQshljUf
         WvLsjxHZ3LJQItQDoPcl3mjmR4ND5iUBG6Ye2aJwdCa9cTEWiU4L20QwCcyxjj0RDHTU
         sOG3iWp5wRB34g/fMPZMuZt035TGFoc4XtjktmJqZvdVeNDh5/AR7uZ4klvno6vvC09V
         hJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VeawawUi5g0FfCTDEqJ5MvcxHdxdB9dBz92ffBaoMAw=;
        b=L5HjlRcBI1DCfXhCr5laTz/zutJQ0GbMjUFbvBd0KbNOJVLpJx/lpKc9kkTrOnwSR3
         sMjLmpsH0I/lnkEJbRWj6b/tbiXeANIJLmZGw8n+7LhZlNdbWMHME/eje/dNEC41wqIW
         OAXZu+L4CYWItcr8jVGpddPkG6vl8upQ3T2p21e+p1v742BnCNfJsIJYhBTlS9LYs9uf
         6cAbnRtyoCYepFdayLhv0V0orsZrIG5/fjGFt5H3hSvFIE96r2xywCryQCelU7Am5eXm
         xQuVjfEiwBMuf7lwsoKi2j4H0B2JDmGsdSn81hFOqWWxWU4NyEgcneden5aWBFZ2Ncvi
         ut4A==
X-Gm-Message-State: APjAAAUFClccty7SOGUFf0Solp+ysWYSNfYheVWhgwkQTJ+cBIiZLcWm
        QmgID99HlxVgmWSbv+TdQ8j7fg==
X-Google-Smtp-Source: APXvYqxFsYI+UYZKTbw1T621cq6Iam/b5vsDkEu/WyX9IyZQ+Nvg7ntahhKNSBeZ/JRcdvfxISzGcA==
X-Received: by 2002:a17:90b:30cc:: with SMTP id hi12mr38477303pjb.80.1574074980611;
        Mon, 18 Nov 2019 03:03:00 -0800 (PST)
Received: from localhost ([223.226.74.76])
        by smtp.gmail.com with ESMTPSA id b7sm18966026pjo.3.2019.11.18.03.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 03:03:00 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] opp: Replace list_kref with a local counter
Date:   Mon, 18 Nov 2019 16:32:50 +0530
Message-Id: <bc5326ca95314cbebc3ffed8d476dd2e815f8382.1574074666.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <befccaf76d647f30e03c115ed7a096ebd5384ecd.1574074666.git.viresh.kumar@linaro.org>
References: <befccaf76d647f30e03c115ed7a096ebd5384ecd.1574074666.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A kref or refcount isn't the right tool to be used here for counting
number of devices that are sharing the static OPPs created for the OPP
table. For example, we are reinitializing the kref again, after it
reaches a value of 0 and frees the resources, if the static OPPs get
added for the same OPP table structure (as the OPP table structure was
never freed). That is messy and very unclear.

This patch makes parsed_static_opps an unsigned integer and uses it to
count the number of users of the static OPPs. The increment and
decrement to parsed_static_opps is done under opp_table->lock now to
make sure no races are possible if the OPP table is getting added and
removed in parallel (which doesn't happen in practice, but can in
theory).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 48 ++++++++++++++++++----------------------------
 drivers/opp/of.c   | 26 +++++++++++--------------
 drivers/opp/opp.h  |  6 ++----
 3 files changed, 32 insertions(+), 48 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index be7a7d332332..ba43e6a3dc0a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -988,7 +988,6 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
 	kref_init(&opp_table->kref);
-	kref_init(&opp_table->list_kref);
 
 	/* Secure the device table modification */
 	list_add(&opp_table->node, &opp_tables);
@@ -1072,33 +1071,6 @@ static void _opp_table_kref_release(struct kref *kref)
 	mutex_unlock(&opp_table_lock);
 }
 
-void _opp_remove_all_static(struct opp_table *opp_table)
-{
-	struct dev_pm_opp *opp, *tmp;
-
-	list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
-		if (!opp->dynamic)
-			dev_pm_opp_put(opp);
-	}
-
-	opp_table->parsed_static_opps = false;
-}
-
-static void _opp_table_list_kref_release(struct kref *kref)
-{
-	struct opp_table *opp_table = container_of(kref, struct opp_table,
-						   list_kref);
-
-	_opp_remove_all_static(opp_table);
-	mutex_unlock(&opp_table_lock);
-}
-
-void _put_opp_list_kref(struct opp_table *opp_table)
-{
-	kref_put_mutex(&opp_table->list_kref, _opp_table_list_kref_release,
-		       &opp_table_lock);
-}
-
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table)
 {
 	kref_put_mutex(&opp_table->kref, _opp_table_kref_release,
@@ -1202,6 +1174,24 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 
+void _opp_remove_all_static(struct opp_table *opp_table)
+{
+	struct dev_pm_opp *opp, *tmp;
+
+	mutex_lock(&opp_table->lock);
+
+	if (!opp_table->parsed_static_opps || --opp_table->parsed_static_opps)
+		goto unlock;
+
+	list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
+		if (!opp->dynamic)
+			dev_pm_opp_put_unlocked(opp);
+	}
+
+unlock:
+	mutex_unlock(&opp_table->lock);
+}
+
 /**
  * dev_pm_opp_remove_all_dynamic() - Remove all dynamically created OPPs
  * @dev:	device for which we do this operation
@@ -2276,7 +2266,7 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev)
 		return;
 	}
 
-	_put_opp_list_kref(opp_table);
+	_opp_remove_all_static(opp_table);
 
 	/* Drop reference taken by _find_opp_table() */
 	dev_pm_opp_put_opp_table(opp_table);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1e5fcdee043c..9cd8f0adacae 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -658,17 +658,15 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	struct dev_pm_opp *opp;
 
 	/* OPP table is already initialized for the device */
+	mutex_lock(&opp_table->lock);
 	if (opp_table->parsed_static_opps) {
-		kref_get(&opp_table->list_kref);
+		opp_table->parsed_static_opps++;
+		mutex_unlock(&opp_table->lock);
 		return 0;
 	}
 
-	/*
-	 * Re-initialize list_kref every time we add static OPPs to the OPP
-	 * table as the reference count may be 0 after the last tie static OPPs
-	 * were removed.
-	 */
-	kref_init(&opp_table->list_kref);
+	opp_table->parsed_static_opps = 1;
+	mutex_unlock(&opp_table->lock);
 
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_table->np, np) {
@@ -678,7 +676,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
 			of_node_put(np);
-			goto put_list_kref;
+			goto remove_static_opp;
 		} else if (opp) {
 			count++;
 		}
@@ -687,7 +685,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	/* There should be one of more OPP defined */
 	if (WARN_ON(!count)) {
 		ret = -ENOENT;
-		goto put_list_kref;
+		goto remove_static_opp;
 	}
 
 	list_for_each_entry(opp, &opp_table->opp_list, node)
@@ -698,18 +696,16 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
 			count, pstate_count);
 		ret = -ENOENT;
-		goto put_list_kref;
+		goto remove_static_opp;
 	}
 
 	if (pstate_count)
 		opp_table->genpd_performance_state = true;
 
-	opp_table->parsed_static_opps = true;
-
 	return 0;
 
-put_list_kref:
-	_put_opp_list_kref(opp_table);
+remove_static_opp:
+	_opp_remove_all_static(opp_table);
 
 	return ret;
 }
@@ -746,7 +742,7 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
 				__func__, freq, ret);
-			_put_opp_list_kref(opp_table);
+			_opp_remove_all_static(opp_table);
 			return ret;
 		}
 		nr -= 2;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 01a500e2c40a..d14e27102730 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -127,11 +127,10 @@ enum opp_table_access {
  * @dev_list:	list of devices that share these OPPs
  * @opp_list:	table of opps
  * @kref:	for reference count of the table.
- * @list_kref:	for reference count of the OPP list.
  * @lock:	mutex protecting the opp_list and dev_list.
  * @np:		struct device_node pointer for opp's DT node.
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
- * @parsed_static_opps: True if OPPs are initialized from DT.
+ * @parsed_static_opps: Count of devices for which OPPs are initialized from DT.
  * @shared_opp: OPP is shared between multiple devices.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
  * @genpd_virt_dev_lock: Mutex protecting the genpd virtual device pointers.
@@ -167,7 +166,6 @@ struct opp_table {
 	struct list_head dev_list;
 	struct list_head opp_list;
 	struct kref kref;
-	struct kref list_kref;
 	struct mutex lock;
 
 	struct device_node *np;
@@ -176,7 +174,7 @@ struct opp_table {
 	/* For backward compatibility with v1 bindings */
 	unsigned int voltage_tolerance_v1;
 
-	bool parsed_static_opps;
+	unsigned int parsed_static_opps;
 	enum opp_table_access shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
-- 
2.21.0.rc0.269.g1a574e7a288b

