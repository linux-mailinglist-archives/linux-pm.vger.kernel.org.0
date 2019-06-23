Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE274FCE5
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2019 18:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfFWQmW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 12:42:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35110 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfFWQmV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 12:42:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so6118466pfd.2;
        Sun, 23 Jun 2019 09:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9UNcpWLQ0SBIIcBRxbN1qX4s3ChEMbjvtnWO+dtNEsA=;
        b=q7GZ/jpCAu9MK3iPRrcZ9ANkg2i3u6OpwBfpBxftNrbB7qb5Ql/dv/7UGy8QXCCGpy
         GiGyjFSWSWxOwbxw3caI4V/cmdLbmXW63FudgJkGpzzRJsXBhSZ1oIcSv5VoS0sgYpmT
         wKshYQ+CHPlieOztlOpzZaI86gqTUced4iJPd7tSBo/mzcRsYUdjvXC2dB8u8KVi7a7o
         Ad48cjNJiPK/Q5LWyupyPXWmQ32wJAU3q8xCbrm4bSi+5gJJdf6+g+Or/gdUlua2/v82
         yAmGhMZ0tWH3/3vnG0wz4DebTviCokra90Eq2UiRVcArotY86r1DhHK+Sogw5UxpNXEM
         bv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9UNcpWLQ0SBIIcBRxbN1qX4s3ChEMbjvtnWO+dtNEsA=;
        b=YVYyhJjY2lB2i4OUEl1iukMKULnmYnNd2NbPvMsFn7Ua8qBdRVlw1wAvxI+ErIwtyD
         QUd5JRAp/Re98FqYn9Ee3009j3d5Lg2C+iQIKAKRuXFszS/iIaN2rPtx9ClahuDs2YKN
         +AK2ugPvK7Wn3iVBb/XqZcD/Zq85mB8orrqr9kevvpwAzEO+OC7M61gINGdAgVBtbV6M
         /Oo4tNvqs99zuG5fgZyauPTakt1asj8DZ9J3SkOG6qHHOEZWUescek5oC+2JhmHePp4N
         Eqz1txQGF2dp+LM9N2cbbn0k0FiaFdSZspRPWrpSEVVQT9beToZjnxsE1sPRaAv3Eg0h
         F2BQ==
X-Gm-Message-State: APjAAAU30SoAbirSHr7wSJlz1tFAQUyRAJTU0WKCgwLNueRLCvbPdsp3
        hB0a1RfUbdRTIVnv3RUdOKkbnFCpP8c=
X-Google-Smtp-Source: APXvYqy7Clm/F/UW+Jya2jGhzAWsBCgiuAG/VXNp/xiWo2mAetLliQqzE0GZg6EIu+TjhZV50wTfIg==
X-Received: by 2002:a17:90a:bb01:: with SMTP id u1mr19254865pjr.92.1561308141132;
        Sun, 23 Jun 2019 09:42:21 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id z186sm9183351pfz.7.2019.06.23.09.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Jun 2019 09:42:20 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v4 05/11] thermal: sun8i: rework for sun8i_ths_get_temp()
Date:   Sun, 23 Jun 2019 12:42:00 -0400
Message-Id: <20190623164206.7467-6-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190623164206.7467-1-tiny.windzz@gmail.com>
References: <20190623164206.7467-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For different socs, the way they get and calculate the
temperature is roughly the same. So get the difference
from device compatible.

Difference point:
  1) temperature calculation formula parameters
  2) ths data register start address

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index c37e1c51a543..e473a5651436 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -22,9 +22,6 @@
 
 #define MAX_SENSOR_NUM	4
 
-#define SUN50I_H6_OFFSET	-2794
-#define SUN50I_H6_SCALE		-67
-
 #define FT_TEMP_MASK				GENMASK(11, 0)
 #define TEMP_CALIB_MASK				GENMASK(11, 0)
 #define TEMP_TO_REG				672
@@ -58,6 +55,10 @@ struct tsensor {
 
 struct ths_thermal_chip {
 	int		sensor_num;
+	int		offset;
+	int		scale;
+	int		ft_deviation;
+	int		temp_data_base;
 };
 
 struct ths_device {
@@ -73,7 +74,7 @@ struct ths_device {
 static int sun8i_ths_reg2temp(struct ths_device *tmdev,
 			      int reg)
 {
-	return (reg + SUN50I_H6_OFFSET) * SUN50I_H6_SCALE;
+	return (reg + tmdev->chip->offset) * tmdev->chip->scale;
 }
 
 static int sun8i_ths_get_temp(void *data, int *temp)
@@ -82,7 +83,7 @@ static int sun8i_ths_get_temp(void *data, int *temp)
 	struct ths_device *tmdev = s->tmdev;
 	int val;
 
-	regmap_read(tmdev->regmap, SUN50I_H6_THS_TEMP_DATA +
+	regmap_read(tmdev->regmap, tmdev->chip->temp_data_base +
 		    0x4 * s->id, &val);
 
 	/* ths have no data yet */
@@ -98,7 +99,7 @@ static int sun8i_ths_get_temp(void *data, int *temp)
 	 * temperature above is also used when the sensor is calibrated. If
 	 * do this, the correct calibration formula is hard to know.
 	 */
-	*temp += SUN50I_H6_FT_DEVIATION;
+	*temp += tmdev->chip->ft_deviation;
 
 	return 0;
 }
@@ -395,6 +396,10 @@ static int sun8i_ths_remove(struct platform_device *pdev)
 
 static const struct ths_thermal_chip sun50i_h6_ths = {
 	.sensor_num = 2,
+	.offset = -2794,
+	.scale = -67,
+	.ft_deviation = SUN50I_H6_FT_DEVIATION,
+	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
 };
 
 static const struct of_device_id of_ths_match[] = {
-- 
2.17.1

