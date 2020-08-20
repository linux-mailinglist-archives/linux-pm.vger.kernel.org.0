Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8207724B0A0
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 09:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHTH46 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 03:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgHTH4y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 03:56:54 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5D7C061383
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 00:56:53 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y10so549287plr.11
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MKa/l++NJX3mb6HDqlPH9HCmk5UKEoj8jJyL9pAVlUc=;
        b=JOhKqnxXyMfppUBIxlmvtEQlY5wB7zlwWW93yYoleBojKtOVakJwUIYj1ZKu4hzmZb
         EKEtrRsslpuOJ6lZJaqD+bqa4AbhVNuOyzF8abrRSlnfiLB1UstLmeV0AgLrLqMr7frF
         jZ7/sXrCNYPogK/+ohFMy/NlW0bTZ6dNRT/FIFnee66X/ZhU1eWzEPe7CqQ21fxnvvIo
         lJWQ5fdhyFNVMMVIGukrmECNfz/6JlWWOepDnc0ODoCBVC7C7ZnSP3D81+RgzZM3r2Fa
         NCf25h2gHBexgANYvR4Vsdbt3TNddA4eotdZtqvTC+OO+NpvXmNWzvPp8l2vAs0WNGWd
         Uqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MKa/l++NJX3mb6HDqlPH9HCmk5UKEoj8jJyL9pAVlUc=;
        b=Bm8aotCCSV+7QoOur+ubTP9wPTJvTfzk/IQbydz/l63KR72PzNAlDjQT3nL2llSevZ
         didgwIT12XDw3KwKqhGPXymtBDKPmpEBdmuDjebo/mLxYX4sP01umfGx2GnEz2EL+BX7
         c0541aNGGAOOlauVmUWlG631mD4NOr7OTIxHs5RcoATCceS5QhPVC343z7sx7jyO1Su3
         5Li3CnL8LDF8cImQRggmEt7+0rawsOo+XX5D/DApQObskF+p0KfYbRwRMaCbsi3/wM/D
         6NgxGz+0nZ3y+xt5AkUaXXx9cUl872k0omF1rdwIy8Ci2bVKtVnkbAF92eRnGgvpS/XZ
         iNMw==
X-Gm-Message-State: AOAM532SB4eMJbn8XpiKwPs+HHVzIUYQDU10VYr8+PwJUGRRQCgAh4yM
        S+5EIYksqWhonQIZ9b0PUMH81g==
X-Google-Smtp-Source: ABdhPJzWB+4yLlGmmwE4dywCJsMU0wuwok6h4p35XzVgwJJe1xwVCWD/kbQ46Cz8LSqBcayxXRk5gw==
X-Received: by 2002:a17:902:868b:: with SMTP id g11mr1739808plo.9.1597910212779;
        Thu, 20 Aug 2020 00:56:52 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id m19sm1596343pgd.21.2020.08.20.00.56.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 00:56:52 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, sibis@codeaurora.org,
        sbhanu@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/4] opp: Remove _dev_pm_opp_find_and_remove_table() wrapper
Date:   Thu, 20 Aug 2020 13:26:34 +0530
Message-Id: <ac1b1206c290a677921b55a4e94e18b12264208e.1597909885.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1597909885.git.viresh.kumar@linaro.org>
References: <cover.1597909885.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove the unnecessary wrapper and merge
_dev_pm_opp_find_and_remove_table() with dev_pm_opp_remove_table().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 21 ++++++++-------------
 drivers/opp/cpu.c  |  2 +-
 drivers/opp/of.c   |  2 +-
 drivers/opp/opp.h  |  1 -
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4edd2c3d6d91..6978b9218c6e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2395,7 +2395,14 @@ int dev_pm_opp_unregister_notifier(struct device *dev,
 }
 EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
 
-void _dev_pm_opp_find_and_remove_table(struct device *dev)
+/**
+ * dev_pm_opp_remove_table() - Free all OPPs associated with the device
+ * @dev:	device pointer used to lookup OPP table.
+ *
+ * Free both OPPs created using static entries present in DT and the
+ * dynamically added entries.
+ */
+void dev_pm_opp_remove_table(struct device *dev)
 {
 	struct opp_table *opp_table;
 
@@ -2420,16 +2427,4 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev)
 	/* Drop reference taken while the OPP table was added */
 	dev_pm_opp_put_opp_table(opp_table);
 }
-
-/**
- * dev_pm_opp_remove_table() - Free all OPPs associated with the device
- * @dev:	device pointer used to lookup OPP table.
- *
- * Free both OPPs created using static entries present in DT and the
- * dynamically added entries.
- */
-void dev_pm_opp_remove_table(struct device *dev)
-{
-	_dev_pm_opp_find_and_remove_table(dev);
-}
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index b5055cc886ef..5004335cf0de 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -124,7 +124,7 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask,
 			continue;
 		}
 
-		_dev_pm_opp_find_and_remove_table(cpu_dev);
+		dev_pm_opp_remove_table(cpu_dev);
 	}
 }
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 0430290670ab..7d9d4455a59e 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -616,7 +616,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
  */
 void dev_pm_opp_of_remove_table(struct device *dev)
 {
-	_dev_pm_opp_find_and_remove_table(dev);
+	dev_pm_opp_remove_table(dev);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 0c3de3f6db5c..78e876ec803e 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -217,7 +217,6 @@ void _get_opp_table_kref(struct opp_table *opp_table);
 int _get_opp_count(struct opp_table *opp_table);
 struct opp_table *_find_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
-void _dev_pm_opp_find_and_remove_table(struct device *dev);
 struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
 int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
-- 
2.25.0.rc1.19.g042ed3e048af

