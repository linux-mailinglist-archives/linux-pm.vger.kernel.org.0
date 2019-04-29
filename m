Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33C3DBA0
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 07:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfD2FsI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 01:48:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46701 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfD2FsG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 01:48:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id j11so4742585pff.13;
        Sun, 28 Apr 2019 22:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VW37A7CK8zNP+puxGj5PzGbX48/U7vlPhB5EcPFYbg=;
        b=Qyf1fENV7j7gZgJ6TmSmVGl9uzWk+GQMzfGHnrxqpyGyqoNdcH5k9vhZasXipNV+28
         lG1Pzkb+66XJwproEs/bYg07ScDOPrbnpKCiIO3tSh52+qYHYgpvfHFO+HBnlIEXtbvg
         NSHbzozFW2+4LD+QQE74NesC0ZtN4IEB5WpZ1uAEgcHkdexjj1GI485ln0KWM2xJmw0k
         zy99Tofp8rOWucCRib+Gp/AzUh+eFvaRkm/Y78yeImqrbDTLGTHapj53/7kkrSR+w2Gu
         l4ZPp2hHpKN1eEjUu+j0lQx3VKJAWj7gvcdbB5rkab549tta57g+g9hqDT0fVBImXFw8
         U15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VW37A7CK8zNP+puxGj5PzGbX48/U7vlPhB5EcPFYbg=;
        b=ckfF3WfilpSn6CmExIXyTSXUFNfWsjJw9FTTIIooRlYT1bhblldTi2v4CRkgrHhtXf
         b2VqitoZ6fk8+1FMTZ39AWcH4xfvsDYg6HVu1YOPK/m19knq+vG7IrHrLxeLZk7ntHRo
         piOuS0d+kh7jLCIk5ofRa5zDQ91iYdXM+Tbcg93q6KxYABNdS4Ei/lz1GDU+gRddqYGw
         Scul7PeSfOMDCCrUG28bEG36hYWt6C0n9QvCdFTX8cYN1+R7iSxHrBpFhmXul5324/j0
         OXrnLQyIm+8ix4+C58JLanRbNfUh57GJAFNEdYYjDe+EMK6AVxAzMst+rBoiY81SnH/0
         HYCw==
X-Gm-Message-State: APjAAAWAA9YSoraBpYILdIQHy/Z3BQ+TqmrUabmi8r5Ev+JY03x6qSNs
        uSLSX/ZZtVgvlSRpWHd/EYSLhdjJc5E=
X-Google-Smtp-Source: APXvYqzyMQ+SR5eQGHpimMe7wlsV50oEX9PDI38GBkP1NISWIAH9TmIa9sRVtnle+Gvzwv0SaumJGQ==
X-Received: by 2002:a63:1160:: with SMTP id 32mr6659179pgr.106.1556516885633;
        Sun, 28 Apr 2019 22:48:05 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id g10sm37856567pgq.54.2019.04.28.22.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 22:48:04 -0700 (PDT)
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
Subject: [PATCH v2 1/3] power: supply: core: Add POWER_SUPPLY_HEALTH_OVERCURRENT constant
Date:   Sun, 28 Apr 2019 22:47:39 -0700
Message-Id: <20190429054741.7286-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429054741.7286-1-andrew.smirnov@gmail.com>
References: <20190429054741.7286-1-andrew.smirnov@gmail.com>
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

