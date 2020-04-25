Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7546C1B88B9
	for <lists+linux-pm@lfdr.de>; Sat, 25 Apr 2020 21:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDYTFM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Apr 2020 15:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726192AbgDYTFM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Apr 2020 15:05:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2577AC09B04D;
        Sat, 25 Apr 2020 12:05:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a5so5362403pjh.2;
        Sat, 25 Apr 2020 12:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iLfV4hMIG5IJIWEx+tNQr6S1UUc4BLs/e1fLy8rArr8=;
        b=s8tY0lpTNju6vCnNsv1wXY5rzrYjmIxfdB5KAzjnIcT6/sXQK7vF04EkGM5Wn5hcNu
         B5z7ksLDmZniGRYV2H2SgPLdrrIcJSul41gVTALV9VBQiqHUjNJ+C1YsGJJIrf2SgrlY
         5hi3PC4qd8VIW2ppq26M3KM+0e6bTXhjrFZAqIQAZ8fNxQrqJrjy580f10TRdX2e6RJl
         Xt5b7GgcNALlDjzMkMwn5AigAsqsy9veukDIfg/uBqDhFDtFvnK4gJg4EZsTPKVOvvw9
         TGXzLeBpldGVzMOK+M+pWjnyaJuBiKZ9wnB32Sj8Hjs9/WyNH7mI8rC1CrmPZK7ls68t
         yJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iLfV4hMIG5IJIWEx+tNQr6S1UUc4BLs/e1fLy8rArr8=;
        b=ZfaOkUA+t43FX99MpBt6bQAzTri1QZVUrewaTDXR+AtiRT0x06kKCpIuCc8lQSg7it
         nMMw6sE22HLOH55p28laOVk2SZLZsW5M3YFksZT9rZYFWnldJwZI2eag7vi+SGgnUyto
         NWBov/LqN+EFem3Jah80rrBh2S9t+cYHMjxi7Hux7FkUUkB0i152nQ2zUZmR9HYujLiE
         PXWJ8gLQ8ou/3Us21lwhTCdrAEzDNESvk7I0d3BgLOd3Izvpr2z00cmij71/gHykxsJ8
         RvLdYQxymXJ0B3KQ6MuBSpQhfsKeyialO1c2+8088IKfVV+EJ/flzvihHV5w/dB9J8qa
         EHXw==
X-Gm-Message-State: AGi0Puam3viaTGSNTxLUZSFtBZ3e79p90sLp0PU9wZWzK0VnVO+eGUX+
        aEsz+IsojdumHpGLUlmLfR0=
X-Google-Smtp-Source: APiQypJKPkfh8ANZwxDRGnRGpJ2rI/CmQHUCYy0XBzO+e6NeKVlZOgDm1SwqEmE3P6KuriVRudSv7w==
X-Received: by 2002:a17:90b:1104:: with SMTP id gi4mr14416599pjb.115.1587841511623;
        Sat, 25 Apr 2020 12:05:11 -0700 (PDT)
Received: from syed ([106.223.101.50])
        by smtp.gmail.com with ESMTPSA id z7sm8441125pff.47.2020.04.25.12.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Apr 2020 12:05:11 -0700 (PDT)
Date:   Sun, 26 Apr 2020 00:35:02 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 3/6] gpio: thermal: Utilize for_each_set_clump macro
Message-ID: <66296904e2ffce670c14576dfc7ea56417c670ab.1587840668.git.syednwaris@gmail.com>
References: <cover.1587840667.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1587840667.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch replaces all the existing for_each_set_clump8 and related
function calls in the drivers (gpio and thermal) with the equivalent
new generic for_each_set_clump macro.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
Changes in v2:
 - No change.

 drivers/gpio/gpio-104-dio-48e.c            | 8 ++++----
 drivers/gpio/gpio-104-idi-48.c             | 4 ++--
 drivers/gpio/gpio-74x164.c                 | 4 ++--
 drivers/gpio/gpio-gpio-mm.c                | 8 ++++----
 drivers/gpio/gpio-max3191x.c               | 4 ++--
 drivers/gpio/gpio-pca953x.c                | 4 ++--
 drivers/gpio/gpio-pci-idio-16.c            | 8 ++++----
 drivers/gpio/gpio-pcie-idio-24.c           | 8 ++++----
 drivers/gpio/gpio-pisosr.c                 | 4 ++--
 drivers/gpio/gpio-uniphier.c               | 4 ++--
 drivers/gpio/gpio-ws16c48.c                | 8 ++++----
 drivers/thermal/intel/intel_soc_dts_iosf.c | 6 +++---
 12 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 1f7d9bb..60f0383 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -192,11 +192,11 @@ static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+	for_each_set_clump(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8, 8) {
 		port_addr = dio48egpio->base + ports[offset / 8];
 		port_state = inb(port_addr) & gpio_mask;
 
-		bitmap_set_value8(bits, port_state, offset);
+		bitmap_set_value(bits, port_state, offset, 8);
 	}
 
 	return 0;
@@ -233,11 +233,11 @@ static void dio48e_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long bitmask;
 	unsigned long flags;
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+	for_each_set_clump(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8, 8) {
 		index = offset / 8;
 		port_addr = dio48egpio->base + ports[index];
 
-		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
+		bitmask = bitmap_get_value(bits, offset, 8) & gpio_mask;
 
 		raw_spin_lock_irqsave(&dio48egpio->lock, flags);
 
diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index d350ac0..03553a31 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -94,11 +94,11 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+	for_each_set_clump(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8, 8) {
 		port_addr = idi48gpio->base + ports[offset / 8];
 		port_state = inb(port_addr) & gpio_mask;
 
-		bitmap_set_value8(bits, port_state, offset);
+		bitmap_set_value(bits, port_state, offset, 8);
 	}
 
 	return 0;
diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index 05637d5..a836433 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -79,9 +79,9 @@ static void gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 	unsigned long bitmask;
 
 	mutex_lock(&chip->lock);
-	for_each_set_clump8(offset, bankmask, mask, chip->registers * 8) {
+	for_each_set_clump(offset, bankmask, mask, chip->registers * 8, 8) {
 		bank = chip->registers - 1 - offset / 8;
-		bitmask = bitmap_get_value8(bits, offset) & bankmask;
+		bitmask = bitmap_get_value(bits, offset, 8) & bankmask;
 
 		chip->buffer[bank] &= ~bankmask;
 		chip->buffer[bank] |= bitmask;
diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index b89b8c5..5790bb7 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -181,11 +181,11 @@ static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+	for_each_set_clump(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8, 8) {
 		port_addr = gpiommgpio->base + ports[offset / 8];
 		port_state = inb(port_addr) & gpio_mask;
 
-		bitmap_set_value8(bits, port_state, offset);
+		bitmap_set_value(bits, port_state, offset, 8);
 	}
 
 	return 0;
@@ -223,11 +223,11 @@ static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long bitmask;
 	unsigned long flags;
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+	for_each_set_clump(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8, 8) {
 		index = offset / 8;
 		port_addr = gpiommgpio->base + ports[index];
 
-		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
+		bitmask = bitmap_get_value(bits, offset, 8) & gpio_mask;
 
 		spin_lock_irqsave(&gpiommgpio->lock, flags);
 
diff --git a/drivers/gpio/gpio-max3191x.c b/drivers/gpio/gpio-max3191x.c
index 310d1a2..e59f09b 100644
--- a/drivers/gpio/gpio-max3191x.c
+++ b/drivers/gpio/gpio-max3191x.c
@@ -245,7 +245,7 @@ static int max3191x_get_multiple(struct gpio_chip *gpio, unsigned long *mask,
 		goto out_unlock;
 
 	bitmap_zero(bits, gpio->ngpio);
-	for_each_set_clump8(bit, gpio_mask, mask, gpio->ngpio) {
+	for_each_set_clump(bit, gpio_mask, mask, gpio->ngpio, 8) {
 		unsigned int chipnum = bit / MAX3191X_NGPIO;
 
 		if (max3191x_chip_is_faulting(max3191x, chipnum)) {
@@ -255,7 +255,7 @@ static int max3191x_get_multiple(struct gpio_chip *gpio, unsigned long *mask,
 
 		in = ((u8 *)max3191x->xfer.rx_buf)[chipnum * wordlen];
 		in &= gpio_mask;
-		bitmap_set_value8(bits, in, bit);
+		bitmap_set_value(bits, in, bit, 8);
 	}
 
 out_unlock:
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 60ae18e..c1bc8fa 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -343,7 +343,7 @@ static int pca953x_write_regs(struct pca953x_chip *chip, int reg, unsigned long
 	int i, ret;
 
 	for (i = 0; i < NBANK(chip); i++)
-		value[i] = bitmap_get_value8(val, i * BANK_SZ);
+		value[i] = bitmap_get_value(val, i * BANK_SZ, 8);
 
 	ret = regmap_bulk_write(chip->regmap, regaddr, value, NBANK(chip));
 	if (ret < 0) {
@@ -367,7 +367,7 @@ static int pca953x_read_regs(struct pca953x_chip *chip, int reg, unsigned long *
 	}
 
 	for (i = 0; i < NBANK(chip); i++)
-		bitmap_set_value8(val, value[i], i * BANK_SZ);
+		bitmap_set_value(val, value[i], i * BANK_SZ, 8);
 
 	return 0;
 }
diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 638d665..f970756 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -112,11 +112,11 @@ static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+	for_each_set_clump(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8, 8) {
 		port_addr = ports[offset / 8];
 		port_state = ioread8(port_addr) & gpio_mask;
 
-		bitmap_set_value8(bits, port_state, offset);
+		bitmap_set_value(bits, port_state, offset, 8);
 	}
 
 	return 0;
@@ -167,11 +167,11 @@ static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long flags;
 	unsigned long out_state;
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+	for_each_set_clump(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8, 8) {
 		index = offset / 8;
 		port_addr = ports[index];
 
-		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
+		bitmask = bitmap_get_value(bits, offset, 8) & gpio_mask;
 
 		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
 
diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index 1d47579..be5cb13 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -215,7 +215,7 @@ static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+	for_each_set_clump(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8, 8) {
 		index = offset / 8;
 
 		/* read bits from current gpio port (port 6 is TTL GPIO) */
@@ -228,7 +228,7 @@ static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
 
 		port_state &= gpio_mask;
 
-		bitmap_set_value8(bits, port_state, offset);
+		bitmap_set_value(bits, port_state, offset, 8);
 	}
 
 	return 0;
@@ -291,10 +291,10 @@ static void idio_24_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long out_state;
 	const unsigned long out_mode_mask = BIT(1);
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+	for_each_set_clump(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8, 8) {
 		index = offset / 8;
 
-		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
+		bitmask = bitmap_get_value(bits, offset, 8) & gpio_mask;
 
 		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
 
diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
index 6698fea..5c9c73c 100644
--- a/drivers/gpio/gpio-pisosr.c
+++ b/drivers/gpio/gpio-pisosr.c
@@ -103,9 +103,9 @@ static int pisosr_gpio_get_multiple(struct gpio_chip *chip,
 	pisosr_gpio_refresh(gpio);
 
 	bitmap_zero(bits, chip->ngpio);
-	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+	for_each_set_clump(offset, gpio_mask, mask, chip->ngpio, 8) {
 		buffer_state = gpio->buffer[offset / 8] & gpio_mask;
-		bitmap_set_value8(bits, buffer_state, offset);
+		bitmap_set_value(bits, buffer_state, offset, 8);
 	}
 
 	return 0;
diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
index f99f3c1..47738d8 100644
--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -149,9 +149,9 @@ static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
 {
 	unsigned long i, bank, bank_mask, bank_bits;
 
-	for_each_set_clump8(i, bank_mask, mask, chip->ngpio) {
+	for_each_set_clump(i, bank_mask, mask, chip->ngpio, UNIPHIER_GPIO_LINES_PER_BANK) {
 		bank = i / UNIPHIER_GPIO_LINES_PER_BANK;
-		bank_bits = bitmap_get_value8(bits, i);
+		bank_bits = bitmap_get_value(bits, i, UNIPHIER_GPIO_LINES_PER_BANK);
 
 		uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_PORT_DATA,
 					 bank_mask, bank_bits);
diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index cb510df..87b532c 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -137,11 +137,11 @@ static int ws16c48_gpio_get_multiple(struct gpio_chip *chip,
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+	for_each_set_clump(offset, gpio_mask, mask, chip->ngpio, 8) {
 		port_addr = ws16c48gpio->base + offset / 8;
 		port_state = inb(port_addr) & gpio_mask;
 
-		bitmap_set_value8(bits, port_state, offset);
+		bitmap_set_value(bits, port_state, offset, 8);
 	}
 
 	return 0;
@@ -182,13 +182,13 @@ static void ws16c48_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long bitmask;
 	unsigned long flags;
 
-	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+	for_each_set_clump(offset, gpio_mask, mask, chip->ngpio, 8) {
 		index = offset / 8;
 		port_addr = ws16c48gpio->base + index;
 
 		/* mask out GPIO configured for input */
 		gpio_mask &= ~ws16c48gpio->io_state[index];
-		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
+		bitmask = bitmap_get_value(bits, offset, 8) & gpio_mask;
 
 		raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
 
diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index f75271b..39b6305 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -123,7 +123,7 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
 		return status;
 
 	update_ptps = store_ptps;
-	bitmap_set_value8(&update_ptps, temp_out & 0xFF, thres_index * 8);
+	bitmap_set_value(&update_ptps, temp_out & 0xFF, thres_index * 8, 8);
 	out = update_ptps;
 
 	status = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
@@ -237,7 +237,7 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
 		return status;
 
 	raw = out;
-	out = bitmap_get_value8(&raw, dts->id * 8) - SOC_DTS_TJMAX_ENCODING;
+	out = bitmap_get_value(&raw, dts->id * 8, 8) - SOC_DTS_TJMAX_ENCODING;
 	*temp = sensors->tj_max - out * 1000;
 
 	return 0;
@@ -314,7 +314,7 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 		trip_mask = 0;
 	else {
 		ptps = store_ptps;
-		for_each_set_clump8(i, trip, &ptps, writable_trip_cnt * 8)
+		for_each_set_clump(i, trip, &ptps, writable_trip_cnt * 8, 8)
 			trip_mask &= ~BIT(i / 8);
 	}
 	dts->trip_mask = trip_mask;
-- 
2.7.4

