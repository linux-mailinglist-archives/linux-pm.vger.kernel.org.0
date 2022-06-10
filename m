Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B4B545ECC
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jun 2022 10:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347639AbiFJIYo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jun 2022 04:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347641AbiFJIYQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2022 04:24:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FAF3F4657
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 01:21:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so1476402pjt.4
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qu+YHy83Y6tmpvXALib3V7ikNYvZhhUbou41agwSzJY=;
        b=hAaG1te8hUjI0psrNR7K8hfEW9uhSKMW3cOyFinTGEJSgxqPz9AqHOXUQzmRnM2oHp
         2dBOjc0rIQnDIkC+bynzLs0drVQLrz++spZIteOP4EOfj+KyttOR2/adAzkBC9TlUi97
         WDrbT4EegTlUww461g1+caI39i6qmwbwb3XRVdZHnFAAeie0bS81825KDl6ljxLf6SbN
         xh5MpokaeGq0r9LFbRe0egtZESOERsIVORsZGihsCcuQ4qsIZxEIMVTTpSlJYcKAenHR
         jr5Zmxw9E2XrNRA9hHH0Ci/g/AtKxQqHaCWdv8FaAYGm1AVS9foDitVP1/x/VVPUUoI+
         mgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qu+YHy83Y6tmpvXALib3V7ikNYvZhhUbou41agwSzJY=;
        b=eNfTh1CVUjK/JwS0apnbeI+lVqI+N1k7XCBf40xFJ8dqJ5+uisyEI0MyGel6VzIIKC
         NBEP1loZ7l5EXvEqEC7ealyTAd4Rr9SoqcxkkUgOl+pXzERKLoHuMapPoUMB/qt9vSxU
         0uihqILuHURrMVmC+qOlGDsL+ku5BgFctGub4oYCwnZ0+Hd9YrkvKCEpTR1hW/vpHLzF
         ufPO4/aNS/O3GrWev6mh6/+RJYcc2dyBDwKgqXDnouvvWgUvn7VpoLQ8XfUnX6XKg1go
         Mcsjibm6SRaEh27YSUyrhfUzP4Sn8UWA5V4Y311E58J2oe9UxKyJWjEjwC5X/Fb02/Er
         sN1w==
X-Gm-Message-State: AOAM532eIvDwecdqMmEPwqWEh3FYsP+fUidan4OYR41aeARmJ7kczE6V
        wqfKt//e05YVtPY1XPRgeM81qw==
X-Google-Smtp-Source: ABdhPJzoW12NwKAawqpIckRDJg0AFfOjbC6Qfj0gkiTdVknPaIvLav11g12rXBp7TE7m2wZ5II9Epg==
X-Received: by 2002:a17:90b:3c0b:b0:1ea:769d:4ab2 with SMTP id pb11-20020a17090b3c0b00b001ea769d4ab2mr3570152pjb.196.1654849275588;
        Fri, 10 Jun 2022 01:21:15 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b0015e8d4eb208sm17947276pla.82.2022.06.10.01.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:21:15 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] OPP: Make dev_pm_opp_set_opp() independent of frequency
Date:   Fri, 10 Jun 2022 13:50:48 +0530
Message-Id: <d1afdc135885113c0ab0cc276787ef38323f074e.1654849214.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1654849214.git.viresh.kumar@linaro.org>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 52 +++++++++++++++++++++++++++++++++-------------
 drivers/opp/opp.h  |  4 ++--
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9f284dc0d9d7..6368ae2d7360 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -766,19 +766,33 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
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
@@ -972,7 +986,7 @@ static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
 }
 
 static int _set_opp(struct device *dev, struct opp_table *opp_table,
-		    struct dev_pm_opp *opp, unsigned long freq)
+		    struct dev_pm_opp *opp, void *clk_data, bool forced)
 {
 	struct dev_pm_opp *old_opp;
 	int scaling_down, ret;
@@ -987,15 +1001,14 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
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
@@ -1028,7 +1041,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 		}
 	}
 
-	ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
+	ret = _generic_set_opp_clk_only(dev, opp_table, opp, clk_data);
 	if (ret)
 		return ret;
 
@@ -1064,7 +1077,6 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	/* Make sure current_opp doesn't get freed */
 	dev_pm_opp_get(opp);
 	opp_table->current_opp = opp;
-	opp_table->current_rate = freq;
 
 	return ret;
 }
@@ -1085,6 +1097,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	struct opp_table *opp_table;
 	unsigned long freq = 0, temp_freq;
 	struct dev_pm_opp *opp = NULL;
+	bool forced = false;
 	int ret;
 
 	opp_table = _find_opp_table(dev);
@@ -1102,7 +1115,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		 * equivalent to a clk_set_rate()
 		 */
 		if (!_get_opp_count(opp_table)) {
-			ret = _generic_set_opp_clk_only(dev, opp_table->clk, target_freq);
+			ret = _generic_set_opp_clk_only(dev, opp_table, NULL,
+							&target_freq);
 			goto put_opp_table;
 		}
 
@@ -1123,12 +1137,22 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
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
@@ -1156,7 +1180,7 @@ int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
 		return PTR_ERR(opp_table);
 	}
 
-	ret = _set_opp(dev, opp_table, opp, opp ? opp->rate : 0);
+	ret = _set_opp(dev, opp_table, opp, NULL, false);
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 4d8894ef2975..131fc7c05db8 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -138,7 +138,7 @@ enum opp_table_access {
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @parsed_static_opps: Count of devices for which OPPs are initialized from DT.
  * @shared_opp: OPP is shared between multiple devices.
- * @current_rate: Currently configured frequency.
+ * @rate_clk_single: Currently configured frequency for single clk.
  * @current_opp: Currently configured OPP for the table.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
  * @genpd_virt_dev_lock: Mutex protecting the genpd virtual device pointers.
@@ -187,7 +187,7 @@ struct opp_table {
 
 	unsigned int parsed_static_opps;
 	enum opp_table_access shared_opp;
-	unsigned long current_rate;
+	unsigned long rate_clk_single;
 	struct dev_pm_opp *current_opp;
 	struct dev_pm_opp *suspend_opp;
 
-- 
2.31.1.272.g89b43f80a514

