Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC44CEB3E
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 22:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfD2UAT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 16:00:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38337 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2UAT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 16:00:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id f36so5585994plb.5;
        Mon, 29 Apr 2019 13:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VW37A7CK8zNP+puxGj5PzGbX48/U7vlPhB5EcPFYbg=;
        b=Vu6lQgcGV7NLvAdTLwPERdPkA1ElUQP6TOeZe9BkQiHmR+OtBqZ9IrXmFicNORmsZ7
         UTyVfwcRnf9QBAeDUBFeJ9oSPwY3lbvQtZutaAzNOBl31e2RG2xEgzvRMaP5ynPKq83e
         Nh/wWwlzi6Uz+vJ4Ip7OtACVOlhDpra0HCqcGDkdapNlu9J4zIAm9tSjzZ46hlAy8Ho6
         jdBpk/6Q/N/6s7OeamdgkKDUbd6mdH+fwGEPfSTj172FQaabJebZnQ3ofufokK69yALK
         4aL4fAx7Uw8UCjkZh+97hoPEfLjXs1EFUXk8YzrGvVuzR5Im4Hf/pOCCac7QfEilX6/h
         ffjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VW37A7CK8zNP+puxGj5PzGbX48/U7vlPhB5EcPFYbg=;
        b=rKrGZLJ5xuVyDlTU0wIo1RC11GTOx8B45BwkZEnduEMpTlIYnS/OOv5F+ThppBRhSo
         zyLo/Bcs1LxTnZTH8+HZpA513xXJEUlHafkzxKPyNB9nAx7WTiBz5ugK/DUtl6uJoYL6
         ZkOfug3WqQ1lXTftzZV8EOrO9cSj42qyMhxgZCWa/E0+aSHCdfEfLhIoFL/vdBk9JThw
         t8FZH6Rs21zOAnK7RI81UDM0jdzNDVanSz8sHgUQ/O8jj0L2rbcs7aMEhSFaETruZqM6
         yc22MdULCxrdvvfnSTGgUK5QNQHBWjBZtwZXWW18DVNMZ4O8zZZGT9Ep1Vibx51qCzCh
         6d+g==
X-Gm-Message-State: APjAAAV8EntPk/V8mAbshponEqudD49l1Cd9sXQKiwc1xl+G1mD6lH1a
        EguXYONQMOruOzi26x1WAJ3Y0VCP1z0=
X-Google-Smtp-Source: APXvYqxX1NtYOvBAqjA+CmqfXlrWdx0r1XIT8njws5CvJ/z/aBa2pmMzVStRmggOt/c0x/W2syQajw==
X-Received: by 2002:a17:902:8c89:: with SMTP id t9mr65874264plo.265.1556567637977;
        Mon, 29 Apr 2019 12:53:57 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l2sm39841783pgl.2.2019.04.29.12.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 12:53:57 -0700 (PDT)
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
Subject: [PATCH v3 1/3] power: supply: core: Add POWER_SUPPLY_HEALTH_OVERCURRENT constant
Date:   Mon, 29 Apr 2019 12:53:47 -0700
Message-Id: <20190429195349.20335-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429195349.20335-1-andrew.smirnov@gmail.com>
References: <20190429195349.20335-1-andrew.smirnov@gmail.com>
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

