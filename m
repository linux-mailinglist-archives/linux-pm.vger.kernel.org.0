Return-Path: <linux-pm+bounces-9566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47FF90EA7A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4782D2817B7
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 12:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1297C1422C5;
	Wed, 19 Jun 2024 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="b96uwaDA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351F613F439
	for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798990; cv=none; b=sJyKDr0F0DjMpBDq6k4o8fOmjrai6TUPAP0rNmOlv/uoqBpAuE1l7WLzJXFtiSf6b1hgO3b48JpP/enSBuhpRwni4JLF2qi/7sVKB9KoO7xpOjbPHPIzTMOQTi0D8YrFhb1GmVvj5R7dora1km2tvCMXRGO/ikshPAPvXNCZf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798990; c=relaxed/simple;
	bh=dwRL4BzskUTNnkpIMgL22DLU9dpDbS12/wL0pywWeXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZV4Jt/t0biPY1xhu6gew3LtMKU3PFAJQ7N487tZLiIvE0wUDzJb8X99f3PhdvG8BoRJEjTlflE48ST4tfqe1Xj+WW8t0X8i1GfXIg8ywmgfVkkt9C5uDot9yrqc44itnlw6aufcbd/bnqHADb9VeL5d2rzZmcS2DzFNx5Y0Qi5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=b96uwaDA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f8ebbd268so139079466b.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718798986; x=1719403786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l37Xgsbrk/W/CaUfhlMyXOo5T2v0G6wEI2diCQGNTyY=;
        b=b96uwaDA9a1Qc/tVcKSVREL724fYS7Cp6PUW5QB2776XazuQc+Ys6jqLoKhyS0gnzh
         FTWLnI7lP8E/CQvHWEzoT+/9Ognl0zEbQJyC1jTIWzYaP8kwOouKul2HzgzHpjAYZjRF
         pa5MeY+LpgRkQx/MFju2DAq3sM+ezmoPp85AO8iHdv6OgTuHItjrcyDbIf4cOtmAQc6R
         AOuWWSbiGNYjTdQvtafG6WRzPFnt58TYfwVPN4dpAWoFe6TiY2ZiKFkcVycCUAp2lbPQ
         M3cepOB5wJmq5jffD2RlxqM3sDZ6PxfFvdy9KlEqjVSAdwM866gJ/cZHnoaPBBkDDHig
         aNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798986; x=1719403786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l37Xgsbrk/W/CaUfhlMyXOo5T2v0G6wEI2diCQGNTyY=;
        b=TjgQLXLlfCZxz3JUWwVZuJEBBO9Ju+UEQrv39gt6x251od/RCFj2JdoCUsGQ21PT2h
         z48B0EGlFzn8A4Fnx9QSMdl8PC96HT4lG0Tw5SVDhVoDLisKhL1PtK47QV3WtSmiPoO+
         75JrW0mxqEF8KL2Hh4QaOQwyR5tx+6NfeLf57VoTM8gFTEz9BbIAKUq5UBqvgmlbJYLI
         Of6spaJhjMvnZkvF3639WpdxvKBvg3+k7CN4fzoRRFsliIha4GPcqOgBDWjRQPE2Fk3Y
         or4xfMljFnhoseBk8J5zWSa9ClR0yqjUGMrpicfu87mqGzo7AJ2PlRf5sICnveokhL+o
         UZRQ==
X-Gm-Message-State: AOJu0YwjUuSkC5E/D9Mu0VWwvLLPFXR1vzR/yJr946trIsuaxfaL+bTx
	i+7sOpEhLOqmw0GkRnGWj8yyIF27o0esuoOfk0WH1MQS/Len/srEikAXnDwSp0M=
X-Google-Smtp-Source: AGHT+IE7mmdZtzwF3jv3n7R6o+Q3QczWuCZ6SkHDb6bjWUSTkUbSSYTk1wTyLPZI29mLO3zORsFkUw==
X-Received: by 2002:a17:906:80cb:b0:a6f:6f98:e3dc with SMTP id a640c23a62f3a-a6f94e1f5c9mr321104066b.10.1718798986592;
        Wed, 19 Jun 2024 05:09:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da43fbsm659014066b.39.2024.06.19.05.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:09:46 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: ulf.hansson@linaro.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	geert+renesas@glider.be,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH RFC 2/3] watchdog: rzg2l_wdt: Keep the clocks prepared
Date: Wed, 19 Jun 2024 15:09:19 +0300
Message-Id: <20240619120920.2703605-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240619120920.2703605-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240619120920.2703605-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The watchdog restart handler is called with interrupts disabled. In
rzg2l_wdt_restart() we call clk_prepare_enable() to enable the watchdog
clocks. The prepare part of clk_prepare_enable() may sleep. Sleep in
atomic context should not happen. The clock drivers for all the
micro-architectures where the RZ/G2L watchdog driver is used are not
implementing struct clk_ops::prepare(). Even so, to be sure we are
not hitted by this at some point, keep the watchdog clocks prepared
and only enable them in restart handler. It is guaranteed that
clk_enable() can be called in atomic context.

Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
Closes: https://lore.kernel.org/all/CAPDyKFq1+cL1M9qGY0P58ETHUZHGymxQL0w92emUJPMe7a_GxA@mail.gmail.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 2a35f890a288..6e3d7512f38c 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -166,8 +166,8 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 	int ret;
 
-	clk_prepare_enable(priv->pclk);
-	clk_prepare_enable(priv->osc_clk);
+	clk_enable(priv->pclk);
+	clk_enable(priv->osc_clk);
 
 	if (priv->devtype == WDT_RZG2L) {
 		ret = reset_control_deassert(priv->rstc);
@@ -226,11 +226,28 @@ static const struct watchdog_ops rzg2l_wdt_ops = {
 	.restart = rzg2l_wdt_restart,
 };
 
+static int rzg2l_clks_prepare(struct rzg2l_wdt_priv *priv)
+{
+	int ret;
+
+	ret = clk_prepare(priv->pclk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare(priv->osc_clk);
+	if (ret)
+		clk_unprepare(priv->pclk);
+
+	return ret;
+}
+
 static void rzg2l_wdt_pm_disable(void *data)
 {
-	struct watchdog_device *wdev = data;
+	struct rzg2l_wdt_priv *priv = data;
 
-	pm_runtime_disable(wdev->parent);
+	pm_runtime_disable(priv->wdev.parent);
+	clk_unprepare(priv->osc_clk);
+	clk_unprepare(priv->pclk);
 }
 
 static int rzg2l_wdt_probe(struct platform_device *pdev)
@@ -275,6 +292,10 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 
 	priv->devtype = (uintptr_t)of_device_get_match_data(dev);
 
+	ret = rzg2l_clks_prepare(priv);
+	if (ret)
+		return ret;
+
 	pm_runtime_enable(&pdev->dev);
 
 	priv->wdev.info = &rzg2l_wdt_ident;
@@ -287,7 +308,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(&priv->wdev, priv);
 	dev_set_drvdata(dev, priv);
-	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
+	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv);
 	if (ret)
 		return ret;
 
-- 
2.39.2


