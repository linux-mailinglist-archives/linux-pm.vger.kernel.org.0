Return-Path: <linux-pm+bounces-25670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFE8A924B0
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 19:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F9518935F1
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E351263C79;
	Thu, 17 Apr 2025 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="PiT8k22B"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A881262802;
	Thu, 17 Apr 2025 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912434; cv=none; b=s6aN0h4NGsNBfKmf744wwcvF/FRxb9VJcKUbqIxWvlzwV35hAdB3llIqnrNFZTwtN84gIQJ9KH8LsSVCXpoPg/5Q58De3UlbsGx8G+6o05xr6vHzxwd5fMDYHI0V8Pj32iSJJuZhUupdAHUdwX6IV9ynN0FbRQOIj/hj8+iG6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912434; c=relaxed/simple;
	bh=A3MMV+vmZjIoXu0GmJWHKWsCrLocFJbNSS2ruwYfoRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9U/gWRcmYXu1q6UFINR4fZqPeSCMMtM8lVH2k7aAAi3ttd78aAG1Bm0LcUl3Qgk7wFFwY53ox9wDIxoFtMrRp76YS4gLhkLOOCdA04VLYzy9whDbc2zPBa0wRDggQlxFjvyJUIz/vrO5yzqMY9RH72QJLza75nEdbkglufvZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=PiT8k22B; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 0026D2E08A29;
	Thu, 17 Apr 2025 20:53:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1744912430;
	bh=iATCUyRrvR0Ub0BIamsKc+GUsMtporebMAuhSglaFuM=; h=From:To:Subject;
	b=PiT8k22B3W8LIwSYgQk/E3Z89kgwiMcntTebJg05hNPL+Rv7XXsuwMQeBEFMQAqrq
	 5m2HIm0ZlcWNUOK2rHelMr29nlH8EGAVOh+yZHckye5umEpjbLn3DzNOtBPvzFk88c
	 CHK9MgADOKAvA6WpnvkSlRfhnvqRZZWk80S4GEgU=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>,
	linux-kernel@vger.kernel.org,
	sre@kernel.org,
	linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	mario.limonciello@amd.com,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v9 15/15] platform/x86: oxpec: Rename rval to ret in tt_toggle
Date: Thu, 17 Apr 2025 19:53:10 +0200
Message-ID: <20250417175310.3552671-16-lkml@antheas.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175310.3552671-1-lkml@antheas.dev>
References: <20250417175310.3552671-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174491243058.25694.1911444091932643740@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Rename the variable `rval` to `ret` in the function
to follow conventions.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index ce20bf70027df..93d4abf8c3b8a 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -409,19 +409,19 @@ static ssize_t tt_toggle_store(struct device *dev,
 			       size_t count)
 {
 	bool value;
-	int rval;
+	int ret;
 
-	rval = kstrtobool(buf, &value);
-	if (rval)
-		return rval;
+	ret = kstrtobool(buf, &value);
+	if (ret)
+		return ret;
 
 	if (value) {
-		rval = tt_toggle_enable();
+		ret = tt_toggle_enable();
 	} else {
-		rval = tt_toggle_disable();
+		ret = tt_toggle_disable();
 	}
-	if (rval)
-		return rval;
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.49.0


