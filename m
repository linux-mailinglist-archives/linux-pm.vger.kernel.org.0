Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F71253207
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 16:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgHZOvn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 10:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbgHZOtR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 10:49:17 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A39C722B40;
        Wed, 26 Aug 2020 14:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453356;
        bh=ZBhWApDwCrDJpoKImS+nFVx4dksKMrud8X8VM0Co+6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ean4WHQ59iRFfzF4Ouy1Ef1zl4WcsGYtnATvmBVh9wuQybu3W98hJRX40J8lUarDH
         DoiBoHPhWewfzSV4DsNvL1yTuWnUExRoMmNdm78R8LCMqMFPbDA/GH7RpJLFNbbq3m
         Zt0S3fuKj9DwMz9FdQB6/opCUXZDcfv1bBmHwHRc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        David Lechner <david@lechnology.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/5] power: supply: lego_ev3: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:48:58 +0200
Message-Id: <20200826144858.9584-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826144858.9584-1-krzk@kernel.org>
References: <20200826144858.9584-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/lego_ev3_battery.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/lego_ev3_battery.c b/drivers/power/supply/lego_ev3_battery.c
index 1ae3710909b7..ccb00be38e2c 100644
--- a/drivers/power/supply/lego_ev3_battery.c
+++ b/drivers/power/supply/lego_ev3_battery.c
@@ -166,27 +166,21 @@ static int lego_ev3_battery_probe(struct platform_device *pdev)
 
 	batt->iio_v = devm_iio_channel_get(dev, "voltage");
 	err = PTR_ERR_OR_ZERO(batt->iio_v);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get voltage iio channel\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err,
+				     "Failed to get voltage iio channel\n");
 
 	batt->iio_i = devm_iio_channel_get(dev, "current");
 	err = PTR_ERR_OR_ZERO(batt->iio_i);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get current iio channel\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err,
+				     "Failed to get current iio channel\n");
 
 	batt->rechargeable_gpio = devm_gpiod_get(dev, "rechargeable", GPIOD_IN);
 	err = PTR_ERR_OR_ZERO(batt->rechargeable_gpio);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get rechargeable gpio\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err,
+				     "Failed to get rechargeable gpio\n");
 
 	/*
 	 * The rechargeable battery indication switch cannot be changed without
-- 
2.17.1

