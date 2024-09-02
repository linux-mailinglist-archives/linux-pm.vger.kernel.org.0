Return-Path: <linux-pm+bounces-13354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ED49688BA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 15:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607971F22F79
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D6321019B;
	Mon,  2 Sep 2024 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="imwnOHxo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE320FA9D
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283462; cv=none; b=mzCUsg3eurnJyEkMhk6Cfv54u2yqKyq/j6gg1vbo9NRhwJ5m6dvMx3+sckWb/7rzEyaUkYQcs67qvOkJGHhyDNzTWfciKvhFnabIFgXeaNJc98wLggQHuHfzNJwVZsp7FPSneuT+sXHPyQlzwiKOvJF2PMeO9BmRyFEepqwQCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283462; c=relaxed/simple;
	bh=cFBTXdmxf6xkp+y5d2pbAtSSMPoHp78PhBPGeBVQ5Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=udDgh/Stj2Z9Smr3XiJ/i+vumrghKZN1WO9OVQt43B0LiYYKjTtLerb9BSSgfSSKcqjMf33fyQ9TGeeP2axHTFMOl+PoJLrMtMbyhk6Qvj1P+yGJDsAu3HH6tQUXKGfEDrwPJhXrBAauyX8ahvXY2bGtV752J6cPt2aUIVWQf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=imwnOHxo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a86883231b4so510158166b.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725283459; x=1725888259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uH2zrXZ5BzUnaRlSwJAfvqf8QT+KWHn0touYH89ZpM=;
        b=imwnOHxo7+qoTVfc9EsEMOxKCHe5/GlHAwIyyaXsvbUtvMYwcZw4BxLJuGIXTIKkzq
         AvcLudtHLQUrT5UEU6cWep/ujpd0yhM/SSlf34ByA/3JYujUtRY76O3aYB4ARRxxRRHD
         dSPsfYSYwAwDUI2TMrsvnvMKbuvqPp85k8mTIElOS8xMFy1SLBvPhRMayvv260LUFaUc
         lG92Ud8yDWG2xWqt7PrergA9fhqyuwMjiHxvKeQSxujQld5Wn5et5VanUWrEVQzdaduB
         WtsMiiEZanzNXm3oUPdit6iO+tONneVCiakJ42tRyW04sxD162kr2ovlN4OkSeHXo6nk
         HpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725283459; x=1725888259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uH2zrXZ5BzUnaRlSwJAfvqf8QT+KWHn0touYH89ZpM=;
        b=L8D6gMWC2TqNGXA2K4r5v+C4nn8X+0d1HOgZQfZM1eeSXv0x3J7bt7LXP99tSGpwmN
         nbFsLzMK4xlEnlDWlh395uEU/zbnj/mSJCEDBhG2AH5qEaBQXsY/32o/vU/ugMPZsY4J
         mYdLhdL9sDjjZmLpdpTqVdZdxcoaDV/Cuz8e/ljoXAu+RbXoqF3g7lcZ46DwBFhBB7N5
         4BgJTbirUrgk7zZ/JaGdoiwCf0WrcDDsGFU4axn8QYrc5toIEfI3s/R8UMKgf+R59EX4
         1kAaxMoHr1hg6ygH0y4vkrM4cJo8hDj45oBuIkEmVmd1s1uPEvcqWtGFrMn5TAzfA/fT
         Yn7A==
X-Forwarded-Encrypted: i=1; AJvYcCXpqnGD1KpTK5Nyi5bmUdCiLzhsJ9JyxNfZINY4qoHhV445/53lq2mqQcW1IpduTfm9GqsEiLbTgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxerF+a5Hul41ppbbhme+KTIAVTmbzaBgZHiMTB264dv7TbBAYj
	4OA5RMs22FZM9RXfbIXkwTNxM6XK5HeKzwtDbtmg4vognNVHHiS6CINeo4s0MK8=
X-Google-Smtp-Source: AGHT+IG1V9dSAf07DHR62KASs9WSEqeV5d5EQuUr+viWs43Pyc9VUqW1INeHZvgwKTUjEq6tI9M0MQ==
X-Received: by 2002:a17:907:d24:b0:a86:700f:93c0 with SMTP id a640c23a62f3a-a89d879c339mr447058166b.35.1725283459432;
        Mon, 02 Sep 2024 06:24:19 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f6e0sm556060266b.77.2024.09.02.06.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:24:19 -0700 (PDT)
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
Subject: [PATCH v3 3/4] clk: renesas: r9a08g045: Mark the watchdog and always-on PM domains as IRQ safe
Date: Mon,  2 Sep 2024 16:24:01 +0300
Message-Id: <20240902132402.2628900-4-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v3:
- none

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


