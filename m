Return-Path: <linux-pm+bounces-35805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69DFBC4BDF
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 14:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22373B33F8
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DA21FAC4B;
	Wed,  8 Oct 2025 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="s6hmmsF+"
X-Original-To: linux-pm@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A671F3B8A;
	Wed,  8 Oct 2025 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925809; cv=none; b=HGA9HY3999YtsQJmMAXr+oDxXtkYPGNDIofyWZJ1PVWefcsc+SCgHgfNf1ox1UfeCtW/FUJbydS+Vo97UrV8ppIxtgoZUei3rq3XusDGbq0uKgC18XXkZ2oLGMPHCeEXw4BFTQdr5bVZ9Yz0rwSqr7Y5xyt7Pr/b/8iiWGj0Jy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925809; c=relaxed/simple;
	bh=JUaMixl2/3amEsk7Eppmq2pN7k2TpyMAl32N1KjHYFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f4HZIx6O3+OFEy7VquxE1pa35wVqDGO2WV9fVwzlRFnh0lJYNDZCoVf+7uBt6ktPyJjebXMzhT/oQuVFoMe6EZavgkZ+6YDuSO0uDvTQMk7AYIU4XogcorIsIA2PstXEB8LsOE+NrB/HdhjAPeAnfIcu4mZfj9VGmKA9rV6/EJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=s6hmmsF+; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 5BB89C0018;
	Wed,  8 Oct 2025 15:07:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 5BB89C0018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1759925244; bh=C1IATWPM3mN9XKTAyH6DunLeD4/BZFtcmHgpuBRdGpc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=s6hmmsF+sZfZohnOA8X7+qqFcMOM2ryFcUWOXEV1PQF+X2BfFC76VPG+2bOzQQ3Cg
	 IBnNfhBqtpGOHhJ/fraHuJoNOXklnmLkZ6qO0zpWtxSNDXnIVO/pMbUQiLGnaNma4p
	 eDdlPvZZ5cAjOnAhwKHm+EA4MLSESGDt5hj5uTJgDsC0aqoSXL2a82wrI2MO6m1AiV
	 zCGRDgABvQTvKdYlTAKKkADGH4LHzAjnCH2EMftffAvxUHRWF568qYYr1jqa6+L3ja
	 9Ycork/pa6cW//s4WXhB7d5CUIVPx1BPAR8gYjhqkxdCEGnpWFaUb/YOi/uGhRxG+n
	 iYkpgB/JcLFWQ==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Wed,  8 Oct 2025 15:07:24 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Oct 2025 15:07:22 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Tobias Schrammm <t.schramm@manjaro.org>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Sebastian Reichel
	<sre@kernel.org>, Zheyu Ma <zheyuma97@gmail.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 1/1] power: supply: cw2015: Check devm_delayed_work_autocancel() return code
Date: Wed, 8 Oct 2025 15:07:11 +0300
Message-ID: <20251008120711.556021-1-i.abramov@mt-integration.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 69 0.3.69 3c9ee7b2dda8a12f0d3dc9d3a59fa717913bd018, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, mt-integration.ru:7.1.1;127.0.0.199:7.1.2;81.200.124.61:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg01.maxima.ru:7.1.1, {Macro_SMTPFROM_NOT_MATCHES_SMTP}, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 196899 [Oct 08 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/08 08:37:00 #27892411
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

Since devm_delayed_work_autocancel() may fail, add return code check and
exit cw_bat_probe() on error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0cb172a4918e ("power: supply: cw2015: Use device managed API to simplify the code")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 drivers/power/supply/cw2015_battery.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 2263d5d3448f..0806abea2372 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -699,7 +699,13 @@ static int cw_bat_probe(struct i2c_client *client)
 	if (!cw_bat->battery_workqueue)
 		return -ENOMEM;
 
-	devm_delayed_work_autocancel(&client->dev, &cw_bat->battery_delay_work, cw_bat_work);
+	ret = devm_delayed_work_autocancel(&client->dev, &cw_bat->battery_delay_work, cw_bat_work);
+	if (ret) {
+		dev_err_probe(&client->dev, ret,
+			"Failed to register delayed work\n");
+		return ret;
+	}
+
 	queue_delayed_work(cw_bat->battery_workqueue,
 			   &cw_bat->battery_delay_work, msecs_to_jiffies(10));
 	return 0;
-- 
2.39.5


