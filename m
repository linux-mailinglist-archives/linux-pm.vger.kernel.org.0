Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51D0E1083A5
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2019 15:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfKXOJU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 09:09:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41146 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKXOJT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 09:09:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id p26so5961006pfq.8;
        Sun, 24 Nov 2019 06:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=czC6nSQ5Mc9CJVDHU8aRwsMtho/ZtmD5fWxjP8fTWFQ=;
        b=GtT9zO/ttEp5EBxeDarWq2F13mveIYiDxKZ+MRPLPaXmXvU0VbpaI+P7v8Y3ikAyBS
         TFvreqga/+8htA8ez08lE8xi7POJ9OOpHQ6t6Jcn8oVr+EFKYcfbyS8pp5zB/c0A1Jk9
         lvvfUmieleCnquwCneIlKLcCcROA4HGk40h21iUwvZFb00MvAfbxehG4CrGcVENsG7Wq
         IHWqhzhWmc8k2RT129cEMiNI2xhfxyrP7GzYg3wc5mifpsg+NSpVVZQ8tPFwKBuIveQx
         amy6ltiZRgfG1VR6PJy6KcADSBkSsUpyDhLEtFAZ2b/EaDg69FUZIXIGyCM5/FZmdN/g
         hhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=czC6nSQ5Mc9CJVDHU8aRwsMtho/ZtmD5fWxjP8fTWFQ=;
        b=mKmab9yq65CL4lCoDxbBgRg0nf5yB1axP53lvgwyzuzHKKNHgkB9lnnHDo+uDVYoM5
         e7BVgQJbevDNA5yV6rKtK8xZGC82uEYz1TicgL1QNE11PWcR4wl73DjLCkj2aiDuXBtT
         +Wx4zzbERHOHc0O+Sbjd+jGlH572uCXysV3p1NsZYUjGdFmFhS6/zKfnrUfk9tKbHbEU
         S3g9tcwNCnjmE2qZfUUIFlsBgFE6Bfluo5PGNJcJe3liPWGgWoc/k5dNEvR25KXq4Rhn
         u7FB3cZf7Gla9zqtvw440WtBRZlLSI4uN/cWpT9qlqxnup6IJisNYtQTZmtcyiLBbd/d
         dsPw==
X-Gm-Message-State: APjAAAV7yNkkMJLy9seb0jJRm4elwPJOAV0M4I8ydjGbrS9QNOrBGkmS
        VGnSCVHceuGm+NC7creJna1qemaVHYI=
X-Google-Smtp-Source: APXvYqxcacdLA/j7CmvnEt1MVmIqsOc+mODcqUPaCaS2Ilz2oZL6AlDj6CpF8oRmisR4xhh9U5fpBg==
X-Received: by 2002:a63:1718:: with SMTP id x24mr24924884pgl.1.1574604558045;
        Sun, 24 Nov 2019 06:09:18 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id a3sm4816326pgh.91.2019.11.24.06.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Nov 2019 06:09:17 -0800 (PST)
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
Subject: [PATCH 2/8] ACPI: thermal: switch to use <linux/temperature.h> helpers
Date:   Sun, 24 Nov 2019 23:08:44 +0900
Message-Id: <1574604530-9024-3-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This switches the ACPI thermal zone driver to use celsius_to_deci_kelvin()
and deci_kelvin_to_celsius() in <linux/temperature.h> instead of helpers
in <linux/thermal.h>.

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
 drivers/acpi/thermal.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index d831a61..bd9b6eb 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -297,7 +297,9 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			if (crt == -1) {
 				tz->trips.critical.flags.valid = 0;
 			} else if (crt > 0) {
-				unsigned long crt_k = CELSIUS_TO_DECI_KELVIN(crt);
+				unsigned long crt_k =
+					celsius_to_deci_kelvin(crt);
+
 				/*
 				 * Allow override critical threshold
 				 */
@@ -333,7 +335,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		if (psv == -1) {
 			status = AE_SUPPORT;
 		} else if (psv > 0) {
-			tmp = CELSIUS_TO_DECI_KELVIN(psv);
+			tmp = celsius_to_deci_kelvin(psv);
 			status = AE_OK;
 		} else {
 			status = acpi_evaluate_integer(tz->device->handle,
@@ -413,7 +415,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					break;
 				if (i == 1)
 					tz->trips.active[0].temperature =
-						CELSIUS_TO_DECI_KELVIN(act);
+						celsius_to_deci_kelvin(act);
 				else
 					/*
 					 * Don't allow override higher than
@@ -421,9 +423,9 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					 */
 					tz->trips.active[i - 1].temperature =
 						(tz->trips.active[i - 2].temperature <
-						CELSIUS_TO_DECI_KELVIN(act) ?
+						celsius_to_deci_kelvin(act) ?
 						tz->trips.active[i - 2].temperature :
-						CELSIUS_TO_DECI_KELVIN(act));
+						celsius_to_deci_kelvin(act));
 				break;
 			} else {
 				tz->trips.active[i].temperature = tmp;
@@ -1087,7 +1089,8 @@ static int acpi_thermal_add(struct acpi_device *device)
 	INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
 
 	pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
-		acpi_device_bid(device), DECI_KELVIN_TO_CELSIUS(tz->temperature));
+		acpi_device_bid(device),
+		deci_kelvin_to_celsius(tz->temperature));
 	goto end;
 
 free_memory:
-- 
2.7.4

