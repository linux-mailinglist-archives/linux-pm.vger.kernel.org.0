Return-Path: <linux-pm+bounces-39266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8FECAAA3B
	for <lists+linux-pm@lfdr.de>; Sat, 06 Dec 2025 17:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32B1B3009C25
	for <lists+linux-pm@lfdr.de>; Sat,  6 Dec 2025 16:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450A62701B6;
	Sat,  6 Dec 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrwUrSTs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11D918CC13
	for <linux-pm@vger.kernel.org>; Sat,  6 Dec 2025 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765038659; cv=none; b=pnB00sl5NVfLWZgdOk2aHwqugDJNG1ewS41sm8w9iZ98NPmzg+y7+DyzjCfwgP1a3rvkaLnvee/zWnMxTOvmQddK7vy4EGqck3QSQRyzFoqbU89HAQey/A5Hs+pSQpsmuFnzycoHx8Y0tJhxa6+hlrzRJf0UlD/P95QsanlzMfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765038659; c=relaxed/simple;
	bh=Pjqq3IhQZEU0T+kr+l+SJxkmnGc2LedDezow2IDI6B4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b9PL8y0u0eBkAWOHvvaiC0wsUOMU+Vp3ZC5n399o0jG7WH0tNas2ozb3aNQJ7wEPX6QaYNJ8zPs/6ZdyXEMrnJSzvq/rriOippU0N+/HYjFBXoHxpJiaACzjwdF2oYXKRwgAN1x1siKR5NByfzwP9ne8jIzzFiLY+LqbDLF8l5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrwUrSTs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-298144fb9bcso33143225ad.0
        for <linux-pm@vger.kernel.org>; Sat, 06 Dec 2025 08:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765038657; x=1765643457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDSd8Vdq8giSc188TspRF54MXu3sfJ1VJvqYKX7oxLI=;
        b=ZrwUrSTs8wsy6Ou6QubTXVrSqRDcqZJ45vmJ5ClP1cyqaaeOEyyrlGQfryqOWhVLiT
         moMrUBRx/Ds2PjNhbafuQc+mEweOIr7ps5ZSrvWSoop73K9FlefZUh8jqiuvbhAESj6g
         ijzZqTi0v9kR8lmOaInXnDO/w0l+mlL2Np4OtgIslwE8Xkl1v/xJRRFmrau+80xy+R/n
         1NpzMojOwv1rT9SHfNjRHh27U+Igl76qj4v6JnsVHisST17EdhxVIroVo+ElDKcJX/xK
         tXncZTxKqZIWl9HBIbOfhNMY69KOF8RnB+VP+rkxNN0MG8p8QELT81vMLVHGvgY6hB4D
         ZtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765038657; x=1765643457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDSd8Vdq8giSc188TspRF54MXu3sfJ1VJvqYKX7oxLI=;
        b=jlSKyVLj08vaRf2jgYUK6VlB5HxnLQsSnspNMqKTmHuU9MHdheMI3eLcA/+jTgb+AY
         Epsz3Z9m41uJBjNpFuwcHKe/1gc+wK2Z9tgym0McIfxfZxkYOU6hF/u5NsFcDRX27z9V
         tSItJahcqmDvmvZbONrzdJwfPQYjW5V5XWoYEoNqK/QA+iEG1OnkvLDOIdOK8mo2ToGU
         GmuOOxNzSogBoQcAbF9FmCCP7cw+49Ubu8E5obbYNeLW4casaAO6hZrdFdTrgen3nhyW
         CT1FhRDFJsV8VmLhvynnW3ZTOtvtpE9KWQekG4YiZOXc7WGs0R/ORohf5yTVLzZs3fBi
         NJmA==
X-Forwarded-Encrypted: i=1; AJvYcCUXmLu9XW+QwmfdCApXwPFwLgjzaTxrFYuDwS7EcJOyF20HehU53lwGVi/yRQp2BKlcql0TDwf3jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRby8KqdJi13L0fUFL8Cn86htnuTR0ur8zglmQxQjTNrDjgVbj
	jcOGmCIu2OK2a9vALiOmX/sivL6M3F0NoIJnYVCGk2jB/f+boAZwR6dt
X-Gm-Gg: ASbGnct9/CAlPwoRQ0nxXGrHfEOAMtJtCLT0W3bXus9bgvpvEQ4yAsZqOp49VNNzsPH
	s2pvOOnipC8F+NmXxjDkHCGYR2L1zjbcV5TanALlZTYzrdEgYNRC88I+XXEkGbYybDkb1EuqTDq
	Jvfau2j7NrxE5snj5F+3I7FY+7lErPqV3Bj1jCBpBXAYaR3rf7jzRWKk0L4byU3yKdxRL80TEGH
	K0rXGPCiqvc3sxE+0adtFlFOgR5102tf1k2qbC4Yv1Zs/PIH7wvzfWyF3e5RA13vY0k4ise4R8J
	5VwWqDCgNe/J2tI60Ylbi+5bdDf7WJ908htAjLuPj249gQGkLfWtkbXxFIPYluJIV1HjDn2BAto
	5PUMZmJ+AnNw4IiUiKH+b5CwR6GxDl8gDWAUjBrnPLy7y7lr2WWqi7TpsFCHpppLkjv5qejKXZ+
	0ja3H5OChnrpJrqQIQupYaZlxts/Cv25i7ig==
X-Google-Smtp-Source: AGHT+IGjvoE4fTOveWBDEffY1step8XtJFOeFdFKl3HR5Zhlm5TuQ08EkqpDdpzaQhfZMWQaABB/pw==
X-Received: by 2002:a17:902:d2c8:b0:298:42ba:c422 with SMTP id d9443c01a7336-29df5e1dfe6mr24842845ad.31.1765038656777;
        Sat, 06 Dec 2025 08:30:56 -0800 (PST)
Received: from DESKTOP-IM4PCEA.localdomain ([49.207.52.239])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29daeaabbb1sm78468455ad.82.2025.12.06.08.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 08:30:55 -0800 (PST)
From: Mintu Patel <mintupatel89@gmail.com>
To: 
Cc: Mintu Patel <mintupatel89@gmail.com>,
	Saurabh Kumar <saurabhsingh14june@gmail.com>,
	Shahid Kagadgar <shahidkagadgar3821@gmail.com>,
	Dilshad Alam <Dil.alam@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] Dumping GPIOs state during suspend state
Date: Sat,  6 Dec 2025 22:00:51 +0530
Message-Id: <20251206163101.828-1-mintupatel89@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is difficult to find out which GPIOs are going high during suspend
without manual probing with multimeters or oscilloscopes.
In order to save the power especifically for battery operated devices,
It becomes must to pull GPIOs low during suspend.

As of now there is no way to trace which GPIOs are high during suspend
without manual probing with multimeters or oscilloscopes.
This patch would help the developer to find the GPIOs are high during
suspend state without struggling with hardware devices.

The patch would print the below logs:

[  244.029392] GPIO Chip : 3000000.pinctrl
[  244.029394] GPIO   Suspend state
[  244.029404] 3      1
[  244.029418] 17      1
[  244.029424] 21      1
[  244.029431] 30      1
[  244.029436] 32      1
[  244.029440] 33      1
[  244.029444] 34      1
[  244.029447] 35      1
[  244.029453] 41      1
[  244.029462] 51      1
[  244.029470] 57      1
[  244.029492] 90      1
[  244.029496] 91      1
[  244.029515] 114      1
[  244.029519] 115      1
[  244.029523] 117      1

Based on the above logs, GPIOs 3, 17, etc are high during suspend state.
Thus particular driver/submodule can be modified for configuring
the GPIOs accordingly for suspend and resume states.

Co-developed-by: Saurabh Kumar <saurabhsingh14june@gmail.com>
Signed-off-by: Saurabh Kumar <saurabhsingh14june@gmail.com>
Co-developed-by: Shahid Kagadgar <shahidkagadgar3821@gmail.com>
Signed-off-by: Shahid Kagadgar <shahidkagadgar3821@gmail.com>
Co-developed-by: Dilshad Alam <Dil.alam@gmail.com>
Signed-off-by: Dilshad Alam <Dil.alam@gmail.com>
Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
---
 drivers/gpio/gpiolib.c | 36 ++++++++++++++++++++++++++++++++++++
 kernel/power/suspend.c |  8 ++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 94903fc1c145..65a8d2150d90 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -51,6 +51,10 @@
 /* Device and char device-related information */
 static DEFINE_IDA(gpio_ida);
 static dev_t gpio_devt;
+#ifdef CONFIG_DEBUG_FS
+void gpio_state_fetch_at_suspend(void);
+DEFINE_SPINLOCK(gpio_lock);
+#endif
 #define GPIO_DEV_MAX 256 /* 256 GPIO chip devices supported */
 
 static int gpio_bus_match(struct device *dev, struct device_driver *drv)
@@ -4702,6 +4706,38 @@ void gpiod_put_array(struct gpio_descs *descs)
 }
 EXPORT_SYMBOL_GPL(gpiod_put_array);
 
+#ifdef CONFIG_DEBUG_FS
+static void fetching_gpios_state_suspend(struct gpio_chip *chip) {
+
+	int gpio_num, value = 0;
+
+	pr_info("GPIO Chip : %s\n",chip->label);
+	pr_info("GPIO   Suspend state\n");
+	for (gpio_num = 0; gpio_num <chip->ngpio; gpio_num++ ) {
+		value = chip->get(chip, gpio_num);
+			if(value != 0) {
+			pr_info("%d      %d\n",gpio_num, value);
+			}
+	}
+	}
+
+void gpio_state_fetch_at_suspend() {
+
+	struct gpio_device *gdev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+	list_for_each_entry(gdev, &gpio_devices, list)
+		if (gdev->chip != NULL) {
+			fetching_gpios_state_suspend( gdev->chip);
+		}
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+}
+
+EXPORT_SYMBOL_GPL(gpio_state_fetch_at_suspend);
+#endif
+
 static int gpio_stub_drv_probe(struct device *dev)
 {
 	/*
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 09f8397bae15..e8d28206b053 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -33,6 +33,10 @@
 
 #include "power.h"
 
+#ifdef CONFIG_DEBUG_FS
+extern void gpio_state_fetch_at_suspend(void);
+#endif
+
 const char * const pm_labels[] = {
 	[PM_SUSPEND_TO_IDLE] = "freeze",
 	[PM_SUSPEND_STANDBY] = "standby",
@@ -429,6 +433,10 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	if (suspend_test(TEST_PLATFORM))
 		goto Platform_wake;
 
+#ifdef CONFIG_DEBUG_FS
+	gpio_state_fetch_at_suspend();
+#endif
+
 	if (state == PM_SUSPEND_TO_IDLE) {
 		s2idle_loop();
 		goto Platform_wake;
-- 
2.25.1


