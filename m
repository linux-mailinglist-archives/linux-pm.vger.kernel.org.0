Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A503CC56E
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 20:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhGQS0e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 14:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbhGQS0I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 14:26:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A345C0613DC;
        Sat, 17 Jul 2021 11:23:09 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bn5so18450624ljb.10;
        Sat, 17 Jul 2021 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyEqKVYd5TXY1roltYfKJJJ2QzPSBfIspS/lNIOm7yo=;
        b=uiHe/8AVBuInu04jlXzgcUHpNJqOOdllXeR6HliYQRTRkTQDLPFxr93UOy0u5fvvAy
         2Ck0s4X8gLDBbAsPyiP0rGQwQGlCZpmL4fnFUdiaKbvKXWJb7dcBYeK8ItB7VH7+vX0c
         ZXNVr9gfPyNIbFSEiZe2ZTJZERti2+YXAYGreI9MZLonh9lJNXhm2o9tupx0vldweXKM
         /SCbL9CaTX+xayMZJNwOFuyvwJpBHEaGaI0fTJWDHajh+zPHWvqASoDhOKgchIbhJb0S
         zzpQs4DlPO/IRdOLvc2fla4qxM6w4sGAm5PZFPhMhLQlZwEPgV36F/vh0G9GCdJys/27
         8ZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyEqKVYd5TXY1roltYfKJJJ2QzPSBfIspS/lNIOm7yo=;
        b=edi8gm2feRmTAmqmFHUI4CVof13lluRRzYC4+VB7fY+2yG6lCJ04idDntcNiMFYpil
         tAL8CWqRmO1gIzQVD2ExDiyzRYeqCR/wH+RROSfth7CNleLpXRP1nYH8/jhJvAmUVscX
         mD5sppeFCKOBp7y/9soY0+90g3UgyO0uQjJ17015D8PwvklHLhz8edowaJ9pZcrrFvry
         tMwMol2KaV0oe/DFMwsWHtBDS+gcxPMw7+rt5/W+nX4ZjaN6BecL/D708/9bRntRdNsm
         3dHRB9glnxeUxpysEaZPkhgLXlJ7JPtMKeqkFJsJDlcgs+Ej8ANyZCUTGOuwfSp0bQOp
         t6iw==
X-Gm-Message-State: AOAM533/pJTrPbjYO5SwsqGI7gM777ttWFWvzK4XBEloQWAxC/yGskTr
        USjVHIocxYJpmoCGhbHJvw8=
X-Google-Smtp-Source: ABdhPJwIlxdKcMBrJc07SqUK9IKmgrZ2dXbf0Z6LlIe0tvKNl3/29hhmHJr818+2kr5k+fqIT1BNlg==
X-Received: by 2002:a2e:9241:: with SMTP id v1mr14371221ljg.48.1626546188055;
        Sat, 17 Jul 2021 11:23:08 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id z20sm1409532ljk.123.2021.07.17.11.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:23:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v5 08/12] power: supply: smb347-charger: Utilize generic regmap caching
Date:   Sat, 17 Jul 2021 21:21:30 +0300
Message-Id: <20210717182134.30262-9-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717182134.30262-1-digetx@gmail.com>
References: <20210717182134.30262-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Utilize generic regmap caching in order to avoid unnecessary slow I2C
accesses each time the supply status updated and remove local caching
of charger state to make code cleaner.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/smb347-charger.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index db1378b41f80..0f4d458e294f 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -135,7 +135,6 @@
  * @id: SMB charger ID
  * @mains_online: is AC/DC input connected
  * @usb_online: is USB input connected
- * @charging_enabled: is charging enabled
  * @irq_unsupported: is interrupt unsupported by SMB hardware
  * @max_charge_current: maximum current (in uA) the battery can be charged
  * @max_charge_voltage: maximum voltage (in uV) the battery can be charged
@@ -192,7 +191,6 @@ struct smb347_charger {
 	unsigned int		id;
 	bool			mains_online;
 	bool			usb_online;
-	bool			charging_enabled;
 	bool			irq_unsupported;
 
 	unsigned int		max_charge_current;
@@ -358,21 +356,13 @@ static int smb347_charging_status(struct smb347_charger *smb)
 
 static int smb347_charging_set(struct smb347_charger *smb, bool enable)
 {
-	int ret = 0;
-
 	if (smb->enable_control != SMB3XX_CHG_ENABLE_SW) {
 		dev_dbg(smb->dev, "charging enable/disable in SW disabled\n");
 		return 0;
 	}
 
-	if (smb->charging_enabled != enable) {
-		ret = regmap_update_bits(smb->regmap, CMD_A, CMD_A_CHG_ENABLED,
-					 enable ? CMD_A_CHG_ENABLED : 0);
-		if (!ret)
-			smb->charging_enabled = enable;
-	}
-
-	return ret;
+	return regmap_update_bits(smb->regmap, CMD_A, CMD_A_CHG_ENABLED,
+				  enable ? CMD_A_CHG_ENABLED : 0);
 }
 
 static inline int smb347_charging_enable(struct smb347_charger *smb)
@@ -1310,6 +1300,7 @@ static const struct regmap_config smb347_regmap = {
 	.max_register	= SMB347_MAX_REGISTER,
 	.volatile_reg	= smb347_volatile_reg,
 	.readable_reg	= smb347_readable_reg,
+	.cache_type	= REGCACHE_FLAT,
 };
 
 static const struct power_supply_desc smb347_mains_desc = {
-- 
2.32.0

