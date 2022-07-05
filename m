Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2235663C4
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 09:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiGEHA5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 03:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiGEHAp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 03:00:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D4D1147C
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 00:00:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id r1so10222791plo.10
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 00:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=miW8Tr7lV7G34W+RMqWJnrYWMkcRAss34hOq+aE2O90=;
        b=CsHSuaH9QoAcMU51PGaqtXOpeV+UKOMHFJgIkdj032ULga4/6muXaTuj75cplkOM8s
         ++FurW1vI6T3RCVZcRJ49SSkOvGlXfty/zhpT6ZwRbo9BGFCaNorURdAmhKpa6wk9re6
         T3Scdb5hkItEAFco+8wl587AJc/6eYv/HKUFdfowTRYcdtx3nLNBi0GwLWOk2t84dRyP
         HlqwxoUAGmDcrkg9Uf7ZuQ09/X5Q+kqDkeyDIUjHtEekp5hOINHkMiHZFF2/PK02ByNn
         Zs5R9smmFbY+O0Pr3jBKWaNnbUJ8qhAyPP1LuNz5PHeHmht9ZgXr2dK3aHQYRhqe+mXB
         pPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=miW8Tr7lV7G34W+RMqWJnrYWMkcRAss34hOq+aE2O90=;
        b=TJlZ8CZa4HduTzCLMjJJL0+dR3v7csbGaz+oSbPsJLR2ZL5j9wVTcnruchH44wIiLD
         1Qiz+1PhOSJrEmbygWnc8kGO81unPQ890hR1IAn/ZgT6CZ/uw2CEtzfwBRJ5PbatxfjM
         yWsEFBxmaF46Y8RvIRqwZsp68MnvQx+ULg/KiepRicG4rcFEWBQLKc9emgVWTzqlPXK0
         63RFMeVpQXq6Uc1rodaHQ/wYFBseh6f84MhV04ASD9p/n5lACLtJ3I38AoJ2LbIeR9/M
         AHRt5v5nT0WBeNVw44dg7VeqsZpZCOrwiB1DWm10m4EUoSa6BblxUJHdJIY0Lttqt68K
         HBHA==
X-Gm-Message-State: AJIora/zp8IsbpHQF8J2XaYqep2fGi0YVePi5dmDSXZUYSTp/yEf7I8e
        8UQG8m6SPXBX/WFIGxyHe/DsLA==
X-Google-Smtp-Source: AGRyM1sEvzGL5/pHJGu3PkBYNyFPoHxKkiLVS9lcfkbxzdtau15ZF+qrALM42AZPJvNsMP6u7Xw6UA==
X-Received: by 2002:a17:90b:3a8d:b0:1ef:7d4:6a5f with SMTP id om13-20020a17090b3a8d00b001ef07d46a5fmr39512462pjb.139.1657004442946;
        Tue, 05 Jul 2022 00:00:42 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id h23-20020a632117000000b0041245ccb6b1sm3117358pgh.62.2022.07.05.00.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:00:42 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 04/13] OPP: Make dev_pm_opp_set_opp() independent of frequency
Date:   Tue,  5 Jul 2022 12:30:07 +0530
Message-Id: <89976ad1c64d0716d69bd834aa8b82d66d83ad85.1657003420.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657003420.git.viresh.kumar@linaro.org>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_pm_opp_set_opp() can be called for any device, it may or may not
have a frequency value associated with it.

If a frequency value isn't available, we pass 0 to _set_opp(). Make it
optional instead by making _set_opp() accept a pointer instead, as the
frequency value is anyway available in the OPP. This makes
dev_pm_opp_set_opp() and _set_opp() completely independent of any
special key value.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 52 +++++++++++++++++++++++++++++++++-------------
 drivers/opp/opp.h  |  4 ++--
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 00d5911b20f8..daabc810a1f9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -784,19 +784,33 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 	return ret;
 }
 
-static inline int _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
-					    unsigned long freq)
+static inline int _generic_set_opp_clk_only(struct device *dev,
+		struct opp_table *opp_table, struct dev_pm_opp *opp, void *data)
 {
+	unsigned long *target = data;
+	unsigned long freq;
 	int ret;
 
 	/* We may reach here for devices which don't change frequency */
-	if (IS_ERR(clk))
+	if (IS_ERR(opp_table->clk))
 		return 0;
 
-	ret = clk_set_rate(clk, freq);
+	/* One of target and opp must be available */
+	if (target) {
+		freq = *target;
+	} else if (opp) {
+		freq = opp->rate;
+	} else {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	ret = clk_set_rate(opp_table->clk, freq);
 	if (ret) {
 		dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
 			ret);
+	} else {
+		opp_table->rate_clk_single = freq;
 	}
 
 	return ret;
@@ -990,7 +1004,7 @@ static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
 }
 
 static int _set_opp(struct device *dev, struct opp_table *opp_table,
-		    struct dev_pm_opp *opp, unsigned long freq)
+		    struct dev_pm_opp *opp, void *clk_data, bool forced)
 {
 	struct dev_pm_opp *old_opp;
 	int scaling_down, ret;
@@ -1005,15 +1019,14 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	old_opp = opp_table->current_opp;
 
 	/* Return early if nothing to do */
-	if (old_opp == opp && opp_table->current_rate == freq &&
-	    opp_table->enabled) {
+	if (!forced && old_opp == opp && opp_table->enabled) {
 		dev_dbg(dev, "%s: OPPs are same, nothing to do\n", __func__);
 		return 0;
 	}
 
 	dev_dbg(dev, "%s: switching OPP: Freq %lu -> %lu Hz, Level %u -> %u, Bw %u -> %u\n",
-		__func__, opp_table->current_rate, freq, old_opp->level,
-		opp->level, old_opp->bandwidth ? old_opp->bandwidth[0].peak : 0,
+		__func__, old_opp->rate, opp->rate, old_opp->level, opp->level,
+		old_opp->bandwidth ? old_opp->bandwidth[0].peak : 0,
 		opp->bandwidth ? opp->bandwidth[0].peak : 0);
 
 	scaling_down = _opp_compare_key(old_opp, opp);
@@ -1046,7 +1059,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 		}
 	}
 
-	ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
+	ret = _generic_set_opp_clk_only(dev, opp_table, opp, clk_data);
 	if (ret)
 		return ret;
 
@@ -1082,7 +1095,6 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	/* Make sure current_opp doesn't get freed */
 	dev_pm_opp_get(opp);
 	opp_table->current_opp = opp;
-	opp_table->current_rate = freq;
 
 	return ret;
 }
@@ -1103,6 +1115,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	struct opp_table *opp_table;
 	unsigned long freq = 0, temp_freq;
 	struct dev_pm_opp *opp = NULL;
+	bool forced = false;
 	int ret;
 
 	opp_table = _find_opp_table(dev);
@@ -1120,7 +1133,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		 * equivalent to a clk_set_rate()
 		 */
 		if (!_get_opp_count(opp_table)) {
-			ret = _generic_set_opp_clk_only(dev, opp_table->clk, target_freq);
+			ret = _generic_set_opp_clk_only(dev, opp_table, NULL,
+							&target_freq);
 			goto put_opp_table;
 		}
 
@@ -1141,12 +1155,22 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 				__func__, freq, ret);
 			goto put_opp_table;
 		}
+
+		/*
+		 * An OPP entry specifies the highest frequency at which other
+		 * properties of the OPP entry apply. Even if the new OPP is
+		 * same as the old one, we may still reach here for a different
+		 * value of the frequency. In such a case, do not abort but
+		 * configure the hardware to the desired frequency forcefully.
+		 */
+		forced = opp_table->rate_clk_single != target_freq;
 	}
 
-	ret = _set_opp(dev, opp_table, opp, freq);
+	ret = _set_opp(dev, opp_table, opp, &target_freq, forced);
 
 	if (target_freq)
 		dev_pm_opp_put(opp);
+
 put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
 	return ret;
@@ -1174,7 +1198,7 @@ int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
 		return PTR_ERR(opp_table);
 	}
 
-	ret = _set_opp(dev, opp_table, opp, opp ? opp->rate : 0);
+	ret = _set_opp(dev, opp_table, opp, NULL, false);
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index e449828ffbf4..e481bdb59499 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -159,7 +159,7 @@ enum opp_table_access {
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @parsed_static_opps: Count of devices for which OPPs are initialized from DT.
  * @shared_opp: OPP is shared between multiple devices.
- * @current_rate: Currently configured frequency.
+ * @rate_clk_single: Currently configured frequency for single clk.
  * @current_opp: Currently configured OPP for the table.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
  * @genpd_virt_dev_lock: Mutex protecting the genpd virtual device pointers.
@@ -208,7 +208,7 @@ struct opp_table {
 
 	unsigned int parsed_static_opps;
 	enum opp_table_access shared_opp;
-	unsigned long current_rate;
+	unsigned long rate_clk_single;
 	struct dev_pm_opp *current_opp;
 	struct dev_pm_opp *suspend_opp;
 
-- 
2.31.1.272.g89b43f80a514

