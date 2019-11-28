Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 844EF10CACA
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 15:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfK1OzU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 09:55:20 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34421 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK1OzT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 09:55:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id h13so11722208plr.1;
        Thu, 28 Nov 2019 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rl/Muaad0JKZvHEYUN/4/vVrZyhpWqkrNfXezrDAyeU=;
        b=VNGiuixpHdhZlKCdI1lUbF3zqtjKhA8JjC+y8CfCWFSPFQ0BQz3Lmb0QLJTeQzeeOp
         I3MeGV7hUuAKdiWZjr9nz5YeeVEaBxxsWo7QfzwE5sJCF8N4jcodOUIv88gm2xsi9+R7
         +BQRtKJq5MV1L8ufJnXe56xOngFxMRJyrlT/Nc8R94EMwK7GJn8AooBCxywnqUUpcvPZ
         yksVDGyhleVo0RnEBJS31FGBfySon8G+y0S1+6NAYU4EZpHqlqBPdZ3qbFskqmJ4z874
         pzMm7HaYHErXanglixeEhcaG4g6dNNTXqgAj/Pc2fw8A1uCma13Pr826ept1srbPcqFL
         74TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rl/Muaad0JKZvHEYUN/4/vVrZyhpWqkrNfXezrDAyeU=;
        b=R2rruXsmDqp4XijQIlyW2B3ma/CyU1F96wp/A3VmJsxA4YPiWNhaOT1GSPWClbj3PW
         YHNy3krA1DfDNyavtd47/cQhfFtyNnNbrit2MKaAdJoiJiA2wMHIBbS28zrbnwx/NtPg
         KwVQjX6I/o7x+3HTsa1o3Vil0JvIOmGLaIJCbEHqmo2hLZKnj2idPvJT0pVRVvSp/0sR
         cR7AqnRNKz/NKNyuO/pVHbyKyXXh9mzOU6WkuVnhpqeDqtYepVE/gty9tbEi8ZmyX1lc
         wFLqPz25JQkXz+ZSD9ri109dp3VVa9ltSO1IEqnoxY5vIlAyBaAY/AcO68I5orGCROdf
         PNzA==
X-Gm-Message-State: APjAAAUfyyaORh4MiTeb2bkTFKRIy23GdKPswXhwykgqf+H2A7s4Q6ul
        2B0iGozseDT1gZPGO41TNplLdbQUQbA=
X-Google-Smtp-Source: APXvYqwR27zrU/EiAbDRNlN1A8TmOl4w2Fmgs7jCyn1WoiQAAB82sxWB2twhBCfOfzKVYrGHmqrS8Q==
X-Received: by 2002:a17:90a:48:: with SMTP id 8mr12600637pjb.82.1574952918403;
        Thu, 28 Nov 2019 06:55:18 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8015:e854:5ef0:f52e])
        by smtp.gmail.com with ESMTPSA id z11sm22282563pfg.117.2019.11.28.06.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 06:55:17 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 5/8] thermal: int340x: switch to use <linux/temperature.h> helpers
Date:   Thu, 28 Nov 2019 23:54:36 +0900
Message-Id: <1574952879-7200-6-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This switches the int340x thermal zone driver to use
deci_kelvin_to_millicelsius() and millicelsius_to_deci_kelvin() in
<linux/temperature.h> instead of helpers in <linux/thermal.h>.

This is preparation for centralizing the kelvin to/from Celsius conversion
helpers in <linux/temperature.h>.

Cc: Sujith Thomas <sujith.thomas@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
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
* v2
- include <linux/temperature.h> explicitly from thermal drivers
- fix s/temprature/temperature/ typo in commit log

 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 75484d6..6658cc7 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/temperature.h>
 #include <linux/thermal.h>
 #include "int340x_thermal_zone.h"
 
@@ -34,7 +35,7 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 		*temp = (unsigned long)conv_temp * 10;
 	} else
 		/* _TMP returns the temperature in tenths of degrees Kelvin */
-		*temp = DECI_KELVIN_TO_MILLICELSIUS(tmp);
+		*temp = deci_kelvin_to_millicelsius(tmp);
 
 	return 0;
 }
@@ -116,7 +117,7 @@ static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
 
 	snprintf(name, sizeof(name), "PAT%d", trip);
 	status = acpi_execute_simple_method(d->adev->handle, name,
-			MILLICELSIUS_TO_DECI_KELVIN(temp));
+			millicelsius_to_deci_kelvin(temp));
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -163,7 +164,7 @@ static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	*temp = DECI_KELVIN_TO_MILLICELSIUS(r);
+	*temp = deci_kelvin_to_millicelsius(r);
 
 	return 0;
 }
-- 
2.7.4

