Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10A83DFFD9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 13:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbhHDLEc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 07:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbhHDLE1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 07:04:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB70C0617A0;
        Wed,  4 Aug 2021 04:04:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c16so2586072plh.7;
        Wed, 04 Aug 2021 04:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7ipuFcAF0hi+YGdtGdT1Vm/pxhGoa9kh3ysl0IJnuL8=;
        b=CwxFZjlEgvFV8xQjYWnzhmyymTw9EBVKFtGtSqffodm55NGxSOlQiuoxY2IvRLQaLm
         eHJtshg6pMW+qc7MVFau4YJSvrZUguXESzLUOK4LoPdmj6UYD9TNA/rE6kdknmhmjUPx
         FQhVibPFzujaUUu27gFJ9Rez3t8iR/JlxcTtjP2TA7KfBYOWZO48zcTag3UGttcDTLQX
         8yJOlUP4r+XH+J1MKBus1YaI162hsvaF8QzffAheITSHzCLd5LCCAG0HGm+cHKTTxjqi
         P8x4X9TUoaiNxZSlmUOMtxtWBxx78kinwntY1QKXpGkyiWQ4ZA/a9aS8dEmb+ne5hrIe
         FfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7ipuFcAF0hi+YGdtGdT1Vm/pxhGoa9kh3ysl0IJnuL8=;
        b=ezZ8IBn4gsBTVyDahW9njZRKzC+iogUmM7gatYquBzcthOsdj3DkcxQGXXC0aqL9wX
         nsdD9GxuF7ornIsD+jb7JC5Hweewnkufueh9zub9EP8Jr2+6fr9XxMwdjy2Nhi4OcOpD
         qKQwPrTxiBHaxcGz78/0cNVQnjTuOvEAaK2+mM60KeFhQrtPQx+6aN+gi7m8P11KaOQi
         kEtEx0SO32vdehIPE9BnBZi5fKaKZXVU5N2sE4QIMLeJnuIiCWBEKTa778fg0vjNbJA4
         gdFv+pt3VlzGJ0Tb0HAmpNzMY+qHoDBCFpQNbGQZnSbyTSKn8pgljoZchT0tQrd7Knnf
         TJQg==
X-Gm-Message-State: AOAM531WQM5G3iMhDt5EoRXdg12N+V1ZweEFoqFdwcj/1RMe2TE6AfmA
        6Ayhn2la3QL94CAx00+lNes=
X-Google-Smtp-Source: ABdhPJyQ/9mreaAe00O7y1fFI176mhfOvMGrtteEhkhKKcPIUgXof/ODYwI0eFkbW1jPr3bbqoYcWw==
X-Received: by 2002:a63:f44a:: with SMTP id p10mr384144pgk.11.1628075051875;
        Wed, 04 Aug 2021 04:04:11 -0700 (PDT)
Received: from wangting-OptiPlex-7050.mioffice.cn ([2408:8607:1b00:7:529a:4cff:fe0e:1dd3])
        by smtp.gmail.com with ESMTPSA id f6sm2306220pfv.69.2021.08.04.04.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 04:04:11 -0700 (PDT)
From:   Ting Wang <zxc52fgh@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, wangting11 <wangting11@xiaomi.com>
Subject: [PATCH v11 4/4] power: supply: core: property to control reverse charge
Date:   Wed,  4 Aug 2021 19:02:01 +0800
Message-Id: <0d72b2e799ec764b851f3efecffbcc20f9b2c55c.1627992564.git.wangting11@xiaomi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1627992564.git.wangting11@xiaomi.com>
References: <cover.1627992564.git.wangting11@xiaomi.com>
In-Reply-To: <cover.1627992564.git.wangting11@xiaomi.com>
References: <cover.1627992564.git.wangting11@xiaomi.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: wangting11 <wangting11@xiaomi.com>

Interface to control wireless reverse charge.

Signed-off-by: wangting11 <wangting11@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 14 ++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 4a6b4970cb7d..59518568d594 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -807,3 +807,17 @@ Description:
 
 		Access: Read-Only
 		Valid values: 0 - 100
+
+What:		/sys/class/power_supply/<supply_name>/reverse_chg_mode
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		Some devices support wireless reverse charge function which
+		charge other devices.The property provider interface to
+		enable/disable wireless reverse charge.If enabled, start TX
+		mode and detect RX. Disabled when timeout or manual setting.
+
+		Access: Read, Write
+		Valid values:
+		- 1: enabled
+		- 0: disabled
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 4de91dce2001..934563eed155 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -214,6 +214,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
 	POWER_SUPPLY_ATTR(TX_ADAPTER),
 	POWER_SUPPLY_ATTR(SIGNAL_STRENGTH),
+	POWER_SUPPLY_ATTR(REVERSE_CHG_MODE),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 0dfec19cb473..3fe3f9665389 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -174,6 +174,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_TX_ADAPTER,
 	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
+	POWER_SUPPLY_PROP_REVERSE_CHG_MODE,
 };
 
 enum power_supply_type {
-- 
2.17.1

