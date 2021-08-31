Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AC93FC900
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 15:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhHaN55 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 09:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhHaN5z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 09:57:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42245C0613D9;
        Tue, 31 Aug 2021 06:57:00 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bq28so38703419lfb.7;
        Tue, 31 Aug 2021 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kl0Y7hWnImbF0EBJlhQD+X5wimgI5lPFl9LYh/wR6RI=;
        b=jtMZgopVU3iUlt7/gbnIjj8Xg95dxw2fXMZuUFG/y18xFl0072FeWtOMsE0ErQV96A
         p7qbizqpKh4JIrCB5TsTOBmkgSA9Irn/CcLM8srykauJM/sNZ4RlymgQ15BKi4osg+oq
         0wLMUHs8z6zXPyaULDENsLRrMDQGD7LMcyPM4uJJCOeSjPxWS4GUfa6ItyXnBoKmzp8Q
         cWMi4UfaSdBT6Hb59DIV8VYjOhfc7gscgFG0BZGJpOsKW44VbGSdozz+cXAduMv3FK9h
         9Bg3ath8Bng8ya9GtvP0o1xr6+tiaziQVztV6KmD8SdbTo6PitryshmGXZpPrB3nvdRR
         iJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kl0Y7hWnImbF0EBJlhQD+X5wimgI5lPFl9LYh/wR6RI=;
        b=ayYqpGsno6z7LyA4pCdZknJlmoUn8eqH7lz4WmtxPRD0SH29bqMhE6vmjOrjdCOGLt
         zXpQsIClULYx1q4IwAAuftxY7R9CTYyQ8oGrHA4TFZ3Yk2h35DaK2dahlZf1grW5fprW
         KbgrFM86fVvnbaNfMNLzHrEJgOf4iW3NaPQhe+92bvINFmXiWOj9IGL/OaxPxtRU2x6W
         0SVXBUwQVczI0dyP/f5R8yHyEipXOB2zM2weI6cr7szRo1mUZ/WCpYba/owkrgERZz6/
         SZVKA3zCiHUeTY0eAIYkcxGTHBVgYknCL8r8qczhwkVBwesipMgXTDobdG1gJS84gGBj
         vdGg==
X-Gm-Message-State: AOAM5300+fWOi1zDb7hY3Lsn6BhF2Pu1zCUOvQTAiEB8Oy/l9pWthyqK
        Z1h5AkxvgNXVbARMYkTLTP4=
X-Google-Smtp-Source: ABdhPJwdicbVV/JUyy7fJmDZVKPtcggwkAXPQjWC9eGJOcSkCifYWZoDyK0Yrv9lOBxSQBg8lK/k2w==
X-Received: by 2002:a05:6512:ad3:: with SMTP id n19mr1674841lfu.297.1630418218675;
        Tue, 31 Aug 2021 06:56:58 -0700 (PDT)
Received: from localhost.localdomain (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.gmail.com with ESMTPSA id x4sm2203622ljm.98.2021.08.31.06.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:56:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v10 1/8] opp: Add dev_pm_opp_get_current()
Date:   Tue, 31 Aug 2021 16:54:43 +0300
Message-Id: <20210831135450.26070-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210831135450.26070-1-digetx@gmail.com>
References: <20210831135450.26070-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add dev_pm_opp_get_current() helper that returns OPP corresponding
to the current clock rate of a device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 43 +++++++++++++++++++++++++++++++++++++++---
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 04b4691a8aac..dde8a5cc948c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -939,7 +939,7 @@ static int _set_required_opps(struct device *dev,
 	return ret;
 }
 
-static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
+static struct dev_pm_opp *_find_current_opp(struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
 	unsigned long freq;
@@ -949,6 +949,18 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 		opp = _find_freq_ceil(opp_table, &freq);
 	}
 
+	return opp;
+}
+
+static void _find_and_set_current_opp(struct opp_table *opp_table)
+{
+	struct dev_pm_opp *opp;
+
+	if (opp_table->current_opp)
+		return;
+
+	opp = _find_current_opp(opp_table);
+
 	/*
 	 * Unable to find the current OPP ? Pick the first from the list since
 	 * it is in ascending order, otherwise rest of the code will need to
@@ -1002,8 +1014,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 		return _disable_opp_table(dev, opp_table);
 
 	/* Find the currently set OPP if we don't know already */
-	if (unlikely(!opp_table->current_opp))
-		_find_current_opp(dev, opp_table);
+	_find_and_set_current_opp(opp_table);
 
 	old_opp = opp_table->current_opp;
 
@@ -2931,3 +2942,29 @@ int dev_pm_opp_sync_regulators(struct device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
+
+/**
+ * dev_pm_opp_get_current() - Get current OPP
+ * @dev:	device for which we do this operation
+ *
+ * Get current OPP of a device based on current clock rate or by other means.
+ *
+ * Return: pointer to 'struct dev_pm_opp' on success and errorno otherwise.
+ */
+struct dev_pm_opp *dev_pm_opp_get_current(struct device *dev)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *opp;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return ERR_CAST(opp_table);
+
+	opp = _find_current_opp(opp_table);
+
+	/* Drop reference taken by _find_opp_table() */
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return opp;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_current);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 84150a22fd7c..c8091977efb8 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -168,6 +168,7 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 void dev_pm_opp_remove_table(struct device *dev);
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_sync_regulators(struct device *dev);
+struct dev_pm_opp *dev_pm_opp_get_current(struct device *dev);
 #else
 static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 {
@@ -434,6 +435,11 @@ static inline int dev_pm_opp_sync_regulators(struct device *dev)
 	return -EOPNOTSUPP;
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_get_current(struct device *dev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
2.32.0

