Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E003CC306
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 14:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhGQMOk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 08:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbhGQMOc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 08:14:32 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4CBC06175F;
        Sat, 17 Jul 2021 05:11:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u13so20575260lfs.11;
        Sat, 17 Jul 2021 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0s0M0z8QxhlBsL/EnH/YmL65tjqGzsbgcjcWgYpzJI=;
        b=N3hMLbiQeBoLg6RaA70OhsaDgyI+G0sld8cf/RwtcMh4G4z986zqNRKAGFcxI5RDn/
         hu+n3Z8PgR/YNOoYy3gz3xrG+gJXMvpqcfL/ERoXRvW7AsV7G9vY5uy5TlfzvYc4SpqB
         DF/b/jKE9ejvYJnrbOcEuYoSy/27NaXRoYRUindiTF95GmMWM5Cv8xZFllsOcsbQtA6l
         Otej/IaHIl3q2TEirgHan1r/z4oZjdqJDgRCqGGuFoFazBhA/J9SiwuJc7QDUuaJYnT8
         4wThI+x+4M6Xo31AvyFZ/csjFdeEfI192hRYsY+IZEUeTRVNcO991NkJzUgzHUByIxfz
         r5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0s0M0z8QxhlBsL/EnH/YmL65tjqGzsbgcjcWgYpzJI=;
        b=diADKyrFcbflaXRHbzGv+h2DKS7b0w5k7GOk/l5j0vMmWz8WZwL96l8q94+Hbyx5oA
         A628pt82JNVTvNu9zVHOZUryrQ11k6ilrc2es8/DlzDFNW0BZsjpQ5ie8Kx+bNjnTou9
         oS5g0tACab4IJ7OWaHeg9OUv1jZzDUHZ7i0R5zsoxJzmrjEqcHbeja3P8TqecJU7Vqtl
         baqZRdgFnoQML+1e9LOWbSo3i6s/fnX+bvDTwo3Se4Vz7n1582sMiW8/0SiP3cztm2LE
         LgivFS9bCnAUQjIvtJl1yAO9J8IvmIVKVKgLQu3dXe+Mq/LTrPlXGdsma6887644OvNI
         OhhA==
X-Gm-Message-State: AOAM531aOCEB4WueemH3+6dq8Z3sNffhosDMwkLVujwh98gVWZb6mDbS
        ScdJI6CY251y3ml6OXNyuA4=
X-Google-Smtp-Source: ABdhPJzWcCsU9+YOxRgXSCUg0VqtsEVVLu8FMGUfjdNdCqacgwMN0t+i5mBrgwFf7LftIHPMc1fKiw==
X-Received: by 2002:ac2:4ec2:: with SMTP id p2mr11538760lfr.420.1626523891657;
        Sat, 17 Jul 2021 05:11:31 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id m16sm852597lfq.23.2021.07.17.05.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 05:11:31 -0700 (PDT)
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
Subject: [PATCH v4 07/12] power: supply: smb347-charger: Make smb347_set_writable() IRQ-safe
Date:   Sat, 17 Jul 2021 15:11:07 +0300
Message-Id: <20210717121112.3248-8-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717121112.3248-1-digetx@gmail.com>
References: <20210717121112.3248-1-digetx@gmail.com>
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

