Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA8B1083AE
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2019 15:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfKXOJf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 09:09:35 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40657 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKXOJf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 09:09:35 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep1so5255938pjb.7;
        Sun, 24 Nov 2019 06:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p4GXpFBwRIhrFQe2rae/GEBMEDnMv/ArRbrbnanSG1w=;
        b=AG9JNeOFbszeO/8b9h/bQ0hRUJwthd4/ubsKqui3xK7gywbStUqgNrrNdEEmL7Tar7
         gu5sVIqxXEiiJEJfiiWr0exookUZuvNrXhNg5iUuzt5w/A/c/SOsvqi51ucqkB6GOaUP
         cOd/1mr/huELIW57Ks0kTXf70cNCp3pYFGWLvENGMt7WViPU7dV52Au+I2yoMo+M4rab
         pX98IWw9YPeF7LlK/HfjcSTxCK8xcQGMs4SjHC+VMOeuKt45hg59QuWVDMyGZHTfThXB
         2jIFLnkZeb40aZ65gQsXv3sirdkLXc032HKFsM+R5p/6ARrIa/6cO9qF4CIG0Q2sXRPh
         lwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p4GXpFBwRIhrFQe2rae/GEBMEDnMv/ArRbrbnanSG1w=;
        b=szHX88ZI9QUBoTb331AgE4Gfa7jgpLmehnSWhdUe6B0AAVIOdCS9KlY8+sp96DmbCK
         parteqtKORkVn0kZpeFAiNRYDLZzj3mzoY2rEcOLKLa83QcX05t+mlzCUjagCpcolw+9
         dooTMb81Oq6UElaW5YMV1gJEOih9vGS2srFxor7RvzDOy0yO2e5bIDw990JoLIpgMkIJ
         BzSRT+hdQ6EtHPghOC4TJ0n3a3ed49gmFqixPUvUmieE2DYmUiYTnFSHERh0D7c7lr5T
         6rxILWi6eMub+/ZCpYuikbIhi9FtW3LR5wYlot+9GTLU2LLRZxIkmrx+8O6kjB1BV1NN
         6BFA==
X-Gm-Message-State: APjAAAVYnbAgguF6/7VYQeTdfXxboLD0g6ls6U9uQsB1TqUtVp4xMUni
        TjKDhdVj/uIi99CwoXh7QyT4LJaUTaw=
X-Google-Smtp-Source: APXvYqwtRVmCG1ARmbdLuLN5TLXRWlDXeduPpXKaQqk9x+tN4bppuLQSOjFIMlVZ00QWYUoX3M3URg==
X-Received: by 2002:a17:902:7887:: with SMTP id q7mr23881753pll.86.1574604573851;
        Sun, 24 Nov 2019 06:09:33 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id a3sm4816326pgh.91.2019.11.24.06.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Nov 2019 06:09:33 -0800 (PST)
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
Subject: [PATCH 5/8] thermal: int340x: switch to use <linux/temperature.h> helpers
Date:   Sun, 24 Nov 2019 23:08:47 +0900
Message-Id: <1574604530-9024-6-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This switches the int340x thermal zone driver to use
deci_kelvin_to_millicelsius() and millicelsius_to_deci_kelvin() in
<linux/temperature.h> instead of helpers in <linux/thermal.h>.

This is preparation for centralizing the kelvin to/from Celsius conversion
helpers in <linux/temprature.h>.

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
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 75484d6..1e653f6 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -34,7 +34,7 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 		*temp = (unsigned long)conv_temp * 10;
 	} else
 		/* _TMP returns the temperature in tenths of degrees Kelvin */
-		*temp = DECI_KELVIN_TO_MILLICELSIUS(tmp);
+		*temp = deci_kelvin_to_millicelsius(tmp);
 
 	return 0;
 }
@@ -116,7 +116,7 @@ static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
 
 	snprintf(name, sizeof(name), "PAT%d", trip);
 	status = acpi_execute_simple_method(d->adev->handle, name,
-			MILLICELSIUS_TO_DECI_KELVIN(temp));
+			millicelsius_to_deci_kelvin(temp));
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -163,7 +163,7 @@ static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	*temp = DECI_KELVIN_TO_MILLICELSIUS(r);
+	*temp = deci_kelvin_to_millicelsius(r);
 
 	return 0;
 }
-- 
2.7.4

