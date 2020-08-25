Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55093251681
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 12:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgHYKSy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 06:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbgHYKSd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 06:18:33 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A319C061574;
        Tue, 25 Aug 2020 03:18:33 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ep8so993846pjb.3;
        Tue, 25 Aug 2020 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89yx6cZZLpORQougS6qytDdcNI/14e8vNGHS/0MWLQk=;
        b=Tvoi3Cd+GhzfJdhGcbR+Za137QeGhHkwTtX2Ah8CMRgWQNGdVcGn7G5AgZv8Nx1F5d
         beXn4Zi2DuCmXdDVR5FqHPDA6WeUCKTEZaRXsHXlHfG+2zPs0iMtZv0byLRBOvgOeKKK
         LWP+nXhmHI+EtCetztp++sBzvCtqihUNduhF79Gg4FZb5JvHKrC3QqBZTINfUTy43f4Y
         rJXX+LiI41/KnYvMnj8QgPKZ8KfvT+ot5k2KMC+wv+ybWlPeQEhnE2ES+bKsxRU0m3OV
         Z/35jaV1Wi5TU16fWxIxyCollHJOnjP5xLRt3Lkg+S93iqV4BLHY9SKlGJmynH0TFIsC
         p+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89yx6cZZLpORQougS6qytDdcNI/14e8vNGHS/0MWLQk=;
        b=NosaVSvkd768+sWySecg0KN+5ZmLQ5ZNHYEF7NCmos8mGlkpE+KEFB7q3n5r1rSWrs
         dHQzgKH01FnC7dLSYXt3zw5clhZoGBUhllytU0hUBtbAYd7S0axHqCyUEO6abWTgHsof
         7vN2XMSSc8Rd56WWNT7reiNi/C3yri2cYIAn+hsOMHZvL81omzl2HsigOtOJDrbto//A
         7D+ZBQmT2ByCODEyNzNFLEK4oiJxqQcITY/vno+N6OXy4mEnxKFmxPsDcice1YC/ynVw
         LNS6xkRJTbPWQFsodG4kHRLS4e3CHO9wh+xMQrHUNE8bCAbt7HMtZg+hAqsqTCkT1OUm
         y0Uw==
X-Gm-Message-State: AOAM530UmQ9+vcWFWpha+jTRe8JZMw41pdjaBc3qy169aVB3Ywx9OAeP
        jZnk8kgg+I8+5pS7C191c6sCi087/BSx8w==
X-Google-Smtp-Source: ABdhPJyPGsv9HterPKrRxpy49SbPX+uZaB4Wie9X0WMnEzVNLlz2lgCK9b5uL3R4+tudTN7AIsCP6w==
X-Received: by 2002:a17:90a:2c06:: with SMTP id m6mr1034869pjd.129.1598350712776;
        Tue, 25 Aug 2020 03:18:32 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 19sm1788911pjk.28.2020.08.25.03.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 03:18:32 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v10 4/4] power: supply: core: property to control reverse charge
Date:   Tue, 25 Aug 2020 18:16:17 +0800
Message-Id: <d2a4960e5641c4360a9360f438669ec03a2c3d0d.1598349907.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598349907.git.huangqiwu@xiaomi.com>
References: <cover.1598349907.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Interface to control wireless reverse charge.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 14 ++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index c3a547037d07..e0adb22a6648 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -780,3 +780,17 @@ Description:
 
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
index 64e6bdd91edf..403a1787fada 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -213,6 +213,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
 	POWER_SUPPLY_ATTR(TX_ADAPTER),
 	POWER_SUPPLY_ATTR(SIGNAL_STRENGTH),
+	POWER_SUPPLY_ATTR(REVERSE_CHG_MODE),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 496d1faecdd1..ee156492c566 100644
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
2.28.0

