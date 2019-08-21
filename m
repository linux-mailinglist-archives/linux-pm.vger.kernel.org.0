Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810B696ED5
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 03:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfHUB1A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 21:27:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37758 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfHUB07 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 21:26:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id 129so284428pfa.4;
        Tue, 20 Aug 2019 18:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACiQ2TVINvEc8tRiSP1ADYbEBXNCOC0SJeWP6GOyKXE=;
        b=BiywEQpIyuzwL8lv5/nBKRyppkyJdRXLlxObrygz6/DXtScyzUsJsgTFCyNw37fqcI
         E3HBChQKSU6x05mimZ/AtPbO390x2s0wpGWg2wE1dkzPpsgEM5ZiWq4Ur+XNyv9f38cp
         NEwg27jxdrc1tHtorO7YAAVCeBV/MRiKe1bBevl4szXvq9ruSgwFmb6wQYIGttvT2agX
         oOjBD5Pgxpqn/IwAkvAB8OzPgaokJFFNaS8vSzibugvwI6zVQvOL83ACKpp3vLmMzlUL
         vODJuyaKtJ01L44ibtWQXXMu+g6v9YaKnbYWESwlkz+7a2bzXD+NqWUyHz6S6UTOhmMu
         dM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACiQ2TVINvEc8tRiSP1ADYbEBXNCOC0SJeWP6GOyKXE=;
        b=ElkVbpDoymOTSRWBp+L380X+DHPb21UpbHtXF8eq6UxEeb/xsvxlvBTS6Y2xNveRC/
         KkTq7m7LT+fg5oyTghKZa3Wgv7mk71hNnxj5y7z6Ektrt2uhnNsJUCJlVNa4XrdZ1Nhn
         yArIQ+MNzvG16Hbuq145OxZBxUZ15y2mVmY8Kqa12Tr/6OkMp/hOcNTTMu2pIaCab+Ly
         RSzf2fBfuc26NT3MQiSTjcyhPB3KvipamKTEL9S4Ck5qE3ktDPvtJefHjMlA7wmiTuOT
         9APbH/S+lbd+PuiZnER02ZuYhytpijC2NT8vBLE6zDG374RHLjxcbkRQHsmuYOEuxqRW
         YroA==
X-Gm-Message-State: APjAAAVBpQ06z0gPo0qyWlyrrHos2Wefm36rVtWo47dtpLLbLYw0PlVq
        5xtaA/YNVmlUQ6PZuC5DZ26NfjnnjYk=
X-Google-Smtp-Source: APXvYqxmwtLvOje8reyjS/YW+rihedvgdMsnKI1d7gKMEmrpQs2HW+e6l5guTVDnIvwKWppfKSvUdg==
X-Received: by 2002:a17:90a:bb0c:: with SMTP id u12mr2928902pjr.132.1566350818332;
        Tue, 20 Aug 2019 18:26:58 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id bt18sm1162700pjb.1.2019.08.20.18.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 18:26:57 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v6 10/12] thermal: qoriq: Do not report invalid temperature reading
Date:   Tue, 20 Aug 2019 18:26:10 -0700
Message-Id: <20190821012612.7823-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821012612.7823-1-andrew.smirnov@gmail.com>
References: <20190821012612.7823-1-andrew.smirnov@gmail.com>
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

