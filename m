Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C2F25122C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 08:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgHYGkQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 02:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbgHYGkM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 02:40:12 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E49C061574;
        Mon, 24 Aug 2020 23:40:12 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 17so6530554pfw.9;
        Mon, 24 Aug 2020 23:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ricGGIi0rSFfCMhWo07vOBDDcXPDfivbO4AsrdYg3Sk=;
        b=tuosopsExS5cuVwTcyuPWEqBaG9Q42/P7sTCtZrtTHD/wFAS7iQtxXwA0se6WVDyrV
         3bmMs2rRoddsaioTa5pYwRGT6HJWnVdC8zVXt05fJ2/8WY+VvUM4OznqoBrCJYgUp+H5
         BvVrZNErh81sV8yEaDqU66TPSLDqtSHOc/qi4nFYoXLsf5fTeNp4zexwPQGvBXsP5bdR
         +Bs1HawvHR3wkxTYoqJh0GimyBFlrb6vXdZzVs1Tx5QBlH45azMgqj9eV394Qw49RRXq
         v8/veAvxp1Bh/CJhqYKsIZYtdNl+/Yo44qC11dpEvi7xlfTzk9dB42PmHfT8MXPwGABX
         DNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ricGGIi0rSFfCMhWo07vOBDDcXPDfivbO4AsrdYg3Sk=;
        b=EPs/4GwigtwSwtky3afENceTavPl+wUxRNG6GlHeb8Jv9OGn1+tEUiqEbxDAOcslVP
         L+BZ12QNwxcaUQ18ozzZFDhjbGxrYdc1XXyhHPeYvqb4ZXZZZExSF5Ix+QCIof+gOFzb
         gBddpC0yfaeuLTyCJVlwHx/jsa632U+Q8FLwn5XBXUnf7B4npCMnwKHAeY0vNvXRJ6zb
         lKsrCsokwsUiruQnjDR+w7xWoGcLL73cwlRXwa7+ByWME870JKQRMuGr2SvLqwdYlwau
         mQ5adDClDO9DJ122YoOb0//hpKsVzYf532EWWmlk8o5J0qs/yUxVjzphqITCdiRVG48E
         hFAg==
X-Gm-Message-State: AOAM532LghqtS2AZodeCNY3K1c8lqvaZrHZ4pPtMYTruqZp1Aj+GNOHz
        WF9DrIIaMnTih7CtYncNYDQ=
X-Google-Smtp-Source: ABdhPJxETsPue40ear0GRI+w3n1T4ossZuS7y666yM7tY0cK8N4BmF/OzQ6Qm3HtuE/De0NzF/F0EA==
X-Received: by 2002:a63:342:: with SMTP id 63mr6011789pgd.134.1598337612218;
        Mon, 24 Aug 2020 23:40:12 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id z2sm14197283pfq.46.2020.08.24.23.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 23:40:11 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v9 2/4] power: supply: core: add wireless charger adapter type property
Date:   Tue, 25 Aug 2020 14:37:57 +0800
Message-Id: <2c3cd38e180af5b375ece088d5a3ec2519b39b9a.1598337073.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598337073.git.huangqiwu@xiaomi.com>
References: <cover.1598337073.git.huangqiwu@xiaomi.com>
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

