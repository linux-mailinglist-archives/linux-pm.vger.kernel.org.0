Return-Path: <linux-pm+bounces-18386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CFD9E0D93
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 22:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1981316558E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 21:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CE41DF26D;
	Mon,  2 Dec 2024 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CxAuzfTS"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966D11DDA0C;
	Mon,  2 Dec 2024 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174126; cv=none; b=CizumGd+Kbeux4k5py8H3F/31KqjQcdRZ/CyxJi5oXjK5gJTwLKgCHAoS0gykEcO/WDyCAzHq0zZ+atobq2WNc4iOl0IxVVK3y0DNY8fJwEe/RhKv2jWpV2uy2ZadZ7QXxlShB1ZDNk+yBNNhZsLlcp5jAJXzWjxBnFw5Ei5el0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174126; c=relaxed/simple;
	bh=3ncebkoMfB2c4jQJI85u71Oo6G7lqbdbWKatLiOZuBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJzs+rKLJ3o2GRHZsiS29aNKRHnICvSEmUXwSmn0SUebRPMmDwBdmlvfqNFzBKYAB2ghlqtkeP7/6Mo0Ik6m4RU4mhpCklsYFL3j4FrUs/jtb9eYkoU3E0oJ74FaqolRaY/YzAIafBlQhaw56U6Jg61UPPt7iNVHi+nQ+3t10Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CxAuzfTS; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B2LFLRm042457;
	Mon, 2 Dec 2024 15:15:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733174121;
	bh=wzPxvMfl6rsFcnkrTUvkGRDue9AJCUJzhDr7f9CnFj0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CxAuzfTSWrziMID/wm6ZmpPLNiod7vWoJ5fjaz/FCKM4564CXfkeUrdDXMoZJ0VQd
	 vlsyY3tfUVc9UFMYEP7yiZTudPHCFivYZtoEtUlGuGL9EXasKV0qt5bm1Yxu92NGFy
	 y0uQan1TX7DwZQVsuNMJNBh5mQesBBpNdzsF1EL4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B2LFL3Q010171
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Dec 2024 15:15:21 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Dec 2024 15:15:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Dec 2024 15:15:21 -0600
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B2LFKgp099805;
	Mon, 2 Dec 2024 15:15:20 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 2/5] power: supply: ds2782: Free IDA with devm action
Date: Mon, 2 Dec 2024 15:15:16 -0600
Message-ID: <20241202211519.199635-2-afd@ti.com>
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

This helps prevent mistakes like freeing out of order in cleanup functions
and forgetting to free on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/ds2782_battery.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
index 10428d781c18b..28ad11c8f82de 100644
--- a/drivers/power/supply/ds2782_battery.c
+++ b/drivers/power/supply/ds2782_battery.c
@@ -57,7 +57,6 @@ struct ds278x_info {
 	struct power_supply_desc	battery_desc;
 	const struct ds278x_battery_ops *ops;
 	struct delayed_work	bat_work;
-	int			id;
 	int                     rsns;
 	int			capacity;
 	int			status;		/* State Of Charge */
@@ -314,14 +313,11 @@ static void ds278x_power_supply_init(struct power_supply_desc *battery)
 static void ds278x_battery_remove(struct i2c_client *client)
 {
 	struct ds278x_info *info = i2c_get_clientdata(client);
-	int id = info->id;
 
 	power_supply_unregister(info->battery);
 	cancel_delayed_work_sync(&info->bat_work);
 	kfree(info->battery_desc.name);
 	kfree(info);
-
-	ida_free(&battery_id, id);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -365,6 +361,13 @@ static const struct ds278x_battery_ops ds278x_ops[] = {
 	}
 };
 
+static void ds278x_free_ida(void *data)
+{
+	int num = (uintptr_t)data;
+
+	ida_free(&battery_id, num);
+}
+
 static int ds278x_battery_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -387,12 +390,13 @@ static int ds278x_battery_probe(struct i2c_client *client)
 	num = ida_alloc(&battery_id, GFP_KERNEL);
 	if (num < 0)
 		return num;
+	ret = devm_add_action_or_reset(&client->dev, ds278x_free_ida, (void *)(uintptr_t)num);
+	if (ret)
+		return ret;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		ret = -ENOMEM;
-		goto fail_info;
-	}
+	if (!info)
+		return -ENOMEM;
 
 	info->battery_desc.name = kasprintf(GFP_KERNEL, "%s-%d",
 					    client->name, num);
@@ -406,7 +410,6 @@ static int ds278x_battery_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, info);
 	info->client = client;
-	info->id = num;
 	info->ops  = &ds278x_ops[id->driver_data];
 	ds278x_power_supply_init(&info->battery_desc);
 	psy_cfg.drv_data = info;
@@ -432,8 +435,6 @@ static int ds278x_battery_probe(struct i2c_client *client)
 	kfree(info->battery_desc.name);
 fail_name:
 	kfree(info);
-fail_info:
-	ida_free(&battery_id, num);
 	return ret;
 }
 
-- 
2.39.2


