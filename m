Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C033BAF83
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 00:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhGDW6s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 18:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhGDW6n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 18:58:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76D7C061762;
        Sun,  4 Jul 2021 15:56:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c28so5612539lfp.11;
        Sun, 04 Jul 2021 15:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0s0M0z8QxhlBsL/EnH/YmL65tjqGzsbgcjcWgYpzJI=;
        b=hPtwlF/YsRqPd5mmTAIYIlsA48PeQnSqk3bk9ZQPDFAeTP9+ScSsdirrC67NjnA8Xy
         nRKOVHo0sbM925B7P3cFNHk9gXd0lO5s0QDRmUixnyf5DS4k4gPd1bCCxOz6BBXJMQFG
         6I3jdE435HVe3nOQTA6qzCu2lYvAINQYtOEuz2g8oP9U+fVfqSIH8kfScXllkiGz6dOB
         1j3zbumNgSZZgj31MGg5XGmOPCk3wq0BoBXkAI8Q5JPnas5XrPH/nEKswbeNw97yRYiv
         pYwf9yfzqYoHmzZQzm30yLizlXS1yCnlygz+tgAkYrOIYT0eBdgGFTFd7mTlyUYsGj8q
         1vNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0s0M0z8QxhlBsL/EnH/YmL65tjqGzsbgcjcWgYpzJI=;
        b=sXQrLLRFDVYW7ZfdFfUAJbx6jYwHledRwol4onddm2RJ4vJZextZ/9GLZ3N2sZPLWn
         3QIr3zKrxlXcbGzJ/YrRThVDOceuGhjy/u8wxVhoj7t5EawXno91pIp7MajqxwY0oV0r
         M0MNfodJhAff5PNqq9tVKRudnXpncauNqnmeHTOROyA6GHiEjl9tRq1ZEsPBmMxbMpMi
         +Mi/vVWTCjxuIGr0ec6R6l4l3QiSr+VcJ+uf4Em/79UDCUZzy1VdQhgEWhCU/SAI025c
         nKjFeSYm7v8kR9BGDcywtZC3jUIEee/r+F1oSfRRRMGioQJ7Gp1/aQUzbV19dPWRyWXp
         UeyQ==
X-Gm-Message-State: AOAM531SMI3VqNoMsZ1S5Hl+6vXYegid5nYRNs/ycDFF63XjW8DbN3nN
        YzKsPjHFwUiaE+eJTq3dM5A=
X-Google-Smtp-Source: ABdhPJzL1NLRsiK6JiBHsnCMYe8W+wwSI5V2oXPYjSehALhqs7WTs0i6vrpVnOaNlnPYlBSQD8MwHQ==
X-Received: by 2002:a05:6512:90a:: with SMTP id e10mr8239819lft.70.1625439365088;
        Sun, 04 Jul 2021 15:56:05 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id i13sm497921lfc.111.2021.07.04.15.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:56:04 -0700 (PDT)
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
Subject: [PATCH v3 07/12] power: supply: smb347-charger: Make smb347_set_writable() IRQ-safe
Date:   Mon,  5 Jul 2021 01:54:28 +0300
Message-Id: <20210704225433.32029-8-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210704225433.32029-1-digetx@gmail.com>
References: <20210704225433.32029-1-digetx@gmail.com>
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

