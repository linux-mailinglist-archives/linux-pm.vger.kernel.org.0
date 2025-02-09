Return-Path: <linux-pm+bounces-21610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2228BA2E11C
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 23:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E26163ECA
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 22:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9771FC10F;
	Sun,  9 Feb 2025 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3z9XctR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170722F17D
	for <linux-pm@vger.kernel.org>; Sun,  9 Feb 2025 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739138837; cv=none; b=IwtNtFuHnZ2DcICpRNlBniwK2X5sU/LYRzEkZd7dAPQ7GSWfgmo3LNZrvZ7wFKk+qIsVTnveRlzxzJPTDlD474MJK92DlDZ1rRupQoz5Q/Ja6BhCpsvkxXnlZvkFgCpEu+fN+uoAvssqQTC2XR+5N9pp5BXcW0fomtPKJz+Jo4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739138837; c=relaxed/simple;
	bh=uroPKKaN+hm8ZOaXXgQ6wTDHWe3x+0gyAjigUkvchR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxHyvCNcu+xPaABUC1xcZYR16vQsrQi9Tv68tokKx6EFLALxsXRwnxs8/QXlMGG2L2DA1l52Y4hqWjXzwvu9j9itFNwc8+XYjxJrbEuEtmtpuLQglSv6gF/+uJkbTfy0wqqKxrdWDvZSU9vF/OS3BQAl2QTuCkyVSsHuqMM2Xys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3z9XctR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dc9f3cc80so774532f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 09 Feb 2025 14:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739138833; x=1739743633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=369dAJGZKeB0JOjSvrMu1FUQdCgqdozrza7riiyrYK0=;
        b=i3z9XctRhEAmJVi3sLDc8Sp6Oi0akSE1xHkj62yYKQeW9vLKVtvoc8eD/zHevuwl2n
         VA6pDB5DBNXpIUbEhaOYTTSB95Jbp4x5SbSGwNeZUprJw686qm23EWZrQKdxl9xBi3MH
         pI0vgGEzVJVqPDRPhciSmGdNojafLmQOYpwHnX/JqXrOVuNbAUf/Psmwbj0rpL/sfxwR
         2Rysu9Vsn7XctcX3iPW19fWgyhvZyIj8UhY01aQTrLTG+eRIdLCm4DSpffqZHFydWnub
         COpJ4hYgJVBZe7wn3RJ1DTlVkodJSmeKJ3wrJZ/b59+0vjX4ATL58/BBf3nvlnEj4kry
         15QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739138833; x=1739743633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=369dAJGZKeB0JOjSvrMu1FUQdCgqdozrza7riiyrYK0=;
        b=v4RxNk5gy4/hFs3I+j5JwIJYgk5f/WbDUWoF90TPTM9XVYzJvPs5Vpcbkt4XCsfaqL
         1FiL+4KDCaTmKdwoNX+aTEpmcVEdgJLzga2OJa9DU/T3CZnxn+oE7EnIkAt5QKWrv/We
         tqICLQblvTgXmeA8SrNCPXqBfZ4lmWqv4AbakKNTP361TWN65wJm95Wwz7wCc33s3zgn
         i9Tvy1DNoItm+Dz4PfK3xZwKm/sF8o5Tshz75QiaD5ktxg+uayKphF2QIXNcYrJ1tv0/
         R9ze+5httUHOBxHsizE85+iwR4i+NE9GGvsNcqhanpal+1OResewSuqbSLTR4bsp+UWQ
         aACw==
X-Forwarded-Encrypted: i=1; AJvYcCU/U4rGaRKuvRdBPNQ996p9oPZd0ftlaedcQpF8kwe63CE8yIFwTaPY8UY8+4rxTYRYeZvyGjpfcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwhOdCQo4FQv/MbXkq6gBv/kHgiahjkpjAoCItHI8h7VFJsyav
	60byx7oFPRYGdzEee0pa791CooITOxyoShJHMptt6Y4nCtThiPmo
X-Gm-Gg: ASbGncvfva21iFjO86fwa4kwZoG6D1bK4caNqJ3aga+mhWJwOXaok7DGS+UMgls5Wnz
	PoAjRVDKveNTrc2puGin1CQsVjEmy4W8SmHQXOxIjJHlVSn7Rq0KwZpwC/FIRsD1WH5vDI6r8pl
	/DKo58gwrtCleBJjcEJCiW4/sbK4XkFcA55b81gmLbFe2SBJnb3uvxKD9Di1kZq5KPmOMMX/NCg
	B3+7G//kXFUptffuJVcZT0omuI+vRxpoaDRxApNGQ+t7H9OJm8m/tUDijJSXxwPEnI2iAUm68cO
	qaDcFaq0IaHkJQLMVFtl9SBPLxP4
X-Google-Smtp-Source: AGHT+IGQNeDm9SkXrpQUSzcKpyxZS28meHGL8UbkTV9jZIpjqhrqbWvmN7mXz5mtgw2H/4aI14AXXQ==
X-Received: by 2002:a05:6000:4028:b0:38d:d767:364 with SMTP id ffacd0b85a97d-38dd7670e6fmr3783272f8f.13.1739138833224;
        Sun, 09 Feb 2025 14:07:13 -0800 (PST)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbf2ed900sm10386544f8f.53.2025.02.09.14.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 14:07:12 -0800 (PST)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: soc@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Haylen Chu <heylenay@outlook.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Reichel <sre@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 09/10] power: reset: cv18xx: New driver
Date: Sun,  9 Feb 2025 23:06:34 +0100
Message-ID: <20250209220646.1090868-10-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new driver to support cold and warm reset on Cvitek CV18xx and Sophgo
SG2000 SoCs.

Link: https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 MAINTAINERS                        |  1 +
 drivers/power/reset/Kconfig        | 12 ++++
 drivers/power/reset/Makefile       |  1 +
 drivers/power/reset/cv18xx-reset.c | 89 ++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+)
 create mode 100644 drivers/power/reset/cv18xx-reset.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e4f5d8f68581..b7fec02f7673 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22147,6 +22147,7 @@ M:	Chen Wang <unicorn_wang@outlook.com>
 M:	Inochi Amaoto <inochiama@outlook.com>
 T:	git https://github.com/sophgo/linux.git
 S:	Maintained
+F:	drivers/power/reset/cv18xx-reset.c
 N:	sophgo
 K:	sophgo
 
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 60bf0ca64cf3..d41ed3c2a30d 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -75,6 +75,18 @@ config POWER_RESET_BRCMSTB
 	  Say Y here if you have a Broadcom STB board and you wish
 	  to have restart support.
 
+config POWER_RESET_CV18XX
+	bool "Cvitek CV18XX/Sophgo SG2000 reset driver"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	depends on MFD_SYSCON
+	default ARCH_SOPHGO
+	help
+	  This driver provides restart support for Cvitek CV18xx and
+	  Sophgo SG2000 SoCs.
+
+	  Say Y here if you have a Cvitek CV18xx or Sophgo SG2000 SoC and
+	  you wish to have restart support.
+
 config POWER_RESET_EP93XX
 	bool "Cirrus EP93XX reset driver" if COMPILE_TEST
 	depends on MFD_SYSCON
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 10782d32e1da..ce24e74e0477 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_POWER_RESET_ATC260X) += atc260x-poweroff.o
 obj-$(CONFIG_POWER_RESET_AXXIA) += axxia-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMKONA) += brcm-kona-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMSTB) += brcmstb-reboot.o
+obj-$(CONFIG_POWER_RESET_CV18XX) += cv18xx-reset.o
 obj-$(CONFIG_POWER_RESET_EP93XX) += ep93xx-restart.o
 obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) += gemini-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
diff --git a/drivers/power/reset/cv18xx-reset.c b/drivers/power/reset/cv18xx-reset.c
new file mode 100644
index 000000000000..bc1797e7d3f5
--- /dev/null
+++ b/drivers/power/reset/cv18xx-reset.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+/* RTCSYS_CTRL registers */
+#define RTC_CTRL_UNLOCKKEY		0x04
+#define RTC_CTRL0			0x08
+#define  REQ_PWR_CYC			BIT(3)
+#define  REQ_WARM_RST			BIT(4)
+
+/* RTCSYS_CORE registers */
+#define RTC_EN_PWR_CYC_REQ		0xC8
+#define RTC_EN_WARM_RST_REQ		0xCC
+
+static struct regmap *rtcsys_ctrl_regs;
+static struct regmap *rtcsys_core_regs;
+
+static int cv18xx_restart_handler(struct sys_off_data *data)
+{
+	u32 reg_en = RTC_EN_WARM_RST_REQ;
+	u32 request = 0xFFFF0800;
+
+	if (data->mode == REBOOT_COLD) {
+		reg_en = RTC_EN_PWR_CYC_REQ;
+		request |= REQ_PWR_CYC;
+	} else {
+		request |= REQ_WARM_RST;
+	}
+
+	/* Enable reset request */
+	regmap_write(rtcsys_core_regs, reg_en, 1);
+	/* Enable CTRL0 register access */
+	regmap_write(rtcsys_ctrl_regs, RTC_CTRL_UNLOCKKEY, 0xAB18);
+	/* Request reset */
+	regmap_write(rtcsys_ctrl_regs, RTC_CTRL0, request);
+
+	return NOTIFY_DONE;
+}
+
+static int cv18xx_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	if (!np)
+		return -ENODEV;
+
+	rtcsys_ctrl_regs = syscon_regmap_lookup_by_phandle(np, "sophgo,rtcsys-ctrl");
+	if (IS_ERR(rtcsys_ctrl_regs))
+		return dev_err_probe(dev, PTR_ERR(rtcsys_ctrl_regs),
+				     "sophgo,rtcsys-ctrl lookup failed\n");
+
+	rtcsys_core_regs = syscon_regmap_lookup_by_phandle(np, "sophgo,rtcsys-core");
+	if (IS_ERR(rtcsys_core_regs))
+		return dev_err_probe(dev, PTR_ERR(rtcsys_core_regs),
+				     "sophgo,rtcsys-core lookup failed\n");
+
+	ret = devm_register_restart_handler(&pdev->dev, cv18xx_restart_handler, NULL);
+	if (ret)
+		dev_err(&pdev->dev, "Cannot register restart handler (%pe)\n", ERR_PTR(ret));
+	return ret;
+}
+
+static const struct of_device_id cv18xx_reset_of_match[] = {
+	{ .compatible = "sophgo,cv1800-reset" },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cv18xx_reset_of_match);
+
+static struct platform_driver cv18xx_reset_driver = {
+	.probe = cv18xx_reset_probe,
+	.driver = {
+		.name = "cv18xx-reset",
+		.of_match_table = cv18xx_reset_of_match,
+	},
+};
+module_platform_driver(cv18xx_reset_driver);
+
+MODULE_AUTHOR("Alexander Sverdlin <alexander.sverdlin@gmail.com>");
+MODULE_DESCRIPTION("Cvitek CV18xx/Sophgo SG2000 Reset Driver");
+MODULE_ALIAS("platform:cv18xx-reset");
-- 
2.48.1


