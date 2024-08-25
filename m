Return-Path: <linux-pm+bounces-12862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A91095E3EF
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 16:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF401F21669
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15E2156C74;
	Sun, 25 Aug 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ihYMXAN8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A45464E
	for <linux-pm@vger.kernel.org>; Sun, 25 Aug 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724596475; cv=none; b=ro1svkdP3eL/ZUr/5BXXuYPb44D4oKlMSJ4Hc9X+LSi2Q/byv/lqlZRzrRVvEbyA6mJ88eC8jeRxEMDw8s0fLdLAWORpnmP3Ze/B46SWC9nd7NH2/s+A5VdraqzQ+AKDWzcRfhOTHlJvHpyVudsSwMxsgDF9N9/EeWAOETwAg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724596475; c=relaxed/simple;
	bh=Y4w5OHB5AAqQgw5YqBA+ey3TPocL/Uh/eEew5lcaGaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=caqPvN0vIEEsa0mf7EH4vEvxifQclLaIdAZR+Le/YwZ3WiBDCKWId3cOOOPk/ENIF5j4MmkYOxy+Dx6QsqNk/A1EnNRZxTlmbnTYxrFXfOUthGBJ9U95mgZwche5KHHP4eYauoz/TF2USds1H0JOC7LQRptIRBM0fd5EH4XL4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ihYMXAN8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8695cc91c8so362554366b.3
        for <linux-pm@vger.kernel.org>; Sun, 25 Aug 2024 07:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1724596471; x=1725201271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KJCtcmIB3UdIrkYLcVzOIpEPiO2wmd+dCBPvqHnV2K4=;
        b=ihYMXAN8P/oS5Omlvw7LKf0EmeqiN5gVWUxQdm+Jxifh6b6NTAQRmyHvDlNO0yRgcO
         9d3xw3M89fMfcuDN1N/OPqUddkRNOcbCqjZ7JHOsjx4gJqNeIuoQJrBREYV8Ew3dXp0o
         44G+q4E6m6UVpVRXoBUoSpyapGYYdBzn1gAAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724596471; x=1725201271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJCtcmIB3UdIrkYLcVzOIpEPiO2wmd+dCBPvqHnV2K4=;
        b=NRI7N0jdNHDl6ex4zKaj1RePfON3teMnkNnHYssILf6QyLCAWl8mOSob/ZWRC4II39
         UBTB1uomlqx235czA9ta3jebFMNLmzHPDNUI+m0sEuP+WFvEx1OB4w4x91ZcIgaLY6xc
         zrirt9E7QzycxxWF5LU7jC2wYRge4woKR7OIk0CoU7ugObaWgp0BJTPO12+eEN5YDEse
         4y+nh61N79ioNycwR1PBDuOh0FeDNCjmVNHNnMQaph0l0tgEjSM9Mw1pCCyWxNFd8ZuN
         RYtaObFILiBqVrcjxu+hXyi5cM8zfRBgGNKBH2BInJn8bPdzTQqrKv0/u71tIJAYXrVY
         Y98w==
X-Forwarded-Encrypted: i=1; AJvYcCVk6+WPdGGYLjWbz3WNP224u+oVCw49I5xRA42M+ltBCLf+ve7u7s4ZfZGRSwex9hecK7fixEEBzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkLkJ88wSd2lZ8VxAP2yfVeJQfld7M3JkX0S10XGusNqGmJGSA
	vWzCm8Hp2ntLkruMDozWwUWVOCmpPBuCAhwZ3VSt/SbLb+PhwPEBHG9g5M6ZFxM=
X-Google-Smtp-Source: AGHT+IFrPkCDWSQxHr3mcynt8lDSRSWlq9K1FdNFRP5DdDzP7xtG+zdnJc3gqlxqDwJcYjVr7uYgTg==
X-Received: by 2002:a17:907:7f12:b0:a86:8524:2558 with SMTP id a640c23a62f3a-a86a518a3a6mr468976166b.12.1724596471075;
        Sun, 25 Aug 2024 07:34:31 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-25-99-149.retail.telecomitalia.it. [79.25.99.149])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4862b6sm550625566b.170.2024.08.25.07.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 07:34:30 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Fabio Estevam <festevam@gmail.com>,
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
Subject: [PATCH v2 1/3] pmdomain: imx93-pd: replace dev_err() with dev_err_probe()
Date: Sun, 25 Aug 2024 16:34:00 +0200
Message-ID: <20240825143428.556439-1-dario.binacchi@amarulasolutions.com>
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

Changes in v2:
- Drop the extra { } to be even more compact.

 drivers/pmdomain/imx/imx93-pd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
index d750a7dc58d2..44daecbe5cc3 100644
--- a/drivers/pmdomain/imx/imx93-pd.c
+++ b/drivers/pmdomain/imx/imx93-pd.c
@@ -125,11 +125,10 @@ static int imx93_pd_probe(struct platform_device *pdev)
 	/* Just to sync the status of hardware */
 	if (!domain->init_off) {
 		ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
-		if (ret) {
-			dev_err(domain->dev, "failed to enable clocks for domain: %s\n",
-				domain->genpd.name);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(domain->dev, ret,
+					     "failed to enable clocks for domain: %s\n",
+					     domain->genpd.name);
 	}
 
 	ret = pm_genpd_init(&domain->genpd, NULL, domain->init_off);
-- 
2.43.0


