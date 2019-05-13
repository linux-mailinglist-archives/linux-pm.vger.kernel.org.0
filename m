Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E403D1BE58
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 22:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfEMUER (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 16:04:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40017 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfEMUER (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 16:04:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id u17so7767633pfn.7;
        Mon, 13 May 2019 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SydvbyyQhG9l+iV51oR0mTsbiib4ordz8eglryY7UWQ=;
        b=lYFBRhVDFUhWWfIfI+VLAoqC7hGTMz62vqT5OyZuszgmi0Q4RdQztJ01f2dhWcMzIL
         /blFmpP3eZvJUW06hr/ypXyXF9LcxopqJitouSD9q2UM/uror2jb9W+go24EwhSZEQvv
         WQmF6GALppHwAn8VKzFXiUMg2aUPifKbx497HwtuVsW0TyUwtZCkHmEscK9bO8wI4gTG
         swIsUmuFqs+xqMTGVhvNs1LbB9HD6U+fSeChg9j96ZBXDZ3lpFLVTIP2zK2dGyMyhnll
         0VnqQ1Z8H4cjbYEHFrNcxYZOXy52I/eaSSqrJn3XRZGfBCGk+EzlMTj18bCbi5Pl2qZZ
         9q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SydvbyyQhG9l+iV51oR0mTsbiib4ordz8eglryY7UWQ=;
        b=cmgxabUj6W0yxsVjGTL21q0KyQQn95nFfCbStUfKVAAWnYiTJr7bZHdQSZlXMcGjWR
         r6dA6pixYRAqHeCwxGYFyLknd17+QtXg47PYaquSEsHvWIDc3eWTB7z+AG2miaI8RLUG
         6qKbeIGVDQ2WMM6Ac3He1spXY5+8IrIls9FeNFlRqECBDZyvtfcpGUABMlBBvls77yPa
         bUmEFxfRhZzYtrFwFWuXgDV+qP9B3ELS7NzR5J7ja3cqp1n0lYZZomdlpZQzgWHszY+R
         9A1CMNTziEVPdFZ2k624do3CQY78oDJ3xDxvjzYw59TvbSK111xGf62w/XwPBc1ujHNR
         L2mg==
X-Gm-Message-State: APjAAAU/5oZLylNIMNB78gaVXp25jwoO9VvJEjIJXXvSXS2gNJa0g5WT
        oumH+Q/NFCJRKYMKQcr0m+o+8824
X-Google-Smtp-Source: APXvYqyqi3KTPUPXr/kXdZFQ4xZj4K7vI3QOLSgy+8pqmv+EypHdt5wIbseBUcrS4szHK0F2RUNW9g==
X-Received: by 2002:a63:5964:: with SMTP id j36mr33869785pgm.384.1557777856235;
        Mon, 13 May 2019 13:04:16 -0700 (PDT)
Received: from localhost.localdomain (KD118155013174.ppp-bb.dion.ne.jp. [118.155.13.174])
        by smtp.gmail.com with ESMTPSA id y3sm19167506pfe.9.2019.05.13.13.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 13:04:15 -0700 (PDT)
From:   Yoshihiro Kaneko <ykaneko0929@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH/RFT v3 2/3] thermal: rcar_gen3_thermal: Update calculation formula of IRQTEMP
Date:   Tue, 14 May 2019 05:03:54 +0900
Message-Id: <1557777835-19454-3-git-send-email-ykaneko0929@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557777835-19454-1-git-send-email-ykaneko0929@gmail.com>
References: <1557777835-19454-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update the formula to calculate CTEMP:
Currently, the CTEMP is average of val1 (is calculated by
formula 1) and val2 (is calculated by formula 2). But,
as description in HWM (chapter 10A.3.1.1 Setting of Normal Mode)

If (STEMP < Tj_T) CTEMP value should be val1.
If (STEMP > Tj_T) CTEMP value should be val2.

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 265ff6d..a2873e7 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -77,6 +77,7 @@ struct rcar_gen3_thermal_tsc {
 	struct equation_coefs coef;
 	int low;
 	int high;
+	int tj_t;
 };
 
 struct rcar_gen3_thermal_priv {
@@ -126,28 +127,26 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
 /* no idea where these constants come from */
 #define TJ_3 -41
 
-static void rcar_gen3_thermal_calc_coefs(struct equation_coefs *coef,
+static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc *tsc,
 					 int *ptat, int *thcode,
 					 int ths_tj_1)
 {
-	int tj_2;
-
 	/* TODO: Find documentation and document constant calculation formula */
 
 	/*
 	 * Division is not scaled in BSP and if scaled it might overflow
 	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
 	 */
-	tj_2 = (FIXPT_INT((ptat[1] - ptat[2]) * 157)
-		/ (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
+	tsc->tj_t = (FIXPT_INT((ptat[1] - ptat[2]) * 157)
+		     / (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
 
-	coef->a1 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
-			     tj_2 - FIXPT_INT(TJ_3));
-	coef->b1 = FIXPT_INT(thcode[2]) - coef->a1 * TJ_3;
+	tsc->coef.a1 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
+				 tsc->tj_t - FIXPT_INT(TJ_3));
+	tsc->coef.b1 = FIXPT_INT(thcode[2]) - tsc->coef.a1 * TJ_3;
 
-	coef->a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
-			     tj_2 - FIXPT_INT(ths_tj_1));
-	coef->b2 = FIXPT_INT(thcode[0]) - coef->a2 * ths_tj_1;
+	tsc->coef.a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
+				 tsc->tj_t - FIXPT_INT(ths_tj_1));
+	tsc->coef.b2 = FIXPT_INT(thcode[0]) - tsc->coef.a2 * ths_tj_1;
 }
 
 static int rcar_gen3_thermal_round(int temp)
@@ -186,13 +185,15 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
 					      int mcelsius)
 {
-	int celsius, val1, val2;
+	int celsius, val;
 
 	celsius = DIV_ROUND_CLOSEST(mcelsius, 1000);
-	val1 = celsius * tsc->coef.a1 + tsc->coef.b1;
-	val2 = celsius * tsc->coef.a2 + tsc->coef.b2;
+	if (celsius <= INT_FIXPT(tsc->tj_t))
+		val = celsius * tsc->coef.a1 + tsc->coef.b1;
+	else
+		val = celsius * tsc->coef.a2 + tsc->coef.b2;
 
-	return INT_FIXPT((val1 + val2) / 2);
+	return INT_FIXPT(val);
 }
 
 static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
@@ -440,7 +441,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		priv->tscs[i] = tsc;
 
 		priv->thermal_init(tsc);
-		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i],
+		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcode[i],
 					     *rcar_gen3_ths_tj_1);
 
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
-- 
1.9.1

