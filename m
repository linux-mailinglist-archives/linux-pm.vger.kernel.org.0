Return-Path: <linux-pm+bounces-40159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1BFCF0647
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 22:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E1D7300FA3A
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jan 2026 21:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CB42222D8;
	Sat,  3 Jan 2026 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccEXikHR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF2C18AFD;
	Sat,  3 Jan 2026 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767475833; cv=none; b=s+2tCXZX3S8cAy8EO6Uu+i68dF8ViE60bxm0ZoF5BvV+8XCq6WrtuL2nY6+m3aT89Kv+P85czN+nUKRf0Iq9fA1AhMV+ql3rgiN0SiiSzYVLTjqadGy/wpoyaDLbaTjsjMM7KO5DrMZ4Hp8u3V+SoKHO+M+5jg0Q4S88oaJde10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767475833; c=relaxed/simple;
	bh=6xFu74sl9nGZy1rZZA6R7vsAB4uUgBLTihnGzDjw50s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpzAnPWgum3TIcZ9Ece2VvKRU5dhtGQEq+vw2/wzO28+D3nRELJWto3KJA1kNW025g+QNTw/3aC2IOJYx13HuVRDpcesCmFhUIlw01A2HsfnULbxP3uA54+TQfm7Ij67bRSk2QLepYz+0bD0DnQwMBZJo3ATzOvEqthQ6HdkvgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccEXikHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B920C113D0;
	Sat,  3 Jan 2026 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767475832;
	bh=6xFu74sl9nGZy1rZZA6R7vsAB4uUgBLTihnGzDjw50s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccEXikHRXJ+SYkYjJLsCvsmmHRdaKN0P3hNupCpHArB1S0jz0yU2g2Chm1Yq7cpMD
	 7llBJYUeCY+oYB1/g8GJHcdlsa3WS/P9b8FneppUBaHLWPuD5YOpcwPKCWoq8Oc5gy
	 b2fEKoyoZgQhMKzSD+snoJ+ond5dbB/ODmXRb5an0CwMQwvTdpUsLoYkFGRuBKswn4
	 +QusgGxdFggTJsP8cxo5VhnvDhcq5a7+o8ts7RExouwqPyiF6NZel0qVqmxAW1aAP/
	 IgQdMCej7iyrdFazCom/L5fTP/GIIeO9LBuqQKYszhTPrP30svpGTqgLYz0FmSg6pk
	 d0Am0SOTqimog==
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
 [PATCH v2 3/3] net: wan: framer: Discard pm_runtime_put() return values
Date: Sat, 03 Jan 2026 22:29:10 +0100
Message-ID: <13939126.uLZWGnKmhe@rafael.j.wysocki>
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





