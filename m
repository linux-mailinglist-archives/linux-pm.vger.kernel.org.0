Return-Path: <linux-pm+bounces-12864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5034F95E3F2
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 16:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073961F213FC
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 14:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EFF16B385;
	Sun, 25 Aug 2024 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="T41hLwyA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67941155742
	for <linux-pm@vger.kernel.org>; Sun, 25 Aug 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724596477; cv=none; b=ZoTHcteluOmWFOp6qzekWkO8W63BkkGQwHy6fSiJfErDG363RIKlDfQ+/yto2efBFX/Zndvpbi1dh7WURG3O6Nt9bs8ZLy+qFMZ+yeJMQWJpjDSzJlbhj19zqsBe4pvkeD4i7GTEb4bBCJz+qG5MoJcrfiXjhID9mNrz29Rb020=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724596477; c=relaxed/simple;
	bh=0lv2+/R/Y1kEilZQGwotVCHUco7bj6y3rAOycGgHMaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqfLWFP0Uo+ka6Q5dAyDNf3h6qyXkNzgpHVE9gHmxdB1Bdj8eOPvzxJsq9wOhXjV52Lq1tsTDuUWIoj8VjqXjSIphEuXfdIAbeQit6MreO9s8MD7exZifLcIN1HWKRh2yTP8F9t38dJQvOf5qByt4ZzLUcF8/q5MU8OXheU2K60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=T41hLwyA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a86859e2fc0so411073866b.3
        for <linux-pm@vger.kernel.org>; Sun, 25 Aug 2024 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1724596474; x=1725201274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUP1tr1Biob0qdgqQZiV/8XgCxeEAXErXHQFm+tqx4M=;
        b=T41hLwyAvWpX9mKA2U4aP5AqUIknepUthKOTph5no6+2aw7geAuIXdJckSU4Ey3pEr
         gswiX0T2vl9R0AvMoJLsvaTTb8mxl3nGPkyNEzruCuDfom4JCOh9PufcLjJ6bmjrmy3p
         kIn8/rsVmODxqjfYRvDSnAoV6M+5DKd4IPVgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724596474; x=1725201274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUP1tr1Biob0qdgqQZiV/8XgCxeEAXErXHQFm+tqx4M=;
        b=pvhVw4d02jafzArXH4O2vmQ3/406hkqhnj0Bio+HeTzwFg7dTLiXPrJl3yAsk/28xj
         ZCnqH9TGlMp8we8lDH50xykPD3DAykDowqJTF+4sTxg+rMd4AmSGVn9aOpul1hJMo2tz
         xha9pE2XY71+BsEmMZgUrYIrHfyzWwU3QQ9fqNJEFPo9AKB+tj3IYsQ4ClbW1OYItdGN
         9GiGpZ7d+0R3RsG8/srmWKdbP/Vj8MqKL8ma8Qfgf46ebjGfWuhgko8qkhcGj71Zfe8U
         FaIHTt7+UdiKKMZ/yiYXbOmq33CYaGlnwe/jJxQoDv/DUHYQueIKzZ94WvOc0hreJJ3A
         To6w==
X-Forwarded-Encrypted: i=1; AJvYcCW4hOvoR+AnfSKgwjALfO9y2bdl7GtlRrlFbDwjkwiMCLNjQTsdxbGXowtbQiVWJjlt7zzazBJPhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzY3FQdBRAaa3p5IiPxxH4kG85ALQNLgdisyRHU3oFi1v040s5w
	b9mKUcUDOZP5yMG9mHON1JY8DyBHqL7URVqk3RAmEuTC1I1U4QOEUad7QT/7cN4=
X-Google-Smtp-Source: AGHT+IFgNRayDgp4fmiIWVjZ3HTGdr0hITo8YBBn478cm5P7zRV+7T0cFa+54xo2Bary5GIFiosIxA==
X-Received: by 2002:a17:906:c143:b0:a86:8368:860a with SMTP id a640c23a62f3a-a86a53005f6mr518996166b.35.1724596473780;
        Sun, 25 Aug 2024 07:34:33 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-25-99-149.retail.telecomitalia.it. [79.25.99.149])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4862b6sm550625566b.170.2024.08.25.07.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 07:34:33 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jacky Bai <ping.bai@nxp.com>,
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
Subject: [PATCH v2 3/3] pmdomain: imx93-pd: drop the context variable "init_off"
Date: Sun, 25 Aug 2024 16:34:02 +0200
Message-ID: <20240825143428.556439-3-dario.binacchi@amarulasolutions.com>
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

This variable is only used within the probe() function, so let's remove
it from the context and define it locally within the same function.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v1)

 drivers/pmdomain/imx/imx93-pd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
index fb53a8e359bc..25ab592945bd 100644
--- a/drivers/pmdomain/imx/imx93-pd.c
+++ b/drivers/pmdomain/imx/imx93-pd.c
@@ -28,7 +28,6 @@ struct imx93_power_domain {
 	void __iomem *addr;
 	struct clk_bulk_data *clks;
 	int num_clks;
-	bool init_off;
 };
 
 #define to_imx93_pd(_genpd) container_of(_genpd, struct imx93_power_domain, genpd)
@@ -99,6 +98,7 @@ static int imx93_pd_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct imx93_power_domain *domain;
+	bool init_off;
 	int ret;
 
 	domain = devm_kzalloc(dev, sizeof(*domain), GFP_KERNEL);
@@ -118,9 +118,9 @@ static int imx93_pd_probe(struct platform_device *pdev)
 	domain->genpd.power_on = imx93_pd_on;
 	domain->dev = dev;
 
-	domain->init_off = readl(domain->addr + MIX_FUNC_STAT_OFF) & FUNC_STAT_ISO_STAT_MASK;
+	init_off = readl(domain->addr + MIX_FUNC_STAT_OFF) & FUNC_STAT_ISO_STAT_MASK;
 	/* Just to sync the status of hardware */
-	if (!domain->init_off) {
+	if (!init_off) {
 		ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
 		if (ret)
 			return dev_err_probe(domain->dev, ret,
@@ -128,7 +128,7 @@ static int imx93_pd_probe(struct platform_device *pdev)
 					     domain->genpd.name);
 	}
 
-	ret = pm_genpd_init(&domain->genpd, NULL, domain->init_off);
+	ret = pm_genpd_init(&domain->genpd, NULL, init_off);
 	if (ret)
 		goto err_clk_unprepare;
 
@@ -144,7 +144,7 @@ static int imx93_pd_probe(struct platform_device *pdev)
 	pm_genpd_remove(&domain->genpd);
 
 err_clk_unprepare:
-	if (!domain->init_off)
+	if (!init_off)
 		clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
 
 	return ret;
-- 
2.43.0


