Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C703DCBD1
	for <lists+linux-pm@lfdr.de>; Sun,  1 Aug 2021 15:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhHANbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Aug 2021 09:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231951AbhHANba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Aug 2021 09:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627824671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7MfyRBE6Upv6sUcuCbvDVgd8N9MvhrV6Ou+uTsFtFE=;
        b=fvA5A5CnTbzHt967vplTttD3D3Bxyl3yS0SC77bZ1ezevPOqElHtu9bysH95/N+11FsM0r
        jrwi6TebylDTUUuTo0txvXnNxEWGtKXNvR4WOLWjTZq42emTSROumVNj3WWQBnhHPg0DtJ
        S2XmeXjHiFzwFt0imSn7zGGxHrnSuDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-fUZ8UIIVPSGTc4_t5SvfOQ-1; Sun, 01 Aug 2021 09:31:10 -0400
X-MC-Unique: fUZ8UIIVPSGTc4_t5SvfOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 760EC6409E;
        Sun,  1 Aug 2021 13:31:09 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CABE60CC4;
        Sun,  1 Aug 2021 13:31:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Andrejus Basovas <cpp@gcc.lt>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 01/10] power: supply: axp288_fuel_gauge: Fix define alignment
Date:   Sun,  1 Aug 2021 15:30:56 +0200
Message-Id: <20210801133105.101761-2-hdegoede@redhat.com>
In-Reply-To: <20210801133105.101761-1-hdegoede@redhat.com>
References: <20210801133105.101761-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The values of various defines used in the driver are not aligned
properly when tabsize is set to 8 (I guess they were created with
a different tabsize).

Properly align the defines to make the code easier to read.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 38 ++++++++++++------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 2ba2d8d6b8e6..99928789040d 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -23,34 +23,34 @@
 #include <linux/seq_file.h>
 #include <asm/unaligned.h>
 
-#define PS_STAT_VBUS_TRIGGER		(1 << 0)
-#define PS_STAT_BAT_CHRG_DIR		(1 << 2)
-#define PS_STAT_VBAT_ABOVE_VHOLD	(1 << 3)
-#define PS_STAT_VBUS_VALID		(1 << 4)
-#define PS_STAT_VBUS_PRESENT		(1 << 5)
+#define PS_STAT_VBUS_TRIGGER			(1 << 0)
+#define PS_STAT_BAT_CHRG_DIR			(1 << 2)
+#define PS_STAT_VBAT_ABOVE_VHOLD		(1 << 3)
+#define PS_STAT_VBUS_VALID			(1 << 4)
+#define PS_STAT_VBUS_PRESENT			(1 << 5)
 
-#define CHRG_STAT_BAT_SAFE_MODE		(1 << 3)
+#define CHRG_STAT_BAT_SAFE_MODE			(1 << 3)
 #define CHRG_STAT_BAT_VALID			(1 << 4)
-#define CHRG_STAT_BAT_PRESENT		(1 << 5)
+#define CHRG_STAT_BAT_PRESENT			(1 << 5)
 #define CHRG_STAT_CHARGING			(1 << 6)
 #define CHRG_STAT_PMIC_OTP			(1 << 7)
 
 #define CHRG_CCCV_CC_MASK			0xf     /* 4 bits */
-#define CHRG_CCCV_CC_BIT_POS		0
+#define CHRG_CCCV_CC_BIT_POS			0
 #define CHRG_CCCV_CC_OFFSET			200     /* 200mA */
-#define CHRG_CCCV_CC_LSB_RES		200     /* 200mA */
+#define CHRG_CCCV_CC_LSB_RES			200     /* 200mA */
 #define CHRG_CCCV_ITERM_20P			(1 << 4)    /* 20% of CC */
 #define CHRG_CCCV_CV_MASK			0x60        /* 2 bits */
-#define CHRG_CCCV_CV_BIT_POS		5
+#define CHRG_CCCV_CV_BIT_POS			5
 #define CHRG_CCCV_CV_4100MV			0x0     /* 4.10V */
 #define CHRG_CCCV_CV_4150MV			0x1     /* 4.15V */
 #define CHRG_CCCV_CV_4200MV			0x2     /* 4.20V */
 #define CHRG_CCCV_CV_4350MV			0x3     /* 4.35V */
 #define CHRG_CCCV_CHG_EN			(1 << 7)
 
-#define FG_CNTL_OCV_ADJ_STAT		(1 << 2)
+#define FG_CNTL_OCV_ADJ_STAT			(1 << 2)
 #define FG_CNTL_OCV_ADJ_EN			(1 << 3)
-#define FG_CNTL_CAP_ADJ_STAT		(1 << 4)
+#define FG_CNTL_CAP_ADJ_STAT			(1 << 4)
 #define FG_CNTL_CAP_ADJ_EN			(1 << 5)
 #define FG_CNTL_CC_EN				(1 << 6)
 #define FG_CNTL_GAUGE_EN			(1 << 7)
@@ -71,23 +71,23 @@
 #define FG_CC_CAP_VALID				(1 << 7)
 #define FG_CC_CAP_VAL_MASK			0x7F
 
-#define FG_LOW_CAP_THR1_MASK		0xf0    /* 5% tp 20% */
+#define FG_LOW_CAP_THR1_MASK			0xf0    /* 5% tp 20% */
 #define FG_LOW_CAP_THR1_VAL			0xa0    /* 15 perc */
-#define FG_LOW_CAP_THR2_MASK		0x0f    /* 0% to 15% */
+#define FG_LOW_CAP_THR2_MASK			0x0f    /* 0% to 15% */
 #define FG_LOW_CAP_WARN_THR			14  /* 14 perc */
 #define FG_LOW_CAP_CRIT_THR			4   /* 4 perc */
 #define FG_LOW_CAP_SHDN_THR			0   /* 0 perc */
 
-#define NR_RETRY_CNT    3
-#define DEV_NAME	"axp288_fuel_gauge"
+#define NR_RETRY_CNT				3
+#define DEV_NAME				"axp288_fuel_gauge"
 
 /* 1.1mV per LSB expressed in uV */
 #define VOLTAGE_FROM_ADC(a)			((a * 11) / 10)
 /* properties converted to uV, uA */
-#define PROP_VOLT(a)		((a) * 1000)
-#define PROP_CURR(a)		((a) * 1000)
+#define PROP_VOLT(a)				((a) * 1000)
+#define PROP_CURR(a)				((a) * 1000)
 
-#define AXP288_FG_INTR_NUM	6
+#define AXP288_FG_INTR_NUM			6
 enum {
 	QWBTU_IRQ = 0,
 	WBTU_IRQ,
-- 
2.31.1

