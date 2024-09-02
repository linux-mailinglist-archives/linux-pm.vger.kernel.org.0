Return-Path: <linux-pm+bounces-13353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEC89688B5
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 15:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B456B235BC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 13:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E913A20FAB7;
	Mon,  2 Sep 2024 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gk6EXikm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0222220FA83
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283461; cv=none; b=rs57Mw8YqCCVHYZy/XznSiS1vq6q755WjAqYAPFOp8HzU/i8WM9dofoO1CW0wAb0vDzmRD/NnEJC5mtsRtRjsbVg4RvdP2tUcQw1DMXgSbtANat0Bhtcr5k/mD8Qv5ZO4Ub2Da43t2GFqdzeky6MGXpyKjcw0k79CjVcxB+yL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283461; c=relaxed/simple;
	bh=lHNKClRL76wkGOAMIs/5mA/cdiGL+E9FB9pCRWp40y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C0/czfvwXMRvKoxiAyPV6YeCeQWK1Yc4nmrKKQR/LQCJcPVGYSo559rW+77WqYhVlwnroGdv0hPwHZflIfnBt4WWX40wxXqWs2ZBJu4Uon9J8bsR2qRyA+2H69S1HP1BrN9pgN8Jx6KTDbkoXcifdMBDgeUBWNtAgDyzUI5nuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gk6EXikm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a80eab3945eso380698066b.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725283458; x=1725888258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2S93e3D6sE+HoZwuX+DGxdxwS+ZCu3pNSafKqNM9e50=;
        b=gk6EXikm7h4ymGxXkd9BiLO12JVDRb2NMsfZT+PkaMuSz3JegW71YtO7Lb1zrJlykQ
         +HYWKEWQctCXoQX6KjNW2vaLcH3k8BZyvmKykkkUGIOXzN2qXz6P0wWc9cJWS7fxYYbW
         +NhZrtDjZexutcS3+tM5UJmK4ISID5IGsxQXyZp/u5EMQ0G4t8DMSj/6T6Ab07iDHnOw
         UrAgqudPYRLYPVQ+zVoLyNSgU+6+EH/YXNA2Mp6eAxRwv4iYD5FGwpXoKYAlTJac5zmc
         pJ3bm6us850AFejfJMiQred3Jm2Lr2Yyr8oP4v4cCGZUr+jJx07NbfUv5vXQf13pbx82
         ZcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725283458; x=1725888258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2S93e3D6sE+HoZwuX+DGxdxwS+ZCu3pNSafKqNM9e50=;
        b=uEqeKR93Sl6vj4BQFE8vdyDagSnexv8U/jCwHVODz9m92WpNYXag9CVVss7UpF3AGc
         witN1J2dYkolvtPcuRgRQQPtZBrA8lzo7KVUes7IxdM4o+KHyFR4z33UjKDDNdGWHrAC
         xB20wbgqTPGN1msUU6D15ooVJt7fPBaLTKghT5c2s9FYcd/gUM5cyClnFOjAUIODLviL
         gFYgOSk0jAEbf8hq6KgVaLeh77VlHuQC3wnW0R+UXzfIN4qoi4vLjDH/dd/Uy7irOFo0
         qziuArk929wbF6d+jxhISmO62yFd0irZSad3JBA1rdjY9xsDKx7M/znFvcUT/+a/IEa6
         tYrw==
X-Forwarded-Encrypted: i=1; AJvYcCX7yJyxGkhejErn62/4mEbqSoXqDQ60kFrLEC3N9XqFIFEXcIGu/v3LK2wvdYjSOqx5kPv0MGLcWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1HVzvSrm80UQ4CgbwAEC4SBGzheH7xEwEWaVhmQ9WTMWaRYvQ
	gZFqiriV/vu0hfoPGs5H1BqaR/8NqiNxTvUB6jw6GnDY0HsjtB8aTlPbeeXzmpc=
X-Google-Smtp-Source: AGHT+IHp5kdh3fuj7ZPvDBthqLxRNlyWnUZOuUAQff7VBvxTNz/SMc/AWSuITFLaJj/5JJ5YN918Xw==
X-Received: by 2002:a17:907:9407:b0:a86:96b3:86be with SMTP id a640c23a62f3a-a89a3826268mr627793166b.63.1725283458009;
        Mon, 02 Sep 2024 06:24:18 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f6e0sm556060266b.77.2024.09.02.06.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:24:17 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	ulf.hansson@linaro.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	linux-pm@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 2/4] clk: renesas: rzg2l-cpg: Use GENPD_FLAG_* flags instead of local ones
Date: Mon,  2 Sep 2024 16:24:00 +0300
Message-Id: <20240902132402.2628900-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240902132402.2628900-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240902132402.2628900-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

For watchdog PM domain it is necessary to provide GENPD_FLAG_IRQ_SAFE flag
to be able to power on the watchdog PM domain from atomic context. For
this, adjust the current infrastructure to be able to provide GENPD_FLAG_*
for individual PM domains.

With this, remove the always_on flag from rzg2l_cpg_add_pm_domains() as
it is not necessary anymore.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- update patch description
- diff in rzg2l_cpg_add_pm_domains() is now simplified as a result
  of adding patch 01/04 from this series

Changes in v2:
- none

Changes since RFC:
- none; this patch is new

 drivers/clk/renesas/r9a08g045-cpg.c | 44 +++++++++++------------------
 drivers/clk/renesas/rzg2l-cpg.c     |  4 +--
 drivers/clk/renesas/rzg2l-cpg.h     | 10 ++-----
 3 files changed, 21 insertions(+), 37 deletions(-)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 213499fc8fb5..ec0672651fe0 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/pm_domain.h>
 
 #include <dt-bindings/clock/r9a08g045-cpg.h>
 
@@ -258,52 +259,41 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 	/* Keep always-on domain on the first position for proper domains registration. */
 	DEF_PD("always-on",	R9A08G045_PD_ALWAYS_ON,
 				DEF_REG_CONF(0, 0),
-				RZG2L_PD_F_ALWAYS_ON),
+				GENPD_FLAG_ALWAYS_ON),
 	DEF_PD("gic",		R9A08G045_PD_GIC,
 				DEF_REG_CONF(CPG_BUS_ACPU_MSTOP, BIT(3)),
-				RZG2L_PD_F_ALWAYS_ON),
+				GENPD_FLAG_ALWAYS_ON),
 	DEF_PD("ia55",		R9A08G045_PD_IA55,
 				DEF_REG_CONF(CPG_BUS_PERI_CPU_MSTOP, BIT(13)),
-				RZG2L_PD_F_ALWAYS_ON),
+				GENPD_FLAG_ALWAYS_ON),
 	DEF_PD("dmac",		R9A08G045_PD_DMAC,
 				DEF_REG_CONF(CPG_BUS_REG1_MSTOP, GENMASK(3, 0)),
-				RZG2L_PD_F_ALWAYS_ON),
+				GENPD_FLAG_ALWAYS_ON),
 	DEF_PD("wdt0",		R9A08G045_PD_WDT0,
-				DEF_REG_CONF(CPG_BUS_REG0_MSTOP, BIT(0)),
-				RZG2L_PD_F_NONE),
+				DEF_REG_CONF(CPG_BUS_REG0_MSTOP, BIT(0)), 0),
 	DEF_PD("sdhi0",		R9A08G045_PD_SDHI0,
-				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(0)),
-				RZG2L_PD_F_NONE),
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(0)), 0),
 	DEF_PD("sdhi1",		R9A08G045_PD_SDHI1,
-				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(1)),
-				RZG2L_PD_F_NONE),
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(1)), 0),
 	DEF_PD("sdhi2",		R9A08G045_PD_SDHI2,
-				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(11)),
-				RZG2L_PD_F_NONE),
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(11)), 0),
 	DEF_PD("eth0",		R9A08G045_PD_ETHER0,
-				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(2)),
-				RZG2L_PD_F_NONE),
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(2)), 0),
 	DEF_PD("eth1",		R9A08G045_PD_ETHER1,
-				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(3)),
-				RZG2L_PD_F_NONE),
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(3)), 0),
 	DEF_PD("i2c0",		R9A08G045_PD_I2C0,
-				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(10)),
-				RZG2L_PD_F_NONE),
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(10)), 0),
 	DEF_PD("i2c1",		R9A08G045_PD_I2C1,
-				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(11)),
-				RZG2L_PD_F_NONE),
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(11)), 0),
 	DEF_PD("i2c2",		R9A08G045_PD_I2C2,
-				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(12)),
-				RZG2L_PD_F_NONE),
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(12)), 0),
 	DEF_PD("i2c3",		R9A08G045_PD_I2C3,
-				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(13)),
-				RZG2L_PD_F_NONE),
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(13)), 0),
 	DEF_PD("scif0",		R9A08G045_PD_SCIF0,
-				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(1)),
-				RZG2L_PD_F_NONE),
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(1)), 0),
 	DEF_PD("vbat",		R9A08G045_PD_VBAT,
 				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(8)),
-				RZG2L_PD_F_ALWAYS_ON),
+				GENPD_FLAG_ALWAYS_ON),
 };
 
 const struct rzg2l_cpg_info r9a08g045_cpg_info = {
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 51ee1b063d9f..de563f0e1879 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1781,7 +1781,6 @@ static int __init rzg2l_cpg_add_pm_domains(struct rzg2l_cpg_priv *priv)
 		return ret;
 
 	for (unsigned int i = 0; i < info->num_pm_domains; i++) {
-		bool always_on = !!(info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON);
 		struct rzg2l_cpg_pd *pd;
 
 		pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
@@ -1789,8 +1788,7 @@ static int __init rzg2l_cpg_add_pm_domains(struct rzg2l_cpg_priv *priv)
 			return -ENOMEM;
 
 		pd->genpd.name = info->pm_domains[i].name;
-		if (always_on)
-			pd->genpd.flags = GENPD_FLAG_ALWAYS_ON;
+		pd->genpd.flags = info->pm_domains[i].genpd_flags;
 		pd->conf = info->pm_domains[i].conf;
 		pd->id = info->pm_domains[i].id;
 		pd->priv = priv;
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index ecfe7e7ea8a1..881a89b5a710 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -270,14 +270,14 @@ struct rzg2l_cpg_pm_domain_conf {
  * struct rzg2l_cpg_pm_domain_init_data - PM domain init data
  * @name: PM domain name
  * @conf: PM domain configuration
- * @flags: RZG2L PM domain flags (see RZG2L_PD_F_*)
+ * @genpd_flags: genpd flags (see GENPD_FLAG_*)
  * @id: PM domain ID (similar to the ones defined in
  *      include/dt-bindings/clock/<soc-id>-cpg.h)
  */
 struct rzg2l_cpg_pm_domain_init_data {
 	const char * const name;
 	struct rzg2l_cpg_pm_domain_conf conf;
-	u32 flags;
+	u32 genpd_flags;
 	u16 id;
 };
 
@@ -288,13 +288,9 @@ struct rzg2l_cpg_pm_domain_init_data {
 		.conf = { \
 			.mstop = (_mstop_conf), \
 		}, \
-		.flags = (_flags), \
+		.genpd_flags = (_flags), \
 	}
 
-/* Power domain flags. */
-#define RZG2L_PD_F_ALWAYS_ON	BIT(0)
-#define RZG2L_PD_F_NONE		(0)
-
 /**
  * struct rzg2l_cpg_info - SoC-specific CPG Description
  *
-- 
2.39.2


