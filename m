Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4952825F0AA
	for <lists+linux-pm@lfdr.de>; Sun,  6 Sep 2020 23:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIFVbW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 17:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgIFVbU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 17:31:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA496C061573;
        Sun,  6 Sep 2020 14:31:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so13466909wrn.0;
        Sun, 06 Sep 2020 14:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bpGLyTGFFFsvy7eUvf4p2N7aeZs8Bgtl+St8PzvtoYc=;
        b=FS2VnZXqEK4soyQQqvVkielSnrBCZiDdtsGJHVCo3ElxbgBDSfgp+1Kc4U10jLfGvG
         G9suTjVALZ+Bmkt9qh5aQToqNXhqunB9Or47SbkUrpC5orSTckt6b0YMv6NK97gan7B9
         Dqvg/EC21qqeA7u3hrFLnX7xFZqU1Z3KUO6iCPy25DGY6826Z/N6VLQyVEesyIYVauxy
         5kiEP1T8+d0X/rBYdlxSmZqS3eIycoWl2J42pUnP3MyKkTOC6e9ratgW5eOEYhwx1e7v
         0uhwA+R0xcf+ARAiwviEMSs6fST+df++DNXW4KwumoMO64sI7xEKTh1kTLc5QtllfWlO
         oL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpGLyTGFFFsvy7eUvf4p2N7aeZs8Bgtl+St8PzvtoYc=;
        b=qGY6tOZ/kr4ZS/RL/slyI1lq9MhacWXXxBQ70qEn31HkQKW5GVsZpk8ryuNb4F3Ntw
         nbuDEKmncKDXGd90k+viMkdNxbOA//GVsXovJMlCvlwTpLI91hhS7wxoFmlcdSEODOU6
         qUoaS2yJ63ts/xsI9kCrYgVwFL+Qf3oHVi+C+Iqt5tkxxRc6sfaero6AWDwq36BTse4v
         b2ls/iA6bYh0Wr70+3IC3tBviG3AONnGAA035cXRgPhPeZTdpOwb1JufMkB+so5DUmxK
         UhPe+/VY74Pl2yU5DaVQG96sPMZdm+R04dc0iVkpttB4fQwlMhx87go33zRPQW0S8kWg
         vuOA==
X-Gm-Message-State: AOAM533C2zgblzyX3I+fe7O0dt2TbY3joNMGVXFtF7fpsHgQ7Ifj3rKT
        ZP30DKZQsIdNHR1+Nt1KC3Y=
X-Google-Smtp-Source: ABdhPJx7z/S1YEZ5s0b0cxZIJrCnPHM1XlAwwVpdwEA4SaFyDEZf1DIKbczibKcM1LKyzLdrNnZniQ==
X-Received: by 2002:adf:b101:: with SMTP id l1mr9964102wra.96.1599427878710;
        Sun, 06 Sep 2020 14:31:18 -0700 (PDT)
Received: from localhost ([91.92.14.102])
        by smtp.gmail.com with ESMTPSA id z19sm4605033wmi.3.2020.09.06.14.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 14:31:18 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v4 1/7] power: supply: max17040: Use devm_ to automate remove
Date:   Mon,  7 Sep 2020 00:30:50 +0300
Message-Id: <20200906213056.2161410-2-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906213056.2161410-1-iskren.chernev@gmail.com>
References: <20200906213056.2161410-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
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

