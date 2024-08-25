Return-Path: <linux-pm+bounces-12859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199DD95E34F
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 14:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1CA1C20C49
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 12:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BDE154430;
	Sun, 25 Aug 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DAH5xNvk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACE613F42F
	for <linux-pm@vger.kernel.org>; Sun, 25 Aug 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724589396; cv=none; b=TtLWfAUNd60pEOa/t1esmd2Am8GK2tBD1wd+l7w4r2ccZ4ocGVUkR2oQT5gB1VYjQ5vj5G0fCf9hK2+s0RDuTcpQTT8QFdWyr6qZ4jaKTcIRP3e92rx1IMCEBPRIEahL7hiJ4GYkxE2oUHhY5hTvvyQeP5+aLdeCpS6mWgFPZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724589396; c=relaxed/simple;
	bh=77c2NJVmdWrqGHVnDc3yMW37k+HNUe9SmurV/a/Bhrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNvWodKY71LLEdACbMv1Aisd+zE8D0Cm7eZUh0wFxsL2vUUiDgRnDsKXREyk/FZIJA9ZHOF2wzNwCRWu2bMcifh2l8aIZ0yHEz+kcp5q9Z+3LSPj2EwzfPpEOYbHQAChIHJ8v8TWMhLFvFLdYwuIM8ch3uewt0M4YIUAvibs8fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=DAH5xNvk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a869332c2c2so503548466b.0
        for <linux-pm@vger.kernel.org>; Sun, 25 Aug 2024 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1724589393; x=1725194193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf5APENb9JvqJNcRLDTY5Ylob0hcYN8J/GA4M8ib6BM=;
        b=DAH5xNvkmDThFTARY/F94x/+osTRS7ZzHSXQJltZJNtxBRTYEZMbVudaxhizX7Jo+2
         zgxS3MDN3Y3ontmY1yHF5lPgtZhr5ClpzyFLBV0i2MRtQYQA3BJYBZ71srjFRKhLq1qj
         kheN2GE6uQNg9kEE3HpHQjBHRrsCdJRPtWAwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724589393; x=1725194193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zf5APENb9JvqJNcRLDTY5Ylob0hcYN8J/GA4M8ib6BM=;
        b=ZmaWvql3rtlUyaq2/hBTg+IQrjL2sEdh6uyeW9wlvMO6icLdEooZoGPNUQLF+WVeJK
         fAWwQm6fh5hrjk3imjQKUPMsjSkVm7kml3QVKLBBOroSMtmNf0PBFT/wLK7NKg7x5z24
         eXKxqc9jGh+DobGl8Y1qGzIB2kq0WRIJinV/P8khJ6UR3sWwiIW+xEQz/XDuRi8dHzhM
         qW+O7mP88s99HX2AEwTqHZfxJ++sT3Wz7uh/TNgHDCUwj2ZWYuLLHDu1t5gQiwz5EaIO
         IP6Xjfbl2YVvefkQWCLd91Btn8DeceC54P99NSAj8CM1YNZ9Vt7jYhqi/lxuqO3UkS3R
         HbGA==
X-Forwarded-Encrypted: i=1; AJvYcCXfZZzH7ZW088GMqgP2F9wnL2fAmV4Xx8CkESZp50Scpdelo+N9NP5xhJHwQaPXUYhyRkDoL/BxPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAEtDVFAXQZIeuXJ7n0HqFvl0GuhvdMy+y8qMoQlXuE378Yk92
	2wytAfhFUAcfg+zIGa3An2xuwTvySaPat6iQSG1iS3oiIPUjctk+jcBWPrseFiU=
X-Google-Smtp-Source: AGHT+IEbIXr1Vpjt4uEgQC8b02IKfOC9sMIl+fcxKuvrrz9/HoMBQxzPbmHf4J/JyeD54FTi1+274w==
X-Received: by 2002:a17:907:2d11:b0:a86:a30f:4b00 with SMTP id a640c23a62f3a-a86a30f4d3fmr825679566b.27.1724589392821;
        Sun, 25 Aug 2024 05:36:32 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-25-99-149.retail.telecomitalia.it. [79.25.99.149])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3e89ebsm4350404a12.43.2024.08.25.05.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 05:36:32 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jacky Bai <ping.bai@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/3] pmdomain: imx93-pd: don't unprepare clocks on driver remove
Date: Sun, 25 Aug 2024 14:36:15 +0200
Message-ID: <20240825123626.3877812-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240825123626.3877812-1-dario.binacchi@amarulasolutions.com>
References: <20240825123626.3877812-1-dario.binacchi@amarulasolutions.com>
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

 drivers/pmdomain/imx/imx93-pd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
index afc482ec563f..24e5bfb336ca 100644
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


