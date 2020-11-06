Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F992A8F6F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 07:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgKFGZ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 01:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFGZ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 01:25:57 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E602BC0613CF
        for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2020 22:25:57 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id z1so189086plo.12
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2020 22:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rp9C+9S//3zvTfS0X7Z1GniUoDQOMUaHSWSzt/VmaaU=;
        b=jVFTp+Ni97ZaD18qQ1I8O6kPWPVW6/7r37muDjxnZmprOLFeyBAvqQfOQ8UFmmph0H
         sYh6JzvMY8cxkF+Pp1EibX0Mfty9cJouCKPcoASP21OL5sSQz0jfnRM6K+4kj3j6Mn48
         ziMmPmKwccYp8S7TRpHdWlVNTWwqahFJLHuUCZm/9o5hmDTkmdQ86YgcVEbcFgxVWHgk
         jrkizgdpCrkiU80ftQj7ybw48JsI1NUxwHuitsYfiogkYhdV3oUDraIyJaFu4mpJztF4
         q3mxniQMakmz5Or8lYvKjY6hQZPfUi6Sb8snWOblAiz6s2q0UeDGUO1NqLFkc2WOcpXs
         FDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rp9C+9S//3zvTfS0X7Z1GniUoDQOMUaHSWSzt/VmaaU=;
        b=sePLm5h7raznnkipolvtAHAcT7T8BKO+zOVxh5kROkuLVSAPCQjSBoo//upFP2O77/
         +ue9cxw34mXoFZkTQ89sZze9PbhidA+d4RFwKe9xWF8/PRjxLaBq29Ml4M2ureUBR7KA
         BRdOumH4qoY56NbZ/PuD98FzsmTGSh83Em1EZnUa1YLpovniCUVmrQfvj3I76V1BJwCV
         AuLz8RI7TaqDuKfz8IuqHP7yYKQ3JPW6S1NJyt4ndSarQW6He5eEpc4hCj1O1c9Jy25L
         c7aYCUCtFcFMI+JUaIl4xw9GJ3ot57ERbyA/Rz0dzUUWeTJTK114mKhbKZrQwk+5rbHI
         GW5A==
X-Gm-Message-State: AOAM530sUi40UrY8uwXwSNQ2KQRJwItj/b1OZgnlCyRlIkRHBoZMv+uG
        JLUTKiK1tA/8tx5aU5AJS6IMqw==
X-Google-Smtp-Source: ABdhPJzfbbyHt3QksSkQXWasKcVVVcVICowIcQXmjUCkZ5zzQg8QMbWob1Lpjl1xpPn0lXotlKRpmA==
X-Received: by 2002:a17:902:a50a:b029:d4:da2d:c9a1 with SMTP id s10-20020a170902a50ab02900d4da2dc9a1mr702017plq.6.1604643957435;
        Thu, 05 Nov 2020 22:25:57 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id y4sm790267pjc.53.2020.11.05.22.25.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 22:25:56 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, digetx@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] opp: Don't create an OPP table from dev_pm_opp_get_opp_table()
Date:   Fri,  6 Nov 2020 11:54:36 +0530
Message-Id: <1012a98950355bd5a52424668050a17c3430cbe0.1604643714.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <684ff01900180c0a40ec307dacc673b24eab593b.1604643714.git.viresh.kumar@linaro.org>
References: <684ff01900180c0a40ec307dacc673b24eab593b.1604643714.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It has been found that some users (like cpufreq-dt and others on LKML)
have abused the helper dev_pm_opp_get_opp_table() to create the OPP
table instead of just finding it, which is the wrong thing to do. This
routine was meant for OPP core's internal working and exposed the whole
functionality by mistake.

Change the scope of dev_pm_opp_get_opp_table() to only finding the
table. The internal helpers _opp_get_opp_table*() are thus renamed to
_add_opp_table*(), dev_pm_opp_get_opp_table_indexed() is removed (as we
don't need the index field for finding the OPP table) and so the only
user, genpd, is updated.

Note that the prototype of _add_opp_table() was already left in opp.h by
mistake when it was removed earlier and so we weren't required to add it
now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c |  2 +-
 drivers/opp/core.c          | 27 +++++++++++++--------------
 drivers/opp/of.c            |  4 ++--
 drivers/opp/opp.h           |  1 +
 include/linux/pm_opp.h      |  1 -
 5 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 743268996336..92b750b865d5 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2249,7 +2249,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 			 * Save table for faster processing while setting
 			 * performance state.
 			 */
-			genpd->opp_table = dev_pm_opp_get_opp_table_indexed(&genpd->dev, i);
+			genpd->opp_table = dev_pm_opp_get_opp_table(&genpd->dev);
 			WARN_ON(IS_ERR(genpd->opp_table));
 		}
 
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9915e8487f0b..b24f685823ae 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1138,7 +1138,7 @@ void _get_opp_table_kref(struct opp_table *opp_table)
  * uses the opp_tables_busy flag to indicate if another creator is in the middle
  * of adding an OPP table and others should wait for it to finish.
  */
-static struct opp_table *_opp_get_opp_table(struct device *dev, int index)
+struct opp_table *_add_opp_table_indexed(struct device *dev, int index)
 {
 	struct opp_table *opp_table;
 
@@ -1188,17 +1188,16 @@ static struct opp_table *_opp_get_opp_table(struct device *dev, int index)
 	return opp_table;
 }
 
-struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
+struct opp_table *_add_opp_table(struct device *dev)
 {
-	return _opp_get_opp_table(dev, 0);
+	return _add_opp_table_indexed(dev, 0);
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_table);
 
-struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev,
-						   int index)
+struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 {
-	return _opp_get_opp_table(dev, index);
+	return _find_opp_table(dev);
 }
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_table);
 
 static void _opp_table_kref_release(struct kref *kref)
 {
@@ -1627,7 +1626,7 @@ struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
 {
 	struct opp_table *opp_table;
 
-	opp_table = dev_pm_opp_get_opp_table(dev);
+	opp_table = _add_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -1686,7 +1685,7 @@ struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 {
 	struct opp_table *opp_table;
 
-	opp_table = dev_pm_opp_get_opp_table(dev);
+	opp_table = _add_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -1779,7 +1778,7 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	struct regulator *reg;
 	int ret, i;
 
-	opp_table = dev_pm_opp_get_opp_table(dev);
+	opp_table = _add_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -1887,7 +1886,7 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 	struct opp_table *opp_table;
 	int ret;
 
-	opp_table = dev_pm_opp_get_opp_table(dev);
+	opp_table = _add_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -1955,7 +1954,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 	if (!set_opp)
 		return ERR_PTR(-EINVAL);
 
-	opp_table = dev_pm_opp_get_opp_table(dev);
+	opp_table = _add_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -2039,7 +2038,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 	int index = 0, ret = -EINVAL;
 	const char **name = names;
 
-	opp_table = dev_pm_opp_get_opp_table(dev);
+	opp_table = _add_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -2204,7 +2203,7 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	struct opp_table *opp_table;
 	int ret;
 
-	opp_table = dev_pm_opp_get_opp_table(dev);
+	opp_table = _add_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 9faeb83e4b32..c718092757d9 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -974,7 +974,7 @@ int dev_pm_opp_of_add_table(struct device *dev)
 	struct opp_table *opp_table;
 	int ret;
 
-	opp_table = dev_pm_opp_get_opp_table_indexed(dev, 0);
+	opp_table = _add_opp_table_indexed(dev, 0);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
@@ -1029,7 +1029,7 @@ int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 			index = 0;
 	}
 
-	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
+	opp_table = _add_opp_table_indexed(dev, index);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index ebd930e0b3ca..4ced7ffa8158 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -224,6 +224,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *o
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
 struct opp_table *_add_opp_table(struct device *dev);
+struct opp_table *_add_opp_table_indexed(struct device *dev, int index);
 void _put_opp_list_kref(struct opp_table *opp_table);
 
 #ifdef CONFIG_OF
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index dbb484524f82..1435c054016a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -90,7 +90,6 @@ struct dev_pm_set_opp_data {
 #if defined(CONFIG_PM_OPP)
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
-struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev, int index);
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
-- 
2.25.0.rc1.19.g042ed3e048af

