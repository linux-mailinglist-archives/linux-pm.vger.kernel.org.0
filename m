Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A088422015A
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 02:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgGOAhe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 20:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgGOAhc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 20:37:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29961C061755;
        Tue, 14 Jul 2020 17:37:32 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id cm21so697039pjb.3;
        Tue, 14 Jul 2020 17:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0d8lgGWp3yT9RktjxMAvaiqBLoWz3hFyt3U4v25jxeA=;
        b=sS8jnJufruUkvnsojmPjKIRSOHh7VIVZ7zbND0Y3TAZWO/tul0vNDtJjFlXMf2NuNl
         PyOl63gKpchRxR/DGPMK+8bCepYSz83F6w3IZ+kRcrc+wDkrvYDJc9L18fwUfJ4R3sel
         IhU1bIRPXPeTySu5ja2yaMlkHcePst+YLBw43kEPt5wpi/h5oIEn6dJvV5/2Yc36BEV/
         EA2VNNojBUnhuSDObVJ0ITq+0DUMGVsFZJFNNzGeZB8ZzJmEv1R8v0ZlMSWUu9xGgU/P
         4ZgeAIe+EWGK0j2gFy1hDFDSBI9on9kx8viuw0llZFETth6Gdncn31DDnR3EJmMcdOtR
         pPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0d8lgGWp3yT9RktjxMAvaiqBLoWz3hFyt3U4v25jxeA=;
        b=c5Bnzk1OfhxcuUClM84E7cdC7+Qx3bQD3IYneDefIkJHZRtHPuGEA5JjUd+2yqhald
         cr2mBX6Eg3ObOwotsNNXy+XSKyDqPSNI1TZbAFfr+oeUDOPER0nmj2TLSR8+0YN8bTa/
         2y+Ul20buqBdMYYlfOMDEmOESRBHN6lEVGHif2teHsD81D7AnoNAWLXX0j/oTt5iSRBu
         NlIZPYTDyrFJke+zAaAThFxShlEDkyJJeGsgQPKX6PjqyddHlx6iMUHdpnGrwqnU9lIu
         in46+vJnXe0cKAREdtrgMR67u7pJbxBIS4DQyzlwhaoYtqfbqQDDmeTqIBRpOcR1KSCJ
         XioA==
X-Gm-Message-State: AOAM531AxogsktbAtfpoeDegNIdqK2/3FY9FURn8NB0YDAtMRPnt7GMp
        PvKvhG3P4urgN0LUDCvY9fI=
X-Google-Smtp-Source: ABdhPJyhy0IZNy2r60ubEp+cU+tNGhJpKg1e8Xtbaa0LZXxBASDuTA64k4DDn+q/FKE1JmsOrx0NYQ==
X-Received: by 2002:a17:90b:4b12:: with SMTP id lx18mr7855878pjb.156.1594773451627;
        Tue, 14 Jul 2020 17:37:31 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id t126sm266156pfd.214.2020.07.14.17.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 17:37:31 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v3 1/5] power: supply: core: add quick charge type property
Date:   Wed, 15 Jul 2020 08:35:19 +0800
Message-Id: <40809c9b859c086ba6aec56b24402d41c60d6e71.1594726859.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594726859.git.huangqiwu@xiaomi.com>
References: <cover.1594726859.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Reports the kind of quick charge type based on
different adapter power. UI will show different
animation effect for different quick charge type.

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

