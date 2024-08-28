Return-Path: <linux-pm+bounces-13037-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E90679629BE
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 16:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58DFDB20DB9
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 14:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069BC18990E;
	Wed, 28 Aug 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jF915vFZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E0A1891D1
	for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853979; cv=none; b=N/F0eZUxYZOo9J9v4asWwNDhuMSys7uj+r0GWNrMzPU7MHStU8kjgQc7w4caPeYd4Jph29ns4jArAjUsq7mZySu9ftS3bWJIzaRa/8F41X68bE7J3wkFOXEFQ6DJay/gp9TkTrlwoowwUmqNg7FZ/t7+NASyO3WH09oubCRcDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853979; c=relaxed/simple;
	bh=WXRDucFwWgrqCe2X9Vw05SOOzPz+LbLVU345258jUyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oj4UVmiNKlwc+GT0z/qvjbs5ElWtpPazimlgyUJBeT7TWAG5enzR+a59rwKOsI/VTbDkwFEm9Ni2/8C2+4qNm6u619gue9tzJUWw+P8VfG3ljdZekTS/YnF++I9VYh00M9MN2KhiD23rP8q6zL379RZqYPtgwRajKaBMuGZVQGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jF915vFZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8684c31c60so814395866b.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 07:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724853976; x=1725458776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JH+0rKKNeAzSSsvzJe0OPzXMrvikOdUwZWhrwYXhhuk=;
        b=jF915vFZhGEFYTh5G4MCi9mwmZYvZGFq8ji/N3vrXBs9b55+ucbuUqagEv4BwfDY+z
         Jw1VgClBC/n5mbMDbtRy+Y5W9K8IZtlquk6vZoQ+tbI8aFDHhdZvnuilIYMKN/+xlUI7
         qCVcYq4+jVPR5myI3K4VSmD34Lzih6T9AKWKT8cXQPU1bkBwlY2zxm09F6IxlsEGbYbu
         MdJ7jZN5EMoJ7XZAlpHve+NWxqDldUqgY4n8sozEdJKXaf3oz6wDUN0pRBEbTZwJA+T2
         RCKvITvPDrW6sCMesm4UMIV56l/lAkohi+WldWsSuOp1gXrGxtW73inwnY25Ycq/SUmS
         UBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724853976; x=1725458776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JH+0rKKNeAzSSsvzJe0OPzXMrvikOdUwZWhrwYXhhuk=;
        b=b0xjeJ23dpdSQ7SzgkrqMMEC9j+pehZ6rsEh+So/NClyQjb+AkGFmOXGCvm1Xyt0j5
         nX1f96xw+tmrLpW7rutzcYpCQiePxxLLOpp8dMyO0WrW1iSgR6TXnZ/AUKElfWp2z6Ez
         VTgp9aRzUUCA+HFuwqRh8QitrKdjJmhqg6TYJO1KqU4AVq22H42b/RkJ3dCmGMChtFPq
         ahpxtPFA/4GV2grP7xtk9Qq7V93G6WMHzSIxvPmsRV5xJZ+prF3rbYhlMoFfO5pNF9qF
         web2e0tDxehtMYhBJ66eun832khcSvAO7nOq0PFjHnpKrvRvNbRbOf3u+lBxCxSwLne2
         Z5Og==
X-Forwarded-Encrypted: i=1; AJvYcCUS5wxEFq03yO5+9RoxTXSMslj93IOOlEQH6eG83v0fMuyWPlj3iWkFOO901H9QB4KezigA0ppnWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxA98xb4X9VvH4t+onb3GBNtAnAsKp/VNsIgiYeZs5SFYyRmzi
	Wcc9Tg8nvPl9ZpXT7zMD+wbyqk+FuRSMAH+MHUBSdpw3XevhxIYrTH5Z8gRLR6w=
X-Google-Smtp-Source: AGHT+IHlWBeTkge0xQBvJR9MDo6Rf5utLGRpETG/17yxAHBD3F77IkaQZ24hm6/XM2V8DroX/uFR2g==
X-Received: by 2002:a17:907:709:b0:a86:8165:1802 with SMTP id a640c23a62f3a-a86a54be149mr1380836166b.66.1724853975992;
        Wed, 28 Aug 2024 07:06:15 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e54b50dbsm251875666b.93.2024.08.28.07.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:06:15 -0700 (PDT)
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
Subject: [PATCH v2 2/3] clk: renesas: r9a08g045: Mark the watchdog and always-on PM domains as IRQ safe
Date: Wed, 28 Aug 2024 17:06:01 +0300
Message-Id: <20240828140602.1006438-3-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v2:
- changed patch title; it was "clk: renesas: rzg2l-cpg: Mark
  watchdog and always-on PM domains as IRQ safe"

Changes since RFC:
- none; this patch is new

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


