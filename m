Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7823F132A9
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 19:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfECRBC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 13:01:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39860 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfECRBC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 13:01:02 -0400
Received: by mail-io1-f66.google.com with SMTP id m7so3493738ioa.6;
        Fri, 03 May 2019 10:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9dyZsdqny3bGMQohAegkSTlVb2DR9rCiAHK7dn7wEFk=;
        b=H1nzdWcTNdGvKOzG+QXxFX8FF/pjhrODH5bjKlcjKvcH5Nxlo+JVv0ySLEf2DYVOZc
         eXRg6ROLzKcXt8aCudIC6PQyKEJn9ZiZBNYNo0oh4aiYv4EM5278ueTcvrGJyMO3X+Yz
         sP32X5UmcQXzPEWS/w1DWxUDJFwdQkut3lPYGXLqGeSS+XKVOAcKKNUW41VrnLREzyp+
         mp7mraQ2PxChnaoFnK/1Ev+NcSFOIbJIyzZ/oMaMGKGzixhD/uPBpii9tjrxKOLYjEtH
         xvgHA3++Y9AnVkfjmfQCoBaMH3x5LT8oAbCiDeW9tigQsySJoKdsRau1ZN3o8+OzyWxM
         Lurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9dyZsdqny3bGMQohAegkSTlVb2DR9rCiAHK7dn7wEFk=;
        b=FuGiH5T2GFsfSBtUky2DuGRqJY2xe23e1X9N7ZufVCTzZY9VVoBTqx6FkwT10CTCNM
         pqMvWGpgprb6IfupnD2CRrL7gWlW9U0Lz79F2KOktLyOnz+OvLxxqRmEeFw4IYnDWV4V
         Pb9AA4hdcu94pmlTvKNjhr2apiTg7K30hOAayAmOeHhNKt+kHiAYLgAGLvuET4IxlvUd
         CfLaieGNuayV74lzuQ5oYybIg+2Ye/h1elzfyLAdAx2N8r9cla76Kf+B8gb+y8Z7X0zU
         eyFcbbK1zvAL1IMpGuorVZ4gSDTNuMefMrZ5vFZ6KAQZ/mLDWk0WacihsZAkWAh/nVPW
         K6hA==
X-Gm-Message-State: APjAAAU4vJ+wSl7M9/dIttMNs0RWgCcPEtyJnZBKI5EtYkkVW5ogv8fT
        oiXNKasuedpTg/oIZsYA9dEsKWpN
X-Google-Smtp-Source: APXvYqxoh4/7a2WAEvRfys/GrzgtOUzfuFOlZBrXrWgJCHxQxWOp7czp56pc+VWb8UPjq2vX/tWgKQ==
X-Received: by 2002:a5e:8348:: with SMTP id y8mr7693405iom.88.1556902861051;
        Fri, 03 May 2019 10:01:01 -0700 (PDT)
Received: from localhost.localdomain (182-254-181-166.mobile.uscc.com. [166.181.254.182])
        by smtp.gmail.com with ESMTPSA id n184sm1342588itc.28.2019.05.03.10.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 10:01:00 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] power: supply: core: Add POWER_SUPPLY_HEALTH_OVERCURRENT constant
Date:   Fri,  3 May 2019 10:00:40 -0700
Message-Id: <20190503170042.19334-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190503170042.19334-1-andrew.smirnov@gmail.com>
References: <20190503170042.19334-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add POWER_SUPPLY_HEALTH_OVERCURRENT constant in order to allow
singalling overcurrent condition via power supply health information.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 drivers/power/supply/power_supply_sysfs.c | 2 +-
 include/linux/power_supply.h              | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 5358a80d854f..153f4a6ca57c 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -62,7 +62,7 @@ static const char * const power_supply_charge_type_text[] = {
 static const char * const power_supply_health_text[] = {
 	"Unknown", "Good", "Overheat", "Dead", "Over voltage",
 	"Unspecified failure", "Cold", "Watchdog timer expire",
-	"Safety timer expire"
+	"Safety timer expire", "Over current"
 };
 
 static const char * const power_supply_technology_text[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 2f9c201a54d1..bdab14c7ca4d 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -57,6 +57,7 @@ enum {
 	POWER_SUPPLY_HEALTH_COLD,
 	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,
 	POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE,
+	POWER_SUPPLY_HEALTH_OVERCURRENT,
 };
 
 enum {
-- 
2.21.0

