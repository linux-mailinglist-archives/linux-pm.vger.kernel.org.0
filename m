Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E152F9723
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 02:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbhARBF0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 20:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbhARA5E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 19:57:04 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE51CC0613ED;
        Sun, 17 Jan 2021 16:55:43 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o13so21663816lfr.3;
        Sun, 17 Jan 2021 16:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vgDoSUPRoPUFpDdr936+57Rv3VyE6xZwg/R405Zj7FM=;
        b=Q9Xr1KYDDf/wQO0QAAoJdCsR2X3CU7X12Zn+9x7ok8bjlryXvSfBcnYhXSGFpEjT/B
         nDqZ6GJkMxI8xISHL/hgL9NIDd+mI7Lv+cPCvTPFQwPfOcZsmDKiPAk0njQJyGJTqSA8
         MlsZtl7ST3Wj/kG9MNcptgsppWrwLTRsEEZsmApI0JimIQoGoOrI/KL3spNwUAdVyMTn
         1OqS/98Hg8uVZIKW0nuwpSQh7rly8krNrgY4RjNORxzmsQFgEfMZGMlESAUqBRB0XpW7
         UshUuvEtwfV7valYKFBhg18jtXBcOkMIu99RrZWqHhCxlpXHGv+d/h3LYmYgt6RUndGj
         U5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vgDoSUPRoPUFpDdr936+57Rv3VyE6xZwg/R405Zj7FM=;
        b=HUBqg7V+b8IqLvuwJC633ZsV/ID6nRUwxevu/CDaymfM2O94+sKNdwMclIljClnoHY
         hR6g+qQCdBQ56AuftQAhn+yRtvy9EU4Nuu7aMpqKYYa5oeZ3EvLuY3eA6K0UDbzp6cvI
         G/Qunpfm8tpDNaXXb1OYzJt9iWEewgLw2aiAkAdxpbIj3vz8XeD0nK54b+zUwhmnnWMq
         ueKXvXH0ZoCe5xojpXgbbDPVzq6Hh2zbJDCtYB9FyK7hjUXRKl8bKnZz3qMpDVOuIMJC
         I8jB3RUzIGZZfjK83NG7pDwnHaQLeN7qUn286W4jvEWy5NSo9UrAsp6Yq9ANcKRiBUHH
         cywg==
X-Gm-Message-State: AOAM531iBOTfLZdWYzFBuNKbR3+6+8F7bcBRzbJwyC00k3ByUxPLEIF9
        KeV/KM9alwNh9A9zs3Rub3s=
X-Google-Smtp-Source: ABdhPJyVyFQhDEzOgofsjcTMdMzB3JK/5khRhA4EtPdSZyVBvc2EQbXNf/IfFQoYpIg2bvHagCpgag==
X-Received: by 2002:a19:6459:: with SMTP id b25mr9607365lfj.635.1610931342481;
        Sun, 17 Jan 2021 16:55:42 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id m24sm1484553ljj.62.2021.01.17.16.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 16:55:42 -0800 (PST)
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
Subject: [PATCH v3 08/12] opp: Add devm_pm_opp_register_set_opp_helper
Date:   Mon, 18 Jan 2021 03:55:20 +0300
Message-Id: <20210118005524.27787-9-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118005524.27787-1-digetx@gmail.com>
References: <20210118005524.27787-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add resource-managed version of dev_pm_opp_register_set_opp_helper().

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 34 ++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  8 ++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index fde2ec00ab0e..8e0d2193fd5f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2857,3 +2857,37 @@ int dev_pm_opp_set_voltage(struct device *dev, struct dev_pm_opp *opp)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_voltage);
+
+static void devm_pm_opp_unregister_set_opp_helper(void *data)
+{
+	dev_pm_opp_unregister_set_opp_helper(data);
+}
+
+/**
+ * devm_pm_opp_register_set_opp_helper() - Register custom set OPP helper
+ * @dev: Device for which the helper is getting registered.
+ * @set_opp: Custom set OPP helper.
+ *
+ * This is a resource-managed version of dev_pm_opp_register_set_opp_helper().
+ *
+ * Return: pointer to 'struct opp_table' on success and errorno otherwise.
+ */
+struct opp_table *
+devm_pm_opp_register_set_opp_helper(struct device *dev,
+				    int (*set_opp)(struct dev_pm_set_opp_data *data))
+{
+	struct opp_table *opp_table;
+	int err;
+
+	opp_table = dev_pm_opp_register_set_opp_helper(dev, set_opp);
+	if (IS_ERR(opp_table))
+		return opp_table;
+
+	err = devm_add_action_or_reset(dev, devm_pm_opp_unregister_set_opp_helper,
+				       opp_table);
+	if (err)
+		return ERR_PTR(err);
+
+	return opp_table;
+}
+EXPORT_SYMBOL_GPL(devm_pm_opp_register_set_opp_helper);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index e072148ae0e1..6de5853aaada 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -169,6 +169,7 @@ void dev_pm_opp_remove_table(struct device *dev);
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_sync_regulators(struct device *dev);
 int dev_pm_opp_set_voltage(struct device *dev, struct dev_pm_opp *opp);
+struct opp_table *devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 #else
 static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 {
@@ -428,6 +429,13 @@ static inline int dev_pm_opp_set_voltage(struct device *dev, struct dev_pm_opp *
 	return -ENOTSUPP;
 }
 
+static inline struct opp_table *
+devm_pm_opp_register_set_opp_helper(struct device *dev,
+				    int (*set_opp)(struct dev_pm_set_opp_data *data))
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
2.29.2

