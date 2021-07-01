Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2333B8C34
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 04:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbhGAC1Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 22:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbhGAC1X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 22:27:23 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EB0C0617A8;
        Wed, 30 Jun 2021 19:24:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q4so6118507ljp.13;
        Wed, 30 Jun 2021 19:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFXR8UJAJfYBsWt7j+dPhOe713FxNJqHeaZ6mJiooJo=;
        b=PK62oc2eMNNQ6fbAE/rLJKzZ2fEctzHg/zwUBO/9i6KwADR2bcleLT9ktF9W4q2UaB
         bwJZBnbGvOG5PKx1j5lwHivo8dbjBqaljlzOaON4KQw/WGkREIkHk2kxcOKORCFMmlMW
         rEsPtJHBL5AbQMW7Ywzxtdlx1UgqbD7K8uFNWQLc6aYBxYvnHwuiCcwp3oN2F+jDlJIK
         Cvjhgjy5uQt2sjZF9c5+bXypA6IqxBg6KNnr1pJINDleJrUx1xgqLMzg2b0tmv/PhZ8Q
         AGbhfYK6bOKuMhL+VqgpkOWZaZNVKq38fYZucm2dWNV+VCk/oUmdCRnUmE+KkSNu3IrI
         kYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFXR8UJAJfYBsWt7j+dPhOe713FxNJqHeaZ6mJiooJo=;
        b=Kvu/YkFlLTKHVJaAwqT4a5Lb3zvJfBWPq4CONe0dbkCm28Hmjnmo0fQUrPMzMaPEH1
         zD5CLOasHO9TuDKkKWIbs7dh+L68hOPTJWgfirkXfR+xmDuuB8DwlTxucKWiMikSjLFc
         tX8+nd3Oq/FHLBm+Mq0Lw9VfPwo9NZVzphSyayZKNkP1OnDZ4QYWF7GZBm/EOM7Edvlc
         jOfLFZ3qwcSd5bMBoKShLELsN0SZsCNh9mi3bRXCuTDVq40rwfVAod126M4cRJtFjFGY
         8RagDbJq/r1MyCHpd3lGQFKICcH3TdspG3pkpa3eXhmi6JN59Ff1OCJPvsatSO71H3As
         IV3w==
X-Gm-Message-State: AOAM532HObtiTNdPrWh+qv+uyshxPHPIBkIvAWRHzjGNhWibOvp2gvxS
        4IKGsBIOYLFtUTF9dKjJenU=
X-Google-Smtp-Source: ABdhPJw/Rj4deuEH5QIk2/cuYLMxw+SwxZOEK2ukcEiuy3kFs6NDJMl8Hiicl+LCn1mE0MWIkKkyXw==
X-Received: by 2002:a2e:974f:: with SMTP id f15mr10061298ljj.434.1625106290320;
        Wed, 30 Jun 2021 19:24:50 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id v7sm2407262ljn.14.2021.06.30.19.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 19:24:50 -0700 (PDT)
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
Subject: [PATCH v1 08/12] power: supply: smb347-charger: Remove caching of charger state
Date:   Thu,  1 Jul 2021 05:24:01 +0300
Message-Id: <20210701022405.10817-9-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701022405.10817-1-digetx@gmail.com>
References: <20210701022405.10817-1-digetx@gmail.com>
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
2.30.2

