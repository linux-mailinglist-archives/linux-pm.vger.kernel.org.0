Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EB0566338
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 08:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiGEGiA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 02:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiGEGh7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 02:37:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8C211149
        for <linux-pm@vger.kernel.org>; Mon,  4 Jul 2022 23:37:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 5so4326346plk.9
        for <linux-pm@vger.kernel.org>; Mon, 04 Jul 2022 23:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mgVrobRjRVVckOe4+13ub+Rh2vX8SJDm/0tKekQBc40=;
        b=b3lGdME5GHaIYu+2f81jtoPrZGLSIn/R2Rp23ERfIY/OsM6YR0qJLY1Wtvjn2Q2PZP
         ylN3AL7hjz++KNzVTk+pUmIt7h/WT1yMxxbD8zT2MK2sJcmKuM0RzSgBfSbSe2E5Nuj9
         8CkNOqHeh3s1FPKpHoCRrEz2vgxZDWDh33QlexqCqjz9I3BosBOvg3oA0/UiLzIMosDP
         hud3azSEAmzL+6BoUMM8gHYza9r8Ra7Ef0WPHUmi9sdoWaBu8FIfvbur5S4oh/TZ2mBN
         YOl09mxPYHqZavMUAM7thK5JAvmInxlKYsXyzP2rn38Ol9j7MnpvtQFmkgsfMLYGlmI5
         +T/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mgVrobRjRVVckOe4+13ub+Rh2vX8SJDm/0tKekQBc40=;
        b=BFA9m50+P7ch+FRhvbfVny7hBQtE3k3NJNQ3ZkdYYFZx6XVilmJH+KwmfHbe+X+w9F
         yAcPmP9ukk6NJuiBGECX8Dit038uueKnXFAbXJ5ixhzHuv4pZ7VWg252b/5+RO71GK8z
         SB0bavmpWPdCUeyguLtCQsqjROXv8865wuX5gk3AjSvpIIwI2CZ3RNjSqZaS6EmmB5yM
         fc7ypkb8rRMPt7KJdg1f4lraJmS/M18ZlJ/8G18NykMQktArpxj6KX0oW98ljnTcx9Zq
         GOn59gDbDd4ysbP/CAOJpNeTEPOzBhSGDU/+6oP5TWlGXoTG3d+0JhRw4bmCddG6M6bz
         7u2Q==
X-Gm-Message-State: AJIora8S8+Tzx6Pc52eaHW2KgLgtAkwI6C29UrKo/CAMC8O8Oqc65GwQ
        OK2HJw4Vk70bisGRWrkqBQnPrA==
X-Google-Smtp-Source: AGRyM1u8awKUnXFqpuo/32okx5J1EnxHusVCBX85KZo+aIV8d2QuurrG6XfMic89cMVtCZNyUq3qOQ==
X-Received: by 2002:a17:902:d4c3:b0:16a:7696:971a with SMTP id o3-20020a170902d4c300b0016a7696971amr38957197plg.142.1657003074925;
        Mon, 04 Jul 2022 23:37:54 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id c6-20020a63ef46000000b0040ca00cd318sm21368116pgk.40.2022.07.04.23.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 23:37:54 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/4] OPP: Use generic key finding helpers for level key
Date:   Tue,  5 Jul 2022 12:07:39 +0530
Message-Id: <ccdd4b7e7e6e66ee24299914a4b916c1cff9852a.1657002904.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657002904.git.viresh.kumar@linaro.org>
References: <cover.1657002904.git.viresh.kumar@linaro.org>
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

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 63 ++++++++--------------------------------------
 1 file changed, 10 insertions(+), 53 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c850b8691ee6..968fdbbc0693 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -433,6 +433,11 @@ static unsigned long _read_freq(struct dev_pm_opp *opp, int index)
 	return opp->rate;
 }
 
+static unsigned long _read_level(struct dev_pm_opp *opp, int index)
+{
+	return opp->level;
+}
+
 /* Generic comparison helpers */
 static bool _compare_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 			   unsigned long opp_key, unsigned long key)
@@ -656,33 +661,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					       unsigned int level)
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
 
@@ -704,33 +683,11 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_exact);
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
+	unsigned long temp = *level;
+	struct dev_pm_opp *opp;
 
+	opp = _find_key_ceil(dev, &temp, 0, true, _read_level);
+	*level = temp;
 	return opp;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
-- 
2.31.1.272.g89b43f80a514

