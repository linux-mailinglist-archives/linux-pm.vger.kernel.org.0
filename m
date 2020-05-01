Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3621C17CA
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 16:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgEAOas (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 10:30:48 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:20580 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbgEAOas (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 10:30:48 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49DF6G1brdz7N;
        Fri,  1 May 2020 16:30:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588343446; bh=WgVlgCr6MbzvVSNExbvY4JCH5rFnjkfqWzvLsrfDpq8=;
        h=Date:From:Subject:In-Reply-To:To:Cc:From;
        b=i7UdLiawyrvn4fBym2ZE5X2aK8Wgd/yxbIWzeG8qQ3RJQv5vYJuu7M1Z3oE9CTxT5
         dBzpCdUBGHP9ybnKCy420e2hrizMPkpft6CgGp7uDSoBumC3GYERaWEJnxlNvvtjZ4
         h3+sKG4aykp3raA+aDueJrruiYA54nNQmW35IWAwmdknMw8+aW5z4az/nmdFEXSF4s
         Wc26seBBZoK3BuZ0amPh3yHrRCVJpyxnRj/tHAUmEx3eW6kgsnxAt1MIYKX7q+tfnf
         Fq9abWNhnOluaF1vZzDOk3JNVXalB29IPTgSD+pDs+M4ZP6+ASXk9lpt/r5d4ZmdsD
         /oKpyE2cG8x4Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 01 May 2020 16:30:43 +0200
Message-Id: <c262c4b0921d916712de6a15133ff016fb721c4f.1588343350.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] power: charger-manager: clarify num_properties starting value
In-Reply-To: <20200501135109.45gwxpczcqdt3fbb@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Initialize num_properties with length of the copied array instead
of relying on previously memcpy'd value. This makes it clear how
the array and the counter are related.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/charger-manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 415a9efa6816..2ef53dc1f2fb 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1729,7 +1729,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 	memcpy(properties, default_charger_props,
 		sizeof(enum power_supply_property) *
 		ARRAY_SIZE(default_charger_props));
-	num_properties = psy_default.num_properties;
+	num_properties = ARRAY_SIZE(default_charger_props);
 
 	/* Find which optional psy-properties are available */
 	fuel_gauge = power_supply_get_by_name(desc->psy_fuel_gauge);
-- 
2.20.1

