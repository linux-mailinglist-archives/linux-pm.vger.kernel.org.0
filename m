Return-Path: <linux-pm+bounces-2345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709EE831F7F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 20:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24F81C230D9
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 19:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCD2A53;
	Thu, 18 Jan 2024 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="PfFEVZQv"
X-Original-To: linux-pm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801922E620
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605180; cv=none; b=fLgX1xO3sIjuNPTjOCaC4ebEzS/9aUpGfs4iy/uQqxkQAWg9FRCxz6/3LmiUWChVmjBBaG/GWy32nLIRUiidS/5uVt8GqfLLbRVwnqeXf3Fae8cjnftHqKOJV0KWAjuvMOc+z0NihqDT7/FgTcvI41C7DyP0M8Kg+8O/KomRmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605180; c=relaxed/simple;
	bh=rryNpJSG1BWICIX89m8yqHYp3cZzNOLaw5aAZ/bI1x8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rIctEdcGwea+6bFmludktElb738aIYLL52NfG1XgYIuNi3Lpo6P6rN8TiHbppRKjyXjtksEPRb9K2lucXAAB6oOEjmCHvWun1fWB9YWBNwAdkQk0e0aw+6Uv08JXY33FTNvhUBHooAMOreXvbS2Xh7qXgYtI1YDNRj+j0EuUQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=PfFEVZQv; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BDF5D85E44;
	Thu, 18 Jan 2024 20:12:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705605171;
	bh=spLv23iepvexx7sMsCkjYR2XpICnNm57Tp/xysuWojw=;
	h=From:To:Cc:Subject:Date:From;
	b=PfFEVZQv57emsLHRD45ihb+DlgT0cWvBJTSX8IQx3FTvWOY7J4rkDcGIvMbwbx1ZW
	 I6xw0uIGzpp8Ai6gFQo5F9XyAd0/g2T7s5u8Q16v16oUPoQ+vfMShL4lYnwP6xBjh7
	 f2r7U8FNYAMG/HPDi99aXn0LBsOhdbWlFkXiOHi9XP3FbLndyZi4U4zsJ7tPGLvFnb
	 LO2fcgzFjrSDsx+fYSE17t3hPYBBszd3CLySsGgnplpzLzv7uhyUXHdzSsmYE0A5AJ
	 uZWxGGooe7uYP6HE/4R1IdwfjefhsJhRyXC8FCjmJglf8EcQfw4Vh4fUlLPWDMVeau
	 Q9ICPDeP2zcHw==
From: Marek Vasut <marex@denx.de>
To: linux-pm@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jindong Yue <jindong.yue@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pmdomain: imx8m-blk-ctrl: imx8mp-blk-ctrl: Error out if domains are missing in DT
Date: Thu, 18 Jan 2024 20:12:24 +0100
Message-ID: <20240118191235.145549-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This driver assumes that domain->power_dev is non-NULL in its suspend/resume
path. The assumption is valid, since all the devices that are being looked up
here should be described in DT. In case they are not described in DT, beause
the DT is faulty, suspend/resume attempt would trigger NULL pointer dereference.
To avoid this failure, check whether the power_dev assignment is not NULL right
away in probe callback and fail early if it is.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jindong Yue <jindong.yue@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Marco Felsch <m.felsch@pengutronix.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c  | 2 +-
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 1341a707f61bc..1b83c9c2d5b77 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -258,7 +258,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 
 		domain->power_dev =
 			dev_pm_domain_attach_by_name(dev, data->gpc_name);
-		if (IS_ERR(domain->power_dev)) {
+		if (IS_ERR_OR_NULL(domain->power_dev)) {
 			dev_err_probe(dev, PTR_ERR(domain->power_dev),
 				      "failed to attach power domain \"%s\"\n",
 				      data->gpc_name);
diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index e3203eb6a0229..3d6888afb416c 100644
--- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
@@ -687,7 +687,7 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 
 		domain->power_dev =
 			dev_pm_domain_attach_by_name(dev, data->gpc_name);
-		if (IS_ERR(domain->power_dev)) {
+		if (IS_ERR_OR_NULL(domain->power_dev)) {
 			dev_err_probe(dev, PTR_ERR(domain->power_dev),
 				      "failed to attach power domain %s\n",
 				      data->gpc_name);
-- 
2.43.0


