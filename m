Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B827D227876
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 08:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgGUGBy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 02:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbgGUGBv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 02:01:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623C0C061794;
        Mon, 20 Jul 2020 23:01:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k1so1032482pjt.5;
        Mon, 20 Jul 2020 23:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rQMYS8GPViemdBCwGtXgr4XomnsVhh0epuBKtBNluTw=;
        b=mAsbyeX7wSZFEEDpALXdqbF7aE/LjLH76jv7r9R4lEC7hx6c6SAz8HNu1mZknxGd2I
         lYhF4IXdkG1N0OwgAK4Q1MPeoW90zFCCjBvGQ5OC9jMUecD8hI5sUwZvSYEw4zvJx5sc
         peFvt2kztyZPIZCZbgcpE2DwfygLv+Qb9Ov4H4xy78xS4ubHarfWXLRQ+44iFq5NW7pn
         tUMf11nmWP+giQVDUoJjQXkdZkAMicgQ1/y/36utGZPEJYRNhByvu39rufLCElAQT5qD
         kbKXfVqAJXjpKCmZpW/+GxKNB9BvhYvWHstsqRRx35+PUDY8EPebnul37+P5ySIKciRi
         /Xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rQMYS8GPViemdBCwGtXgr4XomnsVhh0epuBKtBNluTw=;
        b=oMINJuQTBMh9RxgYxU7/zgx0v7TOpBjWaHjXmU4BYwFaX+orecWDiAfOCp5Qi5YYf8
         G5iknJQvgZiTdJW+GWhse4J7/ugZV9B3Jjb26Lg7psdKl3DqIUsTnyp38icnCidQqS02
         jTCNOpqnvzLSdXn8CEi5rNDUeYyPz3qr69Vr8fb7uhni66jkD5HIAqzCEfebSbEjW9W6
         6Dq69BdQ0/+sh6++P76BVOtsRHtn81uvebgFnkUUC3uw6Fn03yHI74uhe2ESHEHTSZmb
         R2XXGvLW8zyW8+pwiwW5QXRzdSNR5mp4xVp37IEJOfKUU3fc9FGwI+5GXvkZfH3n3pTW
         RTNw==
X-Gm-Message-State: AOAM5326/3NqSvxMryykUPEyKVIx5geysULI77CBSXJuqt8IxWXs1qCi
        +MDyRm5x19btR4g1KbU4UtI=
X-Google-Smtp-Source: ABdhPJytjc7xmWperLQfdm4u248x9Y6qlMbR6ykQJXFEjggKel7ml3QRtZ5v0j4ejGZBiavtbGM8AQ==
X-Received: by 2002:a17:902:bc43:: with SMTP id t3mr19389983plz.276.1595311310929;
        Mon, 20 Jul 2020 23:01:50 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id 129sm18368833pfv.161.2020.07.20.23.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 23:01:50 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v5 2/4] power: supply: core: add wireless charger adapter type property
Date:   Tue, 21 Jul 2020 13:59:35 +0800
Message-Id: <8a46e20d48d34f898b26cccfee562735894b08ae.1595301250.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595301250.git.huangqiwu@xiaomi.com>
References: <cover.1595301250.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Reports what type of wireless adapter connection is
currently active for the supply.
for example it can show if ADAPTER_PD capable source is attached.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 28 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                | 19 ++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index dd3773dcf16a..03ab449fae8a 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -729,3 +729,31 @@ Contact:	Fei Jiang <jiangfei1@xiaomi.com>
 			3: QUICK_CHARGE_TURBE,
 			4: QUICK_CHARGE_SUPER.
 
+===== Wireless Charger Properties =====
+What:		/sys/class/power_supply/<supply_name>/tx_adapter
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		Reports the type of wireless adapter connection is currently active for
+		the supply, for example it can show if ADAPTER_PD capable source
+		is attached. Expect common wireless adapter type, also increase by
+		some vendor private adapter type(ex. ADAPTER_PD_40W).
+
+		Access: Read-Only
+		Valid values:
+			0: ADAPTER_NONE,
+			1: ADAPTER_SDP,
+			2: ADAPTER_DCP,
+			3: ADAPTER_CDP,
+			4: ADAPTER_OCP,
+			5: ADAPTER_QC2,
+			6: ADAPTER_QC3,
+			7: ADAPTER_PD,
+			8: ADAPTER_AUTH_FAILED,
+			9: ADAPTER_PRIVATE_QC3,
+			10: ADAPTER_PRIVATE_PD,
+			11: ADAPTER_CAR_POWER,
+			12: ADAPTER_PRIVATE_PD_40W,
+			13: ADAPTER_VOICE_BOX,
+			14: ADAPTER_PRIVATE_PD_50W.
+
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 9554d7907373..f2458e21d02b 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -207,6 +207,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(MANUFACTURER),
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
 	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
+	POWER_SUPPLY_ATTR(TX_ADAPTER),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index f35c661a2544..0bbdec1630a4 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -168,6 +168,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_TX_ADAPTER,
 };
 
 enum power_supply_type {
@@ -207,6 +208,24 @@ enum power_supply_quick_charge_type {
 	QUICK_CHARGE_MAX,
 };
 
+enum power_supply_tx_adapter_type {
+	ADAPTER_NONE = 0,			/* Nothing Attached */
+	ADAPTER_SDP,				/* Standard Downstream Port */
+	ADAPTER_CDP,				/* Charging Downstream Port */
+	ADAPTER_DCP,				/* Dedicated Charging Port */
+	ADAPTER_OCP,				/* Other Charging Port */
+	ADAPTER_QC2,				/* Qualcomm Charge 2.0 */
+	ADAPTER_QC3,				/* Qualcomm Charge 3.0 */
+	ADAPTER_PD,				/* Power Delivery Port */
+	ADAPTER_AUTH_FAILED,			/* Authenticated Failed Adapter */
+	ADAPTER_PRIVATE_QC3,			/* Qualcomm Charge 3.0 with Private Protocol */
+	ADAPTER_PRIVATE_PD,			/* PD Adapter with Private Protocol */
+	ADAPTER_CAR_POWER,			/* Wireless Car Charger */
+	ADAPTER_PRIVATE_PD_40W,			/* 40W PD Adapter with Private Protocol */
+	ADAPTER_VOICE_BOX,			/* Voice Box which Support Wireless Charger */
+	ADAPTER_PRIVATE_PD_50W,			/* 50W PD Adapter with Private Protocol */
+};
+
 enum power_supply_notifier_events {
 	PSY_EVENT_PROP_CHANGED,
 };
-- 
2.27.0

