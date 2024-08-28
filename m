Return-Path: <linux-pm+bounces-13038-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4383C9629BF
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 16:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FBA1C24020
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 14:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C81E189B91;
	Wed, 28 Aug 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gHahkeEy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68656188CBA
	for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853980; cv=none; b=p+AoC5xVmZBcR6fcZ/0v4tw3Q+PlVsiarkTDpumHdCsMNLPOHSDhUpVpUlKK/bWXfcZP2vWDri19x3Wi8b7vOzcboTFO9vyqO05C2OUmnT6VIMmnqvOtjsnuFcfV4qk9rvG76TQszr+NmYrane5Ei4nDs6ogwnjin4NARZN1p0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853980; c=relaxed/simple;
	bh=8VHUL57R0OzzBSjjnOEhhX/D+itTi+aKH9NWr4oG+rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ax150TWvFKIADjRPBg/0DVhx610IO1GweS3Kv4KrUklRxM6MEEcljoyeJs2adxBtYs39pFRsH9FEz92iJNKknq4vgK9Kd8645XkeWRDQ9FHaJoZ17y+MKAWXcoWz/W9ZV3ruNlgC5ynpjrfSgqhBJ4zgYRT3jAcN6nVMWut3KFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gHahkeEy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86b46c4831so531574966b.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 07:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724853975; x=1725458775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xS9W/uziPW5QbMHaGQ7eUl8eCqs5pktusx+WC57dvT0=;
        b=gHahkeEy2OWN6Z/bPMgGv/sOxndVpjZ82a6KrWKVfW50LSbc22KRFTge+yKb2iog2M
         A9v0wzi1dfo3klLXHgeDhZTV66ev5W5zGs8jZvuf2wa9ppuLtMTpreZHHaduCB1lPItx
         YJUaH29EUONf+k70hxEoNN8EzI2Bbmy+aix9sbxN41mveaHMMg5TxRLjf6BbNWalGFX5
         Y/LLmYIPmIJUC9qxEc5vzcc6c8yYcBD1EmSYIitWYfWGgjazM9m5U6L03Rre8zO/DYd1
         CDyIGTY/gLV2uOki3f06X4qTbwbFolyHqO660VqA7cfl9Q/ixv5qcevGj9/hd4g/tFn9
         hNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724853975; x=1725458775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xS9W/uziPW5QbMHaGQ7eUl8eCqs5pktusx+WC57dvT0=;
        b=MGY10NqZNavBQCRd41lhSvnInc28n6LmNu20prGQd+Dgb3u0Tl6/Pg4/RYtHHlNbYl
         YY1gz7K2N6tBa1b5ECsxtNPCa0npyVUdc/GnXUSNakIDUHx2800ZQ6ApRxmeINVyCyYo
         dr4XWS7O12yrt+9KPtI5Ks3gEUBdkhREmMw60Zufe4iOGt/13J3vTom6NIU19nEsJZQ4
         sgyhSJSfrU6/FrzkjvD2lWKBm6uTtDxiC34g0RCm1VU2809qpUA27Aqu72vStM3fEMjp
         ytXGj5VHDpcQvOudmQflo0K8rZj18CRrhH8+dRR1ZpmaTzUDHVVwOfpdIwUoQ/QECF9I
         BB2A==
X-Forwarded-Encrypted: i=1; AJvYcCXEox7XH2uscLdia521jK06vB4DtNwsDjPcNxXRvd+cLJFljykLc7eWBk4XwKei/+TTqS3q/VaBpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHl8oTbj6ncilHZmOYoXAbpaDwLc04x2vj6Z9I7iN1yoZTI4x
	7QTO0nXzK1BjQmlV4+ghrmQ3cpYN6CY3RwqtPX7Mt8zc/etxJl5ulfF+qh6Lhng=
X-Google-Smtp-Source: AGHT+IHwGv5jLhngxX0DU4uSV0hVOXIo5vpPbFbXZ3sADm3GPhfkHLacWXr2lg8q+59SyW9xTx+kpg==
X-Received: by 2002:a17:907:f7a8:b0:a86:8953:e1fe with SMTP id a640c23a62f3a-a86a54d2d4bmr1345488266b.47.1724853974401;
        Wed, 28 Aug 2024 07:06:14 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e54b50dbsm251875666b.93.2024.08.28.07.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:06:14 -0700 (PDT)
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
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 1/3] clk: renesas: rzg2l-cpg: Use GENPD_FLAG_* flags instead of local ones
Date: Wed, 28 Aug 2024 17:06:00 +0300
Message-Id: <20240828140602.1006438-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828140602.1006438-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240828140602.1006438-1-claudiu.beznea.uj@bp.renesas.com>
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

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

Changes since RFC:
- none; this patch is new

 drivers/clk/renesas/r9a08g045-cpg.c | 44 +++++++++++------------------
 drivers/clk/renesas/rzg2l-cpg.c     | 13 +++++----
 drivers/clk/renesas/rzg2l-cpg.h     | 10 ++-----
 3 files changed, 28 insertions(+), 39 deletions(-)

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
index 88bf39e8c79c..b97996e93042 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1680,11 +1680,13 @@ static int rzg2l_cpg_power_off(struct generic_pm_domain *domain)
 	return 0;
 }
 
-static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, bool always_on)
+static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, u32 genpd_flags,
+				     bool always_on)
 {
 	struct dev_power_governor *governor;
 
-	pd->genpd.flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
+	pd->genpd.flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP |
+			   genpd_flags;
 	pd->genpd.attach_dev = rzg2l_cpg_attach_dev;
 	pd->genpd.detach_dev = rzg2l_cpg_detach_dev;
 	if (always_on) {
@@ -1712,7 +1714,7 @@ static int __init rzg2l_cpg_add_clk_domain(struct rzg2l_cpg_priv *priv)
 
 	pd->genpd.name = np->name;
 	pd->priv = priv;
-	ret = rzg2l_cpg_pd_setup(pd, true);
+	ret = rzg2l_cpg_pd_setup(pd, 0, true);
 	if (ret)
 		return ret;
 
@@ -1777,7 +1779,8 @@ static int __init rzg2l_cpg_add_pm_domains(struct rzg2l_cpg_priv *priv)
 		return ret;
 
 	for (unsigned int i = 0; i < info->num_pm_domains; i++) {
-		bool always_on = !!(info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON);
+		u32 genpd_flags = info->pm_domains[i].genpd_flags;
+		bool always_on = !!(genpd_flags & GENPD_FLAG_ALWAYS_ON);
 		struct rzg2l_cpg_pd *pd;
 
 		pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
@@ -1789,7 +1792,7 @@ static int __init rzg2l_cpg_add_pm_domains(struct rzg2l_cpg_priv *priv)
 		pd->id = info->pm_domains[i].id;
 		pd->priv = priv;
 
-		ret = rzg2l_cpg_pd_setup(pd, always_on);
+		ret = rzg2l_cpg_pd_setup(pd, genpd_flags, always_on);
 		if (ret)
 			return ret;
 
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


