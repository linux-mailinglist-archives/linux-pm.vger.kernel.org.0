Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D34B2FDC9C
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 23:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbhATWbf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 17:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387562AbhATW1r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 17:27:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC26C0613CF;
        Wed, 20 Jan 2021 14:27:06 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 7so17324474wrz.0;
        Wed, 20 Jan 2021 14:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qAjqiq2dwbDskT9XOWElQP0slOUTW1tc29GpHVtC6mo=;
        b=mB5594KRNwJjZ8ATsswKkpqvGkCiHsAGRjjozSmbKq+q9aBNATyNc2yrt1FbVQewUi
         ahMzU4OateHBTd/MwjJBj3zcsvNlE0kSf7dNdCvSHAaJ7nn74Kh4fnUOV9C1IBqC2ZO+
         iMCmGyRJzasA4puZKAQtzZ3KEjgOvofWHrkzJYtZWQoUqUw/vgVmqMeK53EFX3iN+Bj2
         t0U3KoeZ2xQ9qg8koz7UFwnDvwy3yIb9ucCtRSG0fR06FZbTamoudTvB1C1lLZPyviXQ
         eAvjZPiD29QTBf80YhkGj4NauPFGjoNc9LKZevRfLwnnizkMNvg78BHleEe10ACiXy0B
         NfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAjqiq2dwbDskT9XOWElQP0slOUTW1tc29GpHVtC6mo=;
        b=nctAq7NXF2IEzSVlsH54I2xqIGT5ZnYBCuTuuBS0goBv9PCLCsoxUVhGgOZc1+Y4VH
         22pJ0myOPrBa9+Wr+sMyzQT8uW4wf2j05Cp8MYNVOUCYpEtl4WaK/PPyd8L5tdvOn8jb
         JP/3ThDDJ//I0zPxANR8EEvnVrrWlsz1lU7j95Vz6fGoYBEPbzt8+FlPdLxf1LILqHQU
         x9i+UZdxAXcPpJgd2MKBv1Q+UUf/MJw63HNEYowC84+txJpmGP92a2KEm4+cIAHnC/QA
         DwUcQo616iB4fr0t+8Rgu7ZYQzn/OIwTE94+ewUI6jUJRA8PJY5NY+xygEVllvMcKUHL
         7mRw==
X-Gm-Message-State: AOAM5306OLyNQu7dWIHOKAhhIFYFOne/kwhC3hkv5wle6eNQyxoSM+el
        wxrHG7CIB7B3OgaRxakpKgA=
X-Google-Smtp-Source: ABdhPJyvP5W6Ie4sqxA/nRGNlsEqLrqfipTD3XiTtnE/z+QGnkZeRSYoTmGxCyn8TXAtziifOignpQ==
X-Received: by 2002:a05:6000:1a8c:: with SMTP id f12mr243408wry.173.1611181625358;
        Wed, 20 Jan 2021 14:27:05 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id i131sm5663710wmi.25.2021.01.20.14.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 14:27:04 -0800 (PST)
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
Subject: [PATCH v4 3/4] opp: Add dev_pm_opp_set_voltage()
Date:   Thu, 21 Jan 2021 01:26:48 +0300
Message-Id: <20210120222649.28149-4-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120222649.28149-1-digetx@gmail.com>
References: <20210120222649.28149-1-digetx@gmail.com>
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
 drivers/opp/core.c     | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 +++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 43e62e0e3d5b..08d205a55c07 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2700,3 +2700,54 @@ int dev_pm_opp_sync_regulators(struct device *dev)
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
+	reg = opp_table->regulators[0];
+	ret = _set_opp_voltage(dev, reg, opp->supplies);
+
+	if (!opp_table->enabled) {
+		ret = regulator_enable(reg);
+		if (ret < 0) {
+			dev_warn(dev, "Failed to enable regulator: %d", ret);
+			goto put_table;
+		}
+
+		opp_table->enabled = true;
+	}
+put_table:
+	/* Drop reference taken by _find_opp_table() */
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_voltage);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 80cdb9af8268..d8f412dfc03a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -164,6 +164,7 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 void dev_pm_opp_remove_table(struct device *dev);
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_sync_regulators(struct device *dev);
+int dev_pm_opp_set_voltage(struct device *dev, struct dev_pm_opp *opp);
 #else
 static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 {
@@ -405,6 +406,11 @@ static inline int dev_pm_opp_sync_regulators(struct device *dev)
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

