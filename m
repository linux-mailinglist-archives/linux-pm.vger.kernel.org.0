Return-Path: <linux-pm+bounces-11201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4474933878
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 10:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42FD1C22489
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D601B948;
	Wed, 17 Jul 2024 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="T+cwgzpk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="c4/g1VU1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D52C6B6;
	Wed, 17 Jul 2024 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203423; cv=none; b=B14qLZ7wdeH87DHUlHR7iPjM6QppFIMb9bgfVJjEbZ8zU01DyM3nMeay7Ysri6MUGvAsW36yvqChGSWh1saIUcR1Pk3zuu1BwmzaI7UvUSzehtdpD/VBB0g0hqeS4YFTDL/FfCz1WFkfxzumVPdy9joLD7WjtDtPWQ0DXAeqOUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203423; c=relaxed/simple;
	bh=XPf6FraqAY5Pnc0921qTtkEWqT98FeTp2J69L7xL064=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OURKMbWDDpGNGYxFV9GgTm5P4/2eoyh1BimRL2CKGpKeZgMRBD6gDhSGAF0e9pvpou5+UQ9c939qFjLGqcC3w2rI3p/xZ2a34NfaiPZFrHowjBCk6iNWtvzZtKN4g/Pzx5v9HZMF4LeGtNn1IY6LT0izWqFYpVi352rvhKBfm04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=T+cwgzpk; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=c4/g1VU1 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721203420; x=1752739420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/AfJrwnzPB93tg8xRLJ+lSVIdfMPUjr5wVivkuJa62s=;
  b=T+cwgzpkT8soeQZBdFbA9Hlr5NytLvyMBZWyodpy1kiBq3CW84Gyn8cW
   VfKSwYGYyQ3gc7U6Ufu4ywiugsfhus0JQCz5M5Cg75hZfTrnWFJ2WSc5N
   QNNMh+U5K3X6Csn2min0uDUwcqBR6u6lxZ9YA9nOK5GNr3cKIZtcnEKot
   /ciAMMMIP4yAmPjutAcO7d3mnJN0rKcVmOBtbI39FTaGdFUidzsPJNZmE
   Tj7YO5COiF5XkEEJ2S74q1jc0c8hGWCaL+cIgQQAB6dXdRirxLdEvtWVV
   7NwfFYhseaGdOVXsBxFZgxZMPgvNG9dkGWG8uGNuRkK7xbJrQGE93AotS
   A==;
X-CSE-ConnectionGUID: g/oQUe2TQSy4TdPmv9qhIg==
X-CSE-MsgGUID: va+o87CQT+Ggl3lcXeqvzw==
X-IronPort-AV: E=Sophos;i="6.09,214,1716242400"; 
   d="scan'208";a="37944923"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Jul 2024 10:03:38 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44ADF161428;
	Wed, 17 Jul 2024 10:03:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721203418; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=/AfJrwnzPB93tg8xRLJ+lSVIdfMPUjr5wVivkuJa62s=;
	b=c4/g1VU16nGwwQPwN6MWQ8dfHI0V92TxbMWjcBPCVmtqoi+WRJb7S9nBWVuMu/R0hR4ALO
	Vis93GlwsysQusTIb1TcXPhFO3CqG1htAZM+tqg+MAa80FtTCrDzyvloL9QPblb2hmuMdl
	SAwfIJRMa3gncbOcx8s/01hB3oOBiDdgXVS4vCTqRbqkffzkJj7fGjaFs5JqicEcSE4KWA
	cozC7WSZBWMo/28OSLB+INKCDOsp+mo07E6UmPmGZYsrN1LC63Jy4+fo+h5AgFvu56hWhj
	b+9N5caKcx3SJXElSP8Jg6tgvFo6yNlMC0sqnfPygwkq8HMBM7qhJDIhz/fffA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] pmdomain: imx: scu-pd: Remove duplicated clocks
Date: Wed, 17 Jul 2024 10:03:33 +0200
Message-Id: <20240717080334.2210988-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

These clocks are already added to the list. Remove the duplicates ones.

Fixes: a67d780720ff ("genpd: imx: scu-pd: add more PDs")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/pmdomain/imx/scu-pd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
index 05841b0bf7f30..01d465d88f60d 100644
--- a/drivers/pmdomain/imx/scu-pd.c
+++ b/drivers/pmdomain/imx/scu-pd.c
@@ -223,11 +223,6 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "lvds1-pwm", IMX_SC_R_LVDS_1_PWM_0, 1, false, 0 },
 	{ "lvds1-lpi2c", IMX_SC_R_LVDS_1_I2C_0, 2, true, 0 },
 
-	{ "mipi1", IMX_SC_R_MIPI_1, 1, 0 },
-	{ "mipi1-pwm0", IMX_SC_R_MIPI_1_PWM_0, 1, 0 },
-	{ "mipi1-i2c", IMX_SC_R_MIPI_1_I2C_0, 2, 1 },
-	{ "lvds1", IMX_SC_R_LVDS_1, 1, 0 },
-
 	/* DC SS */
 	{ "dc0", IMX_SC_R_DC_0, 1, false, 0 },
 	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true, 0 },
-- 
2.34.1


