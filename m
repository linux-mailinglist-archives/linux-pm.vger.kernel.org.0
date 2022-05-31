Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE3538E88
	for <lists+linux-pm@lfdr.de>; Tue, 31 May 2022 12:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245529AbiEaKK1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 May 2022 06:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245520AbiEaKKV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2022 06:10:21 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AA4996B1
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2022 03:10:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y189so12750967pfy.10
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2022 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=coONZgGzVl+ts87B3n9/T4bQl890pWmuXnplgV/C9Qg=;
        b=Qa7hl/jpCBUOw+kvcg30HuQhWAvp/zpkTKCuIfskarK5euPwihSjNOzWf7CUYn2IdY
         rbc+MXsZfPguvuAqzrjjCEYrnwsguKIv7EyMruUjtkyhQShfM4XMQHt0nGyf1utKruqZ
         ObQnT3hw1xetdBZfuY1C7nVpN6vaUaKnrZdnU3J1VQ2zaphGuqvjMxn3YcVcGGtJylbv
         Fc5cymUqI1pOCcY9IfiOvNsSN+ucRtxqOcCV3ynkkdCJ0lwo4CKHfpybyfvlKepjaqK2
         P3SlPLG8mv4pA8DU3htg91lg3E1o80C7VkX/eeHgQrByz0fSUkECg0cDrf6FVt/fdSG8
         c7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=coONZgGzVl+ts87B3n9/T4bQl890pWmuXnplgV/C9Qg=;
        b=Pod9fUOXurd/iOsJR5edTzqKf2JRGYANABk/Z704Nc9c4/nX9N3KJHR5tHpFR06D3E
         vu+ybWAv7dBisOWVNdZD+0qfWVitdK4X4zvEiQJmR6Om2CTQz1ATBq1/RyKTrsmAfJR/
         tBQuULkfSuFt1XAWeuJUTtBYpyMFra76/rxewtKJi+0AZ6/Wy9bG//7jlmC4rzKiqGOE
         0JXKJ23nURS/nKDPe+dtQHPIqf8evde02GsbVXUppXfeup85Ib7GctoenTXbf08ZxMLv
         ii++GStQBQ4depRORw1zbwWHmlX3s3+sX7dsHdCnUEK0bGP+GLrVC6LsP7Mf1flHnwFs
         DFdg==
X-Gm-Message-State: AOAM532zP8dC8cL24ab+2NIQ/QJ6FLO6NSu52LxzfKagZB8wh2VBPP21
        rFDOyV2plpLYQsfw7WQiEiI9Zw==
X-Google-Smtp-Source: ABdhPJyBkBo9gqfY3r46DA7I2O+W5n1W3xh3U7PbVLcmjOmAEVH68r2SqZtJjTU+hxUdFInwHElEUA==
X-Received: by 2002:a65:5886:0:b0:3fb:a6ea:b741 with SMTP id d6-20020a655886000000b003fba6eab741mr17416708pgu.502.1653991819634;
        Tue, 31 May 2022 03:10:19 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7874d000000b0050dc762816fsm10267850pfo.73.2022.05.31.03.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:10:19 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Keerthy <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] OPP: Add support for config_regulators() helper
Date:   Tue, 31 May 2022 15:40:00 +0530
Message-Id: <17e3f49303a738605b0b6e2b835578c55f3fe82c.1653991004.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653991004.git.viresh.kumar@linaro.org>
References: <cover.1653991004.git.viresh.kumar@linaro.org>
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

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 63 ++++++++++++++++++++++++++++++++++++++++++
 drivers/opp/opp.h      |  2 ++
 include/linux/pm_opp.h |  5 ++++
 3 files changed, 70 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 62c5d4308e01..bac91d078cbb 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1181,6 +1181,15 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 			dev_err(dev, "Failed to set bw: %d\n", ret);
 			return ret;
 		}
+
+		if (opp_table->config_regulators) {
+			ret = opp_table->config_regulators(dev, old_opp, opp, opp_table->regulators,
+							   opp_table->regulator_count);
+			if (ret) {
+				dev_err(dev, "Failed to set regulator voltages: %d\n", ret);
+				return ret;
+			}
+		}
 	}
 
 	if (opp_table->set_opp) {
@@ -1198,6 +1207,15 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 
 	/* Scaling down? Configure required OPPs after frequency */
 	if (scaling_down) {
+		if (opp_table->config_regulators) {
+			ret = opp_table->config_regulators(dev, old_opp, opp, opp_table->regulators,
+							   opp_table->regulator_count);
+			if (ret) {
+				dev_err(dev, "Failed to set regulator voltages: %d\n", ret);
+				return ret;
+			}
+		}
+
 		ret = _set_opp_bw(opp_table, opp, dev);
 		if (ret) {
 			dev_err(dev, "Failed to set bw: %d\n", ret);
@@ -2237,6 +2255,43 @@ static void _opp_unregister_set_opp_helper(struct opp_table *opp_table)
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
+static int _opp_set_config_regulators_helper(struct opp_table *opp_table, struct device *dev,
+					     config_regulators_t config_regulators)
+{
+	/* Another CPU that shares the OPP table has set the helper ? */
+	if (!opp_table->config_regulators) {
+		mutex_lock(&opp_table->lock);
+		opp_table->config_regulators = config_regulators;
+		mutex_unlock(&opp_table->lock);
+	}
+
+	return 0;
+}
+
+/**
+ * _opp_put_config_regulators_helper() - Releases resources blocked for config_regulators helper.
+ * @opp_table: OPP table returned from _opp_set_config_regulators_helper().
+ *
+ * Release resources blocked for platform specific config_regulators helper.
+ */
+static void _opp_put_config_regulators_helper(struct opp_table *opp_table)
+{
+	if (opp_table->config_regulators) {
+		mutex_lock(&opp_table->lock);
+		opp_table->config_regulators = NULL;
+		mutex_unlock(&opp_table->lock);
+	}
+}
+
 static void _detach_genpd(struct opp_table *opp_table)
 {
 	int index;
@@ -2404,6 +2459,13 @@ struct opp_table *dev_pm_opp_set_config(struct device *dev,
 			goto err;
 	}
 
+	/* Configure config_regulators helper */
+	if (config->config_regulators) {
+		ret = _opp_set_config_regulators_helper(opp_table, dev, config->config_regulators);
+		if (ret)
+			goto err;
+	}
+
 	/* Configure supported hardware */
 	if (config->supported_hw) {
 		ret = _opp_set_supported_hw(opp_table, config->supported_hw,
@@ -2458,6 +2520,7 @@ void dev_pm_opp_clear_config(struct opp_table *opp_table)
 	_opp_detach_genpd(opp_table);
 	_opp_put_regulators(opp_table);
 	_opp_put_supported_hw(opp_table);
+	_opp_put_config_regulators_helper(opp_table);
 	_opp_unregister_set_opp_helper(opp_table);
 	_opp_put_prop_name(opp_table);
 	_opp_put_clkname(opp_table);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 9e1cfcb0ea98..4695d315e7f9 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -151,6 +151,7 @@ enum opp_table_access {
  * @prop_name: A name to postfix to many DT properties, while parsing them.
  * @clk_configured: Clock name is configured by the platform.
  * @clk: Device's clock handle
+ * @config_regulators: Platform specific config_regulators() callback.
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators. Its value can be -1
  * (uninitialized), 0 (no opp-microvolt property) or > 0 (has opp-microvolt
@@ -203,6 +204,7 @@ struct opp_table {
 	const char *prop_name;
 	bool clk_configured;
 	struct clk *clk;
+	config_regulators_t config_regulators;
 	struct regulator **regulators;
 	int regulator_count;
 	struct icc_path **paths;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 6cf1bbc71ed2..7e7986106274 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -90,11 +90,15 @@ struct dev_pm_set_opp_data {
 	struct device *dev;
 };
 
+typedef int (*config_regulators_t)(struct device *dev, struct dev_pm_opp *old_opp,
+				   struct dev_pm_opp *new_opp, struct regulator **regulators,
+				   unsigned int count);
 /**
  * struct dev_pm_opp_config - Device OPP configuration values
  * @clk_name: Clk name.
  * @prop_name: Name to postfix to properties.
  * @set_opp: Custom set OPP helper.
+ * @config_regulators: Custom set regulator helper.
  * @supported_hw: Array of hierarchy of versions to match.
  * @supported_hw_count: Number of elements in the array.
  * @regulator_names: Array of pointers to the names of the regulator.
@@ -108,6 +112,7 @@ struct dev_pm_opp_config {
 	const char *clk_name;
 	const char *prop_name;
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
+	config_regulators_t config_regulators;
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char * const *regulator_names;
-- 
2.31.1.272.g89b43f80a514

