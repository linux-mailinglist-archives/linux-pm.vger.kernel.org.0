Return-Path: <linux-pm+bounces-18390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8939E0D99
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 22:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F261E165649
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 21:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6141DF96A;
	Mon,  2 Dec 2024 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t7g01go/"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9872B1DF270;
	Mon,  2 Dec 2024 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174128; cv=none; b=FIVSc1X4ifgGgq6otZpdA2NMVB0vcZTlIJnlDjCPGmk60WuRtRJ64txcXu1s/O8Lu7gl30sA3LHCSX8d7zXZmbucc3vub9kmyKAu5zi4IUdoLgnjXkHzT4/rI3WV5b8S8c95k8Wr3O1xW2Z3VhoWIHl71N668yvXZv3qIlLyoUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174128; c=relaxed/simple;
	bh=NdJ0yXTxTKVWot4f4JMxdCfyaWCHM1+Od7JimNuxcHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNOsMJdesHlEYagJ0g6upLlaomff5/sd6g4RY9ljOABFjk4OSJec0969JliRvhGoSpW27bFHbQl3PiF56QlTmxqki2pQO/xE0nLK9x/BkC5fqYVEWL0YaglLiFpOeMD5R8MfhiVeaTYxc1WaHKuxO6mKoHjvmcbHdBN+6vGe8Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t7g01go/; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B2LFLfW042465;
	Mon, 2 Dec 2024 15:15:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733174121;
	bh=2JjsfL/WpGUMsb+xrY8eVOUuQ1g+JVXvcYE89y86t3Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=t7g01go/RmuXJCfAeqbr+KattNjlag1gyE+KBhul8w+yGjpGqKD11AXmgoJpTruu1
	 TunvD60B48z2Uca/iGeHzYP6LUgQpgoN/NeEUo2kds5BXaw409SGmNi4fnlqpW+81w
	 P4RlkY8HnYDcPhe5MSoMVoNtse9iOT4CwTRH8PwE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B2LFLcI010178
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Dec 2024 15:15:21 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Dec 2024 15:15:21 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Dec 2024 15:15:21 -0600
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B2LFKgr099805;
	Mon, 2 Dec 2024 15:15:21 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 4/5] power: supply: ds2782: Use devm_power_supply_register() helper
Date: Mon, 2 Dec 2024 15:15:18 -0600
Message-ID: <20241202211519.199635-4-afd@ti.com>
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

Use the device lifecycle managed register function. This helps prevent
mistakes like unregistering out of order in cleanup functions and
forgetting to unregister on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/ds2782_battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
index a72d8c26650d7..ea687b9703314 100644
--- a/drivers/power/supply/ds2782_battery.c
+++ b/drivers/power/supply/ds2782_battery.c
@@ -314,7 +314,6 @@ static void ds278x_battery_remove(struct i2c_client *client)
 {
 	struct ds278x_info *info = i2c_get_clientdata(client);
 
-	power_supply_unregister(info->battery);
 	cancel_delayed_work_sync(&info->bat_work);
 }
 
@@ -415,8 +414,9 @@ static int ds278x_battery_probe(struct i2c_client *client)
 
 	INIT_DELAYED_WORK(&info->bat_work, ds278x_bat_work);
 
-	info->battery = power_supply_register(&client->dev,
-					      &info->battery_desc, &psy_cfg);
+	info->battery = devm_power_supply_register(&client->dev,
+						   &info->battery_desc,
+						   &psy_cfg);
 	if (IS_ERR(info->battery)) {
 		dev_err(&client->dev, "failed to register battery\n");
 		return PTR_ERR(info->battery);
-- 
2.39.2


