Return-Path: <linux-pm+bounces-43616-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGSgDC6CqGmYvAAAu9opvQ
	(envelope-from <linux-pm+bounces-43616-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 20:04:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F1A206D17
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 20:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 517073058ED1
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 18:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369823DFC61;
	Wed,  4 Mar 2026 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVeEnba4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B8A3DBD64
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650692; cv=none; b=lxllyggfhoeGHwcqBTooLJalgxkOeA0WHii8TBAJhma0excmbbiTtunN7oiIN+nlqGmNXns28A3Go9NW5ye22PDFmqLnj43A7MGdMZw4n+05Ni9GsgB0HoFWKI5910JBWM1KbNMyBKLQye38wZ39eg6f3xzq3ahK1sAo4CAIPo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650692; c=relaxed/simple;
	bh=ZTqgWtpj6tKUgf32dtc8i7L8MjH0YqS/79IDbEUtnwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcoOK9hhe6NOXa3yGulnAyRrPCzDBduXQJR/o9E92gM5eEXUhVIL32a4Vy1XPZ7RYFhXWttVFeXevjRCTznCQ4FjJYzBLpFXkZJtv8lrpYBRgCbjj5XQ3V+dSy/SKeDxBA5/BDvK810ER6WLijMl/Ry1qo1faXj32UZve49ccnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVeEnba4; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-389e71756d8so139022131fa.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 10:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772650687; x=1773255487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdovW4y7qNJYO1ZIVTtHt3DP+4V/Cdk3nKOn+FFq9HA=;
        b=NVeEnba4oSKuHcSSCz+BTGG/T2JcNWkhhFeTblqdxKeO2qSkK/Znbi0Xlvwp2h72CF
         1Mhn6KfUvahEoIfx3x8OTFr1sqSbDWDqvbzijsIus2wf1t4gWN5VLE7H9f3fV8Fy72OP
         /kVwMoa7jm4zhOmcvWpe5X8eGYL4LNVHF912CbJvjI7DSEAGxNkCVAGG7BrAe6QDvwC3
         pfSqPfP+YAbocvz/Xay3MrAQazol549WcYPUvxwtEeGLcj2BWR6pd3T9bxZBP3OxNZiR
         KFBvTHtE7cp3KzQCnsv7EKPYq+z3sWLoYdTHB3NSeLlwgR7QwRU9NtWXROxdDUXnYT6Y
         JLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772650687; x=1773255487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RdovW4y7qNJYO1ZIVTtHt3DP+4V/Cdk3nKOn+FFq9HA=;
        b=e7grd40G5NdXoHKedCMuLMqNiDooRJDuaIKYb3fzDqBPoVCtHBPgraKn8rM+f1h8ch
         3VCMIhcH0P0loFA+yY4BOsa2PLM93lTJ4uP6QstFg8gMSjwyJpDFi3aOx57WH4tRZWiv
         K7HHCg/3AiS43WcfUVHPEMFBW4gv2hta8GeH1xOQZp7i/AgZsYSnCsNOBxeML9xU1PoN
         ugfz+oECk887zO4WtU4RyW6Cc0AVO4+w/O0q9l4RZ1ow7LL2wTj61A0mXlse3HiyE7Sk
         aEQRbxhJA5Tr7D5kvQQa0E8ti02DnHUj/q4CCm4jtcw6kzqgBKRsqag9loJrCZZNzsQ6
         GwkA==
X-Forwarded-Encrypted: i=1; AJvYcCVmPeE5ntVgfm2x05bRiVFbIitYC4m4yXUPRApFVXFTqVzC78dx5WIVSedEmJcPnsr7gWedFPAGNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpHfORF/TUsV8b8K4QryeR56CZbJ1hwvvu3y9sRH7PzkOx6yEe
	i3noz+1WBuvxPse4YM1wjntha+hhs41dqR1yQfWaliCf1bxw7Mrx7/Cg
X-Gm-Gg: ATEYQzzaxGt+N3M32kbqubVcHFjl/9VtwGkrM+SSTnPOL5hb1lacbHkfRH/GH6ERhTV
	LUjtWWA5iWsJVPkxMS3KQOUCeFT/M/VHOOiKdMa3B75L5oLV+bqORTVmhiS4Xl1AjLp7fhP3yFt
	ah5IxykAcvTax7RW+bjxoFQJcIdrgoQyfHiRIf4zvwxCnTokor+D9FUX+rOPZPbFuEeBWYoLvMz
	tgnYxqlVNS92sHv9wPhqL5TZ7tEchdfSpIr7uVL1CBVQQnWKes5DKpbJIX6A32u1+bZPFp9a9Kn
	OXgIEpBKZCuiF+nR+d5xPFpCf5fGrPH6QQQeS3cVszZVrrPsSJ2WyxpPycb4eDIhM8FogwMFovt
	9QSdVEQxdfGgNp769XLiDnfsYwg1op80KkxYpoqKpn0z3gNtkGn/STXRjeXvU2Z7D+GHGz+ErdL
	/iKFpudYENFJ7H
X-Received: by 2002:a2e:bd13:0:b0:38a:3381:991f with SMTP id 38308e7fff4ca-38a33819db9mr3763751fa.2.1772650687124;
        Wed, 04 Mar 2026 10:58:07 -0800 (PST)
Received: from xeon ([188.163.112.72])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a12a6ddd3bsm704985e87.0.2026.03.04.10.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:58:06 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 4/7] input: keyboard: Add driver for ASUS Transformer dock multimedia keys
Date: Wed,  4 Mar 2026 20:57:48 +0200
Message-ID: <20260304185751.83494-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304185751.83494-1-clamor95@gmail.com>
References: <20260304185751.83494-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B9F1A206D17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43616-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,agorria.com,rere.qmqm.pl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qmqm.pl:email,agorria.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Add support for multimedia top button row of ASUS Transformer's Mobile
Dock keyboard. Driver is made that function keys (F1-F12) are used by
default which suits average Linux use better and with pressing
ScreenLock + AltGr function keys layout is switched to multimedia keys.
Since this only modifies codes sent by asus-ec-keys it doesn't affect
normal keyboards at all.

Co-developed-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/input/keyboard/Kconfig                |  10 +
 drivers/input/keyboard/Makefile               |   1 +
 .../input/keyboard/asus-transformer-ec-keys.c | 272 ++++++++++++++++++
 3 files changed, 283 insertions(+)
 create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 2ff4fef322c2..4e577e5cf216 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -89,6 +89,16 @@ config KEYBOARD_APPLESPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called applespi.
 
+config KEYBOARD_ASUS_TRANSFORMER_EC
+	tristate "Asus Transformer's Mobile Dock multimedia keys"
+	depends on MFD_ASUS_TRANSFORMER_EC
+	help
+	  Say Y here if you want to use multimedia keys present on Asus
+	  Transformer's Mobile Dock.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called asus-transformer-ec-keys.
+
 config KEYBOARD_ATARI
 	tristate "Atari keyboard"
 	depends on ATARI
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 2d906e14f3e2..575edb0e8eb4 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_KEYBOARD_ADP5585)		+= adp5585-keys.o
 obj-$(CONFIG_KEYBOARD_ADP5588)		+= adp5588-keys.o
 obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 obj-$(CONFIG_KEYBOARD_APPLESPI)		+= applespi.o
+obj-$(CONFIG_KEYBOARD_ASUS_TRANSFORMER_EC)	+= asus-transformer-ec-keys.o
 obj-$(CONFIG_KEYBOARD_ATARI)		+= atakbd.o
 obj-$(CONFIG_KEYBOARD_ATKBD)		+= atkbd.o
 obj-$(CONFIG_KEYBOARD_BCM)		+= bcm-keypad.o
diff --git a/drivers/input/keyboard/asus-transformer-ec-keys.c b/drivers/input/keyboard/asus-transformer-ec-keys.c
new file mode 100644
index 000000000000..02516ccb0b12
--- /dev/null
+++ b/drivers/input/keyboard/asus-transformer-ec-keys.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/array_size.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/mfd/asus-transformer-ec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define ASUSEC_EXT_KEY_CODES		0x20
+
+struct asus_ec_keys_data {
+	struct notifier_block nb;
+	struct asusec_info *ec;
+	struct input_dev *xidev;
+	bool special_key_pressed;
+	bool special_key_mode;
+	unsigned short keymap[ASUSEC_EXT_KEY_CODES * 2];
+};
+
+static void asus_ec_input_event(struct input_handle *handle,
+				unsigned int event_type,
+				unsigned int event_code, int value)
+{
+	struct asus_ec_keys_data *priv = handle->handler->private;
+
+	/* Store special key state */
+	if (event_type == EV_KEY && event_code == KEY_RIGHTALT)
+		priv->special_key_pressed = !!value;
+}
+
+static int asus_ec_input_connect(struct input_handler *handler, struct input_dev *dev,
+				 const struct input_device_id *id)
+{
+	struct input_handle *handle;
+	int error;
+
+	handle = kzalloc_obj(*handle);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev = dev;
+	handle->handler = handler;
+	handle->name = "asusec-media-handler";
+
+	error = input_register_handle(handle);
+	if (error)
+		goto err_free_handle;
+
+	error = input_open_device(handle);
+	if (error)
+		goto err_unregister_handle;
+
+	return 0;
+
+ err_unregister_handle:
+	input_unregister_handle(handle);
+ err_free_handle:
+	kfree(handle);
+
+	return error;
+}
+
+static void asus_ec_input_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+static const struct input_device_id asus_ec_input_ids[] = {
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit = { BIT_MASK(EV_KEY) },
+	},
+	{ }
+};
+
+static struct input_handler asus_ec_input_handler = {
+	.name =	"asusec-media-handler",
+	.event = asus_ec_input_event,
+	.connect = asus_ec_input_connect,
+	.disconnect = asus_ec_input_disconnect,
+	.id_table = asus_ec_input_ids,
+};
+
+static const unsigned short asus_ec_dock_ext_keys[] = {
+	/* Function keys [0x00 - 0x19] */
+	[0x01] = KEY_DELETE,
+	[0x02] = KEY_F1,
+	[0x03] = KEY_F2,
+	[0x04] = KEY_F3,
+	[0x05] = KEY_F4,
+	[0x06] = KEY_F5,
+	[0x07] = KEY_F6,
+	[0x08] = KEY_F7,
+	[0x10] = KEY_F8,
+	[0x11] = KEY_F9,
+	[0x12] = KEY_F10,
+	[0x13] = KEY_F11,
+	[0x14] = KEY_F12,
+	[0x15] = KEY_MUTE,
+	[0x16] = KEY_VOLUMEDOWN,
+	[0x17] = KEY_VOLUMEUP,
+	/* Multimedia keys [0x20 - 0x39] */
+	[0x21] = KEY_SCREENLOCK,
+	[0x22] = KEY_WLAN,
+	[0x23] = KEY_BLUETOOTH,
+	[0x24] = KEY_TOUCHPAD_TOGGLE,
+	[0x25] = KEY_BRIGHTNESSDOWN,
+	[0x26] = KEY_BRIGHTNESSUP,
+	[0x27] = KEY_BRIGHTNESS_AUTO,
+	[0x28] = KEY_PRINT,
+	[0x30] = KEY_WWW,
+	[0x31] = KEY_CONFIG,
+	[0x32] = KEY_PREVIOUSSONG,
+	[0x33] = KEY_PLAYPAUSE,
+	[0x34] = KEY_NEXTSONG,
+	[0x35] = KEY_MUTE,
+	[0x36] = KEY_VOLUMEDOWN,
+	[0x37] = KEY_VOLUMEUP,
+};
+
+static void asus_ec_keys_report_key(struct input_dev *dev, unsigned int code,
+				    unsigned int key, bool value)
+{
+	input_event(dev, EV_MSC, MSC_SCAN, code);
+	input_report_key(dev, key, value);
+	input_sync(dev);
+}
+
+static int asus_ec_keys_process_key(struct input_dev *dev, u8 code)
+{
+	struct asus_ec_keys_data *priv = dev_get_drvdata(dev->dev.parent);
+	unsigned int key = 0;
+
+	if (code == 0)
+		return NOTIFY_DONE;
+
+	/* Flip special key mode state when pressing key 1 with special key pressed */
+	if (priv->special_key_pressed && code == 1) {
+		priv->special_key_mode = !priv->special_key_mode;
+		return NOTIFY_DONE;
+	}
+
+	/*
+	 * Relocate code to second "page" if pressed state XOR's mode state
+	 * This way special key will invert the current mode
+	 */
+	if (priv->special_key_mode ^ priv->special_key_pressed)
+		code += ASUSEC_EXT_KEY_CODES;
+
+	if (code < dev->keycodemax) {
+		unsigned short *map = dev->keycode;
+
+		key = map[code];
+	}
+
+	if (!key)
+		key = KEY_UNKNOWN;
+
+	asus_ec_keys_report_key(dev, code, key, 1);
+	asus_ec_keys_report_key(dev, code, key, 0);
+
+	return NOTIFY_OK;
+}
+
+static int asus_ec_keys_notify(struct notifier_block *nb,
+			       unsigned long action, void *data_)
+{
+	struct asus_ec_keys_data *priv = container_of(nb, struct asus_ec_keys_data, nb);
+	u8 *data = data_;
+
+	if (action & ASUSEC_SMI_MASK)
+		return NOTIFY_DONE;
+
+	if (action & ASUSEC_SCI_MASK)
+		return asus_ec_keys_process_key(priv->xidev, data[2]);
+
+	return NOTIFY_DONE;
+}
+
+static void asus_ec_keys_setup_keymap(struct asus_ec_keys_data *priv)
+{
+	struct input_dev *dev = priv->xidev;
+	unsigned int i;
+
+	BUILD_BUG_ON(ARRAY_SIZE(priv->keymap) < ARRAY_SIZE(asus_ec_dock_ext_keys));
+
+	dev->keycode = priv->keymap;
+	dev->keycodesize = sizeof(*priv->keymap);
+	dev->keycodemax = ARRAY_SIZE(priv->keymap);
+
+	input_set_capability(dev, EV_MSC, MSC_SCAN);
+	input_set_capability(dev, EV_KEY, KEY_UNKNOWN);
+
+	for (i = 0; i < ARRAY_SIZE(asus_ec_dock_ext_keys); i++) {
+		unsigned int code = asus_ec_dock_ext_keys[i];
+
+		if (!code)
+			continue;
+
+		__set_bit(code, dev->keybit);
+		priv->keymap[i] = code;
+	}
+}
+
+static void asus_ec_input_handler_deregister(void *priv)
+{
+	input_unregister_handler(&asus_ec_input_handler);
+}
+
+static int asus_ec_keys_probe(struct platform_device *pdev)
+{
+	struct asusec_info *ec = cell_to_ec(pdev);
+	struct i2c_client *parent = to_i2c_client(pdev->dev.parent);
+	struct asus_ec_keys_data *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	priv->ec = ec;
+
+	priv->xidev = devm_input_allocate_device(&pdev->dev);
+	if (!priv->xidev)
+		return -ENOMEM;
+
+	priv->xidev->name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+					   "%s Keyboard Ext", ec->model);
+	priv->xidev->phys = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+					   "i2c-%u-%04x",
+					   i2c_adapter_id(parent->adapter),
+					   parent->addr);
+	asus_ec_keys_setup_keymap(priv);
+
+	ret = input_register_device(priv->xidev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register extension keys: %d\n",
+			ret);
+		return ret;
+	}
+
+	asus_ec_input_handler.private = priv;
+
+	ret = input_register_handler(&asus_ec_input_handler);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev, asus_ec_input_handler_deregister,
+				       priv);
+	if (ret)
+		return ret;
+
+	priv->nb.notifier_call = asus_ec_keys_notify;
+
+	return devm_asus_ec_register_notifier(pdev, &priv->nb);
+}
+
+static struct platform_driver asus_ec_keys_driver = {
+	.driver.name = "asus-transformer-ec-keys",
+	.probe = asus_ec_keys_probe,
+};
+module_platform_driver(asus_ec_keys_driver);
+
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_DESCRIPTION("ASUS Transformer's multimedia keys driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0


