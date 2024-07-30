Return-Path: <linux-pm+bounces-11665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 606DF9412BD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 15:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841ED1C228E8
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 13:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCE31DFD8;
	Tue, 30 Jul 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="anxpxvwG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24356623
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344558; cv=none; b=ENB21QZVnBUen2vawdaWHmjZw3LiuuHo3ogVdCg4diWVDRKlwRFPRp1Kc/GELXjtWtI0JmNgnXL8QWNzzWdiCvImxJNh1f33yOyQa4vTMKL/ASRiGXcHmYDSDaYMqJkzPCPWCaNO6lszqb5d9//tx+rl3byjz4awi/09yQ0XwoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344558; c=relaxed/simple;
	bh=hrDllh0mNU8XywMa0JRzu7wg1R37WLjH1EOOxeHp8yY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQKt/aWxSraGdV9bbnoGbeYY/6CopApyvZ2MUOGzA5BtXIDe4CGxo7M5pejJ+6Mfi6/Ff7WvkvJPzL3grgWv1VYsQU1whTjGCR/Di1rJqKSExpUrbjCS/dreQF5M+K24DQ7vNsxPkxlX/kxwhXMHxSQWusZIGPcsDp+ePXjvSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=anxpxvwG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so18610645e9.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722344554; x=1722949354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R2dIB4QTYc9vVKi6HADA4MXWLrYLxkVXN+gnrOZFtN0=;
        b=anxpxvwG3fJuGQXSCO58+Rag/5bk4JDl/+B9tqgjYCaZhcyBj7kM6nqRrI+cqk2FH6
         oH8QivvHKWGMgSXI6FHjsc85SAwGq92TJ1KfDhD/mkhYe1CDemv7Nbq2xCrWDgV+oPTc
         6M6mNs4IelvuhsTPKD8wmZggNZ0K0g2uyDLdU3qd4F0cJYOELorbFFYtkxK9YvVVQcpc
         WvPv1P/zt2MLJlpdt6qFIG7l/5gCdTMHk4WcmxciK9seg2ibw0snNluKS253XmPEuv8J
         iaTscOm3vYbxkqPCAePEy/jd/Ut0tEOdjtXIKx0bDyDEAKtFz4aTwgDjbfEjKKJ45Hoe
         DwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722344554; x=1722949354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2dIB4QTYc9vVKi6HADA4MXWLrYLxkVXN+gnrOZFtN0=;
        b=mEgapbbl63NKg4c+NcTglgRx4srQwvjeMin/MSAgThJiLUxEBrH5TLh8hqS2ST4Jut
         0gIPkjCiRrw/e0XjHvb56erCmPKaWtFJoQ50XGSUuhRnjH6B60s+QTZQxtg9pvC2ijvs
         pdzVmJKKV3SLgAMPXhr0v+Ek/QVDukpr/ZcxTouvNLB0gpqyNm6vAcaM0WQVxnl/KJ20
         QSA+1i5YDN/pX3o15ZFu17NRZmoGdU2pdbp/45X9KDRZ0XpYsaDGGwpo2aXJN3E/KoDd
         TknbemJqL46BwAvSq1IWAJ6Rn7wAcTDa7HajXbzXfp0UPVmR7jzpit4cMROdiCLNJ/W1
         hIvA==
X-Forwarded-Encrypted: i=1; AJvYcCVJBvkA8aX52YU/fdyIr7QVX6T3qSR8MQyTiaJX9qRyqeCYZsB6FauxhKfWfMneAWsYCIJBedSApxwTDi+aZ5CYts4iN9wIuxk=
X-Gm-Message-State: AOJu0YxK1m/nx+NFt723kRjztZztquVJpZcfXoZd5EbkrpEtGmBAuI49
	Xrhm1bLVEYdyTDW6JD8bQoqhjR1UuMckKD7yVYu0BzEtOR2av1Da2klfwKXkwZRcKofKPVcuSEF
	04FW/dw==
X-Google-Smtp-Source: AGHT+IFJLfvBrTrdxWRIISn31wIE0LGu6jnrEGDic8jUofnRSO+fbzG98BOGseW0OOZ2U+Lb9vizkg==
X-Received: by 2002:a05:600c:4ec9:b0:427:ff1e:ab1f with SMTP id 5b1f17b1804b1-42811d9ca69mr92858975e9.14.1722344553806;
        Tue, 30 Jul 2024 06:02:33 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:291e:4a48:358e:6f49])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428134a8323sm128244305e9.46.2024.07.30.06.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 06:02:33 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-amlogic@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: amlogic: remove obsolete vpu domain driver
Date: Tue, 30 Jul 2024 15:02:22 +0200
Message-ID: <20240730130227.712894-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

meson-gx-pwrc-vpu has been superseded by meson-ee-pwrc since
commit 53773f2dfd9c ("soc: amlogic: meson-ee-pwrc: add support for the Meson GX SoCs"),
so v5.8.

This driver is obsolete and no longer used or tested.
There is no reason to keep it around so remove it.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pmdomain/amlogic/Kconfig             |  11 -
 drivers/pmdomain/amlogic/Makefile            |   1 -
 drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c | 380 -------------------
 3 files changed, 392 deletions(-)
 delete mode 100644 drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c

diff --git a/drivers/pmdomain/amlogic/Kconfig b/drivers/pmdomain/amlogic/Kconfig
index 2108729909b5..e72b664174af 100644
--- a/drivers/pmdomain/amlogic/Kconfig
+++ b/drivers/pmdomain/amlogic/Kconfig
@@ -1,17 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "Amlogic PM Domains"
 
-config MESON_GX_PM_DOMAINS
-	tristate "Amlogic Meson GX Power Domains driver"
-	depends on ARCH_MESON || COMPILE_TEST
-	depends on PM && OF
-	default ARCH_MESON
-	select PM_GENERIC_DOMAINS
-	select PM_GENERIC_DOMAINS_OF
-	help
-	  Say yes to expose Amlogic Meson GX Power Domains as
-	  Generic Power Domains.
-
 config MESON_EE_PM_DOMAINS
 	tristate "Amlogic Meson Everything-Else Power Domains driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/pmdomain/amlogic/Makefile b/drivers/pmdomain/amlogic/Makefile
index 3d58abd574f9..99f195f09957 100644
--- a/drivers/pmdomain/amlogic/Makefile
+++ b/drivers/pmdomain/amlogic/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
 obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
diff --git a/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c b/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c
deleted file mode 100644
index 6028e91664a4..000000000000
--- a/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c
+++ /dev/null
@@ -1,380 +0,0 @@
-/*
- * Copyright (c) 2017 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * SPDX-License-Identifier: GPL-2.0+
- */
-
-#include <linux/platform_device.h>
-#include <linux/pm_domain.h>
-#include <linux/bitfield.h>
-#include <linux/regmap.h>
-#include <linux/mfd/syscon.h>
-#include <linux/of.h>
-#include <linux/reset.h>
-#include <linux/clk.h>
-#include <linux/module.h>
-
-/* AO Offsets */
-
-#define AO_RTI_GEN_PWR_SLEEP0		(0x3a << 2)
-
-#define GEN_PWR_VPU_HDMI		BIT(8)
-#define GEN_PWR_VPU_HDMI_ISO		BIT(9)
-
-/* HHI Offsets */
-
-#define HHI_MEM_PD_REG0			(0x40 << 2)
-#define HHI_VPU_MEM_PD_REG0		(0x41 << 2)
-#define HHI_VPU_MEM_PD_REG1		(0x42 << 2)
-#define HHI_VPU_MEM_PD_REG2		(0x4d << 2)
-
-struct meson_gx_pwrc_vpu {
-	struct generic_pm_domain genpd;
-	struct regmap *regmap_ao;
-	struct regmap *regmap_hhi;
-	struct reset_control *rstc;
-	struct clk *vpu_clk;
-	struct clk *vapb_clk;
-};
-
-static inline
-struct meson_gx_pwrc_vpu *genpd_to_pd(struct generic_pm_domain *d)
-{
-	return container_of(d, struct meson_gx_pwrc_vpu, genpd);
-}
-
-static int meson_gx_pwrc_vpu_power_off(struct generic_pm_domain *genpd)
-{
-	struct meson_gx_pwrc_vpu *pd = genpd_to_pd(genpd);
-	int i;
-
-	regmap_update_bits(pd->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
-			   GEN_PWR_VPU_HDMI_ISO, GEN_PWR_VPU_HDMI_ISO);
-	udelay(20);
-
-	/* Power Down Memories */
-	for (i = 0; i < 32; i += 2) {
-		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG0,
-				   0x3 << i, 0x3 << i);
-		udelay(5);
-	}
-	for (i = 0; i < 32; i += 2) {
-		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG1,
-				   0x3 << i, 0x3 << i);
-		udelay(5);
-	}
-	for (i = 8; i < 16; i++) {
-		regmap_update_bits(pd->regmap_hhi, HHI_MEM_PD_REG0,
-				   BIT(i), BIT(i));
-		udelay(5);
-	}
-	udelay(20);
-
-	regmap_update_bits(pd->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
-			   GEN_PWR_VPU_HDMI, GEN_PWR_VPU_HDMI);
-
-	msleep(20);
-
-	clk_disable_unprepare(pd->vpu_clk);
-	clk_disable_unprepare(pd->vapb_clk);
-
-	return 0;
-}
-
-static int meson_g12a_pwrc_vpu_power_off(struct generic_pm_domain *genpd)
-{
-	struct meson_gx_pwrc_vpu *pd = genpd_to_pd(genpd);
-	int i;
-
-	regmap_update_bits(pd->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
-			   GEN_PWR_VPU_HDMI_ISO, GEN_PWR_VPU_HDMI_ISO);
-	udelay(20);
-
-	/* Power Down Memories */
-	for (i = 0; i < 32; i += 2) {
-		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG0,
-				   0x3 << i, 0x3 << i);
-		udelay(5);
-	}
-	for (i = 0; i < 32; i += 2) {
-		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG1,
-				   0x3 << i, 0x3 << i);
-		udelay(5);
-	}
-	for (i = 0; i < 32; i += 2) {
-		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG2,
-				   0x3 << i, 0x3 << i);
-		udelay(5);
-	}
-	for (i = 8; i < 16; i++) {
-		regmap_update_bits(pd->regmap_hhi, HHI_MEM_PD_REG0,
-				   BIT(i), BIT(i));
-		udelay(5);
-	}
-	udelay(20);
-
-	regmap_update_bits(pd->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
-			   GEN_PWR_VPU_HDMI, GEN_PWR_VPU_HDMI);
-
-	msleep(20);
-
-	clk_disable_unprepare(pd->vpu_clk);
-	clk_disable_unprepare(pd->vapb_clk);
-
-	return 0;
-}
-
-static int meson_gx_pwrc_vpu_setup_clk(struct meson_gx_pwrc_vpu *pd)
-{
-	int ret;
-
-	ret = clk_prepare_enable(pd->vpu_clk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(pd->vapb_clk);
-	if (ret)
-		clk_disable_unprepare(pd->vpu_clk);
-
-	return ret;
-}
-
-static int meson_gx_pwrc_vpu_power_on(struct generic_pm_domain *genpd)
-{
-	struct meson_gx_pwrc_vpu *pd = genpd_to_pd(genpd);
-	int ret;
-	int i;
-
-	regmap_update_bits(pd->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
-			   GEN_PWR_VPU_HDMI, 0);
-	udelay(20);
-
-	/* Power Up Memories */
-	for (i = 0; i < 32; i += 2) {
-		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG0,
-				   0x3 << i, 0);
-		udelay(5);
-	}
-
-	for (i = 0; i < 32; i += 2) {
-		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG1,
-				   0x3 << i, 0);
-		udelay(5);
-	}
-
-	for (i = 8; i < 16; i++) {
-		regmap_update_bits(pd->regmap_hhi, HHI_MEM_PD_REG0,
-				   BIT(i), 0);
-		udelay(5);
-	}
-	udelay(20);
-
-	ret = reset_control_assert(pd->rstc);
-	if (ret)
-		return ret;
-
-	regmap_update_bits(pd->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
-			   GEN_PWR_VPU_HDMI_ISO, 0);
-
-	ret = reset_control_deassert(pd->rstc);
-	if (ret)
-		return ret;
-
-	ret = meson_gx_pwrc_vpu_setup_clk(pd);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static int meson_g12a_pwrc_vpu_power_on(struct generic_pm_domain *genpd)
-{
-	struct meson_gx_pwrc_vpu *pd = genpd_to_pd(genpd);
-	int ret;
-	int i;
-
-	regmap_update_bits(pd->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
-			   GEN_PWR_VPU_HDMI, 0);
-	udelay(20);
-
-	/* Power Up Memories */
-	for (i = 0; i < 32; i += 2) {
-		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG0,
-				   0x3 << i, 0);
-		udelay(5);
-	}
-
-	for (i = 0; i < 32; i += 2) {
-		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG1,
-				   0x3 << i, 0);
-		udelay(5);
-	}
-
-	for (i = 0; i < 32; i += 2) {
-		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG2,
-				   0x3 << i, 0);
-		udelay(5);
-	}
-
-	for (i = 8; i < 16; i++) {
-		regmap_update_bits(pd->regmap_hhi, HHI_MEM_PD_REG0,
-				   BIT(i), 0);
-		udelay(5);
-	}
-	udelay(20);
-
-	ret = reset_control_assert(pd->rstc);
-	if (ret)
-		return ret;
-
-	regmap_update_bits(pd->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
-			   GEN_PWR_VPU_HDMI_ISO, 0);
-
-	ret = reset_control_deassert(pd->rstc);
-	if (ret)
-		return ret;
-
-	ret = meson_gx_pwrc_vpu_setup_clk(pd);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static bool meson_gx_pwrc_vpu_get_power(struct meson_gx_pwrc_vpu *pd)
-{
-	u32 reg;
-
-	regmap_read(pd->regmap_ao, AO_RTI_GEN_PWR_SLEEP0, &reg);
-
-	return (reg & GEN_PWR_VPU_HDMI);
-}
-
-static struct meson_gx_pwrc_vpu vpu_hdmi_pd = {
-	.genpd = {
-		.name = "vpu_hdmi",
-		.power_off = meson_gx_pwrc_vpu_power_off,
-		.power_on = meson_gx_pwrc_vpu_power_on,
-	},
-};
-
-static struct meson_gx_pwrc_vpu vpu_hdmi_pd_g12a = {
-	.genpd = {
-		.name = "vpu_hdmi",
-		.power_off = meson_g12a_pwrc_vpu_power_off,
-		.power_on = meson_g12a_pwrc_vpu_power_on,
-	},
-};
-
-static int meson_gx_pwrc_vpu_probe(struct platform_device *pdev)
-{
-	const struct meson_gx_pwrc_vpu *vpu_pd_match;
-	struct regmap *regmap_ao, *regmap_hhi;
-	struct meson_gx_pwrc_vpu *vpu_pd;
-	struct device_node *parent_np;
-	struct reset_control *rstc;
-	struct clk *vpu_clk;
-	struct clk *vapb_clk;
-	bool powered_off;
-	int ret;
-
-	vpu_pd_match = of_device_get_match_data(&pdev->dev);
-	if (!vpu_pd_match) {
-		dev_err(&pdev->dev, "failed to get match data\n");
-		return -ENODEV;
-	}
-
-	vpu_pd = devm_kzalloc(&pdev->dev, sizeof(*vpu_pd), GFP_KERNEL);
-	if (!vpu_pd)
-		return -ENOMEM;
-
-	memcpy(vpu_pd, vpu_pd_match, sizeof(*vpu_pd));
-
-	parent_np = of_get_parent(pdev->dev.of_node);
-	regmap_ao = syscon_node_to_regmap(parent_np);
-	of_node_put(parent_np);
-	if (IS_ERR(regmap_ao)) {
-		dev_err(&pdev->dev, "failed to get regmap\n");
-		return PTR_ERR(regmap_ao);
-	}
-
-	regmap_hhi = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-						     "amlogic,hhi-sysctrl");
-	if (IS_ERR(regmap_hhi)) {
-		dev_err(&pdev->dev, "failed to get HHI regmap\n");
-		return PTR_ERR(regmap_hhi);
-	}
-
-	rstc = devm_reset_control_array_get_exclusive(&pdev->dev);
-	if (IS_ERR(rstc))
-		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
-				     "failed to get reset lines\n");
-
-	vpu_clk = devm_clk_get(&pdev->dev, "vpu");
-	if (IS_ERR(vpu_clk)) {
-		dev_err(&pdev->dev, "vpu clock request failed\n");
-		return PTR_ERR(vpu_clk);
-	}
-
-	vapb_clk = devm_clk_get(&pdev->dev, "vapb");
-	if (IS_ERR(vapb_clk)) {
-		dev_err(&pdev->dev, "vapb clock request failed\n");
-		return PTR_ERR(vapb_clk);
-	}
-
-	vpu_pd->regmap_ao = regmap_ao;
-	vpu_pd->regmap_hhi = regmap_hhi;
-	vpu_pd->rstc = rstc;
-	vpu_pd->vpu_clk = vpu_clk;
-	vpu_pd->vapb_clk = vapb_clk;
-
-	platform_set_drvdata(pdev, vpu_pd);
-
-	powered_off = meson_gx_pwrc_vpu_get_power(vpu_pd);
-
-	/* If already powered, sync the clock states */
-	if (!powered_off) {
-		ret = meson_gx_pwrc_vpu_setup_clk(vpu_pd);
-		if (ret)
-			return ret;
-	}
-
-	vpu_pd->genpd.flags = GENPD_FLAG_ALWAYS_ON;
-	pm_genpd_init(&vpu_pd->genpd, NULL, powered_off);
-
-	return of_genpd_add_provider_simple(pdev->dev.of_node,
-					    &vpu_pd->genpd);
-}
-
-static void meson_gx_pwrc_vpu_shutdown(struct platform_device *pdev)
-{
-	struct meson_gx_pwrc_vpu *vpu_pd = platform_get_drvdata(pdev);
-	bool powered_off;
-
-	powered_off = meson_gx_pwrc_vpu_get_power(vpu_pd);
-	if (!powered_off)
-		vpu_pd->genpd.power_off(&vpu_pd->genpd);
-}
-
-static const struct of_device_id meson_gx_pwrc_vpu_match_table[] = {
-	{ .compatible = "amlogic,meson-gx-pwrc-vpu", .data = &vpu_hdmi_pd },
-	{
-	  .compatible = "amlogic,meson-g12a-pwrc-vpu",
-	  .data = &vpu_hdmi_pd_g12a
-	},
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, meson_gx_pwrc_vpu_match_table);
-
-static struct platform_driver meson_gx_pwrc_vpu_driver = {
-	.probe	= meson_gx_pwrc_vpu_probe,
-	.shutdown = meson_gx_pwrc_vpu_shutdown,
-	.driver = {
-		.name		= "meson_gx_pwrc_vpu",
-		.of_match_table	= meson_gx_pwrc_vpu_match_table,
-	},
-};
-module_platform_driver(meson_gx_pwrc_vpu_driver);
-MODULE_DESCRIPTION("Amlogic Meson GX Power Domains driver");
-MODULE_LICENSE("GPL v2");
-- 
2.43.0


