Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE97C565485
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jul 2022 14:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbiGDMKC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jul 2022 08:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbiGDMJ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2022 08:09:27 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E0612740
        for <linux-pm@vger.kernel.org>; Mon,  4 Jul 2022 05:08:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y18so400044plb.2
        for <linux-pm@vger.kernel.org>; Mon, 04 Jul 2022 05:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/rxGDvIN/4skEVodhcHfGZ0EFBLSAZBvRwIgIUIkzN8=;
        b=dajE6R5ZvcmdwhTwjyhmbfXqCxtCtUxYWDvgZrz5BZ2oJj18rtQ1NIG7zb4kobbnPt
         kbSXYg3CRG+iNiIzam6mU3onh8IwVocUjTdXyZwzHWA5ytxIvnvcy6GwBUiohq5awZwi
         ATqxJ/wv3LNzbDwa2USaubJ2FCnuE3qsOhKxIccwuRX3307VuDxz9zNZZoKMJtL+MArH
         F/cqOZ+7vTR2Z+GSIOk3N8NxFkt5ROb+NofQKPQpLvexIQygm3YL2oafKdZKfoHdQxTB
         30drebrwuOmkHWpKaXUyypffGLWsEV3NmG7Yri1fwqBY1wDhnuzc8bKFoy0RQYm95il0
         PkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/rxGDvIN/4skEVodhcHfGZ0EFBLSAZBvRwIgIUIkzN8=;
        b=EOUGh3qvSOXnm157y/ByfaZbAR/IhZwoSg2WVT7h4ZDHo5YeXtFpB0sQE1fuEDTR6g
         Kzwf+6C5BLuj9jtnbJ7IG5yoXtRkTmY6lhsoX8a9VDjlbNcrwHSOHJnJZdjWOvhiMqml
         iLvFKopyAwQYqw1rZvExeRpxVDxHq7ynCjsCrk3TUOS07M6neQ1JlZinme21b/SZeIS5
         XSKGpEFUnreqZgfU8AknO8+vRO6KAYBIcXZ5SKU+pMb39B2B9trRP6U4VQ2rainCHbh0
         07U/VJj9/J+lMjHkEMD1p06NQvQieag1N2Ue34M5Cifq30Heo6rJ6JqdLUKs34dZYlo2
         Wwpw==
X-Gm-Message-State: AJIora9/EdoDkK2umQ5RCo2M0TJOwPQHM/8JZwq9FZm+1J81sKa6QLkC
        IiPD/Vu1quXIuLbjBX1QAdSOZA==
X-Google-Smtp-Source: AGRyM1sKdDqykdrQ/uHLjZGUdN+DL5XGqX0jMh66dHcOscKth++9OzF8v4i5N3HR1wcwBqvWwdR7mQ==
X-Received: by 2002:a17:903:1250:b0:16b:9866:c2f0 with SMTP id u16-20020a170903125000b0016b9866c2f0mr33050412plh.68.1656936537087;
        Mon, 04 Jul 2022 05:08:57 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id y11-20020a170902d64b00b0016782c55790sm20963906plh.232.2022.07.04.05.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:56 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 16/20] OPP: Add support for config_regulators() helper
Date:   Mon,  4 Jul 2022 17:37:54 +0530
Message-Id: <c342cccd065a5959eb1784f5bade87e6796f11c0.1656935522.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656935522.git.viresh.kumar@linaro.org>
References: <cover.1656935522.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Extend the dev_pm_opp_set_config() interface to allow adding
config_regulators() helpers. This helper will be called to set the
voltages of the regulators from the regular path in _set_opp(), while we
are trying to change the OPP.

This will eventually replace the custom set_opp() helper.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 68 +++++++++++++++++++++++++++++++++++++++++-
 drivers/opp/opp.h      |  2 ++
 include/linux/pm_opp.h | 22 ++++++++++++++
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 1745e25c1eaf..12bae79564f1 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1185,6 +1185,17 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 			dev_err(dev, "Failed to set bw: %d\n", ret);
 			return ret;
 		}
+
+		if (opp_table->config_regulators) {
+			ret = opp_table->config_regulators(dev, old_opp, opp,
+							   opp_table->regulators,
+							   opp_table->regulator_count);
+			if (ret) {
+				dev_err(dev, "Failed to set regulator voltages: %d\n",
+					ret);
+				return ret;
+			}
+		}
 	}
 
 	if (opp_table->set_opp) {
@@ -1202,6 +1213,17 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 
 	/* Scaling down? Configure required OPPs after frequency */
 	if (scaling_down) {
+		if (opp_table->config_regulators) {
+			ret = opp_table->config_regulators(dev, old_opp, opp,
+							   opp_table->regulators,
+							   opp_table->regulator_count);
+			if (ret) {
+				dev_err(dev, "Failed to set regulator voltages: %d\n",
+					ret);
+				return ret;
+			}
+		}
+
 		ret = _set_opp_bw(opp_table, opp, dev);
 		if (ret) {
 			dev_err(dev, "Failed to set bw: %d\n", ret);
@@ -2268,6 +2290,38 @@ static void _opp_unregister_set_opp_helper(struct opp_table *opp_table)
 	}
 }
 
+/**
+ * _opp_set_config_regulators_helper() - Register custom set regulator helper.
+ * @dev: Device for which the helper is getting registered.
+ * @config_regulators: Custom set regulator helper.
+ *
+ * This is useful to support platforms with multiple regulators per device.
+ *
+ * This must be called before any OPPs are initialized for the device.
+ */
+static int _opp_set_config_regulators_helper(struct opp_table *opp_table,
+		struct device *dev, config_regulators_t config_regulators)
+{
+	/* Another CPU that shares the OPP table has set the helper ? */
+	if (!opp_table->config_regulators)
+		opp_table->config_regulators = config_regulators;
+
+	return 0;
+}
+
+/**
+ * _opp_put_config_regulators_helper() - Releases resources blocked for
+ *					 config_regulators helper.
+ * @opp_table: OPP table returned from _opp_set_config_regulators_helper().
+ *
+ * Release resources blocked for platform specific config_regulators helper.
+ */
+static void _opp_put_config_regulators_helper(struct opp_table *opp_table)
+{
+	if (opp_table->config_regulators)
+		opp_table->config_regulators = NULL;
+}
+
 static void _detach_genpd(struct opp_table *opp_table)
 {
 	int index;
@@ -2394,8 +2448,10 @@ static void _opp_clear_config(struct opp_config_data *data)
 		_opp_put_regulators(data->opp_table);
 	if (data->flags & OPP_CONFIG_SUPPORTED_HW)
 		_opp_put_supported_hw(data->opp_table);
-	if (data->flags & OPP_CONFIG_REGULATOR_HELPER)
+	if (data->flags & OPP_CONFIG_REGULATOR_HELPER) {
+		_opp_put_config_regulators_helper(data->opp_table);
 		_opp_unregister_set_opp_helper(data->opp_table);
+	}
 	if (data->flags & OPP_CONFIG_PROP_NAME)
 		_opp_put_prop_name(data->opp_table);
 	if (data->flags & OPP_CONFIG_CLK)
@@ -2476,6 +2532,16 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 		data->flags |= OPP_CONFIG_REGULATOR_HELPER;
 	}
 
+	/* Configure config_regulators helper */
+	if (config->config_regulators) {
+		ret = _opp_set_config_regulators_helper(opp_table, dev,
+						config->config_regulators);
+		if (ret)
+			goto err;
+
+		data->flags |= OPP_CONFIG_REGULATOR_HELPER;
+	}
+
 	/* Configure supported hardware */
 	if (config->supported_hw) {
 		ret = _opp_set_supported_hw(opp_table, config->supported_hw,
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index d652f0cc84f1..45fd40737159 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -172,6 +172,7 @@ enum opp_table_access {
  * @prop_name: A name to postfix to many DT properties, while parsing them.
  * @clk_configured: Clock name is configured by the platform.
  * @clk: Device's clock handle
+ * @config_regulators: Platform specific config_regulators() callback.
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators. Its value can be -1
  * (uninitialized), 0 (no opp-microvolt property) or > 0 (has opp-microvolt
@@ -224,6 +225,7 @@ struct opp_table {
 	const char *prop_name;
 	bool clk_configured;
 	struct clk *clk;
+	config_regulators_t config_regulators;
 	struct regulator **regulators;
 	int regulator_count;
 	struct icc_path **paths;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index f995ca1406e8..9f2f9a792a19 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -90,11 +90,16 @@ struct dev_pm_set_opp_data {
 	struct device *dev;
 };
 
+typedef int (*config_regulators_t)(struct device *dev,
+			struct dev_pm_opp *old_opp, struct dev_pm_opp *new_opp,
+			struct regulator **regulators, unsigned int count);
+
 /**
  * struct dev_pm_opp_config - Device OPP configuration values
  * @clk_names: Clk names, NULL terminated array, max 1 clock for now.
  * @prop_name: Name to postfix to properties.
  * @set_opp: Custom set OPP helper.
+ * @config_regulators: Custom set regulator helper.
  * @supported_hw: Array of hierarchy of versions to match.
  * @supported_hw_count: Number of elements in the array.
  * @regulator_names: Array of pointers to the names of the regulator, NULL terminated.
@@ -109,6 +114,7 @@ struct dev_pm_opp_config {
 	const char * const *clk_names;
 	const char *prop_name;
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
+	config_regulators_t config_regulators;
 	const unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char * const *regulator_names;
@@ -613,6 +619,22 @@ static inline void dev_pm_opp_unregister_set_opp_helper(int token)
 	dev_pm_opp_clear_config(token);
 }
 
+/* config-regulators helpers */
+static inline int dev_pm_opp_set_config_regulators(struct device *dev,
+						   config_regulators_t helper)
+{
+	struct dev_pm_opp_config config = {
+		.config_regulators = helper,
+	};
+
+	return dev_pm_opp_set_config(dev, &config);
+}
+
+static inline void dev_pm_opp_put_config_regulators(int token)
+{
+	dev_pm_opp_clear_config(token);
+}
+
 /* genpd helpers */
 static inline int dev_pm_opp_attach_genpd(struct device *dev,
 					  const char * const *names,
-- 
2.31.1.272.g89b43f80a514

