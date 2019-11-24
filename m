Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 501081083A8
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2019 15:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKXOJZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 09:09:25 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33782 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKXOJY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 09:09:24 -0500
Received: by mail-pj1-f67.google.com with SMTP id o14so5266474pjr.0;
        Sun, 24 Nov 2019 06:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GqKt6zdWfZywezSW3C4ZkPtud9ch/0Uh/6q3QjZGy/0=;
        b=lNhNJTaVbOYkgvALBg5TYxMoq8zHMyfVOu3sxGp7bmwZFD7wBp4Y1O15pm8Oz3YqTT
         QHYl3RYDZUBvL4JRBlICIV4t5EAUfVooVi999U9O8IpccoBPzz2Tx6DytcNdG+wYBDh/
         5HqaVGDNHbEEDib3zIf4hSbQmCkO2umeNYEMmqBmKQruaVQIFMyzbfA0zl7tFlQWip9N
         Hdbm5rsD48oZ64JjDYvAsyVCipezgtYHBNNPi8JLYzwRhdaG4hOzCBR0S5fig4zc4rHD
         +rdOHy/VgFex1Eqdp9H7p+E4YXM/KtNYUNlHkOnZf81/IPH+SkxfHIXoPV/oUn7WDBTM
         WjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GqKt6zdWfZywezSW3C4ZkPtud9ch/0Uh/6q3QjZGy/0=;
        b=eur/KyBqxq1IO71cF4OVSsuNns8+C579EGkW+AdOAfq0DIPA2r/sr1fGjCMao9AgHq
         ZguSUWRCHipAexin7PNcQ8ffyZp69NN62Qy32R3GuvtCBZZgmAtMkROSRG4rpL6phaOZ
         JNsQAPr53tZQV68+9m83Ulo5SN1qiIhGUBkWd9DxfXfgh7KMh8H9/RNzeMIEIcbbyQm7
         l3Je9N2UrlgLh3/f2cIZxWv1K3LYVF5jaqusOZMpnmT+JOvaRY+R1ok/J2VQXzNiXyI3
         mFAd1r2pYTyDC0EhlVD4m7V0sbN3vtx3Jf4lbZoIcLDTp9vGiC9SkXJys4OOnC5iTusS
         08Sg==
X-Gm-Message-State: APjAAAXGI4wu6B9mbp+qrImTusOrBCEJoieC5m6QalPfZ2qcgA4LD6lI
        PBBPbivvCpQ8EKMg2v84f4o=
X-Google-Smtp-Source: APXvYqyk+tVzVqLTp1q5GIHaF/zWFrbxTxJ6dlTdJpNb8Ke8+dFQc2bkHdcu0WkqO7ewXlbG9toS4A==
X-Received: by 2002:a17:90a:c56:: with SMTP id u22mr31571968pje.24.1574604563465;
        Sun, 24 Nov 2019 06:09:23 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id a3sm4816326pgh.91.2019.11.24.06.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Nov 2019 06:09:22 -0800 (PST)
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
Subject: [PATCH 3/8] platform/x86: asus-wmi: switch to use <linux/temperature.h> helpers
Date:   Sun, 24 Nov 2019 23:08:45 +0900
Message-Id: <1574604530-9024-4-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The asus-wmi driver doesn't implement the thermal device functionality
directly, so including <linux/thermal.h> just for DECI_KELVIN_TO_CELSIUS()
is a bit odd.

This switches the asus-wmi driver to use deci_kelvin_to_millicelsius() in
<linux/temperature.h>.

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
 drivers/platform/x86/asus-wmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 821b08e..6a1a2f9 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -33,7 +33,7 @@
 #include <linux/seq_file.h>
 #include <linux/platform_data/x86/asus-wmi.h>
 #include <linux/platform_device.h>
-#include <linux/thermal.h>
+#include <linux/temperature.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 
@@ -1512,9 +1512,8 @@ static ssize_t asus_hwmon_temp1(struct device *dev,
 	if (err < 0)
 		return err;
 
-	value = DECI_KELVIN_TO_CELSIUS((value & 0xFFFF)) * 1000;
-
-	return sprintf(buf, "%d\n", value);
+	return sprintf(buf, "%ld\n",
+		       deci_kelvin_to_millicelsius(value & 0xFFFF));
 }
 
 /* Fan1 */
-- 
2.7.4

