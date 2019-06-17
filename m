Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D506148898
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 18:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfFQQPV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 12:15:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38128 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbfFQQPV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 12:15:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id v11so6087151pgl.5;
        Mon, 17 Jun 2019 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hTprmL6/4DTxYUWRYFqPS6Khlk6NQD+J3yhldvbHj+M=;
        b=VuBYWDakvVdIntrhmddfKScqKlnj/dVBtTgB3jmRysYMdKY5AA6Vrp8fU2oSrxuG06
         0YfPVbc6jq1P5ARQoasYOgtEaRDUQCoe/D30dncysXP+QDsjvbQ30kdyAKZHG2yJcC1m
         lq88NNBNJFUoGBI7pkG6w18WfoIoPnxIrjfsoiSqDaKvShv0Prfpt/ALbEepEWx04SpQ
         aJW2JywGZro9s82kvgcNYChITLq9TglMOCuMnwfV9q5NwADAhbBtl8JOEgoWQQwT4jJ1
         Mi7sd5g2opVQewGmWArFnnMJ2wj0OSVn+6fpV+O37Hz6CJnujYA9UtDN+CJRpEHR9tQI
         EX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hTprmL6/4DTxYUWRYFqPS6Khlk6NQD+J3yhldvbHj+M=;
        b=DArGfNR6IkKrcehJhmjMPrD11MNZ5T/bd7PS50687UiPYqh0TLUrjA6eqAH/7Mww8p
         ehtmWnPh10qfJzXleh3IpG7PffdqXhXSWf6gamcILv1z7ploqxergBgMEELV7gtsweFJ
         5KeAim+OS2IDRcSC9X/DiGejbTShPXEnQpYUua1At38AF/pD5qzX6WSXyx/XXB/MLwkV
         d1Thgzv4LFcAf3kweN2fN8fZ69BsxaOGMIkCFF/Vrj4yd/+IPiZNzrZ3/WrbP43VtPTS
         xN3a+oPygHvdNARl/Sxh8IyGGs/AP2ZwG6oUkgBdvTN8hfxlBsZ/0MUOOUWrL+FJhuwb
         y+ug==
X-Gm-Message-State: APjAAAW4pyUdVT1n296ZZRXuUlOHG8izyFcNscqhmUsdvQwJpAHHNoB8
        q5plzhz6bbsbvFW8rcIFWr40xpccns4=
X-Google-Smtp-Source: APXvYqyulHJRXkyrEaDR8++8h0CIP2/GegUPthY80RE9qmp0V8disDoNVojmtGTWG6HMiaKlKE0reg==
X-Received: by 2002:a63:1243:: with SMTP id 3mr25796813pgs.235.1560788120209;
        Mon, 17 Jun 2019 09:15:20 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c9sm14791953pfn.3.2019.06.17.09.15.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 09:15:19 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/12] thermal: qoriq: Enable all sensors before registering them
Date:   Mon, 17 Jun 2019 09:14:55 -0700
Message-Id: <20190617161458.3754-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617161458.3754-1-andrew.smirnov@gmail.com>
References: <20190617161458.3754-1-andrew.smirnov@gmail.com>
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

