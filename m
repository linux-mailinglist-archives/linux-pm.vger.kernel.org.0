Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8520F10CACC
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 15:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfK1OzY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 09:55:24 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37259 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK1OzX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 09:55:23 -0500
Received: by mail-pj1-f65.google.com with SMTP id bb19so8455023pjb.4;
        Thu, 28 Nov 2019 06:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KOk1Zu1Ql454tFPs2kZw5FfHjnyPTzMrmCfexC/lRs8=;
        b=PUx6zKO3n9KG7pm9Qk5LBg/cFVNRMxPNChPn/sB7wL8qLgLFBctSNutljHfYN60Uzj
         6z+GKH89YGgLqCEzGu5GAw7Z6kdiScXCHYIav+6bXSRzfMz5qr43OBlvdbLH0uTZfvT1
         KqMC854IvMpRm2UaBumtVDBNTF8qTtOyC50qjHeAwpNHLfIXyY12rX2f0PrYRSA3O03R
         POQCifcpPOoiUbUIhmcrfSUMMv3Sgraxn/v34nM6/767YYyTUB6qetrVpIuAfIIsSW+z
         CM7K11Jey8gqcjfknmDVk1zui1u3VzlQU+me6AXnOQ76YCFa13zhDnuc31Q9kh8fvOS/
         jflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KOk1Zu1Ql454tFPs2kZw5FfHjnyPTzMrmCfexC/lRs8=;
        b=EUbTtPpTvaFklOFX7Y8CehA1iHMCPDD187Iu1X0hsZheyX/76/TZ4ls9YNYTULQjO0
         P0Lx3PR4sTkfxEoJ1kss3Yyi02wa9kAnOXhO4+871zsBilkL8jGh1nO695PGzBzowRRv
         fVrVvmB3pVCU16ZZkfgLpesx9sM8d7b9XvbTPkEn2IYLngfg04ChR3q7aVp0WhFHBYe8
         NnQBqieyMRwMVM73qtIZmkTXNQ0D5tKPhkXrEyoov/1QrGvXbRPK8ymRCRAVLOWs60fn
         J3tULzDgxDzpqTi57s+o5VIDT36F6n7z36IgApv9RecRLFcAuWTp0Gzr/0ou7Qno7ayb
         NnNw==
X-Gm-Message-State: APjAAAUh1AGehoxmIViY6oW789e4cwyWTXl09xEGYo3U2P9WWaMp3Qe6
        JJJjI0IqZncZfDOaxFiXXx8=
X-Google-Smtp-Source: APXvYqz4ojDDuagtER2KZtGw/qJt9x/inm9T4ft8+dEsuEU1iGQ6cYCvDasNxYdsCl3BC1bGnjHbNg==
X-Received: by 2002:a17:902:8d81:: with SMTP id v1mr9881555plo.289.1574952922811;
        Thu, 28 Nov 2019 06:55:22 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8015:e854:5ef0:f52e])
        by smtp.gmail.com with ESMTPSA id z11sm22282563pfg.117.2019.11.28.06.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 06:55:21 -0800 (PST)
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
Subject: [PATCH v2 6/8] thermal: intel_pch: switch to use <linux/temperature.h> helpers
Date:   Thu, 28 Nov 2019 23:54:37 +0900
Message-Id: <1574952879-7200-7-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This switches the intel pch thermal driver to use
deci_kelvin_to_millicelsius() in <linux/temperature.h> instead of helpers
in <linux/thermal.h>.

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

 drivers/thermal/intel/intel_pch_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 4f0bb8f..505a5d2 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -13,6 +13,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/thermal.h>
+#include <linux/temperature.h>
 #include <linux/pm.h>
 
 /* Intel PCH thermal Device IDs */
@@ -92,7 +93,7 @@ static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
 		if (ACPI_SUCCESS(status)) {
 			unsigned long trip_temp;
 
-			trip_temp = DECI_KELVIN_TO_MILLICELSIUS(r);
+			trip_temp = deci_kelvin_to_millicelsius(r);
 			if (trip_temp) {
 				ptd->psv_temp = trip_temp;
 				ptd->psv_trip_id = *nr_trips;
-- 
2.7.4

