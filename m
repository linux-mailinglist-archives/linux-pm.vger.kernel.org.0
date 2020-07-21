Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC0E227E95
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 13:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgGULRy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 07:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbgGULRx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 07:17:53 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C862AC061794;
        Tue, 21 Jul 2020 04:17:53 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t6so10125658plo.3;
        Tue, 21 Jul 2020 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sZlxIlYMO7HwxnRaFGsIzOSb76wV/Tp+2rRqojyDdA8=;
        b=QzwthzU6xxZEXetxaAUxFYl0PuYshwfIoF3VJ/ez1xT5vygkSHm3o7QwM5572NnDmx
         QtjQTxPaVwa0Dswg9iCGLe5bcg/QAHyTlGF4PxwF4WPUG91g+Spn4xrULpAPnlj0fNkm
         +neOZJGx197Fu2mRyA4L9lNyvNiQOprG/Sy19yrprk5jBGbTSR540MLE6BB0fhHHMSxy
         KFsJhKHWzWjrQlGrmYnS21hODYMDQMvEwtr2GpITqGFawxDoLPfAr2IOWDMGh5Z3ie+F
         qhbefSSrunZdU82CTVco4e7lMbUg95oUZm7NywNeAyoQjD0ZEJTiYab0LD1G4riAUW3d
         +9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sZlxIlYMO7HwxnRaFGsIzOSb76wV/Tp+2rRqojyDdA8=;
        b=dIkry7GVR6pVmJZ6WODofe09GXb9cNqnDwYH2oAKXcmRjKn/Jpe9NJak7rsvB710d3
         csyiDEnbkX/z3mDyI+cbX3AtnG6D4f1r2QS84IC0teYbAbX2j5Y058puI0qixXh/Ad1+
         9wVi2tpDrpBCTfOg8k3Uoe9Yu7nlVJKbPKhjkndA4bCjTF4gYbabJ7ZRFvFyBEq3wtBz
         XHrQHPrdZYbZfSDhAq6gjDEYLPpBYXbJyJkrau3lrC2ZMvqBnWTMVgPSOeXHvkwg36eP
         rSMYXi7BReca4Xl0kKwcpQhdFq5KusKbksi8F4/jXm8N2VMk+zxlpTed19i3QptE9hG4
         YiEw==
X-Gm-Message-State: AOAM532K7ZAVGDh09V+w8h6NQ/cIniYH98twXCXDoowOypgBIAgBqDSC
        SHVWlH/M0uVtFz44EGoFzRY=
X-Google-Smtp-Source: ABdhPJyT7gP+HCCeN0E1x5y3DkZmVc81PnTjtnPj7IzkYGyMVmjhdzi2tqEgK3NlztAYoyeTlkoTvw==
X-Received: by 2002:a17:90a:3e4f:: with SMTP id t15mr4156673pjm.46.1595330273386;
        Tue, 21 Jul 2020 04:17:53 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id f72sm19829566pfa.66.2020.07.21.04.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 04:17:52 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v6 3/4] power: supply: core: add wireless signal strength property
Date:   Tue, 21 Jul 2020 19:15:38 +0800
Message-Id: <df7d3aa6ae74a7606c37804bd914be7601f79bf2.1595329640.git.huangqiwu@xiaomi.com>
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

reports wireless signal strength.
The value show degree of coupling between tx and rx.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 22 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 03ab449fae8a..4459b720feb2 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -757,3 +757,25 @@ Description:
 			13: ADAPTER_VOICE_BOX,
 			14: ADAPTER_PRIVATE_PD_50W.
 
+What:		/sys/class/power_supply/<supply_name>/signal_strength
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		In PING phase, RX transmits a signal strength packet as the
+		first communication packet to instruct the base to keep power
+		signal on.The value reports wireless signal strength and show
+		degree of coupling.
+
+		The Qi Wireless Power Transfer System is published by the
+		Wireless Power Consortium.The ping phase is the necessary stage
+		for matching transmitter and receiver. In this phase,the Power
+		Transmitter executes a Digital Ping, and listens for a response.
+		If the Power Transmitter discovers a Power Receiver, the Power
+		Transmitter may extend the Digital Ping,i.e. maintain the Power
+		Signal at the level of the Digital Ping. This causes the system
+		to proceed to the identification & configuration phase. If the
+		Power Transmitter does not extend the Digital Ping, the system
+		shall revert to the selection phase.
+
+		Access: Read-Only
+		Valid values: 0 - 100
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f2458e21d02b..e420a453095e 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -208,6 +208,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
 	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
 	POWER_SUPPLY_ATTR(TX_ADAPTER),
+	POWER_SUPPLY_ATTR(SIGNAL_STRENGTH),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 0bbdec1630a4..346c6c9c0737 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -169,6 +169,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_TX_ADAPTER,
+	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
 };
 
 enum power_supply_type {
-- 
2.27.0

