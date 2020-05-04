Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F5E1C4846
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgEDUaH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgEDU3y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:29:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6919EC061A0F
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 13:29:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l25so350387pgc.5
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 13:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NGoGEZluL9u4F9w1PmP4MjWH3smmEpRPBbWdVZLsz/A=;
        b=O3MosuVnaI6D+D6YXn6EK5moNebiQic8es+rXg1x2adeORvhyH5pdgD827nCM3mLMb
         +PjX4NrwoppEzjj1uEkdkcr3lghf6CJh5BuKXsoz0c4ZTK+y7zTQHEF9tanGjYcmdzhe
         9Ji0aZ+2kzJJmKnTiN8rPSXLh9ZFecnHSl3IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NGoGEZluL9u4F9w1PmP4MjWH3smmEpRPBbWdVZLsz/A=;
        b=TUNfb8uwPy4Idpgkn2xXEWgveqxkXWCq2pupJTyir03fRhAibm/melJq+03BgANL6q
         FIMw1NDdOg6UTKPVHDBgueDduEt4OeWyQc1tVx5VSjZ5ZKYWa0/HEdGmWKmFOfkceinU
         FVUTpPo2Cwr6/xBxfu+w1hXjyddpvKibfBhW7xcNbosY5DPnj2wUJLL4fTCQDZ/lso/n
         yupbER0FQFaESfQuhWpySkg4+qulLn/WXpERbhdoXKACgwhrU5HZWczqMIakaTfhvxBo
         LYEOjAtNTglT/MaoWL7XDRghmqz46gohN0IwETMMOMLdVzyZovxivDpZRpEmIixSX18/
         iKGw==
X-Gm-Message-State: AGi0Pubbhua02zJios8sstLK3lS644vaGlpayxnJPywcQRheGC5Mozof
        cAIpbQwulKQD0N593c8gYR7llg==
X-Google-Smtp-Source: APiQypK6NciV1mEfRACpOr3wHUiQ+F0vbsxum6wURTgeC5ZhSq0PMukpVM/XV9PCSn4Qxpw55o4PGQ==
X-Received: by 2002:a63:af51:: with SMTP id s17mr3576pgo.305.1588624193892;
        Mon, 04 May 2020 13:29:53 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id z23sm9511737pfr.136.2020.05.04.13.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 13:29:53 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2 2/4] power_supply: Use designated initializer for property text arrays
Date:   Mon,  4 May 2020 14:29:28 -0600
Message-Id: <20200504202930.228453-3-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200504202930.228453-1-mathewk@chromium.org>
References: <20200504202930.228453-1-mathewk@chromium.org>
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
v2: - Fix array name change meant for next patch
---
 drivers/power/supply/power_supply_sysfs.c | 74 ++++++++++++++++++-----
 1 file changed, 60 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 69be80b321ea..fb4d41c49ae1 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -34,41 +34,87 @@ struct power_supply_attr {
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
 
 static const char * const power_supply_usb_type_text[] = {
-	"Unknown", "SDP", "DCP", "CDP", "ACA", "C",
-	"PD", "PD_DRP", "PD_PPS", "BrickID"
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
2.26.2.526.g744177e7f7-goog

