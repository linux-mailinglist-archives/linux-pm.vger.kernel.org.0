Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF76227E9A
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 13:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgGULRw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 07:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgGULRv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 07:17:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8979EC0619D8;
        Tue, 21 Jul 2020 04:17:51 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id m9so10586260pfh.0;
        Tue, 21 Jul 2020 04:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rQMYS8GPViemdBCwGtXgr4XomnsVhh0epuBKtBNluTw=;
        b=TempFeZf63Hh1FjzFjgHHqFZRxHanBnEsiKRIma4VziM56cpXiabH8YDi5dJlaRNfC
         FNB8lLuIh3c81Gvw2TWWm9J/36mxnmEi3HTwlbtkX/HX+yavpEpP1RpdWOtN/bwLcz+m
         /7qZpwW+PiFLay98CosJXn4tq7LaYtDNoIV2nu2NfCXJ9QvQk87/pZFvCJAcoicQAi/q
         05sval9AgtUWuS0jAfDZXN8A6b+nV2j9XzDiu4KtS/Cq50EODjkiwZ4F24ZiVjUfQAFG
         /wBzJBS7S8Byw0baos88NQuf7OwqUmOXktO6bL8Xvg0VqoJRPqTPOEhunARKQyoIEIpG
         zjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rQMYS8GPViemdBCwGtXgr4XomnsVhh0epuBKtBNluTw=;
        b=a06cP0BKZ81h1ZRrXX0Ycc3WTGhsXIQsfEqP8hvvW01AKRhXlOXXa6BQMdIEeELcpY
         ZLfRY4eREWvm32CMUJKLebbUO8IaP7KdNJ5MJ6cacAtd131PvFv+bfokchgcjo/HoLfG
         B3enPLqv9p/w/0dIToVhD5Jlc3vCjvcMijCBp8fPEhZjaacg9k6wX+TsQchgbxglmyNa
         ebzx/jBdJ9VFUlCs5ShlZOVXKgK9eawIqOaSOrEVZ7FJzowL98k/DOKu8Nni03J9Wwxw
         TJsu/CByPQ7GoHUNQ9ZSbMxBFHPGmapG4ZEOVLohrDoy91XXjKo6i5zhNhb/+/xy6EDi
         HIpw==
X-Gm-Message-State: AOAM533K5ddgwRnEmIT+z9Rz5g7d6Jm8gLi1LPcdC2EocW8+wmsDuKV6
        UnKXxFflNyvT/gumuk5jP4hUeqxhZqBUVg==
X-Google-Smtp-Source: ABdhPJx+J75BWvzZXIktP1WO7JRig+l5RkxSGFTVzw96so5cdMQvZHP1fYIjv2ZOUNx7gMU83FM18Q==
X-Received: by 2002:a63:5821:: with SMTP id m33mr22721077pgb.43.1595330271042;
        Tue, 21 Jul 2020 04:17:51 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id f72sm19829566pfa.66.2020.07.21.04.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 04:17:50 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v6 2/4] power: supply: core: add wireless charger adapter type property
Date:   Tue, 21 Jul 2020 19:15:37 +0800
Message-Id: <8a46e20d48d34f898b26cccfee562735894b08ae.1595329640.git.huangqiwu@xiaomi.com>
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

