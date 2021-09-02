Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904063FF5AC
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 23:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347069AbhIBVhJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 17:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347431AbhIBVhJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 17:37:09 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A92C061757
        for <linux-pm@vger.kernel.org>; Thu,  2 Sep 2021 14:36:10 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c17so3444487pgc.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Sep 2021 14:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1QHuvNA0GE/QTmVf5qMVWbh81vw1JSnVPC3ftDnCQ2o=;
        b=gua2HzSTeHuCTlzTtSh9R215ubwL7XqKG670iNIAzOeVu4z8GygQnSmoL/98bEeYFZ
         r3C6TZnOkZEeIzlRCPfR3ZdVxxd68+kRIQQ0c/YP17msZlbyVdKbrKagj/XucPb14tyM
         3X3klBlrhAk6HnJoH3HYtzt6up6BkBFVWj0F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QHuvNA0GE/QTmVf5qMVWbh81vw1JSnVPC3ftDnCQ2o=;
        b=ga3P0CI2Z86j/PMepmw22dQNIQYdkFlfckUlUgSFuxeur/08PzD/GhPGN3SdOdI7EK
         2TWx0aaDFJ5/qYSu6o/mAJH9dTMfnjo4muUqxAGEPAYRlzlVcfgoneu79K/uzhcLYV4L
         dNkeZ4nHPG2dvHovUm9d19gF7LnnsCbjf5ociTWROl7iBQHcnWLfVmfOCdtSPMYGYg7m
         o43oy+gCfz0H08CSA3KAvgWdpyfiVdKxrJSb7jDjqtMY6Q0LukyB11xAwlR43mUWFbCN
         Xqcuv2M6AqLxvGZpQJI1d1N/edxzwobCQTnSnMTi1MnsNOmLQgoebuEkkCpG2L4LEdEG
         VgLA==
X-Gm-Message-State: AOAM533u++wupLrEjWtdngKycSeR4E1Uy/L0gY0ifw2eyr98x6OcbgBs
        tuONqKrj5o/7XnMVEc+dxGxRtw==
X-Google-Smtp-Source: ABdhPJx7sq5ohmQvvTlzv3h+qRM+7CoompHfl9c5KeAecA71P5FVpCLxdsQFsNAY6McN+gS8ZsenrQ==
X-Received: by 2002:a65:6393:: with SMTP id h19mr435842pgv.64.1630618569489;
        Thu, 02 Sep 2021 14:36:09 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:d082:352a:f346:411a])
        by smtp.gmail.com with ESMTPSA id c68sm3167872pfc.150.2021.09.02.14.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 14:36:09 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-pm@vger.kernel.org, bleung@chromium.org,
        heikki.krogerus@linux.intel.com, badhri@google.com
Cc:     Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Date:   Thu,  2 Sep 2021 14:35:00 -0700
Message-Id: <20210902213500.3795948-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
In-Reply-To: <20210902213500.3795948-1-pmalani@chromium.org>
References: <20210902213500.3795948-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for reporting Source and Sink Capabilities
Power Data Object (PDO) property. These are reported by USB
Power Delivery (PD) capable power sources.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 Documentation/ABI/testing/sysfs-class-power | 30 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   | 18 ++++++++++++-
 include/linux/power_supply.h                |  5 ++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index ca830c6cd809..90d4198e6dfb 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -562,6 +562,36 @@ Description:
 			      "Unknown", "SDP", "DCP", "CDP", "ACA", "C", "PD",
 			      "PD_DRP", "PD_PPS", "BrickID"
 
+What:		/sys/class/power_supply/<supply_name>/source_cap_pdos
+Date:		September 2021
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the Source Capabilities Power Data Objects (PDO) reported by the USB
+		PD-capable power source. 13 PDOs are listed. PDOs 1-7 represent the Source Caps
+		for devices which only support Standard Power Range (SPR), whereas PDOs 8-13
+		are for Extended Power Range (EPR) capable sources.
+		NOTE: The EPR Source Caps message is a superset of the Source Cap message, so on
+		SPR-only sources, PDOs 8-13 will be 0.
+
+		Access: Read-Only
+
+		Valid values: Represented as a list of 13 32-bit PDO objects in hexadecimal format.
+
+What:		/sys/class/power_supply/<supply_name>/sink_cap_pdos
+Date:		September 2021
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the Sink Capabilities Power Data Objects (PDO) reported by the USB
+		PD-capable power source. 13 PDOs are listed. PDOs 1-7 represent the Sink Caps
+		for devices which only support Standard Power Range (SPR), whereas PDOs 8-13
+		are for Extended Power Range (EPR) capable sinks.
+		NOTE: The EPR Sink Caps message is a superset of the Sink Cap message, so on
+		SPR-only sinks, PDOs 8-13 will be 0.
+
+		Access: Read-Only
+
+		Valid values: Represented as a list of 13 32-bit PDO objects in hexadecimal format.
+
 **Device Specific Properties**
 
 What:		/sys/class/power/ds2760-battery.*/charge_now
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c3d7cbcd4fad..9d17d3376949 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -211,6 +211,9 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
+	/* Array properties */
+	POWER_SUPPLY_ATTR(SINK_CAP_PDOS),
+	POWER_SUPPLY_ATTR(SOURCE_CAP_PDOS),
 };
 
 static struct attribute *
@@ -267,7 +270,11 @@ static ssize_t power_supply_show_property(struct device *dev,
 	struct power_supply *psy = dev_get_drvdata(dev);
 	struct power_supply_attr *ps_attr = to_ps_attr(attr);
 	enum power_supply_property psp = dev_attr_psp(attr);
-	union power_supply_propval value;
+	union power_supply_propval value = {
+		.pdos = {0}
+	};
+	size_t count;
+	int i;
 
 	if (psp == POWER_SUPPLY_PROP_TYPE) {
 		value.intval = psy->desc->type;
@@ -299,6 +306,15 @@ static ssize_t power_supply_show_property(struct device *dev,
 	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
 		ret = sprintf(buf, "%s\n", value.strval);
 		break;
+	case POWER_SUPPLY_PROP_SINK_CAP_PDOS:
+	case POWER_SUPPLY_PROP_SOURCE_CAP_PDOS:
+		ret = 0;
+		for (i = 0; i < PDO_MAX_OBJECTS; i++) {
+			count = sprintf(buf, "0x%08x\n", value.pdos[i]);
+			buf += count;
+			ret += count;
+		}
+		break;
 	default:
 		ret = sprintf(buf, "%d\n", value.intval);
 	}
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 9ca1f120a211..a53c8fa4c1c9 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -17,6 +17,7 @@
 #include <linux/leds.h>
 #include <linux/spinlock.h>
 #include <linux/notifier.h>
+#include <linux/usb/pd.h>
 
 /*
  * All voltages, currents, charges, energies, time and temperatures in uV,
@@ -171,6 +172,9 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	/* Array properties */
+	POWER_SUPPLY_PROP_SINK_CAP_PDOS,
+	POWER_SUPPLY_PROP_SOURCE_CAP_PDOS,
 };
 
 enum power_supply_type {
@@ -209,6 +213,7 @@ enum power_supply_notifier_events {
 union power_supply_propval {
 	int intval;
 	const char *strval;
+	u32 pdos[PDO_MAX_OBJECTS];
 };
 
 struct device_node;
-- 
2.33.0.153.gba50c8fa24-goog

