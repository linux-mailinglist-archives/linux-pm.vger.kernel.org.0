Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17ED41083B9
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2019 15:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfKXOJu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 09:09:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44826 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKXOJu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 09:09:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id e6so5745617pgi.11;
        Sun, 24 Nov 2019 06:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HlZyESYLe6A5DAq1XkhuEkfPsYgeQ0ev4dh7nFf6DlA=;
        b=aF+EL/uaBuy3BwpoI2oa5LtqP9+p1sZ6VjixxtI6M70GSLCINBULaM3WNiSvJ1WIrZ
         xIp52aIi0nJQeAktwdoDbbpWpUGRijeoTLe1MAm4hB4Z4WYl9NAkew4iN56rugjskot4
         yt0PkQGxQXJReAVRmTDpxgmvwAEprEGHPYHel8zMm9c4Pbf0nfdxKiEAsstWT0AfLR8r
         bDsPU9XMtHOa1IO5HUXITzT66ktxxcPF+Z9kAYhRpX5dnnkPp6PRQV0tZTGgJfpG2Hcz
         Q8Q4/16zkCk9xffjh+a8YQwbn/z/50qSQu4mMZdfby+ch8XiXZOg7GCvCrNQfdl2VLIo
         mnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HlZyESYLe6A5DAq1XkhuEkfPsYgeQ0ev4dh7nFf6DlA=;
        b=iV6zmf0RUu6hsg8v6w0y/b39yhmMlbUsKsvq4E9CQKrm0hRM9iNB2f86trKuP+Q+WA
         gD6pML8cxJKgQL40qqWn0O/qK3Ew1R2rNuUTKm1t62PbLteA6yTnmY9x8fOtAH1uyexi
         LkeJO7pvTRgmohvnwo9sHAYbcJp9FjPOL1Mwm8x2a5+QuTAVN0agXp8gYTiBVk2EfCZy
         iv7hA9zEx23uDwNzWkfxI7X4iQMwAHJ0Ls2YNcWKdeKZrURdCl5u41lV0KtEL/mXgJkc
         2j46iSBjibqqJZC6kucAfWR2FJ7CwFRwtkCd8XlzIQJgkVBMCw8TqUc0tzGoD1pqxpir
         BQDA==
X-Gm-Message-State: APjAAAUUtTVlA0IgxxvpbVF5ju3idunD0fLK29OuFE5+ylWVwoEPACXC
        LrbNAhrQaUBdK8t/MtIde8QYEYl+35g=
X-Google-Smtp-Source: APXvYqx7K4Gt18amX+hLKSOMgjI0zyd/A3QfgpeceRkltPJbTjqHafxczzSCZqTAx0AlbO7TqjQWng==
X-Received: by 2002:a62:8789:: with SMTP id i131mr28078223pfe.221.1574604589140;
        Sun, 24 Nov 2019 06:09:49 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id a3sm4816326pgh.91.2019.11.24.06.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Nov 2019 06:09:48 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 8/8] thermal: remove kelvin to/from Celsius conversion helpers from <linux/thermal.h>
Date:   Sun, 24 Nov 2019 23:08:50 +0900
Message-Id: <1574604530-9024-9-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This removes the kelvin to/from Celsius conversion helpers in
<linux/thermal.h> which were switched to <linux/temperature.h> helpers.

DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET() is only used by ACPI thermal
zone driver and the usage is specific to the driver.  So this macro
is moved to the ACPI thermal driver rather than generic header.

Cc: Sujith Thomas <sujith.thomas@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/acpi/thermal.c  |  2 ++
 include/linux/thermal.h | 11 -----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index bd9b6eb..370e114 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -42,6 +42,8 @@
 #define ACPI_THERMAL_MAX_ACTIVE	10
 #define ACPI_THERMAL_MAX_LIMIT_STR_LEN 65
 
+#define DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(t, off) (((t) - (off)) * 100)
+
 #define _COMPONENT		ACPI_THERMAL_COMPONENT
 ACPI_MODULE_NAME("thermal");
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index ed549e4..06e1695 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -33,17 +33,6 @@
 /* use value, which < 0K, to indicate an invalid/uninitialized temperature */
 #define THERMAL_TEMP_INVALID	-274000
 
-/* Unit conversion macros */
-#define DECI_KELVIN_TO_CELSIUS(t)	({			\
-	long _t = (t);						\
-	((_t-2732 >= 0) ? (_t-2732+5)/10 : (_t-2732-5)/10);	\
-})
-#define CELSIUS_TO_DECI_KELVIN(t)	((t)*10+2732)
-#define DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(t, off) (((t) - (off)) * 100)
-#define DECI_KELVIN_TO_MILLICELSIUS(t) DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(t, 2732)
-#define MILLICELSIUS_TO_DECI_KELVIN_WITH_OFFSET(t, off) (((t) / 100) + (off))
-#define MILLICELSIUS_TO_DECI_KELVIN(t) MILLICELSIUS_TO_DECI_KELVIN_WITH_OFFSET(t, 2732)
-
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
 #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
-- 
2.7.4

