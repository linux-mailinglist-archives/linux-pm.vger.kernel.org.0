Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7815E534E83
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 13:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbiEZLqR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 07:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347176AbiEZLqC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 07:46:02 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC857D413B
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:45:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q18so1209279pln.12
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2atvtJh3H0IuR3IXR4bSCu5QJSHWZSUpX9aSXdtS/nA=;
        b=fHiM6OHlp2/g+Elmqko00m99XbY3C0cuhalgZK9BfZx7dSjS9LWqA1LSi8FEmSzb1W
         C1F++qlXb4rMzg3/A68rs58ilbq1UPjC0rsgJ/XV0EugVMwY8rN6MjXx5mz94m4UYRcz
         LKab44yI+jfOk3vjt5yQ3gYXEHSqNVThGUaNWLxIdkPvO4lsWpHWYUM8Ca3mqICz/xCa
         1kU/sa1mzPr9wi3c+5/6kCmSvLpxw5onK0JHKyFrjES7Bj+a0XUp/bV0DKNQrKVrwJUj
         MeUpTxhO+VBQaExMMF2MXkF4976q7OeS95r4Zwpu3NagO8jNPnCxWg0fcPghm7mYnveG
         VJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2atvtJh3H0IuR3IXR4bSCu5QJSHWZSUpX9aSXdtS/nA=;
        b=EV015nxnHNzdAsS7v8umDaDOPtJQyCSTe/0XaIv+87tbPnTw6OZX2VFlnUBS1sqiuF
         7YI8Tx6ZdRaA7s9eXB7LqBwIBgjlgm//v62z3L+nnj16NST+qFuDJSIXN98HA1T1uGm7
         SwU9jgZatmalNALL7M8ary9OD4CjstL/X1rJ4KgkQvX22LqjUa+zwmbOJVyer1jx4Irn
         o2VsHya+wX+1l8wXo9INztjGzqSAU+7HGVaD/2jkLKIA/21N361n9q2AfVEYU0IwyIQO
         4dU4QYivm8+G0bSx858Gos6RQQImubjOkq1taGmBtK7z+/2tF/Z0aM5QXEc9xgOLLHrN
         tCqg==
X-Gm-Message-State: AOAM531ewVDNmSL4QSEBEUQMxq1Tf6T3vQydrSeuYrvl1CTMCghyXxc5
        CkNcvJQRAKwGpuhrizBUj+4QuQ==
X-Google-Smtp-Source: ABdhPJz8APqn6IxBdWepFUAUEnNd2ZtU9ziIofE+rnpefgxRaH3ne7Ws/UtzHTmA495wPdlWCuNiUQ==
X-Received: by 2002:a17:903:41cd:b0:163:5f72:1610 with SMTP id u13-20020a17090341cd00b001635f721610mr6982121ple.112.1653565504748;
        Thu, 26 May 2022 04:45:04 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id e14-20020a170903240e00b0015e8d4eb1fasm1319085plo.68.2022.05.26.04.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:45:04 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 31/31] OPP: Rearrange dev_pm_opp_set_config() and friends
Date:   Thu, 26 May 2022 17:12:30 +0530
Message-Id: <d56cbb49707a4b08635496cc3318592a96383710.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rearrange the helpers now to make them look clean.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 49 +++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e6c76b90dbf7..a9e39ebfe9da 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2370,8 +2370,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 struct opp_table *dev_pm_opp_set_config(struct device *dev,
 					struct dev_pm_opp_config *config)
 {
-	struct opp_table *opp_table, *ret;
-	int err;
+	struct opp_table *opp_table;
+	int ret;
 
 	opp_table = _add_opp_table(dev, false);
 	if (IS_ERR(opp_table))
@@ -2379,73 +2379,61 @@ struct opp_table *dev_pm_opp_set_config(struct device *dev,
 
 	/* This should be called before OPPs are initialized */
 	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
-		ret = ERR_PTR(-EBUSY);
+		ret = -EBUSY;
 		goto err;
 	}
 
 	// Configure clock
 	if (config->clk_name) {
-		err = _opp_set_clkname(opp_table, dev, config->clk_name);
-		if (err) {
-			ret = ERR_PTR(err);
+		ret = _opp_set_clkname(opp_table, dev, config->clk_name);
+		if (ret)
 			goto err;
-		}
 	}
 
 	// Configure property names
 	if (config->prop_name) {
-		err = _opp_set_prop_name(opp_table, config->prop_name);
-		if (err) {
-			ret = ERR_PTR(err);
+		ret = _opp_set_prop_name(opp_table, config->prop_name);
+		if (ret)
 			goto err;
-		}
 	}
 
 	// Configure opp helper
 	if (config->set_opp) {
-		err = _opp_register_set_opp_helper(opp_table, dev, config->set_opp);
-		if (err) {
-			ret = ERR_PTR(err);
+		ret = _opp_register_set_opp_helper(opp_table, dev, config->set_opp);
+		if (ret)
 			goto err;
-		}
 	}
 
 	// Configure supported hardware
 	if (config->supported_hw) {
-		err = _opp_set_supported_hw(opp_table, config->supported_hw,
+		ret = _opp_set_supported_hw(opp_table, config->supported_hw,
 					    config->supported_hw_count);
-		if (err) {
-			ret = ERR_PTR(err);
+		if (ret)
 			goto err;
-		}
 	}
 
 	// Configure supplies
 	if (config->regulator_names) {
-		err = _opp_set_regulators(opp_table, dev,
+		ret = _opp_set_regulators(opp_table, dev,
 					  config->regulator_names,
 					  config->regulator_count);
-		if (err) {
-			ret = ERR_PTR(err);
+		if (ret)
 			goto err;
-		}
 	}
 
 	// Attach genpds
 	if (config->genpd_names) {
-		err = _opp_attach_genpd(opp_table, dev, config->genpd_names,
+		ret = _opp_attach_genpd(opp_table, dev, config->genpd_names,
 					config->virt_devs);
-		if (err) {
-			ret = ERR_PTR(err);
+		if (ret)
 			goto err;
-		}
 	}
 
 	return opp_table;
 
 err:
 	dev_pm_opp_clear_config(opp_table);
-	return ret;
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_config);
 
@@ -2465,15 +2453,10 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_config);
 void dev_pm_opp_clear_config(struct opp_table *opp_table)
 {
 	_opp_detach_genpd(opp_table);
-
 	_opp_put_regulators(opp_table);
-
 	_opp_put_supported_hw(opp_table);
-
 	_opp_unregister_set_opp_helper(opp_table);
-
 	_opp_put_prop_name(opp_table);
-
 	_opp_put_clkname(opp_table);
 
 	dev_pm_opp_put_opp_table(opp_table);
-- 
2.31.1.272.g89b43f80a514

