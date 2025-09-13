Return-Path: <linux-pm+bounces-34595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79674B56318
	for <lists+linux-pm@lfdr.de>; Sat, 13 Sep 2025 23:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E6F172B22
	for <lists+linux-pm@lfdr.de>; Sat, 13 Sep 2025 21:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8767328488B;
	Sat, 13 Sep 2025 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbOTBjde"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8493F283FF8
	for <linux-pm@vger.kernel.org>; Sat, 13 Sep 2025 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798190; cv=none; b=Ll+k8IaPiS9wx5wDWSbRM3S0DDr9CWqVWELFYuJZrPAp2keYJOOLYZPzNSyO22j3ZR+JFfAeUhO51XN/He/DrH2WjYi11PqhMLglgZjy0fbqfiMHK/8S+7H2qESxkW84QoJ3NGPHfNhbjS+mfiRoMxrh/0kIciZcXKfLbvBtFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798190; c=relaxed/simple;
	bh=5e7C8/TepjeMtvdq2kYyVr6fK/WhjkkaD45NrgvOPnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R8aQ8XAoC2IO7Zt1V9Sq+3TIOFMy2HQIF/+APXVukZajlJYNRKA9mp29ycHTpiBj3Uvt5VQKnIzuV3O3tHxn1cUPLyuLC6ASsZ3d+sbw6BPCcD/x7qD3j8GVPD+vDb9s1J880YSkaSvtgzW1tirExBJFi7nTGdsLscJitryjpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbOTBjde; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso2191167f8f.0
        for <linux-pm@vger.kernel.org>; Sat, 13 Sep 2025 14:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798187; x=1758402987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+VP5nzPO7TU78rfhYTFY7al0sL7mhZVAIAF4JSoUlo=;
        b=CbOTBjde5lQ7N36F3xP1hZbPey4UiqlZJ0Qt4MCpUEwD9AwaVzNlTFX2n4JxxAMQaK
         zC3xw66p6M682DlD4Bll9KaGuOSjhZyruH++wbp3MSgPSO4jebD54Pq0sbz7RGcnVPq0
         BnljcKv1E8fNVFmOolLRihI6bbor0hufy16Tw8E8P1ZOReL8l66yBqccEEEemLmwb6ES
         GMlWtl50IYK902AhJBecXDTjlBHGzykrPV8Wy/Tu7sVcdSuUKspACbiqc5lWFTKrAN/j
         +WCvXD7t6lgktm2ad4hKzxZLZiM4hkieAlqIQ4EXY/IMKiZDj08VuVxfsuzv95HJ3YNp
         StbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798187; x=1758402987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+VP5nzPO7TU78rfhYTFY7al0sL7mhZVAIAF4JSoUlo=;
        b=IM0b0t2Mh5YQ1nDG8UYb/1wVjUVRHUxbSBABtzgLQG4YDPmxacN/s/jEI6RRjDYq/6
         DRahUsnMJJ87tM/a+hsFYzmuEPPT1O+sGYaWMOz3gS/KX/b34rF0jQm62LtgIWOX96t6
         0gWC89n/mydzhF+R8E+dsOO0FyXfC11UPjS1JtuzrhxuoXjuQS6L1zl+qyibvSn5kGYm
         tFTMfozNOVOQ4XnGaEWGhNxm6Uub9WQqvWWfnb0xGAvpr2J/Ob0GME/23xgZZMYVVCpx
         h8f7nM4H4F8oRCfaaY1scyaak0L8FP9ukp+gPTphIwUpHA1CI3S84GFte6Gq2ATOFmT9
         S0/g==
X-Forwarded-Encrypted: i=1; AJvYcCVr6b9pWcYewRa+HjbT6mSrS0joBcFbCV+7BcBaeFLU3co7BsN0GsuE7HZyB5KL1P2K3x9eJbg9/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNAbTo2uRG7Jm6XLyB8NQ2Lwv8VEtA/bgsmFYMA8aEMTGJjhlt
	c9rasJlept1S04YZmNt5Cl1kszCoqFrz7cH91X41ebEhoApYGco1725k
X-Gm-Gg: ASbGncv4l4g4uiZiwnKzefyLTJSfkXs2UHh6Z6dl3C5/P1Fx9G/5EPQTfi6xRWueQjS
	1aVoV73Fqyg2eVxbHo6TRdY3hkJqgUd+Md+p5c3Wk/tUWupia9Ukl3MiGItk7OlwkaR8tKETjX1
	E55QbROFrbv7R0H4DMfATFugcyCAIluCRf0WHH3qwd0ktgEvyFg1o2xEjoJxh+ooY7OH96GlCXj
	JB0HGDNqyKu8WVDYresMuZG5SbozpYajp93DjJXamzqXdFf25WoQ49FqYxdmR/p0yGO2coQ4aEU
	2mvdNEkWayY2fl72bAmHlOSDDw97SPN4PvY/J6YQwDn2IuRpC6RZfN/Rye1cgeBoAfF0i20jF/Q
	NRCNLNcs52rLcMuSEFTibg6lmX3vw15KR3PmhVtTvCPrpEE2WagKa
X-Google-Smtp-Source: AGHT+IErQfbzl+MbBvCHZhxs1p+1GYnI5sydo30kHH2h99Tqk9i7XQM6wd82P0gT6HpXmbTeKuaCjg==
X-Received: by 2002:a05:6000:2289:b0:3de:5aff:3498 with SMTP id ffacd0b85a97d-3e7659c40f9mr6426295f8f.14.1757798186616;
        Sat, 13 Sep 2025 14:16:26 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e014ac468sm65403145e9.0.2025.09.13.14.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:16:26 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 13 Sep 2025 23:12:50 +0200
Subject: [PATCH v4 3/4] clk: mmp: pxa1908: Instantiate power driver through
 auxiliary bus
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250913-pxa1908-genpd-v4-3-55e4cf32f619@dujemihanovic.xyz>
References: <20250913-pxa1908-genpd-v4-0-55e4cf32f619@dujemihanovic.xyz>
In-Reply-To: <20250913-pxa1908-genpd-v4-0-55e4cf32f619@dujemihanovic.xyz>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4616;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=w28rVWlir7yhdT2JFdKVFGiML/ldN3rGLXPeOpnXsl0=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlH7ytV2V8LFpVXk4iwbXp8pKpRROVavt7LuJkzhLbbe
 s1myKzrKGVhEONikBVTZMn973iN97PI1u3Zywxg5rAygQxh4OIUgIn47WVkWLF7ov5Fi8pXwYds
 p2TMzbuVvzdG5q5QekuY+E9u0ZPPzzIyfFr+4H/FqogKybKaJ9b6NkHfOJ8z6th9PeP96vi+gpo
 IfgA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

The power domain driver shares the APMU clock controller's registers.
Instantiate the power domain driver through the APMU clock driver using
the auxiliary bus.

Also create a separate Kconfig entry for the PXA1908 clock driver to
allow (de)selecting the driver at will and selecting
CONFIG_AUXILIARY_BUS.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
v4:
- Use devm_auxiliary_device_create()

v3:
- Move driver back to pmdomain subsystem, use auxiliary bus to
  instantiate the driver

v2:
- Move to clk subsystem, instantiate the driver from the APMU clock
  driver
- Drop clock handling
- Squash MAINTAINERS patch
---
 MAINTAINERS                        |  2 ++
 drivers/clk/Kconfig                |  1 +
 drivers/clk/mmp/Kconfig            | 10 ++++++++++
 drivers/clk/mmp/Makefile           |  5 ++++-
 drivers/clk/mmp/clk-pxa1908-apmu.c |  7 +++++++
 5 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b0e4767639b24d89fa760020a9681e5c2001a6e..148848dafac7c3dd50933ec22a3bd26170535d47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2869,7 +2869,9 @@ ARM/Marvell PXA1908 SOC support
 M:	Duje Mihanović <duje@dujemihanovic.xyz>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
 F:	arch/arm64/boot/dts/marvell/mmp/
+F:	drivers/clk/mmp/Kconfig
 F:	drivers/clk/mmp/clk-pxa1908*.c
 F:	drivers/pmdomain/marvell/
 F:	include/dt-bindings/clock/marvell,pxa1908.h
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4d56475f94fc1e28823fe6aee626a96847d4e6d5..68a9641fc649a23013b2d8a9e9f5ecb31d623abb 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -511,6 +511,7 @@ source "drivers/clk/imx/Kconfig"
 source "drivers/clk/ingenic/Kconfig"
 source "drivers/clk/keystone/Kconfig"
 source "drivers/clk/mediatek/Kconfig"
+source "drivers/clk/mmp/Kconfig"
 source "drivers/clk/meson/Kconfig"
 source "drivers/clk/mstar/Kconfig"
 source "drivers/clk/microchip/Kconfig"
diff --git a/drivers/clk/mmp/Kconfig b/drivers/clk/mmp/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..b0d2fea3cda5de1284916ab75d3af0412edcf57f
--- /dev/null
+++ b/drivers/clk/mmp/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config COMMON_CLK_PXA1908
+	bool "Clock driver for Marvell PXA1908"
+	depends on ARCH_MMP || COMPILE_TEST
+	depends on OF
+	default y if ARCH_MMP && ARM64
+	select AUXILIARY_BUS
+	help
+	  This driver supports the Marvell PXA1908 SoC clocks.
diff --git a/drivers/clk/mmp/Makefile b/drivers/clk/mmp/Makefile
index 062cd87fa8ddcc6808b6236f8c4dd524aaf02030..0a94f2f0856389c8e959981ccafbb02140a7733d 100644
--- a/drivers/clk/mmp/Makefile
+++ b/drivers/clk/mmp/Makefile
@@ -11,4 +11,7 @@ obj-$(CONFIG_MACH_MMP_DT) += clk-of-pxa168.o clk-of-pxa910.o
 obj-$(CONFIG_COMMON_CLK_MMP2) += clk-of-mmp2.o clk-pll.o pwr-island.o
 obj-$(CONFIG_COMMON_CLK_MMP2_AUDIO) += clk-audio.o
 
-obj-$(CONFIG_ARCH_MMP) += clk-of-pxa1928.o clk-pxa1908-apbc.o clk-pxa1908-apbcp.o clk-pxa1908-apmu.o clk-pxa1908-mpmu.o
+obj-$(CONFIG_COMMON_CLK_PXA1908) += clk-pxa1908-apbc.o clk-pxa1908-apbcp.o \
+	clk-pxa1908-mpmu.o clk-pxa1908-apmu.o
+
+obj-$(CONFIG_ARCH_MMP) += clk-of-pxa1928.o
diff --git a/drivers/clk/mmp/clk-pxa1908-apmu.c b/drivers/clk/mmp/clk-pxa1908-apmu.c
index d3a070687fc5b9fb5338f377f82e7664ca0aac29..7594a495a0093e8e22f2cfe3e61a13d23dc3b9c2 100644
--- a/drivers/clk/mmp/clk-pxa1908-apmu.c
+++ b/drivers/clk/mmp/clk-pxa1908-apmu.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/auxiliary_bus.h>
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -85,6 +86,7 @@ static void pxa1908_axi_periph_clk_init(struct pxa1908_clk_unit *pxa_unit)
 static int pxa1908_apmu_probe(struct platform_device *pdev)
 {
 	struct pxa1908_clk_unit *pxa_unit;
+	struct auxiliary_device *adev;
 
 	pxa_unit = devm_kzalloc(&pdev->dev, sizeof(*pxa_unit), GFP_KERNEL);
 	if (!pxa_unit)
@@ -94,6 +96,11 @@ static int pxa1908_apmu_probe(struct platform_device *pdev)
 	if (IS_ERR(pxa_unit->base))
 		return PTR_ERR(pxa_unit->base);
 
+	adev = devm_auxiliary_device_create(&pdev->dev, "power", NULL);
+	if (IS_ERR(adev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(adev),
+				     "Failed to register power controller\n");
+
 	mmp_clk_init(pdev->dev.of_node, &pxa_unit->unit, APMU_NR_CLKS);
 
 	pxa1908_axi_periph_clk_init(pxa_unit);

-- 
2.51.0


