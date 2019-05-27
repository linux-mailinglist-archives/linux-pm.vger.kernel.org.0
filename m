Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 224D92AD01
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 04:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfE0CqS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 May 2019 22:46:18 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.48]:20243 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbfE0CqS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 May 2019 22:46:18 -0400
X-Greylist: delayed 1380 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 May 2019 22:46:17 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 761AA10C3
        for <linux-pm@vger.kernel.org>; Sun, 26 May 2019 21:23:20 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id V5IGh1m2t4FKpV5IGhNUXL; Sun, 26 May 2019 21:23:20 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I4VLnKJzdba2/tICr5vHEXDmUjBljIV86QHf5FlXteA=; b=pBZkokznjDxJn5J0nEp/+icHZt
        YZukC0iqe8exicoGyoaaPdEHgzTPBSFsvRBwQ89W562CdIfWzRdc7i//G/aHpxbjSyDNfngXNx92V
        pfKxPUwOuA0QrX8G9IBsO9vUXnw0Yx/E38IDVfhR39v0BWtKG7+FDfLGfBRz8kRPY7fVZ+PxCSdsL
        e/f4tRW4IjuOOOaXY8YLrzuuOS7nJew6b+4S6Js6+n1X0gtq8zz9oIRBVUYCZCWoUHPGCG2wA3V/J
        7QtxE1xobhSWBtwmx838KEf0O+VtjqKv2A09qHUhqiG9QU9k/W7YzG+OONtVXCIXDdgh4MKh3km7R
        XrqP/Utg==;
Received: from [177.34.20.96] (port=57660 helo=castello.castello.in)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1hV5IF-003JNX-JQ; Sun, 26 May 2019 23:23:20 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v3 5/5] power: supply: max17040: Send uevent in SOC and status change
Date:   Sun, 26 May 2019 23:22:58 -0300
Message-Id: <20190527022258.32748-6-matheus@castello.eng.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527022258.32748-1-matheus@castello.eng.br>
References: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
 <20190527022258.32748-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 177.34.20.96
X-Source-L: No
X-Exim-ID: 1hV5IF-003JNX-JQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello.in) [177.34.20.96]:57660
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 70
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Notify core through power_supply_changed() in case of changes in state
of charge and power supply status. This is useful for user-space to
efficiently update current battery level.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 61e6fcfea8a1..34278845cfe5 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -176,6 +176,9 @@ static void max17040_get_online(struct i2c_client *client)
 static void max17040_get_status(struct i2c_client *client)
 {
 	struct max17040_chip *chip = i2c_get_clientdata(client);
+	int last_status;
+
+	last_status = chip->status;

 	if (!chip->pdata || !chip->pdata->charger_online
 			|| !chip->pdata->charger_enable) {
@@ -194,6 +197,9 @@ static void max17040_get_status(struct i2c_client *client)

 	if (chip->soc > MAX17040_BATTERY_FULL)
 		chip->status = POWER_SUPPLY_STATUS_FULL;
+
+	if (last_status != chip->status)
+		power_supply_changed(chip->battery);
 }

 static void max17040_get_of_data(struct max17040_chip *chip)
@@ -217,10 +223,18 @@ static void max17040_check_changes(struct i2c_client *client)
 static void max17040_work(struct work_struct *work)
 {
 	struct max17040_chip *chip;
+	int last_soc;

 	chip = container_of(work, struct max17040_chip, work.work);
+
+	/* store SOC for check change */
+	last_soc = chip->soc;
 	max17040_check_changes(chip->client);

+	/* check changes and send uevent */
+	if (chip->soc >= 0 && last_soc != chip->soc)
+		power_supply_changed(chip->battery);
+
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
 }
--
2.20.1

