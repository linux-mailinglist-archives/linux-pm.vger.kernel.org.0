Return-Path: <linux-pm+bounces-39802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAFECD723A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DA8B3027E38
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E4133FE26;
	Mon, 22 Dec 2025 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkSiwkeN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F132833FE08;
	Mon, 22 Dec 2025 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435868; cv=none; b=CV+MfgxfMkVPB8pYXw1/q8oUbD0TZSfDwapFtE6jFsccWfUNjOjDoOmZfRkd35jlpRBAUm8uhLmaLO3x40mBZNeRjasNvZ4iqQa5sv6h/EEzFdbAtBWLm4wKpaTrT0jGXUlWDUiQGXOZjoFis7GWyQHX+OMc3LIUCj55w8WfzbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435868; c=relaxed/simple;
	bh=M3n/TDkey/QlyxKHfVbIIRj+b5l8o9KrKfVk2WzbzE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsB062d7ISkUtzZUJHCLC6kLPI1g+Xhmug41e85FNrhWoYRTltCp9HjOSb+5r/EBWpPzvh1F9wunW4PCz8iVYgMwJzLjINNw6cMhQV09wkInEjC/d7nlU7zMCsZk6Oe3AHxQGpvdnEHhmroB6sTWZihYj9JFqtVe8e5iU8/yf4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkSiwkeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1365C4CEF1;
	Mon, 22 Dec 2025 20:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435867;
	bh=M3n/TDkey/QlyxKHfVbIIRj+b5l8o9KrKfVk2WzbzE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KkSiwkeNZ5/5bz5nZTrZWSSaA8s0bHhW9NQQ/suAUjS7eiUV5xvsT94TUPNmK9QDI
	 kXfatPbMQBzxwdSVdyM1Qoba+EH3TFpztMdaOemwFCpn6Y6f9GaAcPAQJX7h8yFZGc
	 f0sJzs5aGZK0+dxXMfWB240cWRnmPvW+ygbV+GagQst6weYtvQGcTRaWdUUgpuEOeB
	 d5LzjJgC6tlsPuvcMFDD3ejPXm4aRKIKu8CCn7mT/4BkyLJppcAP/mEURMmXHfo3GD
	 XEXhsPH8iGaeMyi9/R9xPjw8FDPzfM9irL+yiyi3xh974PwkPElPE12jP8SNCSfEX7
	 XurIixMLBz/9A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 netdev@vger.kernel.org
Subject:
 [PATCH v1 10/23] net: ethernet: ti: am65-cpsw: Discard pm_runtime_put()
 return value
Date: Mon, 22 Dec 2025 21:11:42 +0100
Message-ID: <3608967.QJadu78ljV@rafael.j.wysocki>
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

Accordingly, update am65_cpsw_ethtool_op_begin() and cpsw_ethtool_op_begin()
to simply discard the return value of pm_runtime_put().

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
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c |    5 +----
 drivers/net/ethernet/ti/cpsw_ethtool.c      |    5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -391,11 +391,8 @@ static int am65_cpsw_ethtool_op_begin(st
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
--- a/drivers/net/ethernet/ti/cpsw_ethtool.c
+++ b/drivers/net/ethernet/ti/cpsw_ethtool.c
@@ -374,11 +374,8 @@ int cpsw_ethtool_op_begin(struct net_dev
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




