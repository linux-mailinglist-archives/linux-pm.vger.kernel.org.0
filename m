Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D20306DFE
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 08:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhA1HBA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 02:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhA1HA7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 02:00:59 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CEBC061574
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 23:00:19 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id v19so3655147pgj.12
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 23:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/az9vJJKvmVOYVTxpGhyp9BVL4fKFn3/tkkqVwm4EE=;
        b=OYHLeJvJ79zb8hTo6KJmqeevrBj7uphPKvhzq5FcHZoQNm/yUs99TH8fvKXJuEQnhl
         xDIYpgf5EQAo8ikr34NJqRRwPygEFqtEgs68qy0dgtj8freOMSijibFKuxGOpmN3RXS6
         5yEV2EJOyeAAQq1nfKuJJTdWmePkgE7uUeBOJmi9hhueLVIAzjg5K9F0C2FzqOKL1Kgl
         MzjFfkV97PH8vrmCSN7e6FZvT8+iFx2nZrLJ5bqf1qYwflZrml+i1Zmm0hdku47VrGnl
         hKk412NM2vWcQLX846T6ZUjRoc2Kd2SGSfCrh858MstLf6JF+Oet9jzGWKJrDsQUSD5p
         r03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/az9vJJKvmVOYVTxpGhyp9BVL4fKFn3/tkkqVwm4EE=;
        b=YRAQdSxexFlDOOsviFbiiK9HkexCvX+fW3hOQrHn0h/cWZqJ8tAABuZ5YlRpN1ysng
         yknkl7ANy9nEomwzp8IrO9IUYP78jxBwGGLQYweijP3VkYRBurduPUAb5gEnC7eTNeOG
         F6KaSVlDKHDVTnMNF2bp1TsKSYWkAMBN8q37zulQrBo3gn54Ba/xIxn76Hun6Hap6Qey
         2NwfGcjYJgtYnDrVO0QwZ+iWXWC/RlYxdvoHbGlx7O3gfZpAgN3aNpjSjSRhrAsyXtAi
         5yy7UBxBF5K3YOD423xbDOZy2lJ4AkvMisXwWBiY5xAwTK1ou6lTpjA6maD2PYJ3Nr1W
         Rpbw==
X-Gm-Message-State: AOAM533KpTFbJJU3EDwDcHwgS8TZmva/yO644UcC+NHuo8ArNm6hMbHC
        j7HBKMsSRresP/v2kQiXwNaYUA==
X-Google-Smtp-Source: ABdhPJzMiM3YJKRToSRR29s9MRrC70lmHwUZhVNvqWsBxW6GWCHIoDdZVSITYQ3L250EF9/LfVEGzQ==
X-Received: by 2002:a63:464a:: with SMTP id v10mr15401609pgk.393.1611817218478;
        Wed, 27 Jan 2021 23:00:18 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id s21sm3967791pjz.13.2021.01.27.23.00.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 23:00:17 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] opp: Create _of_add_table_indexed() to reduce code duplication
Date:   Thu, 28 Jan 2021 12:30:07 +0530
Message-Id: <1b58a72fa4d6aadc9542a66f8150150534752d81.1611817096.git.viresh.kumar@linaro.org>
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
V2:
- No change

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

