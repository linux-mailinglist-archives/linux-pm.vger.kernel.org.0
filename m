Return-Path: <linux-pm+bounces-40362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DACD8CFDBCF
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 13:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0622300766E
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C81F3271EB;
	Wed,  7 Jan 2026 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvcE4t4D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5E0326D63;
	Wed,  7 Jan 2026 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789454; cv=none; b=F/MujI5pIE4VUFASo98crM6kJM8P0+iMj/c2jMTbracHgevzrh3EDoHStP4QvrKshLtYKElnIENWmssDCPmYgMEQzV/J6xfh97Udn5QVqWse818MaC27W7u1z9p8NqmShwgwfkkG1FGevStsaoGzw0fINXzSaZHlLlH3TQ2JMds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789454; c=relaxed/simple;
	bh=6xFu74sl9nGZy1rZZA6R7vsAB4uUgBLTihnGzDjw50s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucCjPRUnJuEVHtaBG6x4LyoKNgVQwCwkmkCuaS1Cng0uve/wU+iZ1ueejiKCNtelPDE1N8PFLaJPTM3k0aSwYWtOb70VRhJgr6xCYZK8BkIpIW3h8+PCa0hDPlKC0CHUvEIL8qeDgKa7ugeKZzgN2CB6c2txrfdNpEH21BXo7O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvcE4t4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B156C4CEF7;
	Wed,  7 Jan 2026 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767789453;
	bh=6xFu74sl9nGZy1rZZA6R7vsAB4uUgBLTihnGzDjw50s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvcE4t4Dmj+WFkI6WPqMRGjxqsIKzgrFDeVtcwzTj398S9SmKd3lLEoLmKSn8pny8
	 XRYfd+/lil4C5R4+Eh0D2uP9FYDn72cfUR1xAANnT5ZDZ5tyhxTkWqSMxbjc6k2cMz
	 ILPelqgNLALvaGrK91iTQX5RVAm4E4N6RDpXxavxnfUecyPsmTaD1e8Grh5Q57GGex
	 F8widKtLglAQ2rM+HevVtGLnQ8qmSs0A4cwiMmPkzhvGK5h98qAVmRO6cEX9MACs5L
	 qbMlE+bMblXrrTXG6MtSu9N4lrD+STUzniMyQ2WWpHqM4kA/DeHy6fuuagsz/d/qWS
	 TTYRiAYLDGLSw==
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
 [RESEND][PATCH v2 3/3] net: wan: framer: Discard pm_runtime_put() return
 values
Date: Wed, 07 Jan 2026 13:37:17 +0100
Message-ID: <3027916.e9J7NaK4W3@rafael.j.wysocki>
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

v1 -> v2:
   * Do not remove the pm_runtime_enabled() check from framer_pm_runtime_put()
     so that it also works when runtime PM is disabled.

---
 drivers/net/wan/framer/framer-core.c | 6 +++---
 include/linux/framer/framer.h        | 5 ++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wan/framer/framer-core.c b/drivers/net/wan/framer/framer-core.c
index 58f5143359df..bf7ac7dd2804 100644
--- a/drivers/net/wan/framer/framer-core.c
+++ b/drivers/net/wan/framer/framer-core.c
@@ -60,12 +60,12 @@ int framer_pm_runtime_get_sync(struct framer *framer)
 }
 EXPORT_SYMBOL_GPL(framer_pm_runtime_get_sync);
 
-int framer_pm_runtime_put(struct framer *framer)
+void framer_pm_runtime_put(struct framer *framer)
 {
 	if (!pm_runtime_enabled(&framer->dev))
-		return -EOPNOTSUPP;
+		return;
 
-	return pm_runtime_put(&framer->dev);
+	pm_runtime_put(&framer->dev);
 }
 EXPORT_SYMBOL_GPL(framer_pm_runtime_put);
 
diff --git a/include/linux/framer/framer.h b/include/linux/framer/framer.h
index 2b85fe9e7f9a..b1e575665fc5 100644
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
@@ -124,9 +124,8 @@ static inline int framer_pm_runtime_get_sync(struct framer *framer)
 	return -ENOSYS;
 }
 
-static inline int framer_pm_runtime_put(struct framer *framer)
+static inline void framer_pm_runtime_put(struct framer *framer)
 {
-	return -ENOSYS;
 }
 
 static inline int framer_pm_runtime_put_sync(struct framer *framer)
-- 
2.51.0





