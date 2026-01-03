Return-Path: <linux-pm+bounces-40161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3905FCF065C
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 22:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BAEA303022D
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jan 2026 21:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3662BD5B2;
	Sat,  3 Jan 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEX7UrtM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48DA231845;
	Sat,  3 Jan 2026 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767475845; cv=none; b=S9jW2gtvM73z+hV4eN8CGxlWiINVwiVpKYd0ihrPegzY0wALqkQxcdh2/l9e8MFmVq0xkHtfTPakOiwlt8jzVIFA8AM12Kd1+l4z/gMUsYY7v/kd99FcJXXNgCYuIyumV3xMavR5CJFUUTfnLB5at/RS37vbRUVLSIJ6BCFdJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767475845; c=relaxed/simple;
	bh=3rZ3aSqDtIQegdbz0UiHC1dGQWKjQrUwSTJAJTSwECw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmr0tzf0WJ/G4bCnsR7uE9U/eaIBeBUCYm7Yf/douE7T0DyLxnUsOllg3LMVtAy7JZ/NZCAIlQiZGFjtVnZrVl9KSduCYIw25HS364pSEdRIgbcmKyhCscQxeOXinAq5JH03LXDZGHLgFtgwS/opA4lA1IH79Zu1DyR1dzCTfoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEX7UrtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B6CC113D0;
	Sat,  3 Jan 2026 21:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767475844;
	bh=3rZ3aSqDtIQegdbz0UiHC1dGQWKjQrUwSTJAJTSwECw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEX7UrtMXe4xwRAH5QmRO6MbWMozMmOeZmhMkUV73Mnk70AZX5HaxdbAXtHAvgLRn
	 Q+VpSq9UTuTG+q7aZWGQI2kSv3YJz4vTFqWnLABC6hQSy40gDxPdJ0c30G/7hRy78B
	 TsUb703jk3/pSz46sr8sbzCtHJCzgmh8/DK/fSQxciee477MtfjKPgONcRtyLat6FI
	 fnlHIg2nw8JGuk+5bgVur5pcKO58wOH4yaxF0MlokgjKDmGMiCT7GDEXsNwW+op/y/
	 NN5OqXFW8EB1/RiCJXrQKOvZ0kssFEPiVdZavBp9W88BIyspHa+kieYGfNOASjPOXT
	 rHO90OmfUyUDQ==
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
 [PATCH v2 1/3] net: ethernet: ti: am65-cpsw: Discard pm_runtime_put() return
 value
Date: Sat, 03 Jan 2026 22:26:24 +0100
Message-ID: <5057537.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5973090.DvuYhMxLoT@rafael.j.wysocki>
References:
 <6245770.lOV4Wx5bFT@rafael.j.wysocki> <5973090.DvuYhMxLoT@rafael.j.wysocki>
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





