Return-Path: <linux-pm+bounces-26114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A027A9AAA3
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 12:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617C41941DB8
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF40A23D28C;
	Thu, 24 Apr 2025 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+RKelrJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DC23A989
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491041; cv=none; b=YXkqiMUvTqapHxq0BFKv/ioO/4L67RgHxSQZIh9h2FgIXZRn8zu8zjSOsubAZ0IBbY43CAKp4rbWrquZ8vyyNv3z1SrXtuvL1m/QPkNXnj/eq68RJFNwady5hnRe6Tgv0qWzmPxmZqnbS2jtamTwG/Xa4KFMUSJwvcmGbejgd8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491041; c=relaxed/simple;
	bh=VOa1T0aKJkkd4ubCM8nPBYNfRfmMW9NmHBOvyIP9zM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YdFnTCapNwuPXkwPXXPTldO9WvNUkmmwE7ODZ4RoZq8JLq6ILNV05JpV2qJKz+u/oCSlbyKdajpi1MzooWyTRU0nCqRec9EZRx8cusDMR3fl3QeglpIy/so5/oJ2fPl6wEh9QCmqDV4kC4PCEa+ahRp4vs7yjXwXxYwLdgnpn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o+RKelrJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22c33677183so8026995ad.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745491036; x=1746095836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnM7BGuhRXgKktziblZErpXUgiY+CFGwBppN4UGtJmo=;
        b=o+RKelrJSB0Hcm/82QHhpHUV/kOnwmEBGQXXoaWYXFG+YO+UkNXSFYV+UPFed5AFBu
         NXCtLEu2TZtL5pUpB4LosL+UvvfYULrOQfo9w6TxUhbPTaHgLqUzUCCi6mK0gScBRm0l
         NWdM9mA+NTEjz5wahG2+vjIRDOJ2J2B1KCPcsUt1bPMQzucDWEBWVCPB9eU5aepjRlDy
         i6DUd4zigbVH5dJYpqWR5dh+mp4jh0JNSZ0423yffi1B7FB2eUhJMtUOl2c5QGzvbl2r
         YopOMzlxYmUf8cYBIqq2yb6zTWox749rSuOO3iwZkk0Iw6verOv7fxvFCmx6KVDir0bK
         8Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491036; x=1746095836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnM7BGuhRXgKktziblZErpXUgiY+CFGwBppN4UGtJmo=;
        b=USmfTirZAT6EuJqJd08Yudgic9aZDilA/vNpej4PepuDjCGzJYZuH85YIv365YnFJi
         2IHYn4koyyRsS+bAEPsisH/iMj/py6zYnUrlkh/mgsCALAdAYyju4V/yWRkEV3t6nDU3
         Sd4NBTVwBGDuNtdoFVh+eQjb3bu7NPdTQXk84tx4U7rJFFadG/qHqHjcEbO2kHC58lb1
         5oDobfwWydzR44HpNejVM0UwhtS78LhHYnqTQPBs5jmoT8ob2yQsMVz/gKNNNmt+xclO
         y/0Rf2RZEZnp+X1STwBE1JBT++T9KFMYae/aczlE8kb4XAwTMWAZdOVLu0/EQubRX0Jo
         DFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9TZ7214M/eiCRuwarJeC7DB8OiXGpxOZQnG2YSCJeRIeEe1mhY3vlqbY0UcBjc1k2gZr454VGMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzYLPOgDuJ9tpdg3+rQOzWDHGo6gWyIycieaPIFWXSxeEDQoC3
	VIKVr+wWGy9dqYGB+clGJ8uTCU2mGfSVLH/Plb80pQXq/tbxk2rGBdDa/fj9WDw=
X-Gm-Gg: ASbGncsKmNd6hWjJ8kJ18JGpjCA5zCiP6EHZbiSFGBQjTn1b9pzfiee+tghMJt/M2nk
	z/qb50D1sNeavAiWNx8C5iKydVk2UAXkr0eQdNyb90YrJzxznh561Z3PRcKOg3jd8Rz4jUhLCM+
	K0dqptEhwWAmtYDrsdJBcLP4WrnryNhv8csTnGCHf+p1o9jkPu+BveBvzNwhTmD1KIQm1aHKXd4
	GEmWTfht5nZpq2rDL+kX2EuBRqMr2OCi7GbMjb/RZT5ycSsfcASyekLZPOEU+ePNfMBlCkaTgR/
	r8YW9Mh5QRYCs/T5ov9GunhhYrY+KpjSzYzaBdTIMLUE4PjTl31n
X-Google-Smtp-Source: AGHT+IH07Yj9Qvao1dL/i/uJ11l1+IF+hLKC6pC8RZiwmzbA3oxsha39/3dVJTGMAck9cT2f2/d5Tw==
X-Received: by 2002:a17:903:1b23:b0:223:53fb:e1dd with SMTP id d9443c01a7336-22db3bb2ce3mr29840195ad.9.1745491036240;
        Thu, 24 Apr 2025 03:37:16 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db51021a8sm9782395ad.172.2025.04.24.03.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:37:15 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] OPP: Use scope-based OF cleanup helpers
Date: Thu, 24 Apr 2025 16:06:47 +0530
Message-Id: <f95c855306fe47e809ca7ad6b4f330535f8b34fb.1745490980.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745490980.git.viresh.kumar@linaro.org>
References: <cover.1745490980.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the OF scope-based cleanup helpers for the OPP core.

No intentional functional impact.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 111 +++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 71 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c240acc81a8d..aa43fbfa3e50 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -45,7 +45,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
 struct opp_table *_managed_opp(struct device *dev, int index)
 {
 	struct opp_table *opp_table, *managed_table = NULL;
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 
 	np = _opp_of_get_opp_desc_node(dev->of_node, index);
 	if (!np)
@@ -67,8 +67,6 @@ struct opp_table *_managed_opp(struct device *dev, int index)
 		}
 	}
 
-	of_node_put(np);
-
 	return managed_table;
 }
 
@@ -102,16 +100,13 @@ static struct device_node *of_parse_required_opp(struct device_node *np,
 /* The caller must call dev_pm_opp_put_opp_table() after the table is used */
 static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
 {
+	struct device_node *opp_table_np __free(device_node);
 	struct opp_table *opp_table;
-	struct device_node *opp_table_np;
 
 	opp_table_np = of_get_parent(opp_np);
 	if (!opp_table_np)
 		goto err;
 
-	/* It is safe to put the node now as all we need now is its address */
-	of_node_put(opp_table_np);
-
 	mutex_lock(&opp_table_lock);
 	list_for_each_entry(opp_table, &opp_tables, node) {
 		if (opp_table_np == opp_table->np) {
@@ -161,7 +156,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 					     struct device_node *opp_np)
 {
 	struct opp_table **required_opp_tables;
-	struct device_node *required_np, *np;
+	struct device_node *np __free(device_node);
 	bool lazy = false;
 	int count, i, size;
 
@@ -169,30 +164,32 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	np = of_get_next_available_child(opp_np, NULL);
 	if (!np) {
 		dev_warn(dev, "Empty OPP table\n");
-
 		return;
 	}
 
 	count = of_count_phandle_with_args(np, "required-opps", NULL);
 	if (count <= 0)
-		goto put_np;
+		return;
 
 	size = sizeof(*required_opp_tables) + sizeof(*opp_table->required_devs);
 	required_opp_tables = kcalloc(count, size, GFP_KERNEL);
 	if (!required_opp_tables)
-		goto put_np;
+		return;
 
 	opp_table->required_opp_tables = required_opp_tables;
 	opp_table->required_devs = (void *)(required_opp_tables + count);
 	opp_table->required_opp_count = count;
 
 	for (i = 0; i < count; i++) {
+		struct device_node *required_np __free(device_node);
+
 		required_np = of_parse_required_opp(np, i);
-		if (!required_np)
-			goto free_required_tables;
+		if (!required_np) {
+			_opp_table_free_required_tables(opp_table);
+			return;
+		}
 
 		required_opp_tables[i] = _find_table_of_opp_np(required_np);
-		of_node_put(required_np);
 
 		if (IS_ERR(required_opp_tables[i]))
 			lazy = true;
@@ -208,19 +205,12 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 		list_add(&opp_table->lazy, &lazy_opp_tables);
 		mutex_unlock(&opp_table_lock);
 	}
-
-	goto put_np;
-
-free_required_tables:
-	_opp_table_free_required_tables(opp_table);
-put_np:
-	of_node_put(np);
 }
 
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
 			int index)
 {
-	struct device_node *np, *opp_np;
+	struct device_node *np __free(device_node), *opp_np;
 	u32 val;
 
 	/*
@@ -241,8 +231,6 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
 
 	/* Get OPP table node */
 	opp_np = _opp_of_get_opp_desc_node(np, index);
-	of_node_put(np);
-
 	if (!opp_np)
 		return;
 
@@ -296,15 +284,13 @@ void _of_clear_opp(struct opp_table *opp_table, struct dev_pm_opp *opp)
 static int _link_required_opps(struct dev_pm_opp *opp,
 			       struct opp_table *required_table, int index)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 
 	np = of_parse_required_opp(opp->np, index);
 	if (unlikely(!np))
 		return -ENODEV;
 
 	opp->required_opps[index] = _find_opp_of_np(required_table, np);
-	of_node_put(np);
-
 	if (!opp->required_opps[index]) {
 		pr_err("%s: Unable to find required OPP node: %pOF (%d)\n",
 		       __func__, opp->np, index);
@@ -368,19 +354,22 @@ static int lazy_link_required_opps(struct opp_table *opp_table,
 static void lazy_link_required_opp_table(struct opp_table *new_table)
 {
 	struct opp_table *opp_table, *temp, **required_opp_tables;
-	struct device_node *required_np, *opp_np, *required_table_np;
 	struct dev_pm_opp *opp;
 	int i, ret;
 
 	mutex_lock(&opp_table_lock);
 
 	list_for_each_entry_safe(opp_table, temp, &lazy_opp_tables, lazy) {
+		struct device_node *opp_np __free(device_node);
 		bool lazy = false;
 
 		/* opp_np can't be invalid here */
 		opp_np = of_get_next_available_child(opp_table->np, NULL);
 
 		for (i = 0; i < opp_table->required_opp_count; i++) {
+			struct device_node *required_np __free(device_node) = NULL;
+			struct device_node *required_table_np __free(device_node) = NULL;
+
 			required_opp_tables = opp_table->required_opp_tables;
 
 			/* Required opp-table is already parsed */
@@ -391,9 +380,6 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
 			required_np = of_parse_required_opp(opp_np, i);
 			required_table_np = of_get_parent(required_np);
 
-			of_node_put(required_table_np);
-			of_node_put(required_np);
-
 			/*
 			 * Newly added table isn't the required opp-table for
 			 * opp_table.
@@ -414,8 +400,6 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
 			}
 		}
 
-		of_node_put(opp_np);
-
 		/* All required opp-tables found, remove from lazy list */
 		if (!lazy) {
 			list_del_init(&opp_table->lazy);
@@ -430,16 +414,18 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
 
 static int _bandwidth_supported(struct device *dev, struct opp_table *opp_table)
 {
-	struct device_node *np, *opp_np;
+	struct device_node *opp_np __free(device_node) = NULL;
+	struct device_node *np __free(device_node) = NULL;
 	struct property *prop;
 
 	if (!opp_table) {
+		struct device_node *np __free(device_node);
+
 		np = of_node_get(dev->of_node);
 		if (!np)
 			return -ENODEV;
 
 		opp_np = _opp_of_get_opp_desc_node(np, 0);
-		of_node_put(np);
 	} else {
 		opp_np = of_node_get(opp_table->np);
 	}
@@ -450,15 +436,12 @@ static int _bandwidth_supported(struct device *dev, struct opp_table *opp_table)
 
 	/* Checking only first OPP is sufficient */
 	np = of_get_next_available_child(opp_np, NULL);
-	of_node_put(opp_np);
 	if (!np) {
 		dev_err(dev, "OPP table empty\n");
 		return -EINVAL;
 	}
 
 	prop = of_find_property(np, "opp-peak-kBps", NULL);
-	of_node_put(np);
-
 	if (!prop || !prop->length)
 		return 0;
 
@@ -468,7 +451,7 @@ static int _bandwidth_supported(struct device *dev, struct opp_table *opp_table)
 int dev_pm_opp_of_find_icc_paths(struct device *dev,
 				 struct opp_table *opp_table)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node) = of_node_get(dev->of_node);
 	int ret, i, count, num_paths;
 	struct icc_path **paths;
 
@@ -478,15 +461,13 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
 	else if (ret <= 0)
 		return ret;
 
-	ret = 0;
-
-	np = of_node_get(dev->of_node);
 	if (!np)
 		return 0;
 
+	ret = 0;
+
 	count = of_count_phandle_with_args(np, "interconnects",
 					   "#interconnect-cells");
-	of_node_put(np);
 	if (count < 0)
 		return 0;
 
@@ -1303,8 +1284,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 				   struct cpumask *cpumask)
 {
-	struct device_node *np, *tmp_np, *cpu_np;
-	int cpu, ret = 0;
+	struct device_node *np __free(device_node);
+	int cpu;
 
 	/* Get OPP descriptor node */
 	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
@@ -1317,9 +1298,12 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 
 	/* OPPs are shared ? */
 	if (!of_property_read_bool(np, "opp-shared"))
-		goto put_cpu_node;
+		return 0;
 
 	for_each_possible_cpu(cpu) {
+		struct device_node *cpu_np __free(device_node) = NULL;
+		struct device_node *tmp_np __free(device_node) = NULL;
+
 		if (cpu == cpu_dev->id)
 			continue;
 
@@ -1327,29 +1311,22 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 		if (!cpu_np) {
 			dev_err(cpu_dev, "%s: failed to get cpu%d node\n",
 				__func__, cpu);
-			ret = -ENOENT;
-			goto put_cpu_node;
+			return -ENOENT;
 		}
 
 		/* Get OPP descriptor node */
 		tmp_np = _opp_of_get_opp_desc_node(cpu_np, 0);
-		of_node_put(cpu_np);
 		if (!tmp_np) {
 			pr_err("%pOF: Couldn't find opp node\n", cpu_np);
-			ret = -ENOENT;
-			goto put_cpu_node;
+			return -ENOENT;
 		}
 
 		/* CPUs are sharing opp node */
 		if (np == tmp_np)
 			cpumask_set_cpu(cpu, cpumask);
-
-		of_node_put(tmp_np);
 	}
 
-put_cpu_node:
-	of_node_put(np);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
 
@@ -1366,9 +1343,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
  */
 int of_get_required_opp_performance_state(struct device_node *np, int index)
 {
-	struct dev_pm_opp *opp;
-	struct device_node *required_np;
+	struct device_node *required_np __free(device_node);
 	struct opp_table *opp_table;
+	struct dev_pm_opp *opp;
 	int pstate = -EINVAL;
 
 	required_np = of_parse_required_opp(np, index);
@@ -1379,13 +1356,13 @@ int of_get_required_opp_performance_state(struct device_node *np, int index)
 	if (IS_ERR(opp_table)) {
 		pr_err("%s: Failed to find required OPP table %pOF: %ld\n",
 		       __func__, np, PTR_ERR(opp_table));
-		goto put_required_np;
+		return PTR_ERR(opp_table);
 	}
 
 	/* The OPP tables must belong to a genpd */
 	if (unlikely(!opp_table->is_genpd)) {
 		pr_err("%s: Performance state is only valid for genpds.\n", __func__);
-		goto put_required_np;
+		return -EINVAL;
 	}
 
 	opp = _find_opp_of_np(opp_table, required_np);
@@ -1401,10 +1378,6 @@ int of_get_required_opp_performance_state(struct device_node *np, int index)
 	}
 
 	dev_pm_opp_put_opp_table(opp_table);
-
-put_required_np:
-	of_node_put(required_np);
-
 	return pstate;
 }
 EXPORT_SYMBOL_GPL(of_get_required_opp_performance_state);
@@ -1421,7 +1394,7 @@ EXPORT_SYMBOL_GPL(of_get_required_opp_performance_state);
  */
 bool dev_pm_opp_of_has_required_opp(struct device *dev)
 {
-	struct device_node *opp_np, *np;
+	struct device_node *np __free(device_node) = NULL, *opp_np __free(device_node);
 	int count;
 
 	opp_np = _opp_of_get_opp_desc_node(dev->of_node, 0);
@@ -1429,14 +1402,12 @@ bool dev_pm_opp_of_has_required_opp(struct device *dev)
 		return false;
 
 	np = of_get_next_available_child(opp_np, NULL);
-	of_node_put(opp_np);
 	if (!np) {
 		dev_warn(dev, "Empty OPP table\n");
 		return false;
 	}
 
 	count = of_count_phandle_with_args(np, "required-opps", NULL);
-	of_node_put(np);
 
 	return count > 0;
 }
@@ -1513,8 +1484,8 @@ _get_dt_power(struct device *dev, unsigned long *uW, unsigned long *kHz)
 int dev_pm_opp_calc_power(struct device *dev, unsigned long *uW,
 			  unsigned long *kHz)
 {
+	struct device_node *np __free(device_node);
 	struct dev_pm_opp *opp;
-	struct device_node *np;
 	unsigned long mV, Hz;
 	u32 cap;
 	u64 tmp;
@@ -1525,7 +1496,6 @@ int dev_pm_opp_calc_power(struct device *dev, unsigned long *uW,
 		return -EINVAL;
 
 	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
-	of_node_put(np);
 	if (ret)
 		return -EINVAL;
 
@@ -1581,8 +1551,8 @@ static bool _of_has_opp_microwatt_property(struct device *dev)
  */
 int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
 {
+	struct device_node *np __free(device_node) = NULL;
 	struct em_data_callback em_cb;
-	struct device_node *np;
 	int ret, nr_opp;
 	u32 cap;
 
@@ -1617,7 +1587,6 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
 	 * user about the inconsistent configuration.
 	 */
 	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
-	of_node_put(np);
 	if (ret || !cap) {
 		dev_dbg(dev, "Couldn't find proper 'dynamic-power-coefficient' in DT\n");
 		ret = -EINVAL;
-- 
2.31.1.272.g89b43f80a514


