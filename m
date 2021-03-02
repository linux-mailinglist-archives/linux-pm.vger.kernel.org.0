Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1509332B31F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Mar 2021 04:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343813AbhCCDou (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 22:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379913AbhCBKLz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Mar 2021 05:11:55 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEDDC061756;
        Tue,  2 Mar 2021 02:10:40 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 2so18668819ljr.5;
        Tue, 02 Mar 2021 02:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MUVbcHIyLqhYYbDiH9mnFrDuNemoNACUpRApum/EFvk=;
        b=QV5R4sSgWwClqhOQuWp+XSdvtSAmTbK5YBw42LvaIBL2A+5ogh0Rlhd+q3MiTwp6OI
         DzGogxpLU0sbmLDt+oSJzW6iACiQP0cwATbmJc3oZMfiQ8xw9/oZfPPoa5rbtsJgItbV
         Bamdu/TispHr0dNO+zMZ//ktqCAJiVkP8htqJbE/nEv0uYUg24lvs1opvSrJFQsZGNtT
         oZ7h196QRYnP2n/a3sJvoCV86qzcJmqUue2eV+A5uSff5oUg6abM6kVQ77A6s9LfOVVz
         R92/NH60u0Vwf7uVqDfxvsRf+4LA9uGap4YCDfYG6JzsQC4lzNbTt7x1oQhXb67YYzSP
         Qbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MUVbcHIyLqhYYbDiH9mnFrDuNemoNACUpRApum/EFvk=;
        b=Tur2uJ4+/3ohGGcGcgIKEkP0Pb5Qd1Y1F9mKv2jnV8YMoPqABtmLJkNF/SYygFyppI
         kPGbB7VJXeqm9Zb5uXqwNy/qDncr/pl34meacVTtLOoiJaWLNgUtHWUKYbl+wYzd9HQw
         uiSzULrtMVJYpsTPYxSFIiSJlVyrhcvwimLoR2YloV+tOKNphFX2De4MJvp8oyHPNMXl
         7MyaQclzPTrHGKnfvSke2nBdZzALmTeH0AdQWAUgda1N37iZsxOLeJjOI9IjpO5NdCIC
         Vr5jQCZBTXV5jdm4qw7QX/dGZ7IDw0A0WGHm3lLeqnNPt7+pKK+Wjylu/tLaQA/IiD5M
         QPJA==
X-Gm-Message-State: AOAM531Re3u494/BoELozGnDRMTfNkIbo7Y97zXsLs54I62Pcjvh0Thl
        Hvsbwbr6vW0cXofEcJrkmRE=
X-Google-Smtp-Source: ABdhPJyLnU8qRoh0II4AD+zk5fkGCHCk6RCCFKs4aj0Bal3Fk1RXNzdq9+VItxOItoEBUi/ycazFLw==
X-Received: by 2002:a2e:b4c3:: with SMTP id r3mr2464989ljm.232.1614679838530;
        Tue, 02 Mar 2021 02:10:38 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id c16sm2571001lfb.36.2021.03.02.02.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 02:10:38 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] power: supply: smb347-charger: Improve interrupt initialization
Date:   Tue,  2 Mar 2021 13:10:26 +0300
Message-Id: <20210302101027.4505-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A previous commit attempted to fix IRQ usage in a case where interrupt
is failed to initialize, but it missed couple more cases that could be
improved. The interrupt could be undefined and then everything related
to interrupt shouldn't be touched by driver. Secondly, we shouldn't ignore
errors that aren't directly related to enabling interrupt in hardware,
like enabling h/w write-access or requesting interrupt. Improve interrupt
initialization in the driver in order to handle the missing cases.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/smb347-charger.c | 58 +++++++++++++++++----------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 8cfbd8d6b478..ee13cd5d2b04 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -911,11 +911,14 @@ static int smb347_irq_init(struct smb347_charger *smb,
 {
 	int ret;
 
-	ret = devm_request_threaded_irq(smb->dev, client->irq, NULL,
-					smb347_interrupt, IRQF_ONESHOT,
-					client->name, smb);
-	if (ret < 0)
-		return ret;
+	smb->irq_unsupported = true;
+
+	/*
+	 * Interrupt pin is optional. If it is connected, we setup the
+	 * interrupt support here.
+	 */
+	if (!client->irq)
+		return 0;
 
 	ret = smb347_set_writable(smb, true);
 	if (ret < 0)
@@ -931,7 +934,25 @@ static int smb347_irq_init(struct smb347_charger *smb,
 
 	smb347_set_writable(smb, false);
 
-	return ret;
+	if (ret < 0) {
+		dev_warn(smb->dev, "failed to initialize IRQ: %d\n", ret);
+		dev_warn(smb->dev, "disabling IRQ support\n");
+		return 0;
+	}
+
+	ret = devm_request_threaded_irq(smb->dev, client->irq, NULL,
+					smb347_interrupt, IRQF_ONESHOT,
+					client->name, smb);
+	if (ret)
+		return ret;
+
+	smb->irq_unsupported = false;
+
+	ret = smb347_irq_enable(smb);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 /*
@@ -1120,9 +1141,13 @@ static int smb347_get_property(struct power_supply *psy,
 	struct i2c_client *client = to_i2c_client(smb->dev);
 	int ret;
 
-	disable_irq(client->irq);
+	if (!smb->irq_unsupported)
+		disable_irq(client->irq);
+
 	ret = smb347_get_property_locked(psy, prop, val);
-	enable_irq(client->irq);
+
+	if (!smb->irq_unsupported)
+		enable_irq(client->irq);
 
 	return ret;
 }
@@ -1339,20 +1364,9 @@ static int smb347_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	/*
-	 * Interrupt pin is optional. If it is connected, we setup the
-	 * interrupt support here.
-	 */
-	if (client->irq) {
-		ret = smb347_irq_init(smb, client);
-		if (ret < 0) {
-			dev_warn(dev, "failed to initialize IRQ: %d\n", ret);
-			dev_warn(dev, "disabling IRQ support\n");
-			smb->irq_unsupported = true;
-		} else {
-			smb347_irq_enable(smb);
-		}
-	}
+	ret = smb347_irq_init(smb, client);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.29.2

