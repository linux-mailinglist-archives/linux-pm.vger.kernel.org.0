Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB67A1083A3
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2019 15:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKXOJO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 09:09:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44235 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKXOJN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 09:09:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id d199so1330965pfd.11;
        Sun, 24 Nov 2019 06:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uiVaOYC0AJAeDJiNsTnIMMgr41e8eY8TpWvmzxTalS8=;
        b=UZIHl+FvynMquo91lmoV5lbWmLcB+8Iw8tQF+m0vCBO8UCd9CRAQcTeAd+sMHZP4jo
         B6Xmatc+2rgYJ+34ssDGYNBtJiUINZ7+QB/gQplVjthaNSrMy7CSwwU1ucQLlf6Giaof
         RmRShwUrp8NUVqYWsha6437Pq0+vhr3TLYELT1yPmV1/KZZmDjeJbQFOq3MaBxRqYQQl
         SHu6KL9a66DZesCDnoB59cQL5Rh1E/13ZazzHc7ARMdE7lHt6pFFCXdkGHuk2BCh37uM
         A2hSAc1RcaWOLGy67uLEvZGH2wuKAwZsFzYeDmcmMK3gnM/ALNPxjGQhAOJ1zNSS55O+
         yqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uiVaOYC0AJAeDJiNsTnIMMgr41e8eY8TpWvmzxTalS8=;
        b=uFylDnKrPaO6Nmgi1tavMINCYDwrQLnlnR83cYpC4RFCQagBui8i6sv2BOMxmAdq57
         Mzen7I9hno87+FhNAb3fdlFDzdYfRjhQ+3TABRUUnXPQuoOfQFPXYM3xv5W93KC5PSqT
         tf632b94GdNW44sRl49/A4iM3rR7ErrCXU8zcUnaP3kFyDP/Fzk88IzkCnOmHN/BhFyi
         4rIew1IkO1U7SXG642iOfzo635edMXIJp/+Xa9l0tFYOf0TeQzPhnLai0RgDNptkX+hr
         XTJoYiSh5XhEip1d/72f4tFXcX807qSfVAQJwhdiR69SrnEfTSpk7NPmQBWTQD4Ke/Sm
         s2DQ==
X-Gm-Message-State: APjAAAU8127VBFfg6nhL17eKFKofTgwNV9D98yOO8qElJV6RemKNJTas
        4+4FjnIRqxznQT+ZoIpFqH+YjBeR870=
X-Google-Smtp-Source: APXvYqxa+x5Ky0KmnA9MrXJ6wT3QpcqvpcitOx/D7jKeOjTqkBRfuQPdefSpwDVRKgldh3VsRGRMZQ==
X-Received: by 2002:aa7:8b1a:: with SMTP id f26mr8162545pfd.81.1574604552956;
        Sun, 24 Nov 2019 06:09:12 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id a3sm4816326pgh.91.2019.11.24.06.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Nov 2019 06:09:12 -0800 (PST)
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
Subject: [PATCH 1/8] add header file for kelvin to/from Celsius conversion helpers
Date:   Sun, 24 Nov 2019 23:08:43 +0900
Message-Id: <1574604530-9024-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are several helper macros to convert kelvin to/from Celsius in
<linux/thermal.h> for thermal drivers.  These are useful for any other
drivers or subsystems, but it's odd to include <linux/thermal.h> just for
the helpers.

This adds a new <linux/temperature.h> that provides the equivalent inline
functions for any drivers or subsystems.  It is intended to replace the
helpers in <linux/thermal.h>.

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
 include/linux/temperature.h | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h     |  1 +
 2 files changed, 40 insertions(+)
 create mode 100644 include/linux/temperature.h

diff --git a/include/linux/temperature.h b/include/linux/temperature.h
new file mode 100644
index 0000000..d7e2aed
--- /dev/null
+++ b/include/linux/temperature.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TEMPERATURE_H
+#define _LINUX_TEMPERATURE_H
+
+#include <linux/kernel.h>
+
+#define ABSOLUTE_ZERO_MILLICELSIUS -273150
+
+static inline long kelvin_to_millicelsius(long t)
+{
+	return t * 1000 + ABSOLUTE_ZERO_MILLICELSIUS;
+}
+
+static inline long millicelsius_to_kelvin(long t)
+{
+	return DIV_ROUND_CLOSEST(t - ABSOLUTE_ZERO_MILLICELSIUS, 1000);
+}
+
+static inline long deci_kelvin_to_celsius(long t)
+{
+	return DIV_ROUND_CLOSEST(t * 100 + ABSOLUTE_ZERO_MILLICELSIUS, 1000);
+}
+
+static inline long celsius_to_deci_kelvin(long t)
+{
+	return t * 10 - DIV_ROUND_CLOSEST(ABSOLUTE_ZERO_MILLICELSIUS, 100);
+}
+
+static inline long deci_kelvin_to_millicelsius(long t)
+{
+	return t * 100 + ABSOLUTE_ZERO_MILLICELSIUS;
+}
+
+static inline long millicelsius_to_deci_kelvin(long t)
+{
+	return DIV_ROUND_CLOSEST(t - ABSOLUTE_ZERO_MILLICELSIUS, 100);
+}
+
+#endif /* _LINUX_TEMPERATURE_H */
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e45659c..ed549e4 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -14,6 +14,7 @@
 #include <linux/idr.h>
 #include <linux/device.h>
 #include <linux/sysfs.h>
+#include <linux/temperature.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/thermal.h>
 
-- 
2.7.4

