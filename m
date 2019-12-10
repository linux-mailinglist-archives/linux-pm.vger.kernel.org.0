Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22617118DF1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 17:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfLJQm0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 11:42:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40252 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfLJQmZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 11:42:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so90066plp.7;
        Tue, 10 Dec 2019 08:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jdPbCHrU2X5cb40jCnETs7i2ifIUn3Ola/UP2b4mOwM=;
        b=Masq6otl9D8o4RjM+csEhLQJelHQhLQftYTI7Vq2zmqnRdCp8gLt3kIYVKEWnyqFI8
         lnFLUTaL6kiDNNp2bTBipgRDTIQ+BgbNrDT9sQJ89p/PvFgNxPmvl2z+FIj+rkVWaUtn
         Vv+WqZpFpa0nPcUHiVVvNxM2OHrMJzqIAT4PMLyy+0BVXqA7DgmVYhfaEkzgBpuWGU6u
         OBAU5FRp1vuraJ+xXeZeVu4O85V4cWC6b6hJiyUFMagOrwO9XkpXTvkqtyX7Z+x4YaAT
         fKhKGHZ7F9pgNyofbFKjJu1jpE7P0vUqy/yJWUgA7Wt81uBxp04hwKwO40PUx5hjlZMY
         +AFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdPbCHrU2X5cb40jCnETs7i2ifIUn3Ola/UP2b4mOwM=;
        b=gTV4zw4RibJeNVB6JDiOAZBtSxskwuo28ePYjTqEBKTGCvJ00tgftUnDnTJgVbLyEm
         065W3HyLdVd6unYBgs2Q5EbHXm0bC8bL4Bu96rpQ9+jR32WRPnAXPZ7W4AAlDm5W408R
         ap2/4SuDUKFmnMu1LPQbOYwRlntCRe44TaMQvt7+y6nETiS68cWYEtNeS49wcl4dHPHf
         zAAILV4sA2TqRz22ClEAsgykQHltTFQ+0YpERJMc3Ov0Kk7TrlFcSkxalz128UBFwYbJ
         NfQhZXmZMIru7AFdjH89aC73zkrxKkgSDFlZNfLmC9YWj1PafhWWmnRlFr/Lh091/K9W
         EfGw==
X-Gm-Message-State: APjAAAV4IcLLcVGvq6RUQfCFas6+te68IhnbX7KaB0Jr+vTjXshOJO5i
        Nfef00+niPeuhnWN0C5F62s=
X-Google-Smtp-Source: APXvYqzg1kGqZqDCA++XjokNIDG/tNGgx+rNswAZxzPTKl4YOXbWBUDHmIBvd2JsRIGtJ9Auwf5bgA==
X-Received: by 2002:a17:90a:8989:: with SMTP id v9mr6398145pjn.119.1575996144681;
        Tue, 10 Dec 2019 08:42:24 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j38sm4034634pgj.27.2019.12.10.08.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:42:23 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/12] thermal: qoriq: Do not report invalid temperature reading
Date:   Tue, 10 Dec 2019 08:41:51 -0800
Message-Id: <20191210164153.10463-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191210164153.10463-1-andrew.smirnov@gmail.com>
References: <20191210164153.10463-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Before returning measured temperature data to upper layer we need to
make sure that the reading was marked as "valid" to avoid reporting
bogus data.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 6c5e53ea7711..b684d3ceda69 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -48,6 +48,7 @@
 #define REGS_TRITSR(n)	(0x100 + 16 * (n)) /* Immediate Temperature
 					    * Site Register
 					    */
+#define TRITSR_V	BIT(31)
 #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
 					   * Control Register
 					   */
@@ -80,8 +81,24 @@ static int tmu_get_temp(void *p, int *temp)
 	struct qoriq_sensor *qsensor = p;
 	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
 	u32 val;
+	/*
+	 * REGS_TRITSR(id) has the following layout:
+	 *
+	 * 31  ... 7 6 5 4 3 2 1 0
+	 *  V          TEMP
+	 *
+	 * Where V bit signifies if the measurement is ready and is
+	 * within sensor range. TEMP is an 8 bit value representing
+	 * temperature in C.
+	 */
+	if (regmap_read_poll_timeout(qdata->regmap,
+				     REGS_TRITSR(qsensor->id),
+				     val,
+				     val & TRITSR_V,
+				     USEC_PER_MSEC,
+				     10 * USEC_PER_MSEC))
+		return -ENODATA;
 
-	regmap_read(qdata->regmap, REGS_TRITSR(qsensor->id), &val);
 	*temp = (val & 0xff) * 1000;
 
 	return 0;
-- 
2.21.0

