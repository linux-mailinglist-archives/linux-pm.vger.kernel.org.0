Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDAF227E93
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 13:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgGULRw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 07:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgGULRt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 07:17:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4134DC061794;
        Tue, 21 Jul 2020 04:17:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u5so10578944pfn.7;
        Tue, 21 Jul 2020 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oEglXBwLQOY/wf76maJo9jVEEGUkpTJTd012yFX+eg0=;
        b=eQEcb0DlSutfs/x54NKruHBcmUgGN6eiLv1FT9CCcewYN67Lzfn79XkMbtizfdcXKQ
         HgBBQ5zdJvo1jjeuRKujKhbNNhgta8mQGTKz+PjfpZkZYmcwMdQPSgOznKErnNn+VGhN
         sTyAhUpEqBF0J68wJSFPdbT5fG8km6ffHmr4Iez77sN7VWc0PlgWF5StVbTz6g/aOjqN
         MhUcX3v9MdrzLNja8K7FmRC4QKVS+irGXTVYqUCA1ePELWio6HMSovtatYv5vNwBGEY5
         imyxa3WuNHKspJLvz5NbLFj/3hAFCXsNaf9mt51JG6P/e7E2h0QVQEWTwwvry6sfDxrV
         GGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oEglXBwLQOY/wf76maJo9jVEEGUkpTJTd012yFX+eg0=;
        b=pT3oq7lact3GaW4LAIt5xTatxYu6RnvOjAtCFFx+2iezCtFN9IIWEetCOZynBlwoW5
         OsZxwndXV7C5bE1JpG1/3BxxLbr096n22G1XJhQ0ZLMn+NOct+Gp4xKn7cnYCJuoW/3R
         CEHSMV+kdbtmXAEqGyDr+vCgrNPu1JUh9cN1QsDiRE+/O8MbWohObrKuVBsQ8CWYYV0j
         UKh9Gv/Vuo7Uwb56hiz6anMUlHqa7UwJJ3rdnRj/Pvqv2spgQ1y0YORn3HQGfTezWxJZ
         smjDOc85jlT7YEPMaOpV+vCwUaRGKvtfOT59382Bc2dNVhtmDNPvTa4D/4zCtj7BFyTG
         p4tA==
X-Gm-Message-State: AOAM533HZ9Vie4o123ZcQviml0UlN1iaWmvI1cxLTxy9CmCpyQYX5DP7
        iIsf4nBUrNbB5OP7RuDNqSA=
X-Google-Smtp-Source: ABdhPJynYtaBeDQE5nq3mZYndVR3CbMhBrzTcaw3JP8v9Oz1OogSSSEN48kLJYaC2eSSY/A0bQxC0A==
X-Received: by 2002:a63:b511:: with SMTP id y17mr21869900pge.425.1595330268751;
        Tue, 21 Jul 2020 04:17:48 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id f72sm19829566pfa.66.2020.07.21.04.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 04:17:48 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v6 1/4] power: supply: core: add quick charge type property
Date:   Tue, 21 Jul 2020 19:15:36 +0800
Message-Id: <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595329640.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595329640.git.huangqiwu@xiaomi.com>
References: <cover.1595329640.git.huangqiwu@xiaomi.com>
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

