Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9559E10CABB
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 15:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfK1OzC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 09:55:02 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:42303 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1OzB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 09:55:01 -0500
Received: by mail-pj1-f65.google.com with SMTP id y21so11998139pjn.9;
        Thu, 28 Nov 2019 06:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g0HiFEqIr34ap3Bh6iBqZPv3kmztxiAkeFZgF3cKXMU=;
        b=uiVu1qxsLxyPYPoq+O64OM6AHYD3Bo6KqoMZ3JLMT5lLAJOhBs5sZYiog6g3UcNpht
         4TR1HNXXKqSgpj+SWe7c7HEulw0LAiORFfq0cChrdGDGczV+SsU2JZ7HQ+ziNQT9wJ4Y
         MB7NcLDAssHLAZzKKyWDhP1JsLR1j4AN2Z7uedi3TVVqn0N6kDtsGenJktAVbo9yd0Ld
         WfHv7NZjr2/nBCN4P6UZVcHEHfRC/JE18aY7IkPJTJBFHWQcbHN6RXbLLujov3a+Sda0
         PZpGMBGIANYl3N1CGMyOPYLww9mOgZtSxc+1CSWJ9aAa3WfuFENMCy2tpfPz6GWN1MQI
         y+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g0HiFEqIr34ap3Bh6iBqZPv3kmztxiAkeFZgF3cKXMU=;
        b=gK/iEPe7fqXa5fGKQB+IisAaIL224COts3oCmnasqahfgAt+PsuyE7gMjEh8xWI88b
         boctQfI9pNV1TIY3PP6gyKfz4zEx+4gQQl+7mmj8BxP9cXbXr9TnZ3X0NmUY2dqLO8z1
         BiW13UDoC3jjnKlIrzjPgGAIddDiARs6ZQ82UC8fWIfLp0Q5dmK/KkqVa9R3c6ZQVogD
         Ue78WqQ+lgYo7LrHoeeI0+5tgrfHzRbLsEDNwguJg7xh9R3l/FAARPgJXodtwp0WA7Nj
         AuN7aY4KJXsqEo3s4QzOuv34LPsTXTm9uViXZ9+sUjgYD3I9ezGkHKNW+vQ7st7XRIB5
         cImA==
X-Gm-Message-State: APjAAAVnZbWJyGyl1MqngiLs9R9v394H3sw5goJneQBMGEGodZm5kgNA
        EmtCNtrMZ0vwEGkmNFoS8WOvuqwIWvs=
X-Google-Smtp-Source: APXvYqxwvjfJwJ9RVZBGU55qS1UZ7w101xpLRriZKYh/OSQlyuip6R8NkJJ+WBD7ODgUVFOLfSnyGg==
X-Received: by 2002:a17:90a:330c:: with SMTP id m12mr13090381pjb.18.1574952900858;
        Thu, 28 Nov 2019 06:55:00 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8015:e854:5ef0:f52e])
        by smtp.gmail.com with ESMTPSA id z11sm22282563pfg.117.2019.11.28.06.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 06:55:00 -0800 (PST)
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
Subject: [PATCH v2 1/8] add header file for kelvin to/from Celsius conversion helpers
Date:   Thu, 28 Nov 2019 23:54:32 +0900
Message-Id: <1574952879-7200-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
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
- add deci_kelvin_to_millicelsius_with_offset() in linux/temperature.h
- stop including linux/temperature.h from linux/thermal.h

 include/linux/temperature.h | 51 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 include/linux/temperature.h

diff --git a/include/linux/temperature.h b/include/linux/temperature.h
new file mode 100644
index 0000000..679e70a
--- /dev/null
+++ b/include/linux/temperature.h
@@ -0,0 +1,51 @@
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
+/**
+ * deci_kelvin_to_millicelsius_with_offset - convert Kelvin to Celsius
+ * @t: temperature value in decidegrees Kelvin
+ * @offset: difference between Kelvin and Celsius in millidegrees
+ *
+ * Return: temperature value in millidegrees Celsius
+ */
+static inline long deci_kelvin_to_millicelsius_with_offset(long t, long offset)
+{
+	return t * 100 - offset;
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
-- 
2.7.4

