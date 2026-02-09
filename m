Return-Path: <linux-pm+bounces-42344-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEYuJ8m6iWlwBQUAu9opvQ
	(envelope-from <linux-pm+bounces-42344-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 11:45:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE4E10E467
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 11:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45C90301588D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ACF368278;
	Mon,  9 Feb 2026 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEVQmzJP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA3336998A
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633877; cv=none; b=TK0BA0J5w1KzzkLD7CqefBo9W4IHsDgQfulxZXZ0/sfpdEnqyjlm0rg8XbhWVPiEMQvydV2jjEMpQlcfKMlrHnndA+2pL5x3exAAFekzR9sJ1yCb0ShrcbYBzIDxVJp5FkjnrxK6TjA32NDt10hxlYmIBVanhjLNJwXdUrIb6vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633877; c=relaxed/simple;
	bh=ngKFCu3cqOl5gPWRaEKogf59QUayqMRH5eB6YPE7vFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qq4abe4VLML7UM1hFjp3ZidHNtUy2i+8d7IvWbK/L0Z1pmPUHX54vuf6AfQ7ZvYZF0ORusrers2xt87X6XL+yMLdPh7VIoi4GiY3tafGaL6Wb3qWLMJdn7OwVAukgVC5MJOL2umIvy8sY4JPmc9hcCk8/F80npHTjYd3UevAbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEVQmzJP; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b6c89d302so4213536e87.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 02:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770633875; x=1771238675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIqndriki6fg3AQEF8QYByWC9DeqMY7pkJM5t0jf4fU=;
        b=QEVQmzJPK1YE+CYWirktDsG0llMNQTi6y40dxxhCGeDZMx4znmtkyBnpCTZVzZ3Gcx
         uYU/MQwMjXphMBX+zwYHCd2Bbtr/BO1xSRP0kVwFp3sZYZ3nvzTutihzLjcwxG8hBlGz
         KQ1I5p/nqSz9nobl24l1NUwUDsT6diiCq3vZ1gT+eN71m66/IN6dFLdKyHPVcapHCa1y
         7TaM4VDK2PogWE+CfBPPgwE3cN+bLF5neM9PPFsoLSoVcqfOuCYRONmXJmRkCI1ktvE0
         d8okLgDBmD5sUO9D2t/As48/BzkxiK3W/BTMqPbzEZwt6lcRKPBLyW7AyI1+fkVVGT0M
         X+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770633875; x=1771238675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XIqndriki6fg3AQEF8QYByWC9DeqMY7pkJM5t0jf4fU=;
        b=ZVW5SppdnCpkbY3xFqT+s5zsl89R/TYM56hVKm67p2ubc4pvcK2Zu1AXcCtD33riNQ
         nlNnqMZuexKlx7oPYm4fSAC685h5Iv4GgLWxUOW2S6wnS7cJz0Vng6ldAi6sn9nk6oj7
         JoUTI+7NaJoOBsSdRiFhtWI4JKn1EEUIviYkSq0sEX08PxCKqVHBUnctMH+vKcvmoWpr
         27+8BzktP4HHEB4zxDGsOIGIE90wt7NOKO9Jb+YgqXHad9A4H78NnIjjdrZQhHMo019D
         suf/pp5i6jyfriLr2OzY2CAfPXSH7qyrgF7jQo7qyEfh/3/m/QRk1krb7wHgy425h99x
         G+oA==
X-Forwarded-Encrypted: i=1; AJvYcCWe864DmgrTfH5Woar7ZgFUDoC8ww/d54agxf4woiTutRYUEUuFPfLmQe8jrgS95UQSev7p5VNaoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ6eJHiNGVbhHndDhfoXWMgWzhGlWirc9VAC+YuZX3vbjzI6ni
	Q4krDbJhyxIWhuNU2jxYV1VPxXQqSNsnuI5HxEXADni94eTZjkwcL9lC
X-Gm-Gg: AZuq6aII5kzoq9BG2JSQk7HoT4XBWloInwuOoaouw7XKb5LAt/eofZ+a5rA3ckJVhZS
	KXi3feFjArepXVkIIHzibgndO6NksHc9Drob+VuNh6NtFtrrqWOoEVTUIHH2Yd347XdzDhuJelg
	9aosRS01c6Mrnpm4+3FiVfaT+ybo71H+NJQQjAQnGlFDQbFlVSa6KzmUFaDSyU/EHACy7vatsVx
	MMG9oh/v3G3I1AFFQS4ciu24Xr9j8QHdBahOWCwcbp+agKHpOBFqZUkHpnq52MfUOplNFs6/AB8
	vazU+FAcH7LfyeBXok61zrOylwtiLZfOTRruhBghaRIseD0LGW/aoW35rdHGS3THKzsvRuRKPp0
	eeCrWHDRQuA1ME27z1sRXCrVYinBcWSfqn9BeJdIP6iJPMY+1N0w6grmC42hmk1L//L8EuHgFz4
	dq
X-Received: by 2002:a05:6512:250c:b0:59e:5243:6c95 with SMTP id 2adb3069b0e04-59e52436ed4mr233533e87.24.1770633875248;
        Mon, 09 Feb 2026 02:44:35 -0800 (PST)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6f88sm2501469e87.21.2026.02.09.02.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:44:34 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 7/9] leds: Add driver for Asus Transformer LEDs
Date: Mon,  9 Feb 2026 12:44:05 +0200
Message-ID: <20260209104407.116426-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209104407.116426-1-clamor95@gmail.com>
References: <20260209104407.116426-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42344-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qmqm.pl:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CE4E10E467
X-Rspamd-Action: no action

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Asus Transformer tablets have a green and an amber LED on both the Pad
and the Dock. If both LEDs are enabled simultaneously, the emitted light
will be yellow.

Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/leds/Kconfig        |  11 ++++
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-asus-ec.c | 104 ++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 drivers/leds/leds-asus-ec.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 597d7a79c988..96dab210f6ca 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -120,6 +120,17 @@ config LEDS_OSRAM_AMS_AS3668
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-as3668.
 
+config LEDS_ASUSEC
+	tristate "LED Support for Asus Transformer charging LED"
+	depends on LEDS_CLASS
+	depends on MFD_ASUSEC
+	help
+	  This option enables support for charging indicator on
+	  Asus Transformer's Pad and it's Dock.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-asus-ec.
+
 config LEDS_AW200XX
 	tristate "LED support for Awinic AW20036/AW20054/AW20072/AW20108"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 8fdb45d5b439..1117304dfdf4 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
 obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
 obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
 obj-$(CONFIG_LEDS_AS3668)		+= leds-as3668.o
+obj-$(CONFIG_LEDS_ASUSEC)		+= leds-asus-ec.o
 obj-$(CONFIG_LEDS_AW200XX)		+= leds-aw200xx.o
 obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
 obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
diff --git a/drivers/leds/leds-asus-ec.c b/drivers/leds/leds-asus-ec.c
new file mode 100644
index 000000000000..5dd76c9247ee
--- /dev/null
+++ b/drivers/leds/leds-asus-ec.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ASUS EC driver - battery LED
+ */
+
+#include <linux/err.h>
+#include <linux/leds.h>
+#include <linux/mfd/asus-ec.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/*
+ * F[5] & 0x07
+ *  auto: brightness == 0
+ *  bit 0: blink / charger on
+ *  bit 1: amber on
+ *  bit 2: green on
+ */
+
+#define ASUSEC_CTL_LED_BLINK		BIT_ULL(40)
+#define ASUSEC_CTL_LED_AMBER		BIT_ULL(41)
+#define ASUSEC_CTL_LED_GREEN		BIT_ULL(42)
+
+static void asus_ec_led_set_brightness_amber(struct led_classdev *led,
+					     enum led_brightness brightness)
+{
+	const struct asusec_info *ec = dev_get_drvdata(led->dev->parent);
+
+	if (brightness)
+		asus_ec_set_ctl_bits(ec, ASUSEC_CTL_LED_AMBER);
+	else
+		asus_ec_clear_ctl_bits(ec, ASUSEC_CTL_LED_AMBER);
+}
+
+static void asus_ec_led_set_brightness_green(struct led_classdev *led,
+					     enum led_brightness brightness)
+{
+	const struct asusec_info *ec = dev_get_drvdata(led->dev->parent);
+
+	if (brightness)
+		asus_ec_set_ctl_bits(ec, ASUSEC_CTL_LED_GREEN);
+	else
+		asus_ec_clear_ctl_bits(ec, ASUSEC_CTL_LED_GREEN);
+}
+
+static int asus_ec_led_probe(struct platform_device *pdev)
+{
+	struct asusec_info *ec = cell_to_ec(pdev);
+	struct device *dev = &pdev->dev;
+	struct led_classdev *amber_led, *green_led;
+	int ret;
+
+	platform_set_drvdata(pdev, ec);
+
+	amber_led = devm_kzalloc(dev, sizeof(*amber_led), GFP_KERNEL);
+	if (!amber_led)
+		return -ENOMEM;
+
+	amber_led->name = devm_kasprintf(dev, GFP_KERNEL, "%s::amber", ec->name);
+	amber_led->max_brightness = 1;
+	amber_led->flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
+	amber_led->brightness_set = asus_ec_led_set_brightness_amber;
+
+	ret = devm_led_classdev_register(dev, amber_led);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register amber LED\n");
+
+	green_led = devm_kzalloc(dev, sizeof(*green_led), GFP_KERNEL);
+	if (!green_led)
+		return -ENOMEM;
+
+	green_led->name = devm_kasprintf(dev, GFP_KERNEL, "%s::green", ec->name);
+	green_led->max_brightness = 1;
+	green_led->flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
+	green_led->brightness_set = asus_ec_led_set_brightness_green;
+
+	ret = devm_led_classdev_register(dev, green_led);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register green LED\n");
+
+	return 0;
+}
+
+static const struct of_device_id asus_ec_led_match[] = {
+	{ .compatible = "asus,ec-led" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, asus_ec_led_match);
+
+static struct platform_driver asus_ec_led_driver = {
+	.driver = {
+		.name = "asus-ec-led",
+		.of_match_table = asus_ec_led_match,
+	},
+	.probe = asus_ec_led_probe,
+};
+module_platform_driver(asus_ec_led_driver);
+
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("ASUS Transformer's charging LED driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0


