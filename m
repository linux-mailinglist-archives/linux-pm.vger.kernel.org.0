Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C7C1C4847
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgEDUaH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgEDU3y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:29:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AACC061A0E
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 13:29:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x2so6151322pfx.7
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 13:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0QB4162GZsAN1d5fV7HEvP7d2Yurhr7blPN7cTnpSEo=;
        b=Y8oe9HHGRrJ5KmrQOQxyy1+h2aYbKFjHXwYYCNB6WgwKRnEkaunauvh+kJdvZWXCzk
         I6s7LzvRsDCE4Q1m1/W3OG/xmsVmZBpXe+7k8rXOx9SCTRVSOFOYKH826V0AmDGfzKcH
         6+iY0GiHW65bH24DlJBWxrTvWeNR0yNYmBM9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0QB4162GZsAN1d5fV7HEvP7d2Yurhr7blPN7cTnpSEo=;
        b=cM+POLAB5tJ3iSut7CYWRKSRr3UiyBhyr6vFfHzzaLRNIhw3HIfWz0/QS2ZhJNZ4fC
         ZjUZ07hWk7GONuRm6iRCyofEHtoDZNZf2HAIu6Kb0exZTI8yFcfwmL9Gu3STj+bPiqzY
         bMXCf7MAx/J54+8AlhzBJfnzYyqcQSjWVMpOGhdxOXmsEHKSveZ3SFXtGGylxNLjWNWA
         ruyAucFeqMGM+vVdzjwJJ0mh4sqYM6LQhO4/OYI53/+XbCcZ5tCY+Z/8opVsiXe/bDhW
         W58Gi9HR3ya1dqlDWB07yRQO83St4Kz0tUgeOcKx3nvw3wxPaiN+5nR8fWkKXnhC7SSY
         R2SA==
X-Gm-Message-State: AGi0PuatyxCLFVWdv5I7R5Z8Ouf6nus+I7Vs+z6neG1MW7HJFzC4e7TD
        jgaoXew88Z576++QjlcKbJ55WmVvTf8mNg==
X-Google-Smtp-Source: APiQypJX/3gaMy7JNCCzUaXIh/3dugfltFxqKkBMyY8CmFD2XLSyZ++uN7JwKOieOXHNAevOh/5zqg==
X-Received: by 2002:a63:a358:: with SMTP id v24mr15831pgn.117.1588624192676;
        Mon, 04 May 2020 13:29:52 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id z23sm9511737pfr.136.2020.05.04.13.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 13:29:52 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2 1/4] power_supply: Cleanup power supply sysfs attribute list
Date:   Mon,  4 May 2020 14:29:27 -0600
Message-Id: <20200504202930.228453-2-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200504202930.228453-1-mathewk@chromium.org>
References: <20200504202930.228453-1-mathewk@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make the device attribute list used to create sysfs attributes more
robust by decoupling the list order from order of the enum defined in
power_supply.h. This is done by using a designated initializer in the
POWER_SUPPLY_ATTR macro.

Signed-off-by: Mathew King <mathewk@chromium.org>
---
v2: - Don't create attributes for unlisted properties
    - Use a char array for lower case name so no allocations needed
      in init
---
 drivers/power/supply/power_supply_sysfs.c | 260 +++++++++++-----------
 1 file changed, 132 insertions(+), 128 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f37ad4eae60b..69be80b321ea 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -18,26 +18,20 @@
 
 #include "power_supply.h"
 
-/*
- * This is because the name "current" breaks the device attr macro.
- * The "current" word resolves to "(get_current())" so instead of
- * "current" "(get_current())" appears in the sysfs.
- *
- * The source of this definition is the device.h which calls __ATTR
- * macro in sysfs.h which calls the __stringify macro.
- *
- * Only modification that the name is not tried to be resolved
- * (as a macro let's say).
- */
+#define MAX_PROP_NAME_LEN 30
 
-#define POWER_SUPPLY_ATTR(_name)					\
-{									\
-	.attr = { .name = #_name },					\
-	.show = power_supply_show_property,				\
-	.store = power_supply_store_property,				\
-}
+struct power_supply_attr {
+	const char *prop_name;
+	char attr_name[MAX_PROP_NAME_LEN + 1];
+	struct device_attribute dev_attr;
+};
 
-static struct device_attribute power_supply_attrs[];
+#define POWER_SUPPLY_ATTR(_name)	\
+[POWER_SUPPLY_PROP_ ## _name] =		\
+{					\
+	.prop_name = #_name,		\
+	.attr_name = #_name "\0",	\
+}
 
 static const char * const power_supply_type_text[] = {
 	"Unknown", "Battery", "UPS", "Mains", "USB",
@@ -77,6 +71,91 @@ static const char * const power_supply_scope_text[] = {
 	"Unknown", "System", "Device"
 };
 
+static struct power_supply_attr power_supply_attrs[] = {
+	/* Properties of type `int' */
+	POWER_SUPPLY_ATTR(STATUS),
+	POWER_SUPPLY_ATTR(CHARGE_TYPE),
+	POWER_SUPPLY_ATTR(HEALTH),
+	POWER_SUPPLY_ATTR(PRESENT),
+	POWER_SUPPLY_ATTR(ONLINE),
+	POWER_SUPPLY_ATTR(AUTHENTIC),
+	POWER_SUPPLY_ATTR(TECHNOLOGY),
+	POWER_SUPPLY_ATTR(CYCLE_COUNT),
+	POWER_SUPPLY_ATTR(VOLTAGE_MAX),
+	POWER_SUPPLY_ATTR(VOLTAGE_MIN),
+	POWER_SUPPLY_ATTR(VOLTAGE_MAX_DESIGN),
+	POWER_SUPPLY_ATTR(VOLTAGE_MIN_DESIGN),
+	POWER_SUPPLY_ATTR(VOLTAGE_NOW),
+	POWER_SUPPLY_ATTR(VOLTAGE_AVG),
+	POWER_SUPPLY_ATTR(VOLTAGE_OCV),
+	POWER_SUPPLY_ATTR(VOLTAGE_BOOT),
+	POWER_SUPPLY_ATTR(CURRENT_MAX),
+	POWER_SUPPLY_ATTR(CURRENT_NOW),
+	POWER_SUPPLY_ATTR(CURRENT_AVG),
+	POWER_SUPPLY_ATTR(CURRENT_BOOT),
+	POWER_SUPPLY_ATTR(POWER_NOW),
+	POWER_SUPPLY_ATTR(POWER_AVG),
+	POWER_SUPPLY_ATTR(CHARGE_FULL_DESIGN),
+	POWER_SUPPLY_ATTR(CHARGE_EMPTY_DESIGN),
+	POWER_SUPPLY_ATTR(CHARGE_FULL),
+	POWER_SUPPLY_ATTR(CHARGE_EMPTY),
+	POWER_SUPPLY_ATTR(CHARGE_NOW),
+	POWER_SUPPLY_ATTR(CHARGE_AVG),
+	POWER_SUPPLY_ATTR(CHARGE_COUNTER),
+	POWER_SUPPLY_ATTR(CONSTANT_CHARGE_CURRENT),
+	POWER_SUPPLY_ATTR(CONSTANT_CHARGE_CURRENT_MAX),
+	POWER_SUPPLY_ATTR(CONSTANT_CHARGE_VOLTAGE),
+	POWER_SUPPLY_ATTR(CONSTANT_CHARGE_VOLTAGE_MAX),
+	POWER_SUPPLY_ATTR(CHARGE_CONTROL_LIMIT),
+	POWER_SUPPLY_ATTR(CHARGE_CONTROL_LIMIT_MAX),
+	POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
+	POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
+	POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
+	POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
+	POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),
+	POWER_SUPPLY_ATTR(ENERGY_FULL_DESIGN),
+	POWER_SUPPLY_ATTR(ENERGY_EMPTY_DESIGN),
+	POWER_SUPPLY_ATTR(ENERGY_FULL),
+	POWER_SUPPLY_ATTR(ENERGY_EMPTY),
+	POWER_SUPPLY_ATTR(ENERGY_NOW),
+	POWER_SUPPLY_ATTR(ENERGY_AVG),
+	POWER_SUPPLY_ATTR(CAPACITY),
+	POWER_SUPPLY_ATTR(CAPACITY_ALERT_MIN),
+	POWER_SUPPLY_ATTR(CAPACITY_ALERT_MAX),
+	POWER_SUPPLY_ATTR(CAPACITY_LEVEL),
+	POWER_SUPPLY_ATTR(TEMP),
+	POWER_SUPPLY_ATTR(TEMP_MAX),
+	POWER_SUPPLY_ATTR(TEMP_MIN),
+	POWER_SUPPLY_ATTR(TEMP_ALERT_MIN),
+	POWER_SUPPLY_ATTR(TEMP_ALERT_MAX),
+	POWER_SUPPLY_ATTR(TEMP_AMBIENT),
+	POWER_SUPPLY_ATTR(TEMP_AMBIENT_ALERT_MIN),
+	POWER_SUPPLY_ATTR(TEMP_AMBIENT_ALERT_MAX),
+	POWER_SUPPLY_ATTR(TIME_TO_EMPTY_NOW),
+	POWER_SUPPLY_ATTR(TIME_TO_EMPTY_AVG),
+	POWER_SUPPLY_ATTR(TIME_TO_FULL_NOW),
+	POWER_SUPPLY_ATTR(TIME_TO_FULL_AVG),
+	POWER_SUPPLY_ATTR(TYPE),
+	POWER_SUPPLY_ATTR(USB_TYPE),
+	POWER_SUPPLY_ATTR(SCOPE),
+	POWER_SUPPLY_ATTR(PRECHARGE_CURRENT),
+	POWER_SUPPLY_ATTR(CHARGE_TERM_CURRENT),
+	POWER_SUPPLY_ATTR(CALIBRATE),
+	/* Properties of type `const char *' */
+	POWER_SUPPLY_ATTR(MODEL_NAME),
+	POWER_SUPPLY_ATTR(MANUFACTURER),
+	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
+};
+
+static struct attribute *
+__power_supply_attrs[ARRAY_SIZE(power_supply_attrs) + 1];
+
+static enum power_supply_property dev_attr_psp(struct device_attribute *attr)
+{
+	return container_of(attr, struct power_supply_attr, dev_attr) -
+		power_supply_attrs;
+}
+
 static ssize_t power_supply_show_usb_type(struct device *dev,
 					  enum power_supply_usb_type *usb_types,
 					  ssize_t num_usb_types,
@@ -117,7 +196,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 					  char *buf) {
 	ssize_t ret;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	enum power_supply_property psp = attr - power_supply_attrs;
+	enum power_supply_property psp = dev_attr_psp(attr);
 	union power_supply_propval value;
 
 	if (psp == POWER_SUPPLY_PROP_TYPE) {
@@ -186,7 +265,7 @@ static ssize_t power_supply_store_property(struct device *dev,
 					   const char *buf, size_t count) {
 	ssize_t ret;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	enum power_supply_property psp = attr - power_supply_attrs;
+	enum power_supply_property psp = dev_attr_psp(attr);
 	union power_supply_propval value;
 
 	switch (psp) {
@@ -235,86 +314,6 @@ static ssize_t power_supply_store_property(struct device *dev,
 	return count;
 }
 
-/* Must be in the same order as POWER_SUPPLY_PROP_* */
-static struct device_attribute power_supply_attrs[] = {
-	/* Properties of type `int' */
-	POWER_SUPPLY_ATTR(status),
-	POWER_SUPPLY_ATTR(charge_type),
-	POWER_SUPPLY_ATTR(health),
-	POWER_SUPPLY_ATTR(present),
-	POWER_SUPPLY_ATTR(online),
-	POWER_SUPPLY_ATTR(authentic),
-	POWER_SUPPLY_ATTR(technology),
-	POWER_SUPPLY_ATTR(cycle_count),
-	POWER_SUPPLY_ATTR(voltage_max),
-	POWER_SUPPLY_ATTR(voltage_min),
-	POWER_SUPPLY_ATTR(voltage_max_design),
-	POWER_SUPPLY_ATTR(voltage_min_design),
-	POWER_SUPPLY_ATTR(voltage_now),
-	POWER_SUPPLY_ATTR(voltage_avg),
-	POWER_SUPPLY_ATTR(voltage_ocv),
-	POWER_SUPPLY_ATTR(voltage_boot),
-	POWER_SUPPLY_ATTR(current_max),
-	POWER_SUPPLY_ATTR(current_now),
-	POWER_SUPPLY_ATTR(current_avg),
-	POWER_SUPPLY_ATTR(current_boot),
-	POWER_SUPPLY_ATTR(power_now),
-	POWER_SUPPLY_ATTR(power_avg),
-	POWER_SUPPLY_ATTR(charge_full_design),
-	POWER_SUPPLY_ATTR(charge_empty_design),
-	POWER_SUPPLY_ATTR(charge_full),
-	POWER_SUPPLY_ATTR(charge_empty),
-	POWER_SUPPLY_ATTR(charge_now),
-	POWER_SUPPLY_ATTR(charge_avg),
-	POWER_SUPPLY_ATTR(charge_counter),
-	POWER_SUPPLY_ATTR(constant_charge_current),
-	POWER_SUPPLY_ATTR(constant_charge_current_max),
-	POWER_SUPPLY_ATTR(constant_charge_voltage),
-	POWER_SUPPLY_ATTR(constant_charge_voltage_max),
-	POWER_SUPPLY_ATTR(charge_control_limit),
-	POWER_SUPPLY_ATTR(charge_control_limit_max),
-	POWER_SUPPLY_ATTR(charge_control_start_threshold),
-	POWER_SUPPLY_ATTR(charge_control_end_threshold),
-	POWER_SUPPLY_ATTR(input_current_limit),
-	POWER_SUPPLY_ATTR(input_voltage_limit),
-	POWER_SUPPLY_ATTR(input_power_limit),
-	POWER_SUPPLY_ATTR(energy_full_design),
-	POWER_SUPPLY_ATTR(energy_empty_design),
-	POWER_SUPPLY_ATTR(energy_full),
-	POWER_SUPPLY_ATTR(energy_empty),
-	POWER_SUPPLY_ATTR(energy_now),
-	POWER_SUPPLY_ATTR(energy_avg),
-	POWER_SUPPLY_ATTR(capacity),
-	POWER_SUPPLY_ATTR(capacity_alert_min),
-	POWER_SUPPLY_ATTR(capacity_alert_max),
-	POWER_SUPPLY_ATTR(capacity_level),
-	POWER_SUPPLY_ATTR(temp),
-	POWER_SUPPLY_ATTR(temp_max),
-	POWER_SUPPLY_ATTR(temp_min),
-	POWER_SUPPLY_ATTR(temp_alert_min),
-	POWER_SUPPLY_ATTR(temp_alert_max),
-	POWER_SUPPLY_ATTR(temp_ambient),
-	POWER_SUPPLY_ATTR(temp_ambient_alert_min),
-	POWER_SUPPLY_ATTR(temp_ambient_alert_max),
-	POWER_SUPPLY_ATTR(time_to_empty_now),
-	POWER_SUPPLY_ATTR(time_to_empty_avg),
-	POWER_SUPPLY_ATTR(time_to_full_now),
-	POWER_SUPPLY_ATTR(time_to_full_avg),
-	POWER_SUPPLY_ATTR(type),
-	POWER_SUPPLY_ATTR(usb_type),
-	POWER_SUPPLY_ATTR(scope),
-	POWER_SUPPLY_ATTR(precharge_current),
-	POWER_SUPPLY_ATTR(charge_term_current),
-	POWER_SUPPLY_ATTR(calibrate),
-	/* Properties of type `const char *' */
-	POWER_SUPPLY_ATTR(model_name),
-	POWER_SUPPLY_ATTR(manufacturer),
-	POWER_SUPPLY_ATTR(serial_number),
-};
-
-static struct attribute *
-__power_supply_attrs[ARRAY_SIZE(power_supply_attrs) + 1];
-
 static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 					   struct attribute *attr,
 					   int attrno)
@@ -324,6 +323,9 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	umode_t mode = S_IRUSR | S_IRGRP | S_IROTH;
 	int i;
 
+	if (!power_supply_attrs[attrno].prop_name)
+		return 0;
+
 	if (attrno == POWER_SUPPLY_PROP_TYPE)
 		return mode;
 
@@ -352,31 +354,38 @@ static const struct attribute_group *power_supply_attr_groups[] = {
 	NULL,
 };
 
-void power_supply_init_attrs(struct device_type *dev_type)
+static void str_to_lower(char *str)
 {
-	int i;
-
-	dev_type->groups = power_supply_attr_groups;
-
-	for (i = 0; i < ARRAY_SIZE(power_supply_attrs); i++)
-		__power_supply_attrs[i] = &power_supply_attrs[i].attr;
+	while (*str) {
+		*str = tolower(*str);
+		str++;
+	}
 }
 
-static char *kstruprdup(const char *str, gfp_t gfp)
+void power_supply_init_attrs(struct device_type *dev_type)
 {
-	char *ret, *ustr;
+	int i;
 
-	ustr = ret = kmalloc(strlen(str) + 1, gfp);
+	dev_type->groups = power_supply_attr_groups;
 
-	if (!ret)
-		return NULL;
+	for (i = 0; i < ARRAY_SIZE(power_supply_attrs); i++) {
+		struct device_attribute *attr;
 
-	while (*str)
-		*ustr++ = toupper(*str++);
+		if (!power_supply_attrs[i].prop_name) {
+			pr_warn("%s: Property %d skipped because is is missing from power_supply_attrs\n",
+				__func__, i);
+			sprintf(power_supply_attrs[i].attr_name, "_err_%d", i);
+		} else {
+			str_to_lower(power_supply_attrs[i].attr_name);
+		}
 
-	*ustr = 0;
+		attr = &power_supply_attrs[i].dev_attr;
 
-	return ret;
+		attr->attr.name = power_supply_attrs[i].attr_name;
+		attr->show = power_supply_show_property;
+		attr->store = power_supply_store_property;
+		__power_supply_attrs[i] = &attr->attr;
+	}
 }
 
 int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
@@ -384,7 +393,6 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 	struct power_supply *psy = dev_get_drvdata(dev);
 	int ret = 0, j;
 	char *prop_buf;
-	char *attrname;
 
 	if (!psy || !psy->desc) {
 		dev_dbg(dev, "No power supply yet\n");
@@ -400,12 +408,14 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 		return -ENOMEM;
 
 	for (j = 0; j < psy->desc->num_properties; j++) {
-		struct device_attribute *attr;
+		struct power_supply_attr *pwr_attr;
+		struct device_attribute *dev_attr;
 		char *line;
 
-		attr = &power_supply_attrs[psy->desc->properties[j]];
+		pwr_attr = &power_supply_attrs[psy->desc->properties[j]];
+		dev_attr = &pwr_attr->dev_attr;
 
-		ret = power_supply_show_property(dev, attr, prop_buf);
+		ret = power_supply_show_property(dev, dev_attr, prop_buf);
 		if (ret == -ENODEV || ret == -ENODATA) {
 			/* When a battery is absent, we expect -ENODEV. Don't abort;
 			   send the uevent with at least the the PRESENT=0 property */
@@ -420,14 +430,8 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 		if (line)
 			*line = 0;
 
-		attrname = kstruprdup(attr->attr.name, GFP_KERNEL);
-		if (!attrname) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		ret = add_uevent_var(env, "POWER_SUPPLY_%s=%s", attrname, prop_buf);
-		kfree(attrname);
+		ret = add_uevent_var(env, "POWER_SUPPLY_%s=%s",
+				     pwr_attr->prop_name, prop_buf);
 		if (ret)
 			goto out;
 	}
-- 
2.26.2.526.g744177e7f7-goog

