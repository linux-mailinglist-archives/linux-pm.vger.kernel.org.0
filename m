Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904C43DFFD1
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 13:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbhHDLEN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 07:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237821AbhHDLEL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 07:04:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8967C0613D5;
        Wed,  4 Aug 2021 04:03:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b1-20020a17090a8001b029017700de3903so5424652pjn.1;
        Wed, 04 Aug 2021 04:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2HCYsp3V1C0S5jgoA//TBG3tZQ9KgtlQdV6PXheIk70=;
        b=f+WL5NZhzStujLqiMkkIwb9xaCW0DPxRQnEKb4pPgfyfM4cHWtWCe+IRqSPOYHwmCv
         CI3tHl9i0XsiaeFM4yVM2KYk4LDQe3Avg/imsS96pxjHUjeOIfm7mMrSO500bcszaVWa
         wvqqLC/wYewkmJt0NAvOSG8O0vxAkn1vmQa0Ek48A4MSaVbV599vBdc3kJUn5VdNRCVx
         MXC5O3Mj88GeiHAVzXZCemfEVgAsMcSBPVWHxxqk5LoEiiI+Yl9Q4BRM+vItauaC5L88
         LRWMXGa/4bvq/yTSZqRPqccLv7zm3IHiSCxQ9zlYLpRltk5ynFAAdzynnQmiLK5zTEil
         gtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2HCYsp3V1C0S5jgoA//TBG3tZQ9KgtlQdV6PXheIk70=;
        b=VzoNlOB1Fs1ujy89A08HXb6DsBgFD3ekF/kFcn1DAT6Lhyx0WkVyQgWNg/s3URni5F
         3UjwwmLo19C/YKhW/mZY4PJV6WTkVMSgAAQkHOD+e4bfDfDP1QIUW5AuSTz5NVgJ98LO
         WN4Kzv+6WjVUh9EbohaB8zY9TY8TS8PMnq85efOe/Tu+OsPwLNvdJk6Lm3Gx3e4j9Y/h
         YqnVa6JbpvfmA3/h1cHAB5KIyKrlzifF+MfT/oMpyDHJV/19Q4ZzYqW5ybNiQv16qiNN
         TMz/QYoXkkCcXcVtqXTsCzFeufHevHhCwoxXH1+PEyRhhEZCc2ER7JdfGKQz9kQNDoZ5
         ntJg==
X-Gm-Message-State: AOAM530pwf14qlXalgupXk/1exJ0xfxZbvNeCxKwN+epzuk9+7Z+yBKQ
        89ejN3PGHQ4OQnpw50WpRDg=
X-Google-Smtp-Source: ABdhPJzWVZGkirIblOT+0R32Us09OoIy7bJpht0vlAJLMST4g4xHtGFvrkdDjTkcJraqWDb0h/q26g==
X-Received: by 2002:a17:902:db08:b029:12c:c5d2:534c with SMTP id m8-20020a170902db08b029012cc5d2534cmr8097863plx.47.1628075038379;
        Wed, 04 Aug 2021 04:03:58 -0700 (PDT)
Received: from wangting-OptiPlex-7050.mioffice.cn ([2408:8607:1b00:7:529a:4cff:fe0e:1dd3])
        by smtp.gmail.com with ESMTPSA id f6sm2306220pfv.69.2021.08.04.04.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 04:03:58 -0700 (PDT)
From:   Ting Wang <zxc52fgh@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, wangting11 <wangting11@xiaomi.com>
Subject: [PATCH v11 2/4] power: supply: core: add wireless charger adapter type property
Date:   Wed,  4 Aug 2021 19:01:59 +0800
Message-Id: <48bae506e78556b50349e87b356387e46c2923cb.1627992564.git.wangting11@xiaomi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1627992564.git.wangting11@xiaomi.com>
References: <cover.1627992564.git.wangting11@xiaomi.com>
In-Reply-To: <cover.1627992564.git.wangting11@xiaomi.com>
References: <cover.1627992564.git.wangting11@xiaomi.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: wangting11 <wangting11@xiaomi.com>

Reports what type of wireless adapter connection is
currently active for the supply.
for example it can show if ADAPTER_PD capable source is attached.

Signed-off-by: wangting11 <wangting11@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 28 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                | 19 ++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index a49e1049cd9b..36808bf8731b 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -757,3 +757,31 @@ Contact:	Fei Jiang <jiangfei1@xiaomi.com>
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
index 21f0ab748e5e..561cffef9d61 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -212,6 +212,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(MANUFACTURER),
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
 	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
+	POWER_SUPPLY_ATTR(TX_ADAPTER),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 3dc3e53c5df1..bcfadf2a995f 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -172,6 +172,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_TX_ADAPTER,
 };
 
 enum power_supply_type {
@@ -216,6 +217,24 @@ enum power_supply_quick_charge_type {
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
2.17.1

