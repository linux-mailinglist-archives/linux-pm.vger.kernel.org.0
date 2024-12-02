Return-Path: <linux-pm+bounces-18388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9CD9E0D97
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 22:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B16C283459
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 21:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737061DF731;
	Mon,  2 Dec 2024 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tXwTQRXh"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC981DF25D;
	Mon,  2 Dec 2024 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174127; cv=none; b=LSmlsqI4Ywfd/CDrmPS43uu/LOC8yuwQZTO1HJStjlXNeaNs5HH+bPo96/8yDnbxXyzeMFRsSDYZVjazt+MjMlr/Y/z0bSUzmO46JoBU2ITibu3dg2guSpeimpY4+DR4NkVDzcM0MF9Ll7KLtZMU1qiG4rWk35ZyzvxTGbVclY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174127; c=relaxed/simple;
	bh=+KRs5cb5pDNcOrmkVtzoBpHAtS6QlVZC+o3uB+vrlgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpacWzn8ZBLRY47LB1EqdGZYuoWkWkRWHmqd6BwX+xrD9eJsz5Vu1fvBN4LE/fWQiBrsEGaNDs8U03kUI4UrA0132KNWFL701kfOLb9abeUF9m/QFFrtKYXnkJ94jhIMZzGcula9fZlRor51qKsgVa0oxa/SMe0jFY82A+EwOCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tXwTQRXh; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B2LFLba042461;
	Mon, 2 Dec 2024 15:15:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733174121;
	bh=FSlI7xItPf6A4OyFcddSp1gvlX0oCMs2JHskU3v7+t0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tXwTQRXh+cLdSthP4iBQoFyrEU54QSyOU2y6F4bUytaAl8nWTw/bXRqRcgQNQGNLh
	 dcwkZWqVKifMFIXv48ZprGYaCVUqlX6yYALURFueJKmfbJHY4EnrRYqzL7k/K5N+0n
	 16gTIgVFmHnEnAlD+lm/b0LBIW68k14hRLxHf/Eg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B2LFLgb121619;
	Mon, 2 Dec 2024 15:15:21 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Dec 2024 15:15:21 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Dec 2024 15:15:21 -0600
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B2LFKgq099805;
	Mon, 2 Dec 2024 15:15:20 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 3/5] power: supply: ds2782: Use devm based memory allocators
Date: Mon, 2 Dec 2024 15:15:17 -0600
Message-ID: <20241202211519.199635-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241202211519.199635-1-afd@ti.com>
References: <20241202211519.199635-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Use device lifecycle managed memory alloc helpers. This helps
prevent mistakes like freeing out of order in cleanup functions and
forgetting to free on all error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/ds2782_battery.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
index 28ad11c8f82de..a72d8c26650d7 100644
--- a/drivers/power/supply/ds2782_battery.c
+++ b/drivers/power/supply/ds2782_battery.c
@@ -316,8 +316,6 @@ static void ds278x_battery_remove(struct i2c_client *client)
 
 	power_supply_unregister(info->battery);
 	cancel_delayed_work_sync(&info->bat_work);
-	kfree(info->battery_desc.name);
-	kfree(info);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -394,16 +392,14 @@ static int ds278x_battery_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	info->battery_desc.name = kasprintf(GFP_KERNEL, "%s-%d",
-					    client->name, num);
-	if (!info->battery_desc.name) {
-		ret = -ENOMEM;
-		goto fail_name;
-	}
+	info->battery_desc.name = devm_kasprintf(&client->dev, GFP_KERNEL,
+						 "%s-%d", client->name, num);
+	if (!info->battery_desc.name)
+		return -ENOMEM;
 
 	if (id->driver_data == DS2786)
 		info->rsns = pdata->rsns;
@@ -423,19 +419,12 @@ static int ds278x_battery_probe(struct i2c_client *client)
 					      &info->battery_desc, &psy_cfg);
 	if (IS_ERR(info->battery)) {
 		dev_err(&client->dev, "failed to register battery\n");
-		ret = PTR_ERR(info->battery);
-		goto fail_register;
+		return PTR_ERR(info->battery);
 	} else {
 		schedule_delayed_work(&info->bat_work, DS278x_DELAY);
 	}
 
 	return 0;
-
-fail_register:
-	kfree(info->battery_desc.name);
-fail_name:
-	kfree(info);
-	return ret;
 }
 
 static const struct i2c_device_id ds278x_id[] = {
-- 
2.39.2


