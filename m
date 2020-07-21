Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB3D227F8A
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 14:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgGUMB6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 08:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgGUMB5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 08:01:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BB6C061794;
        Tue, 21 Jul 2020 05:01:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d7so1395014plq.13;
        Tue, 21 Jul 2020 05:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sZlxIlYMO7HwxnRaFGsIzOSb76wV/Tp+2rRqojyDdA8=;
        b=X5e+iQ0Vdh5ViWxc75pLhsPCdvwjqL+lcF3QagdZv13/sciOVcd4vLRFxNwNzd2+vk
         y/WHQ7RWtaJDrR2/wLl6jDK/wYojQRCGocZ1FNFhmRXBf+zw0n0QuiyC8v9vtTgffM0H
         O1ZbuEiV3VSKYszHNmCH6IrQ/E20wAZ7eTvBKcoczoXImXC2rRxzFaY3s8cfMANaRF7q
         vw5bxXfAgcDflxwNrVzj4gm9npP+XhGzcRjXycZdIrbZ7oU+YJaLVgIt47Qzx4eZJxtt
         w05YMLhvdgTZ6nvof6z0F5jYSQFyE8F0FxRSU34rTvbjbo5F9UaSAkutZHhsFVo1MyIS
         EG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sZlxIlYMO7HwxnRaFGsIzOSb76wV/Tp+2rRqojyDdA8=;
        b=qCfu5yk6Amur8f63TvMl28YrlOc63TArHoEIlqyTcDxXiwGWstYZ7NBXYE+TGvcPtx
         r96cOeSz2reKuvs0VrztHmHaHvzvnm4+7Hl78Te8QTnpybrKUU1XKUXljjraw/jU+3Ov
         h2K6tJjkyM+tpoXoVmgHP1TQOLQ5jiE+szC7NKhtdUSDQzqbfBPgJVSY23optAktPVhr
         e3s4AYc+ZGWCyTD7tgepsQso2nJyCapHomE3XdM/IePocM9IEMSKo5kCgAmeOCC2hY/O
         EmobyW0i6D6vJ9wxxKLwvp84IIr0qouFICG44pLxrtY1NAsZSVeBKDsJV4d2FU+PBhEt
         7Z0g==
X-Gm-Message-State: AOAM531S0e4cWE/Isk+F4GpVGcbsp1x5borXWCKsXLBRWwVVYkm4R2fH
        1/yQEAMQDWjwfB3chCnMji4=
X-Google-Smtp-Source: ABdhPJwaar0i+PVY9DkuZaxUw1KoV+Kvqb0C09vGA9mb3eDO5+IY6EKKzaxs0r1tHEc4ivoPzuncoQ==
X-Received: by 2002:a17:90a:6705:: with SMTP id n5mr4878967pjj.67.1595332916717;
        Tue, 21 Jul 2020 05:01:56 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id t73sm20542041pfc.78.2020.07.21.05.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 05:01:56 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v7 3/4] power: supply: core: add wireless signal strength property
Date:   Tue, 21 Jul 2020 19:59:41 +0800
Message-Id: <df7d3aa6ae74a7606c37804bd914be7601f79bf2.1595332392.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595332392.git.huangqiwu@xiaomi.com>
References: <cover.1595332392.git.huangqiwu@xiaomi.com>
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

