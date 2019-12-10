Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9FDC118DF5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 17:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfLJQmY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 11:42:24 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40133 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbfLJQmX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 11:42:23 -0500
Received: by mail-pj1-f68.google.com with SMTP id s35so7613481pjb.7;
        Tue, 10 Dec 2019 08:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2b2cjI9ppTDYWjSViWcD+9AH23luExy4LBLn3g5jjpw=;
        b=EUhUSu8HjuWa8gIUg0BSvq3u75rGGhe2q57nbZPxShzH3xnWa0+0xUQ3mJYypp8zDA
         DEQCUllE9EVT7HV+6JapUHzsgDYaPfJQwwCtsiALrQXNW1G8JIuUNtJ42zZYwjgG/+c1
         5jcBRwU/sl1Gj2IpSJMlK36LJWQ64GffdlNBhkq/84IIgiT6ukx9uS0K7blDDBRQVL+A
         9wI0sfUG3nLju+gODjP+OyeL27MZTbtg9L/h8uVaxzULkIuDfzCzkWnTut34LnczrMgz
         QXrsghAGFe6pzAt2iAjd1J4lstALygq6/Iu/MNc8TJwABsM5pviZKGJKmu3lrbIR4Wxv
         LMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2b2cjI9ppTDYWjSViWcD+9AH23luExy4LBLn3g5jjpw=;
        b=ceedYVxzDd42BgCh088g9enHQ3KLG8bgoWYOYsvwG7Ux9rmzIEr3gWKu3uKseHrbqX
         KCAWamn7CFseB4OCVQC+IyS0jl5GaEPVsOgXIFwOn2pjto2WXAUlGknhzycB7GmFZQwV
         4M6BjRudb0gglxz9P7lTIjx+j1lufFUPEXWUI+1fidJcicqvORITx063OYdOmataitg2
         1kl2BGI0ZSNFOHbu6yeQ51WC4B5em8AHfxKmdJJQ8IhHcppiggapbMfgKA4i7QKbTrwf
         tw3btt3FHrBDdx/FIOCiLTiwpNh5QdiznzkmHa/f31D1j/3OTT1/GGUqcSJuPucDrEWg
         AnaQ==
X-Gm-Message-State: APjAAAVZvlf33bbKvumWIuy8dqiWA5J+w7FHnw+3EKsbR+zqIadX09CY
        c/QgUfo6gy49WaISkK8FIlI=
X-Google-Smtp-Source: APXvYqwAeq3goTCXyPcasARNMmw1ZHElw7Cz+sIEzVBZ34FebrIsYXDzc3MK65C03mhXZeK9WHTC2w==
X-Received: by 2002:a17:90a:1b6b:: with SMTP id q98mr6559278pjq.106.1575996143035;
        Tue, 10 Dec 2019 08:42:23 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j38sm4034634pgj.27.2019.12.10.08.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:42:22 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/12] thermal: qoriq: Enable all sensors before registering them
Date:   Tue, 10 Dec 2019 08:41:50 -0800
Message-Id: <20191210164153.10463-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191210164153.10463-1-andrew.smirnov@gmail.com>
References: <20191210164153.10463-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tmu_get_temp will get called as a part of sensor registration via
devm_thermal_zone_of_sensor_register(). To prevent it from retruning
bogus data we need to enable sensor monitoring before that. Looking at
the datasheet (i.MX8MQ RM) there doesn't seem to be any harm in
enabling them all, so, for the sake of simplicity, change the code to
do just that.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
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
 drivers/thermal/qoriq_thermal.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 6227c940b9b0..6c5e53ea7711 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -29,6 +29,7 @@
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
 #define TMR_ALPF	0x0c000000
+#define TMR_MSITE_ALL	GENMASK(15, 0)
 
 #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
 #define TMTMIR_DEFAULT	0x0000000f
@@ -93,7 +94,15 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
 static int qoriq_tmu_register_tmu_zone(struct device *dev,
 				       struct qoriq_tmu_data *qdata)
 {
-	int id, sites = 0;
+	int id;
+
+	if (qdata->ver == TMU_VER1) {
+		regmap_write(qdata->regmap, REGS_TMR,
+			     TMR_MSITE_ALL | TMR_ME | TMR_ALPF);
+	} else {
+		regmap_write(qdata->regmap, REGS_V2_TMSR, TMR_MSITE_ALL);
+		regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF_V2);
+	}
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
@@ -109,25 +118,9 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 		if (ret) {
 			if (ret == -ENODEV)
 				continue;
-			else
-				return ret;
-		}
 
-		if (qdata->ver == TMU_VER1)
-			sites |= 0x1 << (15 - id);
-		else
-			sites |= 0x1 << id;
-	}
-
-	/* Enable monitoring */
-	if (sites != 0) {
-		if (qdata->ver == TMU_VER1) {
-			regmap_write(qdata->regmap, REGS_TMR,
-				     sites | TMR_ME | TMR_ALPF);
-		} else {
-			regmap_write(qdata->regmap, REGS_V2_TMSR, sites);
-			regmap_write(qdata->regmap, REGS_TMR,
-				     TMR_ME | TMR_ALPF_V2);
+			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
+			return ret;
 		}
 	}
 
-- 
2.21.0

