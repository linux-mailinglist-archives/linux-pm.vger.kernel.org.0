Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF4B22015C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 02:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGOAhy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 20:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgGOAhy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 20:37:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD30C061755;
        Tue, 14 Jul 2020 17:37:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b92so681024pjc.4;
        Tue, 14 Jul 2020 17:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bj0ge/lKsPf1Fx7ggAUb/llP8JF010xTcoaHEoLGxyE=;
        b=HXC6T639/3yvNY+J8IEpxFn71weDtE36v4OCphKwx/KlgcbFsBSgd8IKzH5J2WWvGX
         kjEgg8rMhDUhQUM8IFnDRv4msmzssSFo3fJqORtjBdLol418DMqqf7g0mzmz1MRyJAhc
         uTbPoCxprlVzlf7CAGMOBlxDXvl9/1OWESPSm9PR0aNx9tfJrmncUTwVxhXJSRpuB/ru
         p+kqtilyYU1A9qjDzb2VlBIhAO0Y4yttguQ7zf0pi9HvVa2mXVeq196TOf58Bjsrt/65
         cRR8M+TxYRfaHqEuALia7S2KmxpzR+Zob0CKkUO6ISPCfeKUxXRUdvxC62z/iRcDeY5U
         5vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bj0ge/lKsPf1Fx7ggAUb/llP8JF010xTcoaHEoLGxyE=;
        b=sI41F0vJci3BKmwmKCZESOM1J1P0+HOoElcVT4f7tzeKmuok8LLxjW0As6utEh6GGp
         sNQqFiHfJkkdH4vghKmGBHfDaVYhz0QbCWF4QLE9yNgZABkmgGEtVHIQzouFLPCTkVrN
         QV00rbv2GYl71ToNzQSXHHeGvkfHnDTVo8Dcd65iC70MSOb1DQix/nwpzkGeha6g2aOG
         KkVbKnF5cv/R+Yy2T4FLpcUrVqnmUyA7pnOb2SOLRHNhpvFdzeg0H04QtNOrGklKoHyh
         y91Suvz9h0BnIwdFBvZlT+l6OJUeegRmFni9VtTgCsRRrTlvCcarFtKP+s2NW5ekH0be
         VLRA==
X-Gm-Message-State: AOAM533gW18+1OuLRhjkmqrmy5YKhQDCUxxWI0rHb4MNfWQZDolSqbGj
        ZB+8NlGeJssZUTN1z5y9BS3K8E2fXAi46+9o
X-Google-Smtp-Source: ABdhPJzunN28p7eooB/Av8/c0P3gZVNA85rZAuqjnzs2AahIW+OGNlN1MYwn1lBWlzUDImU5X6EZuw==
X-Received: by 2002:a17:902:7008:: with SMTP id y8mr5909116plk.85.1594773474100;
        Tue, 14 Jul 2020 17:37:54 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id t126sm266156pfd.214.2020.07.14.17.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 17:37:53 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v3 2/5] power: supply: core: add wireless charger adapter type property
Date:   Wed, 15 Jul 2020 08:35:20 +0800
Message-Id: <abd53a779a44c13a1d16e1fded3cb248e5fbfeba.1594726859.git.huangqiwu@xiaomi.com>
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

Reports what type of wireless adapter connection is
currently active forthe supply.
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

