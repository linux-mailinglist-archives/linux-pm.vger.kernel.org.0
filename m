Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF25B30E527
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 22:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhBCVt5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 16:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhBCVt4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2021 16:49:56 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33932C0613D6;
        Wed,  3 Feb 2021 13:49:16 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id f19so877751ljn.5;
        Wed, 03 Feb 2021 13:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjj/jkP+xn619jANr2B4+D1sCFTFtB9T3NGWPn2LjBc=;
        b=hFzLCgIudkVuHaU+AsBo3PCx753kPHuscLyt9remO4q2A6GJjyyZSxGR7wZ/bN3HfG
         tw6SbrBWZ7Aaczs8FEX8jlsbng7V6K7o09LBRMJwq2YtoMjoO+Ij3v3T8C9JGyiReI/u
         v1+fi2TmR9IlQQWo9uQGbC6PQi/Q7f4jyRuKtMBTF6+Sy8i03RhGtHzuuL3uN2n1Khlq
         1Kg7Ox+VB6d8DUr83FNR5vTWbe8IBW5j6EYVtnfCzyurm7yD8JV5/A6NkEyUWXYjpsMD
         Q/B+GlHZI6je3xniqvD7HDJvUldUDLj7xWB6iPQrbprf4wuPeh7CHWpMnBrK8HiCUoG+
         OF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjj/jkP+xn619jANr2B4+D1sCFTFtB9T3NGWPn2LjBc=;
        b=WFgUtceCfuoGUeViJh+1wZ96YZIj6tOqerrCrv7EYeR6xEVjyr/FzkZ7AiU0ybxMMG
         XchvVAwgzRLSMWExiKY+QVVdAq4stik7vS1Gi5FRAAD+Pvaqvsr4gIuxSvDLlcfNoPab
         ogHaHUjOdBY6AOLdfqEUmeCZbCoMS0aZjbLvVVnsQ4ktEDZNeKm0xD0CxeC60RQ9x0zx
         Bmb9uWX/V7ixuDe1tAQSljk/c4emNW0KnQLdYJpUiB2auwoFyAy31o6DigHcap6fCxdp
         +PtkR2exqnueSg20zKqBWTvbE7fr/fZT2123ovzss/YdsmG04MqlWuAzTnZa5gG+trFV
         QK5g==
X-Gm-Message-State: AOAM531byKoYbBP52dQEw3sZMfGQ03xSRMo0QK3J6YRhhml580JiseiR
        IBO19DvAnU5T6rcdK7ZPcQ==
X-Google-Smtp-Source: ABdhPJzGGI6vNDACNDp6o9+k4gy+tF6KiiLm+DYFUDjDZrRdL26L4+TuIS7m591rm6+zH9/Mk9H5yw==
X-Received: by 2002:a2e:311:: with SMTP id 17mr2987134ljd.14.1612388954719;
        Wed, 03 Feb 2021 13:49:14 -0800 (PST)
Received: from localhost.localdomain ([212.180.222.158])
        by smtp.gmail.com with ESMTPSA id c7sm381852ljd.95.2021.02.03.13.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 13:49:14 -0800 (PST)
From:   Marek Czerski <ma.czerski@gmail.com>
To:     sre@kernel.org
Cc:     robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Marek Czerski <ma.czerski@gmail.com>
Subject: [PATCH v2] power: reset: ltc2952: make trigger delay configurable
Date:   Wed,  3 Feb 2021 22:49:00 +0100
Message-Id: <20210203214900.71677-1-ma.czerski@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make trigger delay configurable through device tree with
trigger-delay-ms property.

Trigger delay is the time to wait before starting shutdown
sequence after trigger line assertion.
Trigger delay must take into account the OFFT time configured
with the capacitor connected to OFFT pin of the LTC2952 chip.
Basically, the higher the capacitance connected to OFFT pin,
the larger trigger delay must be.

Signed-off-by: Marek Czerski <ma.czerski@gmail.com>
---
 .../devicetree/bindings/power/reset/ltc2952-poweroff.txt  | 4 ++++
 drivers/power/reset/ltc2952-poweroff.c                    | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.txt b/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.txt
index cd2d7f58a9d7..38e54b3fd9f3 100644
--- a/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.txt
+++ b/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.txt
@@ -17,6 +17,9 @@ Optional properties:
 			chip's trigger line. If this property is not set, the
 			trigger function is ignored and the chip is kept alive
 			until an explicit kill signal is received
+- trigger-delay-ms	The number of milliseconds to wait after trigger line
+			assertion before executing shut down procedure.
+			The default is 2500ms.
 
 Example:
 
@@ -24,6 +27,7 @@ ltc2952 {
 	compatible = "lltc,ltc2952";
 
 	trigger-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+	trigger-delay-ms = <2000>;
 	watchdog-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
 	kill-gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
 };
diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index 318927938b05..d1495af30081 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -55,6 +55,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/gpio/consumer.h>
 #include <linux/reboot.h>
+#include <linux/property.h>
 
 struct ltc2952_poweroff {
 	struct hrtimer timer_trigger;
@@ -172,10 +173,17 @@ static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
 static int ltc2952_poweroff_init(struct platform_device *pdev)
 {
 	int ret;
+	u32 trigger_delay_ms;
 	struct ltc2952_poweroff *data = platform_get_drvdata(pdev);
 
 	ltc2952_poweroff_default(data);
 
+	if (!device_property_read_u32(&pdev->dev, "trigger-delay-ms",
+				      &trigger_delay_ms)) {
+		data->trigger_delay = ktime_set(trigger_delay_ms / MSEC_PER_SEC,
+			(trigger_delay_ms % MSEC_PER_SEC) * NSEC_PER_MSEC);
+	}
+
 	data->gpio_watchdog = devm_gpiod_get(&pdev->dev, "watchdog",
 					     GPIOD_OUT_LOW);
 	if (IS_ERR(data->gpio_watchdog)) {
-- 
2.25.1

