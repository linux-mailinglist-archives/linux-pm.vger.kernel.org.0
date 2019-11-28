Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7734510CAC5
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 15:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfK1OzP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 09:55:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40003 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfK1OzO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 09:55:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id i187so9091763pfc.7;
        Thu, 28 Nov 2019 06:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XLU+RhnbOLO++kk3A2l2hX8YNotokH7UjGIfreihyFk=;
        b=OZfJdX6whHMuR6GPApqn8rRuOEAnRf3w5c08IbXIUPnDI1gkAXOeEWealwKTYg1aLG
         11ye6u77N8A2CX+effHDLr1fku3ylPiH3hhhZqlmY3KN0gbLXXS6Z5Q0bAE2f/jcTSwn
         nMLvypyNuRxsTBdEVODvH8U/Xz+FQe4c88fqRuKFL9/BzSY2weg1rA8zg+63sqyQXNvb
         skqYPRd7XR+mT1G/dHIBao98RWWhcDBBTI9lehVrwK79KZyGhK4oyWwj9nGRV3b2spmU
         7cS5vO2Dk3x4plo5u9YFJLUgfjBJ8lKXFcEo7khVKhPa+AlMyTxPh4yq7QCck4JXmJlV
         dlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XLU+RhnbOLO++kk3A2l2hX8YNotokH7UjGIfreihyFk=;
        b=aQVb0Sf5PYx4Kijc09TdCLPCaEX4Z4JbZ5raxfxEVUDYDd5UndUv7R37hmRp/RqSVM
         04HXzdaLAEmlnndYdbYmIYJXFUqkj7dkgVj1FDeO3P+eZPdrDRsZhJzybleo/rGEg+xp
         Ph7ZnGq7wOcDMDEL4Z/V58gmiOgWE9nkhIvnzkoWkSN9Ahzhfq1S/gRBdH+iVOv2J/67
         cKge7KO5ksnJKv5/5+CXZK+uX9KBMWZInmq2xaPATJr1iydngwG8LVmDRVqIITjyuMW+
         OqOzPRZpNRKOqg2O0CnfPxtHiR5H+dAfC20orwypbsAxVshVAHglOxnZP5DA6pC6sEa2
         UB2A==
X-Gm-Message-State: APjAAAX9nvkSTbmoPCjuR5L4LfVAfkgO62ohcdpLVhPnbh6V/8jf4Rei
        pbYOte47k9wQQJmGJGsgSkg=
X-Google-Smtp-Source: APXvYqwzpYgJ9dVAN3Isp6uQaRiApCWUSpADNNzkXMrApBhMnK2khllI7c2bFpkogeF4MiSUBjiHaw==
X-Received: by 2002:aa7:8aca:: with SMTP id b10mr13507218pfd.213.1574952914062;
        Thu, 28 Nov 2019 06:55:14 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8015:e854:5ef0:f52e])
        by smtp.gmail.com with ESMTPSA id z11sm22282563pfg.117.2019.11.28.06.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 06:55:13 -0800 (PST)
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
Subject: [PATCH v2 4/8] platform/x86: intel_menlow: switch to use <linux/temperature.h> helpers
Date:   Thu, 28 Nov 2019 23:54:35 +0900
Message-Id: <1574952879-7200-5-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This switches the intel_menlow driver to use deci_kelvin_to_celsius() and
celsius_to_deci_kelvin() in <linux/temperature.h> instead of helpers in
<linux/thermal.h>.

This is preparation for centralizing the kelvin to/from Celsius conversion
helpers in <linux/temperature.h>.

This also removes a trailing space, while we're at it.

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
- don't mix up another fix (format string for cellsius value)

 drivers/platform/x86/intel_menlow.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
index b102f6d..12c1094 100644
--- a/drivers/platform/x86/intel_menlow.c
+++ b/drivers/platform/x86/intel_menlow.c
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
+#include <linux/temperature.h>
 #include <linux/thermal.h>
 #include <linux/types.h>
 
@@ -302,8 +303,10 @@ static ssize_t aux_show(struct device *dev, struct device_attribute *dev_attr,
 	int result;
 
 	result = sensor_get_auxtrip(attr->handle, idx, &value);
+	if (result)
+		return result;
 
-	return result ? result : sprintf(buf, "%lu", DECI_KELVIN_TO_CELSIUS(value));
+	return sprintf(buf, "%lu", deci_kelvin_to_celsius(value));
 }
 
 static ssize_t aux0_show(struct device *dev,
@@ -332,8 +335,8 @@ static ssize_t aux_store(struct device *dev, struct device_attribute *dev_attr,
 	if (value < 0)
 		return -EINVAL;
 
-	result = sensor_set_auxtrip(attr->handle, idx, 
-				    CELSIUS_TO_DECI_KELVIN(value));
+	result = sensor_set_auxtrip(attr->handle, idx,
+				    celsius_to_deci_kelvin(value));
 	return result ? result : count;
 }
 
-- 
2.7.4

