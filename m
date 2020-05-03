Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8512F1C2D57
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgECPVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 11:21:13 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:35642 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbgECPVM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 May 2020 11:21:12 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49FV7V1X1KzGj;
        Sun,  3 May 2020 17:21:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588519270; bh=9+54rd/b9MFSvGJ5H7aKdvK4EyDceTpr1Ul1xvO7tH8=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=HhhKdvWPt8ojeOojYUmj4BOYsBqW+vWR/x9jk4+hE0l7fLPYtUAgk+l7T1i+ybTvR
         d5iz0uMsTJpfWEvCXaJOsr9N6OkJwCCHXK/gSrkxOOYFDWg8+ynCbyW9LCxxCPJ9Jc
         lttnWQxa0Nwlp9cupfyTJVgZZaFtLJ4+oXgguVXjliNSqOV8uUz6v/AQMVkh94DI2+
         j1q8mz2QCGsl676C54+sfZB1PMKpY4XQ0gmrIQyoGI52eHLP6WDwsIseRyOsSBe3+x
         SHYmnjQ0UDyMtNVz9inyMSqyjR7rVM/6YdPTaCsRF6y4vZOF7Xp1eEaWoMroxellQR
         BS3NXdreBXsDg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 03 May 2020 17:21:10 +0200
Message-Id: <1b3c0d2b01c56cfc073f9ff4961f077098edbe67.1588517058.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 01/11] power: bq25890: remove redundant I2C bus check
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

regmap initialization will check I2C adapter functionality.
Remove redundant check in the driver.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index aebd1253dbc9..c642519ef7b2 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -881,17 +881,11 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 static int bq25890_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	struct i2c_adapter *adapter = client->adapter;
 	struct device *dev = &client->dev;
 	struct bq25890_device *bq;
 	int ret;
 	int i;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
-		dev_err(dev, "No support for SMBUS_BYTE_DATA\n");
-		return -ENODEV;
-	}
-
 	bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
 	if (!bq)
 		return -ENOMEM;
-- 
2.20.1

