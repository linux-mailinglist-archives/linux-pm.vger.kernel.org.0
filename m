Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17FCA10CACF
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 15:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfK1Oz2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 09:55:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37471 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK1Oz2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 09:55:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id b10so13024679pgd.4;
        Thu, 28 Nov 2019 06:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dhRdimY0ajJJ9jrRtSdV+vAbveAqfBoDwJI+XgU6bco=;
        b=dSadCgTfPIzB/jo2hoLbcB24fHUPWvOniDsvlEf5K+KMHM2DCeUUDhJd9Ix7uawrTV
         vJw7l2PcXrbB2AzJEx3HGoHeaGzwFWmJL4//qbhF9XjGkLf/pQQZZrxLWFN8gOzLUpFQ
         UHWwS//72DeBUawtIyMPbBenUK6DFxHUc8fmvowpiHo0Xkyzm5nSDXPI0/uiJGbcWGzT
         wz8dQW2OMdkhS4dq8B84DO/eaXvFedaGQm4dGKbB/yyuq1kWzrgJWwSw/yXBZbs8/pNi
         DmrsvlGEvm7YIDKQgvF2S6qivSuhIqRJMizM4/htZvoduJO7Im2Jw9XUIjzfkpDUSRh6
         /TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dhRdimY0ajJJ9jrRtSdV+vAbveAqfBoDwJI+XgU6bco=;
        b=HUINRWZZcapPA/S0xTkQy1qxwTWwfl/bYa/EgeX1rgBtcnBuuxt3EzoVmp2fEOMX40
         nw/T9TlmoGy9AEfWEVjQF13wbdw3QWzdlXWfKO+7VA/nXFOU7svpcX08/Zeyb/hXc8d4
         A7L4vbhpeTeCSI18BNvlXy2S8GbSW9nfX0pG39svlYMGp6dTj7goTVN8KCWY4n4lWSWn
         SHD/Fcz1scbJrpMYx4flyRIsRn4FPYXB4IcWPxVbi+yA/eTKdd5zRJmULlAH018rwhrv
         B7r9JNlwFAffjRKlJWxClL6EsuPpYmdD2TkjlEqB2T2UiadQvv1P7IOG2Gv74b0+UBS2
         A3Xg==
X-Gm-Message-State: APjAAAWUwk+7pVoo/jv/Bdmy8e8YJcfdpXBmNiX/6na3XGAZznv5NdUn
        38IRYzhW3co94tsOJ4Ld+88=
X-Google-Smtp-Source: APXvYqzjoubKYiDf0NpWSlRmLegHRj8zhl2/+1eD1xhEeY/kOJ/MNltJD2eQHDC4GImOSmRRLo4KpQ==
X-Received: by 2002:a65:40ca:: with SMTP id u10mr11404387pgp.432.1574952927279;
        Thu, 28 Nov 2019 06:55:27 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8015:e854:5ef0:f52e])
        by smtp.gmail.com with ESMTPSA id z11sm22282563pfg.117.2019.11.28.06.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 06:55:26 -0800 (PST)
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
Subject: [PATCH v2 7/8] nvme: hwmon: switch to use <linux/temperature.h> helpers
Date:   Thu, 28 Nov 2019 23:54:38 +0900
Message-Id: <1574952879-7200-8-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This switches the nvme driver to use kelvin_to_millicelsius() and
millicelsius_to_kelvin() in <linux/temperature.h>.

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- add Reviewed-by tag

 drivers/nvme/host/hwmon.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index a5af21f..14720c1 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -5,14 +5,11 @@
  */
 
 #include <linux/hwmon.h>
+#include <linux/temperature.h>
 #include <asm/unaligned.h>
 
 #include "nvme.h"
 
-/* These macros should be moved to linux/temperature.h */
-#define MILLICELSIUS_TO_KELVIN(t) DIV_ROUND_CLOSEST((t) + 273150, 1000)
-#define KELVIN_TO_MILLICELSIUS(t) ((t) * 1000L - 273150)
-
 struct nvme_hwmon_data {
 	struct nvme_ctrl *ctrl;
 	struct nvme_smart_log log;
@@ -35,7 +32,7 @@ static int nvme_get_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
 		return -EIO;
 	if (ret < 0)
 		return ret;
-	*temp = KELVIN_TO_MILLICELSIUS(status & NVME_TEMP_THRESH_MASK);
+	*temp = kelvin_to_millicelsius(status & NVME_TEMP_THRESH_MASK);
 
 	return 0;
 }
@@ -46,7 +43,7 @@ static int nvme_set_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
 	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
 	int ret;
 
-	temp = MILLICELSIUS_TO_KELVIN(temp);
+	temp = millicelsius_to_kelvin(temp);
 	threshold |= clamp_val(temp, 0, NVME_TEMP_THRESH_MASK);
 
 	if (under)
@@ -88,7 +85,7 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_temp_min:
 		return nvme_get_temp_thresh(data->ctrl, channel, true, val);
 	case hwmon_temp_crit:
-		*val = KELVIN_TO_MILLICELSIUS(data->ctrl->cctemp);
+		*val = kelvin_to_millicelsius(data->ctrl->cctemp);
 		return 0;
 	default:
 		break;
@@ -105,7 +102,7 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			temp = get_unaligned_le16(log->temperature);
 		else
 			temp = le16_to_cpu(log->temp_sensor[channel - 1]);
-		*val = KELVIN_TO_MILLICELSIUS(temp);
+		*val = kelvin_to_millicelsius(temp);
 		break;
 	case hwmon_temp_alarm:
 		*val = !!(log->critical_warning & NVME_SMART_CRIT_TEMPERATURE);
-- 
2.7.4

