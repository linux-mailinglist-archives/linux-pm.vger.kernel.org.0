Return-Path: <linux-pm+bounces-2357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A806832321
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 02:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433081F23271
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 01:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECBBED9;
	Fri, 19 Jan 2024 01:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="uKa8tNjf"
X-Original-To: linux-pm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2728ECE
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 01:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628904; cv=none; b=TrkJq8jHIN8dJq+FvoyPLVEewHPYRlbY9LsP7cjd5b72h0zZ6EmV3LOSaExvv48xpxhUyex3cTqUmsqdvG/vugOEbm1FxRYGvmXdrDuuDgqkneWuLqhXeejuk21YgP6HiYfRbUcgBdMZgr1KDUcJnEyfg2QPpE8/prJMAELWeJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628904; c=relaxed/simple;
	bh=fT0LbGm9+/hby0q9BviM6A6J7qAM3LM3z4Ixer7b30M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MMspAWJFr+ulILqAuY3axq0Kdg/3B5n/G3Pjb1lBmY5uRIIxMnKv/iQaMOY3nZHNCK/MNl6vFHUQQk341rXPJeA/4w+EKJYudewHvLC9ZmQQF84p3Xq9rIoQJUpO83SolJpgw++F+0yzObnjZN38oFRrW+rrjRMRT2HxGOv78X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=uKa8tNjf; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3109487B6E;
	Fri, 19 Jan 2024 02:48:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705628898;
	bh=N1Q8Iuceg6/qwWYYNFcIV0u3VsiiTwpxdHKO563CKTY=;
	h=From:To:Cc:Subject:Date:From;
	b=uKa8tNjfqOF5JAsloF1tNLrusJkXZskIdqOzQfDg2peYvnSDu5xnIMl3Ur4nH09cF
	 Gtv5vT5kOYXgKz8xqMfUMMm8JMQcXG+K1fFZX0ZqJ1QP/2syNnb6OhQCCBr+Xpw0Qt
	 LI150dVClYDFn/cU3Bx3HoedQuZYplnb+pZ2bzF+iI0+QZ1qK2xyfV2VjlMZkmqiy1
	 IpucqEbnDXiFM94p4vimvYoanAguk0aREHgRD6nWpQqW3fJXiR3KA9zSXXwQmyhh+r
	 cofm3D+x9B/ZJSrpSKZfeSsZKBbyn/B7o/xyfwKJktBpNdLfpsod8wgMC9AVv5TGyc
	 qItRDsQigvYPg==
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
Subject: [PATCH v2] pmdomain: imx8m-blk-ctrl: imx8mp-blk-ctrl: Error out if domains are missing in DT
Date: Fri, 19 Jan 2024 02:47:41 +0100
Message-ID: <20240119014807.268694-1-marex@denx.de>
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
V2: Add extra check for domain being NULL (thanks Peng)
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c  | 9 ++++++---
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 1341a707f61bc..ca942d7929c2b 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -258,11 +258,14 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 
 		domain->power_dev =
 			dev_pm_domain_attach_by_name(dev, data->gpc_name);
-		if (IS_ERR(domain->power_dev)) {
-			dev_err_probe(dev, PTR_ERR(domain->power_dev),
+		if (IS_ERR_OR_NULL(domain->power_dev)) {
+			if (!domain->power_dev)
+				ret = -ENODEV;
+			else
+				ret = PTR_ERR(domain->power_dev);
+			dev_err_probe(dev, ret,
 				      "failed to attach power domain \"%s\"\n",
 				      data->gpc_name);
-			ret = PTR_ERR(domain->power_dev);
 			goto cleanup_pds;
 		}
 
diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index e3203eb6a0229..e488cf79b8007 100644
--- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
@@ -687,11 +687,14 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 
 		domain->power_dev =
 			dev_pm_domain_attach_by_name(dev, data->gpc_name);
-		if (IS_ERR(domain->power_dev)) {
-			dev_err_probe(dev, PTR_ERR(domain->power_dev),
+		if (IS_ERR_OR_NULL(domain->power_dev)) {
+			if (!domain->power_dev)
+				ret = -ENODEV;
+			else
+				ret = PTR_ERR(domain->power_dev);
+			dev_err_probe(dev, ret,
 				      "failed to attach power domain %s\n",
 				      data->gpc_name);
-			ret = PTR_ERR(domain->power_dev);
 			goto cleanup_pds;
 		}
 
-- 
2.43.0


