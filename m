Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B679225734
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jul 2020 07:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgGTFta (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 01:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGTFt1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 01:49:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE465C0619D2;
        Sun, 19 Jul 2020 22:49:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k4so8156897pld.12;
        Sun, 19 Jul 2020 22:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oEglXBwLQOY/wf76maJo9jVEEGUkpTJTd012yFX+eg0=;
        b=pqZV2eUuh5vcC1RkeQvfQiB1VqeVHvu5gSMbA7uZ09/wX+7k0aFSkHzFC1cEReoBJz
         icni4Y5Xp2g8TXkbaPvzqFBv7EB1YiIZzrdodMs7XFs3n4L7oUeUyLbGEDggDkUwdf7l
         bUoxgQm3HCGF3eNM64dOk8jAZEOOYFa6tTKSb4aLnxfOVpLNc4iR/ClctBhRMNiU+9A3
         35mAXIkjQ6l0AsCI7YjXZP9PH3z/DUwSRk14PoxY9z0FVUlCYlf2uqmzjEM7QR2MDgd0
         38D1R3bqGc3miYTXmNThBf5owbcUNxozk1B6aRFPe8322ElYoctyAN3bj5LEWzQe3SkR
         BMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oEglXBwLQOY/wf76maJo9jVEEGUkpTJTd012yFX+eg0=;
        b=iEQP1Bq9qDnWXHdkLyc/Z6JfbDAILe7COXgw2c0LAXw95BErglALSRSlWbm1ZU6Xwt
         AviGjh7JT97O/5P5UsBHPmxSlWn5IoOVZOmEJ44DNMu+XghHUtCL7rueh/zWskEoWt0o
         Z9uSUFmE1BHmE/rYD3BJfQ+ovLXfZW8TdOXSNmdBWPEA6K/AzaBoovWemZ38gm7FtabK
         8+CebEuCpetinHn/tZ9cu4gNgVEr4DRcIFlFPCDhcoARKDt6A1fxiJ9R9WQtnjnpga/2
         mO0xanZUqKAZgXmkyGmH/WfWDyoQTlFJq/3XjreQoPlN5IICNHs8oFqJjWrYi5/mZyvJ
         /h6g==
X-Gm-Message-State: AOAM532wvB+uDuTcebhA1iF65YFWmmK5teCCT2RbOQrmOoRt8CSTJNfO
        Oj/3lmQeVF65qZ9Qh3fuyTc=
X-Google-Smtp-Source: ABdhPJyx5niyeIa+kfN9szZmYrvL/wJxKdqjb08QCgQhXIKqH1CPfd/9HLPuU5bkP8u7HjghBNRQfg==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr20241211pjx.169.1595224167265;
        Sun, 19 Jul 2020 22:49:27 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id i7sm13627833pgh.58.2020.07.19.22.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 22:49:26 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v4 1/4] power: supply: core: add quick charge type property
Date:   Mon, 20 Jul 2020 13:47:14 +0800
Message-Id: <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595214246.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595214246.git.huangqiwu@xiaomi.com>
References: <cover.1595214246.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Reports the kind of quick charge type based on
different adapter power.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 21 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                | 10 ++++++++++
 3 files changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 216d61a22f1e..dd3773dcf16a 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -708,3 +708,24 @@ Description:
 
 		Access: Read
 		Valid values: 1-31
+
+What:		/sys/class/power_supply/<supply_name>/quick_charge_type
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+		Description:
+		Reports the kind of quick charge type based on different adapter power.
+		Different quick charge type represent different charging power.
+		QUICK_CHARGE_NORMAL : Charging Power <= 10W
+		QUICK_CHARGE_FAST : 10W < Charging Power <= 20W
+		QUICK_CHARGE_FLASH : 20W < Charging Power <= 30W
+		QUICK_CHARGE_TURBE : 30W < Charging Power <= 50W
+		QUICK_CHARGE_SUPER : Charging Power > 50W
+
+		Access: Read-Only
+		Valid values:
+			0: QUICK_CHARGE_NORMAL,
+			1: QUICK_CHARGE_FAST,
+			2: QUICK_CHARGE_FLASH,
+			3: QUICK_CHARGE_TURBE,
+			4: QUICK_CHARGE_SUPER.
+
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index bc79560229b5..9554d7907373 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -206,6 +206,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
+	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index ac1345a48ad0..f35c661a2544 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -167,6 +167,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 };
 
 enum power_supply_type {
@@ -197,6 +198,15 @@ enum power_supply_usb_type {
 	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 };
 
+enum power_supply_quick_charge_type {
+	QUICK_CHARGE_NORMAL = 0,		/* Charging Power <= 10W */
+	QUICK_CHARGE_FAST,			/* 10W < Charging Power <= 20W */
+	QUICK_CHARGE_FLASH,			/* 20W < Charging Power <= 30W */
+	QUICK_CHARGE_TURBE,			/* 30W < Charging Power <= 50W */
+	QUICK_CHARGE_SUPER,			/* Charging Power > 50W */
+	QUICK_CHARGE_MAX,
+};
+
 enum power_supply_notifier_events {
 	PSY_EVENT_PROP_CHANGED,
 };
-- 
2.27.0

