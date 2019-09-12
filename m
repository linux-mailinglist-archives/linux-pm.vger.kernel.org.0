Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A42CB0690
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 03:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfILBfD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 21:35:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34680 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfILBfC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 21:35:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id r12so14884673pfh.1;
        Wed, 11 Sep 2019 18:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1rLahVlu4CEDCKDroxNVW1usHiwtWZlfedC9bz+64Ew=;
        b=CKtn8l2gXqX9kwIsebIl6Ni9V4udChMHZFLuPa5zg4I7rSoYfqloVb67SyvrEnrUtw
         UvHk7UzXhIeaEzXf9D1JlKclBB4lucNE4sNrBG4Pb0rXI03FN+3X5/OdKAzvo+c9vlx2
         w+108UhgleWi2Mmggmr/GLCMT0+USaVgyiH3m9614iYcoRKmj0qClbt9XeJYHqHVl+VN
         ZTkoy31FkCUPjQCwLbpgenrV7Hy4rGbPzWaYnzgXkBCOihUpQ1SJkmD9tTl/+XvhVwE5
         YWBm8qZ721/I/ZMunGD6PYAoH1KtcVimrlFXCcqPBbZZ8m6SUDakKY4GSY/AbSH/9hXO
         YALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1rLahVlu4CEDCKDroxNVW1usHiwtWZlfedC9bz+64Ew=;
        b=NNCXt6q0E2T1NdLKJiXjxhLgFGxbSc0mL/U+i+D4K0fGKje5bvJ8rghkAMa0wBnbZ9
         OUdhcYweLZAsdtqswX9GWZrzVuhuuy+UK7kcXSVgzSX+2JiOGGV3KcdG4+C+PaAdR0ha
         7oVrC1JSm09ZtFW1JQKMx9LkyRC/aGDXF5/ouxAMVJcGDGiO61sfzbwMDNsHY3b2l/6X
         AhYp+TtJgN64u/MEdLCnF+544mGhgMyUKd+zYVHLsQPX1HSl23DoS5rcxAyavzj7iq03
         jAuM4+VL+G0cxmtYE44IKdOCNpMZd5/Ua7HwBsMc2YY547FCJswhsyoEAYikcCoanl8X
         wp2A==
X-Gm-Message-State: APjAAAX7tlfkcjKsboUSGrO0h1dWaLV/l7HI3OrYBaxpukTlduxLhgan
        njAPMbtLJpIFwiHJvO6LfQs=
X-Google-Smtp-Source: APXvYqwyz/a46GFwnyW6glvee++myUmL2Gcl5uJEXSbxPvRVF03nq0lRbyLMoiXJRnOiuxmeEzFh7g==
X-Received: by 2002:a63:d64f:: with SMTP id d15mr36546251pgj.345.1568252101635;
        Wed, 11 Sep 2019 18:35:01 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id b126sm35248236pfa.177.2019.09.11.18.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:35:00 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/12] thermal: qoriq: Do not report invalid temperature reading
Date:   Wed, 11 Sep 2019 18:34:45 -0700
Message-Id: <20190912013447.2977-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912013447.2977-1-andrew.smirnov@gmail.com>
References: <20190912012920.29601-1-andrew.smirnov@gmail.com>
 <20190912013447.2977-1-andrew.smirnov@gmail.com>
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
index 1cc53a4a5c47..48853192514a 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -38,6 +38,7 @@
 #define REGS_TRITSR(n)	(0x100 + 16 * (n)) /* Immediate Temperature
 					    * Site Register
 					    */
+#define TRITSR_V	BIT(31)
 #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
 					   * Control Register
 					   */
@@ -64,8 +65,24 @@ static int tmu_get_temp(void *p, int *temp)
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

