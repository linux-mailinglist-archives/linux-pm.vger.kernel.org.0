Return-Path: <linux-pm+bounces-13367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFBF968FE0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 00:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FA2AB21FD5
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 22:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E49418890C;
	Mon,  2 Sep 2024 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/PZwawo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A48187340
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 22:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317308; cv=none; b=k6FLvACcSQoidrzF7o9AHl9qnSb4AXFHFRbG62pJUketSGgkVuq4rbGyn/YziRwNiRYwosIA6ngJ1phKzWT5HMX1pGgEtlbLwOWbEBkGga4XaajCWE3bRd28epFf5zdUjd54pGuM3z9yz+pRNr0m1B9C37zfhDHA/UJxlz9BF44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317308; c=relaxed/simple;
	bh=LzUWQdGTlvvxerr/3ylQ+v75vLm4W6aDvWTRLNpxhCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q/dkk1JG1x/3QVLoCrVvYIJ79wbSA29MD1Oq4v0fBoVaNu6X1FSCt7+CPgRDtnADcO9e5eZmyTGw7NFbBLWEgQEvqJgckIKdNlnAkMUV2jBR+5PkZGSi3GPdBBW7ugeJnZgLOioCGYhWua9nUxd8N2DwR7LIksp7rQE0xRZD5WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d/PZwawo; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53560b2b444so143414e87.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 15:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725317305; x=1725922105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILko9GrGSTEsXrXVZflQuhfBdNy2+GsUHO1RFuWf+V0=;
        b=d/PZwawozXkdIZW5PhCclNpY61oTSNzHLZyfglktd8rnGUv6wXZffuMxa2mQnY//8W
         bruw57jGkeZz27s3oyJeuyJGdsNG0Mh0PhXCggeMMctj3UCXyQBC+QkcMrHmXYb+4Xym
         Ryp5ys9gPvvuTG3iiAy/AfiBGPBOFVD5bl1E310+MY/KDfkM2hn9DL51AO3R0Lp9t45O
         FluUxKcJefmvfbUCzjTVuqavDIMDVdk9gv21z32Jcrr7+QdXp/sKoXXz6K8yiPwfHtgI
         FAT2SMhj9GLyMDPlumijruf/21VXP0xzNL/8gwIe2lw2kCkBaOWudsieGjrxHAAza9Of
         4U0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725317305; x=1725922105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILko9GrGSTEsXrXVZflQuhfBdNy2+GsUHO1RFuWf+V0=;
        b=nDX2kcxoHztOLizcangwuYUCs4qCmQig/rZaN8dsl3zuwwQx8jDZSr1JW23d6I6BGE
         MuLqtzD5382XcGKO0FTjc8iBYGdx9WElOi8gSTx7YDxbpVl+YjHMlRVYGqZJ55okr4qL
         65X87JQvd7pIwXcQDncM8EUayHtz4EYNWiztpH14IZMIp0UuVjUB1rGmFQtEKRApQ9sV
         HFoUxnrQGcwPuA9DF7EZf2lDbNrKnjh3cWUco4Vzj/jrSV+t1eEyitH8QUxGbFPLD7UI
         YPSJ3mjaOBIPnHZ13tSdaLLZkVLhjkD8vV6EFmc2ktzBizw4JMFgimBaBvJkzaVMoEZj
         XkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlBx8qq/v3fiA2tvnrZGA4Ld870kHBiH4lPKPmmxUy9aVr+6huiO1iUg52CAy5Zly3LBoLKBA28A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQcgesUHL/dFYezM5ewJGu61ID3TMKfAunvm33zLAxCZe6mwC
	ETr/oNkMVJW88e4Rw2p4SgncqHD0fYMh/l1wpQEBtONYerZR7sJpRfk6sGyPCaI=
X-Google-Smtp-Source: AGHT+IFum6vAI4M7Ifv5kv5ZZ8Ww55Gm2DB955sOcPDG5+CQnwdg/OMQzsSkUUI+7Z9IA063dZuH2g==
X-Received: by 2002:a05:6512:3088:b0:52c:dc06:d4ad with SMTP id 2adb3069b0e04-535462ee5demr3891202e87.6.1725317304291;
        Mon, 02 Sep 2024 15:48:24 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079bbf2sm1790646e87.20.2024.09.02.15.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 15:48:23 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] OPP/pmdomain: Fix the assignment of the required-devs
Date: Tue,  3 Sep 2024 00:48:15 +0200
Message-Id: <20240902224815.78220-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902224815.78220-1-ulf.hansson@linaro.org>
References: <20240902224815.78220-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent attempt to make genpd first lookup an OPP table for a device
that has been attached to it and then let the OPP core validate whether the
OPP table is correct, fails for some configurations.

More precisely, if a device has multiple power-domains, which all has an
OPP table associated, doesn't necessarily mean that the device's OPP table
needs multiple phandles specified in the required-opps. Instead it's
perfectly possible to use a single phandle in the required-opps, which is
typically where the current code fails to assign the correct required-dev.

To fix this problem, let's instead start by letting the OPP core find the
device node for the required OPP table and then let genpd search for a
corresponding OPP table, allowing us the find the correct required-dev to
assign for it.

Reported-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Fixes: f0d2dcc9b087 ("OPP/pmdomain: Set the required_dev for a required OPP during genpd attach")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c      | 15 +++++++-----
 drivers/pmdomain/core.c | 52 +++++++++++++++++++++++------------------
 include/linux/pm_opp.h  |  7 ++++--
 3 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 66cac7a1d9db..538612886446 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2363,7 +2363,7 @@ static void _opp_put_config_regulators_helper(struct opp_table *opp_table)
 static int _opp_set_required_dev(struct opp_table *opp_table,
 				 struct device *dev,
 				 struct device *required_dev,
-				 struct opp_table *required_opp_table)
+				 config_required_dev_t config_required_dev)
 {
 	int i;
 
@@ -2380,6 +2380,7 @@ static int _opp_set_required_dev(struct opp_table *opp_table,
 
 	for (i = 0; i < opp_table->required_opp_count; i++) {
 		struct opp_table *table = opp_table->required_opp_tables[i];
+		struct opp_table *required_opp_table;
 
 		/*
 		 * The OPP table should be available at this point. If not, it's
@@ -2396,7 +2397,9 @@ static int _opp_set_required_dev(struct opp_table *opp_table,
 		 * We need to compare the nodes for the OPP tables, rather than
 		 * the OPP tables themselves, as we may have separate instances.
 		 */
-		if (required_opp_table->np == table->np) {
+		required_opp_table = config_required_dev(required_dev,
+							 table->np);
+		if (required_opp_table) {
 			/*
 			 * The required_opp_tables parsing is not perfect, as
 			 * the OPP core does the parsing solely based on the DT
@@ -2422,8 +2425,8 @@ static int _opp_set_required_dev(struct opp_table *opp_table,
 		}
 	}
 
-	dev_err(dev, "Missing OPP table, unable to set the required dev\n");
-	return -ENODEV;
+	/* No matching OPP table found for the required_dev. */
+	return -ERANGE;
 }
 
 static void _opp_put_required_dev(struct opp_table *opp_table,
@@ -2547,10 +2550,10 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 		data->flags |= OPP_CONFIG_REGULATOR;
 	}
 
-	if (config->required_dev && config->required_opp_table) {
+	if (config->required_dev && config->config_required_dev) {
 		ret = _opp_set_required_dev(opp_table, dev,
 					    config->required_dev,
-					    config->required_opp_table);
+					    config->config_required_dev);
 		if (ret < 0)
 			goto err;
 
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index edef1a520110..0ff0b513b2a1 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2874,20 +2874,21 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
-static struct opp_table *genpd_find_opp_table(struct generic_pm_domain *genpd,
-					      unsigned int depth)
+static struct opp_table *_genpd_find_opp_table(struct generic_pm_domain *genpd,
+					       struct device_node *np,
+					       unsigned int depth)
 {
-	struct opp_table *opp_table;
+	struct opp_table *opp_table = genpd->opp_table;
 	struct gpd_link *link;
 
-	if (genpd->opp_table)
-		return genpd->opp_table;
+	if (opp_table && (dev_pm_opp_table_to_of_node(opp_table) == np))
+		return opp_table;
 
 	list_for_each_entry(link, &genpd->child_links, child_node) {
 		struct generic_pm_domain *parent = link->parent;
 
 		genpd_lock_nested(parent, depth + 1);
-		opp_table = genpd_find_opp_table(parent, depth + 1);
+		opp_table = _genpd_find_opp_table(parent, np, depth + 1);
 		genpd_unlock(parent);
 
 		if (opp_table)
@@ -2897,12 +2898,27 @@ static struct opp_table *genpd_find_opp_table(struct generic_pm_domain *genpd,
 	return NULL;
 }
 
-static int genpd_set_required_opp_dev(struct device *dev,
-				      struct device *base_dev)
+static struct opp_table *genpd_find_opp_table(struct device *dev,
+					      struct device_node *np)
 {
 	struct generic_pm_domain *genpd = dev_to_genpd(dev);
 	struct opp_table *opp_table;
-	int ret = 0;
+
+	genpd_lock(genpd);
+	opp_table = _genpd_find_opp_table(genpd, np, 0);
+	genpd_unlock(genpd);
+
+	return opp_table;
+}
+
+static int genpd_set_required_opp_dev(struct device *dev,
+				      struct device *base_dev)
+{
+	struct dev_pm_opp_config config = {
+		.required_dev = dev,
+		.config_required_dev = genpd_find_opp_table,
+	};
+	int ret;
 
 	/* Limit support to non-providers for now. */
 	if (of_property_present(base_dev->of_node, "#power-domain-cells"))
@@ -2911,20 +2927,10 @@ static int genpd_set_required_opp_dev(struct device *dev,
 	if (!dev_pm_opp_of_has_required_opp(base_dev))
 		return 0;
 
-	genpd_lock(genpd);
-	opp_table = genpd_find_opp_table(genpd, 0);
-	genpd_unlock(genpd);
-
-	if (opp_table) {
-		struct dev_pm_opp_config config = {
-			.required_dev = dev,
-			.required_opp_table = opp_table,
-		};
-
-		ret = devm_pm_opp_set_config(base_dev, &config);
-		if (ret < 0)
-			dev_err(dev, "failed to set opp config %d\n", ret);
-	}
+	ret = devm_pm_opp_set_config(base_dev, &config);
+	ret = ret == -ERANGE ? 0 : ret;
+	if (ret < 0)
+		dev_err(dev, "failed to set opp config %d\n", ret);
 
 	return ret;
 }
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 7894e631cded..0ada4a5057c8 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -53,6 +53,9 @@ typedef int (*config_regulators_t)(struct device *dev,
 typedef int (*config_clks_t)(struct device *dev, struct opp_table *opp_table,
 			struct dev_pm_opp *opp, void *data, bool scaling_down);
 
+typedef struct opp_table *(*config_required_dev_t)(struct device *dev,
+			struct device_node *opp_table_np);
+
 /**
  * struct dev_pm_opp_config - Device OPP configuration values
  * @clk_names: Clk names, NULL terminated array.
@@ -63,7 +66,7 @@ typedef int (*config_clks_t)(struct device *dev, struct opp_table *opp_table,
  * @supported_hw_count: Number of elements in the array.
  * @regulator_names: Array of pointers to the names of the regulator, NULL terminated.
  * @required_dev: Required OPP device.
- * @required_opp_table: The corresponding required OPP table for @required_dev.
+ * @config_required_dev: Custom helper to find the required OPP table for $required_dev.
  *
  * This structure contains platform specific OPP configurations for the device.
  */
@@ -77,7 +80,7 @@ struct dev_pm_opp_config {
 	unsigned int supported_hw_count;
 	const char * const *regulator_names;
 	struct device *required_dev;
-	struct opp_table *required_opp_table;
+	config_required_dev_t config_required_dev;
 };
 
 #define OPP_LEVEL_UNSET			U32_MAX
-- 
2.34.1


