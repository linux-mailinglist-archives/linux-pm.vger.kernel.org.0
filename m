Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 178EA96ED4
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 03:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfHUB06 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 21:26:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44393 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfHUB05 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 21:26:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so310113pgl.11;
        Tue, 20 Aug 2019 18:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hTprmL6/4DTxYUWRYFqPS6Khlk6NQD+J3yhldvbHj+M=;
        b=UlTC09iFBgZ1vv3LGqml6PI8vHWG/phATiJld18gslC7ZBu/5Mk5KTNdi1ai5cbJDZ
         ApJ49DuFgufsoI1NfeVkTHSG1aYpN7r11+EqbizCZAzxquXriKEghdMCXq2yvES6mBPj
         TT529qXi505rmr8seWGsVD2qKj7FX31BOrebYbbKuWKMpzk4Sw9zkSztjxoNv1Pn5o64
         0tWrGR6NRvxDbIsFBOuma1ElIhksngBH7Qa+eSa15grLoJIqJRFMFiMcxMZpxr8fGp8t
         xnntEjLZaGE0EEZisMl6Jz942MMwx+Ll3GHH5+5+F393HLVGUjtOzd4biNxu7lCuIzQt
         Ht2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hTprmL6/4DTxYUWRYFqPS6Khlk6NQD+J3yhldvbHj+M=;
        b=cRPt6P+D2ydXRJkZnTVGiDxC+xsbMqNjnMBmdtt6CCDiODBJBo7S8nvPzqXnmqxkZc
         3esZ2moRcUNSvI8sfDZ91ErdSVWDYqJZnCsQB/bvYf/g5MguTawEzLZzNIg8InM5ZS6k
         +0ZShWL+NcHoE6NaV8Xm/zQrHKazzZjsm717hcBLqtcIqoANNdmUFIxSTtrQ1WuGL6s2
         OwyL38EtO0TZOIm0eE2DaiQzgQ4vVC2NEMGvwjtsvlStTessIF3cF8LscVTMiZv/whka
         Xoypn6vT0+EhJHgZozORJclUCNAQlGcdXNWwbOvtRIeZ3A4/lwbeLhI0gSMvriwKiDxf
         xr7Q==
X-Gm-Message-State: APjAAAXhKiprOCdRUIKPmHIqElzi1ea001sJX+hEfNxLaSFGiGUbvHwu
        Ey955JEfQRb1BoMaT3gWNTjA5PT7x34=
X-Google-Smtp-Source: APXvYqwtYF+tZ+/SeK7V0VxJ47xPzapQ6JIbUTwswucZuNqNe12F+DXbQCresW37CqeJic1SjZm/bg==
X-Received: by 2002:a62:ac0d:: with SMTP id v13mr32415124pfe.129.1566350816550;
        Tue, 20 Aug 2019 18:26:56 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id bt18sm1162700pjb.1.2019.08.20.18.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 18:26:55 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v6 09/12] thermal: qoriq: Enable all sensors before registering them
Date:   Tue, 20 Aug 2019 18:26:09 -0700
Message-Id: <20190821012612.7823-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821012612.7823-1-andrew.smirnov@gmail.com>
References: <20190821012612.7823-1-andrew.smirnov@gmail.com>
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
 drivers/thermal/qoriq_thermal.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 08167ebe6060..5f964f806187 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -23,6 +23,7 @@
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
 #define TMR_ALPF	0x0c000000
+#define TMR_MSITE_ALL	GENMASK(15, 0)
 
 #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
 #define TMTMIR_DEFAULT	0x0000000f
@@ -75,7 +76,10 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
 static int qoriq_tmu_register_tmu_zone(struct device *dev,
 				       struct qoriq_tmu_data *qdata)
 {
-	int id, sites = 0;
+	int id, ret;
+
+	regmap_write(qdata->regmap, REGS_TMR,
+		     TMR_MSITE_ALL | TMR_ME | TMR_ALPF);
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
@@ -86,21 +90,16 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 		tzd = devm_thermal_zone_of_sensor_register(dev, id,
 							   sensor,
 							   &tmu_tz_ops);
-		if (IS_ERR(tzd)) {
-			if (PTR_ERR(tzd) == -ENODEV)
+		ret = PTR_ERR_OR_ZERO(tzd);
+		if (ret) {
+			if (ret == -ENODEV)
 				continue;
-			else
-				return PTR_ERR(tzd);
-		}
 
-		sites |= 0x1 << (15 - id);
+			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
+			return ret;
+		}
 	}
 
-	/* Enable monitoring */
-	if (sites != 0)
-		regmap_write(qdata->regmap, REGS_TMR,
-			     sites | TMR_ME | TMR_ALPF);
-
 	return 0;
 }
 
-- 
2.21.0

