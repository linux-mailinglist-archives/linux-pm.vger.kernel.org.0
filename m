Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808D91B7CF0
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 19:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgDXRfs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 13:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728838AbgDXRfq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 13:35:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD6FC09B04C
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 10:35:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so5118966pfn.5
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CutbCIVuKuAVie48LATjmyyS9o3DqvcRTx6/Njf6Kxg=;
        b=EdjlG3bVGuSQQSoqP+HDFr6ZG+HtO377JdO4jTZKnyCdze5G1+kcyNXfPa+IW4ba6j
         CINYdXZ5luIzOgxUqzx9YUhaaaTyJvACO4JDr2pY2gC1XEl/4WfZdCdusiaiX9fdUVJt
         ZWR80k6PskVOhtoNAXs9RQmQ/plkD9L8mN4tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CutbCIVuKuAVie48LATjmyyS9o3DqvcRTx6/Njf6Kxg=;
        b=D3eoztjjdXLQUUTvUc5SBH9usHeyvdTvxFQul7NuopInN51FLgMpkmLDDyZRt3eYTo
         Nr5jHt67lU1ZyZvZ8zaimG+gJMJdquYWIO1ay6MntGx0uJY6X//LW+q+3k0/dDyIz8n5
         nkH6ku4l6HyJTKL5R3+lfamEM+enpNjCJpyWGj+7RtDmnBI5NjpBTWSbewWNNaT8uLPu
         cmPNlFrXVocb5rr9nYwW2kr9tF4SbviW4YIjm6gddozrwfVdEQUgMEu4fFMijdrVpHy5
         xcSMfiWZfBsj9jAmnnn1A0Z155kgCHfqx/OV59mgpT1EljEMO5M1r6l3BTh2SJk3I0fg
         6/tQ==
X-Gm-Message-State: AGi0PuaHixM1hiAcDLWx4SrXiT2PtQY7Nm1UFgNb6F+whW1u94W3vRTB
        P72CvTJH6KFCu+xwAmG52IuwyQ==
X-Google-Smtp-Source: APiQypIBRnhe3gpS2jtncO1KlNaXPEnkD2+TnHHgrZRkd4/xlQHbeRG5JF1cN+RZ/lLyuQCGXLNRNA==
X-Received: by 2002:a63:257:: with SMTP id 84mr10399336pgc.284.1587749746170;
        Fri, 24 Apr 2020 10:35:46 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id t188sm5360641pgc.3.2020.04.24.10.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:35:45 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 3/4] power_supply: Add a macro that maps enum properties to text values
Date:   Fri, 24 Apr 2020 11:35:32 -0600
Message-Id: <20200424173533.48572-4-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200424173533.48572-1-mathewk@chromium.org>
References: <20200424173533.48572-1-mathewk@chromium.org>
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
 drivers/power/supply/power_supply_sysfs.c | 122 +++++++++-------------
 1 file changed, 49 insertions(+), 73 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 328107589770..fbb05466b9a5 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -26,15 +26,25 @@ struct power_supply_attr {
 	const char *upper_name;
 	const char *lower_name;
 	struct device_attribute dev_attr;
+	const char * const *text_values;
+	int text_values_len;
 };
 
-#define POWER_SUPPLY_ATTR(_name)	\
-[POWER_SUPPLY_PROP_ ## _name] =		\
-{					\
-	.prop_name = #_name		\
+#define _POWER_SUPPLY_ATTR(_name, _text, _len)	\
+[POWER_SUPPLY_PROP_ ## _name] =			\
+{						\
+	.prop_name = #_name,			\
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
@@ -62,7 +72,7 @@ static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] = {
 	[POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID]	= "BrickID",
 };
 
-static const char * const power_supply_status_text[] = {
+static const char * const POWER_SUPPLY_STATUS_TEXT[] = {
 	[POWER_SUPPLY_STATUS_UNKNOWN]		= "Unknown",
 	[POWER_SUPPLY_STATUS_CHARGING]		= "Charging",
 	[POWER_SUPPLY_STATUS_DISCHARGING]	= "Discharging",
@@ -70,7 +80,7 @@ static const char * const power_supply_status_text[] = {
 	[POWER_SUPPLY_STATUS_FULL]		= "Full",
 };
 
-static const char * const power_supply_charge_type_text[] = {
+static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT[] = {
 	[POWER_SUPPLY_CHARGE_TYPE_UNKNOWN]	= "Unknown",
 	[POWER_SUPPLY_CHARGE_TYPE_NONE]		= "N/A",
 	[POWER_SUPPLY_CHARGE_TYPE_TRICKLE]	= "Trickle",
@@ -80,7 +90,7 @@ static const char * const power_supply_charge_type_text[] = {
 	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	= "Custom",
 };
 
-static const char * const power_supply_health_text[] = {
+static const char * const POWER_SUPPLY_HEALTH_TEXT[] = {
 	[POWER_SUPPLY_HEALTH_UNKNOWN]		    = "Unknown",
 	[POWER_SUPPLY_HEALTH_GOOD]		    = "Good",
 	[POWER_SUPPLY_HEALTH_OVERHEAT]		    = "Overheat",
@@ -93,7 +103,7 @@ static const char * const power_supply_health_text[] = {
 	[POWER_SUPPLY_HEALTH_OVERCURRENT]	    = "Over current",
 };
 
-static const char * const power_supply_technology_text[] = {
+static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] = {
 	[POWER_SUPPLY_TECHNOLOGY_UNKNOWN]	= "Unknown",
 	[POWER_SUPPLY_TECHNOLOGY_NiMH]		= "NiMH",
 	[POWER_SUPPLY_TECHNOLOGY_LION]		= "Li-ion",
@@ -103,7 +113,7 @@ static const char * const power_supply_technology_text[] = {
 	[POWER_SUPPLY_TECHNOLOGY_LiMn]		= "LiMn",
 };
 
-static const char * const power_supply_capacity_level_text[] = {
+static const char * const POWER_SUPPLY_CAPACITY_LEVEL_TEXT[] = {
 	[POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN]	= "Unknown",
 	[POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL]	= "Critical",
 	[POWER_SUPPLY_CAPACITY_LEVEL_LOW]	= "Low",
@@ -112,7 +122,7 @@ static const char * const power_supply_capacity_level_text[] = {
 	[POWER_SUPPLY_CAPACITY_LEVEL_FULL]	= "Full",
 };
 
-static const char * const power_supply_scope_text[] = {
+static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
 	[POWER_SUPPLY_SCOPE_UNKNOWN]	= "Unknown",
 	[POWER_SUPPLY_SCOPE_SYSTEM]	= "System",
 	[POWER_SUPPLY_SCOPE_DEVICE]	= "Device",
@@ -120,13 +130,13 @@ static const char * const power_supply_scope_text[] = {
 
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
@@ -169,7 +179,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(CAPACITY),
 	POWER_SUPPLY_ATTR(CAPACITY_ALERT_MIN),
 	POWER_SUPPLY_ATTR(CAPACITY_ALERT_MAX),
-	POWER_SUPPLY_ATTR(CAPACITY_LEVEL),
+	POWER_SUPPLY_ENUM_ATTR(CAPACITY_LEVEL),
 	POWER_SUPPLY_ATTR(TEMP),
 	POWER_SUPPLY_ATTR(TEMP_MAX),
 	POWER_SUPPLY_ATTR(TEMP_MIN),
@@ -182,9 +192,9 @@ static struct power_supply_attr power_supply_attrs[] = {
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
@@ -197,10 +207,14 @@ static struct power_supply_attr power_supply_attrs[] = {
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
@@ -219,11 +233,11 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
 
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
 
@@ -243,6 +257,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 					  char *buf) {
 	ssize_t ret;
 	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply_attr *ps_attr = to_ps_attr(attr);
 	enum power_supply_property psp = dev_attr_psp(attr);
 	union power_supply_propval value;
 
@@ -263,39 +278,16 @@ static ssize_t power_supply_show_property(struct device *dev,
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
@@ -312,30 +304,14 @@ static ssize_t power_supply_store_property(struct device *dev,
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
2.26.2.303.gf8c07b1a785-goog

