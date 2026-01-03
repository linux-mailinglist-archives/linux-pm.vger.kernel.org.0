Return-Path: <linux-pm+bounces-40160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C97CF0659
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 22:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E3E33017EF5
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jan 2026 21:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAED2BE641;
	Sat,  3 Jan 2026 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVMKjYjn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCB92BD5BB;
	Sat,  3 Jan 2026 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767475839; cv=none; b=I2XDvf69oxYt9zjgQEUv9m3eHeJi+UrJmUFktNYozm2dGI/Z6dFVqOUuhgPNAVqroLAne86DJK8Go69AnYTHF9Vd2jJ2PXiv7pvW13Stt8GWXnmYYVKExhehSIqxz17NcOVNTz44zkIjOWo/AmPxlWd0cXwmCanf9XglI/GrULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767475839; c=relaxed/simple;
	bh=RdMrwkj1/LVLzZQ1mNYG0blbk9JnJX6Fb7sg+cv1Ktw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlRV7TKorl01F59pQzaxc7i4L9yhjsaTCbGCXsvASkQ0qt8jj1tFJK1WfuNq3Y7Z7Lo/PwVCyX+BUu6qkIaW/rDlSJTXPWJ2EsyxfYxjnovyCoNNGzNXoxesU2Vf4+LRB90gtDplUrItUgeOoQwQjinibXaOjo35NIPQ8lEtu/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVMKjYjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10BEC19421;
	Sat,  3 Jan 2026 21:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767475838;
	bh=RdMrwkj1/LVLzZQ1mNYG0blbk9JnJX6Fb7sg+cv1Ktw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QVMKjYjn19LXZHWZQJ4RwfxxDWdgBHnTdNK+pmwqm5LU0xWM9TTnhzLY1r8dtB97P
	 MLkaygPIchd+AK1LVGdPhX9z2wlzRU1W9JXNP437YmZ2tA3OeMXXCcoLzhjH2peFnV
	 5Ev3B0rUi7CKYn0/rveNU+697QakBAsvg3ey70lZfNS5Em5ObskqmDJBgkSf9F/9qn
	 IFs1C45j2Gg0aZlT/GOon75MGmhM0duXYr+XbxmuuEPDdgPNgbHNAkWDeaujsvdGHO
	 Ps5HBHCDNTtlyRLVDG7WNzmx/BL/o0MoEpVwbwClvLZ2pu9EqocUHsBQD+uCyLPGbB
	 3XipSDLHlpl/A==
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
 [PATCH v2 2/3] net: cadence: macb: Discard pm_runtime_put() return value
Date: Sat, 03 Jan 2026 22:27:06 +0100
Message-ID: <1962143.tdWV9SEqCh@rafael.j.wysocki>
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

Passing pm_runtime_put() return value to the callers is not particularly
useful.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.  It also happens when the kernel is
configured with CONFIG_PM unset.

Accordingly, update at91ether_close() to simply discard the return
value of pm_runtime_put() and always return success to the caller.

This will facilitate a planned change of the pm_runtime_put() return
type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---

v1 -> v2: Added Acked-by from Nicolas.

---
 drivers/net/ethernet/cadence/macb_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e461f5072884..1079613953bc 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4810,7 +4810,9 @@ static int at91ether_close(struct net_device *dev)
 
 	at91ether_stop(lp);
 
-	return pm_runtime_put(&lp->pdev->dev);
+	pm_runtime_put(&lp->pdev->dev);
+
+	return 0;
 }
 
 /* Transmit packet */
-- 
2.51.0





