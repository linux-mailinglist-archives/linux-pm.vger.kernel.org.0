Return-Path: <linux-pm+bounces-12438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D353F956D2F
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732891F235F6
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28EC16F260;
	Mon, 19 Aug 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0FDRGw6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C4416CD07
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077632; cv=none; b=kIt6mTDtiOtXGhMWQ5GXp2s1uELKIaPVLZeWgMwPyvhXDASsuEYKvcAanpOpM8QvCNBkZ/NEP2H+xXHLcT3J4y21dkg/c9vSox30G61JV1iflnaACSjczgVlU16XP4X7NAtPs2Z2VKO5FsFYanI6wwhKguOO5Izh9E7aF5qjp4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077632; c=relaxed/simple;
	bh=djtggWgq5eB6M4YakigtMYBrLq8szgHMzT53Yv7u5wo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GOEFh2lq8Ss4kqtC1SKkJ9flrTHfh9sogsYFuSUE1Q6imqLIDalOaOS9TrvGSFZPUI3+6GbehlV6fUFdVwum90sXDV2L+Z+s9sjxNA76/rTWRQm5v0beQbsPMg8Q9r034097K378vtG29lMZKvBrkB9H6iBaGt0IJQ2+qxBkyqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0FDRGw6; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2635abdc742so550034fac.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724077630; x=1724682430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8U11yJMCCz9ocZBsA/XDi4Mb91m2fc2Zz9Q1yQzZ3MI=;
        b=Z0FDRGw6iy/jpnocCVKsO5iLYixFJSy/BflAoG0PFAYT53A2fufUmAiAvks17HOxHI
         ThP+Q83pTM3haPMTHw931R9SrD6F9lgRvf9SvbkEo0mCO3/BvRAt7dD2sopBcKz1dRW1
         8i/vB3MZwLcyuxXsTzqRi4X3DLGIqU1WOqw061CsxM0SLtUH8uGyBQtevYld5nUcsm+M
         p8EPwf0LQh7G3N0zFXTakjp31T0ei600vNZWyj76jyHRaffWnpL53KxxHEcrNZ91CViB
         v18Qc9rhmd0vYoERzhwozdLSe10T0egY1TIjBerswpJnQc1+IdiNvlSX2aMHj/n6/sqO
         rrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724077630; x=1724682430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8U11yJMCCz9ocZBsA/XDi4Mb91m2fc2Zz9Q1yQzZ3MI=;
        b=Py1SK1/WG6WJ7XIP44WaNdqz1aFOi9e2X/kw4/zxjm2l7BVnqnFGWUp45GYYMXPQ0G
         y9ijPUqtyrUu8JxuE5bU0c7lUQzqyCpjpYWYyPlgU+/410iw/351HQy80z9e4GhLQE84
         SNvmJSpKuk4VgG2e/VC9FN+i0yZyo8ataZ8V5MBio8aUOgDxlUJMYPCUvLvSCFLGppCR
         iBj5Nx9laLbbt+r/rElHtUWrUpVGKupH+jOCu1f/eYTniijdqr+Rmhq4gB//gIiSKdWm
         uuzimkz2JModfafdBYCZ/4upHhu7929x3YpNrXMGPf0dDkbbKp7MGDOwN/efBc9tcGqn
         j9Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVxR4xfvGdnjGxlneareigqOVVkiprKHD9CcDeOoBvj+L8dpKz+xl62MdzD73YGxz2UfaCIE9XZXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEl64P6OmL1gbMkFeGjY32LGFApna8WCISEyg2eODUDJf7ePID
	EKTTYLgaSVfKJ9l2dz4JMAT37Pmv5B0tyBaFETyhIbG7XFrm2cp6
X-Google-Smtp-Source: AGHT+IFpW+QZpwk1NEeiIS3PoT9ZQgiV3SIsF7BZ+UvfOC1sQPfxGHgUnprVKVIhlNsK/npzGfYlzw==
X-Received: by 2002:a05:6870:ecaa:b0:260:e5e1:2411 with SMTP id 586e51a60fabf-2701c50f7abmr5697919fac.6.1724077630115;
        Mon, 19 Aug 2024 07:27:10 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:9187:7fc0:77bb:926e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61c6124sm7610565a12.27.2024.08.19.07.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 07:27:09 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	linux-pm@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] thermal: qoriq: Remove __maybe_unused notations
Date: Mon, 19 Aug 2024 11:26:59 -0300
Message-Id: <20240819142700.1206586-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

The combined usage of pm_sleep_ptr() and SIMPLE_DEV_PM_OPS()
allows the compiler to evaluate if the suspend/resume() functions
are used at build time or are simply dead code.

This allows removing __maybe_unused notations from the suspend/resume()
functions.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/thermal/qoriq_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 404f01cca4da..4ace3b2a3d30 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -347,7 +347,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
+static int qoriq_tmu_suspend(struct device *dev)
 {
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
 	int ret;
@@ -361,7 +361,7 @@ static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused qoriq_tmu_resume(struct device *dev)
+static int qoriq_tmu_resume(struct device *dev)
 {
 	int ret;
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
@@ -387,7 +387,7 @@ MODULE_DEVICE_TABLE(of, qoriq_tmu_match);
 static struct platform_driver qoriq_tmu = {
 	.driver	= {
 		.name		= "qoriq_thermal",
-		.pm		= &qoriq_tmu_pm_ops,
+		.pm		= pm_sleep_ptr(&qoriq_tmu_pm_ops),
 		.of_match_table	= qoriq_tmu_match,
 	},
 	.probe	= qoriq_tmu_probe,
-- 
2.34.1


