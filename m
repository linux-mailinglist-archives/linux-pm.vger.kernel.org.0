Return-Path: <linux-pm+bounces-39799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3BCCD71E0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C049430A9301
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8303032ED45;
	Mon, 22 Dec 2025 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cA1aT98U"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BBE320A01;
	Mon, 22 Dec 2025 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435856; cv=none; b=pf/mLB+ntf816V1hqoIbJBTKNgzhqaHvIJBAH6vwI2ZgFC95W4m8quFt3hRljSO+tgSiQR8f50zDG5RyMkda4oNTNBKpDBMX86nMJ1CIy96z4+zWPZFzbwVBYGHM05+e+wGRUN1v+v43eYCUGrhrBF9EpL+oPzPy6sIVBn3mZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435856; c=relaxed/simple;
	bh=s8U1CydswO0VHrV1/b5U9Cm0WygeIhxn3DiIa3asjrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwCx3hQgtYTryxKBaHb1OOeYpw3o+0JiUAC6/MzwH2zhw5peiicJmTyRunlC2TQOTlyGIUkFhBstvGObsYl2AAHYFoVXw2SEvs7BJMn2SCAwrPpFI7ZECS/3Kp1dGC1hVB8+v0BP9mAzu1iPdNT11RA293c0awEooYChsw9CjC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cA1aT98U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E86C16AAE;
	Mon, 22 Dec 2025 20:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435856;
	bh=s8U1CydswO0VHrV1/b5U9Cm0WygeIhxn3DiIa3asjrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cA1aT98UnLvjBoGeGqk0TzwvOfi2R8HiihJ9HLXfNvoU3NZ56e0+Tac+UBvIs21dN
	 4u6aoHzoucUh4wGOL3whtSqlAfzHmtxQ+BBgAYPihc6T3uC5Fs7yi9MlsObeu473GK
	 ZwHspH1/yDRJMxxK2tMDhGeu+ZJPg+ZggG+IHoHPfLpMx3s4D2jnJpxNsoFYaOO/41
	 AeujObkfnk1+qYBYjGBRAzODpUru8YM43Mh5vvKF9fSNWVUfxCsZZniOSMirLI/VTQ
	 NBIU6pHjbRa+4mvDRhWQfIwhFKqczcod+5Fab59nG5pjzilzS/7UW5X283uz05acZP
	 jxtgmAKKFF6dQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 linux-phy@lists.infradead.org, imx@lists.linux.dev
Subject:
 [PATCH v1 13/23] phy: freescale: Discard pm_runtime_put() return value
Date: Mon, 22 Dec 2025 21:18:46 +0100
Message-ID: <2012926.taCxCBeP46@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Printing error messages on pm_runtime_put() returning negative values
is not particularly useful.
 
Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.

Accordingly, update mixel_lvds_phy_reset() to simply discard the return
value of pm_runtime_put().

This will facilitate a planned change of the pm_runtime_put() return
type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is part of a series, but it doesn't depend on anything else
in that series.  The last patch in the series depends on it.

It can be applied by itself and if you decide to do so, please let me
know.

Otherwise, an ACK or equivalent will be appreciated, but also the lack
of specific criticism will be eventually regarded as consent.

---
 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
+++ b/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
@@ -286,11 +286,9 @@ static int mixel_lvds_phy_reset(struct d
 
 	regmap_write(priv->regmap, PHY_CTRL, CTRL_RESET_VAL);
 
-	ret = pm_runtime_put(dev);
-	if (ret < 0)
-		dev_err(dev, "failed to put PM runtime: %d\n", ret);
+	pm_runtime_put(dev);
 
-	return ret;
+	return 0;
 }
 
 static struct phy *mixel_lvds_phy_xlate(struct device *dev,




