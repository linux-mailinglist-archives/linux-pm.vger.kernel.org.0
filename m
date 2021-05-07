Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA19376890
	for <lists+linux-pm@lfdr.de>; Fri,  7 May 2021 18:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbhEGQWi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 May 2021 12:22:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51222 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238090AbhEGQWh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 May 2021 12:22:37 -0400
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lf3EP-0008A6-3Q
        for linux-pm@vger.kernel.org; Fri, 07 May 2021 16:21:37 +0000
Received: by mail-qt1-f200.google.com with SMTP id d16-20020ac811900000b02901bbebf64663so6031579qtj.14
        for <linux-pm@vger.kernel.org>; Fri, 07 May 2021 09:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dB8otcToZ0kaQ8XLwm4gKZh/Gvp55gjgN8Q4hQT5d4=;
        b=kxA3U0C1MdWx8pJdlDIs6hpHKbrCnkndhYMGUFsLABkaKJFShq/Tnzt2mQBXdkoWDD
         9VfAS1G6Vw5jSRK3PzUVA8Txg/dfhUQ7EyRbiuPlsJqaXSXgH6QTgEDGB+s/CNLSiFAB
         s+z0PJHo/dyTb5mYeR/f3kXqbH//0bLnTxIkZ29/noguYbQ+ONCvKCulKudaMVt4Xjqe
         EhSpCLt8BHw1QHaUBXkhsF6REwBIUMXRTVsVMfelAYeqOCerDuGJR+AR9Ne2DsoCkCe8
         HBsasMxKamxGS5g6OY/VMWcVBNm7s8P3VrBvbcVMb9IBs3KOoixtXMZn/Llfn2+DjBsB
         q7Mg==
X-Gm-Message-State: AOAM5327FqzZS/rela9njDHjytEB9arpt0cP3Kt926Txpjn08DXsFs5Y
        Ykjp6CiLkNCE/TLNtHOtCO75QWhpHpOg7BMFMMlVsi0seFIGHAxBSLpcQjEQiBsB6lrGgpULrqm
        +UEllfNoTCpdIm29zOXjvsADd+gQbth6SMRKL
X-Received: by 2002:a05:622a:387:: with SMTP id j7mr10053747qtx.255.1620404496173;
        Fri, 07 May 2021 09:21:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztpOdmGOzbTTrf1BhbXzYpMKN6SwOt8oXJJTpBqWJY5h4B6QG8KwlYu67S3yPqWVtZnYvBRA==
X-Received: by 2002:a05:622a:387:: with SMTP id j7mr10053736qtx.255.1620404496012;
        Fri, 07 May 2021 09:21:36 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.1])
        by smtp.gmail.com with ESMTPSA id i5sm4991869qki.115.2021.05.07.09.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:21:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Iskren Chernev <iskren.chernev@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Matheus Castello <matheus@castello.eng.br>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [RFT PATCH 3/3] power: supply: max17040: drop unused platform data support
Date:   Fri,  7 May 2021 12:19:27 -0400
Message-Id: <20210507161927.105862-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507161927.105862-1-krzysztof.kozlowski@canonical.com>
References: <20210507161927.105862-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are no platforms using the driver with platform data (no board
files with the driver), so the dead code can be dropped.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/max17040_battery.c |  3 ---
 include/linux/max17040_battery.h        | 16 ----------------
 2 files changed, 19 deletions(-)
 delete mode 100644 include/linux/max17040_battery.h

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index d51c3443d732..a8ba2c305034 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -16,7 +16,6 @@
 #include <linux/interrupt.h>
 #include <linux/power_supply.h>
 #include <linux/of_device.h>
-#include <linux/max17040_battery.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -142,7 +141,6 @@ struct max17040_chip {
 	struct regmap			*regmap;
 	struct delayed_work		work;
 	struct power_supply		*battery;
-	struct max17040_platform_data	*pdata;
 	struct chip_data		data;
 
 	/* battery capacity */
@@ -453,7 +451,6 @@ static int max17040_probe(struct i2c_client *client,
 
 	chip->client = client;
 	chip->regmap = devm_regmap_init_i2c(client, &max17040_regmap);
-	chip->pdata = client->dev.platform_data;
 	chip_id = (enum chip_id) id->driver_data;
 	if (client->dev.of_node) {
 		ret = max17040_get_of_data(chip);
diff --git a/include/linux/max17040_battery.h b/include/linux/max17040_battery.h
deleted file mode 100644
index 593602fc9317..000000000000
--- a/include/linux/max17040_battery.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  Copyright (C) 2009 Samsung Electronics
- *  Minkyu Kang <mk7.kang@samsung.com>
- */
-
-#ifndef __MAX17040_BATTERY_H_
-#define __MAX17040_BATTERY_H_
-
-struct max17040_platform_data {
-	int (*battery_online)(void);
-	int (*charger_online)(void);
-	int (*charger_enable)(void);
-};
-
-#endif
-- 
2.25.1

