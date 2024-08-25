Return-Path: <linux-pm+bounces-12858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2083B95E34D
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 14:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3021F211DA
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 12:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC47143725;
	Sun, 25 Aug 2024 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ggfYh7Ml"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EC01E4A2
	for <linux-pm@vger.kernel.org>; Sun, 25 Aug 2024 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724589394; cv=none; b=HWsAYBMCQnOCRD93OeVmBJ3PYsi+YvlgC6NA93zLunZisdFT5tliaFUMPe/I100yuu2Ood1cNeBARYmeB3ZU5hUu5wcDXNIZerkxDfSypShs8W/cHN128LSkJwRW2oCjvhYd7fdZjLNT6q03bJ7lRDgEZ0EPjxtQiPxnWKaB8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724589394; c=relaxed/simple;
	bh=6AXodfhsBb1FFNtIxaDf38XHEgg7CfFzYFaOmts+BKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FlL4C2xYiujMwXvrakdJvKGdSoi7D28EFFablK47z0nvKjsiRX2P4ffZlbbIZvgri9OOndvZgD3VGcuMzP5yIeZT2GLrlaowf+8RhMg+Z4l8cfoSpWvctKVSYcP24YJJ6tDX2Qscw2ji95CUQZro5l1bbN7HCgrnFS+iOYcagPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ggfYh7Ml; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5becfd14353so3797736a12.1
        for <linux-pm@vger.kernel.org>; Sun, 25 Aug 2024 05:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1724589391; x=1725194191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1CeKLJiREErcfFDmVmFht0rfeHvolojmCG1SEp0D9eA=;
        b=ggfYh7MlTwi4EfX/1FMcrgtSFlClmR57kHVhzQkAYxggIgdkbNE2xx/9pZ7WSNsf7U
         SREoXu8BrVBdUNDpwT5+P7nZKH21LAL67h9EwlMkR6N3mH4pUJd1ZlAYxp3vax2tcnyZ
         T48FqWRF15uuWrTnz79PnK2glPk9UIA9+SUTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724589391; x=1725194191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CeKLJiREErcfFDmVmFht0rfeHvolojmCG1SEp0D9eA=;
        b=TjAEpSKLkbjo7hNTaGzxaB4mHjAilnk/80AWC4VFfTns31L0YC7e3QMfzXOkGX1jzP
         4NhMKY8zATGqVsZ0uPWKG4tuPizJIWNaRDwhd6zNXQDySjsTnV1/AqWotV5MtILPUYD5
         5Q+ec9+8yjpnseyQ1Kw7+aXNXcqYLWEDfFAV1yqsVpwqMI8laYWk6TmHnQnbp6l8ZztZ
         bfzF6MyWAt5GzOVwM4E5kxX8rgNUDVPg8UZANzj2JK2yweCepvrbGC3Afvf9+gc+W3ng
         +eiWqwsy+cl8gT/g4x7UZxs+bfr27TU7fNM3kZm54QlXPceVxjcds5PP5zA3Qptf4Py9
         TTUA==
X-Forwarded-Encrypted: i=1; AJvYcCUzlFNai6x/zEzeP7CPXNPj4bX7kKuzXG+DHCaHUI4vEO46YHjj7TgGoOB5F3DfG9fF4wPyD5GoCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFuSJlVPf/8Ts161sxQBF2+EIbhyeA29WMMeG8sezEjuwwsowM
	3S3GCS1MMSdyPD4jVxACgiYMkJguLpSADD3Nm8wZJX8jqxdqodDVWJmZ+U1EcWs=
X-Google-Smtp-Source: AGHT+IFHSFH/DUCkWWR0GBh4a/QABa5dvYX0l+xr818EafuCdl7Z/HffbouhFE5+OopSoVp6HJHHKA==
X-Received: by 2002:a05:6402:d0a:b0:5a2:8bef:c370 with SMTP id 4fb4d7f45d1cf-5c08916403amr5020278a12.15.1724589390746;
        Sun, 25 Aug 2024 05:36:30 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-25-99-149.retail.telecomitalia.it. [79.25.99.149])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3e89ebsm4350404a12.43.2024.08.25.05.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 05:36:30 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
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
Subject: [PATCH 1/3] pmdomain: imx93-pd: replace dev_err() with dev_err_probe()
Date: Sun, 25 Aug 2024 14:36:14 +0200
Message-ID: <20240825123626.3877812-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This way, the code becomes more compact, and dev_err_probe() is used in
every error path of the probe() function.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/pmdomain/imx/imx93-pd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
index d750a7dc58d2..afc482ec563f 100644
--- a/drivers/pmdomain/imx/imx93-pd.c
+++ b/drivers/pmdomain/imx/imx93-pd.c
@@ -126,9 +126,9 @@ static int imx93_pd_probe(struct platform_device *pdev)
 	if (!domain->init_off) {
 		ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
 		if (ret) {
-			dev_err(domain->dev, "failed to enable clocks for domain: %s\n",
-				domain->genpd.name);
-			return ret;
+			return dev_err_probe(domain->dev, ret,
+					     "failed to enable clocks for domain: %s\n",
+					     domain->genpd.name);
 		}
 	}
 
-- 
2.43.0


