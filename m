Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AE030567D
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 10:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhA0JI1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 04:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbhA0JGW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 04:06:22 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BB7C061788
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 01:05:41 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id lw17so2695991pjb.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 01:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHVpzPPwZR4A49rdw4CEuR8WNyenxazX6G1grb14wCE=;
        b=acywSujm9nQpsrNHfFh94SHb8cLDWeUZ7iPxSX88YEJMHegEonrRF/fENUeISIT852
         gS6Ll1nGjeAH4tGloIfue2DVm7+00yQ6OdYulQ8V/lTyFE+EIh8Xbb7gW1s87fdzgAjm
         7kbihIeuaYrI+CmOarHzcLt167rA2EhIXicaG2ed4e6SonAAckJqscwKxv5JruJRZfUv
         oddDrdLWx5HWAl33YgDB+q9hzX+kMNrl0nXAtAsEJeT4v22T6AZeMptjY0wLA3ZSzTdA
         Tzw8MzTKWzi2wOHn90d3PGwKVbO6pE/hr2etjoYHdT9jmiRf5DmzbRxeG5DHyu/q7wbb
         +ynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHVpzPPwZR4A49rdw4CEuR8WNyenxazX6G1grb14wCE=;
        b=IL2bMsqBBbulRAQ+VensF5ooD/31PAxgrYFJbS9Ah7oW+VqFOziBy+9RJYgydiB/T2
         WcVduAzdx3sfgiIM8/6AoLi7CEeX4uvx/gxwOWeE8iDtgXzqWZKycEqPb7+gkkSK/GXA
         TK3O7Dry4S8O/3JUiFLnsN5xW/FyOjYiGGn3jXFD9MbuPZ9WUBmDZ9xjo7fNWEy79hU8
         O+q8EE4gTjskJeRd9Whq51Am80TweQG/B5/tHhnNjPVVu1TH66Hx6DvERvozAC13Kc2e
         hvAbSnpamAhjNZYjNaAmz/JQGOm0SAyGPXda/9CQq678mSsetfeTHK7kfYFwRiAjRfH/
         Xm0A==
X-Gm-Message-State: AOAM533/jjo/KimPVn7vhADkFMeXEfkS8YTi8wm/IfgUxyVLXdS7/ern
        xN1mB5zf3qJwkELBLXePnSjDNw==
X-Google-Smtp-Source: ABdhPJwsda4i0K77ZCFdalC7XjaIELTE6eoyNhxuOROg/Fj4oh9k0hvNe8YOn3uydfEAeFq5DJq4vw==
X-Received: by 2002:a17:902:7102:b029:de:aa85:e04e with SMTP id a2-20020a1709027102b02900deaa85e04emr10259942pll.23.1611738341240;
        Wed, 27 Jan 2021 01:05:41 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id hs21sm1352257pjb.6.2021.01.27.01.05.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 01:05:40 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] opp: Create _of_add_table_indexed() to reduce code duplication
Date:   Wed, 27 Jan 2021 14:35:26 +0530
Message-Id: <6c2160ff30a8f421563793020264cf9f533f293c.1611738228.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The implementation of dev_pm_opp_of_add_table() and
dev_pm_opp_of_add_table_indexed() are almost identical. Create
_of_add_table_indexed() to reduce code redundancy.

Also remove the duplication of the doc style comments by referring to
dev_pm_opp_of_add_table() from dev_pm_opp_of_add_table_indexed().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 81 ++++++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 48 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index d0c0336be39b..c6856dcf4c34 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -956,29 +956,23 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 	return ret;
 }
 
-/**
- * dev_pm_opp_of_add_table() - Initialize opp table from device tree
- * @dev:	device pointer used to lookup OPP table.
- *
- * Register the initial OPP table with the OPP library for given device.
- *
- * Return:
- * 0		On success OR
- *		Duplicate OPPs (both freq and volt are same) and opp->available
- * -EEXIST	Freq are same and volt are different OR
- *		Duplicate OPPs (both freq and volt are same) and !opp->available
- * -ENOMEM	Memory allocation failure
- * -ENODEV	when 'operating-points' property is not found or is invalid data
- *		in device node.
- * -ENODATA	when empty 'operating-points' property is found
- * -EINVAL	when invalid entries are found in opp-v2 table
- */
-int dev_pm_opp_of_add_table(struct device *dev)
+static int _of_add_table_indexed(struct device *dev, int index)
 {
 	struct opp_table *opp_table;
-	int ret;
+	int ret, count;
 
-	opp_table = _add_opp_table_indexed(dev, 0);
+	if (index) {
+		/*
+		 * If only one phandle is present, then the same OPP table
+		 * applies for all index requests.
+		 */
+		count = of_count_phandle_with_args(dev->of_node,
+						   "operating-points-v2", NULL);
+		if (count == 1)
+			index = 0;
+	}
+
+	opp_table = _add_opp_table_indexed(dev, index);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
@@ -996,15 +990,12 @@ int dev_pm_opp_of_add_table(struct device *dev)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
 
 /**
- * dev_pm_opp_of_add_table_indexed() - Initialize indexed opp table from device tree
+ * dev_pm_opp_of_add_table() - Initialize opp table from device tree
  * @dev:	device pointer used to lookup OPP table.
- * @index:	Index number.
  *
- * Register the initial OPP table with the OPP library for given device only
- * using the "operating-points-v2" property.
+ * Register the initial OPP table with the OPP library for given device.
  *
  * Return:
  * 0		On success OR
@@ -1017,31 +1008,25 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
  * -ENODATA	when empty 'operating-points' property is found
  * -EINVAL	when invalid entries are found in opp-v2 table
  */
-int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
+int dev_pm_opp_of_add_table(struct device *dev)
 {
-	struct opp_table *opp_table;
-	int ret, count;
-
-	if (index) {
-		/*
-		 * If only one phandle is present, then the same OPP table
-		 * applies for all index requests.
-		 */
-		count = of_count_phandle_with_args(dev->of_node,
-						   "operating-points-v2", NULL);
-		if (count == 1)
-			index = 0;
-	}
-
-	opp_table = _add_opp_table_indexed(dev, index);
-	if (IS_ERR(opp_table))
-		return PTR_ERR(opp_table);
-
-	ret = _of_add_opp_table_v2(dev, opp_table);
-	if (ret)
-		dev_pm_opp_put_opp_table(opp_table);
+	return _of_add_table_indexed(dev, 0);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
 
-	return ret;
+/**
+ * dev_pm_opp_of_add_table_indexed() - Initialize indexed opp table from device tree
+ * @dev:	device pointer used to lookup OPP table.
+ * @index:	Index number.
+ *
+ * Register the initial OPP table with the OPP library for given device only
+ * using the "operating-points-v2" property.
+ *
+ * Return: Refer to dev_pm_opp_of_add_table() for return values.
+ */
+int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
+{
+	return _of_add_table_indexed(dev, index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_indexed);
 
-- 
2.25.0.rc1.19.g042ed3e048af

