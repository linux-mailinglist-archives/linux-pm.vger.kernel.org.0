Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D94C2F9714
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 02:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbhARA5J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 19:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbhARA5C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 19:57:02 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1006DC0613CF;
        Sun, 17 Jan 2021 16:55:41 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o19so21662780lfo.1;
        Sun, 17 Jan 2021 16:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sBN+qDoZ+2xkp7oR26gY6Zqd1Sn2t+N/0CHYfu4wuTs=;
        b=N0kolekTv77LULSo5h6UrdruKTf1gLmyDoikAjHTHvjvlGzKnBG70ARv3fuLhBY164
         2VEgD1/OEx/MBrvW9vhJ46zvVywamJBUQrGKbCXVa1obaxq8HsxMjLZri8mGU0EF/542
         VUwmJ0Vr9Ji1kpXYQhkZs8WzOM8aCsLB78OrlJxx7P8KxF5R4z+y/oBsn1fhDuX7qvhr
         1Ks13u1w3TzEZhUsnbXL6/YGAD7l4+okG5WAaHDSWkjHF+0cI8H8Z+Powu+5yv61WvJZ
         /F9bxBRuvFCrHRd3v3YorqJSZa6INnexi2Mu1WOPn4Rw9ppIrxJAdlhYxU6UuE3JJXNZ
         JFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBN+qDoZ+2xkp7oR26gY6Zqd1Sn2t+N/0CHYfu4wuTs=;
        b=HOU7/f1oNe8jXS4MlWdkrJYpdalyWN6BCw9hcUqE55f8pVtL3ZZjVTFMn6qrr5oipg
         7RKwUoW/TEIF2cXx2S6+uxGPMIHt9pTKcBXPZRayLBVSnEC+QlueCCd3dN47bSzJwDbe
         kpDAoclol2tsaSdMpZ2Buqs8spfTRFe6bgMndING2l8EytTLHpqZsw6RE4X05Su8JV9F
         DeX0iranEzAjmgdjajfylSzJ3K2TUW2jLSWM4zHh6/lFcBZbcqwjKrscF30plovRv7I4
         BJAqbTjj+0gxYtKOlHm3l/4u5D77TLxrI/rn3LUaySD8PeQqhjpksAVI8okJfEI9kEy/
         L+Dg==
X-Gm-Message-State: AOAM532M5n3Y+p5ir1ReXZ0XzTkhGD6bl9I1wRL7xvv+Y9KgIiSazRnu
        UkeDJcwH7FdGw/FFIbLCYH6XloWLyXE=
X-Google-Smtp-Source: ABdhPJwxl910tMjxSVp26/+RBgN0gD4sr24MoLEbRgE8/1QfcPtpCWGwLKnAJsKiMRA4dczyQbE+mw==
X-Received: by 2002:ac2:5201:: with SMTP id a1mr8388633lfl.515.1610931339627;
        Sun, 17 Jan 2021 16:55:39 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id m24sm1484553ljj.62.2021.01.17.16.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 16:55:39 -0800 (PST)
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
Subject: [PATCH v3 05/12] opp: Add dev_pm_opp_set_voltage()
Date:   Mon, 18 Jan 2021 03:55:17 +0300
Message-Id: <20210118005524.27787-6-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118005524.27787-1-digetx@gmail.com>
References: <20210118005524.27787-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add dev_pm_opp_set_voltage() which allows OPP table users to set voltage
in accordance to a given OPP. In particular this is needed for driving
voltage of a generic power domain which uses OPPs and doesn't have a
clock.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 55 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 +++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 99d18befc209..341484d58e6c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2731,3 +2731,58 @@ int dev_pm_opp_sync_regulators(struct device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
+
+/**
+ * dev_pm_opp_set_voltage() - Change voltage of regulators
+ * @dev:	device for which we do this operation
+ * @opp:	opp based on which the voltages are to be configured
+ *
+ * Change voltage of the OPP table regulators.
+ *
+ * Return: 0 on success or a negative error value.
+ */
+int dev_pm_opp_set_voltage(struct device *dev, struct dev_pm_opp *opp)
+{
+	struct opp_table *opp_table;
+	struct regulator *reg;
+	int ret = 0;
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
+	/* This function only supports single regulator per device */
+	if (WARN_ON(opp_table->regulator_count > 1)) {
+		dev_err(dev, "multiple regulators are not supported\n");
+		ret = -EINVAL;
+		goto put_table;
+	}
+
+	mutex_lock(&opp_table->lock);
+
+	reg = opp_table->regulators[0];
+	ret = _set_opp_voltage(dev, reg, opp->supplies);
+
+	if (!opp_table->enabled) {
+		ret = regulator_enable(reg);
+		if (ret < 0) {
+			dev_warn(dev, "Failed to enable regulator: %d", ret);
+			goto unlock;
+		}
+
+		opp_table->enabled = true;
+	}
+unlock:
+	mutex_unlock(&opp_table->lock);
+put_table:
+	/* Drop reference taken by _find_opp_table() */
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_voltage);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 1c3a09cc8dcd..f344be844bde 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -163,6 +163,7 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 void dev_pm_opp_remove_table(struct device *dev);
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_sync_regulators(struct device *dev);
+int dev_pm_opp_set_voltage(struct device *dev, struct dev_pm_opp *opp);
 #else
 static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 {
@@ -404,6 +405,11 @@ static inline int dev_pm_opp_sync_regulators(struct device *dev)
 	return -ENOTSUPP;
 }
 
+static inline int dev_pm_opp_set_voltage(struct device *dev, struct dev_pm_opp *opp)
+{
+	return -ENOTSUPP;
+}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
2.29.2

