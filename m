Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2A12F96F0
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 01:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbhARA4f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 19:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbhARA4U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 19:56:20 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D98C0613C1;
        Sun, 17 Jan 2021 16:55:40 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o13so21663708lfr.3;
        Sun, 17 Jan 2021 16:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORGCA2NNYd6672ynomRyYjTRM+EXXCwELHNI7EanuCU=;
        b=pN9Mjcz0nokQWkTvVfz5+Lt8ICl1kGOENr5AdsNb5nYEy+cYI29WvO/meLDMeXjM/F
         Z/IvMq03D3bXqal8c246kwJ/I+Ut6Y4FNjBZ0Fq/4z+xOIhM/72sPt+kTtYmPR9+mP1v
         J/59PY0byw7OoPppfK35xDgCm/r6KOZ4QLAlrefk4dl8/Y3dJaAOT4z2A72zJsE63czq
         t4NzHv6tJlZaBr7m2HoGlLRwr4FLslBNvyBAmV6OHl8sooCnlMxd9KfOjkfoO+GpsOWY
         al79hbQGZD8QxjDPUB8y9ZTDT8H4+drv/yFf2RWnb/+UleSq4FIhZvuDRR1Hjoq+9i7G
         FiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORGCA2NNYd6672ynomRyYjTRM+EXXCwELHNI7EanuCU=;
        b=pS1B58/gHEZSt9e6oAJutX+nUDp0RT2QNkHSmQvW9WtB+tBkXwSAg5RyOSx429m5Pg
         LeVWdbdZBm/CjByOY5i7iKBz2cm8dHKs1WRuX8Hl39T6Vz6weYrgeEw49n4mSW+PLIbK
         Zea04ulfs+oZJ/9+FC1luDvcPEGidD+7WfeCumhGhgJndPHYXDBI7ZRwe0lk6FqmB99v
         2cIWSo8r9F+BOMMO2+7zr8L82WMh0C4uR47V2FHJAt8Bdejd12edwtBpR5BdED6KZQds
         dyha/WrAVx1Z/YAZNCjo6TU7wYvPgoMaAceYn8iSM643nxwkfCc/Armoe/avSv29AEOI
         yg3g==
X-Gm-Message-State: AOAM530iR18J2+KgJYNTg+lnaQgYFRS9WBOIx3vSLq/CmE793oxtjCfb
        OVp5IQPMfLjirVdXy8L/oYQ=
X-Google-Smtp-Source: ABdhPJxMSTh9dMUpjPVmeMl/WvlsAqwhhMIuN747VN0oDre3vhFgUw/zEZw8Jd31NCMx+KK/qnnQQQ==
X-Received: by 2002:ac2:5ec1:: with SMTP id d1mr9620671lfq.589.1610931338709;
        Sun, 17 Jan 2021 16:55:38 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id m24sm1484553ljj.62.2021.01.17.16.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 16:55:38 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 04/12] opp: Add dev_pm_opp_sync_regulators()
Date:   Mon, 18 Jan 2021 03:55:16 +0300
Message-Id: <20210118005524.27787-5-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118005524.27787-1-digetx@gmail.com>
References: <20210118005524.27787-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Extend OPP API with dev_pm_opp_sync_regulators() function, which syncs
voltage state of regulators.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 45 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 7b4d07279638..99d18befc209 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2686,3 +2686,48 @@ void dev_pm_opp_remove_table(struct device *dev)
 	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
+
+/**
+ * dev_pm_opp_sync_regulators() - Sync state of voltage regulators
+ * @dev:	device for which we do this operation
+ *
+ * Sync voltage state of the OPP table regulators.
+ *
+ * Return: 0 on success or a negative error value.
+ */
+int dev_pm_opp_sync_regulators(struct device *dev)
+{
+	struct opp_table *opp_table;
+	struct regulator *reg;
+	int i, ret = 0;
+
+	/* Device may not have OPP table */
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return 0;
+
+	/* Regulator may not be required for the device */
+	if (!opp_table->regulators)
+		goto put_table;
+
+	mutex_lock(&opp_table->lock);
+
+	/* Nothing to sync if voltage wasn't changed */
+	if (!opp_table->enabled)
+		goto unlock;
+
+	for (i = 0; i < opp_table->regulator_count; i++) {
+		reg = opp_table->regulators[i];
+		ret = regulator_sync_voltage(reg);
+		if (ret)
+			break;
+	}
+unlock:
+	mutex_unlock(&opp_table->lock);
+put_table:
+	/* Drop reference taken by _find_opp_table() */
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index c24bd34339d7..1c3a09cc8dcd 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -162,6 +162,7 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cp
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 void dev_pm_opp_remove_table(struct device *dev);
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
+int dev_pm_opp_sync_regulators(struct device *dev);
 #else
 static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 {
@@ -398,6 +399,11 @@ static inline void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask
 {
 }
 
+static inline int dev_pm_opp_sync_regulators(struct device *dev)
+{
+	return -ENOTSUPP;
+}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
2.29.2

