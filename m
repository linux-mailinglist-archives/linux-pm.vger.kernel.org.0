Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2CB53C4CF
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jun 2022 08:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241390AbiFCGUp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jun 2022 02:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241428AbiFCGUn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2022 02:20:43 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89E637037
        for <linux-pm@vger.kernel.org>; Thu,  2 Jun 2022 23:20:40 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w21so6550521pfc.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2022 23:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gbNLNoNUtLpmvXGtkruf34xAYHi/j4E55WSdSx4bUmU=;
        b=JYxSDO1g1tQSMHpPKKPMY2RVHLSYsZM4Akn7PtJlzCFV7ZBIWYNnG/MH4qSb/Z962J
         p/Rlz7u3eTr0pn258InQjm1G49vXSF5ZtywFATcuk86gmi89yiVoEU0P8uYAC0iMeu0+
         83L3xO5tQG/YrMiPjMNtnJjIATeKT2bggZ4aj31Agl0IPbkNBzopWEGddpxO2kk9AKUt
         brS6x5cvldkh9cfyMeWy+LEmF682U99ZcZLq2VP5/VRTfTjGsqTVxkBYDiAqAlSHPX4+
         K/NahCHpDS62o7bQBnFqIBKNd6L4jrN+Vw7I9rGqy0ea7Q7Ki22JoEkiLKovFBdZfzVc
         DHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gbNLNoNUtLpmvXGtkruf34xAYHi/j4E55WSdSx4bUmU=;
        b=40vV6oBALvCjWs83uUyi6tO3H1fp/Wv++vzVQyxoCm6OnxcsOV2YcKkKqjcuqeYmV3
         8GClPapIT4ECHRlyC2UpB38aQaH9eiOev+jhb1FdyKcVp6Hs4rPDUeMlW2P9GUkmrNHS
         y0lUwGPeCi6CcKigfVk2NZ6z2sWEX7/7ybBivu43TMXZX91qb1MVOE8N5+EerHAAIZY9
         IMLY64teyJI/BZKG6wBmuH7KEvihUM7Gc8FswMwujr9Ixq/Qt0uKLeg2qCuWtnL0QcH8
         kcsJKp2/EkXNvpZGzQYsSTr20ayKxnxejs3bCPXerWSbjsb8PDsM9uVFShkNm37OqOq8
         TUfw==
X-Gm-Message-State: AOAM532PQNq7su8Ht7SxFTXk14FHkwLWJWLg5g0Q50tSQejWafN/WVVo
        vg6Hi1OJfjZ4NsN3KVpmF1exVA==
X-Google-Smtp-Source: ABdhPJztO9aPd48ZSjjD4aY9lShRgqdRU7Zs47AgfKXEdv0GxvFhUwP8Z+mcxJuzKx4yAUM+L2AMrA==
X-Received: by 2002:a63:305:0:b0:3fc:7f18:8d7 with SMTP id 5-20020a630305000000b003fc7f1808d7mr7469116pgd.186.1654237240030;
        Thu, 02 Jun 2022 23:20:40 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902710600b00163a6e1416dsm4575155pll.32.2022.06.02.23.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 23:20:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] OPP: Use generic key finding helpers for bandwidth key
Date:   Fri,  3 Jun 2022 11:50:19 +0530
Message-Id: <07c76851ac311d704522aef1d8712550ef1ac7ca.1654235445.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1654235445.git.viresh.kumar@linaro.org>
References: <cover.1654235445.git.viresh.kumar@linaro.org>
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

Use the recently added generic key findings helpers to find bandwidth
key values.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 78 +++-------------------------------------------
 1 file changed, 4 insertions(+), 74 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d8a91900d8a9..f17e19872769 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -697,43 +697,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
  * The callers are required to call dev_pm_opp_put() for the returned OPP after
  * use.
  */
-struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
-					   unsigned int *bw, int index)
+struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev, unsigned int *bw, int index)
 {
-	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
-
-	if (!dev || !bw) {
-		dev_err(dev, "%s: Invalid argument bw=%p\n", __func__, bw);
-		return ERR_PTR(-EINVAL);
-	}
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table))
-		return ERR_CAST(opp_table);
-
-	if (index >= opp_table->path_count)
-		return ERR_PTR(-EINVAL);
-
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available && temp_opp->bandwidth) {
-			if (temp_opp->bandwidth[index].peak >= *bw) {
-				opp = temp_opp;
-				*bw = opp->bandwidth[index].peak;
-
-				/* Increment the reference count of OPP */
-				dev_pm_opp_get(opp);
-				break;
-			}
-		}
-	}
-
-	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return opp;
+	return _find_key_ceil(dev, (unsigned long *)bw, index, true, _read_bw);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_bw_ceil);
 
@@ -756,45 +722,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_bw_ceil);
  * The callers are required to call dev_pm_opp_put() for the returned OPP after
  * use.
  */
-struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
-					    unsigned int *bw, int index)
+struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev, unsigned int *bw, int index)
 {
-	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
-
-	if (!dev || !bw) {
-		dev_err(dev, "%s: Invalid argument bw=%p\n", __func__, bw);
-		return ERR_PTR(-EINVAL);
-	}
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table))
-		return ERR_CAST(opp_table);
-
-	if (index >= opp_table->path_count)
-		return ERR_PTR(-EINVAL);
-
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available && temp_opp->bandwidth) {
-			/* go to the next node, before choosing prev */
-			if (temp_opp->bandwidth[index].peak > *bw)
-				break;
-			opp = temp_opp;
-		}
-	}
-
-	/* Increment the reference count of OPP */
-	if (!IS_ERR(opp))
-		dev_pm_opp_get(opp);
-	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
-
-	if (!IS_ERR(opp))
-		*bw = opp->bandwidth[index].peak;
-
-	return opp;
+	return _find_key_floor(dev, (unsigned long *)bw, index, true, _read_bw);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_bw_floor);
 
-- 
2.31.1.272.g89b43f80a514

