Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA7E1BE5A
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfEMUEU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 16:04:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40887 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfEMUEU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 16:04:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so7314161pgl.7;
        Mon, 13 May 2019 13:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=647q/9btvZL+BLiFNB10S0rDzh+440L2Fuda1o7ZvI0=;
        b=Tg6Ss2JZzkUeANxlGA35bnhZ5wWeMKKfDWvlZ17+Ufjyz266q3eaOxE6VJtitRJlVt
         IaPPnj8/Fyq633p3RnFuJRBzAs/7CYHk48ppy7LhJv7izP93DoRUIl+DDzM+5TML6H0B
         ha+cG4bDUWSGwBgsYmyPInxu2TtGMq4FVNlmip1mJlgCDaPrA9kU1D8Qew0RX96X4LvP
         TFg2yuscs88xoSHgpsXo2psVWKnh1bubHdsYUvXZUo8yuhbpmQ6r5Mh1D4R8xfrCdAJN
         jauI8ONuWUlvTxZZssXFS8F+pzYuximQbdPU6WWmJqJe8OhjbvTZdUUFwjxy8Fwbh/S0
         JByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=647q/9btvZL+BLiFNB10S0rDzh+440L2Fuda1o7ZvI0=;
        b=uBW8p9563p7u3A8Wgjzv7gO5Br8WhfJ5ZSYANQ+94ZQjDecegPb/Q2kOKvgRM93p2Y
         oQC3XoqShnixPPN4WfBU6VSfPqoIqk2PHl51yMK0eztE9Vf32ZuIosiHIv3gY6HHjkfL
         e6ewczHVObAxpXZv+eD5xukZ6QjeGndlTAhC4XboEmcNoc+pxO9FMB7sle0n6Y/7w4t1
         X1z+/fUrni12HoBKR14Y3jI6WliqT0yanuPP+scWqmzTkAe4QldNkdErap43noIe4as0
         X+MeOTd7MsEHd6X2Yb36QeHtKIjxLRmaPzEJdipsBW2OqqTHJSk8pP8SD48wpuXceRYE
         Lpxg==
X-Gm-Message-State: APjAAAX/XuqF2eP20zLkhsa3Ij9IXdXK/XM3Nz7KU7K9rYG4767GT1RK
        ViFKEFCEXJ1prPrRNED3ETd5BtYr
X-Google-Smtp-Source: APXvYqz4EQThvJcH9VflMuI03PjfB8orVz6VT/I2RgSG8By4opEd3Komtsprx/pq7y8hOuAxMarULQ==
X-Received: by 2002:a63:1820:: with SMTP id y32mr33396629pgl.287.1557777859289;
        Mon, 13 May 2019 13:04:19 -0700 (PDT)
Received: from localhost.localdomain (KD118155013174.ppp-bb.dion.ne.jp. [118.155.13.174])
        by smtp.gmail.com with ESMTPSA id y3sm19167506pfe.9.2019.05.13.13.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 13:04:18 -0700 (PDT)
From:   Yoshihiro Kaneko <ykaneko0929@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH/RFT v3 3/3] thermal: rcar_gen3_thermal: Update temperature conversion method
Date:   Tue, 14 May 2019 05:03:55 +0900
Message-Id: <1557777835-19454-4-git-send-email-ykaneko0929@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557777835-19454-1-git-send-email-ykaneko0929@gmail.com>
References: <1557777835-19454-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update the formula to calculate temperature:
Currently, current TEMP is calculated as
average of val1 (is calculated by formula 1)
and val2 (is calculated by formula 2). But,
as description in HWM (chapter 10A.3.1.2 Normal Mode.)

If (TEMP_CODE < THCODE2[11:0]) CTEMP value should be val1.
If (TEMP_CODE > THCODE2[11:0]) CTEMP value should be val2.

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index a2873e7..661b36c 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -63,6 +63,13 @@
 
 #define TSC_MAX_NUM	3
 
+/* default THCODE values if FUSEs are missing */
+static const int thcode[TSC_MAX_NUM][3] = {
+	{ 3397, 2800, 2221 },
+	{ 3393, 2795, 2216 },
+	{ 3389, 2805, 2237 },
+};
+
 /* Structure for thermal temperature calculation */
 struct equation_coefs {
 	int a1;
@@ -78,6 +85,7 @@ struct rcar_gen3_thermal_tsc {
 	int low;
 	int high;
 	int tj_t;
+	int id; /* thermal channel id */
 };
 
 struct rcar_gen3_thermal_priv {
@@ -128,7 +136,7 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
 #define TJ_3 -41
 
 static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc *tsc,
-					 int *ptat, int *thcode,
+					 int *ptat, const int *thcode,
 					 int ths_tj_1)
 {
 	/* TODO: Find documentation and document constant calculation formula */
@@ -162,15 +170,19 @@ static int rcar_gen3_thermal_round(int temp)
 static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 {
 	struct rcar_gen3_thermal_tsc *tsc = devdata;
-	int mcelsius, val1, val2;
+	int mcelsius, val;
 	u32 reg;
 
 	/* Read register and convert to mili Celsius */
 	reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
 
-	val1 = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1, tsc->coef.a1);
-	val2 = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2, tsc->coef.a2);
-	mcelsius = FIXPT_TO_MCELSIUS((val1 + val2) / 2);
+	if (reg <= thcode[tsc->id][1])
+		val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1,
+				tsc->coef.a1);
+	else
+		val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2,
+				tsc->coef.a2);
+	mcelsius = FIXPT_TO_MCELSIUS(val);
 
 	/* Make sure we are inside specifications */
 	if ((mcelsius < MCELSIUS(-40)) || (mcelsius > MCELSIUS(125)))
@@ -376,11 +388,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	/* default values if FUSEs are missing */
 	/* TODO: Read values from hardware on supported platforms */
 	int ptat[3] = { 2631, 1509, 435 };
-	int thcode[TSC_MAX_NUM][3] = {
-		{ 3397, 2800, 2221 },
-		{ 3393, 2795, 2216 },
-		{ 3389, 2805, 2237 },
-	};
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -437,6 +444,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			ret = PTR_ERR(tsc->base);
 			goto error_unregister;
 		}
+		tsc->id = i;
 
 		priv->tscs[i] = tsc;
 
-- 
1.9.1

