Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1B4227F8C
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 14:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgGUMBx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 08:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgGUMBw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 08:01:52 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E587C061794;
        Tue, 21 Jul 2020 05:01:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a23so9036023pfk.13;
        Tue, 21 Jul 2020 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oEglXBwLQOY/wf76maJo9jVEEGUkpTJTd012yFX+eg0=;
        b=M93GVHYgODBvzZ6OsEoST7K8Vo4PsgpytLq5IijV4GX/ytOt+55foab/vNz6G/Wph4
         hBvZwuxKhBoPJobqEbPOLsCL3tAMusM7jtCm2334uSscO4kUQYiXhvOpsHPBdi0vS929
         wXhx0QR23mvDTlVDLSnPdHroDi4xmDG4CkgxcuZ1oMi57aVdRdYToX7lPHqQVuekQDwU
         TedST1Idi3DQV+53t5mQrDnoI/YnwYFfApSSsljoG7ML+5me76/8NIUclvQGEOwzfUsC
         Zm24ikA4OC/gQ4ZfbJzQG8txPe0A4PVGhNPU+B/bMrideU8vRH3+RmeojyntHOtoZ5TR
         wdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oEglXBwLQOY/wf76maJo9jVEEGUkpTJTd012yFX+eg0=;
        b=Nd1oHFVXeZUl2cMlgjlxIaePApVP8vHz1vVztNZ25ZbWWH9j1eItzpHpdnX7RWFZ/b
         oaQfJ0tpV7GkUJSz3QMuzV8AzQjqEWShxSJAvv9WRqPI5cEZABX3qlpYbE5cuGIFnuwW
         U5+z3aEA+gcbt1focApsk0BuIjjy7xV8ggGynR1fIDxDT57m1iSi31BvSpjXiyaYOmS4
         DfjaAPOfnx7p/zDmarg8ilJDmeHJfYBr2mLpCh9uHxCBcpHpIaPqpwjN/Tpk2nPxHNY2
         owMazb3nvKK3fwTrji/x6Vp7Ot2QKT2OIdEAW6BDfkdezEr7C3oVgujt81Ft48SwCeZh
         j6Dw==
X-Gm-Message-State: AOAM531zpRrPXdZJHT4Mb/1hj17YFOYYxk5xGRD+KBp8N++uPZJ9x/vv
        ooMLZwH1O3ckuO0nnMDJKt8=
X-Google-Smtp-Source: ABdhPJwhd8FAY4dTr5BP042o+pM5c5980Kvldx9qTmjs67yETd0ZLorjDJ5Lj9M7OCDDfbR7xiOUJw==
X-Received: by 2002:a62:8608:: with SMTP id x8mr22783017pfd.96.1595332911873;
        Tue, 21 Jul 2020 05:01:51 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id t73sm20542041pfc.78.2020.07.21.05.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 05:01:51 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v7 1/4] power: supply: core: add quick charge type property
Date:   Tue, 21 Jul 2020 19:59:39 +0800
Message-Id: <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595332392.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595332392.git.huangqiwu@xiaomi.com>
References: <cover.1595332392.git.huangqiwu@xiaomi.com>
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

