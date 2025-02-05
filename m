Return-Path: <linux-pm+bounces-21392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5342FA28AC2
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 13:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7561888973
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3314738DE9;
	Wed,  5 Feb 2025 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hdkjsfbt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042A17BA1;
	Wed,  5 Feb 2025 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759956; cv=none; b=esiJ7J7xai92R2wQJ4kbHEYw9pLuE1jKsdqFzuEZstINPwJIk37QsFItET9FwQdMejW20hsTSrib9aDhdlhOKUSJ9MoHazynF+dRrXt4nnpV7rKoVWSxiJm4THzjkrbJsHYS4n/2mGEGbQfyhB2z7xgyPWGuNFr1fsQ9Ws2+1Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759956; c=relaxed/simple;
	bh=J+xMojpvOnH+y4xF0FQzAkneVDyy4UQzwkTwxNQpHZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uPnnfFb2jEXuGtYSfPn5y1lccAOYXjpR8649KhZGRjG4ItkBC/EuShZJs57by/ich5mhaonIoBIWT/dSph8G2Gl+zf90TisYynsXbl1ymPsTMIY1UY9FuEcZmnVfqDdg0Y7pTQNvCQwr2ev8PyesOs6YU4NLLoCLNa4QIGV7Dc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hdkjsfbt; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dce3c28889so363049a12.0;
        Wed, 05 Feb 2025 04:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738759952; x=1739364752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgfFrjRxyOW1xOgdcC7mwiMGS+SjeOrC7s5Z2O3ZWyY=;
        b=HdkjsfbtAqT7vrkbtjuANx6YCZeHDKt/z8f4XY6UO4rDln10vQGuh9ySU68dfrRJ78
         F7URhlEWuuNcPDqZl5xqmo21FAUX53zcnygFeFY8OZ6X8Kpmtbyy1BxD6iKilT2hWGE3
         DUKKpqNmZ723YimtvDH+FlrwrdFnjNGqV01L7EMDpIs7NggUKlund6/hu78eSzJdLRfn
         1HRL45lOcMAUK5+dZlrZIASzzbnKyrBU64ys4yjFI56z9atAyiWaJXXvxj0Y4j/hwWlf
         5IW89PnHK42Asx73OH98b/0s+dhXHMRlz8gZVogBgEXaJbdYrCea0LkkI8DTnFQOU5l4
         vhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759952; x=1739364752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgfFrjRxyOW1xOgdcC7mwiMGS+SjeOrC7s5Z2O3ZWyY=;
        b=v1veTZGcnkCgerCZ5snF1uWZ/etQJJowkyqHYUGlzIIrL6wfolbS976VMFPV7Bg3XX
         86hJZwRxlo5b6N0VYU4PWfF+DgFEEEp9d1EjiipklZl/aJnTw9zGQjtM64fPcBANQvdl
         iXJCrJZsv/J6K/AjlRKN4j1NGAzQQ9fa0qyokc8q9lAZlvY3IUekyJM8abgn7mZda6vD
         J42ahQrH3rQ6jvBPNsyZ6pnd0yxtI1HtmhD3c40wKYJnmvHh6KY/h4b9bkpGfc9CiYk1
         b1dq+UYhuRlRc0jNsF40CmQkSen7u7Eie/zeeUjkj9sZw5HOjTLCgq0y7BvRKzxG1fHJ
         s1mw==
X-Forwarded-Encrypted: i=1; AJvYcCV9OZzszGQdhy+1C1Jv0BSeGrKFeVjby1ITYAjhc2Ka2iyDub/XbJIlnBY6sIO5e1DXZUst+jjf6LjP@vger.kernel.org, AJvYcCVE7ou46Rlie3VJRr4z5e5Yuv28630JZ3kxpBrrFBhWCx1QjMHCRfiOejYyVe+yQXzJEXvr+jx2fkRs4A==@vger.kernel.org, AJvYcCW5msFQ8zNnQKJB+egar85k+zRf5y/IH1R/kkUvWKid8eYY4C8m9mg5RbS9i0Y2HkhivKkE5awMLkA=@vger.kernel.org, AJvYcCWyk6re7UI3qgdlpUQWc22c57wiXuZwrEbXkysiuCp/dL14MZf2qln3ozwbEudYL2CJIPjnQmpLNgETL8T5@vger.kernel.org, AJvYcCXu/kABYNgASZId7DrEEOrDiePGDDJUtAZyqi0wjxNMOfO4zvSQSj5Y8OvGTLLAgLC44DTG0Y2w1h7F@vger.kernel.org
X-Gm-Message-State: AOJu0YzR4AuA0XMzl9eggaQp8fXgNmX+KJ0WdQaMZVwSgBeYy0LFRaWs
	M+OXDrAjnR0fuDJANCwaq7LcdoTwY7UK1CxnsNURKIo8mo1wHUEJ
X-Gm-Gg: ASbGncv0gmHhYOpvjR63ZAZaF6lmmrXvrePGIt8pNzEhRqU1ZDb5XdbLIONqgf8lg+P
	InXDH4JXHZpwhA92iat3+FCGEcM4lr1Ont9dSBkB80+vabaEpRRQQMGdURnbhvY42mScMJZQcuU
	sSAhLVwc4V6vowJlHgHpuy7w2hzjxicpMlZ0L3HMnlzkAqBA/KcHCJPpMP0C0PfZgvSo4pKS8Jk
	Z+OtYaJmLZUr6LS/5BZB1/aamL4pv3mCT51R8rns34HpeSlADvlHnqV5KV8hlyS1eTfniDl/y2c
	qq2GW/GKSmk/RFU8mbsEtatd/gpRucO0eXLa+FTQf5f5VA==
X-Google-Smtp-Source: AGHT+IEAbQlJM9YpeCWJhaXrMd8JjdEQmk1PIGdg1MxSU0j0zzL77t1J5QeVhoIykZ9fWSW5KttwGw==
X-Received: by 2002:a05:6402:350c:b0:5d0:b51c:8479 with SMTP id 4fb4d7f45d1cf-5dcdb7179ccmr3428449a12.10.1738759951997;
        Wed, 05 Feb 2025 04:52:31 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724055e5sm11559997a12.45.2025.02.05.04.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 04:52:31 -0800 (PST)
From: Andras Szemzo <szemzo.andras@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 02/10] pinctrl: sunxi: add driver for Allwinner V853
Date: Wed,  5 Feb 2025 13:52:17 +0100
Message-Id: <20250205125225.1152849-3-szemzo.andras@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205125225.1152849-1-szemzo.andras@gmail.com>
References: <20250205125225.1152849-1-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The V853 family has multiple package variants, from BGA to QFN88.
The latter has co-packaged DRAM and fewer pins, and less features (pin muxes).
All family members can be supported by a single driver, as the available pins
with allowed muxes is the same across the devices.

This new pinctrl driver depends on the new sunxi device-tree based mux support
patch series [1].

[1]: https://lore.kernel.org/linux-sunxi/20241111005750.13071-1-andre.przywara@arm.com/T/

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 drivers/pinctrl/sunxi/Kconfig              |  5 ++
 drivers/pinctrl/sunxi/Makefile             |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-v853.c | 53 ++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-v853.c

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index a78fdbbdfc0c..fac9c61039e2 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -81,6 +81,11 @@ config PINCTRL_SUN9I_A80_R
 	default MACH_SUN9I
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN8I_V853
+	bool "Support for the Allwinner V853/V851S/V851SE PIO"
+	default MACH_SUN8I
+	select PINCTRL_SUNXI
+
 config PINCTRL_SUN20I_D1
 	bool "Support for the Allwinner D1 PIO"
 	default MACH_SUN8I || (RISCV && ARCH_SUNXI)
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index 2ff5a55927ad..8937b56b2ef4 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_PINCTRL_SUN8I_A83T_R)	+= pinctrl-sun8i-a83t-r.o
 obj-$(CONFIG_PINCTRL_SUN8I_H3)		+= pinctrl-sun8i-h3.o
 obj-$(CONFIG_PINCTRL_SUN8I_H3_R)	+= pinctrl-sun8i-h3-r.o
 obj-$(CONFIG_PINCTRL_SUN8I_V3S)		+= pinctrl-sun8i-v3s.o
+obj-$(CONFIG_PINCTRL_SUN8I_V853)	+= pinctrl-sun8i-v853.o
 obj-$(CONFIG_PINCTRL_SUN20I_D1)		+= pinctrl-sun20i-d1.o
 obj-$(CONFIG_PINCTRL_SUN50I_H5)		+= pinctrl-sun50i-h5.o
 obj-$(CONFIG_PINCTRL_SUN50I_H6)		+= pinctrl-sun50i-h6.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-v853.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-v853.c
new file mode 100644
index 000000000000..fb2112ee12d0
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-v853.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allwinner V853 SoC pinctrl driver.
+ *
+ * Copyright (c) 2025 Andras Szemzo <szemzo.andras@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-sunxi.h"
+
+static const u8 v853_nr_bank_pins[SUNXI_PINCTRL_MAX_BANKS] =
+/*	  PA  PB  PC  PD  PE  PF  PG  PH  PI  */
+	{ 22,  0, 12, 23, 18,  7,  8, 16,  5 };
+
+static const unsigned int v853_irq_bank_map[] = { 0, 2, 3, 4, 5, 6, 7, 8 };
+
+static const u8 v853_irq_bank_muxes[SUNXI_PINCTRL_MAX_BANKS] =
+/*	  PA  PB  PC  PD  PE  PF  PG  PH  PI */
+	{ 14,  0, 14, 14, 14, 14, 14, 14, 14 };
+
+static struct sunxi_pinctrl_desc v853_pinctrl_data = {
+	.irq_banks = ARRAY_SIZE(v853_irq_bank_map),
+	.irq_bank_map = v853_irq_bank_map,
+	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
+};
+
+static int v853_pinctrl_probe(struct platform_device *pdev)
+{
+	return sunxi_pinctrl_dt_table_init(pdev, v853_nr_bank_pins,
+					   v853_irq_bank_muxes,
+					   &v853_pinctrl_data,
+					   SUNXI_PINCTRL_NEW_REG_LAYOUT |
+					   SUNXI_PINCTRL_ELEVEN_BANKS);
+}
+
+static const struct of_device_id v853_pinctrl_match[] = {
+	{ .compatible = "allwinner,sun8i-v853-pinctrl", },
+	{}
+};
+
+static struct platform_driver v853_pinctrl_driver = {
+	.probe	= v853_pinctrl_probe,
+	.driver	= {
+		.name		= "sun8i-v853-pinctrl",
+		.of_match_table	= v853_pinctrl_match,
+	},
+};
+builtin_platform_driver(v853_pinctrl_driver);
-- 
2.39.5


