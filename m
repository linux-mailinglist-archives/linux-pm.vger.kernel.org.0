Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F23AC5E684
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 16:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfGCOYu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 10:24:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32787 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfGCOYt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 10:24:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4so1354373pgk.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2019 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dIdrf6xrhUoL81KGbmUd1YlTYErAwYN8M5ZIm1LdIaA=;
        b=u6lSf5EArvXzs0d2YvYPmS+V2iuCWNKBPB6qpH02mlBBXgYl8xnXzoTkbMT1rKNDXg
         ZUIwA07zKvBqaonuoLncApadQrZ0ATAp0LdbsRnA7tStArFyX5LoIE7bmnAiVLxnuPI5
         iDALbCFsJ4bNu3uPYWGkYGCPflEV5uBtuMImURzsgNwPgkwN3WO6+8HmYRijJwdbXUUO
         g8ZFJdO/KipsNYQUqfow+6Hxv7EnziNZEbBV+9dVScpnahT4bww3vF8ZcGRD7zq9K1gb
         Q14G79Y4Q/wDt7a/uvZTLJz9GjhMmv/MaJ0ljQN1skgoX1FHKhXnJMN6ZEt9retiM7N8
         2N/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dIdrf6xrhUoL81KGbmUd1YlTYErAwYN8M5ZIm1LdIaA=;
        b=EcFY1yPLvTz8VCkHH4OeR7ClI1tnY1wgoRmX24i2nhG+l8HyWbQMI+eWYmw+yQwUQP
         wVkK4m7ZMHht6QRGGvEZyRZ7jeV3reT7A/0eFvZD4bB6xN/8AVNpavFLCaiBmtn/0hvB
         DwRlLb4rPTpVlT7/C8cKCsv0sPXNruQR8l78O726LPBMnf5upmMOaJNmwD1dNK8v5yXL
         OmC+qkIoFN+gd2wFA6b2nHJukcpdSbvnFtidUoH64CpyeZ4aN5xb0GMvv92EBi8IS2OW
         zlBxc7mXdLt9jFCC7oFIa/kcVBcDf3OT6QvPXdIT/Zb+468WcI/PY+zVVDbzRKlfIBUj
         cnIw==
X-Gm-Message-State: APjAAAUjxhPhDk5WjeAXoaC69vE0C+eCc2ZUMmFSyNj5U6GDCtCXFsF5
        AVJDpUH7K3e16u1KH+OYZmDQ/IzW
X-Google-Smtp-Source: APXvYqyKuetLpq+tzH5u/olNZ2g47LftsjNUmTY6eNEDxVTTDq2EhvwAHtL+EN8HAqfjVuVT0iqnvQ==
X-Received: by 2002:a65:63cd:: with SMTP id n13mr37228038pgv.153.1562163888682;
        Wed, 03 Jul 2019 07:24:48 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id s20sm3006098pfe.169.2019.07.03.07.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Jul 2019 07:24:48 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] thermal: of-thermal: avoid NULL ops dereference when writing trip temperature
Date:   Wed,  3 Jul 2019 23:24:33 +0900
Message-Id: <1562163873-14655-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While no sensor is registered to a DT thermal zone, __thermal_zone->ops
(struct thermal_zone_of_device_ops) is set to NULL.
This causes a NULL pointer dereference when writing trip point temperature
(i.e. trip_point_[0-*]_temp).

Fix it by checking if ops is NULL under thermal_zone_device's lock that
protects against concurrent access by thermal_zone_of_sensor_register() and
thermal_zone_of_sensor_unregister().

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/thermal/of-thermal.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index dc5093b..c207075 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -332,17 +332,20 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 				    int temp)
 {
 	struct __thermal_zone *data = tz->devdata;
+	int ret = 0;
 
 	if (trip >= data->ntrips || trip < 0)
 		return -EDOM;
 
-	if (data->ops->set_trip_temp) {
-		int ret;
+	mutex_lock(&tz->lock);
 
+	if (data->ops && data->ops->set_trip_temp)
 		ret = data->ops->set_trip_temp(data->sensor_data, trip, temp);
-		if (ret)
-			return ret;
-	}
+
+	mutex_unlock(&tz->lock);
+
+	if (ret)
+		return ret;
 
 	/* thermal framework should take care of data->mask & (1 << trip) */
 	data->trips[trip].temperature = temp;
-- 
2.7.4

