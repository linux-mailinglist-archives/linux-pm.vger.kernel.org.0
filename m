Return-Path: <linux-pm+bounces-16562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9AA9B2CD6
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 11:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229FB1F21C04
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB51D1D79B1;
	Mon, 28 Oct 2024 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MLBc/CUD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CD31D6199
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111179; cv=none; b=nV+PA4WZZZaeU42fsjAGJWwqobVtNqkFgY0DM9XWGYFYOAFKWq/HM7UY/Y+bV96JGkT+PPfYKqKwhpdJlTpqlOZhI2p1wkajSWMRqnqmvBdxEK11glK1f5ajibgcf30z7qE1ow1HHkshQFngYCmPMCUJjliQlHbfnNS8aXYs7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111179; c=relaxed/simple;
	bh=js8gtoeOZlGeLq8295+lq+IHMiMRiPiXT/e6W18eRR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bByyOl1Fubhn4WKEcO3wkJUBT2ubkdWka9Y0sVVIHptin4PVhIIfyaHgkbT/DOQzWAdxqdm1uIqcNZ71lo1TDxOZdgj1TeK3pMPmwqVgPi9znffu/23G3Rl3hGPicjMZmkm0LDmqLd+vUNqPyHN32gfvow3EqVPEh8mLyl3VdLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=MLBc/CUD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso4766333a12.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 03:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730111176; x=1730715976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tF2Wj+vRMtC983z9w7XL42BV51oFEPPNHEhybEVd+Q=;
        b=MLBc/CUDiBMDtEFFQEvkxQ9roetxU0lYbF+fhzmM1/3c4mloJVXF+W4LngTXlzul8u
         ef18aKSB5BSTLcbMAJrYmn/In9gLl6RzN5e2h5RvamGR9CNaZ5EDI9J6okOfW06ktOSb
         Fn/TEX68ZavztV6AD/r8LFu9fWhjBbRHJUgIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730111176; x=1730715976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tF2Wj+vRMtC983z9w7XL42BV51oFEPPNHEhybEVd+Q=;
        b=sV9POH8KXJXikfSWb5f9/g07SZ/VNFJ85Pas5AXxtGSPZ3FvCennw0I+eMEh83OTG0
         j6yIEeNiFe8unQhLt5/2T3016xGQNftuVXBcVYbf6bEjnPdLK36Ut5wFjvxvUvBi+E8c
         JUROV3W2HdXAnIKIv6xebqlQCM9tdiHtZlUP57nwfzGjA9xqBRsGmjEPEOh0bINGVXQZ
         Oc3YYaoaeZuKRaC73/ONuMVl3DCtJ6bYQRzWM810HZ+zWplbHfqU8T98L99lU7M4zAhx
         b/k9/Q/VHLIGPU6sVrd4prE7gDvptFkOXkkhK3XTyTRiPoXRRz1FT3CxFcaALcZepSTK
         mrYA==
X-Forwarded-Encrypted: i=1; AJvYcCWKklsyIyyfG/bCH3/nIicwb64oRucYNKE+sD/BBNlzTkq0hrSMFkUB5871QHzeUGLfPK2xbHS+GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKfoeghBxKVZwpOUeGChCT+VNKyoaQzqcK9RB0Uhp+Q2wCz3fl
	dip0dte3DFXBPzKmChktxkryBCOYNIHH3QB8LmWRDiu2QbmuvF8R1UQ4vIH2Ngs=
X-Google-Smtp-Source: AGHT+IFdXb6XtLDCZdRMrvkyA0aKsne7r7Yx41P1F2c1jET9YdgAPGWx1KeM7QlZRwkreW9voNIysQ==
X-Received: by 2002:a17:907:1c22:b0:a99:f1aa:a71f with SMTP id a640c23a62f3a-a9de5c90d49mr793546866b.11.1730111175841;
        Mon, 28 Oct 2024 03:26:15 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.41.121])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f297b04sm363613966b.134.2024.10.28.03.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:26:15 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
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
Subject: [RFC PATCH 04/10] pmdomain: imx: gpcv2: don't turn on a power domain already on
Date: Mon, 28 Oct 2024 11:25:27 +0100
Message-ID: <20241028102559.1451383-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028102559.1451383-1-dario.binacchi@amarulasolutions.com>
References: <20241028102559.1451383-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch, by informing pm_genpd_init() with the "is_off" parameter that
the power domain is already on, prevents the power_on() callback from being
called, thus avoiding the unnecessary repetition of the hardware power-on
procedure. This feature is crucial when supporting the simple framebuffer,
as the power domains have already been initialized by the bootloader.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/pmdomain/imx/gpcv2.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index 963d61c5af6d..bf9fe4af03c5 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -1324,6 +1324,7 @@ static const struct imx_pgc_domain_data imx8mn_pgc_domain_data = {
 static int imx_pgc_domain_probe(struct platform_device *pdev)
 {
 	struct imx_pgc_domain *domain = pdev->dev.platform_data;
+	bool init_off;
 	int ret;
 
 	domain->dev = &pdev->dev;
@@ -1354,12 +1355,33 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 		regmap_update_bits(domain->regmap, domain->regs->map,
 				   domain->bits.map, domain->bits.map);
 
-	ret = pm_genpd_init(&domain->genpd, NULL, true);
+	init_off = !of_property_read_bool(domain->dev->of_node,
+					  "fsl,boot-on");
+	ret = pm_genpd_init(&domain->genpd, NULL, init_off);
 	if (ret) {
 		dev_err(domain->dev, "Failed to init power domain\n");
 		goto out_domain_unmap;
 	}
 
+	if (!init_off) {
+		ret = pm_runtime_get_sync(domain->dev);
+		if (ret < 0) {
+			pm_runtime_put_noidle(domain->dev);
+			dev_err_probe(domain->dev, ret, "failed to power up bus domain\n");
+			goto out_genpd_remove;
+		}
+
+		if (domain->keep_clocks) {
+			ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
+			if (ret) {
+				dev_err_probe(domain->dev, ret,
+					      "failed to enable clocks for domain: %s\n",
+					      domain->genpd.name);
+				goto out_pm_put;
+			}
+		}
+	}
+
 	if (IS_ENABLED(CONFIG_LOCKDEP) &&
 	    of_property_read_bool(domain->dev->of_node, "power-domains"))
 		lockdep_set_subclass(&domain->genpd.mlock, 1);
@@ -1368,11 +1390,17 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 					   &domain->genpd);
 	if (ret) {
 		dev_err(domain->dev, "Failed to add genpd provider\n");
-		goto out_genpd_remove;
+		goto out_clk_unprepare;
 	}
 
 	return 0;
 
+out_clk_unprepare:
+	if (!init_off && domain->keep_clocks)
+		clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+out_pm_put:
+	if (!init_off)
+		pm_runtime_put(domain->dev);
 out_genpd_remove:
 	pm_genpd_remove(&domain->genpd);
 out_domain_unmap:
-- 
2.43.0


