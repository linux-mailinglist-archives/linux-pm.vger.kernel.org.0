Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9271A1083AA
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2019 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfKXOJa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 09:09:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44560 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKXOJ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 09:09:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id az9so5258883plb.11;
        Sun, 24 Nov 2019 06:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SVtnbt2w8p1WjmEYI/RfZYho5p/l6mhZ+FEaY9XVk9c=;
        b=tOYyBixaF5cpNMF8ZO7JnE6N1EtCAZ75u7z42W4hABZwe+DAWLHZc634bLtAHRXXHd
         TB9DxYSIAu9yTKUTxpfIjmdsEfaTAvlElIA2ZC+kC67lmVZBH1R+ncjMNJve5x0kRuwx
         bFRAB7t+ABuPSvFKh2te4qkm/oIzhUl9d+Z743wlfc+IfcwSZ9bMcRX31RU5XlMejDDQ
         P7VGrC+t+YIZcgMpIC/bxT0sMiZyAqgKd9fgJ3zSgbdgCCE0F/orDI89ghBjQg6tkij5
         BXYQ81S0DWGo9K5+VLrq3Wuy3U1wi2Vjc4A9H2edizEiiWKInP91OPLvd6kM7XlsD3hR
         0I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SVtnbt2w8p1WjmEYI/RfZYho5p/l6mhZ+FEaY9XVk9c=;
        b=NA3TpaUDXFwGCz+bgVA4RCgaiIzc38ED6qCP9h2UjNWHb5SD0b8S7UBA2lS7FtjuBX
         Wvfx1wFgIsBKsri2nHN2JEtOHp3ujONMG/z4xGRQ65k55Emh9tp4ICCtRcA+JuZW0iH8
         7oR7IZpbF6YkGzMXfhdxrGR3c4Tg2hi+g68AGCBlQcwmjMdgQC48GUpg9SJZkPfMiIK8
         ErCPn4EFMtsIyAE5Yb3pypRkLW1AyCSlLau4WJrzk2ltIYF361SIZ+4XBJqA+bYeR7LW
         xTwDkA72nqYcdnc8XSVm8zc/rRLBFlcD7XxgzX+B8B9a9tkwKFPeV3TGaOE/Crl6i1vq
         QSYA==
X-Gm-Message-State: APjAAAXC+2X9SsI8LWcZq+pUsmxpzWChDRsRhuRLVn4bqAlqkLA+JGiP
        AFUAcIUYEdisxBwXZw713ME=
X-Google-Smtp-Source: APXvYqxhgSSnEyAEssT9mHzY0Xl6B6xR3rhtdCcR/L7wxpVcIjm+OFIVSR2lzjjR7O5c30UgpLP8kw==
X-Received: by 2002:a17:90a:9705:: with SMTP id x5mr31569174pjo.37.1574604568908;
        Sun, 24 Nov 2019 06:09:28 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id a3sm4816326pgh.91.2019.11.24.06.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Nov 2019 06:09:28 -0800 (PST)
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
Subject: [PATCH 4/8] platform/x86: intel_menlow: switch to use <linux/temperature.h> helpers
Date:   Sun, 24 Nov 2019 23:08:46 +0900
Message-Id: <1574604530-9024-5-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This switches the intel_menlow driver to use deci_kelvin_to_celsius() and
celsius_to_deci_kelvin() in <linux/temperature.h> instead of helpers in
<linux/thermal.h>.

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
 drivers/platform/x86/intel_menlow.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
index b102f6d..6313591 100644
--- a/drivers/platform/x86/intel_menlow.c
+++ b/drivers/platform/x86/intel_menlow.c
@@ -302,8 +302,10 @@ static ssize_t aux_show(struct device *dev, struct device_attribute *dev_attr,
 	int result;
 
 	result = sensor_get_auxtrip(attr->handle, idx, &value);
+	if (result)
+		return result;
 
-	return result ? result : sprintf(buf, "%lu", DECI_KELVIN_TO_CELSIUS(value));
+	return sprintf(buf, "%ld", deci_kelvin_to_celsius(value));
 }
 
 static ssize_t aux0_show(struct device *dev,
@@ -332,8 +334,8 @@ static ssize_t aux_store(struct device *dev, struct device_attribute *dev_attr,
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

