Return-Path: <linux-pm+bounces-12729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D2D95BA17
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 17:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0585028647B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867261CCB20;
	Thu, 22 Aug 2024 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gSBtrdpV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCB41CBE89
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340501; cv=none; b=nFRzVGgiN75RmRQI086UnaFz0s+KltYfUUzZeept0sDeoadBwNRhfWP9V9S1IEKEc4/4QXYRubLB2YFzEN+ZoLhwSEYilegqz4EJ8xwn6i3bR/9spMVA+EJC21gWJVr1E8jLyD87ubJEHIpthLLpK80AcG+5KBioIS3w8hmc8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340501; c=relaxed/simple;
	bh=P0cjVSvxG8EmBspMqLkRR/lYn5jiBCxUBXi7FExd/4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=upY9MyecCQnQAEbHyamRovC0Ko6uo5pNpXGoShDZofxPpFS1AQXwpVAumGH55VQRONi9/t4ezErUqVIStkmQSXBssmttAFlkGjpQdD7LzNW3YOeNSDYsvW7S7aNjdSU/q7G/yCd7xNZnTuO79DJOXaYt2iAeP6Z1RKKZSa+VLq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gSBtrdpV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a83562f9be9so119094966b.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 08:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724340498; x=1724945298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q6gFb3LAoTj4ZZDzDA4qjfJDj1sk1ibLpvJ8GBqpwo=;
        b=gSBtrdpVYkV5860Y4K8gtann0zjrVVBkndPFzDkkKqgh91xYywnPEZDbLq1u8ZRNU3
         FsgAq81OSNgUJfyJN9SKxNyrrmKZELLbUBklIeIMt7knjo7YXjGD1jXoAILYiCukLbOl
         CZ/1Tsg8tv3OH2OJ9F/IgkGBcPrGuGxKKBhXysp8Y3ZkImqZ1c8VV4leBw+OB/o94vH6
         qywdj9fBk0QqCf4Lhf3+VEKkTBPIhZmcvXreQAj+Pjsy0nXMwPqyaFvy+WvNuGvFP8jI
         psSoPmboZsoJURST2gcVSCoqWiQx8KcV+/stIlUWViE+knJ0xGQNjwGcUtAZiIw2EtFs
         Tk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724340498; x=1724945298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6q6gFb3LAoTj4ZZDzDA4qjfJDj1sk1ibLpvJ8GBqpwo=;
        b=MIrwnXAWoie3lh9H/QuqKTtDs/z3Up7iL9yc0KHjRT9F77Yzs5d7liMTt7WtWhY2E1
         NKSfn6ukQUdY57jKTzPdpw3gfJP0PG0Lq3k+p/ZrbnGZ8SrhdGaaTsbvYgxy0i3jHLwH
         GwnQJkbyBhIHH4/7mJiBVxPQ0Nx1IoILZ+pgyOwhj3EtiQNCyxUNwfbpGzZ5n2MjR4hz
         WDxVPTP/OLS0UyZWKxBlfmxw9E7U9S3ld9o39lD6ivY9KobmfZ1LR3KgoROf3KG+c+++
         LAHu5dH5f9uXN+EhJ44J5+FLuibpfmsfC//VN1hVpPUbijnDfyF8CN5g/2R/HUZD0JAJ
         f1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcrn7irOrde5sTH8eeefATz/7CuQWazprPOn2OW2EsMjnoZttiEWA+GdGT10RP59WttEx9pR/+3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvu1WY1VD5/PhYkRUEa5SeOqS/RfoR49zqBHQN2cvOH0okXX+k
	044UB+RM/nEOfxYESAmgT/0gU7LQxVoalrOGP+tXXrABowIWSXIjv8VQ0Cua1rKIAH5UHD3QDt/
	Z
X-Google-Smtp-Source: AGHT+IFku6GurN1Vx/0hMFrk2Pt1NEf4Luk7IB+yb2dHofGfjXLtTdF78YBKlCcWth7ycyDXumSweA==
X-Received: by 2002:a17:907:1b1a:b0:a80:f6a9:c311 with SMTP id a640c23a62f3a-a866ee68e16mr449214366b.0.1724340497897;
        Thu, 22 Aug 2024 08:28:17 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484dc5sm134189166b.171.2024.08.22.08.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 08:28:17 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	gregkh@linuxfoundation.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com,
	ulf.hansson@linaro.org
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 01/16] clk: renesas: r9a08g045: Add clocks, resets and power domains for USB
Date: Thu, 22 Aug 2024 18:27:46 +0300
Message-Id: <20240822152801.602318-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add clocks, resets and power domains for USB modules available on the
Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index a891bfc3ab5a..6e9529678307 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -207,6 +207,10 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("sdhi2_imclk2",		R9A08G045_SDHI2_IMCLK2, CLK_SD2_DIV4, 0x554, 9),
 	DEF_MOD("sdhi2_clk_hs",		R9A08G045_SDHI2_CLK_HS, R9A08G045_CLK_SD2, 0x554, 10),
 	DEF_MOD("sdhi2_aclk",		R9A08G045_SDHI2_ACLK, R9A08G045_CLK_P1, 0x554, 11),
+	DEF_MOD("usb0_host",		R9A08G045_USB_U2H0_HCLK, R9A08G045_CLK_P1, 0x578, 0),
+	DEF_MOD("usb1_host",		R9A08G045_USB_U2H1_HCLK, R9A08G045_CLK_P1, 0x578, 1),
+	DEF_MOD("usb0_func",		R9A08G045_USB_U2P_EXR_CPUCLK, R9A08G045_CLK_P1, 0x578, 2),
+	DEF_MOD("usb_pclk",		R9A08G045_USB_PCLK, R9A08G045_CLK_P1, 0x578, 3),
 	DEF_COUPLED("eth0_axi",		R9A08G045_ETH0_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 0),
 	DEF_COUPLED("eth0_chi",		R9A08G045_ETH0_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 0),
 	DEF_MOD("eth0_refclk",		R9A08G045_ETH0_REFCLK, R9A08G045_CLK_HP, 0x57c, 8),
@@ -230,6 +234,10 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A08G045_SDHI1_IXRST, 0x854, 1),
 	DEF_RST(R9A08G045_SDHI2_IXRST, 0x854, 2),
+	DEF_RST(R9A08G045_USB_U2H0_HRESETN, 0x878, 0),
+	DEF_RST(R9A08G045_USB_U2H1_HRESETN, 0x878, 1),
+	DEF_RST(R9A08G045_USB_U2P_EXL_SYSRST, 0x878, 2),
+	DEF_RST(R9A08G045_USB_PRESETN, 0x878, 3),
 	DEF_RST(R9A08G045_ETH0_RST_HW_N, 0x87c, 0),
 	DEF_RST(R9A08G045_ETH1_RST_HW_N, 0x87c, 1),
 	DEF_RST(R9A08G045_I2C0_MRST, 0x880, 0),
@@ -277,6 +285,15 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 	DEF_PD("sdhi2",		R9A08G045_PD_SDHI2,
 				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(11)),
 				RZG2L_PD_F_NONE),
+	DEF_PD("usb0",		R9A08G045_PD_USB0,
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, GENMASK(6, 5)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("usb1",		R9A08G045_PD_USB1,
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(7)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("usb-phy",	R9A08G045_PD_USB_PHY,
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(4)),
+				RZG2L_PD_F_NONE),
 	DEF_PD("eth0",		R9A08G045_PD_ETHER0,
 				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(2)),
 				RZG2L_PD_F_NONE),
-- 
2.39.2


