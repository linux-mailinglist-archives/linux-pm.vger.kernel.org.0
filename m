Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE89E1B7CE8
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 19:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgDXRfs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 13:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728818AbgDXRfp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 13:35:45 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0461C09B049
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 10:35:45 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t11so4949309pgg.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cFdinK0bIeMjw6G5Ftqw2WLK1bNAspn5nTVpMRhWZIM=;
        b=M1jkEg4kOy8yV1ckus6IEX7DZqAhobGdebVkPPpIAci1QE4gXilcm3TfHrBm7A2FG9
         26O9qjJYlkmhV0EQsF4LwIhx8C0ao4mBEU7FzsIWdxROM2a6sggDML7Y4Y5UnNYUk3BX
         3eR1c9bfDbCqcoojEvU+jo9MvkR3Me3Kd8lHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cFdinK0bIeMjw6G5Ftqw2WLK1bNAspn5nTVpMRhWZIM=;
        b=bsvqXI+2zOnHixRz+Tzbv8rtaEj5QUzFgVg/QaZfsrAQgbypbTAx8ZwY7rfQCrNwc+
         YxoGVCY1gjDV/qoHi16JIYaoT+aHoeQ7WHDj0twoXJ7BaJhezU6/8/F790Qem6rJ+sTc
         x+dYZA+2AhgfsPjc+c9fH2KaKUfDLvgaiERqQ+558WWS8PHLUXsuSPNl0Ru8hiz78d1Q
         KX/21Sswt4aYooXRwmAPXWA2YQ4PBkofjm3A0LougW2qNFlAQ/z23sm040UbR/csrvT9
         E9NcJVh9JMIh6XDDqIwCeERh9Ae+IhhERKs3qs8izQuFXxN/XG+ds8wihCddyARStS0b
         P7oA==
X-Gm-Message-State: AGi0PualSLuI+eGRtMd9hfBB+64DSiTa7aClRVC2WTBvsbzHjTuFPKVp
        /yhU+6c2tlssorhKOjVZJAGlsQ==
X-Google-Smtp-Source: APiQypLoD+57iy0GydjhQe/E63j+X7j2O8bgsrt2L26+pJ6MbJgTpQh9zRv6MVp3plIp6FDQB+nVCA==
X-Received: by 2002:a63:7ce:: with SMTP id 197mr1571914pgh.113.1587749745294;
        Fri, 24 Apr 2020 10:35:45 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id t188sm5360641pgc.3.2020.04.24.10.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:35:44 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 2/4] power_supply: Use designated initializer for property text arrays
Date:   Fri, 24 Apr 2020 11:35:31 -0600
Message-Id: <20200424173533.48572-3-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200424173533.48572-1-mathewk@chromium.org>
References: <20200424173533.48572-1-mathewk@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use designated initializers for the sysfs power supply text values. This
will help ensure that the text values are kept in sync with the enum
values from power_supply.h.

Signed-off-by: Mathew King <mathewk@chromium.org>
---
 drivers/power/supply/power_supply_sysfs.c | 76 ++++++++++++++++++-----
 1 file changed, 61 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index b579081599d7..328107589770 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -35,41 +35,87 @@ struct power_supply_attr {
 }
 
 static const char * const power_supply_type_text[] = {
-	"Unknown", "Battery", "UPS", "Mains", "USB",
-	"USB_DCP", "USB_CDP", "USB_ACA", "USB_C",
-	"USB_PD", "USB_PD_DRP", "BrickID"
+	[POWER_SUPPLY_TYPE_UNKNOWN]		= "Unknown",
+	[POWER_SUPPLY_TYPE_BATTERY]		= "Battery",
+	[POWER_SUPPLY_TYPE_UPS]			= "UPS",
+	[POWER_SUPPLY_TYPE_MAINS]		= "Mains",
+	[POWER_SUPPLY_TYPE_USB]			= "USB",
+	[POWER_SUPPLY_TYPE_USB_DCP]		= "USB_DCP",
+	[POWER_SUPPLY_TYPE_USB_CDP]		= "USB_CDP",
+	[POWER_SUPPLY_TYPE_USB_ACA]		= "USB_ACA",
+	[POWER_SUPPLY_TYPE_USB_TYPE_C]		= "USB_C",
+	[POWER_SUPPLY_TYPE_USB_PD]		= "USB_PD",
+	[POWER_SUPPLY_TYPE_USB_PD_DRP]		= "USB_PD_DRP",
+	[POWER_SUPPLY_TYPE_APPLE_BRICK_ID]	= "BrickID",
 };
 
-static const char * const power_supply_usb_type_text[] = {
-	"Unknown", "SDP", "DCP", "CDP", "ACA", "C",
-	"PD", "PD_DRP", "PD_PPS", "BrickID"
+static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] = {
+	[POWER_SUPPLY_USB_TYPE_UNKNOWN]		= "Unknown",
+	[POWER_SUPPLY_USB_TYPE_SDP]		= "SDP",
+	[POWER_SUPPLY_USB_TYPE_DCP]		= "DCP",
+	[POWER_SUPPLY_USB_TYPE_CDP]		= "CDP",
+	[POWER_SUPPLY_USB_TYPE_ACA]		= "ACA",
+	[POWER_SUPPLY_USB_TYPE_C]		= "C",
+	[POWER_SUPPLY_USB_TYPE_PD]		= "PD",
+	[POWER_SUPPLY_USB_TYPE_PD_DRP]		= "PD_DRP",
+	[POWER_SUPPLY_USB_TYPE_PD_PPS]		= "PD_PPS",
+	[POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID]	= "BrickID",
 };
 
 static const char * const power_supply_status_text[] = {
-	"Unknown", "Charging", "Discharging", "Not charging", "Full"
+	[POWER_SUPPLY_STATUS_UNKNOWN]		= "Unknown",
+	[POWER_SUPPLY_STATUS_CHARGING]		= "Charging",
+	[POWER_SUPPLY_STATUS_DISCHARGING]	= "Discharging",
+	[POWER_SUPPLY_STATUS_NOT_CHARGING]	= "Not charging",
+	[POWER_SUPPLY_STATUS_FULL]		= "Full",
 };
 
 static const char * const power_supply_charge_type_text[] = {
-	"Unknown", "N/A", "Trickle", "Fast", "Standard", "Adaptive", "Custom"
+	[POWER_SUPPLY_CHARGE_TYPE_UNKNOWN]	= "Unknown",
+	[POWER_SUPPLY_CHARGE_TYPE_NONE]		= "N/A",
+	[POWER_SUPPLY_CHARGE_TYPE_TRICKLE]	= "Trickle",
+	[POWER_SUPPLY_CHARGE_TYPE_FAST]		= "Fast",
+	[POWER_SUPPLY_CHARGE_TYPE_STANDARD]	= "Standard",
+	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	= "Adaptive",
+	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	= "Custom",
 };
 
 static const char * const power_supply_health_text[] = {
-	"Unknown", "Good", "Overheat", "Dead", "Over voltage",
-	"Unspecified failure", "Cold", "Watchdog timer expire",
-	"Safety timer expire", "Over current"
+	[POWER_SUPPLY_HEALTH_UNKNOWN]		    = "Unknown",
+	[POWER_SUPPLY_HEALTH_GOOD]		    = "Good",
+	[POWER_SUPPLY_HEALTH_OVERHEAT]		    = "Overheat",
+	[POWER_SUPPLY_HEALTH_DEAD]		    = "Dead",
+	[POWER_SUPPLY_HEALTH_OVERVOLTAGE]	    = "Over voltage",
+	[POWER_SUPPLY_HEALTH_UNSPEC_FAILURE]	    = "Unspecified failure",
+	[POWER_SUPPLY_HEALTH_COLD]		    = "Cold",
+	[POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE] = "Watchdog timer expire",
+	[POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE]   = "Safety timer expire",
+	[POWER_SUPPLY_HEALTH_OVERCURRENT]	    = "Over current",
 };
 
 static const char * const power_supply_technology_text[] = {
-	"Unknown", "NiMH", "Li-ion", "Li-poly", "LiFe", "NiCd",
-	"LiMn"
+	[POWER_SUPPLY_TECHNOLOGY_UNKNOWN]	= "Unknown",
+	[POWER_SUPPLY_TECHNOLOGY_NiMH]		= "NiMH",
+	[POWER_SUPPLY_TECHNOLOGY_LION]		= "Li-ion",
+	[POWER_SUPPLY_TECHNOLOGY_LIPO]		= "Li-poly",
+	[POWER_SUPPLY_TECHNOLOGY_LiFe]		= "LiFe",
+	[POWER_SUPPLY_TECHNOLOGY_NiCd]		= "NiCd",
+	[POWER_SUPPLY_TECHNOLOGY_LiMn]		= "LiMn",
 };
 
 static const char * const power_supply_capacity_level_text[] = {
-	"Unknown", "Critical", "Low", "Normal", "High", "Full"
+	[POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN]	= "Unknown",
+	[POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL]	= "Critical",
+	[POWER_SUPPLY_CAPACITY_LEVEL_LOW]	= "Low",
+	[POWER_SUPPLY_CAPACITY_LEVEL_NORMAL]	= "Normal",
+	[POWER_SUPPLY_CAPACITY_LEVEL_HIGH]	= "High",
+	[POWER_SUPPLY_CAPACITY_LEVEL_FULL]	= "Full",
 };
 
 static const char * const power_supply_scope_text[] = {
-	"Unknown", "System", "Device"
+	[POWER_SUPPLY_SCOPE_UNKNOWN]	= "Unknown",
+	[POWER_SUPPLY_SCOPE_SYSTEM]	= "System",
+	[POWER_SUPPLY_SCOPE_DEVICE]	= "Device",
 };
 
 static struct power_supply_attr power_supply_attrs[] = {
-- 
2.26.2.303.gf8c07b1a785-goog

