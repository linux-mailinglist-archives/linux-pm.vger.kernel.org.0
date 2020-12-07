Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953202D1D54
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 23:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgLGW36 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 17:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgLGW36 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 17:29:58 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915E1C061793
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 14:29:17 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so20381500lfh.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 14:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Z7vXIFm1nN8q1nU0Yw8i5nugjLivvO7Dp4dIDNpOHA=;
        b=g/HD6zErfhsiIhiKVQYp++lcjqSYaA/bCArI/edpHG+Q+ocCjgIuue31lAm7xdKjKW
         bRg8N/lWrcCFRdh9GPy2YuaVf5oisA4VP0IL3g2KMCn26MrfMLEJwB1NNXk4vOT2Oa0w
         iSfYJSlLKveSUs0JB5ufB9N2Q2646YqdJfAjFNkmbCJJKmSzjRc28gI/14Zq6H4C30hg
         hst1DWx//F11Kabb6Ui42ShkLmQ8wwrwyhceRph9i8LO44I5iaMc2xAMzBh91lUISqc1
         m0Qxwizk511GTk5FbLh1MEpd7aH2dBsOGefyXpQcn1d6J37xippIUehQAN1ouVzutQmI
         5DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Z7vXIFm1nN8q1nU0Yw8i5nugjLivvO7Dp4dIDNpOHA=;
        b=sSWOZxKFgn0b0D1Xr1Cr23+Cls6otYX/04vSt3zdoBXzcRYZM7K4UAfMcZH7kUIYIY
         FV5/Ux9NtFXye1G8OX01AFzh7hCBbO2Te8XtpgeObHTe1ilZr+4/v2m+9zLdorVCEUhM
         7bW7cjotrl4ZC4YyXKQ4/q1gi+4fTWJlnLxaCoIgOGvvz+se1zqW2dZiLgQGcj0KLOQQ
         YsW4/q3mPM0ubohl6HNhdfax7aeeaREHJzGcjbiLQDoHJPF4nJDXMqrzptIlV1zk6itI
         YvGSD99dLWIqZz2r2NFnbAM/Mrxjs7spHbG5x6at+nlfDQdQeGYnRxJDAg4zh1vQA4Bx
         AQvQ==
X-Gm-Message-State: AOAM531kDJPANZvPimQjamx+H4W/hTyeKzndujZIJIwzKxSF8tIk7mkM
        aG/SVsp4WH+9WbOyxT+wOQ==
X-Google-Smtp-Source: ABdhPJxMYfnISVrV9prkQ+yMPED5UD9XnjBMdMOrVzsaxn/j0xMmInjJsHTk1VQOZB0/xvoVZeLEUA==
X-Received: by 2002:a19:ec09:: with SMTP id b9mr9607293lfa.178.1607380156120;
        Mon, 07 Dec 2020 14:29:16 -0800 (PST)
Received: from localhost.localdomain ([212.180.222.158])
        by smtp.gmail.com with ESMTPSA id p19sm3012316lfh.82.2020.12.07.14.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:29:15 -0800 (PST)
From:   Marek Czerski <ma.czerski@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, Marek Czerski <ma.czerski@gmail.com>
Subject: [PATCH] power: reset: ltc2952: make trigger delay configurable
Date:   Mon,  7 Dec 2020 23:28:29 +0100
Message-Id: <20201207222829.13676-1-ma.czerski@gmail.com>
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
index cd2d7f58a..881f15a78 100644
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
+        trigger-delay-ms = <2000>;
 	watchdog-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
 	kill-gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
 };
diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index 318927938..243811541 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -55,6 +55,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/gpio/consumer.h>
 #include <linux/reboot.h>
+#include <linux/of.h>
 
 struct ltc2952_poweroff {
 	struct hrtimer timer_trigger;
@@ -172,10 +173,17 @@ static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
 static int ltc2952_poweroff_init(struct platform_device *pdev)
 {
 	int ret;
+	u32 trigger_delay_ms;
 	struct ltc2952_poweroff *data = platform_get_drvdata(pdev);
 
 	ltc2952_poweroff_default(data);
 
+	if (!of_property_read_u32(pdev->dev.of_node, "trigger-delay-ms",
+				  &trigger_delay_ms)) {
+		data->trigger_delay = ktime_set(trigger_delay_ms / MSEC_PER_SEC,
+			(trigger_delay_ms % MSEC_PER_SEC) * NSEC_PER_MSEC);
+	}
+
 	data->gpio_watchdog = devm_gpiod_get(&pdev->dev, "watchdog",
 					     GPIOD_OUT_LOW);
 	if (IS_ERR(data->gpio_watchdog)) {
-- 
2.25.1

