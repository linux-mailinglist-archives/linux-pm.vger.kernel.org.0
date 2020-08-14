Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168FB2443F9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 05:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgHNDtP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 23:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHNDtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 23:49:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465DEC061757;
        Thu, 13 Aug 2020 20:49:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v5so1420905plo.4;
        Thu, 13 Aug 2020 20:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ricGGIi0rSFfCMhWo07vOBDDcXPDfivbO4AsrdYg3Sk=;
        b=fxXpTUDfPU6zUvUa9bNeaMMx5lIsisqOZqNETLYlIT3zsGtLIPsJZtBgfPsHPJwmUq
         nKAx7vKcUN4dvtyfDEgppsnNrnjir6nGGGp639h/9lNzop6n+IEwvE1b5RaQ5qkegeBF
         DLX3H091XsbaqVLGyQXEecZEAlFL5azLBs0wuoG8XJRGzDd8avXyQ+4HkbFAfDznebxs
         mymSDccCpUxB+1zG2QVesh2sFWoT5DvPegkDHDYcO6aiN6IG3I9LZuspt4xrlukKqpeu
         bKtFtAY0BNptXA4BtKNrtVRSLXlHN/Q7NPxIpy426ShyE8bQ9Ly9uZRe6K8OfkVAqBu8
         76kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ricGGIi0rSFfCMhWo07vOBDDcXPDfivbO4AsrdYg3Sk=;
        b=V2Q/dy85vewM7s89KBdVE9CnqCZUb1XNqRfaYbQwW/yef10tVb6QVJLJO4R5DZZhWc
         tFrBT/VhJnGKdRmmPJ+WRi+3murez79YdRxeJS1qp7RyW2s7ENDFgD3aUAMCscjJdZJa
         isH6Z013UtYoY1072hLiL2Mdflr9gW54LqN58g2Joo53jX6UXFOVNtzymTvnuin4+U2N
         beHgUUBjuZuDf4h/fyxeUzBNcT6+7e7YgA/Md0yJr5mnJovUchiSNPE4a3LhODQyZhpq
         yRBy+zGi8/ykuYPbWw0evqztVyu3WqBpYK12nQ3OW00NJ9Pfju8m1L1HbIBjTKNUUIIV
         TPgA==
X-Gm-Message-State: AOAM531xr5ca7XFO7b6B/0GmzuJvGxK6dpYrgLUfDSOFqvM+enyJl16j
        hZL3fRDQurWCk6M1ywZILUM=
X-Google-Smtp-Source: ABdhPJwPqUeyIYBIfykWcAiFmJqn55tlU+d6Xmz8Ykh3DJZTE4lhEKT3acbhNMn1ic4q1MdTk9ME3Q==
X-Received: by 2002:a17:90b:f09:: with SMTP id br9mr692763pjb.11.1597376954711;
        Thu, 13 Aug 2020 20:49:14 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id n26sm7253385pff.30.2020.08.13.20.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 20:49:14 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v8 2/4] power: supply: core: add wireless charger adapter type property
Date:   Fri, 14 Aug 2020 11:46:55 +0800
Message-Id: <07b666877e4eb64d1a431e56146b9a9e2d61b7f7.1597376585.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597376585.git.huangqiwu@xiaomi.com>
References: <cover.1597376585.git.huangqiwu@xiaomi.com>
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
index bd99658c05be..00254e096a4a 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -168,6 +168,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_TX_ADAPTER,
 };
 
 enum power_supply_type {
@@ -211,6 +212,24 @@ enum power_supply_quick_charge_type {
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
2.28.0

