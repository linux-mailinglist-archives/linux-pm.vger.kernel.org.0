Return-Path: <linux-pm+bounces-16472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6737D9B0923
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 18:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B6C1C229A6
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 16:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84787E792;
	Fri, 25 Oct 2024 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="naxm2wnp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B99185B7B
	for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872280; cv=none; b=l8tdbq1evYynE4coli1zduAUIHm3cTD4/lim4TMCf8SevF+0mIreuvIOZB/THa2wroupzLHn2QrVm3RRlJ/W7hZz1Vn7DMohGMESJHZKD31vyzTlOPwLCRskG982B94fXHDWvgj1h4jxf6KdRILmKpEkVvYn0B7x2lWhGYzDvjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872280; c=relaxed/simple;
	bh=rv5rJ4jmTrZ27qkbyvCgIO215qm4tAl0JboSDanP3hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2SdsZT56dW7Sz40dDvOCAtHt5Q5SW5r6f0NC1T+G93t7K7XbTVujgGVCf0edBlIg9mGuiV1JwJ84wXdwMi0Fy//u+PgryHacL6+842ikddopp9QGLWl78no6CIzySfi02QKW4OtYxNcaxlBQ5B3L/yjo/DIrmN6vKsosqIsI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=naxm2wnp; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so23157241fa.3
        for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2024 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1729872277; x=1730477077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xCM1ACcR+e8vZp8ZeWNxMr9lABciJDnozk61Zgoap0=;
        b=naxm2wnpTOjEvHretXyAmPU1/YrO8SA7WfkGp0j0JGmIFso6pdna0poLesiQE9T9Qe
         FBH2473tdWbDsPPdPOxeGtg2pkggqhFCI8VOQGj/IulcL8wLnW5vRtRoSGhSWxtqA7ot
         5ZdQ408y21jXB4QAE77AlGZe0nVhM7ruPez+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729872277; x=1730477077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xCM1ACcR+e8vZp8ZeWNxMr9lABciJDnozk61Zgoap0=;
        b=G7PhL2c7OP2URK7VOOg907hGjm522WwhAId4I+l96/5W+71xQQjjF7FwiQsYVPrdbm
         hsTIPqfdwJNTtve19hmCLUejDcgxmnzPYY+k1eAKoi7cPF5Ozc00AyANEjvJYN6L1Zlp
         93CWVguD9irsaihlhCBOPhhSYoImZkQjVLbrcHMDOeqW5OimI5oCsQV3FPHNBqrb8LDY
         7Q8/E2NkKOfq2I+xhWCZrBxT1n8tNleYcdAySNml412AfyKzvZXp49An5MVBMnFdilu0
         EJkYm5PDYPk/Uxz5FcmvZSTRBnSkxW/vSAh9cbQvNy9ymT6FA/7Ues383+54IgoyrKhg
         0bYg==
X-Forwarded-Encrypted: i=1; AJvYcCXwrelDQXtiHPa7HuEAbBJhylShwJGavViAWllhb1YanS7dCJY7+lxjx33oExbqwhw8t+Mhamr4Ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJH6wzop65trZC+I7OM23yfM/qf2nXZB7gBQ8tKi8/35jWSNpq
	C57oUOcdmUcz411F3RqZ6UtmtuDIbXdBNhV0W9r3q/ifjk/JCl4SOChISlF+hnY=
X-Google-Smtp-Source: AGHT+IE5tAGEzSGr1VKCRE9qh4Kh62Hto2hpFgEH+icsAjjqXGeOuQHrKjPabwauzhg1pQ0otdSs8A==
X-Received: by 2002:a2e:bc09:0:b0:2f7:6653:8046 with SMTP id 38308e7fff4ca-2fc9d37468fmr61995861fa.25.1729872276573;
        Fri, 25 Oct 2024 09:04:36 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.43.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058bb4348sm1848614f8f.111.2024.10.25.09.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:04:36 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2] pmdomain: imx: gpcv2: replace dev_err() with dev_err_probe()
Date: Fri, 25 Oct 2024 18:03:56 +0200
Message-ID: <20241025160430.4113467-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch standardizes the probe() code by replacing the two occurrences
of dev_err() with dev_err_probe(). Indeed, dev_err_probe() was used in all
other error paths of the probe() function.
Note that dev_err_probe() has advantages even if the error code is not
EPROBE_DEFER, such as the symbolic output of the error code. Therefore,
it should generally be preferred over dev_err().

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

---

Changes in v2:
- Improve the commit message.
- Add 'Reviewed-by' tag of Marco Felsch.

 drivers/pmdomain/imx/gpcv2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index 963d61c5af6d..6e6ecbf2e152 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -1356,7 +1356,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 
 	ret = pm_genpd_init(&domain->genpd, NULL, true);
 	if (ret) {
-		dev_err(domain->dev, "Failed to init power domain\n");
+		dev_err_probe(domain->dev, ret, "Failed to init power domain\n");
 		goto out_domain_unmap;
 	}
 
@@ -1367,7 +1367,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 	ret = of_genpd_add_provider_simple(domain->dev->of_node,
 					   &domain->genpd);
 	if (ret) {
-		dev_err(domain->dev, "Failed to add genpd provider\n");
+		dev_err_probe(domain->dev, ret, "Failed to add genpd provider\n");
 		goto out_genpd_remove;
 	}
 
-- 
2.43.0


