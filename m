Return-Path: <linux-pm+bounces-40364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 654C3CFDBA2
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 13:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DCC030021D9
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B3C32939F;
	Wed,  7 Jan 2026 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlNR8W/3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19373329395;
	Wed,  7 Jan 2026 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789467; cv=none; b=Vb6MXsHRbA9YGXQBRYrZX0RONznh8upf+d2HGGKk/DSqFzVRiitt6CvBSRwddMJdz9uPTNKUCCXRBhRSICpE0Pao8n//Impvcyqlm9nCJ9TuLCfohi5J5hxniGCixfjiYk+8jdhuFUn67B5iN7yTObp1Fy71pMfXm0/K/Y1Gdxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789467; c=relaxed/simple;
	bh=3rZ3aSqDtIQegdbz0UiHC1dGQWKjQrUwSTJAJTSwECw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIa/NI7XWopupXxye9ONlvve/idJ3Vld4yIFlnkNREsM07PzYw614A1+E85oZSjUF9QNYmutwD5fu1Vpa99hUprSXf7Y0cUePe5wRlKzdmShGxk6Jvb5Yl5VQn67RNFL5NcWh+Qz7bu39eJ7dFAQWrynKGpMvExAz/UD1OZC09U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlNR8W/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCEEC4CEF7;
	Wed,  7 Jan 2026 12:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767789466;
	bh=3rZ3aSqDtIQegdbz0UiHC1dGQWKjQrUwSTJAJTSwECw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlNR8W/3AVrpb8ASe87LFsEhWBoubhWmsxr04CZtHK2Vg/IJeTgzKtZ9um+fFfeOw
	 bC+4X8FByJwNz2HWfmM8ZWqG51v0/GFeJvs5wFGx/28O7ph2qKD2qDeFb2hPWOH2r2
	 sdaOmpJ7fmn+FlBYWkRJIMbaCtYB2R/wVSUTCqMF4CBdAS6260wEmyEmf4hkB/Tni4
	 nAlqEMERywSjxxDxJV24W7fgUuxfIfCH7Mm4+52hFsL5qpdCfQXcgS0xw2QixEU9uQ
	 s5vNMkcwVI4Ap9y+U/U8eZd1EuQypeASpJ1zO25uJoLNmFH9v8S/KU+p8d2T2ohxye
	 GDKdLbUAkRb2Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, netdev@vger.kernel.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Simon Horman <horms@kernel.org>
Subject:
 [RESEND][PATCH v2 1/3] net: ethernet: ti: am65-cpsw: Discard pm_runtime_put()
 return value
Date: Wed, 07 Jan 2026 13:34:02 +0100
Message-ID: <5042490.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2816529.mvXUDI8C0e@rafael.j.wysocki>
References:
 <6245770.lOV4Wx5bFT@rafael.j.wysocki> <2816529.mvXUDI8C0e@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Printing error messages on pm_runtime_put() returning negative values
is not particularly useful.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.

Accordingly, update am65_cpsw_ethtool_op_begin() and cpsw_ethtool_op_begin()
to simply discard the return value of pm_runtime_put().

This will facilitate a planned change of the pm_runtime_put() return
type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 5 +----
 drivers/net/ethernet/ti/cpsw_ethtool.c      | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index c57497074ae6..98d60da7cc3b 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -391,11 +391,8 @@ static int am65_cpsw_ethtool_op_begin(struct net_device *ndev)
 static void am65_cpsw_ethtool_op_complete(struct net_device *ndev)
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
-	int ret;
 
-	ret = pm_runtime_put(common->dev);
-	if (ret < 0 && ret != -EBUSY)
-		dev_err(common->dev, "ethtool complete failed %d\n", ret);
+	pm_runtime_put(common->dev);
 }
 
 static void am65_cpsw_get_drvinfo(struct net_device *ndev,
diff --git a/drivers/net/ethernet/ti/cpsw_ethtool.c b/drivers/net/ethernet/ti/cpsw_ethtool.c
index bdc4db0d169c..a43f75ee269e 100644
--- a/drivers/net/ethernet/ti/cpsw_ethtool.c
+++ b/drivers/net/ethernet/ti/cpsw_ethtool.c
@@ -374,11 +374,8 @@ int cpsw_ethtool_op_begin(struct net_device *ndev)
 void cpsw_ethtool_op_complete(struct net_device *ndev)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
-	int ret;
 
-	ret = pm_runtime_put(priv->cpsw->dev);
-	if (ret < 0)
-		cpsw_err(priv, drv, "ethtool complete failed %d\n", ret);
+	pm_runtime_put(priv->cpsw->dev);
 }
 
 void cpsw_get_channels(struct net_device *ndev, struct ethtool_channels *ch)
-- 
2.51.0





