Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2162A3CC563
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 20:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhGQS0L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 14:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbhGQS0H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 14:26:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E559EC061764;
        Sat, 17 Jul 2021 11:23:08 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g22so9691386lfu.0;
        Sat, 17 Jul 2021 11:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0s0M0z8QxhlBsL/EnH/YmL65tjqGzsbgcjcWgYpzJI=;
        b=IkTg5Jxqg4eSEEFLunf21iwtAMWn5dG49OB3XcN8soCBSEusH/JCTP+iLl71XFbjOy
         Apu0fJ4wB7L0oJ17WQaXt7eEM2J4wclvP1SaohCBMwsqX8MFg5XcEw9UP/mYuiADdFhs
         RhlQcnBZ42GZhjHDQ+S4k318RgeSDFGmQIJFiUWlxlBrX77KcrX3Cv2RG/OHZourI14J
         q69+b+8WmWxQPmmESkcelm76dJjW3p3qHPaV3/cF8DPikAwag4hqO9m0U4yMCZ1i4llO
         MtfQh6AQD35Rr3uq734o0BLPFlySseTN9vRJEEUo7QxcHM0+cDIcl3ST1tI8qaO8gWTx
         y30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0s0M0z8QxhlBsL/EnH/YmL65tjqGzsbgcjcWgYpzJI=;
        b=poAD/qnbviJwT63R+b8mwCVqcA8DGVkUoCMhsQWh8BH35A7M4bzMn0aDdZ3Od5m3hm
         zO/ELJh46cH+QvLLGOkGs+jn7Itec5k0usIpDy7+PlJxd1YInRlhbCMbQXq2c5bv6u7H
         2wlHPvW1V/E0zraVjUIxZoUDO658TaTabBUa+xV7oL6jKFYt3/2QamuhMogST2r+Td01
         11N6GR1HasGmgBpHYl0Z0gUmeUQFtsS3NJzNCF0LhykTZ6P6VaO+pl/T8+U5sRAM0vjh
         DcTN+p2vlSnfyyd56MNJrYMyhSOkZsFNqlmHKx0RdXDO18j4FFd7BoV+R8JEMvd9fDgO
         FvWw==
X-Gm-Message-State: AOAM531y1E455BS3Q5RjvCxmb6Fp+ou3Z1DPstCyzXEmLwwltnj9ySFI
        wD0Ysa5D8R4PembGBjRzdyw=
X-Google-Smtp-Source: ABdhPJzd76uy4L8Cbp10rv0ImWAhsEpfvJbSxMVvFcy9sJ7aZD+RjVPvWlW4nH+F+bj88kqkoqh2DQ==
X-Received: by 2002:a05:6512:374f:: with SMTP id a15mr11902689lfs.208.1626546187283;
        Sat, 17 Jul 2021 11:23:07 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id z20sm1409532ljk.123.2021.07.17.11.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:23:06 -0700 (PDT)
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
Subject: [PATCH v5 07/12] power: supply: smb347-charger: Make smb347_set_writable() IRQ-safe
Date:   Sat, 17 Jul 2021 21:21:29 +0300
Message-Id: <20210717182134.30262-8-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717182134.30262-1-digetx@gmail.com>
References: <20210717182134.30262-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The smb347_set_writable() is used by interrupt handler and outside of it.
The interrupt should be disabled when the function is used outside of
interrupt handler in order to prevent racing with the interrupt context.
Add new parameter to smb347_set_writable() that allows to disable IRQ.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/smb347-charger.c | 30 +++++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index df240420f2de..db1378b41f80 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -671,10 +671,22 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
  *
  * Returns %0 on success and negative errno in case of failure.
  */
-static int smb347_set_writable(struct smb347_charger *smb, bool writable)
+static int smb347_set_writable(struct smb347_charger *smb, bool writable,
+			       bool irq_toggle)
 {
-	return regmap_update_bits(smb->regmap, CMD_A, CMD_A_ALLOW_WRITE,
-				  writable ? CMD_A_ALLOW_WRITE : 0);
+	struct i2c_client *client = to_i2c_client(smb->dev);
+	int ret;
+
+	if (writable && irq_toggle && !smb->irq_unsupported)
+		disable_irq(client->irq);
+
+	ret = regmap_update_bits(smb->regmap, CMD_A, CMD_A_ALLOW_WRITE,
+				 writable ? CMD_A_ALLOW_WRITE : 0);
+
+	if ((!writable || ret) && irq_toggle && !smb->irq_unsupported)
+		enable_irq(client->irq);
+
+	return ret;
 }
 
 static int smb347_hw_init(struct smb347_charger *smb)
@@ -682,7 +694,7 @@ static int smb347_hw_init(struct smb347_charger *smb)
 	unsigned int val;
 	int ret;
 
-	ret = smb347_set_writable(smb, true);
+	ret = smb347_set_writable(smb, true, false);
 	if (ret < 0)
 		return ret;
 
@@ -758,7 +770,7 @@ static int smb347_hw_init(struct smb347_charger *smb)
 	ret = smb347_start_stop_charging(smb);
 
 fail:
-	smb347_set_writable(smb, false);
+	smb347_set_writable(smb, false, false);
 	return ret;
 }
 
@@ -866,7 +878,7 @@ static int smb347_irq_set(struct smb347_charger *smb, bool enable)
 	if (smb->irq_unsupported)
 		return 0;
 
-	ret = smb347_set_writable(smb, true);
+	ret = smb347_set_writable(smb, true, true);
 	if (ret < 0)
 		return ret;
 
@@ -891,7 +903,7 @@ static int smb347_irq_set(struct smb347_charger *smb, bool enable)
 	ret = regmap_update_bits(smb->regmap, CFG_PIN, CFG_PIN_EN_CHARGER_ERROR,
 				 enable ? CFG_PIN_EN_CHARGER_ERROR : 0);
 fail:
-	smb347_set_writable(smb, false);
+	smb347_set_writable(smb, false, true);
 	return ret;
 }
 
@@ -919,7 +931,7 @@ static int smb347_irq_init(struct smb347_charger *smb,
 	if (!client->irq)
 		return 0;
 
-	ret = smb347_set_writable(smb, true);
+	ret = smb347_set_writable(smb, true, false);
 	if (ret < 0)
 		return ret;
 
@@ -931,7 +943,7 @@ static int smb347_irq_init(struct smb347_charger *smb,
 				 CFG_STAT_ACTIVE_HIGH | CFG_STAT_DISABLED,
 				 CFG_STAT_DISABLED);
 
-	smb347_set_writable(smb, false);
+	smb347_set_writable(smb, false, false);
 
 	if (ret < 0) {
 		dev_warn(smb->dev, "failed to initialize IRQ: %d\n", ret);
-- 
2.32.0

