Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B6B3DC761
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jul 2021 19:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhGaRjW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Jul 2021 13:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhGaRjO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jul 2021 13:39:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41735C06179F;
        Sat, 31 Jul 2021 10:39:04 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e5so17617727ljp.6;
        Sat, 31 Jul 2021 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yP6S2T4oQUXBPJzLj6JChwZNeadgwpgXfp2tQNc6v5U=;
        b=deUskVg3oSa4TdKJzd3l5DM8ygli4WAPYQlZamdeMEEasb94cUMPSwqi7KIyCwZPk5
         oLqVZagPxxnvfKaFrg7PjAp0mlPJw+oTel3ipGcrT0KsyLoNskI+/AgeAzZU4qQ8Zp18
         PWplzL8SQL1/WWW21VUH0MLMo7bMiPvAd03LEWV6etGfi+VxcNI4beAsk1eRmwXbyAEw
         g/T9IRVp4Nrlmwanbbe4x6Kp3dX8icaqZA2/1w95fMVVb006Kace9dHKDghAIrx4XUHs
         1YZrzCMBZOTlrip1Xa/m2Dr8eMdYh1KrnW7gfyp6w5RY6SvckYjWOna/lupXt3A/4J92
         M0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yP6S2T4oQUXBPJzLj6JChwZNeadgwpgXfp2tQNc6v5U=;
        b=B1fw/3JHcvTQjvDyRxRfpDO3y0v4x1n17HO/FPS2GPWsX3TIghXzeabrbm04/4jkbv
         3xFVTjsCPvalIsEUGkFObe/3s2g3BwDEYAlAWkaVPiTN70J3Nqy1RYB79at95HTGUMMN
         yvsq+JFQ2THoJdjqonHdRczpTinCFpBWVcZqFGedCuExxaO1RXWqveaZMNbyWXDYQkZk
         j3e1pP3BP2QiroCbLhzk21CgwGr6EL6Mb7mDlGkNr821OCriWo/dkmileEtEdh/voLMZ
         xgKcya984uUt3GlwltsjgqmAFndwI1oBE/mHqSeJaLjGUeCpAG0uf6s4UoN0jqvAXltN
         UOnQ==
X-Gm-Message-State: AOAM532aGBXpUUsyxqKEkxqjbjFtBNwnygYscP0u2OiFwWFXCybSzLLS
        ezksjJBwdgn2/3XJc1PQvT4=
X-Google-Smtp-Source: ABdhPJwJwrGb8ek+xMSWKTOXoZWv/E9mHJtnrLRuSutxKVe3f6GUHeavio7Z/94lGrZZ4xXmSYFyRw==
X-Received: by 2002:a05:651c:235:: with SMTP id z21mr5710651ljn.462.1627753142657;
        Sat, 31 Jul 2021 10:39:02 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id s15sm445272lfp.216.2021.07.31.10.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:39:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v6 07/12] power: supply: smb347-charger: Utilize generic regmap caching
Date:   Sat, 31 Jul 2021 20:38:37 +0300
Message-Id: <20210731173842.19643-8-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731173842.19643-1-digetx@gmail.com>
References: <20210731173842.19643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Utilize generic regmap caching in order to avoid unnecessary slow I2C
accesses to all constant registers each time the supply status updated
and remove local caching of charger state to make code cleaner.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/smb347-charger.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index db1378b41f80..27254e6efdde 100644
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
@@ -1310,6 +1300,8 @@ static const struct regmap_config smb347_regmap = {
 	.max_register	= SMB347_MAX_REGISTER,
 	.volatile_reg	= smb347_volatile_reg,
 	.readable_reg	= smb347_readable_reg,
+	.cache_type	= REGCACHE_FLAT,
+	.num_reg_defaults_raw = SMB347_MAX_REGISTER,
 };
 
 static const struct power_supply_desc smb347_mains_desc = {
-- 
2.32.0

