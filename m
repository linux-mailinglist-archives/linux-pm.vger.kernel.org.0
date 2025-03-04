Return-Path: <linux-pm+bounces-23418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831EAA4E589
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B761891DF6
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FBE2C1532;
	Tue,  4 Mar 2025 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="AUbGjBHy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EfIgBlsM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0195B264FBD;
	Tue,  4 Mar 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103399; cv=none; b=H/UgUvKuGdRXEqbz5T96C0pbzPVgjVNss95pS2/MDoB3hJQYseQCoGvQnjocTeNUr06toB4USYu9jRG83fTTmQzaWSx3I8pRN4v8ruhAnV8dwcDyqEEGdu27yZJsvjIDnIBgMZdFbayGG+l0LVI2NPVR71S5WR3butdSr9yrj6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103399; c=relaxed/simple;
	bh=vjgVYUK5TRk53wXHl50cHgbtkHvU9ukkNxWMaIgzKyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ld9avkxAkW5/hc5DOUIIactmu4Nlv7a3ZbtD6J3JGj7EiPVo08A7an3gmayAh0NI6hQTk7lGYPh+wkN05apOmoNd7wXW35zbJ8xxK3Czi+fwB4Pa9314Dpo77Sx2aoci+9u50AyV0ZHOuA8oI88dUZxTz6JKqrLVo2KuXJbr0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=AUbGjBHy; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=EfIgBlsM reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1741103397; x=1772639397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wE/c2Fa90XnbMz9AMwkVjT2yzgC+rVUkbGd6dOZFdWA=;
  b=AUbGjBHyjed/EKJu4xIGwKli0Z6S0Yl5fAX1E218F1PYNv7NWYunMmhe
   d5Ll2nUu2LGzNyYlSd4qFsB2HvrY94XR0mFrzYopoqXBdLSHKKTWyT2Ww
   cXAbwIphkqq1q4PpCQDa/5y5hHr83ec6sfW248zAsoFrRjBhKaS8Dzw2A
   oZGiEGWHnMIkyVH3MvdQ0oWN9ZyY0uvCBaoM4MQ9f7W6kNABWxf3C6Y2+
   SWKiLH4Pz4BzNctKpcTuNLmLS3mKOz6+R4I4v7gmWDtnXjZYMCCHQ6zUz
   qWGgNCCwMkwpoOpidIYiuqJxAueZIPEf1kZeWQj/smk4AaRFL8Mw9lRto
   g==;
X-CSE-ConnectionGUID: eiMfnn0RQral6d6IjLP81A==
X-CSE-MsgGUID: f3mKrzHHQBqOu18yxaTVGQ==
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="42272741"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Mar 2025 16:49:56 +0100
X-CheckPoint: {67C72124-3-2417938-F0170C2B}
X-MAIL-CPID: 9BB829BBFCA8BCE751FB4D144BA7619A_2
X-Control-Analysis: str=0001.0A006366.67C72126.00E9,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD7161632FF;
	Tue,  4 Mar 2025 16:49:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1741103391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wE/c2Fa90XnbMz9AMwkVjT2yzgC+rVUkbGd6dOZFdWA=;
	b=EfIgBlsMg1UVRuBSSkt1gslSFVNMtBmC6X0tFrcjg4DTePGEZ4T54mj/FR/VBkrhgxzUL5
	G9sspy2+dIkmAiGsEhXFiUdsDQG4etKjlqqx6G66sut7cBpGuPqjEwe+f/VIfUSdhB+Mvv
	qWAJ2xifDdXb0hlE1IbZuQF0vw8PlPNK10BBKFaD5/7rVPLC332sbYOAat88iExv42XiGQ
	+nUnGiyneJ6et1RMLU7HvanGgOnJI1gytfvbPJyYTqUqt6tCRn8zcyKsOHge7Qs1/50B7L
	lkRCihdhQGmUkBl7jNAk/ATNwUHEC9pMLEtBrfTOf6GKEVUq0hpnsOlixfBfvQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 3/6] pmdomain: imx93-blk-ctrl: Scan subnodes and bind drivers to them
Date: Tue,  4 Mar 2025 16:49:22 +0100
Message-ID: <20250304154929.1785200-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
References: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This particular block can have DT subnodes describing the LVDS LDB
bridge. Instead of misusing simple-bus to scan for those nodes, do
the scan within the driver.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/pmdomain/imx/imx93-blk-ctrl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index 0e2ba8ec55d75..fe2ff7a457502 100644
--- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
@@ -7,6 +7,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -297,8 +298,14 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, bc);
 
+	ret = devm_of_platform_populate(dev);
+	if (ret)
+		goto cleanup_provider;
+
 	return 0;
 
+cleanup_provider:
+	of_genpd_del_provider(dev->of_node);
 cleanup_pds:
 	for (i--; i >= 0; i--)
 		pm_genpd_remove(&bc->domains[i].genpd);
-- 
2.43.0


