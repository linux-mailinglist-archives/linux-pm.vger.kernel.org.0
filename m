Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A423E6CD7
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 08:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbfJ1HUB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 03:20:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43038 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732514AbfJ1HUA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 03:20:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id v5so5143630ply.10
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2019 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zQKRY2XE5oS+mi6BE44agpH5JNOXqmvzvanMV9EmHYs=;
        b=fm2GAqpvOV5+xOdAo3r0mmuXfnSQudliJYYK8fQmDxTzI5/A6qJcm4cFNtMt6kztOm
         LEZHSgqqIvCQzImsVgxaM52k5nBlExW9YWo98VQGVjqF2zzmrhFIgBsgconeYJH6Qo3C
         VOUk3K90fTM/4g9mYUqnSN3J9E/qTa4ERPQnuGuNs8WpJGU+wX7gRuHHnAuwqB+0XZ9u
         YFsSnfSzwhLA6UHhm24M9X1b3D1RELJx5tC2NgLdio/S+QPsiIfaaJKTaGFZklAVbZqk
         shg3n+kFoHcQ10KLL5GSbW9Xps5orYtPui3XQeo+GlHYFiS6PYd+0TGb8KMDMZeBbzr4
         TzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zQKRY2XE5oS+mi6BE44agpH5JNOXqmvzvanMV9EmHYs=;
        b=Z1b+yNvaUWEU5RPiayf4h0FJlX9xSDNVGTMxrf9MQCTC9QRsWu67ssIuYwk05rwsOS
         lwEfYrElIw0pF+xr06MT55KyCEoWFvrdbgWWyesx8VRHN8375aMF4S/eyMY5wAPJTxmA
         eJF2M8nlRVXFlD93NEi5EQd/uzMQF17K/XzpzCbf/7AYqPxDterHj2vhyK4rrJzzrcxV
         aE0TsaX7F00YXxXsk3QvYeJD5ro/p7QubMXQe4AMko/e1SODOAjxSG5dCvYvSfJmSInZ
         +lvKjxmV7bsj6LdavMOb8i40GvZrCCSkK7Rhj/tANJYEy6AaXfkJyBSC4ApDst5eOGYI
         JIQA==
X-Gm-Message-State: APjAAAVImTK7MCNPTXDPqwCe9vgLX2osAIRE2wVzd52TbMJivMvig1D3
        6WOBd57e+KYti72zO1gXPy3xtQ==
X-Google-Smtp-Source: APXvYqxGyPewV02f8pGwk38cG8wUAibrorZUIjhlZRWTqatHMYUo9fDPeptlwz4JNB+aK8blKxxnjg==
X-Received: by 2002:a17:902:8b83:: with SMTP id ay3mr17436518plb.269.1572247198266;
        Mon, 28 Oct 2019 00:19:58 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 13sm11504703pgq.72.2019.10.28.00.19.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 00:19:57 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH 2/5] power: supply: core: Add battery internal resistance temperature table support
Date:   Mon, 28 Oct 2019 15:18:58 +0800
Message-Id: <cf8ccdb8ee1c00bcd576bb35374c458a3a608c3d.1572245011.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1572245011.git.baolin.wang@linaro.org>
References: <cover.1572245011.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1572245011.git.baolin.wang@linaro.org>
References: <cover.1572245011.git.baolin.wang@linaro.org>
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

