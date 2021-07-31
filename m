Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0979E3DC773
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jul 2021 19:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhGaRji (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Jul 2021 13:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhGaRjP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jul 2021 13:39:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AA4C06179E;
        Sat, 31 Jul 2021 10:39:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r26so24977404lfp.5;
        Sat, 31 Jul 2021 10:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0s0M0z8QxhlBsL/EnH/YmL65tjqGzsbgcjcWgYpzJI=;
        b=K9PirLv1mOWvDgd8sp69mCRYJ1EjRQRQ85rDiyTUWEGz4X7ckDYyvJBYezxA107zZ2
         /HkPm9Rmsyr/iAuyQONAa5+z/vIlFL6zk2SQtLVaPIz+6xU0WRxV6CGrYJm/RV3Bh5UI
         zQgKftSuTqzT4cjvIU7v+flWOsJOYmvBzaviBSrDEch7T/8tZYd1VDpAHjMBPOpeyG1X
         TKtZw5hSwNZLkaNgN3NUlgHpmt01Qti71CNnRMIJZm9RTuX/9W/WOi/Ad7QTIb56H7Lj
         9nn/J5vG+k3hXP10fvBSrsbkRctJoxEIv6Oy3Tm5S3a2SNMSehTpIULVFSmm8eSQVAsd
         Q9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0s0M0z8QxhlBsL/EnH/YmL65tjqGzsbgcjcWgYpzJI=;
        b=jT7xkdXuI0wKJ462jl5CCAGQkqLbdFlCuF7O6NaTTlE25lc9sTThVxD89V7S5LKrt6
         Gii1R21wn8PoiHxpbVhna+KRxtE307J9oEFCB1JNJ1dfwUaGF3z/5rGn0dpj/mOk2BAG
         yCkDMj7IBjaejtW/hZ8CgthAExoN5n1W753BAMn0BLO6wuwABqMcODg9tdJP8tF7aZag
         Q0EaAVDwPVv+zhptBewq/nYKyq1zpS24KKnM06zCmEqPcx2j5q+p0nho/G25aqmuDeg1
         n9pgCKoW3ucZhQZwH7fwS84eXgBlXhrJniImpbMm88bWMUIR+Zuios3yBj9wOFtM4fvU
         FNrQ==
X-Gm-Message-State: AOAM531aud2+jgMQkAUbWBOZHIPU0i0s+cGmaDt+p9EsRxFV/+KypBvJ
        C2Sfp9Sk637VaR3W4GaIK5c=
X-Google-Smtp-Source: ABdhPJzdbPAxAHPWyw7f2fAj8Bhx089XN80sHpWwM+q7Y8pZ7ono1d7fmHD6++Zp7tde1FKjopqeow==
X-Received: by 2002:ac2:4119:: with SMTP id b25mr2741917lfi.284.1627753141929;
        Sat, 31 Jul 2021 10:39:01 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id s15sm445272lfp.216.2021.07.31.10.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:39:01 -0700 (PDT)
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
Subject: [PATCH v6 06/12] power: supply: smb347-charger: Make smb347_set_writable() IRQ-safe
Date:   Sat, 31 Jul 2021 20:38:36 +0300
Message-Id: <20210731173842.19643-7-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731173842.19643-1-digetx@gmail.com>
References: <20210731173842.19643-1-digetx@gmail.com>
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

