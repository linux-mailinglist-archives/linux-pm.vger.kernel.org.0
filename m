Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9335A53C4CE
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jun 2022 08:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241408AbiFCGUk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jun 2022 02:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241390AbiFCGUj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2022 02:20:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CAC31DF4
        for <linux-pm@vger.kernel.org>; Thu,  2 Jun 2022 23:20:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so11373098pju.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2022 23:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vGD8xeygMuouGJmhsw5Y0o7g11kgBD47l9iHV0atlE=;
        b=PAIEVagjF87QEZSuJ46V1NbanKyWVzHu2P+0TaPHRFAhFD/E10fEZcstdDjH5aHwc6
         kYXteNBdgV0t6hCyV9o1IWNvNeDQ2I3GL1ssgEnfy8XeQFNt0QwiEqFJ0dO06GqdsC0A
         WcavoNLbur3qNEUc1rlZ3GUBcu9xZiwLJoW4sXZpE7t28EUtZduSTYd8C8HZg/WNzrGj
         MiePq5i06UBmBWqxw8jqWEjn3bjsyIeA/1NmH+Xwk/g3CU63Hsw6oRpUFTW15Uh5XEDw
         twHqF6GuAhuZOkSWVKp+MdXXyhHJ0EvVV1cCFWnMO3BGHAcWLzSv5xGqJTDrYsNTrwet
         dijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vGD8xeygMuouGJmhsw5Y0o7g11kgBD47l9iHV0atlE=;
        b=IO8DpfAZ8o1H6RRyEp8HCN3cGAqs/MD1t/BVn6QJpao38AEGHGApS9bbgokcdZxJUL
         XfiLbEfipSovhuirVnb5qtNdsxrBp+UONlS648u9qHLPjLi50Sm5q06g7E4ncu3yiHGk
         iwFn0aWzG4UBTwjR7DDsbdOv4omc5tHdZnBr+ITqgMQEBPHqCIvEFuwcIXyxnDZQlxB4
         pIjqH7JjYEtt6G6X1MsDe+PXlxIzwaWbfYT74WHgDKmeBC4GoBccgP1E0+zz59mOVb0L
         x5eYRQYA3FEs/0F256yMa6EZPm7VnivkIuP6q9F09GMnXwgIpUF1LsNvpNGH5w9q3k2+
         XjNw==
X-Gm-Message-State: AOAM530reK/aQsTWJ51Ini0Q+9+yMezK6O8SkqEopAWBlf8WGS8dl32D
        s4qbtf0alMYcVtUoGKb/BiwitQ==
X-Google-Smtp-Source: ABdhPJx3v0WTCiUSqEVf4ES8VFLb1f6/DrsOqENUN5DKirn9hteNSryYlnTTzGPxvH8DKzLFQxTAiw==
X-Received: by 2002:a17:902:cf06:b0:163:62cb:250e with SMTP id i6-20020a170902cf0600b0016362cb250emr8720003plg.171.1654237237301;
        Thu, 02 Jun 2022 23:20:37 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id fh6-20020a17090b034600b001cd4989fec6sm6837272pjb.18.2022.06.02.23.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 23:20:36 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] OPP: Use generic key finding helpers for level key
Date:   Fri,  3 Jun 2022 11:50:18 +0530
Message-Id: <af798b8c4b87d5eb360d6184906fa6b7490768d8.1654235445.git.viresh.kumar@linaro.org>
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

Use the recently added generic key findings helpers to find level key
values.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 60 +++-------------------------------------------
 1 file changed, 3 insertions(+), 57 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2e6cb2abf0b9..d8a91900d8a9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -650,36 +650,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
  * The callers are required to call dev_pm_opp_put() for the returned OPP after
  * use.
  */
-struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
-					       unsigned int level)
+struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev, unsigned int level)
 {
-	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		int r = PTR_ERR(opp_table);
-
-		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
-		return ERR_PTR(r);
-	}
-
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->level == level) {
-			opp = temp_opp;
-
-			/* Increment the reference count of OPP */
-			dev_pm_opp_get(opp);
-			break;
-		}
-	}
-
-	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return opp;
+	return _find_key_exact(dev, level, 0, true, _read_level);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_exact);
 
@@ -701,34 +674,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_exact);
 struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 					      unsigned int *level)
 {
-	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		int r = PTR_ERR(opp_table);
-
-		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
-		return ERR_PTR(r);
-	}
-
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available && temp_opp->level >= *level) {
-			opp = temp_opp;
-			*level = opp->level;
-
-			/* Increment the reference count of OPP */
-			dev_pm_opp_get(opp);
-			break;
-		}
-	}
-
-	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return opp;
+	return _find_key_ceil(dev, (unsigned long *)level, 0, true, _read_level);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
 
-- 
2.31.1.272.g89b43f80a514

