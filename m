Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55071C4843
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgEDU36 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgEDU35 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:29:57 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D36AC061A0E
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 13:29:55 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r14so6166806pfg.2
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 13:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+wRB5VIfZYKsxL8k93SIKt73dz4lmPO3scxFuSAQj30=;
        b=PeD0pB0e/n9l4fG8cG6k0mKzO7nh3ASbGXrnrEoEIENp4G61qTS2JVdN6iOkR4sQcQ
         DzgXFdfz2DVdhU0qfJ5YTDgFj69QK5Pnr9i6D+AnQnUFYjlBtGMaHAJ3puNmTqPRNNQW
         p6H2YEHgy3CpiPH7ZitGv2Z/rwpHeUinztj14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+wRB5VIfZYKsxL8k93SIKt73dz4lmPO3scxFuSAQj30=;
        b=Llaz0nOC2YljoHNaWBSRQ+kxveVSrlQiZwFgwpxcCwkG5AdlhTLh91gkzSN2Xtc13o
         vqEhNrM6HcifKuTfnSU14dtn2XumDinNTJtox6ZxnNgaKwEjNLYAoagaIcf2+1OvOLHA
         sClljAsQcTtNvt4Sdl8eB3SGzdIITgukRZ8XqOK1/8taUUNlL7LNol9PUtq8baRz3rLD
         kMPHdW/0voYHRYCn8wdo5jHlJvg8T2fe1NrdOmuJVW0U9jaH6cZ606vQcXfZb51C6HyU
         c6myjXa/a7QTjeMYhkm21m5F24iiK7qcwrqB6ihpisciVTrjESNSugDHCTfiy28rnBP/
         1i9g==
X-Gm-Message-State: AGi0PuYkNuKh6JeSXupi8uh+I7bkDPLano61es9oB7d7kYTlE65EM7m+
        PSK+Jr3g1zvYWqsH0r/p/+Hbpg==
X-Google-Smtp-Source: APiQypLOyqgvtozcPjyYW5OlT5qxl0jz0eewN5V8RpPJP7QqhNTq3SSzCQD+U3OCQkxe31WiFlHeBQ==
X-Received: by 2002:a63:ff42:: with SMTP id s2mr25874pgk.410.1588624195118;
        Mon, 04 May 2020 13:29:55 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id z23sm9511737pfr.136.2020.05.04.13.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 13:29:54 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2 3/4] power_supply: Add a macro that maps enum properties to text values
Date:   Mon,  4 May 2020 14:29:29 -0600
Message-Id: <20200504202930.228453-4-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200504202930.228453-1-mathewk@chromium.org>
References: <20200504202930.228453-1-mathewk@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reduce the number of touch points to add a new enum property to the
power_supply class by mapping the array of text values to the device
attribute descriptor. A new enum property can now added by creating an
array with the text values named POWER_SUPPLY_${PROPNAME}_TEXT and
adding POWER_SUPPLY_ENUM_ATTR(${PROPNAME}) to the power_supply_attrs
array.

Signed-off-by: Mathew King <mathewk@chromium.org>
---
v2: - Fix array name from previous patch
---
 drivers/power/supply/power_supply_sysfs.c | 126 +++++++++-------------
 1 file changed, 51 insertions(+), 75 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index fb4d41c49ae1..8f90daff0003 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -24,16 +24,26 @@ struct power_supply_attr {
 	const char *prop_name;
 	char attr_name[MAX_PROP_NAME_LEN + 1];
 	struct device_attribute dev_attr;
+	const char * const *text_values;
+	int text_values_len;
 };
 
-#define POWER_SUPPLY_ATTR(_name)	\
-[POWER_SUPPLY_PROP_ ## _name] =		\
-{					\
-	.prop_name = #_name,		\
-	.attr_name = #_name "\0",	\
+#define _POWER_SUPPLY_ATTR(_name, _text, _len)	\
+[POWER_SUPPLY_PROP_ ## _name] =			\
+{						\
+	.prop_name = #_name,			\
+	.attr_name = #_name "\0",		\
+	.text_values = _text,			\
+	.text_values_len = _len,		\
 }
 
-static const char * const power_supply_type_text[] = {
+#define POWER_SUPPLY_ATTR(_name) _POWER_SUPPLY_ATTR(_name, NULL, 0)
+#define _POWER_SUPPLY_ENUM_ATTR(_name, _text)	\
+	_POWER_SUPPLY_ATTR(_name, _text, ARRAY_SIZE(_text))
+#define POWER_SUPPLY_ENUM_ATTR(_name)	\
+	_POWER_SUPPLY_ENUM_ATTR(_name, POWER_SUPPLY_ ## _name ## _TEXT)
+
+static const char * const POWER_SUPPLY_TYPE_TEXT[] = {
 	[POWER_SUPPLY_TYPE_UNKNOWN]		= "Unknown",
 	[POWER_SUPPLY_TYPE_BATTERY]		= "Battery",
 	[POWER_SUPPLY_TYPE_UPS]			= "UPS",
@@ -48,7 +58,7 @@ static const char * const power_supply_type_text[] = {
 	[POWER_SUPPLY_TYPE_APPLE_BRICK_ID]	= "BrickID",
 };
 
-static const char * const power_supply_usb_type_text[] = {
+static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] = {
 	[POWER_SUPPLY_USB_TYPE_UNKNOWN]		= "Unknown",
 	[POWER_SUPPLY_USB_TYPE_SDP]		= "SDP",
 	[POWER_SUPPLY_USB_TYPE_DCP]		= "DCP",
@@ -61,7 +71,7 @@ static const char * const power_supply_usb_type_text[] = {
 	[POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID]	= "BrickID",
 };
 
-static const char * const power_supply_status_text[] = {
+static const char * const POWER_SUPPLY_STATUS_TEXT[] = {
 	[POWER_SUPPLY_STATUS_UNKNOWN]		= "Unknown",
 	[POWER_SUPPLY_STATUS_CHARGING]		= "Charging",
 	[POWER_SUPPLY_STATUS_DISCHARGING]	= "Discharging",
@@ -69,7 +79,7 @@ static const char * const power_supply_status_text[] = {
 	[POWER_SUPPLY_STATUS_FULL]		= "Full",
 };
 
-static const char * const power_supply_charge_type_text[] = {
+static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT[] = {
 	[POWER_SUPPLY_CHARGE_TYPE_UNKNOWN]	= "Unknown",
 	[POWER_SUPPLY_CHARGE_TYPE_NONE]		= "N/A",
 	[POWER_SUPPLY_CHARGE_TYPE_TRICKLE]	= "Trickle",
@@ -79,7 +89,7 @@ static const char * const power_supply_charge_type_text[] = {
 	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	= "Custom",
 };
 
-static const char * const power_supply_health_text[] = {
+static const char * const POWER_SUPPLY_HEALTH_TEXT[] = {
 	[POWER_SUPPLY_HEALTH_UNKNOWN]		    = "Unknown",
 	[POWER_SUPPLY_HEALTH_GOOD]		    = "Good",
 	[POWER_SUPPLY_HEALTH_OVERHEAT]		    = "Overheat",
@@ -92,7 +102,7 @@ static const char * const power_supply_health_text[] = {
 	[POWER_SUPPLY_HEALTH_OVERCURRENT]	    = "Over current",
 };
 
-static const char * const power_supply_technology_text[] = {
+static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] = {
 	[POWER_SUPPLY_TECHNOLOGY_UNKNOWN]	= "Unknown",
 	[POWER_SUPPLY_TECHNOLOGY_NiMH]		= "NiMH",
 	[POWER_SUPPLY_TECHNOLOGY_LION]		= "Li-ion",
@@ -102,7 +112,7 @@ static const char * const power_supply_technology_text[] = {
 	[POWER_SUPPLY_TECHNOLOGY_LiMn]		= "LiMn",
 };
 
-static const char * const power_supply_capacity_level_text[] = {
+static const char * const POWER_SUPPLY_CAPACITY_LEVEL_TEXT[] = {
 	[POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN]	= "Unknown",
 	[POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL]	= "Critical",
 	[POWER_SUPPLY_CAPACITY_LEVEL_LOW]	= "Low",
@@ -111,7 +121,7 @@ static const char * const power_supply_capacity_level_text[] = {
 	[POWER_SUPPLY_CAPACITY_LEVEL_FULL]	= "Full",
 };
 
-static const char * const power_supply_scope_text[] = {
+static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
 	[POWER_SUPPLY_SCOPE_UNKNOWN]	= "Unknown",
 	[POWER_SUPPLY_SCOPE_SYSTEM]	= "System",
 	[POWER_SUPPLY_SCOPE_DEVICE]	= "Device",
@@ -119,13 +129,13 @@ static const char * const power_supply_scope_text[] = {
 
 static struct power_supply_attr power_supply_attrs[] = {
 	/* Properties of type `int' */
-	POWER_SUPPLY_ATTR(STATUS),
-	POWER_SUPPLY_ATTR(CHARGE_TYPE),
-	POWER_SUPPLY_ATTR(HEALTH),
+	POWER_SUPPLY_ENUM_ATTR(STATUS),
+	POWER_SUPPLY_ENUM_ATTR(CHARGE_TYPE),
+	POWER_SUPPLY_ENUM_ATTR(HEALTH),
 	POWER_SUPPLY_ATTR(PRESENT),
 	POWER_SUPPLY_ATTR(ONLINE),
 	POWER_SUPPLY_ATTR(AUTHENTIC),
-	POWER_SUPPLY_ATTR(TECHNOLOGY),
+	POWER_SUPPLY_ENUM_ATTR(TECHNOLOGY),
 	POWER_SUPPLY_ATTR(CYCLE_COUNT),
 	POWER_SUPPLY_ATTR(VOLTAGE_MAX),
 	POWER_SUPPLY_ATTR(VOLTAGE_MIN),
@@ -168,7 +178,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(CAPACITY),
 	POWER_SUPPLY_ATTR(CAPACITY_ALERT_MIN),
 	POWER_SUPPLY_ATTR(CAPACITY_ALERT_MAX),
-	POWER_SUPPLY_ATTR(CAPACITY_LEVEL),
+	POWER_SUPPLY_ENUM_ATTR(CAPACITY_LEVEL),
 	POWER_SUPPLY_ATTR(TEMP),
 	POWER_SUPPLY_ATTR(TEMP_MAX),
 	POWER_SUPPLY_ATTR(TEMP_MIN),
@@ -181,9 +191,9 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(TIME_TO_EMPTY_AVG),
 	POWER_SUPPLY_ATTR(TIME_TO_FULL_NOW),
 	POWER_SUPPLY_ATTR(TIME_TO_FULL_AVG),
-	POWER_SUPPLY_ATTR(TYPE),
+	POWER_SUPPLY_ENUM_ATTR(TYPE),
 	POWER_SUPPLY_ATTR(USB_TYPE),
-	POWER_SUPPLY_ATTR(SCOPE),
+	POWER_SUPPLY_ENUM_ATTR(SCOPE),
 	POWER_SUPPLY_ATTR(PRECHARGE_CURRENT),
 	POWER_SUPPLY_ATTR(CHARGE_TERM_CURRENT),
 	POWER_SUPPLY_ATTR(CALIBRATE),
@@ -196,10 +206,14 @@ static struct power_supply_attr power_supply_attrs[] = {
 static struct attribute *
 __power_supply_attrs[ARRAY_SIZE(power_supply_attrs) + 1];
 
+static struct power_supply_attr *to_ps_attr(struct device_attribute *attr)
+{
+	return container_of(attr, struct power_supply_attr, dev_attr);
+}
+
 static enum power_supply_property dev_attr_psp(struct device_attribute *attr)
 {
-	return container_of(attr, struct power_supply_attr, dev_attr) -
-		power_supply_attrs;
+	return  to_ps_attr(attr) - power_supply_attrs;
 }
 
 static ssize_t power_supply_show_usb_type(struct device *dev,
@@ -218,11 +232,11 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
 
 		if (value->intval == usb_type) {
 			count += sprintf(buf + count, "[%s] ",
-					 power_supply_usb_type_text[usb_type]);
+					 POWER_SUPPLY_USB_TYPE_TEXT[usb_type]);
 			match = true;
 		} else {
 			count += sprintf(buf + count, "%s ",
-					 power_supply_usb_type_text[usb_type]);
+					 POWER_SUPPLY_USB_TYPE_TEXT[usb_type]);
 		}
 	}
 
@@ -242,6 +256,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 					  char *buf) {
 	ssize_t ret;
 	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply_attr *ps_attr = to_ps_attr(attr);
 	enum power_supply_property psp = dev_attr_psp(attr);
 	union power_supply_propval value;
 
@@ -262,39 +277,16 @@ static ssize_t power_supply_show_property(struct device *dev,
 		}
 	}
 
+	if (ps_attr->text_values_len > 0 &&
+	    value.intval < ps_attr->text_values_len && value.intval >= 0) {
+		return sprintf(buf, "%s\n", ps_attr->text_values[value.intval]);
+	}
+
 	switch (psp) {
-	case POWER_SUPPLY_PROP_STATUS:
-		ret = sprintf(buf, "%s\n",
-			      power_supply_status_text[value.intval]);
-		break;
-	case POWER_SUPPLY_PROP_CHARGE_TYPE:
-		ret = sprintf(buf, "%s\n",
-			      power_supply_charge_type_text[value.intval]);
-		break;
-	case POWER_SUPPLY_PROP_HEALTH:
-		ret = sprintf(buf, "%s\n",
-			      power_supply_health_text[value.intval]);
-		break;
-	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		ret = sprintf(buf, "%s\n",
-			      power_supply_technology_text[value.intval]);
-		break;
-	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
-		ret = sprintf(buf, "%s\n",
-			      power_supply_capacity_level_text[value.intval]);
-		break;
-	case POWER_SUPPLY_PROP_TYPE:
-		ret = sprintf(buf, "%s\n",
-			      power_supply_type_text[value.intval]);
-		break;
 	case POWER_SUPPLY_PROP_USB_TYPE:
 		ret = power_supply_show_usb_type(dev, psy->desc->usb_types,
-						 psy->desc->num_usb_types,
-						 &value, buf);
-		break;
-	case POWER_SUPPLY_PROP_SCOPE:
-		ret = sprintf(buf, "%s\n",
-			      power_supply_scope_text[value.intval]);
+						psy->desc->num_usb_types,
+						&value, buf);
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
 		ret = sprintf(buf, "%s\n", value.strval);
@@ -311,30 +303,14 @@ static ssize_t power_supply_store_property(struct device *dev,
 					   const char *buf, size_t count) {
 	ssize_t ret;
 	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply_attr *ps_attr = to_ps_attr(attr);
 	enum power_supply_property psp = dev_attr_psp(attr);
 	union power_supply_propval value;
 
-	switch (psp) {
-	case POWER_SUPPLY_PROP_STATUS:
-		ret = sysfs_match_string(power_supply_status_text, buf);
-		break;
-	case POWER_SUPPLY_PROP_CHARGE_TYPE:
-		ret = sysfs_match_string(power_supply_charge_type_text, buf);
-		break;
-	case POWER_SUPPLY_PROP_HEALTH:
-		ret = sysfs_match_string(power_supply_health_text, buf);
-		break;
-	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		ret = sysfs_match_string(power_supply_technology_text, buf);
-		break;
-	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
-		ret = sysfs_match_string(power_supply_capacity_level_text, buf);
-		break;
-	case POWER_SUPPLY_PROP_SCOPE:
-		ret = sysfs_match_string(power_supply_scope_text, buf);
-		break;
-	default:
-		ret = -EINVAL;
+	ret = -EINVAL;
+	if (ps_attr->text_values_len > 0) {
+		ret = __sysfs_match_string(ps_attr->text_values,
+					   ps_attr->text_values_len, buf);
 	}
 
 	/*
-- 
2.26.2.526.g744177e7f7-goog

