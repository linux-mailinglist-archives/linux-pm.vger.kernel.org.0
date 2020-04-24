Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EC41B7AD3
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 17:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgDXPyo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 11:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgDXPyM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 11:54:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B12C09B046
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 08:54:10 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so11494633wrx.4
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rAju4fK7CHysmmIehKnpso2uJ6HDzME/JcC5AUO00iw=;
        b=zdAYSeJUnlrn0u/CWL9bvvfbAzIdMiuDYYWEjaIXpg0UVkwGnTZkhLfX6mFLI0dtQ+
         VZaOb8QgCMqjaiwqSDjdzFo+p2wDecCG0QhbJJmF4dLdmXcWODABwDUOgsBr1cw+e4n5
         EPFaLHEZE4Df1w4lfx+RpyGIfJwqrQIGZl+Cis1xmYwCPqAEz2+Q3i5pSE7HTjmxjpkG
         3bMnlK4ef0NtEUdV4HM/gQqhPmHMYwWeF7lXsiXYJZg8an+/r30H3vUrThk/shse2zvs
         OoWSFjivoCfmByw59njCQUamGSAGJvijh8iiWHG6YUsXvgaovXxTHNlSOd/xrG7Z8Llv
         ptzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rAju4fK7CHysmmIehKnpso2uJ6HDzME/JcC5AUO00iw=;
        b=i8GWMxhL4+10Fni8MUxvy7BfjxY9wULsXEFnkFN5CMOO28QqgxK7IcNAUJbJxKhLBj
         Mu/CutvPNlkAlTteHMh4/T9L6PGUMCabl+1mGRaHv1BWnlh0S3Brj5ILgn5wuwkANrf1
         m0a1yH2a3rSHxLq7sl/TDpfpv1sCHqjMW5VGsi6nJzqdj2ecaSs2ffqWaJnQDgehSHOy
         BoDXEEVE/2EgjmSExaTr78Gkz/W4elAT/3fqlfQ1wSFhQZt4fmyvZwjj+n/LUiGxey+t
         LFbOm3kyK5Oan8Nfa7cJBNXqQEV/7AIC8KIzJ27XJp6x2aWp0rtFWqc1qnCaoI2RTabh
         PqeQ==
X-Gm-Message-State: AGi0PuY3T+OuLHUHO9bUaapYct773rb+LohJfLpAuyNnJF2pGdkMEhUM
        ucCf8QOgX3iNr90WgM1fE0GgBw==
X-Google-Smtp-Source: APiQypIQnHKRQRqEI3qjkLCNM//g6shPVX1vYzUfB6kNBgGf1SqfrNKEWPuvh++//uc0YjFK7y3A6w==
X-Received: by 2002:adf:db41:: with SMTP id f1mr11264741wrj.13.1587743649305;
        Fri, 24 Apr 2020 08:54:09 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id z76sm3923583wmc.9.2020.04.24.08.54.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:54:08 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        sibis@codeaurora.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, jcrouse@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v7 2/7] OPP: Add helpers for reading the binding properties
Date:   Fri, 24 Apr 2020 18:53:59 +0300
Message-Id: <20200424155404.10746-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200424155404.10746-1-georgi.djakov@linaro.org>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

The opp-hz DT property is not mandatory and we may use another property
as a key in the OPP table. Add helper functions to simplify the reading
and comparing the keys.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v7:
* Extracted just the helpers from patch v6, as Viresh advised to split it.

v6: https://lore.kernel.org/r/20191207002424.201796-3-saravanak@google.com

 drivers/opp/core.c | 15 +++++++++++++--
 drivers/opp/of.c   | 42 ++++++++++++++++++++++++++----------------
 drivers/opp/opp.h  |  1 +
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ba43e6a3dc0a..c9c1bbe6ae27 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1272,11 +1272,21 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
 	return true;
 }
 
+int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
+{
+	if (opp1->rate != opp2->rate)
+		return opp1->rate < opp2->rate ? -1 : 1;
+	if (opp1->level != opp2->level)
+		return opp1->level < opp2->level ? -1 : 1;
+	return 0;
+}
+
 static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
 			     struct opp_table *opp_table,
 			     struct list_head **head)
 {
 	struct dev_pm_opp *opp;
+	int opp_cmp;
 
 	/*
 	 * Insert new OPP in order of increasing frequency and discard if
@@ -1287,12 +1297,13 @@ static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
 	 * loop.
 	 */
 	list_for_each_entry(opp, &opp_table->opp_list, node) {
-		if (new_opp->rate > opp->rate) {
+		opp_cmp = _opp_compare_key(new_opp, opp);
+		if (opp_cmp > 0) {
 			*head = &opp->node;
 			continue;
 		}
 
-		if (new_opp->rate < opp->rate)
+		if (opp_cmp < 0)
 			return 0;
 
 		/* Duplicate OPPs */
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 9cd8f0adacae..e33169c7e045 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -521,6 +521,28 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
+static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
+			 bool *rate_not_available)
+{
+	u64 rate;
+	int ret;
+
+	ret = of_property_read_u64(np, "opp-hz", &rate);
+	if (!ret) {
+		/*
+		 * Rate is defined as an unsigned long in clk API, and so
+		 * casting explicitly to its type. Must be fixed once rate is 64
+		 * bit guaranteed in clk API.
+		 */
+		new_opp->rate = (unsigned long)rate;
+	}
+	*rate_not_available = !!ret;
+
+	of_property_read_u32(np, "opp-level", &new_opp->level);
+
+	return ret;
+}
+
 /**
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
  * @opp_table:	OPP table
@@ -558,26 +580,14 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	if (!new_opp)
 		return ERR_PTR(-ENOMEM);
 
-	ret = of_property_read_u64(np, "opp-hz", &rate);
+	ret = _read_opp_key(new_opp, np, &rate_not_available);
 	if (ret < 0) {
-		/* "opp-hz" is optional for devices like power domains. */
-		if (!opp_table->is_genpd) {
-			dev_err(dev, "%s: opp-hz not found\n", __func__);
-			goto free_opp;
-		}
+		if (!opp_table->is_genpd)
+			dev_err(dev, "%s: opp key field not found\n", __func__);
 
-		rate_not_available = true;
-	} else {
-		/*
-		 * Rate is defined as an unsigned long in clk API, and so
-		 * casting explicitly to its type. Must be fixed once rate is 64
-		 * bit guaranteed in clk API.
-		 */
-		new_opp->rate = (unsigned long)rate;
+		goto free_opp;
 	}
 
-	of_property_read_u32(np, "opp-level", &new_opp->level);
-
 	/* Check if the OPP supports hardware's hierarchy of versions or not */
 	if (!_opp_is_supported(dev, opp_table, np)) {
 		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index d14e27102730..bcadb1e328a4 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -211,6 +211,7 @@ struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_
 void _dev_pm_opp_find_and_remove_table(struct device *dev);
 struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
+int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table, bool rate_not_available);
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
