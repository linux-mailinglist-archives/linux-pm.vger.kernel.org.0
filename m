Return-Path: <linux-pm+bounces-12886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAB495F4F9
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 17:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4351B21BD2
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51535194A45;
	Mon, 26 Aug 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PlFzkV35"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C41940A1
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724685947; cv=none; b=lfQJ7M8xc3OYc3SqCn7/D9erDMenczlzJwLOKCLd6WIlcNjQbU71mKD00Vs41qNvyghVBzVAY2z6uz5/oNmpU8eoFoCkK1fIMv/0SHdi5O+n69+DGlqBsPr8Mkw23IHoOB9ZXAwKYMZa7JFbgYxJZfRcz6eTUA6laP+GUXxuciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724685947; c=relaxed/simple;
	bh=rsZuUfNZcs9lg0rPx9CSZBgjL9st+fLll+W4cyWgdkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSPGTOVpkdTSuSKOLovV1yITlRf+MTk58LN/56uK/+ik9K5qTg0MxKARHB58ww9WPAAMBsag1ZWuA9ldEZhO4jLFp3SQ0PrYbHBlF8hOkMDr3xQc2Ez1ratfVcXdmuYUC1RuCCySU36nQ7o2M/CyqIna8qVAdbnGGJYV+a60K3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PlFzkV35; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a86883231b4so572167366b.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 08:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724685943; x=1725290743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKZW1L3bK8VtJFD4UHbqlhoKQbHeYiPWb3w9DhKsGU8=;
        b=PlFzkV35kguZ4oZgO4JXg7bbAGyYF94UoEdRWOILc0frP96aSzjnuER6cIljU9JzZH
         JCFn5wMJps3c4Rnkho6R7goLyC6ozBKHPvEghuXR0rd3X1SO8XKBYl78aQWCzIkY+l1+
         eqd5B1bkwS8GCyg5X8MwXYp+MZzPd7wFC4UbIBYrGheIkdN9Ig9/JECYsS3LtAXAUmF8
         bxGUt61r/2nRTzRTpjAzXaRlu2Fwzyo59IKXByOfVeLINe5TaUSLNCbTYeNn0UyGSS/8
         Wjzv62muWDCI7NHApqCtOs2RqGxteT1K/bXHrtfa/uvrpCL0DrlevcwZhjZI4jOcdxC5
         /vnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724685943; x=1725290743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKZW1L3bK8VtJFD4UHbqlhoKQbHeYiPWb3w9DhKsGU8=;
        b=crd/yoiz5s119DWW7ebp4ThQjswPOurXjDtOH7fH7rilzjibGwOZVm2SE2Ymf6XjjL
         1naHS8sTzb84WNad/ji5b7fRYLXVuRkrOHlMvyKguU58XkeZmoFRcf4NZ7aynczPJfNl
         TaCv/h7u2V8U62/Gv9gKJwh4fkRbB45UJIjLl/W0amIfnz2RwhdJqPrV0LHpo8bgV2Xg
         o32U3W32Ut74ao74bQYjb2RGbLghsT64ww73BZ+bNTjDqF7Ru+GVG5udX78u5mM71plB
         N7r7KTkMVe8X+2diYRD+koWXwwJZq3BaX5uJ5CphBCzOLc07E3lpqFMeu95Yd7dnVjSC
         7QWg==
X-Forwarded-Encrypted: i=1; AJvYcCWMzcfTmHxicdJbeISlHvRIJeO798R04UmoXmM+MFrKKU1HP4NN4TAHhVVCqc+gwfKADNP/JWVHmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB4t80pTRkYtQb3ZgHkCfeZ2Mwkt0IZQ9XVW2V5lx2I8f9wTvP
	1UbwhK0RdAGTfKmVfzfZytT5ahIhh3OtnVdf92iZb5dLdQGpYPui9g6QODGY3CA=
X-Google-Smtp-Source: AGHT+IHwcvV+iRgWb/1qPSucDkWuaWbymy91bdnFpsjuT+IA2I+XKOr0Sq6pyEAf+2DomRgdSdho8Q==
X-Received: by 2002:a17:907:c27:b0:a86:8166:1b0a with SMTP id a640c23a62f3a-a86a54efbeamr802439266b.56.1724685942736;
        Mon, 26 Aug 2024 08:25:42 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f437d5fsm683005866b.99.2024.08.26.08.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 08:25:42 -0700 (PDT)
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
Subject: [PATCH 2/3] clk: renesas: rzg2l-cpg: Mark watchdog and always-on PM domains as IRQ safe
Date: Mon, 26 Aug 2024 18:25:28 +0300
Message-Id: <20240826152529.2080248-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826152529.2080248-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240826152529.2080248-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

If the watchdog is part of a dedicated power domain (as it may be on
RZ/G3S) the watchdog PM domain need to be powered on in the watchdog
restart handler. Currently, only the clocks are enabled in the watchdog
restart handler. To be able to also power on the PM domain we need to
call pm_runtime_resume_and_get() on the watchdog restart handler, mark
the watchdog device as IRQ safe and register the watchdog PM domain
with GENPD_FLAG_IRQ_SAFE.

Register watchdog PM domain as IRQ safe. Along with it the always-on
PM domain (parent of the watchdog domain) was marked as IRQ safe.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index ec0672651fe0..8e4f17c21dd7 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -259,7 +259,7 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 	/* Keep always-on domain on the first position for proper domains registration. */
 	DEF_PD("always-on",	R9A08G045_PD_ALWAYS_ON,
 				DEF_REG_CONF(0, 0),
-				GENPD_FLAG_ALWAYS_ON),
+				GENPD_FLAG_ALWAYS_ON | GENPD_FLAG_IRQ_SAFE),
 	DEF_PD("gic",		R9A08G045_PD_GIC,
 				DEF_REG_CONF(CPG_BUS_ACPU_MSTOP, BIT(3)),
 				GENPD_FLAG_ALWAYS_ON),
@@ -270,7 +270,8 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 				DEF_REG_CONF(CPG_BUS_REG1_MSTOP, GENMASK(3, 0)),
 				GENPD_FLAG_ALWAYS_ON),
 	DEF_PD("wdt0",		R9A08G045_PD_WDT0,
-				DEF_REG_CONF(CPG_BUS_REG0_MSTOP, BIT(0)), 0),
+				DEF_REG_CONF(CPG_BUS_REG0_MSTOP, BIT(0)),
+				GENPD_FLAG_IRQ_SAFE),
 	DEF_PD("sdhi0",		R9A08G045_PD_SDHI0,
 				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(0)), 0),
 	DEF_PD("sdhi1",		R9A08G045_PD_SDHI1,
-- 
2.39.2


