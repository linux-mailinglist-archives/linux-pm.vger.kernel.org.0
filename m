Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01306EB027
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 13:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfJaMXp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 08:23:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34895 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfJaMXp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 08:23:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id c8so3974008pgb.2
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 05:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zQKRY2XE5oS+mi6BE44agpH5JNOXqmvzvanMV9EmHYs=;
        b=cLIQcH9d9VBOuW5eg1WEB5cH12kHdtw3tpLXDCqui+gGLI2o+7YmxJeMpr3bTTID22
         OxrVgLn7lpnpBFmynNLHesa80WLHSG1l1PQOM92u6713UOvNwXflkXZNdNY4MS2WMztn
         5QvPoMfZiu9X5Kwdqy4XwZKlycdtyH3cLehgxbzfTn4P9qeLqQ60qm8/vRDXUNfi5oU6
         J9fN2TF2DbSg1+UCZu3XGYnYUhlbE7r6+qHwvv+UtvcO92CHjzbwqmmzSc4MhwgKFwoY
         wCVaTSmQIfpf8AivSJE+7TFrbb/Qe3bg2EbtvphPWKjHzBOjKLO0MPfGhElq9/Y0VcFX
         Ax4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zQKRY2XE5oS+mi6BE44agpH5JNOXqmvzvanMV9EmHYs=;
        b=YuDK+PADgz53WuXlGBlYJDypvVFFPhtshn2WG/w3O+qkkJd18bLd8TVdd96RI4byVV
         AjKa83dnXVO+hruFdtcCUs/BbRVJ1B+vSx+nvW7y+l07MqJODjOyAYep4OVJFyyRb5YP
         R2G0kXYnlSHGkJsthHSb7brxwpdKxPDKhr/Q3CQUt+RcppD4lxzuc9vHjZJWwNT/e1b0
         m3M3/Lx4KtOxrFWcTcQfqOuy2X/cQ3b+irjhm++4igyFngOpkVZYkXbMHEr0h43RM4WK
         I8Pp9ME4KGnHBc63YSytMdSi1iRax3FOb6ED+wIIEvfKN1qZYFhVnOMKBwKNo6Z+cg7q
         rBNw==
X-Gm-Message-State: APjAAAV15LbL67PLr5gU8TfG4Kwh9vbuV318zF3/u8vXPIOvAc2/AgqN
        dpi3VjP7egOiRxsBzR57a1R2fA==
X-Google-Smtp-Source: APXvYqz4LtpsmNhxAR8BEP3jfQN9Zi/GoqBPCUEwXEOGFoUFUvabW6mN4F67lmRMZ3lE0g99zgH2oA==
X-Received: by 2002:a17:90a:9293:: with SMTP id n19mr6915757pjo.67.1572524624617;
        Thu, 31 Oct 2019 05:23:44 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j25sm2983077pfi.113.2019.10.31.05.23.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 05:23:43 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH v2 2/5] power: supply: core: Add battery internal resistance temperature table support
Date:   Thu, 31 Oct 2019 20:22:41 +0800
Message-Id: <febb8a7721ddd29ad2fa7cf92c2b7a79180bb61e.1572523415.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1572523415.git.baolin.wang@linaro.org>
References: <cover.1572523415.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1572523415.git.baolin.wang@linaro.org>
References: <cover.1572523415.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since the battery internal resistance can be changed with the temperature
changes, thus add a resistance temperature table support to look up
the accurate battery internal resistance in a certain temperature.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/power_supply_core.c |   67 +++++++++++++++++++++++++++++-
 include/linux/power_supply.h             |   10 +++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 5c36c43..1a9a9fa 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -565,9 +565,11 @@ struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
 int power_supply_get_battery_info(struct power_supply *psy,
 				  struct power_supply_battery_info *info)
 {
+	struct power_supply_resistance_temp_table *resist_table;
 	struct device_node *battery_np;
 	const char *value;
 	int err, len, index;
+	const __be32 *list;
 
 	info->energy_full_design_uwh         = -EINVAL;
 	info->charge_full_design_uah         = -EINVAL;
@@ -578,6 +580,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->constant_charge_current_max_ua = -EINVAL;
 	info->constant_charge_voltage_max_uv = -EINVAL;
 	info->factory_internal_resistance_uohm  = -EINVAL;
+	info->resist_table = NULL;
 
 	for (index = 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
 		info->ocv_table[index]       = NULL;
@@ -644,7 +647,6 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	for (index = 0; index < len; index++) {
 		struct power_supply_battery_ocv_table *table;
 		char *propname;
-		const __be32 *list;
 		int i, tab_len, size;
 
 		propname = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d", index);
@@ -677,6 +679,26 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		}
 	}
 
+	list = of_get_property(battery_np, "resistance-temp-table", &len);
+	if (!list || !len)
+		goto out_put_node;
+
+	info->resist_table_size = len / (2 * sizeof(__be32));
+	resist_table = info->resist_table = devm_kcalloc(&psy->dev,
+							 info->resist_table_size,
+							 sizeof(*resist_table),
+							 GFP_KERNEL);
+	if (!info->resist_table) {
+		power_supply_put_battery_info(psy, info);
+		err = -ENOMEM;
+		goto out_put_node;
+	}
+
+	for (index = 0; index < info->resist_table_size; index++) {
+		resist_table[index].temp = be32_to_cpu(*list++);
+		resist_table[index].resistance = be32_to_cpu(*list++);
+	}
+
 out_put_node:
 	of_node_put(battery_np);
 	return err;
@@ -692,10 +714,53 @@ void power_supply_put_battery_info(struct power_supply *psy,
 		if (info->ocv_table[i])
 			devm_kfree(&psy->dev, info->ocv_table[i]);
 	}
+
+	if (info->resist_table)
+		devm_kfree(&psy->dev, info->resist_table);
 }
 EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
 
 /**
+ * power_supply_temp2resist_simple() - find the battery internal resistance
+ * percent
+ * @table: Pointer to battery resistance temperature table
+ * @table_len: The table length
+ * @ocv: Current temperature
+ *
+ * This helper function is used to look up battery internal resistance percent
+ * according to current temperature value from the resistance temperature table,
+ * and the table must be ordered descending. Then the actual battery internal
+ * resistance = the ideal battery internal resistance * percent / 100.
+ *
+ * Return: the battery internal resistance percent
+ */
+int power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table,
+				    int table_len, int temp)
+{
+	int i, resist;
+
+	for (i = 0; i < table_len; i++)
+		if (temp > table[i].temp)
+			break;
+
+	if (i > 0 && i < table_len) {
+		int tmp;
+
+		tmp = (table[i - 1].resistance - table[i].resistance) *
+			(temp - table[i].temp);
+		tmp /= table[i - 1].temp - table[i].temp;
+		resist = tmp + table[i].resistance;
+	} else if (i == 0) {
+		resist = table[0].resistance;
+	} else {
+		resist = table[table_len - 1].resistance;
+	}
+
+	return resist;
+}
+EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
+
+/**
  * power_supply_ocv2cap_simple() - find the battery capacity
  * @table: Pointer to battery OCV lookup table
  * @table_len: OCV table length
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 28413f7..dcd5a71 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -325,6 +325,11 @@ struct power_supply_battery_ocv_table {
 	int capacity;	/* percent */
 };
 
+struct power_supply_resistance_temp_table {
+	int temp;	/* celsius */
+	int resistance;	/* internal resistance percent */
+};
+
 #define POWER_SUPPLY_OCV_TEMP_MAX 20
 
 /*
@@ -349,6 +354,8 @@ struct power_supply_battery_info {
 	int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];/* celsius */
 	struct power_supply_battery_ocv_table *ocv_table[POWER_SUPPLY_OCV_TEMP_MAX];
 	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
+	struct power_supply_resistance_temp_table *resist_table;
+	int resist_table_size;
 };
 
 extern struct atomic_notifier_head power_supply_notifier;
@@ -381,6 +388,9 @@ extern int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *ta
 				int temp, int *table_len);
 extern int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
 					int ocv, int temp);
+extern int
+power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table,
+				int table_len, int temp);
 extern void power_supply_changed(struct power_supply *psy);
 extern int power_supply_am_i_supplied(struct power_supply *psy);
 extern int power_supply_set_input_current_limit_from_supplier(
-- 
1.7.9.5

