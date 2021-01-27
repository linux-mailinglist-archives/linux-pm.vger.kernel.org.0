Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9102D30567E
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 10:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhA0JI3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 04:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbhA0JG0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 04:06:26 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A90BC06178C
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 01:05:45 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id b21so1132422pgk.7
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 01:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OjpOd/Y/FK/H2NSbndAgqWfjTMnUxw5T0tdE3/+WPu0=;
        b=pYQE0IgwXy1Zs6ba72Xjz1to1eQPd8M7H8sIYE/kP/kcbVple/AFEQAxw4t0DjPerZ
         MkICrsPw8/tZZFc1dHkWLISMPvl7ev/U0M+KiIj1dzPAJjxF3O2V22CVkPxkgWc/ZZCO
         AnlWWwVBcYgiVepHvz3zeTgRYaq9jlk/eeijnV8/pK1LDYbh9GCfUSVIECqkYYobxdk9
         OYh8I16fo3dnvDxmd0qZh3QKvkVEIJiaPWQ+O+Menf/UNJ2I6RmwTkdywamI9HoaIhxh
         3DUl9zkBvePZRgCNEbjLX/y/26oYhyQatEo7vNo9yL4jiS5RiKeD24LBmuKoUSkX8P68
         o87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OjpOd/Y/FK/H2NSbndAgqWfjTMnUxw5T0tdE3/+WPu0=;
        b=HtXC72HF+55O4/QM6vgafl/LTho0pZSE6kc7GNo2hIqKGNbbpoAJJ4/AbFYkfxIzxM
         HdkpM2PnQyPYpeDSf8rD2nX0emuNoUqOWoVJgaUBh267USXFioyLZVgRmjyDCPQlSJfj
         NF4F9+vdrRq69pJWRjB41rwMxrAB79OwccY4VA8YMdRN5KnHNkd9+4EsO9EHtVy5H09N
         Pn31ogEzU2ahi19fUJynIhnpGoCGWGp9qXXdQujkKSxgT2FV1E+Ih5dzFnTZNplK/2OO
         4H9d2m+oKvEvbCBGgVVegteubY5XX8VRtuSup+nljf32yoEYMJpC6nBk/TT0LV1rwbIf
         8Jdg==
X-Gm-Message-State: AOAM531NPJnzGj/elxbZcMXdfZVvVtq0OB4wAcslEKzLBpYwD/NoufNi
        ZKCgkn3240hslc0OgE8BrJcLqwOQnYdAbA==
X-Google-Smtp-Source: ABdhPJyBrz5MB8GLOduf99kDZiBhdFOxOflGnaPCfPOkvrrjG4mAmVkOknkzlG1FAxLn5b8GWChFvg==
X-Received: by 2002:a63:c70c:: with SMTP id n12mr10338049pgg.347.1611738344665;
        Wed, 27 Jan 2021 01:05:44 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id i7sm1732164pfc.50.2021.01.27.01.05.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 01:05:44 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] opp: Add dev_pm_opp_of_add_table_noclk()
Date:   Wed, 27 Jan 2021 14:35:27 +0530
Message-Id: <26de96f200805b43634bcc2b4d9824b2e38b0f6b.1611738228.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <6c2160ff30a8f421563793020264cf9f533f293c.1611738228.git.viresh.kumar@linaro.org>
References: <6c2160ff30a8f421563793020264cf9f533f293c.1611738228.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A few drivers have device's clk but they don't want the OPP core to
handle that. Add a new helper for them, dev_pm_opp_of_add_table_noclk().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 28 +++++++++++++++++-----------
 drivers/opp/of.c       | 26 ++++++++++++++++++++++----
 drivers/opp/opp.h      |  2 +-
 include/linux/pm_opp.h |  6 ++++++
 4 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9f6cf93cef3e..31abf460cd69 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1129,7 +1129,8 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	return opp_dev;
 }
 
-static struct opp_table *_allocate_opp_table(struct device *dev, int index)
+static struct opp_table *_allocate_opp_table(struct device *dev, int index,
+					     bool getclk)
 {
 	struct opp_table *opp_table;
 	struct opp_device *opp_dev;
@@ -1158,14 +1159,18 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 
 	_of_init_opp_table(opp_table, dev, index);
 
-	/* Find clk for the device */
-	opp_table->clk = clk_get(dev, NULL);
-	if (IS_ERR(opp_table->clk)) {
-		ret = PTR_ERR(opp_table->clk);
-		if (ret == -EPROBE_DEFER)
-			goto remove_opp_dev;
+	if (getclk) {
+		/* Find clk for the device */
+		opp_table->clk = clk_get(dev, NULL);
+		if (IS_ERR(opp_table->clk)) {
+			ret = PTR_ERR(opp_table->clk);
+			if (ret == -EPROBE_DEFER)
+				goto remove_opp_dev;
 
-		dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
+			dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
+		}
+	} else {
+		opp_table->clk = ERR_PTR(-ENODEV);
 	}
 
 	/* Find interconnect path(s) for the device */
@@ -1214,7 +1219,8 @@ void _get_opp_table_kref(struct opp_table *opp_table)
  * uses the opp_tables_busy flag to indicate if another creator is in the middle
  * of adding an OPP table and others should wait for it to finish.
  */
-struct opp_table *_add_opp_table_indexed(struct device *dev, int index)
+struct opp_table *_add_opp_table_indexed(struct device *dev, int index,
+					 bool getclk)
 {
 	struct opp_table *opp_table;
 
@@ -1249,7 +1255,7 @@ struct opp_table *_add_opp_table_indexed(struct device *dev, int index)
 
 		mutex_lock(&opp_table_lock);
 	} else {
-		opp_table = _allocate_opp_table(dev, index);
+		opp_table = _allocate_opp_table(dev, index, getclk);
 
 		mutex_lock(&opp_table_lock);
 		if (!IS_ERR(opp_table))
@@ -1266,7 +1272,7 @@ struct opp_table *_add_opp_table_indexed(struct device *dev, int index)
 
 struct opp_table *_add_opp_table(struct device *dev)
 {
-	return _add_opp_table_indexed(dev, 0);
+	return _add_opp_table_indexed(dev, 0, true);
 }
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c6856dcf4c34..a905497c75f8 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -956,7 +956,7 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 	return ret;
 }
 
-static int _of_add_table_indexed(struct device *dev, int index)
+static int _of_add_table_indexed(struct device *dev, int index, bool getclk)
 {
 	struct opp_table *opp_table;
 	int ret, count;
@@ -972,7 +972,7 @@ static int _of_add_table_indexed(struct device *dev, int index)
 			index = 0;
 	}
 
-	opp_table = _add_opp_table_indexed(dev, index);
+	opp_table = _add_opp_table_indexed(dev, index, getclk);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
@@ -1010,7 +1010,7 @@ static int _of_add_table_indexed(struct device *dev, int index)
  */
 int dev_pm_opp_of_add_table(struct device *dev)
 {
-	return _of_add_table_indexed(dev, 0);
+	return _of_add_table_indexed(dev, 0, true);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
 
@@ -1026,10 +1026,28 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
  */
 int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 {
-	return _of_add_table_indexed(dev, index);
+	return _of_add_table_indexed(dev, index, true);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_indexed);
 
+/**
+ * dev_pm_opp_of_add_table_noclk() - Initialize indexed opp table from device
+ *		tree without getting clk for device.
+ * @dev:	device pointer used to lookup OPP table.
+ * @index:	Index number.
+ *
+ * Register the initial OPP table with the OPP library for given device only
+ * using the "operating-points-v2" property. Do not try to get the clk for the
+ * device.
+ *
+ * Return: Refer to dev_pm_opp_of_add_table() for return values.
+ */
+int dev_pm_opp_of_add_table_noclk(struct device *dev, int index)
+{
+	return _of_add_table_indexed(dev, index, false);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_noclk);
+
 /* CPU device specific helpers */
 
 /**
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 4ced7ffa8158..edbf05df8b82 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -224,7 +224,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *o
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
 struct opp_table *_add_opp_table(struct device *dev);
-struct opp_table *_add_opp_table_indexed(struct device *dev, int index);
+struct opp_table *_add_opp_table_indexed(struct device *dev, int index, bool getclk);
 void _put_opp_list_kref(struct opp_table *opp_table);
 
 #ifdef CONFIG_OF
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 979b208bc4a8..158158620dde 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -395,6 +395,7 @@ static inline int dev_pm_opp_sync_regulators(struct device *dev)
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
 int dev_pm_opp_of_add_table(struct device *dev);
 int dev_pm_opp_of_add_table_indexed(struct device *dev, int index);
+int dev_pm_opp_of_add_table_noclk(struct device *dev, int index);
 void dev_pm_opp_of_remove_table(struct device *dev);
 int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
@@ -419,6 +420,11 @@ static inline int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 	return -ENOTSUPP;
 }
 
+static inline int dev_pm_opp_of_add_table_noclk(struct device *dev, int index)
+{
+	return -ENOTSUPP;
+}
+
 static inline void dev_pm_opp_of_remove_table(struct device *dev)
 {
 }
-- 
2.25.0.rc1.19.g042ed3e048af

