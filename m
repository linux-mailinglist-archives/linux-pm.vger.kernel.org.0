Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E75A448892
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 18:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfFQQP0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 12:15:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39002 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbfFQQPX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 12:15:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so6090591pgc.6;
        Mon, 17 Jun 2019 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACiQ2TVINvEc8tRiSP1ADYbEBXNCOC0SJeWP6GOyKXE=;
        b=h+GYT+KVTS2phA+OlPWq3CdBC+yKbkSTCjvYAh8dGAVtClvywKnZx+/kUZ8Hd55wrO
         OzBz/lTIs4G2oA3HxepG16eO0qziIbaZpQhAJnGmDgSlztWF00SN287QKu2jvg5Cp1Cm
         mibDq0SCGF4STDz44a1+MkeVYlnNBFZECpb3McvZfOxEcdW5alSJRf2v/wnhUUbr8PXm
         kWlevAEWiq9suSIJJjpZZYJZqDT9+ASTdpA1eKoTV3V1AlEgsw8uaW/DKPheGWJDkLTO
         JR2J0XCF8o8LMekjqB34H1cex0xOEHZyWn3xWZC17KdrkObhnsE5Q9aTUul/uH57vQ2R
         Eq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACiQ2TVINvEc8tRiSP1ADYbEBXNCOC0SJeWP6GOyKXE=;
        b=uN/uozdiN+wXCVeZpbxYRJeAgiGcubC6WKq5GgpObyLP1JweFyf6GRdI2kZ60XkEbd
         ihIuOYXw1WUgU2awopq6mKNAePSaon9td+GLMRGrpShsfodAcy/JpfmaJhT9+ZV3bQ5B
         4csgLG5lG6bX/hj/usmL/uZddOctq8gYEs39oHMykt2M/DoxWImjBwDal4MDefQtVw/W
         DgQYHVXPzApfPD4yeIj7W7Ejc34X3FZkWAhb55s3DDIlmuoD1MvOpfhKUC8lnnmhjE5h
         v4HkBeJeI0rLT7uSSbsDPSAUoO0lAY86KOkb8tQR7QMyqc8hjckmP2u4skGUJn86p20C
         lfkg==
X-Gm-Message-State: APjAAAVEU+Bz1vfjVWGFsWh1OpRhu8nan6Lr2F5l9c4NcOymAqs+G9Vj
        UJ1FiG8uUUhmD1TiE7sxwQIrpW19hn8=
X-Google-Smtp-Source: APXvYqwo6mV13xn1+k9izdoijttMerWsvUhSt0lXKCCsddzLTIMmzBP/aXizNU/5030n7IniwHQpjQ==
X-Received: by 2002:a62:2784:: with SMTP id n126mr48228002pfn.61.1560788121686;
        Mon, 17 Jun 2019 09:15:21 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c9sm14791953pfn.3.2019.06.17.09.15.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 09:15:20 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/12] thermal: qoriq: Do not report invalid temperature reading
Date:   Mon, 17 Jun 2019 09:14:56 -0700
Message-Id: <20190617161458.3754-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617161458.3754-1-andrew.smirnov@gmail.com>
References: <20190617161458.3754-1-andrew.smirnov@gmail.com>
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
index 5f964f806187..2f8c5feb1a25 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -37,6 +37,7 @@
 #define REGS_TRITSR(n)	(0x100 + 16 * (n)) /* Immediate Temperature
 					    * Site Register
 					    */
+#define TRITSR_V	BIT(31)
 #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
 					   * Control Register
 					   */
@@ -62,8 +63,24 @@ static int tmu_get_temp(void *p, int *temp)
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

