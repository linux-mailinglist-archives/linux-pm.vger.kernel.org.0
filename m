Return-Path: <linux-pm+bounces-22739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677F2A40B85
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 21:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5110A166E81
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 20:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA0220013E;
	Sat, 22 Feb 2025 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="Ph4CAjkV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F591EEA43;
	Sat, 22 Feb 2025 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740254573; cv=none; b=r7vANk9zHta6figvjL2FcgQeLEht2usfXg8ix/1I3uDVISkwLacdsYIzaxbkkV6EEZTmywgEE47R/HU1fE3mQBJoePai7uj4DTC8l4oTUNUGhMO298erNyvvT70Z+QrIMAT8kdFDVLCSiKLTKlVVlEaQ8F95U0p9oniCA35coMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740254573; c=relaxed/simple;
	bh=1ysXJ9tNqbTNnC5MOSLRwjUBTc9Nx5MfsWwXFqejhwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JVj91VDU06gXpqcJWfwXbBp3jd1Bosy/Kd0ziURaeD2aOjHtYS+Uu9iP1zFMxkliViLSQCxUyjo9g1I5aXFr+GBBZnGEH17/tjKrMv5jO/fPFlfXkxLFNoof80qnKZ1gfDvWiTZ3F8r8cV/Wdhd6gSGct72eqcDa4jD+DeoXLhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=Ph4CAjkV; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z0dFz1w3Zz9t1g;
	Sat, 22 Feb 2025 21:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740254567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z6djf3boNN959313q2ECyr8yAQbh1eNxQmRkyyOk0VU=;
	b=Ph4CAjkV2ku4zIUUVJ93F6Rk2zWDvDGXMfwgZSgQxikk3uZ/N1ZeuYD/txQK+F+XihyTqn
	DJAOkqG7WjFjD3fedGfCn/x45DDMyJ2T2852uMukJ4HITLn+qGzAuo9PP/JZA0WztDdub7
	0ihldMq4ihrL4SBGqXyWM6PZgRlZWsLjuM3z3Cw3t4ud232skCEH7bOQ0YAxMhnJP3XKWz
	mVzGqpq9Zmh2cmk8S/A5wU9e46AEpra7peKnc+41sDBUdZP6bNe6LS7/zjlH59EoKivysj
	xVwStx+UesTGcJIbs2+oCE8W9pXFb8oi8Sjx57mrzHn0pgB25QxmQtnAhtAdvg==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sat, 22 Feb 2025 15:02:42 -0500
Subject: [PATCH] thermal/debugfs: replace kzalloc() with kcalloc() in
 thermal_debug_tz_add()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-thermal_kcalloc-v1-1-9f7a747fbed7@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAGEtumcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMj3ZKM1KLcxJz47OTEnJz8ZF0LC8OU5DTTJHPzJAsloK6CotS0zAq
 widGxtbUAOmYgfGEAAAA=
X-Change-ID: 20250222-thermal_kcalloc-881dcf5b77b8
To: Markus Elfring <Markus.Elfring@web.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=1ysXJ9tNqbTNnC5MOSLRwjUBTc9Nx5MfsWwXFqejhwo=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBPL1NUWlpJbS9QMWJkeVV2V1gzRys0cXJ6clBNM1dUCnVqS24rUVRuRnVGWFVuZWNI
 Ny9yS0dWaEVPTmlrQlZUWlBtZm81ejJVSE9Hd3M2L0xrMHdjMWlaUUlZd2NIRUsKd0VTK0JESXk
 vTmJjRWI3UzJYaXU2SlRTeFFZT0UvTW5UdGs0Ujd3My9JL1BjcWF5Qm8vcmF4ais2WVhNYXJ4eA
 p1MDN2K0pQSDRVY3Rpcjh6NTM3emNOMWZ3eTgvUTdrcjNvR0pFd0JwaTB2cQo9azhudAotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

We are trying to get rid of all multiplications from allocation
functions to prevent integer overflows[1]. Here the multiplication is
obviously safe, but using kcalloc() is more appropriate and improves
readability. This patch has no effect on runtime behavior.

Link: https://github.com/KSPP/linux/issues/162 [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/thermal/thermal_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
index c800504c3cfe0ea3b4a51286f348dd5802e1898f..60ee6c366998e26447a0b985112f578ba8757f17 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -876,7 +876,7 @@ void thermal_debug_tz_add(struct thermal_zone_device *tz)
 
 	tz_dbg->tz = tz;
 
-	tz_dbg->trips_crossed = kzalloc(sizeof(int) * tz->num_trips, GFP_KERNEL);
+	tz_dbg->trips_crossed = kcalloc(tz->num_trips, sizeof(int), GFP_KERNEL);
 	if (!tz_dbg->trips_crossed) {
 		thermal_debugfs_remove_id(thermal_dbg);
 		return;

---
base-commit: 5cf80612d3f72c46ad53ef5042b4c609c393122f
change-id: 20250222-thermal_kcalloc-881dcf5b77b8

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


