Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA433B99AB
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhGAXqt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhGAXqa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:46:30 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18582C0613DF;
        Thu,  1 Jul 2021 16:43:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id k21so10861682ljh.2;
        Thu, 01 Jul 2021 16:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esff+ZXqqz83swKvK/vBkagYD4H4gF2qZzwq0FaHQEk=;
        b=EO2W7fDBIINLnKEOgT4Zxsjtzj6uP3DID/qd/uIKUNCzbUIIh9rT32VX9jJz/skEHG
         Q8+tnkjxBDIaWiSJiXRMW374yuW/4FT68KnyLSHh5FeO2kKrrubq+tyWnHpXIpSyZW2e
         FI6CepenJLfFH8myj9g1gmMCC1fFE6CLzJY5ITd8SneEjJUTaM5nFYXSoRwqVgv9kBiu
         JvPu79SnTMuW6zfUxnUCAoOlgqRP+hfmyJcUNhKRVa7fY5wMRy/F7Oz/NtVhqiOn4Nh1
         n6Iaz7/VXC7sHycL8JXF+uxGn39Q2DCa6rR3hki4S1LEC09MMJBYB4U5BCxhMiQzYfYr
         qFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esff+ZXqqz83swKvK/vBkagYD4H4gF2qZzwq0FaHQEk=;
        b=rR7bS1ep4bfTR2KlIjUo5Eel/Wdo2ZtwrDwy4XNjQV4sw3QjCfLsPxtYfdOlwacA//
         StEDSSNUT4XRDmpwvMKxWvYcNUDLCTjJstJWTe2XIlIdx0x+cLZA3LQ0FjSspX/Pjpx2
         W/kFtsc3I3DezzjAa0CDdxXqtBljwWBr5t7Ginl7m0huLeqgRBESU9GkWlh2YVn+bI3s
         bwYRpusoHl/FyAEaad9/M0n4hvQO0u4PaVlpnDsHSvLY4HjNy7DslCq8vw5Awnu7S7X8
         haWYxZxJ4LpRWuFBl1pqNUxMQJSyuZCt5ARexK5yVHoM7wyPbH1JyFvn6+r0H8X7QWXE
         Zh6Q==
X-Gm-Message-State: AOAM531mXp2+xnugywRe4qZGbfN/Z6UT07AimvPS1ujXTot7FSQroBv+
        MriicW1j34zat0ClD7adkdctywotNPY=
X-Google-Smtp-Source: ABdhPJxTcBMbSWeM4AiTR84W4ntVS4lau8EpT07hyBVHhi57xF4eudmvTaf5P79yOL9QgBUkElm9Sg==
X-Received: by 2002:a2e:8e26:: with SMTP id r6mr1528050ljk.313.1625183035470;
        Thu, 01 Jul 2021 16:43:55 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id e23sm60743lfq.221.2021.07.01.16.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:43:55 -0700 (PDT)
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
Subject: [PATCH v2 07/12] power: supply: smb347-charger: Make smb347_set_writable() IRQ-safe
Date:   Fri,  2 Jul 2021 02:43:12 +0300
Message-Id: <20210701234317.26393-8-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701234317.26393-1-digetx@gmail.com>
References: <20210701234317.26393-1-digetx@gmail.com>
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
2.30.2

