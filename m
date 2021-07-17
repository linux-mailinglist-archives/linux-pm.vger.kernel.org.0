Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03B43CC2FF
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 14:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhGQMOh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 08:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbhGQMOb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 08:14:31 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106C5C061762;
        Sat, 17 Jul 2021 05:11:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a6so17919965ljq.3;
        Sat, 17 Jul 2021 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8EOJok7gQ/2QjTWWQG3gL5Nl9QBC5D9nB2n0/NrCfQ=;
        b=krFYklNnqTr+ydt5j0gBvY6WSdtsOKSAnDgz5XPRH25oKBkb6laFdA5dpiu3rr/bEn
         L9dQZ1Ik4xiZCvprzuDFyNcsnYA/1ypXity5JdNK74VmTyT4nULcSsEb5LYlONpRrrHb
         dACDN2ZLnscnurDYF7hXmUJf9n2dIxfrl+1gdzXxyj0NqYHBBEyu9rj/prgYKAzcL8Sk
         iVRsEBvebMk/xyyZGfF5Ug260gBrz800zRqrVuBc4yH9EheWewLudRjAjd8tbq51miTw
         LnaYIFFZngNBwxJ0QWJyfNawmIxPezLdHnuKx6scbsd5MaxREa2R+IvKC7hKHcj1og0u
         R+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8EOJok7gQ/2QjTWWQG3gL5Nl9QBC5D9nB2n0/NrCfQ=;
        b=pQDjUxWfBgMTDgwp6kwwyooaDvuKsfbpHTEKe1jmmuDKMICeES++KRMsopgFGUs4ZA
         AuL3VsrHq077gPZh9PoYcpXPnu7HjRQDbG8ThaRCieyR3y/t3FQFBge6DKSMjEdAcLNW
         cvdiHeYICUl+vc6DtwVloTo2Xsa/cdI532YLpO/kWw3mMPWb7pVZtG5Z8RXOMBqtV6ga
         EN3lmLGWQdLGrSsvnnAIF43s33bdkA5gfbRO3jb1rVkf/+fnVUZ0U/1czslUVbr2bXIt
         Uc4+lQ/LzfOX4wdbIaZNyLSrUaTyY2lz6KpavJsLeSYRDERWxNuKMekfdpaEHeNoLrT8
         /Wqg==
X-Gm-Message-State: AOAM531ZTKKJM4JOU++9y7QSMGT+exrflUFwBKnLmegjBUDWY9NbX3qS
        d/wDM/jO0nuIv/ghkEjxWcU=
X-Google-Smtp-Source: ABdhPJxv5JurXs40vsTu/yjO/+QF1gU58GIUbQflwcKDd/6fVyrYkpga5dNk6RGW3Ud1hLK9xWZlAw==
X-Received: by 2002:a2e:9009:: with SMTP id h9mr13502791ljg.213.1626523892478;
        Sat, 17 Jul 2021 05:11:32 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id m16sm852597lfq.23.2021.07.17.05.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 05:11:32 -0700 (PDT)
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
Subject: [PATCH v4 08/12] power: supply: smb347-charger: Remove caching of charger state
Date:   Sat, 17 Jul 2021 15:11:08 +0300
Message-Id: <20210717121112.3248-9-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717121112.3248-1-digetx@gmail.com>
References: <20210717121112.3248-1-digetx@gmail.com>
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

