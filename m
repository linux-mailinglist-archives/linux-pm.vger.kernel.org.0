Return-Path: <linux-pm+bounces-12863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A25E95E3F0
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 16:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90171F2156F
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28087158873;
	Sun, 25 Aug 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SgoVhZr0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF913D518
	for <linux-pm@vger.kernel.org>; Sun, 25 Aug 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724596476; cv=none; b=qkaxGfuLVNe5lwkiK9xZPbFDvw2dx3jhD3l0ULx0LUktCxc8i46eWGpFCaJAJwsYYc02pB2aotv18at3Pz19xi4XWCgN5Kn51LVSqtc2Kp76DCZgGvSXh2+uefXyV6mHNguX17A/fqDhLhkhKl4EJAXilNChk5QhL1HbStCxagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724596476; c=relaxed/simple;
	bh=FJAYltTw/vKUew7y1T5RlL01/wrW5nRptSnGTB1MgLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhkpbDpKdgn8pTE7wNJZV2Y61s50SAjqhE4pEJU/UKiRd31GDdv2PHTvHwWD/AVI7ixXoem0n+owyy7LoebqHszYjUggjIgHX2vw13FjEFaKV4bSIgrgrhy0TKX1gzF5W6nTc1D8OH4fw58gJ/KO9zhciXmTu3enEiAJVJZTtvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=SgoVhZr0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86859e2fc0so411072466b.3
        for <linux-pm@vger.kernel.org>; Sun, 25 Aug 2024 07:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1724596473; x=1725201273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/+WxYlkSCaxJVD+lANibTyIufP0s0obescAo/C5LRY=;
        b=SgoVhZr0EfLB0dI24M6+tf+w4vfTFS7vF8UZeExAOY9kjQgsuSvNpULQRkzxBjl+MB
         shbsoMjYu2EVWee8BZePEtQCbvWCC7wv8FgszCDOwODS9f5+lMSW01gQAP6Hy158+zoL
         ZL6hSnBZsthH9BOWHwHdP83/736LXMrbTOaIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724596473; x=1725201273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/+WxYlkSCaxJVD+lANibTyIufP0s0obescAo/C5LRY=;
        b=W7rrZC3AiYj00V+vi4F5Nw11QWgONPdo8e4qg20MjDEf3xOQQ9zPIXZ6VScmtZeo9B
         hSlo9dfXEKbJbV4zbWZF3qAhqPLYPZVuA2bmrBcQOPMYQvsdhix71Ox9yVdFrETk4kBF
         Xrwb/WkNBELrWdXDWZMumHBmzuPp81SmCF/XDdmxTNgvKmGIWMCCaBPYv4VEPpklFiPL
         vXyGoT9HEkl28pICUTvuIRzSkudIfD3a3lxRop1BKTE8AGlR2UrVGYU/hTzfRbMpXz8I
         AN9HduJaTSr2g2t04eo7JhKCSj+Gtl3wyw2CIFe2SJPrOpKaSs1yPSHSSLjgQXyo/THY
         qBcw==
X-Forwarded-Encrypted: i=1; AJvYcCWrup25RRpbMgKtTcnS4IP8nSRqW+RN0iH5/2WP9z5pEpBvNnCjXszBvEBIbiu+QAAZMfmBsNFGMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLL73aiz3ZKWB8aAwUhWA0ppMFFNYHRaKowWIh0pQX7wijZor
	QxBuL9IIogfPru9XOEOegz7HWtT43an/c079t1kX/3tl1Do4pfHnxDF45hVZcd0=
X-Google-Smtp-Source: AGHT+IFIxJEDmnRdmJ2yfEJLKXiwKOFoIxfU32uGKJOfRx3/E1xOLH6e41n99MLu4zc4j3as810TWA==
X-Received: by 2002:a17:907:9626:b0:a86:899d:6459 with SMTP id a640c23a62f3a-a86a53017a9mr610711266b.38.1724596472420;
        Sun, 25 Aug 2024 07:34:32 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-25-99-149.retail.telecomitalia.it. [79.25.99.149])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4862b6sm550625566b.170.2024.08.25.07.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 07:34:32 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 2/3] pmdomain: imx93-pd: don't unprepare clocks on driver remove
Date: Sun, 25 Aug 2024 16:34:01 +0200
Message-ID: <20240825143428.556439-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240825143428.556439-1-dario.binacchi@amarulasolutions.com>
References: <20240825143428.556439-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The removed code was added to handle the case where the power domain is
already on during the driver's probing. In this use case, the "is_off"
parameter is passed as false to pm_genpd_init() to inform it not to call
the power_on() callback, as it's unnecessary to perform the hardware
power-on procedure since the power domain is already on. Therefore, with
the call to clk_bulk_prepare_enable() by probe(), the system is in the
same operational state as when "is_off" is passed as true after the
power_on() callback execution:

 probe() -> is_off == true  -> clk_bulk_prepare_enable() called by power_on()
 probe() -> is_off == false -> clk_bulk_prepare_enable() called by probe()

Reaching the same logical and operational state, it follows that upon
driver removal, there is no need to perform different actions depending
on the power domain's on/off state during probing.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/pmdomain/imx/imx93-pd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
index 44daecbe5cc3..fb53a8e359bc 100644
--- a/drivers/pmdomain/imx/imx93-pd.c
+++ b/drivers/pmdomain/imx/imx93-pd.c
@@ -90,9 +90,6 @@ static void imx93_pd_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 
-	if (!domain->init_off)
-		clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
-
 	of_genpd_del_provider(np);
 	pm_genpd_remove(&domain->genpd);
 }
-- 
2.43.0


