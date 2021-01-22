Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A21300CDD
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 20:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbhAVTog (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 14:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbhAVTSr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 14:18:47 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07C2C061788;
        Fri, 22 Jan 2021 11:18:06 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f17so7760219ljg.12;
        Fri, 22 Jan 2021 11:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x/j5bxV3su/zAKnCmk1bt6joxRJHQqb1aOUcW9Eg2tM=;
        b=oZOF825K+Hgc9MwIwL7Uupdbk/HyRaPnb4qspvFVACKYhqiGe2UjBwIFuVI13qsk5s
         OZEWJBqkldIn6TZNkefpbIERwuf5kzjyWcX8vzO7WPX1NU8bDMdXft7S3i4DV0+2nVZd
         k3+lXzHQvHmRBj5g9GISGf4QOaj62r0n9w+3oeuvcbw8UrDI5S6eBIgiZRBgoKRiKEsi
         2Gpph8/vNLK5zzXN6LxrNjS+eh4FNnXHvI3s7V9x3oriWDsx04jmRgA4LUigBAhcj/cY
         L23nY5rmtjMNrgDXCZzUzqMVYtnhqT5RCOMwGXmzr0MlqYjA4jshIJSdfMLrgaWUAKhQ
         Xe3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x/j5bxV3su/zAKnCmk1bt6joxRJHQqb1aOUcW9Eg2tM=;
        b=OLIiGu7AKdRhx2gA/HZW3g7v1GI8Bnhe/tmjKtaBVMfSdpOE31hDHHVs3ExPnJJHhi
         gx/Ti1+g2NHLjzOf39ApmxNgzDrAQ2bvlJOAvM66hSJCFeUISJ8pzmWZyB/SXU0IeI63
         iSgP2BHiCZqEY34VfVM6fMGFAhGeUVEpnfHoTZhHJFkLdxLruS+W+S5mnO07aD3+LflS
         rHwmw1Wd0vNOj/7QN2CzFoC+MpPYdnixLmtuVvuovu/bArxOWPwQiFD/PeQe8JDNT9cy
         pOAFlykYJy6m/7/0r7xDuw0mmvwuaZdGmgVt0y15SRdKUiVddMdZJKgqTOx87OeTjmdE
         /3Kg==
X-Gm-Message-State: AOAM533BsNfTLrBtt/l9CZMkgWRvYb1VrGhUiANptZqR6Od5ViEvtKH1
        S9AEl/iyfjUKKBteOInSeoc=
X-Google-Smtp-Source: ABdhPJyy8oO/DvRhkAOrLEsBbRgcpb0qTO8Jr2QGtf/mhAaoGnPDUaG0HSdyNlWx4Kox2DoKjum6XQ==
X-Received: by 2002:a2e:81d5:: with SMTP id s21mr1057426ljg.263.1611343085197;
        Fri, 22 Jan 2021 11:18:05 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id f205sm94759lfd.70.2021.01.22.11.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 11:18:04 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] power: supply: smb347-charger: Fix interrupt usage if interrupt is unavailable
Date:   Fri, 22 Jan 2021 22:17:34 +0300
Message-Id: <20210122191734.27584-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The IRQ=0 could be a valid interrupt number in kernel because interrupt
numbers are virtual in a modern kernel. Hence fix the interrupt usage in
a case if interrupt is unavailable by not overriding the interrupt number
which is used by the driver.

Note that currently Nexus 7 is the only know device which uses SMB347
kernel diver and it has a properly working interrupt, hence this patch
doesn't fix any real problems, it's a minor cleanup/improvement.

Fixes: 99298de5df92 ("power: supply: smb347-charger: Replace mutex with IRQ disable/enable")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/smb347-charger.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index d3bf35ed12ce..8cfbd8d6b478 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -137,6 +137,7 @@
  * @mains_online: is AC/DC input connected
  * @usb_online: is USB input connected
  * @charging_enabled: is charging enabled
+ * @irq_unsupported: is interrupt unsupported by SMB hardware
  * @max_charge_current: maximum current (in uA) the battery can be charged
  * @max_charge_voltage: maximum voltage (in uV) the battery can be charged
  * @pre_charge_current: current (in uA) to use in pre-charging phase
@@ -193,6 +194,7 @@ struct smb347_charger {
 	bool			mains_online;
 	bool			usb_online;
 	bool			charging_enabled;
+	bool			irq_unsupported;
 
 	unsigned int		max_charge_current;
 	unsigned int		max_charge_voltage;
@@ -862,6 +864,9 @@ static int smb347_irq_set(struct smb347_charger *smb, bool enable)
 {
 	int ret;
 
+	if (smb->irq_unsupported)
+		return 0;
+
 	ret = smb347_set_writable(smb, true);
 	if (ret < 0)
 		return ret;
@@ -923,8 +928,6 @@ static int smb347_irq_init(struct smb347_charger *smb,
 	ret = regmap_update_bits(smb->regmap, CFG_STAT,
 				 CFG_STAT_ACTIVE_HIGH | CFG_STAT_DISABLED,
 				 CFG_STAT_DISABLED);
-	if (ret < 0)
-		client->irq = 0;
 
 	smb347_set_writable(smb, false);
 
@@ -1345,6 +1348,7 @@ static int smb347_probe(struct i2c_client *client,
 		if (ret < 0) {
 			dev_warn(dev, "failed to initialize IRQ: %d\n", ret);
 			dev_warn(dev, "disabling IRQ support\n");
+			smb->irq_unsupported = true;
 		} else {
 			smb347_irq_enable(smb);
 		}
@@ -1357,8 +1361,8 @@ static int smb347_remove(struct i2c_client *client)
 {
 	struct smb347_charger *smb = i2c_get_clientdata(client);
 
-	if (client->irq)
-		smb347_irq_disable(smb);
+	smb347_irq_disable(smb);
+
 	return 0;
 }
 
-- 
2.29.2

