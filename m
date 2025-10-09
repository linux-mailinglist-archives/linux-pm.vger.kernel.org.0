Return-Path: <linux-pm+bounces-35874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4A0BCA537
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 19:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C82A4E9007
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F91A233727;
	Thu,  9 Oct 2025 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="XlwYGDv0"
X-Original-To: linux-pm@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0402615E90;
	Thu,  9 Oct 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029577; cv=none; b=ApUzMyb2y9Aahlis/jg8BLxZuGLJ0MdtngzpN7evyYEsxfJO5BwB/ZvOHucL/PGZLfnkAjUIeKAtrubWPUkSfe7L1q6Ih1WarwXn4O5N8tCKiN1oN6LWXLCpj9SCZFzR0slK1wvrfDdFjnTPdi4/A7mclhgiFyFCC5lrZLLhlxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029577; c=relaxed/simple;
	bh=hwWKuQQt63jq6BhwlgzSw3pF4h8LHNwl+jIV4Hd4vEw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F0dPSUUNudpLXeDuf45bTEN94nJBbf8lUtelIRPMHsS/CQ41zjwZZWqWJ8JtxgfSql8E3WK1GTVDHziR6ZordULXIhr6cql3NqexWwglHB/8Vb+gfVpLCnqaitF5vOQCduIcXnWyzpLXv114uZEC2W3dDcvRHknkeDMO68VwP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=XlwYGDv0; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 0954AC0003;
	Thu,  9 Oct 2025 20:06:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 0954AC0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1760029571; bh=KMdQaChPFuH9o4VWi3mlJ40Whtlsb7iPE17jb8cpd7s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=XlwYGDv0LLqZmbFZVnjJ389MZkUyRu66zB7+7WGltZCM9BD8N7WgdrsRW55UW8kbK
	 VuFyc4uzj2LdzFMfrLBwe172ysaaksXcaqgTIxZ+cIhfmXrfXOVq/YAS0qq99KyLLP
	 AGlH4EIdYzRZMdfKqk2Y+kCVTQhwVRBzaCprQAU9IT8rdkM568kSOoH77xPeUTv+Z2
	 rAVeiJdQduSgW4Y4Cn1umA27FxXehr9aDKgUHMS6r0vBm6zdtlmO4NEevgp7dNYzzd
	 x2iIq//h2KmkWjXdDAkTD5FMT1jXheO/Gsd6M7XUE2CiV9Pe0WQfgEkffaxQe1vaCW
	 Zp/d7U/Pzi7kw==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Thu,  9 Oct 2025 20:06:10 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 9 Oct 2025 20:06:09 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Sebastian Reichel <sre@kernel.org>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Lee Jones <lee@kernel.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>, Charles Keepax
	<ckeepax@opensource.wolfsonmicro.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, <patches@opensource.cirrus.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 1/1] power: supply: wm831x: Check wm831x_set_bits() return value
Date: Thu, 9 Oct 2025 20:05:52 +0300
Message-ID: <20251009170553.566561-1-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 71 0.3.71 ee78c3da48e828d2b9b16d6d0b31328b8b240a3c, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.200.124.61:7.1.2;127.0.0.199:7.1.2;ksmg01.maxima.ru:7.1.1;mt-integration.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 196967 [Oct 09 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/09 15:41:00 #27896937
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

Since wm831x_set_bits() may return error, log failure and exit from
wm831x_usb_limit_change() in such case.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 626b6cd5f52e ("power: wm831x_power: Support USB charger current limit management")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 drivers/power/supply/wm831x_power.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/wm831x_power.c
index 6acdba7885ca..78fa0573ef25 100644
--- a/drivers/power/supply/wm831x_power.c
+++ b/drivers/power/supply/wm831x_power.c
@@ -144,6 +144,7 @@ static int wm831x_usb_limit_change(struct notifier_block *nb,
 							 struct wm831x_power,
 							 usb_notify);
 	unsigned int i, best;
+	int ret;
 
 	/* Find the highest supported limit */
 	best = 0;
@@ -156,8 +157,13 @@ static int wm831x_usb_limit_change(struct notifier_block *nb,
 	dev_dbg(wm831x_power->wm831x->dev,
 		"Limiting USB current to %umA", wm831x_usb_limits[best]);
 
-	wm831x_set_bits(wm831x_power->wm831x, WM831X_POWER_STATE,
-		        WM831X_USB_ILIM_MASK, best);
+	ret = wm831x_set_bits(wm831x_power->wm831x, WM831X_POWER_STATE,
+			      WM831X_USB_ILIM_MASK, best);
+	if (ret < 0) {
+		dev_err(wm831x_power->wm831x->dev,
+			"Failed to set USB current limit: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.39.5


