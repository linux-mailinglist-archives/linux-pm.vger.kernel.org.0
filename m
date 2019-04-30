Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10E1F0B3
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 08:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfD3GqQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 02:46:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44120 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfD3GqQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 02:46:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so6569644pfm.11;
        Mon, 29 Apr 2019 23:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VW37A7CK8zNP+puxGj5PzGbX48/U7vlPhB5EcPFYbg=;
        b=LzgAvsZKBZJydg0akAdWWhNubSRDXtZ5Xf18tNdZ93yZXhW/hOZbBzEJRA9CggQxXU
         dayAf7HAjlIdKg3rpn5dfpDRSsjgYjBHxyRs74WhgIDaAuYDIeS7NPn0loDvfaqojWVt
         BArqqfEjJG94+QWz5vLzdHsSJN/5GHKhQV2I12YrCuT4mTsmab61/UVRqf641xeCale7
         AvnJbrwDrFg1lbqBcOp6JGjefF7wxqWNbJ9IM+LFmNoFCozV/XFIoP+ZEJwp7xXdTXjt
         PCM/20bqff6uFq0cjKO3PGDgGNldE1jG53I0kKCHNtccOv8ENjWBfCt5hyBkqyhqTcQ4
         joPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VW37A7CK8zNP+puxGj5PzGbX48/U7vlPhB5EcPFYbg=;
        b=C9gmgElqmQrmrcA8tAahyxpPmvzH2jX0fXL8jU/+ptA2OvMA3YceRdQjyeuwGF7eAR
         G1iuFseGwHYVkFjwMLi36yAYLAp9JjYNFHtMbxKurnHN0thiWVzAb4fmfT3qUkcRhVmz
         aPa5Gy3qXAIn1JszAV/f7SbLAFGf6q/cdYZvVGBvPcHlR7NDK0emWzz5SKyUxrQlp8/o
         FX80//41x45YYyyJhPF7Ft86zdPMfESuNplrIze4onVIc34qnrwtmiawDEzrwqodotop
         Kb7mWE+SbDp9jqIZE/HfZbOX5cv7w9+YSXx1Ki7Vgqf7x1Bs1uy5I6hEzXIfuTlUNQfd
         7oCw==
X-Gm-Message-State: APjAAAWbpeWWkN7XbILjlLHarkTV86DYIKLwbDSOCkBCpq8UMQsa9SH1
        h5XgVFx1Uix3c50UJDDzn+ZXozvgfrQ=
X-Google-Smtp-Source: APXvYqz+53uQ/abdHdtAJPhvBy84J+/ZS724ENQOjtBtIvvnyUlhJXj7xZymzA1uCeHlgZFwpogk7A==
X-Received: by 2002:a63:610f:: with SMTP id v15mr27658139pgb.128.1556606774974;
        Mon, 29 Apr 2019 23:46:14 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a9sm47336010pfo.17.2019.04.29.23.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 23:46:14 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] power: supply: core: Add POWER_SUPPLY_HEALTH_OVERCURRENT constant
Date:   Mon, 29 Apr 2019 23:45:55 -0700
Message-Id: <20190430064557.28469-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430064557.28469-1-andrew.smirnov@gmail.com>
References: <20190430064557.28469-1-andrew.smirnov@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>
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
2.20.1

