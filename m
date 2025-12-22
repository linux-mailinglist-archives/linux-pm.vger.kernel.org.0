Return-Path: <linux-pm+bounces-39800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D28CD71E3
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAD633030DA5
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534F4319855;
	Mon, 22 Dec 2025 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH6k0Rhy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B5D333448;
	Mon, 22 Dec 2025 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435860; cv=none; b=Lr/+gio01fRXoHiaU2mubiuNUMfhzFwv3VEHI8xMU9tge+8pRZIBc4mSUVdLw0F+AEPZTpuAWG5cKlA0w9B0nSN2UMZGQm5QXmJ+CcXtBS38vqMGEyWCx/wjQHLBfY3csoKZG4mDa5Ize5s/XraQTx74IB6+L9d53PyaZGdXZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435860; c=relaxed/simple;
	bh=Z3YqJU+/AbvXAZpk1oF3ErI9aIcJYnfF7je/Cge7iag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWXj6F7jbDA8pX/fgVhDSv0YFnLt627sDA70Q+t+fp78tn3098sGBLaK7eMZJWiG1ty+cDhbTlepIHjEwS2gfQ2twpBGLj9gjg82VkuEu4hSIBTjRHG0dXNqRioyJFaXrdLc3oui2j1MdLvD7x5BdgtRsZkxNBFetRfUGY06kVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH6k0Rhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FDDC116D0;
	Mon, 22 Dec 2025 20:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435859;
	bh=Z3YqJU+/AbvXAZpk1oF3ErI9aIcJYnfF7je/Cge7iag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pH6k0RhyDI/IH8EhEwwrKisNuFtOn8I0mR8dDolJ4q4qkE+fRroNRBEfLS7ncTn50
	 EC70zsV9flZlKhU4jHE/CzST+KHZdyB1mQ1j5KGEKLzOFGjrrMKOrsRLq+kXBs7kXr
	 1/O/S7kV2+MSXf93jyBLu+W1m72g1skfqi2KuUCSEhqjf13MLQ4JbiIGsrKkG4W5V5
	 B4Jvfb+YqXbGk95UJnhOPH6I4XgDAL3x1Xx/My/Cj7xfPP2N9C5PcAHmFSunaJd52Z
	 vP7dQpuXbFBFXY67Er36DrOhIw8iYnwNYB91pDGy/YP8SSJeX7t2Hl4txKl0ILpI5i
	 finfi/K1th6vQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject:
 [PATCH v1 12/23] net: wan: framer: Discard pm_runtime_put() return values
Date: Mon, 22 Dec 2025 21:16:29 +0100
Message-ID: <2279041.Mh6RI2rZIc@rafael.j.wysocki>
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

The framer driver defines framer_pm_runtime_put() to return an int,
but that return value is never used.  It also passes the return value
of pm_runtime_put() to the caller which is not very useful.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.

Modify phy_pm_runtime_put() to discard the pm_runtime_put() return
value and change its return type to void.

No intentional functional impact.

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
 drivers/net/wan/framer/framer-core.c |    7 ++-----
 include/linux/framer/framer.h        |    5 ++---
 2 files changed, 4 insertions(+), 8 deletions(-)

--- a/drivers/net/wan/framer/framer-core.c
+++ b/drivers/net/wan/framer/framer-core.c
@@ -60,12 +60,9 @@ int framer_pm_runtime_get_sync(struct fr
 }
 EXPORT_SYMBOL_GPL(framer_pm_runtime_get_sync);
 
-int framer_pm_runtime_put(struct framer *framer)
+void framer_pm_runtime_put(struct framer *framer)
 {
-	if (!pm_runtime_enabled(&framer->dev))
-		return -EOPNOTSUPP;
-
-	return pm_runtime_put(&framer->dev);
+	pm_runtime_put(&framer->dev);
 }
 EXPORT_SYMBOL_GPL(framer_pm_runtime_put);
 
--- a/include/linux/framer/framer.h
+++ b/include/linux/framer/framer.h
@@ -96,7 +96,7 @@ struct framer {
 #if IS_ENABLED(CONFIG_GENERIC_FRAMER)
 int framer_pm_runtime_get(struct framer *framer);
 int framer_pm_runtime_get_sync(struct framer *framer);
-int framer_pm_runtime_put(struct framer *framer);
+void framer_pm_runtime_put(struct framer *framer);
 int framer_pm_runtime_put_sync(struct framer *framer);
 int framer_init(struct framer *framer);
 int framer_exit(struct framer *framer);
@@ -124,9 +124,8 @@ static inline int framer_pm_runtime_get_
 	return -ENOSYS;
 }
 
-static inline int framer_pm_runtime_put(struct framer *framer)
+static inline void framer_pm_runtime_put(struct framer *framer)
 {
-	return -ENOSYS;
 }
 
 static inline int framer_pm_runtime_put_sync(struct framer *framer)




