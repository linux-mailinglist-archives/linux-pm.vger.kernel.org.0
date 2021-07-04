Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F163BAF85
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 00:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhGDW6t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 18:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhGDW6o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 18:58:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0DFC061765;
        Sun,  4 Jul 2021 15:56:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p21so7308885lfj.13;
        Sun, 04 Jul 2021 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8EOJok7gQ/2QjTWWQG3gL5Nl9QBC5D9nB2n0/NrCfQ=;
        b=Tpz8BJCapxbWorqBwyUJbO5nXFK2W8UsmHmkcBJJqMc4ZTeEsbYUK9kx+iqttD0o6K
         mVAH8667GRa+jJpNEteykqm3JYvpqvUPi0XA6x2bOZQ+m0PBVhzS56oElIbVLkyQRnEL
         NFRrMc1d3hNnzzUPojQvK2ttmxLA+JPYt6khmCmpuNns3Ahpi6/XaOv09pDNRNF1JFaB
         Ja/R0bSR/K+mkFtpJ91rs/oYG6t8zv7gp8QYhX67k+TCAi8uVF0MHrUhMWgTkCNKo198
         qwpUtfiWdF+GernbF4GRh2I3ZTW5P4Vdmd6xyhn8ivYtHplY0uptDSWC3M2KbdUx2PJe
         Ux0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8EOJok7gQ/2QjTWWQG3gL5Nl9QBC5D9nB2n0/NrCfQ=;
        b=sfDhAvzlan3Gq/C0d3l4ej80hTwzRILt3+xa/v0iPW9o8QhFWG1Y/9niDuKek2eKT6
         kuNFI5pDDxUnPKEILPlYNbLZgGdGiB+IRrFET/rL8MOhSofN1btcQTyLpdWtz+u71h8f
         2gkeR2tqTEpaoe3SIQtvwHpd2HEY3akIJtQ5Lge8QrHUX7CekytY89k9aREx0zdbvT9y
         zc5M3BQR1Rpy3Pzgb1JyLv79QoOht/3TDDZjLogtW2bPiz9FS65elXpQizyA9eFo2cNN
         ZKpNT/dcihwZDhNkl/aFptgxkDRqEwbGVhHzlkwLYl2D7fcutAfyVVSX4U6//m9ktjkD
         JSYw==
X-Gm-Message-State: AOAM531g84eO+1xqQzGDV+CEJIDgWqOTDK0xEWvt42X4HbOzmik7x14e
        Bhb1WLnB3J9bRmoU7KTlhqY=
X-Google-Smtp-Source: ABdhPJzFtDCuOvfwHodsQvDx3pEgsNaQIuNKjB3X5YrFF7VYSwO/kyRUM/rO0RGOKn8A9xjMSFozkA==
X-Received: by 2002:a05:6512:c26:: with SMTP id z38mr7978903lfu.53.1625439365825;
        Sun, 04 Jul 2021 15:56:05 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id i13sm497921lfc.111.2021.07.04.15.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:56:05 -0700 (PDT)
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
Subject: [PATCH v3 08/12] power: supply: smb347-charger: Remove caching of charger state
Date:   Mon,  5 Jul 2021 01:54:29 +0300
Message-Id: <20210704225433.32029-9-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210704225433.32029-1-digetx@gmail.com>
References: <20210704225433.32029-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Regmap already provides us with the caching, so remove caching of charger
state to make code cleaner.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/smb347-charger.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index db1378b41f80..f81c60c679a0 100644
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
-- 
2.32.0

