Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CC6274166
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 13:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgIVLtC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 07:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgIVLn0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 07:43:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0921C0613CF;
        Tue, 22 Sep 2020 04:43:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so3006726wmi.1;
        Tue, 22 Sep 2020 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bpGLyTGFFFsvy7eUvf4p2N7aeZs8Bgtl+St8PzvtoYc=;
        b=Nia7PZj2XhIagSgk3TpOp9d4d1hmKtrp7i5bCGpK45loLkmt8j/QY9I+8Vp8H36X0D
         RSvhcEiOwlRtoRvGBeBzo0f7DBrb2jFtHtxaM4szpYzNxgyvR4F51N2j/2a/l+EX6eDU
         YJW7DpHl/ho/j5xCcBGU7a7unBKDZsfAZ39owbKr211UM+KKYwbSjC82M98lAdMkT2v4
         gdSRzNCaa0/7vDUIPJdC21LBa2PBcYJiIMthz6fGOsVA14emPOKd6K4+83NRTOl2UQfE
         gQsC+Vod8KCnDLM80hfClrl/PPLjNAfDxO/ukZoJbNzE6OIAFOeBiH6n5e0ibQH6mAa/
         A9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpGLyTGFFFsvy7eUvf4p2N7aeZs8Bgtl+St8PzvtoYc=;
        b=f85BkCyLRNuD3tZPMlBcxhrI+5R3c8vzdhMETNQwnGNWowyaXQpq9RKHWOrvCDhu8S
         vC3UBMUq4uPJdhv6TkRjYRo3FfjFEY7LVTVyJnEYmhRyJj1iYC8l5zB/nID5KblD9wOb
         04Y4W7iMfLk8Ogqpg68Os+u9RVyI65vehkqUw9TkAPzFdQHHadyHSUW76T9nq/NaY1h7
         SdOGm9YN3KIwcXnaB2H+nHpCqnZRqQi9KJy6V0WJo+Ct1B9N5ZekbPOu+UQyxIIPClXJ
         gnMejPPRQNI9RWTwwXqNONLhqfX3MaRCZs5MNCJGHE4Hn2ER9NaWxh9Twl96PBPGJqEH
         WUaw==
X-Gm-Message-State: AOAM530RQ6S8COyHgWC451AGMLxygrlBKViqwnWn4Wsg4xgQTu8FOd4x
        mS+lZ39DCLDjcI0Jg+5wknY=
X-Google-Smtp-Source: ABdhPJy+nNu5DY6MJAxBvtzBp86fGbGhf547KSWKBEXiH3sweBE8GwULh/UfJNxysjX6SQAXdkkfKA==
X-Received: by 2002:a1c:32c6:: with SMTP id y189mr588444wmy.51.1600775003382;
        Tue, 22 Sep 2020 04:43:23 -0700 (PDT)
Received: from localhost (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id c4sm4561954wme.27.2020.09.22.04.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 04:43:22 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v5 1/7] power: supply: max17040: Use devm_ to automate remove
Date:   Tue, 22 Sep 2020 14:42:31 +0300
Message-Id: <20200922114237.1803628-2-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922114237.1803628-1-iskren.chernev@gmail.com>
References: <20200922114237.1803628-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Two actions were performed during remove - power supply dereg and
delayed work cleanup. Power supply dereg can be handled by using the
devm_ version of the registration function. Work cleanup can be added as
a devm_action.

If probe fails after psy registration it will now be cleaned up
properly.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Tested-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/max17040_battery.c | 39 +++++++++++++------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 6cb31b9a958dd..19b9e710bbd2f 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -207,6 +207,19 @@ static void max17040_check_changes(struct i2c_client *client)
 	max17040_get_status(client);
 }
 
+static void max17040_queue_work(struct max17040_chip *chip)
+{
+	queue_delayed_work(system_power_efficient_wq, &chip->work,
+			   MAX17040_DELAY);
+}
+
+static void max17040_stop_work(void *data)
+{
+	struct max17040_chip *chip = data;
+
+	cancel_delayed_work_sync(&chip->work);
+}
+
 static void max17040_work(struct work_struct *work)
 {
 	struct max17040_chip *chip;
@@ -223,8 +236,7 @@ static void max17040_work(struct work_struct *work)
 	if (last_soc != chip->soc || last_status != chip->status)
 		power_supply_changed(chip->battery);
 
-	queue_delayed_work(system_power_efficient_wq, &chip->work,
-			   MAX17040_DELAY);
+	max17040_queue_work(chip);
 }
 
 static irqreturn_t max17040_thread_handler(int id, void *dev)
@@ -339,7 +351,7 @@ static int max17040_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
 
-	chip->battery = power_supply_register(&client->dev,
+	chip->battery = devm_power_supply_register(&client->dev,
 				&max17040_battery_desc, &psy_cfg);
 	if (IS_ERR(chip->battery)) {
 		dev_err(&client->dev, "failed: power supply register\n");
@@ -368,18 +380,11 @@ static int max17040_probe(struct i2c_client *client,
 	}
 
 	INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
-	queue_delayed_work(system_power_efficient_wq, &chip->work,
-			   MAX17040_DELAY);
-
-	return 0;
-}
-
-static int max17040_remove(struct i2c_client *client)
-{
-	struct max17040_chip *chip = i2c_get_clientdata(client);
+	ret = devm_add_action(&client->dev, max17040_stop_work, chip);
+	if (ret)
+		return ret;
+	max17040_queue_work(chip);
 
-	power_supply_unregister(chip->battery);
-	cancel_delayed_work(&chip->work);
 	return 0;
 }
 
@@ -403,12 +408,11 @@ static int max17040_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct max17040_chip *chip = i2c_get_clientdata(client);
 
-	queue_delayed_work(system_power_efficient_wq, &chip->work,
-			   MAX17040_DELAY);
-
 	if (client->irq && device_may_wakeup(dev))
 		disable_irq_wake(client->irq);
 
+	max17040_queue_work(chip);
+
 	return 0;
 }
 
@@ -442,7 +446,6 @@ static struct i2c_driver max17040_i2c_driver = {
 		.pm	= MAX17040_PM_OPS,
 	},
 	.probe		= max17040_probe,
-	.remove		= max17040_remove,
 	.id_table	= max17040_id,
 };
 module_i2c_driver(max17040_i2c_driver);
-- 
2.28.0

