Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103DD2FDCA6
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 23:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbhATWbu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 17:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387537AbhATW1p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 17:27:45 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1357FC0613C1;
        Wed, 20 Jan 2021 14:27:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m4so24558708wrx.9;
        Wed, 20 Jan 2021 14:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4sp7b1NkfUJTCMUO91JmNlpsU6mJZQVutgbbdE6RDGY=;
        b=aUke85VsKCiPdz0Alc+YVwiQ0D4OI3iN5Q/Ft5p4OGNth9UBoPyxKCjWVccoJDPdQD
         2xYsS/Ad1rMamkETdZCN7KobY1i6BY7N4PdnqimTfhKA5xdCKuZMMT7mAq+xWWO8etZx
         yoLyG4tpxW0gttL2py33fOhMJNJIJvb44mp3HSa8miGwftaFdn5v4cyG9G/e8InCzOWb
         MlL8C9t886/SfzTV92Y9oCLdIhVSyDVuDsxj9xRzpVnSojas25y0LQBY+TM6QoMmbqYD
         4+jGnIb/57fKBM/Zn4ogILKlQ6I2bgKCi80H8ldygDZsVQPiP1AuBSXfA+zObYKoi7D1
         4zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4sp7b1NkfUJTCMUO91JmNlpsU6mJZQVutgbbdE6RDGY=;
        b=VpCeW/U4NRW2qciTvQhluOySDezGOgqwtT9BpkEdNZ0iGW6SNWlcJXAmksfAvUMRFH
         eTRRFhlHnv8L/eMR1LypgybXuQ64eWC7ucz8FoPRzRUoItQs7CreK95UQI3A0MxJkYvB
         20R41Xb7jBjdh3HppUm5qabln2mcHuXr5q6aUsDUfbJM6etDX4kq8Y10SM1paGMIDo+l
         Ll2PtHLgdRS/i2wIlVjjia/dRadtW3fUBk5RIKgvv02IXjdexNg7ftZ/YyHcQm41xY3i
         NyYD4MhiTzN7ELtUEwtNqSBYxgRwoDy6MklCHTPOPmWRbhak1lOpw/a0goi5q2oH1exN
         vL7w==
X-Gm-Message-State: AOAM532+MSVbmAxPn1b4NYwUSh+dD8tnNz2IZ0iiKCAUg38wdcLBrlK/
        wIqzEYKFywwJVsnsPW/aAY2mO3ebUog=
X-Google-Smtp-Source: ABdhPJy8G4MQ/SRCrPj6NJeeBTZe5Zq2RrOu/W40d2elBko46pfsfliw+dQ5Aq24ftgBdjkzluMy8g==
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr4353685wrq.238.1611181623894;
        Wed, 20 Jan 2021 14:27:03 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id i131sm5663710wmi.25.2021.01.20.14.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 14:27:03 -0800 (PST)
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
Subject: [PATCH v4 2/4] opp: Add dev_pm_opp_sync_regulators()
Date:   Thu, 21 Jan 2021 01:26:47 +0300
Message-Id: <20210120222649.28149-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120222649.28149-1-digetx@gmail.com>
References: <20210120222649.28149-1-digetx@gmail.com>
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
 drivers/opp/core.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6049b17f99d6..43e62e0e3d5b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2659,3 +2659,44 @@ void dev_pm_opp_remove_table(struct device *dev)
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
+	/* Nothing to sync if voltage wasn't changed */
+	if (!opp_table->enabled)
+		goto put_table;
+
+	for (i = 0; i < opp_table->regulator_count; i++) {
+		reg = opp_table->regulators[i];
+		ret = regulator_sync_voltage(reg);
+		if (ret)
+			break;
+	}
+put_table:
+	/* Drop reference taken by _find_opp_table() */
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index f8e9a8e3eb59..80cdb9af8268 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -163,6 +163,7 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cp
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 void dev_pm_opp_remove_table(struct device *dev);
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
+int dev_pm_opp_sync_regulators(struct device *dev);
 #else
 static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 {
@@ -399,6 +400,11 @@ static inline void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask
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

