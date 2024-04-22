Return-Path: <linux-pm+bounces-6788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA848ACB67
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 12:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A091F226E7
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 10:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1114F12B;
	Mon, 22 Apr 2024 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nLEbod0l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA614F10C
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783255; cv=none; b=CXN8Wv/jjM1KGeNa0sjWcxUGfqth5WLSI7jbNk5RIsGWznF7KJBN8bmvK/JNy7tc9q+l0Mai/GZwtiEB/FolzgG084RCPqM3xgOuD8x34VstaQ0IMNndKjQUy9U+ogjvW4HPKETQ6W0iKzJPm84eExzhYKJf49IPy1cySjjR1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783255; c=relaxed/simple;
	bh=sdehE+zn1RQvIdReWR+XY+nVCRWOxX0wiMQ32N7tCn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rFTBqcz2YcGw+lhqMYT6kfMDfKzmHHHaPAuehaTSvIcYQnXL6Q04/bjUCrwLSU6ZR5bMQWr8UEgSXo5o6IqrMEg1NvwZsfKh4zidFJAlRo16kngZnRC8u8xv1yjuBSsLC4aDVoKRgOvf0R58DhmUE9NFG2V/ApsDrnZw4Apm4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nLEbod0l; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so6325975e9.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 03:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713783253; x=1714388053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1N7C9y6FANsDWlj/dSgm/X0vOo9KMVHsfxdkeCTUls=;
        b=nLEbod0lXZ92+d0VG1rK4TelU0qV1ZOkB3G487b5EbCdYNezO+NSUl6SdpkRac87Zp
         pBg52h6CzlrTu0eAx0bcKx85AiUU6yqjsQJmAlUGmheEICyuvQTfwIZaGxOgOEZdwRWc
         Vc97Wu54wkU3KNumaFEeBJqwMTjRsYqhgOlSg8lUHAk5P5y3H2MpLrhbTvtHgNQz8mgS
         ZIznqhsKWPDaITcQqrYdk6k6zUdVCDpK61O/36r5pw9A/eoCgUqhWyLfYXFN9hbABJ+v
         83fVqxobxgw3O3CFYAhdV/ELm64zzWec74+x1Ciet2jDQ7G2h/nd1umAMDj7Y7GtPHdL
         uzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713783253; x=1714388053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1N7C9y6FANsDWlj/dSgm/X0vOo9KMVHsfxdkeCTUls=;
        b=IWkMDBxceRIW6bgrWpawO+5Gwxp7UMfBrkrkhcXzGEjsrVF/NcYVIDSkO9XKDTb6NW
         EqWka6Yd0vuRj6ymSvU5Yicu9JcVikD7dPmXbY+WD6+8lTmdCp5lQw9INHpn3G028sJQ
         /vCMyMhzMma5QrIaPeKUcK5CnjtuXD8BYwGTnE7UqWqIj4k/V25+AbR1iXGK1yIsXu3U
         awXFP43qIiqRJIrudbVKXMFXf84BSEyIwMrLE1XMMC7tpa943KxVAxTOPU8cczDTPtl4
         8wAZ29pujubjlGLcz9Z4RVuOKSx7K9ir4IxvWTUuX/FQ+geDcSfWPT++RVxjTpR0t6SJ
         cmhA==
X-Forwarded-Encrypted: i=1; AJvYcCXfvtxckY3n3nVmQX8zJCdnVvX7nPTUTLttjrhb5k25q2BOzjfqI2IfHgodb+EA8kunLfLKFW+KXw7ieAszvzrRmfKwHpfjL/Y=
X-Gm-Message-State: AOJu0YzWVv7MvMy0jh9OSp6aXc/mcUrwWuZ/bvlmgFEIp64jZF+yUEvo
	wGMakFmYnnBn2NojLVgfo/ChVz+HbufM2Oloxof/hGSQrcr6J3TGXtCb2DKJJ8I=
X-Google-Smtp-Source: AGHT+IF6X7R+CnfnuWa+fl+Pf5YiSAINpYi8IL6p/62UKQojmoQFTVGPGQijrRA+F6G+VcEY6bhYXw==
X-Received: by 2002:a05:600c:358b:b0:418:2ab6:7123 with SMTP id p11-20020a05600c358b00b004182ab67123mr6892154wmq.10.1713783252902;
        Mon, 22 Apr 2024 03:54:12 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041a3f700ccesm4321037wmn.40.2024.04.22.03.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:54:12 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 7/8] clk: renesas: r9a08g045: Add support for power domains
Date: Mon, 22 Apr 2024 13:53:54 +0300
Message-Id: <20240422105355.1622177-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Instantiate power domains for the currently enabled IPs of R9A08G045 SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- dropped DEF_REG_CONF() specific to pwrdn functionality
- dropped ddr, tzcddr, oftde_ddr domains as these were there due to
  the pwrdn functionality
- added wdt0 domain; this will not impact currently integrated
  watchdog support
- @Geert: I dropped your previous Rb tag due to the changes in v4

Changes in v3:
- collected tags

Change in v2:
- used DEF_REG_CONF() to describe register offests and bits
- updated MSTOP bitmask for ddr domain
- updated MSTOP config for oftde_ddr
- kept the same description for gic as the CPG_BUS_ACPU_MSTOP register
  documentation in the latest HW manual version is wrong and it will be
  fixed; proper description for GIC is located in "Registers for Module
  Standby Mode" table
- haven't added watchdog domain (was missing in v1, too, by mistake) as
  the watchdog restart handler will fail w/o patch [1]; with this pm domain
  support the watchdog will fail to probe; not sure what is the best
  option until [1] will be integrated

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20240228083253.2640997-10-claudiu.beznea.uj@bp.renesas.com

 drivers/clk/renesas/r9a08g045-cpg.c | 41 +++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index c3e6da2de197..b068733b145f 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -240,6 +240,43 @@ static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A08G045_DMAC_ACLK,
 };
 
+static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
+	/* Keep always-on domain on the first position for proper domains registration. */
+	DEF_PD("always-on",	R9A08G045_PD_ALWAYS_ON,
+				DEF_REG_CONF(0, 0),
+				RZG2L_PD_F_ALWAYS_ON),
+	DEF_PD("gic",		R9A08G045_PD_GIC,
+				DEF_REG_CONF(CPG_BUS_ACPU_MSTOP, BIT(3)),
+				RZG2L_PD_F_ALWAYS_ON),
+	DEF_PD("ia55",		R9A08G045_PD_IA55,
+				DEF_REG_CONF(CPG_BUS_PERI_CPU_MSTOP, BIT(13)),
+				RZG2L_PD_F_ALWAYS_ON),
+	DEF_PD("dmac",		R9A08G045_PD_DMAC,
+				DEF_REG_CONF(CPG_BUS_REG1_MSTOP, GENMASK(3, 0)),
+				RZG2L_PD_F_ALWAYS_ON),
+	DEF_PD("wdt0",		R9A08G045_PD_WDT0,
+				DEF_REG_CONF(CPG_BUS_REG0_MSTOP, BIT(0)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("sdhi0",		R9A08G045_PD_SDHI0,
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(0)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("sdhi1",		R9A08G045_PD_SDHI1,
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(1)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("sdhi2",		R9A08G045_PD_SDHI2,
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(11)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("eth0",		R9A08G045_PD_ETHER0,
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(2)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("eth1",		R9A08G045_PD_ETHER1,
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(3)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("scif0",		R9A08G045_PD_SCIF0,
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(1)),
+				RZG2L_PD_F_NONE),
+};
+
 const struct rzg2l_cpg_info r9a08g045_cpg_info = {
 	/* Core Clocks */
 	.core_clks = r9a08g045_core_clks,
@@ -260,5 +297,9 @@ const struct rzg2l_cpg_info r9a08g045_cpg_info = {
 	.resets = r9a08g045_resets,
 	.num_resets = R9A08G045_VBAT_BRESETN + 1, /* Last reset ID + 1 */
 
+	/* Power domains */
+	.pm_domains = r9a08g045_pm_domains,
+	.num_pm_domains = ARRAY_SIZE(r9a08g045_pm_domains),
+
 	.has_clk_mon_regs = true,
 };
-- 
2.39.2


