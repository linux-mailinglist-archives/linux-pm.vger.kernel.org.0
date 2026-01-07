Return-Path: <linux-pm+bounces-40363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 568EBCFDC35
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 13:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50A4130E505D
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 12:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27A9328B58;
	Wed,  7 Jan 2026 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG4AcyXA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95256328B43;
	Wed,  7 Jan 2026 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789460; cv=none; b=OnNKRHWeuVYS+vd+Mk2FhC01RJts0WW4IbI417EDKCezzuNPKQPqc//VB8mMUH/FqcLcIbLnhZ+vznMi7noka9JM4LHYyS4HCzeueOqL3YdZz8/u+G9o+nNE57DV+MT5ELfJd3Ji68Q+/XOXKXIPkMiGgKq8gzUYf+IW4eXU/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789460; c=relaxed/simple;
	bh=0fdwo4lgufSfE9d3Q035mLW/81LeqImK6RZ94JeFmaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgXOuiUA9wyZWGwr6ujRopSyG7Gf/gNjVszMdXFPvk3xxaxXkPZv6fjUzULvv65A68qtML+ffu5JCxO6rnlL3TBNudDwvA8fyR+faVotNY1+V/XV8cdlu+tWfgsEMtsJ4LCeG5MCr4JathPaYKwbUzluLOCNqEMi/ooSqas+tQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG4AcyXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A249C4CEF7;
	Wed,  7 Jan 2026 12:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767789460;
	bh=0fdwo4lgufSfE9d3Q035mLW/81LeqImK6RZ94JeFmaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FG4AcyXA+6wZPSqy0OGwlMeMosAAYloIEzCYYBCpSwwiN9WTI6Ekv0miPFAGYNLE8
	 tr+hv12ShS2Wp+ssN4C/hO42kRpb9D+ftpX4wOrgYF1ntW226WSI7cPJl7aRBCl6u1
	 1J6uPaSKQlCVe5lGwp1djOU884q938Juq4jMxQFk2UZC+53f2qMc6YwkMcuyaxeSSQ
	 Y955ol0vshqAgiY5XzeNXvjSQIB9kvC2E4UbD4lupsBPOcefDCm0QjarFimoRp4iau
	 KWIgiQF5JXeTSUArgZaPZ5C1hIk4mQ1hUzCFls9qiWMTD74s16CE8G+BCacVKsnjdW
	 k1Lsu/pdKWglg==
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
 [RESEND][PATCH v2 2/3] net: cadence: macb: Discard pm_runtime_put() return
 value
Date: Wed, 07 Jan 2026 13:35:58 +0100
Message-ID: <2252292.irdbgypaU6@rafael.j.wysocki>
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

v1 -> v2: Added Acked-by from Nicolas

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





